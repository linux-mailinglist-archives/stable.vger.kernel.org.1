Return-Path: <stable+bounces-169882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A0AB2928E
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 11:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8307A1B209E4
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 09:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC65221DBA;
	Sun, 17 Aug 2025 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BfnZYVFU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBC13176FB
	for <stable@vger.kernel.org>; Sun, 17 Aug 2025 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755424743; cv=none; b=Y5K12kaQZ6N54SDNkiOb+wPSO9buY+Cil3h2z+RADZY24nf4NOu/QqpWNVqu76xQqNJiFqav16Vp05P37Aih3OXpMkloALSec/xbcsmjBgSEoAlIe/hr2hjwacAuA+QbUJEVkPI6WMmLtgKLNrbXUpiWHi+MRW7y/CIDKlV+FRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755424743; c=relaxed/simple;
	bh=sdrZzH4SUhGb5S7hZMhXMIV45uDv9aoo+XX0QZoPaPk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=C2CF/C672F+pqg7HQ9bD6EhZnAxAg9jABv7dbWxA8qk1yJEh+NQtvxueGqGWnDfQuN7TyJBBvabXl9RekzBGXoqa0Y070Z/HB2rdMA7wS4/PhGqVZ6JSbOC5BhHnQ8qrYP+T1DEk8DFAKRpwaqrg44h5r+BeZaUaX2GbALq4yXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BfnZYVFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA93EC4CEEB;
	Sun, 17 Aug 2025 09:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755424743;
	bh=sdrZzH4SUhGb5S7hZMhXMIV45uDv9aoo+XX0QZoPaPk=;
	h=Subject:To:Cc:From:Date:From;
	b=BfnZYVFUFGSRT5aXYBBdAb2Dm+8WW3bdCn+gyJ/+GnRUdQCiwaR0yj41ZxTKxENYq
	 4x8vAmXLLW/MRRp2bJLRdUIIjRD2yKkj90tiPR/ibSm4c62y0pDvJ6UMeWOrP8kyqC
	 o5wRBXOv5IsnuIt0WKlOdllKsOtAgkq6K7TbwuIo=
Subject: FAILED: patch "[PATCH] smb: client: let send_done() cleanup before calling" failed to apply to 5.4-stable tree
To: metze@samba.org,longli@microsoft.com,smfrench@gmail.com,stfrench@microsoft.com,tom@talpey.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 17 Aug 2025 11:58:55 +0200
Message-ID: <2025081755-subdivide-astound-6aef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 5349ae5e05fa37409fd48a1eb483b199c32c889b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081755-subdivide-astound-6aef@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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
 


