Return-Path: <stable+bounces-204793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB62CF3D9D
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B221314B62B
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 13:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E2720FAA4;
	Mon,  5 Jan 2026 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0+3RrYji"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9319207A38
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767619669; cv=none; b=LRIkfDg1ZdDHw1mX62tLyWkYXJtZIX6VinZeS8ELZlT/7yHM1lHsj/QH3GjQap0CN5BKgZpl+gSE9ptEfF+ob9ER6OazC2/TEZPpA6sQFK5aaok96Dx7j8IQCmzRypqX6f9DBQUS+9re5Sum+r9i8L5n7P2/JUWpvMPtkqEKJ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767619669; c=relaxed/simple;
	bh=Nq1GgZrOf/emQcdrOsGb9hClHyJSrsTO84jtRf+YMdg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=giqJluWx8ZgtjN8DvESt48iIvlDZnl6XV0en+KHPyjAMOKW00KqI2NzHu0f0Zy0BxOIN8LsOtJqh43YGTrBN0m+/8CnofToFsF7LCI4UFxKJ/886hiblUT0Ttgfk0k7Lb3QhDTxECHm0D0kTsmjqf6LEZD5khy1mUgVXnFodLW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0+3RrYji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040E0C116D0;
	Mon,  5 Jan 2026 13:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767619669;
	bh=Nq1GgZrOf/emQcdrOsGb9hClHyJSrsTO84jtRf+YMdg=;
	h=Subject:To:Cc:From:Date:From;
	b=0+3RrYjiOi0Jwe/3Rq1YYhgZ2p+thmBTm+xJSrp6ResDMBWKm2Avx7Xd5VpbcDMUj
	 TUA782Hs0nFYy1VlYcjmNFSh04aDEtQWGiow+/kSqpQ2tPsK7iQdw0lMvi+zH1UxTO
	 WbY5oe+E+SkR1xXqoeoJPikg9FhUokddmfRnZhcY=
Subject: FAILED: patch "[PATCH] drm/mgag200: Fix big-endian support" failed to apply to 5.15-stable tree
To: rene@exactco.de,tzimmermann@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 14:27:46 +0100
Message-ID: <2026010546-doorpost-resume-e2e2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 6cb31fba137d45e682ce455b8ea364f44d5d4f98
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010546-doorpost-resume-e2e2@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6cb31fba137d45e682ce455b8ea364f44d5d4f98 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactco.de>
Date: Mon, 8 Dec 2025 14:18:27 +0100
Subject: [PATCH] drm/mgag200: Fix big-endian support
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Unlike the original, deleted Matrox mga driver, the new mgag200 driver
has the XRGB frame-buffer byte swapped on big-endian "RISC"
systems. Fix by enabling byte swapping "PowerPC" OPMODE for any
__BIG_ENDIAN config.

Fixes: 414c45310625 ("mgag200: initial g200se driver (v2)")
Signed-off-by: René Rebe <rene@exactco.de>
Cc: stable@kernel.org
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patch.msgid.link/20251208.141827.965103015954471168.rene@exactco.de

diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index 951d715dea30..d019177462cf 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -161,6 +161,30 @@ static void mgag200_set_startadd(struct mga_device *mdev,
 	WREG_ECRT(0x00, crtcext0);
 }
 
+/*
+ * Set the opmode for the hardware swapper for Big-Endian processor
+ * support for the frame buffer aperture and DMAWIN space.
+ */
+static void mgag200_set_datasiz(struct mga_device *mdev, u32 format)
+{
+#if defined(__BIG_ENDIAN)
+	u32 opmode = RREG32(MGAREG_OPMODE);
+
+	opmode &= ~(GENMASK(17, 16) | GENMASK(9, 8) | GENMASK(3, 2));
+
+	/* Big-endian byte-swapping */
+	switch (format) {
+	case DRM_FORMAT_RGB565:
+		opmode |= 0x10100;
+		break;
+	case DRM_FORMAT_XRGB8888:
+		opmode |= 0x20200;
+		break;
+	}
+	WREG32(MGAREG_OPMODE, opmode);
+#endif
+}
+
 void mgag200_init_registers(struct mga_device *mdev)
 {
 	u8 crtc11, misc;
@@ -496,6 +520,7 @@ void mgag200_primary_plane_helper_atomic_update(struct drm_plane *plane,
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_rect damage;
 
+	mgag200_set_datasiz(mdev, fb->format->format);
 	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
 	drm_atomic_for_each_plane_damage(&iter, &damage) {
 		mgag200_handle_damage(mdev, shadow_plane_state->data, fb, &damage);


