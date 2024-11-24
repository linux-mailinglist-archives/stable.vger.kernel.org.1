Return-Path: <stable+bounces-95200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 132689D741E
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB8D283BD6
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2455A1F9582;
	Sun, 24 Nov 2024 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECzo0UEJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64331F9593;
	Sun, 24 Nov 2024 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456341; cv=none; b=lMXRMM5O8Xh0pEKVLuzHn/mA+WYDY7xY4h0m9JGtQV7e+s09xr5SMHIhy3Rpj1vhsdQb9pAQ46GRDmIvgeOJsGQM4VxtkORJFc1zAjdwyMjqCJDYU37tKkOrl322P98+NdOPRGI8qb1tmz84wl25RFf0EHdFQZVGRLz1PxSWaWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456341; c=relaxed/simple;
	bh=6Ia5i8vhTxBHx+/WKhZtOL52JILqLguAD8ISGEQQijY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u+GvRMnc9FHqs5aFlw4CnauEB+Z/Qv+52oQS/+eHFcxwVjy2FwZnYQtPdSp8i0CEj1fO5rQAGVRI+4YlKG+9GPHZSU0eHAkha/D9pCjzsXwjfmrzaYv+pm5TJUbzJ0uKzg4+pmkrbPO3DQ2RL2WlwwPXWYK0MXyzWM32Xnil4jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECzo0UEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9938EC4CECC;
	Sun, 24 Nov 2024 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456341;
	bh=6Ia5i8vhTxBHx+/WKhZtOL52JILqLguAD8ISGEQQijY=;
	h=From:To:Cc:Subject:Date:From;
	b=ECzo0UEJjAccRNZc2zczTwQeY2aHNjZ9thOmlTGZymwzG3EP+jk8N7gIMyXKltS5h
	 GSEeVGCBWrtdrF/RPLonL8E3ZYLAMDWW+qutj+TEQIGYr5df7mVdsQlHJbwcwi14YN
	 dr8pLhqw/dYWsCPbQlDdawmY+hbc992HOSAFkqpxOQZWwBKO/DTXfzdvlFaFzbdlfn
	 OwrJ4GSe4Ckpcm5TpWw60hI2291zByKXVAQ/4dOtIILpyEB3jaDpfLPuh3IE1G0VHf
	 HIjqShezIvuhQRKn/6jWaYP76IQJpeko3WrB+a/v7GNSR8venwDnxLswF/gzyQXC/O
	 eCUxIxX6fVaSA==
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
Subject: [PATCH AUTOSEL 5.15 01/36] drm/vc4: hvs: Set AXI panic modes for the HVS
Date: Sun, 24 Nov 2024 08:51:15 -0500
Message-ID: <20241124135219.3349183-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
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
index 3856ac289d380..69b2936a5f4ad 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -729,6 +729,17 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
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


