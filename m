Return-Path: <stable+bounces-169880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB7DB2928C
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 11:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A343B99C6
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 09:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D410221FA0;
	Sun, 17 Aug 2025 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xqqB3ouS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D7E218ACA
	for <stable@vger.kernel.org>; Sun, 17 Aug 2025 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755424736; cv=none; b=giwHpq96uQWh/LY8UAvylK61pX+P5IcFqB6YZr45POb/ZpX1CycLsI9wHhZolr88zEUynJV4W7JMc0S8IHfRAlafYyvSgjCit2OAxdPcSuHozE3ZDSxd7u85VZCbW4POuxGkGshZDrpNPDtjKS8fGT8HbGsRQc0/ttMQUGGg948=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755424736; c=relaxed/simple;
	bh=4E9zM3h0H7GMOgCSr6vsI6tTdcPKF8+UwxTRQM5NRuI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YbPiSayGXlGDDGLydApFS4d/nHQH5XtrnmxZrHTQGeo2YD/o5C7aEyLpjX43ITvqL68EEK/rsD+6CT1sx8tp2ZNWy/1Cl35GL+N65BhXuOEmFas23jUciU6TPlfrU58nSZ2He7d0JFyI9UGh1f6sL/uyYRj52G0DloSh950iiQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xqqB3ouS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77D3C4CEEB;
	Sun, 17 Aug 2025 09:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755424735;
	bh=4E9zM3h0H7GMOgCSr6vsI6tTdcPKF8+UwxTRQM5NRuI=;
	h=Subject:To:Cc:From:Date:From;
	b=xqqB3ouSJm+ZvZ3oKXAvhO0e5GBMKIUO/SM9N7ys07IcjeH8KWKfjYERe0Husux8K
	 mZ8qnldesCiNxX6II9gqRKZrGPXnDcz9StKdJPuWHgowwbVAOHywQ0Do44USOVjKD5
	 pvaayoR42d6UZDuoeQhRrO+KWEDaz1OxLtngB4Uc=
Subject: FAILED: patch "[PATCH] smb: client: let send_done() cleanup before calling" failed to apply to 6.1-stable tree
To: metze@samba.org,longli@microsoft.com,smfrench@gmail.com,stfrench@microsoft.com,tom@talpey.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 17 Aug 2025 11:58:51 +0200
Message-ID: <2025081751-drench-clammy-f8dd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5349ae5e05fa37409fd48a1eb483b199c32c889b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081751-drench-clammy-f8dd@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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
 


