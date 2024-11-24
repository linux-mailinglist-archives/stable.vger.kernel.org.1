Return-Path: <stable+bounces-95236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3554D9D7475
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEEBE2811AD
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851521B21BD;
	Sun, 24 Nov 2024 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5Fj+cc7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CB4240FE6;
	Sun, 24 Nov 2024 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456453; cv=none; b=DnsWGcPeh45mVnDW0/PDA7kP/ZNB/LUcxrhv9IbAynir/ji22GfTi4MWwrrl/n8o9Ba8eAJYvULlQ1nqolk0ZmOJTpjnXlA0nlZsLt0NQwM3otgOTrIlHByHYPk8ISTgAmj5DbVjSW4bDX/+Ymc915scGF3Lg5v94muu3BzXRLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456453; c=relaxed/simple;
	bh=fdJg4E+ZjiSqnAVXysEsXx/1QZXi9B+MaxM4ktrHRaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K71jhdDT2QldJ7OpricGMCcurHdhc1n6PgHsJXqND+Ih5o/PSz8yWi67GXyFm6HWUICRPNv+3z9q2I0jCVcdS61kcHVnmBRrRibXZ6pkqoe7+BkZ9fy73aIKvFHzMOvCMOZGTsz0C23qrt1WWNbkHSlIPcsFcOsRfNmIpu3cxqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5Fj+cc7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930B8C4CECC;
	Sun, 24 Nov 2024 13:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456452;
	bh=fdJg4E+ZjiSqnAVXysEsXx/1QZXi9B+MaxM4ktrHRaI=;
	h=From:To:Cc:Subject:Date:From;
	b=G5Fj+cc7v4y0hDvAzpqNQ01nBePiEOC7xwIdnvSYLUzOx+faNlvBK0X1eOfoDUu2L
	 TFVb0kcFxo/o4gbdmFVtj+GHQmxT+EVEt0808b4LC+/K49T8p8ilKjmWt8uSNF2v1w
	 YgJvgNv3wJHEkch8S5xAUcOkVRApQlJ8d5FYkZG04VOToPbLbEA5OkEP5aL86IzB9x
	 Tjj+MokZLMgFANVQ1t0GCFI3y24OE6c3xo14A6TnX5PEI0/YsRV26oV2KADmFtEbPr
	 eKGMjg6nfCCgB/xPlYBth+jBxTsx0tNYAG4xYfdvQRsANvLB9cD3a3SvBwjQglmwol
	 T+oy/UClKy9zQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 01/33] drm/vc4: hvs: Set AXI panic modes for the HVS
Date: Sun, 24 Nov 2024 08:53:13 -0500
Message-ID: <20241124135410.3349976-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
Content-Transfer-Encoding: 8bit

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

[ Upstream commit 014eccc9da7bfc76a3107fceea37dd60f1d63630 ]

The HVS can change AXI request mode based on how full the COB
FIFOs are.
Until now the vc4 driver has been relying on the firmware to
have set these to sensible values.

With HVS channel 2 now being used for live video, change the
panic mode for all channels to be explicitly set by the driver,
and the same for all channels.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240621152055.4180873-7-dave.stevenson@raspberrypi.com
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_hvs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index f8f2fc3d15f73..64a02e29b7cb1 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -688,6 +688,17 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
 	dispctrl |= VC4_SET_FIELD(2, SCALER_DISPCTRL_PANIC1);
 	dispctrl |= VC4_SET_FIELD(2, SCALER_DISPCTRL_PANIC2);
 
+	/* Set AXI panic mode.
+	 * VC4 panics when < 2 lines in FIFO.
+	 * VC5 panics when less than 1 line in the FIFO.
+	 */
+	dispctrl &= ~(SCALER_DISPCTRL_PANIC0_MASK |
+		      SCALER_DISPCTRL_PANIC1_MASK |
+		      SCALER_DISPCTRL_PANIC2_MASK);
+	dispctrl |= VC4_SET_FIELD(2, SCALER_DISPCTRL_PANIC0);
+	dispctrl |= VC4_SET_FIELD(2, SCALER_DISPCTRL_PANIC1);
+	dispctrl |= VC4_SET_FIELD(2, SCALER_DISPCTRL_PANIC2);
+
 	HVS_WRITE(SCALER_DISPCTRL, dispctrl);
 
 	ret = devm_request_irq(dev, platform_get_irq(pdev, 0),
-- 
2.43.0


