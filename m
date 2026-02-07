Return-Path: <stable+bounces-214830-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIvdCYKYh2mraQQAu9opvQ
	(envelope-from <stable+bounces-214830-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 20:54:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94821106FF2
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 20:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 488AC3011045
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 19:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDDC3385A8;
	Sat,  7 Feb 2026 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndZRflm5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AD42DA771
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770494079; cv=none; b=TYo4pKe7mLcqDDI1ehOFBOhZj8nIfF4zPu+uKsh/hd/eQXU9mdV/bmKQgUMlJynkwU7f5EdDjvHbxe+niOrNBinyvDvJFxmZ3QvIu/r9jxagTjyfpCZebNExdeNarOlArInCIkLJeH6z9MMSpvFs1Oj/6gU/Jb2GJj0DpjgNBkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770494079; c=relaxed/simple;
	bh=j/Vt978w6tPmfBndfCr0HF5AoQR2Oxj3wWIgbxNwTWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlguRlV1W2OcrOgLv/mzxFO8BTPNdoJfuj6Ag5aSZvU/Ol+iWwbUrNdSQrcmlV2T/krTRVQGcbI4mqXh9SAY7+a+zKvrEtT2nnmA0z8cyOMl1QloZW09vbeC/TERe641CocnY0j+6Mecym1zY+tBjxxxi+63MFCJRBK17uIp/zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndZRflm5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7459CC16AAE;
	Sat,  7 Feb 2026 19:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770494079;
	bh=j/Vt978w6tPmfBndfCr0HF5AoQR2Oxj3wWIgbxNwTWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ndZRflm5oZBdyc9mj61cPHnUWiu0u0PtwnIF8Kp70+y1QnqMOd/9PTDfDNt+0AccA
	 YJBDunFtZKxBWE7DzmrKVJPqJenJb9lMtbad7+GqrGMpiD+/cKBskoUpjkv93wn2B0
	 /I+44uIu/moAYZywMX5Hn8P6HUxRBK1Fxscsl8NizAmefo+KeLu3tPrf9N0+PqH6S5
	 n3MBjzyrf2M0O1rAsECQVcLOtz92XqHVYcf2PCHUDdUhNkb+VySiJIzH1dTBK114IN
	 EcMEBHcAldBlg4bZEenutLpLwOMo8Bs/k89lZi2te3AmpxbUAd741xRvX7iywcDJYP
	 pFpxcHsvcMpUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: YunJe Shin <yjshin0438@gmail.com>,
	YunJe Shin <ioerts@kookmin.ac.kr>,
	Sagi Grimberg <sagi@grimberg.me>,
	Joonkyo Jung <joonkyoj@yonsei.ac.kr>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/5] nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec
Date: Sat,  7 Feb 2026 14:54:23 -0500
Message-ID: <20260207195423.535763-5-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260207195423.535763-1-sashal@kernel.org>
References: <2026020740-kiln-galvanize-65e4@gregkh>
 <20260207195423.535763-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kookmin.ac.kr,grimberg.me,yonsei.ac.kr,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214830-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[grimberg.me:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,yonsei.ac.kr:email]
X-Rspamd-Queue-Id: 94821106FF2
X-Rspamd-Action: no action

From: YunJe Shin <yjshin0438@gmail.com>

[ Upstream commit 52a0a98549344ca20ad81a4176d68d28e3c05a5c ]

nvmet_tcp_build_pdu_iovec() could walk past cmd->req.sg when a PDU
length or offset exceeds sg_cnt and then use bogus sg->length/offset
values, leading to _copy_to_iter() GPF/KASAN. Guard sg_idx, remaining
entries, and sg->length/offset before building the bvec.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Signed-off-by: YunJe Shin <ioerts@kookmin.ac.kr>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Joonkyo Jung <joonkyoj@yonsei.ac.kr>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index d0fcce6aec93f..9e6943ffe4abe 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -306,11 +306,14 @@ static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd)
 	cmd->req.sg = NULL;
 }
 
+static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue);
+
 static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 {
 	struct bio_vec *iov = cmd->iov;
 	struct scatterlist *sg;
 	u32 length, offset, sg_offset;
+	unsigned int sg_remaining;
 	int nr_pages;
 
 	length = cmd->pdu_len;
@@ -318,10 +321,25 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 	offset = cmd->rbytes_done;
 	cmd->sg_idx = offset / PAGE_SIZE;
 	sg_offset = offset % PAGE_SIZE;
+	if (!cmd->req.sg_cnt || cmd->sg_idx >= cmd->req.sg_cnt) {
+		nvmet_tcp_fatal_error(cmd->queue);
+		return;
+	}
 	sg = &cmd->req.sg[cmd->sg_idx];
+	sg_remaining = cmd->req.sg_cnt - cmd->sg_idx;
 
 	while (length) {
-		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
+		u32 iov_len;
+
+		if (!sg_remaining) {
+			nvmet_tcp_fatal_error(cmd->queue);
+			return;
+		}
+		if (!sg->length || sg->length <= sg_offset) {
+			nvmet_tcp_fatal_error(cmd->queue);
+			return;
+		}
+		iov_len = min_t(u32, length, sg->length - sg_offset);
 
 		iov->bv_page = sg_page(sg);
 		iov->bv_len = sg->length;
@@ -329,6 +347,7 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 
 		length -= iov_len;
 		sg = sg_next(sg);
+		sg_remaining--;
 		iov++;
 		sg_offset = 0;
 	}
-- 
2.51.0


