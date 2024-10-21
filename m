Return-Path: <stable+bounces-87187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E5D9A63A9
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9B01F22DE2
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2C91E5722;
	Mon, 21 Oct 2024 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="szAlwd0g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022561E3DF9;
	Mon, 21 Oct 2024 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506855; cv=none; b=oE6sghSex/Al2BGaSX89KAvDnPl2qQuBB9onkRR4gJCjaPNV3OviqicWS8ATlzwSj5tfRTMFkTfXiLG/lbSO/+1+4yhpcm/d0aPpMsO9bIUNqJHzhaU7PujkbAo6aFeCe2ArYwIwkFS1KA7xBED/4trGpNBAE6Sn9zaYzrP3f/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506855; c=relaxed/simple;
	bh=43qBq+ZPWW+GvVgwpNbIR4xvhZpeHy1lNtsjrySdtxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSGRIDpRv+MECYmQhZyQomPqefmaKWBm9yQuuD9E8TvWcibnqRT++0tWbo3sj+QFnXF8gVHycnUK+8qti1HO7yMV9zmiFVFIClIFstDOd6hskgV5tTrEU4A9/0E31yzTxZSHE6/xjgUeEe6aabxqn0pOqYD2pmdPncLgQ2SQfcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=szAlwd0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725EEC4CEC3;
	Mon, 21 Oct 2024 10:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729506854;
	bh=43qBq+ZPWW+GvVgwpNbIR4xvhZpeHy1lNtsjrySdtxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=szAlwd0g8n06iroLRVfsSta264NT/gcc3dQC5S0LifutqlCWmMUFkOZJrPcPWSXkE
	 MFquoJZEq+1dmXLCm+VAe0jbw5jb57Uk2jvTlYHc0p4ghdZk7fZClsFaeUuOssLGbF
	 FSL6UPIfg+54n4wohrBDykxwN6NrUzZ46aK/Bo/Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 6.11 102/135] xhci: Mitigate failed set dequeue pointer commands
Date: Mon, 21 Oct 2024 12:24:18 +0200
Message-ID: <20241021102303.316815508@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021102259.324175287@linuxfoundation.org>
References: <20241021102259.324175287@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit fe49df60cdb7c2975aa743dc295f8786e4b7db10 upstream.

Avoid xHC host from processing a cancelled URB by always turning
cancelled URB TDs into no-op TRBs before queuing a 'Set TR Deq' command.

If the command fails then xHC will start processing the cancelled TD
instead of skipping it once endpoint is restarted, causing issues like
Babble error.

This is not a complete solution as a failed 'Set TR Deq' command does not
guarantee xHC TRB caches are cleared.

Fixes: 4db356924a50 ("xhci: turn cancelled td cleanup to its own function")
Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20241016140000.783905-3-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-ring.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1023,7 +1023,7 @@ static int xhci_invalidate_cancelled_tds
 					td_to_noop(xhci, ring, cached_td, false);
 					cached_td->cancel_status = TD_CLEARED;
 				}
-
+				td_to_noop(xhci, ring, td, false);
 				td->cancel_status = TD_CLEARING_CACHE;
 				cached_td = td;
 				break;



