Return-Path: <stable+bounces-220713-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEMvOrhAo2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220713-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:23:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 934561C6ECF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE35130E3F5D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BC43FC8C2;
	Sat, 28 Feb 2026 17:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCfwKR9a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DFE3FC8B8;
	Sat, 28 Feb 2026 17:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300593; cv=none; b=aYyeRsB98f9tLbmpX1PttVNhO6UlNlpVSHqJfkmJPz+Dz+kj5b3hTfJ5hZEuRvN71YsACpRT094XPvEK6jZHqRFMb6xoC0Y462gyB3erc/HkB1V5io1wr977Jy5vCvYxatQ1ciN2UP4B/tFDl4H4uF6fPLyVx0gNq84/dzTpaJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300593; c=relaxed/simple;
	bh=EFZIfroVRKxAPaQYojJzhoqbjti53m4439xZKaFIDzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ydv4snKUI9X0MSRlXayLrRF6P87iOLHouhz5dhJzMrW1liwIVoflykqgz9NlPdIyXpR9X06PDmCzgMxi3/O5u7ENCGvVXXaa+AxlCaW/xE8YW6iYwvaorkhHzQFzOG3uGcBmyFS8BXgSWTro643r8sco1IUDdVXNlMdYdbqyZhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCfwKR9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560D5C116D0;
	Sat, 28 Feb 2026 17:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300593;
	bh=EFZIfroVRKxAPaQYojJzhoqbjti53m4439xZKaFIDzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CCfwKR9aNEsvL3oYBsh8JkPFpdAV1Gz1LBNxuJxMP/gJFdH8j/h1RE/irVxMLOQeH
	 cfBiYMsVk26RJdTThT9GsdbTkBTmJBfCLrzqwip4ByYZvBbAVK6k0obl0/oVA9795c
	 0qt5pZVerdAdPY0hqhB/ynCDhANu1GBXZxnVwzENvj2Xajy48ZmLXotptstiQt5Cu8
	 qq7kIm79zAg0MGbHGNYQEcPrh1mwSgQtMha2jdeCRzXxbQlgS+mAZmgnQhTQCUdDNM
	 95QvpNIKe657WEE1fMpvzwOEtPk92QK973Qc5wh9+PKY/bchRuk8ajBRi+3bNMbuak
	 y5+zjP7x9aG9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 634/844] media: iris: Fix fps calculation
Date: Sat, 28 Feb 2026 12:29:07 -0500
Message-ID: <20260228173244.1509663-635-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220713-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,chromium.org:email]
X-Rspamd-Queue-Id: 934561C6ECF
X-Rspamd-Action: no action

From: Ricardo Ribalda <ribalda@chromium.org>

[ Upstream commit 71fe80364a6584f404556ac9a6a4aca4ab80fb5b ]

iris_venc_s_param() uses do_div to divide two 64 bits operators, this is
wrong. Luckily for us, both of the operators fit in 32 bits, so we can use
a normal division.

Now that we are at it, mark the fps smaller than 1 as invalid, the code
does not seem to handle them properly.

The following cocci warning is fixed with this patch:
./platform/qcom/iris/iris_venc.c:378:1-7: WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead

Fixes: 4ff586ff28e3 ("media: iris: Add support for G/S_PARM for encoder video device")
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/iris/iris_venc.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_venc.c b/drivers/media/platform/qcom/iris/iris_venc.c
index 5830eba93c68b..0ed5018f9fe33 100644
--- a/drivers/media/platform/qcom/iris/iris_venc.c
+++ b/drivers/media/platform/qcom/iris/iris_venc.c
@@ -382,8 +382,7 @@ int iris_venc_s_param(struct iris_inst *inst, struct v4l2_streamparm *s_parm)
 	struct v4l2_fract *timeperframe = NULL;
 	u32 default_rate = DEFAULT_FPS;
 	bool is_frame_rate = false;
-	u64 us_per_frame, fps;
-	u32 max_rate;
+	u32 fps, max_rate;
 
 	int ret = 0;
 
@@ -405,23 +404,19 @@ int iris_venc_s_param(struct iris_inst *inst, struct v4l2_streamparm *s_parm)
 			timeperframe->denominator = default_rate;
 	}
 
-	us_per_frame = timeperframe->numerator * (u64)USEC_PER_SEC;
-	do_div(us_per_frame, timeperframe->denominator);
-
-	if (!us_per_frame)
+	fps = timeperframe->denominator / timeperframe->numerator;
+	if (!fps)
 		return -EINVAL;
 
-	fps = (u64)USEC_PER_SEC;
-	do_div(fps, us_per_frame);
 	if (fps > max_rate) {
 		ret = -ENOMEM;
 		goto reset_rate;
 	}
 
 	if (is_frame_rate)
-		inst->frame_rate = (u32)fps;
+		inst->frame_rate = fps;
 	else
-		inst->operating_rate = (u32)fps;
+		inst->operating_rate = fps;
 
 	if ((s_parm->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE && vb2_is_streaming(src_q)) ||
 	    (s_parm->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE && vb2_is_streaming(dst_q))) {
-- 
2.51.0


