Return-Path: <stable+bounces-220234-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLCfI7ouo2me+AQAu9opvQ
	(envelope-from <stable+bounces-220234-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:06:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3A21C56BC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F25ED30E98F9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1183B36D9E5;
	Sat, 28 Feb 2026 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuviLNUM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F6247CC99;
	Sat, 28 Feb 2026 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300138; cv=none; b=b+GQIPdIznm+VwPlkIyMLuhVpxmEYprf2CI65pxlxs0Iv2Q5OTVn6zkFo7C6xWL5aMXxS3imtirCIBuNFhDsAYwMS1ISiERooTtez600rAkCOP9Lk11bJj7Ung0qC6pSwcAu0BwU2yxraRCyMjlgDt7/0JzkDLI9mzq+q1ru0VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300138; c=relaxed/simple;
	bh=hFQSfyc2sFzPu99hh9iKoECuRF196fks64pjmsKHxFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bt4wmoIS4lLHms1snFgjlXfMBZ0eIAsDvik6vPplOMUFX9ZGldCtPg8f4yHi4+CxrCFegYpToKPrpmB43+AeM6NkZOL7bKXWN3xPoeURvY4XAHBEIa8dGcib83hUMgeHWBY6QbtnZ2diSayZS3ArYGXlk1H+mNTI4efRe8ZmETo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuviLNUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0200C19423;
	Sat, 28 Feb 2026 17:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300138;
	bh=hFQSfyc2sFzPu99hh9iKoECuRF196fks64pjmsKHxFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JuviLNUMXM/JZSMyaPdeSblguWZ8PH/VTHVLAREeUX9r7GMiYezUjBSCRQw8gpLXL
	 7dpeGvO8T7Cuti/p5G+vASCv//LSOBUmkgyKYwRrM+Gfrol/U+3BbFVwLDcOV9zxfB
	 x9L1FpjIVM0z6aAqiQ8j+1PUD4tS8Uq1Y1ztlS+XRkalyecRwBcA/vWQMIo8jZdrUJ
	 ZvRcfqTPdkyTy3fXyiQje/7nfET13sY8rCHboWBtr9ZjaARkSoUNk65hl2CaFqriMB
	 zixLSsEph4zn878Wh0KOlOzZjECKS49sw6zBwl7FhTMpONtuMamxeOu4bmT2LolXXJ
	 HqDSuv85WCp9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brandon Brnich <b-brnich@ti.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 156/844] media: chips-media: wave5: Process ready frames when CMD_STOP sent to Encoder
Date: Sat, 28 Feb 2026 12:21:09 -0500
Message-ID: <20260228173244.1509663-157-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-220234-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,collabora.com:email,ti.com:email]
X-Rspamd-Queue-Id: 0D3A21C56BC
X-Rspamd-Action: no action

From: Brandon Brnich <b-brnich@ti.com>

[ Upstream commit 5da0380de41439ed64ed9a5218850db38544e315 ]

CMD_STOP being sent to encoder before last job is executed by device_run
can lead to an occasional dropped frame. Ensure that remaining ready
buffers are drained by making a call to v4l2_m2m_try_schedule.

Signed-off-by: Brandon Brnich <b-brnich@ti.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index a11f0f7c7d7b0..a254830e4009e 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -649,6 +649,8 @@ static int wave5_vpu_enc_encoder_cmd(struct file *file, void *fh, struct v4l2_en
 
 		m2m_ctx->last_src_buf = v4l2_m2m_last_src_buf(m2m_ctx);
 		m2m_ctx->is_draining = true;
+
+		v4l2_m2m_try_schedule(m2m_ctx);
 		break;
 	case V4L2_ENC_CMD_START:
 		break;
-- 
2.51.0


