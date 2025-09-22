Return-Path: <stable+bounces-181365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DBBB9311C
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C79A2E01BA
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4872F3C2F;
	Mon, 22 Sep 2025 19:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xpnf3dNU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB502F49E3;
	Mon, 22 Sep 2025 19:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570359; cv=none; b=oznSKbPvz4RBNH9czUNRUml0WFoNTBTCRDUG95g9uNYv1O6dC0YfxmtNGZu7tZmfrh+EmaLPGK6W1rqHlkbRM0X9fx+9YVtfQZk4dFuyv8RBm/KsA086XuhZVXq2DWuJZEi23b12ov6KxgpfRMx/jirzx8WCQGfyCmB4m0SklYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570359; c=relaxed/simple;
	bh=FvnL/dhvmO3xMT1crajOQdOxaGReVrkPljAuPL3Py4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1vITfkSXlQ/lQzoLrqkTRF3vwyys0XYqSVjVYT5bQvubtkJP7KipS7s3uXDNfjUHsmLcQqI4MA5AwUX7LWiFGi3p1TLULKM50IdyADhD0xzBAikhcaa1cI1T5ctj3Fm43ww0Dh9Xvmym/4bdQVFsa5WN8FxPPRiTdzkFsBp++M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xpnf3dNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6690DC4CEF0;
	Mon, 22 Sep 2025 19:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758570359;
	bh=FvnL/dhvmO3xMT1crajOQdOxaGReVrkPljAuPL3Py4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xpnf3dNUKO+cFnDaigzjKdDzlp+dfcZTPEAzOl1Hk+3APQfEH8bUzqQlK+g08H6QI
	 WUk3UJ6c2j2qMXUYdXe3NehtSnJPPCrLi2JC/XRkBhvk9LDQTsHOMmv8NraV3VhA/l
	 ULpuZeJ5Gbil/tcTmuSTTsQD+5/I7BPG8omwzeig=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sun peng Li <sunpeng.li@amd.com>,
	Ivan Lipski <ivan.lipski@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.16 096/149] drm/amd/display: Allow RX6xxx & RX7700 to invoke amdgpu_irq_get/put
Date: Mon, 22 Sep 2025 21:29:56 +0200
Message-ID: <20250922192415.307468593@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
References: <20250922192412.885919229@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Lipski <ivan.lipski@amd.com>

commit 29a2f430475357f760679b249f33e7282688e292 upstream.

[Why&How]
As reported on https://gitlab.freedesktop.org/drm/amd/-/issues/3936,
SMU hang can occur if the interrupts are not enabled appropriately,
causing a vblank timeout.

This patch reverts commit 5009628d8509 ("drm/amd/display: Remove unnecessary
amdgpu_irq_get/put"), but only for RX6xxx & RX7700 GPUs, on which the
issue was observed.

This will re-enable interrupts regardless of whether the user space needed
it or not.

Fixes: 5009628d8509 ("drm/amd/display: Remove unnecessary amdgpu_irq_get/put")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3936
Suggested-by: Sun peng Li <sunpeng.li@amd.com>
Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 95d168b367aa28a59f94fc690ff76ebf69312c6d)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   39 +++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8689,7 +8689,16 @@ static int amdgpu_dm_encoder_init(struct
 static void manage_dm_interrupts(struct amdgpu_device *adev,
 				 struct amdgpu_crtc *acrtc,
 				 struct dm_crtc_state *acrtc_state)
-{
+{	/*
+	 * We cannot be sure that the frontend index maps to the same
+	 * backend index - some even map to more than one.
+	 * So we have to go through the CRTC to find the right IRQ.
+	 */
+	int irq_type = amdgpu_display_crtc_idx_to_irq_type(
+			adev,
+			acrtc->crtc_id);
+	struct drm_device *dev = adev_to_drm(adev);
+
 	struct drm_vblank_crtc_config config = {0};
 	struct dc_crtc_timing *timing;
 	int offdelay;
@@ -8742,7 +8751,35 @@ static void manage_dm_interrupts(struct
 
 		drm_crtc_vblank_on_config(&acrtc->base,
 					  &config);
+		/* Allow RX6xxx, RX7700, RX7800 GPUs to call amdgpu_irq_get.*/
+		switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
+		case IP_VERSION(3, 0, 0):
+		case IP_VERSION(3, 0, 2):
+		case IP_VERSION(3, 0, 3):
+		case IP_VERSION(3, 2, 0):
+			if (amdgpu_irq_get(adev, &adev->pageflip_irq, irq_type))
+				drm_err(dev, "DM_IRQ: Cannot get pageflip irq!\n");
+#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+			if (amdgpu_irq_get(adev, &adev->vline0_irq, irq_type))
+				drm_err(dev, "DM_IRQ: Cannot get vline0 irq!\n");
+#endif
+		}
+
 	} else {
+		/* Allow RX6xxx, RX7700, RX7800 GPUs to call amdgpu_irq_put.*/
+		switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
+		case IP_VERSION(3, 0, 0):
+		case IP_VERSION(3, 0, 2):
+		case IP_VERSION(3, 0, 3):
+		case IP_VERSION(3, 2, 0):
+#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+			if (amdgpu_irq_put(adev, &adev->vline0_irq, irq_type))
+				drm_err(dev, "DM_IRQ: Cannot put vline0 irq!\n");
+#endif
+			if (amdgpu_irq_put(adev, &adev->pageflip_irq, irq_type))
+				drm_err(dev, "DM_IRQ: Cannot put pageflip irq!\n");
+		}
+
 		drm_crtc_vblank_off(&acrtc->base);
 	}
 }



