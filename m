Return-Path: <stable+bounces-185528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 974C9BD69A6
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 00:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DAEE4E17A1
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 22:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDE62F3620;
	Mon, 13 Oct 2025 22:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+4ZKzAT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DAB2FE04C
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760394108; cv=none; b=plbQPYrPU4gcS7wBmSaSGzLDZMXfqhdia2eKM3l9pM+q6LRinOVa5GuIjtgHr7ERX7Iu4hkMjSfSBQZbXE8jtyOyUQC5+rHYyzCqOjHpO1028bzEC+h09SKAxcwU794ET+nefKAMZFMDwCDmpaxY1w7UgtGATx+Gpa77SBcTPfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760394108; c=relaxed/simple;
	bh=SPnlhZFfWC1tysTb7iIRRnyH45rfFqRinc4g0EKEJJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kET9Xuy9GVXn7MoMYJQApwA11FeNG1onvRlf1vvkxdAt8iK9fJ/lGiYjQ8eO6rYsvJuPuEdacQIqiAYKO2cGNAr0wY9VHB2U6AWzh/uRgU29x2yv4BzmNQ+HGvEC57UZJRb4bA2Ovz1h36Mbp6QjIIrz21HsE/3AP3Ssi6jf6JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+4ZKzAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF155C4CEE7;
	Mon, 13 Oct 2025 22:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760394107;
	bh=SPnlhZFfWC1tysTb7iIRRnyH45rfFqRinc4g0EKEJJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l+4ZKzATChjj5TeCsV/nWpHrp4ucYc2/KbIDjx84N5zizfUcy98epC1fJXYumQLbB
	 p6IumNJs2RdjxctPNYRtfmmAzLen5Osom7QEl8p8/f8OzRgHkjpYQxpeCGg/dthAM0
	 QolNc01yq1eyNqK6sn0WaJid2+0Db8Ahm1K7E2xPZbG+dmpeMpUqLg+GrfPGVU4tZr
	 18j3TSO7v36CLZSMYUUL8y9Kfe8Nu4H1idI521MfDz1QW3D9UjNr/vkzRJ7H7EEbGP
	 nrLdTAnoT3OCLHomhVyrTJIEP30JL4GRPfS8zrJlTyqGpMGBt44TOH5BD6tK2YOdxp
	 oiCE9CIaLXdQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+031d0cfd7c362817963f@syzkaller.appspotmail.com,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] media: mc: Clear minor number before put device
Date: Mon, 13 Oct 2025 18:21:45 -0400
Message-ID: <20251013222145.3663624-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101338-swab-rut-c1d4@gregkh>
References: <2025101338-swab-rut-c1d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit 8cfc8cec1b4da88a47c243a11f384baefd092a50 ]

The device minor should not be cleared after the device is released.

Fixes: 9e14868dc952 ("media: mc: Clear minor number reservation at unregistration time")
Cc: stable@vger.kernel.org
Reported-by: syzbot+031d0cfd7c362817963f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=031d0cfd7c362817963f
Tested-by: syzbot+031d0cfd7c362817963f@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[ moved clear_bit from media_devnode_release callback to media_devnode_unregister before put_device ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/mc/mc-devnode.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/media/mc/mc-devnode.c b/drivers/media/mc/mc-devnode.c
index f249199dc616b..f8257aa5fc584 100644
--- a/drivers/media/mc/mc-devnode.c
+++ b/drivers/media/mc/mc-devnode.c
@@ -50,11 +50,6 @@ static void media_devnode_release(struct device *cd)
 {
 	struct media_devnode *devnode = to_media_devnode(cd);
 
-	mutex_lock(&media_devnode_lock);
-	/* Mark device node number as free */
-	clear_bit(devnode->minor, media_devnode_nums);
-	mutex_unlock(&media_devnode_lock);
-
 	/* Release media_devnode and perform other cleanups as needed. */
 	if (devnode->release)
 		devnode->release(devnode);
@@ -283,6 +278,7 @@ void media_devnode_unregister(struct media_devnode *devnode)
 	/* Delete the cdev on this minor as well */
 	cdev_device_del(&devnode->cdev, &devnode->dev);
 	devnode->media_dev = NULL;
+	clear_bit(devnode->minor, media_devnode_nums);
 	mutex_unlock(&media_devnode_lock);
 
 	put_device(&devnode->dev);
-- 
2.51.0


