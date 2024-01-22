Return-Path: <stable+bounces-13587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28634837CE6
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5B31F29119
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5722E15B305;
	Tue, 23 Jan 2024 00:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pbGvK2Yq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D5715B2FC;
	Tue, 23 Jan 2024 00:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969754; cv=none; b=Wnr5UCqrckSqqjS5Qf7zxqfN0mJwds/aRA/7wD67eoMv7JWH/9m+iCSeNLjijiCKBitEogf9KBdExNnu98GaplVyX5fJVQAB7SQStoWKc8a4eXF67yWzL2Go2evnbdDnSY9VmCZgCn+mBSpK3khX8Xl+F7nZPEGgKwnVwY2tCGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969754; c=relaxed/simple;
	bh=w/C3Ok5GtOJo1O/K7TNZuJ+B652PmuByUb2cW6UzHi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evk3FMLSWU4DAngAkkKscJ8+RdyRHTREEMROn3JCdrET8GBamjVqRO+sb7mwzKKuERkMcEunt6zauYjotYBaY9Ryfum1Opdj0+CS6459rY7Ud/7G1PfsoEZkMAD6k2/2otfACIqD0ea8Hrcj+LodOLdlhFc5MXfQHOIJ9qPg3nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pbGvK2Yq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244EFC433C7;
	Tue, 23 Jan 2024 00:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969753;
	bh=w/C3Ok5GtOJo1O/K7TNZuJ+B652PmuByUb2cW6UzHi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pbGvK2Yqpxn0nB72Gmdr3M0WCoeM/g3tNPqHeS43oieIO89XtuZeeZbDDZ/QUiIi0
	 ZaZOK+SdGxAW0vmsDVHnbq2hp9PjYc4iQudBWduunXahQfEUB0PVh0MMk8TRf87Ycx
	 fUy8kZT55h/k8EyEHr/EryZRId4Iuwcdc3e4IX34=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Helge Deller <deller@gmx.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 6.7 430/641] fbdev/acornfb: Fix name of fb_ops initializer macro
Date: Mon, 22 Jan 2024 15:55:34 -0800
Message-ID: <20240122235831.446298369@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

commit b48807788e7a2bd93044fe84cfe8ff64b85ec15e upstream.

Fix build by using the correct name for the initializer macro
for struct fb_ops.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 9037afde8b9d ("fbdev/acornfb: Use fbdev I/O helpers")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: <stable@vger.kernel.org> # v6.6+
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231127131655.4020-2-tzimmermann@suse.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/acornfb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/video/fbdev/acornfb.c
+++ b/drivers/video/fbdev/acornfb.c
@@ -605,7 +605,7 @@ acornfb_pan_display(struct fb_var_screen
 
 static const struct fb_ops acornfb_ops = {
 	.owner		= THIS_MODULE,
-	FB_IOMEM_DEFAULT_OPS,
+	FB_DEFAULT_IOMEM_OPS,
 	.fb_check_var	= acornfb_check_var,
 	.fb_set_par	= acornfb_set_par,
 	.fb_setcolreg	= acornfb_setcolreg,



