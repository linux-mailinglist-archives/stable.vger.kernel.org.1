Return-Path: <stable+bounces-57297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B9A925C56
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04ED7292581
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0A418FC90;
	Wed,  3 Jul 2024 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lklr9WbS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EDA176226;
	Wed,  3 Jul 2024 11:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004456; cv=none; b=L9/iyjvf/bJJ25kMQy+Yl8VcdypuZYcdMsbSNvw5haSZNtjl7mNyybvz5TIYhyyir3N2Eul7/qhaFV4zPQRNgGscBJJl0dFK4HaUn8eX3lGYf5LOLFADcJbDAfvH2lzLfh0BduGU7y0uvxGjyBq2em1m9IqKJLJVDZjbY0CBI6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004456; c=relaxed/simple;
	bh=8II0VpQWFoSixNDi1HAJvwJv6swNZrRsDEirl2rzIW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnllGls+HX83KFQUQcls8W8XIYc/tBsYro8wgf64RQL0OJhjVCAhVX/k3RZU3HFY29I+KTZb0xptrFUtPyuvH7Sqwkl/8fxjzkprUv680inJSzKfTEb325YV2T2Psl4QzKGW7UFNEwJrWHySPPFpviHH8zvtoukSR01ZBBjRHu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lklr9WbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A06DC2BD10;
	Wed,  3 Jul 2024 11:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720004455;
	bh=8II0VpQWFoSixNDi1HAJvwJv6swNZrRsDEirl2rzIW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lklr9WbSwikz6UFdQ0nFvFXLHtmFI1QaBDjhqNLSAiY979DN7tJcMS7XZADRSIEs4
	 sOdiCELF5sivryjvwfTFZ1TJjb0hllrqhJXRGfioWPri9eL/IQVBf7y4Fpuf8WApzb
	 3pRwsGknh0Yjm+Re0GRIy/uTIx+psRLZ3PU3Kdgc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pierre Tomon <pierretom+12@ik.me>,
	Alan Stern <stern@rowland.harvard.edu>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 5.10 047/290] xhci: Set correct transferred length for cancelled bulk transfers
Date: Wed,  3 Jul 2024 12:37:08 +0200
Message-ID: <20240703102905.979057630@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102904.170852981@linuxfoundation.org>
References: <20240703102904.170852981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit f0260589b439e2637ad54a2b25f00a516ef28a57 upstream.

The transferred length is set incorrectly for cancelled bulk
transfer TDs in case the bulk transfer ring stops on the last transfer
block with a 'Stop - Length Invalid' completion code.

length essentially ends up being set to the requested length:
urb->actual_length = urb->transfer_buffer_length

Length for 'Stop - Length Invalid' cases should be the sum of all
TRB transfer block lengths up to the one the ring stopped on,
_excluding_ the one stopped on.

Fix this by always summing up TRB lengths for 'Stop - Length Invalid'
bulk cases.

This issue was discovered by Alan Stern while debugging
https://bugzilla.kernel.org/show_bug.cgi?id=218890, but does not
solve that bug. Issue is older than 4.10 kernel but fix won't apply
to those due to major reworks in that area.

Tested-by: Pierre Tomon <pierretom+12@ik.me>
Cc: stable@vger.kernel.org # v4.10+
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20240611120610.3264502-2-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-ring.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2386,9 +2386,8 @@ static int process_bulk_intr_td(struct x
 		goto finish_td;
 	case COMP_STOPPED_LENGTH_INVALID:
 		/* stopped on ep trb with invalid length, exclude it */
-		ep_trb_len	= 0;
-		remaining	= 0;
-		break;
+		td->urb->actual_length = sum_trb_lengths(xhci, ep_ring, ep_trb);
+		goto finish_td;
 	case COMP_USB_TRANSACTION_ERROR:
 		if (xhci->quirks & XHCI_NO_SOFT_RETRY ||
 		    (ep->err_count++ > MAX_SOFT_RETRY) ||



