Return-Path: <stable+bounces-64468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA25941DF5
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72AB01F252B7
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC211A76BA;
	Tue, 30 Jul 2024 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1zOafbWH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC921A76AF;
	Tue, 30 Jul 2024 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360221; cv=none; b=ByNp6+mL8axYQ25K8pvhCxoEvtDiYNHyCCHkF7+ZmdLmjzFqRkdXjh1D8hx2+VZuwH3ZD8LboYhjP+wPnk91DD4BdLqLarPvO0Wde0I0lo0CuFcrhQpRjXTdw9X3o2z5fJ7KLY/oDyfMo8uNwR0MGAKnBMCaGSuWoSd+S0iCPkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360221; c=relaxed/simple;
	bh=kk/w0boIX4z1xrykrSiNiGxw2TbqpWeb8cn6g3leiAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCvxaDWTAOvQnpcy9Py22zAJ+53AxoYw5xXTghEBow73qHrtyyGZH3Qq3YXyGg1Xukx0DQSTTIpoWCqIqCMD+84qCTlijW2q55NzKp9DuOcKdl801Njy6THPV2HOM5NUf6KfZoxR7uWj/qdVF7NSjgrdQl2+QRbWGMP0ATk/UeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1zOafbWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B919DC32782;
	Tue, 30 Jul 2024 17:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722360221;
	bh=kk/w0boIX4z1xrykrSiNiGxw2TbqpWeb8cn6g3leiAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1zOafbWHmv5zGUAoRvC8menXc9a5rabdOStmSpubxPHWj2GnR4kaUWuN7h76jEad+
	 pxvqCrA6Ka4CeHBXs8dTbfO01MBZ/LmJJIqrJ/Iukg7clD2t7l44ylhW4FAYH0+COu
	 ZJSDbDP8aGMeaNV5UIQQWo5KN14LQIFdSUWRrDpc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Thomas Huth <thuth@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 6.10 634/809] drm/fbdev-dma: Fix framebuffer mode for big endian devices
Date: Tue, 30 Jul 2024 17:48:30 +0200
Message-ID: <20240730151749.883723357@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Huth <thuth@redhat.com>

commit cb31c58e8c294ff31ea842ee1fa2c06c9a9f1cc3 upstream.

The drm_mode_legacy_fb_format() function only generates formats suitable
for little endian devices. switch to drm_driver_legacy_fb_format() here
instead to take the device endianness into consideration, too.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 6ae2ff23aa43 ("drm/client: Convert drm_client_buffer_addfb() to drm_mode_addfb2()")
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: <stable@vger.kernel.org> # v6.7+
Link: https://patchwork.freedesktop.org/patch/msgid/20240702121737.522878-1-thuth@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_fbdev_dma.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/drm_fbdev_dma.c
+++ b/drivers/gpu/drm/drm_fbdev_dma.c
@@ -90,7 +90,8 @@ static int drm_fbdev_dma_helper_fb_probe
 		    sizes->surface_width, sizes->surface_height,
 		    sizes->surface_bpp);
 
-	format = drm_mode_legacy_fb_format(sizes->surface_bpp, sizes->surface_depth);
+	format = drm_driver_legacy_fb_format(dev, sizes->surface_bpp,
+					     sizes->surface_depth);
 	buffer = drm_client_framebuffer_create(client, sizes->surface_width,
 					       sizes->surface_height, format);
 	if (IS_ERR(buffer))



