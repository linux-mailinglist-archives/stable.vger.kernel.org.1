Return-Path: <stable+bounces-52376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D29E990ADB9
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 14:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD991C22F21
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 12:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69F2194C85;
	Mon, 17 Jun 2024 12:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wloxTeEb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78603192B87
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 12:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718626420; cv=none; b=bnlj7UtX/XG/r+MyXj1azf62rmIw+jdLRJCVRCMgBw1e/Lva2VG87HLXns4uvaehLfFImKbAgG48xAlPWAN6XbJlb5wjk0HK2N/fqhl/MMY7S0QsShyVcdwUUwEce72MC6cQt2iE1D/65y1lMNiSBNpZjV0VAX6sE9f2F2mNHAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718626420; c=relaxed/simple;
	bh=MGWDuZ1kj8hnoz2LkuqWaaUA3IFDTXVvH45w618j47k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XUEApYx9E59Z6RP0Hn+IUPdhw/a0TqNGwqNHnD4f4vT33SjB2HdvNUSoGHpz0QBZZdJMV19I9Wl344AsVVQfp6rBEIfvRpbIgBXLGybk6s9bkKvtFpsuKOrs7KaUvFKTwxte5lHy62KXyGxoLX8PWjTBxB58SUGjO2S0kiQ4udA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wloxTeEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F46C2BD10;
	Mon, 17 Jun 2024 12:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718626420;
	bh=MGWDuZ1kj8hnoz2LkuqWaaUA3IFDTXVvH45w618j47k=;
	h=Subject:To:Cc:From:Date:From;
	b=wloxTeEbDKUwh7YEERlzBJvcq1NmuCebkruwsrSU1e63PMd+26sTDkgSf0oc1p5s4
	 eN7DpJ+PZqBE1utcyNBb2MUhJFgOZx31PQ8DgsUHEZHZaFmb1Db63E0ltBRHP5oFip
	 5WCB2XVQS5roROepCtcgCqE0HCvcpeo8avToJKuU=
Subject: FAILED: patch "[PATCH] xhci: Set correct transferred length for cancelled bulk" failed to apply to 4.19-stable tree
To: mathias.nyman@linux.intel.com,gregkh@linuxfoundation.org,pierretom+12@ik.me,stern@rowland.harvard.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Jun 2024 14:13:36 +0200
Message-ID: <2024061736-pretender-account-356c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x f0260589b439e2637ad54a2b25f00a516ef28a57
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061736-pretender-account-356c@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

f0260589b439 ("xhci: Set correct transferred length for cancelled bulk transfers")
f8f80be501aa ("xhci: Use soft retry to recover faster from transaction errors")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f0260589b439e2637ad54a2b25f00a516ef28a57 Mon Sep 17 00:00:00 2001
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Date: Tue, 11 Jun 2024 15:06:07 +0300
Subject: [PATCH] xhci: Set correct transferred length for cancelled bulk
 transfers

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

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 9e90d2952760..1db61bb2b9b5 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2524,9 +2524,8 @@ static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
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


