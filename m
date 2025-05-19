Return-Path: <stable+bounces-144778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5091FABBD29
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E273B3C7A
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 12:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211A3201246;
	Mon, 19 May 2025 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nMVsHw9x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D2C13D52F
	for <stable@vger.kernel.org>; Mon, 19 May 2025 12:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747656048; cv=none; b=XfulrPkidnLJOWr9Tg6osI3VutXU2WRKoK7iUCRXeiug7/pVZtl2EAUShopz/SIS9vQ/vl53seMnRiLrPmhQrZ7EhDN/STSrj52QVdaxp5sxINtGrWdEG4bQRYSRCSGLRiJ0sl5cpD5Ws/ZWnjNe+olJiPRCwoJYWuVAZ0F9yaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747656048; c=relaxed/simple;
	bh=7SuLutil5XsLSxWlJwe2Xdh8dUx3ayM7zcGwI+jY0v8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=D3wrrzOY/MH9CRS4AiJD4xsTLeGnpzbJezGwyZ5WtTMt5iQiuZ2OoWi7V0pAIlt5d9zUMiWt7gCsYHlFZX4Y07+IDNKW4onO0GxhieWBod0W1K/Oknofh7nPeCc9wlw5AGUZRKqAKEryG6TUvyMiTrjthLN/UhQSDql2FlPVdts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nMVsHw9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9D8C4CEE4;
	Mon, 19 May 2025 12:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747656048;
	bh=7SuLutil5XsLSxWlJwe2Xdh8dUx3ayM7zcGwI+jY0v8=;
	h=Subject:To:Cc:From:Date:From;
	b=nMVsHw9xaDaWPkEml0NrC9FxToc+6/e9SLV7OlhxDbpjhzdbBuw3j3aufx3N2NGQt
	 8Q4mRyiMNqtHvXivDx/JCMkBBFvfgO8XF/+tGjzMJnfJ6my7hiL1NkcPLJJ/fbZIM7
	 bOQF1yV9mhQvWE6vu2fuafAiW4ZPljSDznq85yFU=
Subject: FAILED: patch "[PATCH] drm/tiny: panel-mipi-dbi: Use drm_client_setup_with_fourcc()" failed to apply to 6.6-stable tree
To: festevam@denx.de,javierm@redhat.com,tzimmermann@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 14:00:37 +0200
Message-ID: <2025051937-backup-carton-07fd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9c1798259b9420f38f1fa1b83e3d864c3eb1a83e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051937-backup-carton-07fd@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9c1798259b9420f38f1fa1b83e3d864c3eb1a83e Mon Sep 17 00:00:00 2001
From: Fabio Estevam <festevam@denx.de>
Date: Thu, 17 Apr 2025 07:34:58 -0300
Subject: [PATCH] drm/tiny: panel-mipi-dbi: Use drm_client_setup_with_fourcc()

Since commit 559358282e5b ("drm/fb-helper: Don't use the preferred depth
for the BPP default"), RGB565 displays such as the CFAF240320X no longer
render correctly: colors are distorted and the content is shown twice
horizontally.

This regression is due to the fbdev emulation layer defaulting to 32 bits
per pixel, whereas the display expects 16 bpp (RGB565). As a result, the
framebuffer data is incorrectly interpreted by the panel.

Fix the issue by calling drm_client_setup_with_fourcc() with a format
explicitly selected based on the display's bits-per-pixel value. For 16
bpp, use DRM_FORMAT_RGB565; for other values, fall back to the previous
behavior. This ensures that the allocated framebuffer format matches the
hardware expectations, avoiding color and layout corruption.

Tested on a CFAF240320X display with an RGB565 configuration, confirming
correct colors and layout after applying this patch.

Cc: stable@vger.kernel.org
Fixes: 559358282e5b ("drm/fb-helper: Don't use the preferred depth for the BPP default")
Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://lore.kernel.org/r/20250417103458.2496790-1-festevam@gmail.com

diff --git a/drivers/gpu/drm/tiny/panel-mipi-dbi.c b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
index 0460ecaef4bd..23914a9f7fd3 100644
--- a/drivers/gpu/drm/tiny/panel-mipi-dbi.c
+++ b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
@@ -390,7 +390,10 @@ static int panel_mipi_dbi_spi_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, drm);
 
-	drm_client_setup(drm, NULL);
+	if (bpp == 16)
+		drm_client_setup_with_fourcc(drm, DRM_FORMAT_RGB565);
+	else
+		drm_client_setup_with_fourcc(drm, DRM_FORMAT_RGB888);
 
 	return 0;
 }


