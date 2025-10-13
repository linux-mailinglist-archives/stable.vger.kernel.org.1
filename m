Return-Path: <stable+bounces-185534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E28E2BD6A87
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 00:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B0254E48AB
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 22:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6858E1FDA89;
	Mon, 13 Oct 2025 22:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RynMLT3V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260D22AD1F
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 22:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760395668; cv=none; b=E6gbwnzlcVyWb3n7DLZZJaKjYRinNiwqKJ6ZyaEcqR7pgFYbj5znnMueehJ62kbSMPkZgJ+k/GAVeRjFF5vXLwo7LA5CpVyc60j1Ze94CU0HZn5dt/ixLDdXx2UmIRVuIsyojAH/bmmle4aZyqZn/2YD72yerjd6ZH537CNo4Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760395668; c=relaxed/simple;
	bh=SPnlhZFfWC1tysTb7iIRRnyH45rfFqRinc4g0EKEJJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKGbD6PmVm52go0G1Hk+kM7oQyRsuJb6RI2IpLX3jtG5J/mPnE5/b0U3/uU2hVxylIoYscvkpFTqOXsUrvx6cNdA1BUGsIgnqa4PrUhuDn8JmRxMb2F5uk2sskO+OfeIicQm+LRT8iqiVe7LTX9qfeAM5kh+UKMfTgdE4ClNLAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RynMLT3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF37FC4CEE7;
	Mon, 13 Oct 2025 22:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760395667;
	bh=SPnlhZFfWC1tysTb7iIRRnyH45rfFqRinc4g0EKEJJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RynMLT3VwTG7F4BszQCrrxGzAK+czDY0PNXLKe9GPvCaEGHAvUOUL2E18sVM++NVG
	 RCUWQkLwbn21rbY5uhEDjB/gQgMNq4WI/olxGtoBwaj/hiHEpNkBVIUjM8+Bno5Slo
	 NZXLFd3/I5+B0N4sDxNAc+uyXGeYvrMm3LKOK0VGffSfPGSWfLOZQfSn7dKW9M4JD1
	 AimUhFXCpqPcxP/n36gdvLAz26QpC0VyVYzFikZbgO5i2qiKlrFtuSgatlumd0a1v1
	 HjJr+Jx+/7erhxj+BROndLOCRwUnf6w0OMl7xt8jyOLbrR3lXikHqM8lgdkpRK0XUV
	 G6PcOptpB5/PQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+031d0cfd7c362817963f@syzkaller.appspotmail.com,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] media: mc: Clear minor number before put device
Date: Mon, 13 Oct 2025 18:47:44 -0400
Message-ID: <20251013224744.3682086-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101340-boned-upright-7693@gregkh>
References: <2025101340-boned-upright-7693@gregkh>
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


