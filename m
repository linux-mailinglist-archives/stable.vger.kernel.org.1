Return-Path: <stable+bounces-77443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D1E985D4B
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4A5285A23
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3BB1DEFC7;
	Wed, 25 Sep 2024 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdkIzJAR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A341DCB3D;
	Wed, 25 Sep 2024 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265793; cv=none; b=ji16mha8zVxJClkWRJpy9nE7Bc/7OX/pZIqR+5DcKmVmWEH29vzp5cZiVmsFN3rPQhfRI1hT6QV1nRYDoWzM6JZozIRC9DZvk/f3hmT0ooAtQc4alzei7WjQsdj4J+pYZ/uKtrHGclyWiJMdCtueTIq/UAGnHB8zzqeN9GoWOT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265793; c=relaxed/simple;
	bh=6Rf5F4xR3of/PuGK6m3em5sCuc3QV6oACndIhzGnyQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9YpbNyyVfAfts7smYV5Pf/CXk29UW2R5VD0WGyU8kmJhGALeumCNpKrfyMaW/RoLHHHuaAt2JfMOwiS8oBQm8rUqSJxlZvJDBmgdgNssV8gMPgZlOwDKJgJOwAg7yQzIrE0CG+Xztiz1hoaS0GlnES1pWXnpyl/bvPQUGXjZlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdkIzJAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2E5C4CECF;
	Wed, 25 Sep 2024 12:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265793;
	bh=6Rf5F4xR3of/PuGK6m3em5sCuc3QV6oACndIhzGnyQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NdkIzJAR2xe/ovRxCjFBUNuMnn5Tq6H7C2D/kpckwB6CoKpLq/6tnjcqnkYwtU/v+
	 SiKUWTp1DqqI7MeIbFkNQnmfP6c2h66MU1hMi/fzyLcFoj5w5i+i3sZwMRKIOabxK3
	 ATzzD1FIJfwbG6rPfxgU1RfiJdH9WLEtt0u4zfhjE8k/W3LtpzF+fEgEhmugphY43K
	 pkTSenp9l9lNLF+JzAjH6I3hrJCy2a4NImBTxfvnKZirdFWgOUDpanQX/gmeebtfq5
	 UXuRCRynrNEPk0EX0i/sMSuaMfBZ1KzGtdryw/Smw4nELp/4FIaXrXoa7eXI1EumFY
	 UggjUw51vEPGw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	pjones@redhat.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 098/197] fbdev: efifb: Register sysfs groups through driver core
Date: Wed, 25 Sep 2024 07:51:57 -0400
Message-ID: <20240925115823.1303019-98-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit 95cdd538e0e5677efbdf8aade04ec098ab98f457 ]

The driver core can register and cleanup sysfs groups already.
Make use of that functionality to simplify the error handling and
cleanup.

Also avoid a UAF race during unregistering where the sysctl attributes
were usable after the info struct was freed.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/efifb.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 8dd82afb3452b..595b8e27bea66 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -561,15 +561,10 @@ static int efifb_probe(struct platform_device *dev)
 		break;
 	}
 
-	err = sysfs_create_groups(&dev->dev.kobj, efifb_groups);
-	if (err) {
-		pr_err("efifb: cannot add sysfs attrs\n");
-		goto err_unmap;
-	}
 	err = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (err < 0) {
 		pr_err("efifb: cannot allocate colormap\n");
-		goto err_groups;
+		goto err_unmap;
 	}
 
 	err = devm_aperture_acquire_for_platform_device(dev, par->base, par->size);
@@ -587,8 +582,6 @@ static int efifb_probe(struct platform_device *dev)
 
 err_fb_dealloc_cmap:
 	fb_dealloc_cmap(&info->cmap);
-err_groups:
-	sysfs_remove_groups(&dev->dev.kobj, efifb_groups);
 err_unmap:
 	if (mem_flags & (EFI_MEMORY_UC | EFI_MEMORY_WC))
 		iounmap(info->screen_base);
@@ -608,12 +601,12 @@ static void efifb_remove(struct platform_device *pdev)
 
 	/* efifb_destroy takes care of info cleanup */
 	unregister_framebuffer(info);
-	sysfs_remove_groups(&pdev->dev.kobj, efifb_groups);
 }
 
 static struct platform_driver efifb_driver = {
 	.driver = {
 		.name = "efi-framebuffer",
+		.dev_groups = efifb_groups,
 	},
 	.probe = efifb_probe,
 	.remove_new = efifb_remove,
-- 
2.43.0


