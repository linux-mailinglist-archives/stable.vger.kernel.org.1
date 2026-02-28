Return-Path: <stable+bounces-220233-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE4XLBIuo2me+AQAu9opvQ
	(envelope-from <stable+bounces-220233-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:04:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E721C560E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8935731BEA0A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF057301F0D;
	Sat, 28 Feb 2026 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJe8cTrp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F01301F04;
	Sat, 28 Feb 2026 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300137; cv=none; b=MYy7G/Kql/BYuUvimK9Le1TTW2yyM6ic/s/mccnFGleBVgb19VLkoUK3DG1QklVKZMJm+9Tqh+YzB0QPh7TYPYT5msvHgH6yy67OHgGlSllI5O100J87J6CmBD3tYvaWrzIDQlTG1Y1T+ZC0qHdnHtst/patnZbx92GJjNvi0rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300137; c=relaxed/simple;
	bh=hXFZmuqxr72Et5WWnpswSxvsRGJlQHJGxp3QLH3btng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/fSsvYJ9XXco+5RNQPMWUs4aPAvub8n6nTYt5cTn78vto6zM2oSlXNR8VcWaaZ6n2ctMHvjobpJ36XJWtw0fWX+oWAVOOEhsaKV1Yd5ht7P4M9X+eC2UHsDfLmnOAVtQTohjgUUTUpJIsucQNEsX+EWhAHenu2mpQYgbDsYaNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJe8cTrp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CAEC19424;
	Sat, 28 Feb 2026 17:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300137;
	bh=hXFZmuqxr72Et5WWnpswSxvsRGJlQHJGxp3QLH3btng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZJe8cTrpIMkZWWmpJriYT4v6UHOT5I3rbQdmmomfJw9CB7gwt2Id62JGkc8LMeuY9
	 lqAO+5ehnau60S88vSXRLJ3G6YgE2L0Qg/XCLelqQGahwx1/gmnBmqvmXnUuZ1BcSc
	 MeK65BojeuOFCQegaMeI6fCNF/6cG6b+u5PU3pCUwkQQ96dVh/nQ6iIhe8LAevoBow
	 fTDAU12rg363A2rLvMEPfmdvyXOltTWaqt8+9uzbWKI/AlAtHulZAABnFLCyUFehdW
	 LiSFYiCTvQE7wfV6oAArjip0tM3ag4pFonxjGxhTFzRUo5wS85e+j7OEz7RQlhFrsN
	 ok0ve/rlXhKgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brandon Brnich <b-brnich@ti.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 155/844] media: chips-media: wave5: Fix conditional in start_streaming
Date: Sat, 28 Feb 2026 12:21:08 -0500
Message-ID: <20260228173244.1509663-156-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-220233-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:email,ti.com:email]
X-Rspamd-Queue-Id: 30E721C560E
X-Rspamd-Action: no action

From: Brandon Brnich <b-brnich@ti.com>

[ Upstream commit b4e26c6fc1b3c225caf80d4a95c6f9fcbe959e17 ]

When STREAMON(CAP) is called after STREAMON(OUT), the driver was failing to
switch states from VPU_INST_STATE_OPEN to VPU_INST_STATE_INIT_SEQ and
VPU_INST_STATE_PIC_RUN because the capture queue streaming boolean had not
yet been set to true. This led to a hang in the encoder since the state
was stuck in VPU_INST_STATE_OPEN. During the second call to
start_streaming, the sequence initialization and frame buffer allocation
should occur.

Signed-off-by: Brandon Brnich <b-brnich@ti.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index 94fb5d7c87021..a11f0f7c7d7b0 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -1367,7 +1367,8 @@ static int wave5_vpu_enc_start_streaming(struct vb2_queue *q, unsigned int count
 		if (ret)
 			goto return_buffers;
 	}
-	if (inst->state == VPU_INST_STATE_OPEN && m2m_ctx->cap_q_ctx.q.streaming) {
+	if (inst->state == VPU_INST_STATE_OPEN &&
+	    (m2m_ctx->cap_q_ctx.q.streaming || q->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)) {
 		ret = initialize_sequence(inst);
 		if (ret) {
 			dev_warn(inst->dev->dev, "Sequence not found: %d\n", ret);
-- 
2.51.0


