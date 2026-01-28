Return-Path: <stable+bounces-212679-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMgcO1SBemnx7AEAu9opvQ
	(envelope-from <stable+bounces-212679-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 22:36:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 535B4A924D
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 22:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B0EB302C916
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 21:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870AC32FA37;
	Wed, 28 Jan 2026 21:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dy+FTfP4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE6332D0C2
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 21:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769636177; cv=none; b=aGqvh/ec/fVBEcefw81Kd0vYVfdLMretZlerwqFzXUxZxsT+PxLdbhBqkkmIma65PAA6RHzcIHAvbRw4Bwp3nqGTkYwdFR2Y2GplKqa/5axQSSgQ1zMZEzxJm2dCdbeREo6OADLqGeFJKzgWY2fDIae4IREvIXQmBZP4ilvE6Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769636177; c=relaxed/simple;
	bh=G2nQbwBYdPkwqlDO0zbjT8kHXIsntzXatt3xDRUOKNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1iRHXyqLNOtWQIQb463CS0ydub14500qDaTtUlNrh/pqk0MlbcPWNhgNqBENGq/J9DMXO7uxF+w5pmV8DVHuO6G4Hhbfv7wRUwmXPEJs2iLbri3Gnq9SR2oQ6ehRT3IUl1GJxM8Xv8EQ35w/O2QLllwnGIY11wwsAi9eo2HUGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dy+FTfP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECB7C4CEF1;
	Wed, 28 Jan 2026 21:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769636176;
	bh=G2nQbwBYdPkwqlDO0zbjT8kHXIsntzXatt3xDRUOKNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dy+FTfP4mMxtdUcVQTLYyWPxpBetkKX8cigaOR4yJvDEADddXaCmAs5bMphfjEG6s
	 GhXj5VYMmQm3o6XVwZePkBlqLEFWE+/fN4oUduBke/DmTZfht48n0fhZ/NjbeHxFi7
	 PBFWBm7XFccmHsBpYU8JqhijBKH5/cs79uNXqsPK6H0S3BkDHYu3FrFitA+NBtdF6S
	 kK0BfFnI52+vpe4tBZu2/96ISgycIrCddSbxJMKcYMReA+O/e91H+y9X8pAFaY/E/V
	 K7NEMPhROdPiUVvWPPuCZZglv0/z+bh3JefWoviCeByMGPtZK1YOAdFbXzodnl9zN3
	 3J83J4oXlZNLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ksmbd: smbd: fix dma_unmap_sg() nents
Date: Wed, 28 Jan 2026 16:36:14 -0500
Message-ID: <20260128213614.2762269-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012756-unpack-hatchet-f3fe@gregkh>
References: <2026012756-unpack-hatchet-f3fe@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,microsoft.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-212679-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 535B4A924D
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
 fs/smb/server/transport_rdma.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 91e85a1a154fd..4bab3f89d2c87 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -1108,14 +1108,12 @@ static int get_sg_list(void *buf, int size, struct scatterlist *sg_list, int nen
 
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
@@ -1184,12 +1182,13 @@ static int smb_direct_post_send_data(struct smb_direct_transport *t,
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
@@ -1197,7 +1196,7 @@ static int smb_direct_post_send_data(struct smb_direct_transport *t,
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


