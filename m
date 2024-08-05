Return-Path: <stable+bounces-65422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E179480F8
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 20:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D3A285A0A
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 18:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BDC16630E;
	Mon,  5 Aug 2024 17:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tz0J7xAU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C81165F1A;
	Mon,  5 Aug 2024 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880659; cv=none; b=hNRrtk7zBLp6D2C3st0Nnn5F3xIIyMmkYDWNmY9mO0Kpn2YZpyQqJZOLW16182fOdlWJ0pPuVMwtoaRx9fSpL3RL3YKl2dVoeI0Yzhy8uo12uauKUyJQFoqoSPPbwQGhk9q6ExouZVZQyakkKOgQVUZ7whobK9jGlF2fHADD760=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880659; c=relaxed/simple;
	bh=Z2Wnr6wo32Vo1wK84djG26QZ2MkW4rpb3IxbvO7gIGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UCszBJvPP0EiUayRjO5V/0eU5s5xoeM5xzR95CBQZpkBsCS7Hei+8CP6RjBf6jrRHabnpUs8aKl+OFj456wJ/quJhogbIybY4fktRHQXdo6ZnX4Z6ZBpcC9/I+p+ZuGZjDbZaOJToY0XQ063QcY+gH71HWKxjiKubLW9g6U2WrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tz0J7xAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F47C32782;
	Mon,  5 Aug 2024 17:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722880659;
	bh=Z2Wnr6wo32Vo1wK84djG26QZ2MkW4rpb3IxbvO7gIGY=;
	h=From:To:Cc:Subject:Date:From;
	b=tz0J7xAUuz84HslYf1b1UuNRP7fGUZCP9rSSeZiclS2QSxRtIRddhU1Rszsj35oBH
	 FO7TSbJrw6YYLyuNxC0D33cV8RdoiZ0sgeWFACQtwX5mYTVjH0RpK9uQZt5HQqA3hn
	 TmO3bQ7wSfQ8z79f/bacdBbBwlzyGR14aQ452cgSY58tT8X21KJtAbOLefopez9gg9
	 K20aCsledewH/m8M4ajBxn4dMRDrxrIX9uGx2li4b8gugqV9I45U3sK4vu1EQRhhwb
	 zFqMRzFEadTyxXAne68ilx0VW2NOwuhVdrRKH88XSV22+REAbEzaXgRSvTy3lshH8z
	 GrTdxhglOFNFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Yudong Wang <yudong.wang@intel.com>, Maarten@web.codeaurora.org,
	Lankhorst@web.codeaurora.org, maarten.lankhorst@linux.intel.com,
	Sasha Levin <sashal@kernel.org>, mripard@kernel.org,
	airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 01/15] drm/fb-helper: Don't schedule_work() to flush frame buffer during panic()
Date: Mon,  5 Aug 2024 13:56:58 -0400
Message-ID: <20240805175736.3252615-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.44
Content-Transfer-Encoding: 8bit

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

[ Upstream commit 833cd3e9ad8360785b6c23c82dd3856df00732d9 ]

Sometimes the system [1] hangs on x86 I/O machine checks. However, the
expected behavior is to reboot the system, as the machine check handler
ultimately triggers a panic(), initiating a reboot in the last step.

The root cause is that sometimes the panic() is blocked when
drm_fb_helper_damage() invoking schedule_work() to flush the frame buffer.
This occurs during the process of flushing all messages to the frame
buffer driver as shown in the following call trace:

  Machine check occurs [2]:
    panic()
      console_flush_on_panic()
        console_flush_all()
          console_emit_next_record()
            con->write()
              vt_console_print()
                hide_cursor()
                  vc->vc_sw->con_cursor()
                    fbcon_cursor()
                      ops->cursor()
                        bit_cursor()
                          soft_cursor()
                            info->fbops->fb_imageblit()
                              drm_fbdev_generic_defio_imageblit()
                                drm_fb_helper_damage_area()
                                  drm_fb_helper_damage()
                                    schedule_work() // <--- blocked here
    ...
    emergency_restart()  // wasn't invoked, so no reboot.

During panic(), except the panic CPU, all the other CPUs are stopped.
In schedule_work(), the panic CPU requires the lock of worker_pool to
queue the work on that pool, while the lock may have been token by some
other stopped CPU. So schedule_work() is blocked.

Additionally, during a panic(), since there is no opportunity to execute
any scheduled work, it's safe to fix this issue by skipping schedule_work()
on 'oops_in_progress' in drm_fb_helper_damage().

[1] Enable the kernel option CONFIG_FRAMEBUFFER_CONSOLE,
    CONFIG_DRM_FBDEV_EMULATION, and boot with the 'console=tty0'
    kernel command line parameter.

[2] Set 'panic_timeout' to a non-zero value before calling panic().

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Reported-by: Yudong Wang <yudong.wang@intel.com>
Tested-by: Yudong Wang <yudong.wang@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240703141737.75378-1-qiuxu.zhuo@intel.com
Signed-off-by: Maarten Lankhorst,,, <maarten.lankhorst@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_fb_helper.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 117237d3528bd..618b045230336 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -631,6 +631,17 @@ static void drm_fb_helper_add_damage_clip(struct drm_fb_helper *helper, u32 x, u
 static void drm_fb_helper_damage(struct drm_fb_helper *helper, u32 x, u32 y,
 				 u32 width, u32 height)
 {
+	/*
+	 * This function may be invoked by panic() to flush the frame
+	 * buffer, where all CPUs except the panic CPU are stopped.
+	 * During the following schedule_work(), the panic CPU needs
+	 * the worker_pool lock, which might be held by a stopped CPU,
+	 * causing schedule_work() and panic() to block. Return early on
+	 * oops_in_progress to prevent this blocking.
+	 */
+	if (oops_in_progress)
+		return;
+
 	drm_fb_helper_add_damage_clip(helper, x, y, width, height);
 
 	schedule_work(&helper->damage_work);
-- 
2.43.0


