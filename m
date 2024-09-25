Return-Path: <stable+bounces-77444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2840D985D4F
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D9A1F272E3
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90791DFE22;
	Wed, 25 Sep 2024 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHEjlePC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814C51DCB3D;
	Wed, 25 Sep 2024 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265796; cv=none; b=Rv9NZmEaEHBW//aUO2c8dcJT2tfkeupw1PLsOz8kb0MHUSlQuPIaqBsT3r0ivASiQhnBtM2WUk7T6h77KApYodrKTUM7Tqdu3A7o4IYBLdKmdWlONuiH1+ltiw1VHQ/DDssh5oV6IjZP0eKMTcDKBsIsTTd9Ml/AxXz/ao08w2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265796; c=relaxed/simple;
	bh=jHudm0CECuKh1KiFB3Pzw6IIjb7GizByG8fAtQfyH6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knixu8c1Z0HZ1fnkTI1VACOWbVTK+T53WwRZTUXHb1aT+AnCady4feV7Sp/FqP/+SYhSFKocMfYDtR7D6xQ9Y3NbY3rWtYnnFzPKgsNSdTYL+rTzXgMYdVDl19KyWDYaTPETIcD2BiSi2ae0eTbly39RO3+yGoNVVdjzR9S34uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHEjlePC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB5AC4CECD;
	Wed, 25 Sep 2024 12:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265796;
	bh=jHudm0CECuKh1KiFB3Pzw6IIjb7GizByG8fAtQfyH6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bHEjlePCZY3i8UOjAsKGpQQIsQZFp3TXhxAtpcLbqI5PpOlVj++3TNiudNspTNxI5
	 dtg15jxwUVWuuRSJbw5uY/lM36yhbqDEZqy5ukw0+1NfxwVh4GWGjJgRGypTv0FCOz
	 UidMMibJCxtoA79xZAhRkgXXcQ14gOnOJiQfoSUp1tp/2wJgSS3H2Z1X4m8NJbqI+4
	 SkxIWHseWWGz/V8HDAy44vdayqOiatF6H/n0re5aPkgNLQF4GYsaY8z5A0TCiYsb2D
	 D8Ea7fqSduGata03XYvVbDip4XVI+9iacav7odTEuQ67qxD9d0e4eHTwUXgeXAstW9
	 MH4FtOWkvK1SQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kaixin Wang <kxwang23@m.fudan.edu.cn>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	laurent.pinchart@ideasonboard.com,
	kuninori.morimoto.gx@renesas.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 099/197] fbdev: pxafb: Fix possible use after free in pxafb_task()
Date: Wed, 25 Sep 2024 07:51:58 -0400
Message-ID: <20240925115823.1303019-99-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Kaixin Wang <kxwang23@m.fudan.edu.cn>

[ Upstream commit 4a6921095eb04a900e0000da83d9475eb958e61e ]

In the pxafb_probe function, it calls the pxafb_init_fbinfo function,
after which &fbi->task is associated with pxafb_task. Moreover,
within this pxafb_init_fbinfo function, the pxafb_blank function
within the &pxafb_ops struct is capable of scheduling work.

If we remove the module which will call pxafb_remove to make cleanup,
it will call unregister_framebuffer function which can call
do_unregister_framebuffer to free fbi->fb through
put_fb_info(fb_info), while the work mentioned above will be used.
The sequence of operations that may lead to a UAF bug is as follows:

CPU0                                                CPU1

                                   | pxafb_task
pxafb_remove                       |
unregister_framebuffer(info)       |
do_unregister_framebuffer(fb_info) |
put_fb_info(fb_info)               |
// free fbi->fb                    | set_ctrlr_state(fbi, state)
                                   | __pxafb_lcd_power(fbi, 0)
                                   | fbi->lcd_power(on, &fbi->fb.var)
                                   | //use fbi->fb

Fix it by ensuring that the work is canceled before proceeding
with the cleanup in pxafb_remove.

Note that only root user can remove the driver at runtime.

Signed-off-by: Kaixin Wang <kxwang23@m.fudan.edu.cn>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/pxafb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 2ef56fa28aff3..5ce02495cda63 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2403,6 +2403,7 @@ static void pxafb_remove(struct platform_device *dev)
 	info = &fbi->fb;
 
 	pxafb_overlay_exit(fbi);
+	cancel_work_sync(&fbi->task);
 	unregister_framebuffer(info);
 
 	pxafb_disable_controller(fbi);
-- 
2.43.0


