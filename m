Return-Path: <stable+bounces-149275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEEDACB20D
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC6F194066E
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FC02459DC;
	Mon,  2 Jun 2025 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KO+1mIyQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73742459D8;
	Mon,  2 Jun 2025 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873462; cv=none; b=Xvsu4FY2J250Vn3thkMQ+b79pyy0mDvppmcXQT3eEp1hoG1mWLk2LuHPtLiPD/1WT01qs5xxC5n4GTCyfK0hvlAJt+KIw6i5MXLn89xYHofaS8iAM9dangs184AU36JfY3HVMWeF3L+4B22SIHzx5dUdd6sE+1v8jXc1qnqt4hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873462; c=relaxed/simple;
	bh=QPZy5nH69QC5j960c7RR5mqg665mSEYeh7k0XhNXHm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knW4SDHjSO0kOLVvKLMH08Q+N1YlGfOsbhkAlMU5GUJ4YB5O1NnrsE6n0/wLyvMZgAnrHzD8WJELJFLb75PViaXx8eQrDV2N1qJaV2vOYLRztOg7K5bfBIb+gNT3r7cNw7rnmKW6gH8Mj4bj0PxeYXz8v73EPsDJYI8Qd2whl44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KO+1mIyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D6AC4CEEB;
	Mon,  2 Jun 2025 14:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748873462;
	bh=QPZy5nH69QC5j960c7RR5mqg665mSEYeh7k0XhNXHm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KO+1mIyQIKj9z81avMnuDJBMwNtWbmnsooajxQsLfl9T7g2VDQDzXCT+FxBfLwNYY
	 lIAtjb9r74+T5WnRItwEnu9m34evQsrnQ9xX6lhyxC0qHZBcBCz5CrLB3wQciD6EaU
	 d8QBou9pqAY8Evy+z3Kg4aO75DIk4nfkZ+0za8L0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 149/444] media: cx231xx: set device_caps for 417
Date: Mon,  2 Jun 2025 15:43:33 +0200
Message-ID: <20250602134346.955637273@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
References: <20250602134340.906731340@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil@xs4all.nl>

[ Upstream commit a79efc44b51432490538a55b9753a721f7d3ea42 ]

The video_device for the MPEG encoder did not set device_caps.

Add this, otherwise the video device can't be registered (you get a
WARN_ON instead).

Not seen before since currently 417 support is disabled, but I found
this while experimenting with it.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/cx231xx/cx231xx-417.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/usb/cx231xx/cx231xx-417.c b/drivers/media/usb/cx231xx/cx231xx-417.c
index c5e21785fafe2..02343e88cc618 100644
--- a/drivers/media/usb/cx231xx/cx231xx-417.c
+++ b/drivers/media/usb/cx231xx/cx231xx-417.c
@@ -1722,6 +1722,8 @@ static void cx231xx_video_dev_init(
 	vfd->lock = &dev->lock;
 	vfd->release = video_device_release_empty;
 	vfd->ctrl_handler = &dev->mpeg_ctrl_handler.hdl;
+	vfd->device_caps = V4L2_CAP_READWRITE | V4L2_CAP_STREAMING |
+			   V4L2_CAP_VIDEO_CAPTURE;
 	video_set_drvdata(vfd, dev);
 	if (dev->tuner_type == TUNER_ABSENT) {
 		v4l2_disable_ioctl(vfd, VIDIOC_G_FREQUENCY);
-- 
2.39.5




