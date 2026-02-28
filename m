Return-Path: <stable+bounces-220951-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIZZLr1co2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220951-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:23:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCB81C8F81
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 960023413FB3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB0744CF37;
	Sat, 28 Feb 2026 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjJausvp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2CD47B43F;
	Sat, 28 Feb 2026 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301297; cv=none; b=i8vfuQoRgAlH9nI9iSKLVVvYlWRv1Xo6u3PeaIvLaZf6dZ+7uL9XCFFGXhpXXSFe/uO+btkIR0f26V65QB17OsX9sTCYXWJOMXG5xZmTNZIK2uBvqgRPqVU6+utc4zDaR8xOD56VD78oZChjd9auEHqnTeHL3HPPOUVXIX1kxS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301297; c=relaxed/simple;
	bh=VUmlSKdJKQXF3sFNo+mJUSJ27aDu1PAe3j7aYFPOhbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJbliNnTv5DqrInXDcvR/NifyMPoyJt18xfWy44vJ9LM2YrX1kZRCYtrv8HLMa0O1elFchIvVB0ZLb+/9T7AjsTIkJDnhW8y27siFzKQDNJhZ6ODItMNF2U1s2p0phqN3rPLBPmUWuwZAcp5yHdgPg8X9FroTCRb90CNTNBF5xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjJausvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F24C19423;
	Sat, 28 Feb 2026 17:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301297;
	bh=VUmlSKdJKQXF3sFNo+mJUSJ27aDu1PAe3j7aYFPOhbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MjJausvpycLvQ57Nz/PuwrMg2Aah2jRTMM6Qmkasu/r7ohEQEPzLKKuH2wo38zr+H
	 r/tC7YLLfx2U/jhs981GHYAr8du3IPoqSJ+pH+kmKfEGKw5KxvDpiIOlKsBkCoDB/k
	 LIhlHuRnKKVKX8DccEvDo2u6Ecr0xmGsB208bLQJ1kJIPj6+lf/gI+CtqEd3/M5uUK
	 ugfcaVnqeDkC9EicTWrn/5x+UuiQWh347uKKaHHfUdn2xRU+xDAY/snTZLjz6wwgJJ
	 1nmcS3To/jUn9KODZgI+mFx5eyEL37y8yCYkqbJhM5vUxd2HjmLY8Ci4mTGWijNGZa
	 /DcbO/EmUNzaA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Irui Wang <irui.wang@mediatek.com>,
	stable@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 482/752] media: mediatek: encoder: Fix uninitialized scalar variable issue
Date: Sat, 28 Feb 2026 12:43:13 -0500
Message-ID: <20260228174750.1542406-482-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220951-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:email,mediatek.com:email]
X-Rspamd-Queue-Id: 0FCB81C8F81
X-Rspamd-Action: no action

From: Irui Wang <irui.wang@mediatek.com>

[ Upstream commit 88e935de7cf8795d7a6a51385db87ecb361a7050 ]

UNINIT checker finds some instances of variables that are used
without being initialized, for example using the uninitialized
value enc_result.is_key_frm can result in unpredictable behavior,
so initialize these variables after declaring.

Fixes: 4e855a6efa54 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video Encoder Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Irui Wang <irui.wang@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c
index d815e962ab898..0212ff0462fcc 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c
@@ -864,7 +864,7 @@ static void vb2ops_venc_buf_queue(struct vb2_buffer *vb)
 static int vb2ops_venc_start_streaming(struct vb2_queue *q, unsigned int count)
 {
 	struct mtk_vcodec_enc_ctx *ctx = vb2_get_drv_priv(q);
-	struct venc_enc_param param;
+	struct venc_enc_param param = { };
 	int ret;
 	int i;
 
@@ -1018,7 +1018,7 @@ static int mtk_venc_encode_header(void *priv)
 	int ret;
 	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 	struct mtk_vcodec_mem bs_buf;
-	struct venc_done_result enc_result;
+	struct venc_done_result enc_result = { };
 
 	dst_buf = v4l2_m2m_dst_buf_remove(ctx->m2m_ctx);
 	if (!dst_buf) {
@@ -1139,7 +1139,7 @@ static void mtk_venc_worker(struct work_struct *work)
 	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 	struct venc_frm_buf frm_buf;
 	struct mtk_vcodec_mem bs_buf;
-	struct venc_done_result enc_result;
+	struct venc_done_result enc_result = { };
 	int ret, i;
 
 	/* check dst_buf, dst_buf may be removed in device_run
-- 
2.51.0


