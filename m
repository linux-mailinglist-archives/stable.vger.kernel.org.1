Return-Path: <stable+bounces-15996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5825483E64B
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4380B2401D
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A57455E66;
	Fri, 26 Jan 2024 23:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZzeJ+ECw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B07F23751
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310715; cv=none; b=uyfi7SlaEJ31hUMH2a/046iVnnLQsJTJ59ekQzjYAgyau0uA0ULZYFpLMSh1WzzmaphT5bKOX1mQ9gg6r1JpO8cr62iQT0Uqr/d5gX3Aq467SogCBMmaNx2I8RXDSiEoqta6KPC7iA+WpLnrQ4Gdj5rrEsJU4MI/2W/Cb/fmZRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310715; c=relaxed/simple;
	bh=DimlLayfpU0uqRaJeVs156mZ0JZ86n6Vp9Zhew1HpY0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=B1O3rGBCL71aIHs+rcyOLVdOYF0K2uDygzb36w1ZnE6YNcHjOCNdyn/mSloJfE0sUv+px+ki4aWHKAjFdtA21tkX3x/ZZgkQNdnmkDTd9y+BGeR0GzcgeBoN8rCN291wGSVUhj8qf5vPc9wiy/ioJsP9yxslaSlyScdyxQ7/MpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZzeJ+ECw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB3EC433C7;
	Fri, 26 Jan 2024 23:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706310714;
	bh=DimlLayfpU0uqRaJeVs156mZ0JZ86n6Vp9Zhew1HpY0=;
	h=Subject:To:Cc:From:Date:From;
	b=ZzeJ+ECwJ67GYCnk3TVVS32ELL4nbgYZNBM02R+bEwa+Gn0P5jMfu4PFf+lK5sE5I
	 L700ulinU3FuOp5Z6ht5OFbD2eP9KL1L5zGUM+wJgMDm7yrzMZzj6LK5rNdRq41qgL
	 POO335MxLvxqYxCLTN5a3lPR2P8n6EiD2N/YELSg=
Subject: FAILED: patch "[PATCH] media: mtk-jpeg: Fix use after free bug due to error path" failed to apply to 5.15-stable tree
To: zyytlz.wz@163.com,dmitry.osipenko@collabora.com,hverkuil-cisco@xs4all.nl,mchehab@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 15:11:53 -0800
Message-ID: <2024012653-marital-palpitate-7d96@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 206c857dd17d4d026de85866f1b5f0969f2a109e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012653-marital-palpitate-7d96@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

206c857dd17d ("media: mtk-jpeg: Fix use after free bug due to error path handling in mtk_jpeg_dec_device_run")

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


