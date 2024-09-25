Return-Path: <stable+bounces-77622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A876985F37
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10DF7286FAB
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B873220FC7;
	Wed, 25 Sep 2024 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhWWsFcN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEAC18C00F;
	Wed, 25 Sep 2024 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266503; cv=none; b=SOSEopX5DcpzylfLhMlQ2yWDBZicNRsUcc/UelI+TkqeW1aKZpLGJbpHoF0+6jx2eollzzNNVpcG/xqlHHQ9SfmI9yPYPVE6UScpYjhWxi9VaMAbB8nPU+nxh/EmzxTFSk1iuBHKuSeK7w9UYe274R4LoMgZGnZyTdRGOpH8mTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266503; c=relaxed/simple;
	bh=2uVuhDZDMUIshitsnapNSlE48Yb+JPuyFmI2qexGfsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QP1VgyMFS6kVD8PET+PPcutI9BsIBH1GLJ1fKzRaxPB3GUR3v/vMVtXBQjqL16DQKJVsSUSmMrlm6HwmHfxurlT9CE2Z/7zx6btuobsQVj8jYT6GpKORmDgsXemvh5/cTimc+wI4Fc0Pi51t2WAp3lpGaNWBRQoU5AjUQMoFGNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhWWsFcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CFDC4CECE;
	Wed, 25 Sep 2024 12:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266502;
	bh=2uVuhDZDMUIshitsnapNSlE48Yb+JPuyFmI2qexGfsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uhWWsFcN07UFXP4OTAewh7tPPqosRE79kii5OCNSiGmFqTJHCRKuy8MwScIDyIbzh
	 griEtU3Vbd+s4TFtst66pKtDtadaA8ZH2wveWuDinshUALd6wuYiTtDE7RDFcZlBab
	 E3B6TQDuUHNh98N31LJ8btDMZCcJpwMiiplhyb3w8UeBQH8++0GL+UOSJV4mWS9KJl
	 FdMkWSZZSPjINoS7sniAezch2r9BPiRP0sy0LWeXiOy1vic+GMiAbh9VZl/bENDG4Z
	 U1we6a/Q0ETJDb+giSA32JbIE9DI4N+Tyy8SnPotVrDjl5roIwTUUQJa9cOe+kA3zu
	 t2Uy/UT63EtOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kaixin Wang <kxwang23@m.fudan.edu.cn>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	kuninori.morimoto.gx@renesas.com,
	laurent.pinchart@ideasonboard.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 075/139] fbdev: pxafb: Fix possible use after free in pxafb_task()
Date: Wed, 25 Sep 2024 08:08:15 -0400
Message-ID: <20240925121137.1307574-75-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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
index fa943612c4e2b..3a2427eb29f23 100644
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


