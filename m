Return-Path: <stable+bounces-83515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B4B99B366
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D1CEB22495
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A1615539D;
	Sat, 12 Oct 2024 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMg7Hew5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E713154C09;
	Sat, 12 Oct 2024 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732383; cv=none; b=d+myXP4KtPwAcKXpGdyQRmcjd/SdEfd6uN6XRt/V8OoD/JcwgR4hwPPIUjxzrmbMAk/BxMwsFkgGxirBLp5fTzWwZbR/B8jbKvuDdBHXG+2K6tcNo/m9fONO7IjB1KHX1ycO7g268FajIJDz2pqGfKYNFvMIl7ltugt/fOKMGCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732383; c=relaxed/simple;
	bh=lYkhIINQCsW+2d696QWDNwq1XLGeQGmtSOSYZ72cApY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q6EvMTaY3mJFwFvGVVZXe8cOKjTn0f1d1tvgqQ4AmN3LoS7ph2pt8d/io734j75KizScsmMsUmICrgToQZDuHk0cGCXjO7ivBBCOBV0L2KHGqYIi0rtWQwYPQo1UQlf7O8SZ0QY40DSOCUoxk5nQAPceg0IYfubYpopFpfOCZdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMg7Hew5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555B0C4CEC7;
	Sat, 12 Oct 2024 11:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732382;
	bh=lYkhIINQCsW+2d696QWDNwq1XLGeQGmtSOSYZ72cApY=;
	h=From:To:Cc:Subject:Date:From;
	b=XMg7Hew53o/aUoawKms7YpEIgGRFxCwKZ+je/MWrtNgPoIUiI7pP54C/p22ESBpyK
	 zHVAyUESXhVn+QFQRIbdDlSAHSysaWvpMIByqyrptru1oU4gh+WnIVCvRrTgEAJGii
	 QxVZWqQ3jFQHKJlaOd9eweWkgaEv5hlCbve2SMTEAtUy2DboBAqdwdm9XrHbh43JWA
	 LzD3lG5nUx4X7xlCPmPAja89PGksqoXVS9VXub7vroh1l/XScVTSPcfA4lIuC35EzC
	 fBsydU5+Nl49vIKCd6nwoESf25427trf1WogyMXYz207K6sB8PdLh1/9ivhujfAAHa
	 0Xj5ApIe2rpuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 01/16] drm/vboxvideo: Replace fake VLA at end of vbva_mouse_pointer_shape with real VLA
Date: Sat, 12 Oct 2024 07:25:57 -0400
Message-ID: <20241012112619.1762860-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.3
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit d92b90f9a54d9300a6e883258e79f36dab53bfae ]

Replace the fake VLA at end of the vbva_mouse_pointer_shape shape with
a real VLA to fix a "memcpy: detected field-spanning write error" warning:

[   13.319813] memcpy: detected field-spanning write (size 16896) of single field "p->data" at drivers/gpu/drm/vboxvideo/hgsmi_base.c:154 (size 4)
[   13.319841] WARNING: CPU: 0 PID: 1105 at drivers/gpu/drm/vboxvideo/hgsmi_base.c:154 hgsmi_update_pointer_shape+0x192/0x1c0 [vboxvideo]
[   13.320038] Call Trace:
[   13.320173]  hgsmi_update_pointer_shape [vboxvideo]
[   13.320184]  vbox_cursor_atomic_update [vboxvideo]

Note as mentioned in the added comment it seems the original length
calculation for the allocated and send hgsmi buffer is 4 bytes too large.
Changing this is not the goal of this patch, so this behavior is kept.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240827104523.17442-1-hdegoede@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vboxvideo/hgsmi_base.c | 10 +++++++++-
 drivers/gpu/drm/vboxvideo/vboxvideo.h  |  4 +---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vboxvideo/hgsmi_base.c b/drivers/gpu/drm/vboxvideo/hgsmi_base.c
index 8c041d7ce4f1b..87dccaecc3e57 100644
--- a/drivers/gpu/drm/vboxvideo/hgsmi_base.c
+++ b/drivers/gpu/drm/vboxvideo/hgsmi_base.c
@@ -139,7 +139,15 @@ int hgsmi_update_pointer_shape(struct gen_pool *ctx, u32 flags,
 		flags |= VBOX_MOUSE_POINTER_VISIBLE;
 	}
 
-	p = hgsmi_buffer_alloc(ctx, sizeof(*p) + pixel_len, HGSMI_CH_VBVA,
+	/*
+	 * The 4 extra bytes come from switching struct vbva_mouse_pointer_shape
+	 * from having a 4 bytes fixed array at the end to using a proper VLA
+	 * at the end. These 4 extra bytes were not subtracted from sizeof(*p)
+	 * before the switch to the VLA, so this way the behavior is unchanged.
+	 * Chances are these 4 extra bytes are not necessary but they are kept
+	 * to avoid regressions.
+	 */
+	p = hgsmi_buffer_alloc(ctx, sizeof(*p) + pixel_len + 4, HGSMI_CH_VBVA,
 			       VBVA_MOUSE_POINTER_SHAPE);
 	if (!p)
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/vboxvideo/vboxvideo.h b/drivers/gpu/drm/vboxvideo/vboxvideo.h
index f60d82504da02..79ec8481de0e4 100644
--- a/drivers/gpu/drm/vboxvideo/vboxvideo.h
+++ b/drivers/gpu/drm/vboxvideo/vboxvideo.h
@@ -351,10 +351,8 @@ struct vbva_mouse_pointer_shape {
 	 * Bytes in the gap between the AND and the XOR mask are undefined.
 	 * XOR mask scanlines have no gap between them and size of XOR mask is:
 	 * xor_len = width * 4 * height.
-	 *
-	 * Preallocate 4 bytes for accessing actual data as p->data.
 	 */
-	u8 data[4];
+	u8 data[];
 } __packed;
 
 /* pointer is visible */
-- 
2.43.0


