Return-Path: <stable+bounces-169883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDEDB2928F
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 11:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D40207BB2
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 09:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0959C221DBA;
	Sun, 17 Aug 2025 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RqJyb1Xi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD247218ACA
	for <stable@vger.kernel.org>; Sun, 17 Aug 2025 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755424750; cv=none; b=ILUASC+k2ky1B81gFdmPCInCW5cbcmHFx3MvFYiw5iEtYeTON1UYLR4AeZPOnx0ngL8s/Jg/8WCrcWBtiLz9Ci398Xl41hqgSr76yAWsvUccQwApJCIaxp2QRfTg3J/+A03c1P2+/wbUbRUpS7A7rBW16IDv7pC2wTJo+5TDMtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755424750; c=relaxed/simple;
	bh=+H6AH/jBx1aql8TlxV63WqeLnOU3+r3oxFe6hU9liTs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AahXExzpV+6TJklHrrtJ0m4MaR8GavsKt33vnRFBKnZ0ihUM84/mMqqTWRcrVbLbUdZ3QIoDLGUj0Gt1FkW4bCh5rT/H5TTzrE2qE4r2AcqIe7y3HynYXwlIOR9kO8hKmjLLqWjNpiWYcPbR+DEknHTcdZuJg0dYiZjIvLr5hXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RqJyb1Xi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7A0C4CEEB;
	Sun, 17 Aug 2025 09:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755424749;
	bh=+H6AH/jBx1aql8TlxV63WqeLnOU3+r3oxFe6hU9liTs=;
	h=Subject:To:Cc:From:Date:From;
	b=RqJyb1XiRqVoiuAEj5C+mBKe9T4mIe/arV6LRSiolLFukMewldhowZ7A/aCMxkW6+
	 an9o+5qXZYPEB2GYcInrKsO422s16s/EM6Vw4DSwAaDPOZCIxqlZkvnJgLLCdH8SIA
	 +gYFWZfN5pnR/ohk7nyR4zl1F/fbLz2M/d2SE9eg=
Subject: FAILED: patch "[PATCH] smb: client: let send_done() cleanup before calling" failed to apply to 5.10-stable tree
To: metze@samba.org,longli@microsoft.com,smfrench@gmail.com,stfrench@microsoft.com,tom@talpey.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 17 Aug 2025 11:58:58 +0200
Message-ID: <2025081757-moonwalk-backpedal-fe00@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5349ae5e05fa37409fd48a1eb483b199c32c889b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081757-moonwalk-backpedal-fe00@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5349ae5e05fa37409fd48a1eb483b199c32c889b Mon Sep 17 00:00:00 2001
From: Stefan Metzmacher <metze@samba.org>
Date: Mon, 4 Aug 2025 14:10:12 +0200
Subject: [PATCH] smb: client: let send_done() cleanup before calling
 smbd_disconnect_rdma_connection()

We should call ib_dma_unmap_single() and mempool_free() before calling
smbd_disconnect_rdma_connection().

And smbd_disconnect_rdma_connection() needs to be the last function to
call as all other state might already be gone after it returns.

Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Fixes: f198186aa9bb ("CIFS: SMBD: Establish SMB Direct connection")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index 754e94a0e07f..e99e783f1b0e 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -281,18 +281,20 @@ static void send_done(struct ib_cq *cq, struct ib_wc *wc)
 	log_rdma_send(INFO, "smbd_request 0x%p completed wc->status=%d\n",
 		request, wc->status);
 
-	if (wc->status != IB_WC_SUCCESS || wc->opcode != IB_WC_SEND) {
-		log_rdma_send(ERR, "wc->status=%d wc->opcode=%d\n",
-			wc->status, wc->opcode);
-		smbd_disconnect_rdma_connection(request->info);
-	}
-
 	for (i = 0; i < request->num_sge; i++)
 		ib_dma_unmap_single(sc->ib.dev,
 			request->sge[i].addr,
 			request->sge[i].length,
 			DMA_TO_DEVICE);
 
+	if (wc->status != IB_WC_SUCCESS || wc->opcode != IB_WC_SEND) {
+		log_rdma_send(ERR, "wc->status=%d wc->opcode=%d\n",
+			wc->status, wc->opcode);
+		mempool_free(request, info->request_mempool);
+		smbd_disconnect_rdma_connection(info);
+		return;
+	}
+
 	if (atomic_dec_and_test(&request->info->send_pending))
 		wake_up(&request->info->wait_send_pending);
 


