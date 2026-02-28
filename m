Return-Path: <stable+bounces-220236-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gN/aLsMuo2me+AQAu9opvQ
	(envelope-from <stable+bounces-220236-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:06:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E8E1C56C3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 265A733C639F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F5936DA18;
	Sat, 28 Feb 2026 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSF9cS2u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589FE36DA0F;
	Sat, 28 Feb 2026 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300140; cv=none; b=mczH7ESx9aGx+97IPw4tIkor4H09B3DIrnNXMSanIricarBxSgUho4Cgq99qihvVPefDz+b75OEY91zcVJYh8BFzxW3ZlZcYj6R0mz7oSJ1U150OEOPiY4DGMwAb+LyswTVGCN6OzwJsy5pUuAJr6Mn+1x8X1jRHiBrmkxZQUGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300140; c=relaxed/simple;
	bh=NOzhfqd4DjmFiQKuS+a1GuPqV7fhkO86AfFKKYFbbyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekaOmkwjF63y6IYdQztI2KYHw4ce72GdMFVx36y6R+nn3stKcRbUoPsorJ3AH+NSXUZxKC5nQAYF1xsNfriKME3+QEUJwOwaV7lqVYP9DpmBye8nooERUGrfHEJa9V9d9X+cY01ZQMri+9Ok1xSB/aLIYXgJal3CCrfsQgVrboM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSF9cS2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D08CC116D0;
	Sat, 28 Feb 2026 17:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300140;
	bh=NOzhfqd4DjmFiQKuS+a1GuPqV7fhkO86AfFKKYFbbyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZSF9cS2usx58a+13SHSCUUa9cFRjBqA5enfSYsuMcoxiGmjBK/AtTjunty7opjczf
	 2HV6fj4NP68GVPj62W4iQm2TKkEmPT3Th/ESaD9MpmdeIuBlktzLPPr5Zx5aUZy21E
	 +T5keVtCgP0wR+uR8W/WOadXk+w+QKEIEtWztXSlpu8YzC9qFMc0n10xTrlUQ3hsZF
	 hiQCWKc2oDlbSv+XPVEsvnFApe+UZn+uim/GX/v64lqV0STr23SQVYEnQqf0wQUNHf
	 L1M4RMM57MJo3euBx9sDSD3PUaIiN8MSOp6sWIc3rxUWWoulWXq7iCwJGzTwPFDHjF
	 WHkWwk+varQ+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 158/844] media: mediatek: vcodec: Don't try to decode 422/444 VP9
Date: Sat, 28 Feb 2026 12:21:11 -0500
Message-ID: <20260228173244.1509663-159-sashal@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220236-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,collabora.com:email]
X-Rspamd-Queue-Id: 74E8E1C56C3
X-Rspamd-Action: no action

From: Nicolas Dufresne <nicolas.dufresne@collabora.com>

[ Upstream commit 3e92d7e4935084ecdbdc88880cc4688618ae1557 ]

This is not supported by the hardware and trying to decode
these leads to LAT timeout errors.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
index d873159b9b306..9eef3ff2b1278 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
@@ -502,6 +502,12 @@ static int mtk_vdec_s_ctrl(struct v4l2_ctrl *ctrl)
 			mtk_v4l2_vdec_err(ctx, "VP9: bit_depth:%d", frame->bit_depth);
 			return -EINVAL;
 		}
+
+		if (!(frame->flags & V4L2_VP9_FRAME_FLAG_X_SUBSAMPLING) ||
+		    !(frame->flags & V4L2_VP9_FRAME_FLAG_Y_SUBSAMPLING)) {
+			mtk_v4l2_vdec_err(ctx, "VP9: only 420 subsampling is supported");
+			return -EINVAL;
+		}
 		break;
 	case V4L2_CID_STATELESS_AV1_SEQUENCE:
 		seq = (struct v4l2_ctrl_av1_sequence *)hdr_ctrl->p_new.p;
-- 
2.51.0


