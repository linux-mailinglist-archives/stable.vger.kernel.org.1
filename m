Return-Path: <stable+bounces-185518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FBBBD6659
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 23:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 325224E8879
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 21:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA68F2F1FC8;
	Mon, 13 Oct 2025 21:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNe3lx2g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1922E9EDF
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 21:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760391900; cv=none; b=Ta0vAc29OFcAHmpBCICmulSEm5XtDwSGRjnZcblMJf05vHtU1ndRuq+P4XGRCYLFP/6Hak46Cw2AbgFHVQVemFv9WX/8i3kAvEj/Hv/7YbAjbUs6Kwwm0fukJs0VVNCD3lBCtLdjajJs3sZLsFptq6UA5uoIO4bOBhwopdRJNM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760391900; c=relaxed/simple;
	bh=ShhdSaGSPMNfnPp3gSG2zgEceWBo5dCeSWYJUwCaGUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lk6UaOghooTzRd65SEBlOVQt4se+fAwhoiPN6omG4XVsYA7UR+3Kk5dMmBUtwqJK1VtTCyHsPyk6yyvlQbbwD8V+3pI48G91ikA5xlzq8vVVL/QmPceRN20cSLHrewtPJuZRUUZ6vGRkaAyKyb0xRWmN5XSds756zB70zonCKJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNe3lx2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CD6C4CEE7;
	Mon, 13 Oct 2025 21:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760391900;
	bh=ShhdSaGSPMNfnPp3gSG2zgEceWBo5dCeSWYJUwCaGUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cNe3lx2giH5ExqECy24tNC7yANsDcHo/agdE/td9R7M4DKYu8jhQTYoYf5qcQyy6g
	 O+zkzf2riqL+ykiSRyOVVJyRn7XvrSFVT4FjfAeGlSd4GU69YRs1c7e6w3QIlvtkvs
	 PQl6sJqoCACEllDotWFNx6IgrXA99g+zkAxxVHpN1EvqZYmnjbHHgE5Z2aMyIiP7HQ
	 Ebnk8Wj6mJRO4ZQNefzSr5qSr9d1s6LnAj8WljfRMqmty14NhLUJQSOj/LarfQZtLV
	 SJtqJToJKygx5+D/zZzMuFF1VEXL4kilmQE13vtsziHMqizBjHB/E7T768qlvatgwS
	 egtJel1jBsJZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+031d0cfd7c362817963f@syzkaller.appspotmail.com,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] media: mc: Clear minor number before put device
Date: Mon, 13 Oct 2025 17:44:57 -0400
Message-ID: <20251013214457.3636880-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101337-robust-deepness-48c6@gregkh>
References: <2025101337-robust-deepness-48c6@gregkh>
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
index 94abd042045da..6fd8885f5928e 100644
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


