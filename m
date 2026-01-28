Return-Path: <stable+bounces-212705-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOtvJgeRemmz7wEAu9opvQ
	(envelope-from <stable+bounces-212705-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 23:43:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E972DA9B56
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 23:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 906DD301CF8A
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 22:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9A634253C;
	Wed, 28 Jan 2026 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4Zohv1s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45EF313520
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 22:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769640024; cv=none; b=H0VoHPT1cW2j7GLhgPm1DBLns+nSc1WEhsn11aTEOc/SlpEMVfTHM4+bm6xBcWVU//6F+mzmXP21//1R8azzLHgjTS2tmNGGCZUTx6TiQc4ip/gLkLjgOr58VmEGEYG+vl7r3Vzs2/VttDS4CnXxti0dlMCr1/hQ/NrvBdGKwQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769640024; c=relaxed/simple;
	bh=+8mSpQTgO+bsDyq5YYgfUWxUlbF9bdp+flCuUhtwYZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btYw8GKohLhXS0M6SoFncqO1Idn0D/4Z+JAzk9acXoRxyDPZupWOtUt9wZRRhMp3kvCJ0pbFlULluljweerHxnK9VQFF5SQHq4tLM0rWphisAf5rtikpHbrsI7dd86+8jnWxneLay3Vl1u5p0h3kv8lqPiXBKiX2gu6nIQSM+M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4Zohv1s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6094C4CEF1;
	Wed, 28 Jan 2026 22:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769640024;
	bh=+8mSpQTgO+bsDyq5YYgfUWxUlbF9bdp+flCuUhtwYZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y4Zohv1s2FgLXaifNaLuQgvZlYDf080jHSh0TBc2JCA6XzIARvKxqyIrgyk1o69aP
	 E0rbHeTEjK1ZL0vZo/JIUPvBsdgvMGt7aq+53+qQrZk1ShE2PBJ93fdf80D9W1MifZ
	 H5wAC8E5khXy6bRtXq7Lq4FCqvwn/bIuPUkbtZKWkw2xbF63dtmqblBNvH7VTBlM/W
	 gXU5cgwezRIJx4a+pRlGb9rVkmDdTouaNVpfCFPPHa/P84Mg8e25O04sgF4IDP+dRP
	 MbfNY2BOOECjjEwisk2Xn8QONIxbEeTy++071jPni2QSzCaHt4GkbwGrXIGKxMIewR
	 Rz7QDM3zj14tQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: smbd: fix dma_unmap_sg() nents
Date: Wed, 28 Jan 2026 17:40:22 -0500
Message-ID: <20260128224022.2810098-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012757-wrench-plated-2f22@gregkh>
References: <2026012757-wrench-plated-2f22@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212705-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,microsoft.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E972DA9B56
X-Rspamd-Action: no action

From: Thomas Fourier <fourier.thomas@gmail.com>

[ Upstream commit 98e3e2b561bc88f4dd218d1c05890672874692f6 ]

The dma_unmap_sg() functions should be called with the same nents as the
dma_map_sg(), not the value the map function returned.

Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ Context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/transport_rdma.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index 4b79df7c8caf3..6ea73fe6de6c5 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -1086,14 +1086,12 @@ static int get_sg_list(void *buf, int size, struct scatterlist *sg_list, int nen
 
 static int get_mapped_sg_list(struct ib_device *device, void *buf, int size,
 			      struct scatterlist *sg_list, int nentries,
-			      enum dma_data_direction dir)
+			      enum dma_data_direction dir, int *npages)
 {
-	int npages;
-
-	npages = get_sg_list(buf, size, sg_list, nentries);
-	if (npages < 0)
+	*npages = get_sg_list(buf, size, sg_list, nentries);
+	if (*npages < 0)
 		return -EINVAL;
-	return ib_dma_map_sg(device, sg_list, npages, dir);
+	return ib_dma_map_sg(device, sg_list, *npages, dir);
 }
 
 static int post_sendmsg(struct smb_direct_transport *t,
@@ -1162,12 +1160,13 @@ static int smb_direct_post_send_data(struct smb_direct_transport *t,
 	for (i = 0; i < niov; i++) {
 		struct ib_sge *sge;
 		int sg_cnt;
+		int npages;
 
 		sg_init_table(sg, SMB_DIRECT_MAX_SEND_SGES - 1);
 		sg_cnt = get_mapped_sg_list(t->cm_id->device,
 					    iov[i].iov_base, iov[i].iov_len,
 					    sg, SMB_DIRECT_MAX_SEND_SGES - 1,
-					    DMA_TO_DEVICE);
+					    DMA_TO_DEVICE, &npages);
 		if (sg_cnt <= 0) {
 			pr_err("failed to map buffer\n");
 			ret = -ENOMEM;
@@ -1175,7 +1174,7 @@ static int smb_direct_post_send_data(struct smb_direct_transport *t,
 		} else if (sg_cnt + msg->num_sge > SMB_DIRECT_MAX_SEND_SGES) {
 			pr_err("buffer not fitted into sges\n");
 			ret = -E2BIG;
-			ib_dma_unmap_sg(t->cm_id->device, sg, sg_cnt,
+			ib_dma_unmap_sg(t->cm_id->device, sg, npages,
 					DMA_TO_DEVICE);
 			goto err;
 		}
-- 
2.51.0


