Return-Path: <stable+bounces-15998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDB883E64E
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 667E9B24113
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4891F56779;
	Fri, 26 Jan 2024 23:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1yKshGLZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0968B5677D
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310718; cv=none; b=P9XqVs+zzLR74JNzPBTqVbd5mjHpCt7+vy8+pCkakCAnox4JLy3kbVsCxEBYt4GZo/E2NCtxQCQM4VEWeDiVsWcTwedtNV2qBk/hrlujTNjbpWEecv4VF2vk6yHAVxiQBOl+4Hji7GEehZiqaiJ2qmGr/IbJNqx5EK5cFDHcRuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310718; c=relaxed/simple;
	bh=KL9wRhlnbgxXWAa1ugYXT+6j8nDN+wclJibSQU0L1iA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AmZpqxfqu1nsDzHjEXXh5nbnBVuN1KkpBixhyr56sc5BsRoIQ/j+8YIA19M6YB61kNWS1/5FpnfUQI3Z7S4SkWmP2le6+BdzSheBJSqzs6JOLzBy1H5oVRvVHgfm0CVt7OiToDiMxtyj4vSj2TCIAZk4YZu5fWb1uUzAVph+fCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1yKshGLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFE7C433F1;
	Fri, 26 Jan 2024 23:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706310717;
	bh=KL9wRhlnbgxXWAa1ugYXT+6j8nDN+wclJibSQU0L1iA=;
	h=Subject:To:Cc:From:Date:From;
	b=1yKshGLZLsHowifaNyhGsaWUjCM4aPM7tRqyJPdnKXSTvQwvpzftQeAeO9iEh/0RE
	 WBz4kY7u98e6EOrV6TyVXpyE3v/nF8MSBjNELiNIncrD9Oo6ro7V6G5fOVuZlPTeBJ
	 DAFs8CyM7JGPadCUrBZ9wHndMlZIlSBNk0q4VHVo=
Subject: FAILED: patch "[PATCH] media: mtk-jpeg: Fix use after free bug due to error path" failed to apply to 5.4-stable tree
To: zyytlz.wz@163.com,dmitry.osipenko@collabora.com,hverkuil-cisco@xs4all.nl,mchehab@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 15:11:56 -0800
Message-ID: <2024012656-unaligned-conductor-4ef5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 206c857dd17d4d026de85866f1b5f0969f2a109e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012656-unaligned-conductor-4ef5@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

206c857dd17d ("media: mtk-jpeg: Fix use after free bug due to error path handling in mtk_jpeg_dec_device_run")
2023a9981111 ("media: platform: rename mediatek/mtk-jpeg/ to mediatek/jpeg/")
63fe3d27b226 ("media: platform/*/Kconfig: make manufacturer menus more uniform")
f2ab6d3e8c48 ("media: platform: Create vendor/{Makefile,Kconfig} files")
8148baabd1c4 ("media: platform: re-structure TI drivers")
012e3ca3cb4d ("media: platform: rename omap/ to ti/omap/")
ceafdaac46ea ("media: platform: rename omap3isp/ to ti/omap3isp/")
d24a170bde65 ("media: platform: rename davinci/ to ti/davinci/")
407965e2348e ("media: platform: rename am437x/ to ti/am437x/")
e7b8153e2a4f ("media: platform: place stm32/ and sti/ under st/ dir")
43ecec16c4fa ("media: platform: rename s5p-mfc/ to samsung/s5p-mfc/")
f4104b7851a8 ("media: platform: rename s5p-jpeg/ to samsung/s5p-jpeg/")
a7f3b2d32dab ("media: platform: rename s5p-g2d/ to samsung/s5p-g2d/")
c1024049033f ("media: platform: rename s3c-camif/ to samsung/s3c-camif/")
3bae07d4b44c ("media: platform: rename exynos-gsc/ to samsung/exynos-gsc/")
238c84f71120 ("media: platform: rename exynos4-is/ to samsung/exynos4-is/")
9b18ef7c9ff4 ("media: platform: rename tegra/vde/ to nvidia/tegra-vde/")
574476a7d05d ("media: platform: rename mtk-vpu/ to mediatek/mtk-vpu/")
728dc4075acc ("media: platform: rename mtk-vcodec/ to mediatek/mtk-vcodec/")
1cb72963fa1e ("media: platform: rename mtk-mdp/ to mediatek/mtk-mdp/")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 206c857dd17d4d026de85866f1b5f0969f2a109e Mon Sep 17 00:00:00 2001
From: Zheng Wang <zyytlz.wz@163.com>
Date: Mon, 6 Nov 2023 15:48:10 +0100
Subject: [PATCH] media: mtk-jpeg: Fix use after free bug due to error path
 handling in mtk_jpeg_dec_device_run

In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
mtk_jpeg_job_timeout_work.

In mtk_jpeg_dec_device_run, if error happens in
mtk_jpeg_set_dec_dst, it will finally start the worker while
mark the job as finished by invoking v4l2_m2m_job_finish.

There are two methods to trigger the bug. If we remove the
module, it which will call mtk_jpeg_remove to make cleanup.
The possible sequence is as follows, which will cause a
use-after-free bug.

CPU0                  CPU1
mtk_jpeg_dec_...    |
  start worker	    |
                    |mtk_jpeg_job_timeout_work
mtk_jpeg_remove     |
  v4l2_m2m_release  |
    kfree(m2m_dev); |
                    |
                    | v4l2_m2m_get_curr_priv
                    |   m2m_dev->curr_ctx //use

If we close the file descriptor, which will call mtk_jpeg_release,
it will have a similar sequence.

Fix this bug by starting timeout worker only if started jpegdec worker
successfully. Then v4l2_m2m_job_finish will only be called in
either mtk_jpeg_job_timeout_work or mtk_jpeg_dec_device_run.

Fixes: b2f0d2724ba4 ("[media] vcodec: mediatek: Add Mediatek JPEG Decoder Driver")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index 7c2e6a2f6c40..63165f05e123 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1020,13 +1020,13 @@ static void mtk_jpeg_dec_device_run(void *priv)
 	if (ret < 0)
 		goto dec_end;
 
-	schedule_delayed_work(&jpeg->job_timeout_work,
-			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
-
 	mtk_jpeg_set_dec_src(ctx, &src_buf->vb2_buf, &bs);
 	if (mtk_jpeg_set_dec_dst(ctx, &jpeg_src_buf->dec_param, &dst_buf->vb2_buf, &fb))
 		goto dec_end;
 
+	schedule_delayed_work(&jpeg->job_timeout_work,
+			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
+
 	spin_lock_irqsave(&jpeg->hw_lock, flags);
 	mtk_jpeg_dec_reset(jpeg->reg_base);
 	mtk_jpeg_dec_set_config(jpeg->reg_base,


