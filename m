Return-Path: <stable+bounces-212683-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CANcIPGLemkE7gEAu9opvQ
	(envelope-from <stable+bounces-212683-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 23:21:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCC2A9874
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 23:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B578302C6C6
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 22:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C201E342C92;
	Wed, 28 Jan 2026 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoNzHfMn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8631334253C
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769638826; cv=none; b=bPZ79nV1Hco/5+Sh5cxboL58eOYrB66iuusihSaDsy3FHp0N+vSLz0OyxzUMW+qDwiHXUbbvMt37APeKvwl6+VSNWKdWeRlsRzwIO/7TeCgQKgu4tekpFIZ8T6y91L2PfR6dQj+NXBARQy2g5ot2eLE0Xerw/VqTK81kzoHphv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769638826; c=relaxed/simple;
	bh=SmdLVH7z8CM5ynk21rZrSTuGb7x5qqZx8Un66avhDNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4RkBzP00QGS9RS25D49VEPB4oc+92f/2dTxkh1+D7HaJfOX9eHCItTHU+VHmUV0xy/QmjG9RrJWXAWlZPTuDX2KopAcjf5k83oLGpZ70+qkKZf63Lfu6WTLkK5z+PugeF5c10IYwFARd9FUuAKCgNVuYysT7qP6g5rikwogUIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoNzHfMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2BFC4CEF1;
	Wed, 28 Jan 2026 22:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769638826;
	bh=SmdLVH7z8CM5ynk21rZrSTuGb7x5qqZx8Un66avhDNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PoNzHfMns+NNs8jA9STDKfliH+jF04vReE1Mgk+D7cDTdJhLNCZaFmpNBG6UOJuZO
	 XCVBdMZN9JyaLzD062P7z/s6MfQeHWoAyfsgnbT4JQ100gH0QTShiQYZd/ENMZ5fO8
	 b8DU/sQbXnH+0yHgQPcO534FAE4FcAkD2L2inSqD/XgDd+geCU5CrmFyxH+spWbuVJ
	 HDMz3hPNeKhV8m95EyBqp+Fz4XhvOo0p/0/sErf9lE8a+KzFEWeIIFEpQ2dMNooA//
	 C795bncKq3F3LLFokj6Cmmh9cy8Y9qXCUZdFjVJDhadb/TvIA+vKU1BLah8wFEvxpC
	 mOB5Pyxw9KwOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ksmbd: smbd: fix dma_unmap_sg() nents
Date: Wed, 28 Jan 2026 17:20:21 -0500
Message-ID: <20260128222021.2800060-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012757-crazed-cupbearer-fa32@gregkh>
References: <2026012757-crazed-cupbearer-fa32@gregkh>
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
	TAGGED_FROM(0.00)[bounces-212683-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 2CCC2A9874
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
index 81da8a5c1e0db..1290c0fa7dd18 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -1103,14 +1103,12 @@ static int get_sg_list(void *buf, int size, struct scatterlist *sg_list, int nen
 
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
@@ -1179,12 +1177,13 @@ static int smb_direct_post_send_data(struct smb_direct_transport *t,
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
@@ -1192,7 +1191,7 @@ static int smb_direct_post_send_data(struct smb_direct_transport *t,
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


