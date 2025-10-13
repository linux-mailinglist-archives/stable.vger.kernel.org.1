Return-Path: <stable+bounces-185512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD54BD639D
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 22:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28D64035A7
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 20:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522CA30AD12;
	Mon, 13 Oct 2025 20:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XabJ6WGX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113FF30AAD7
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 20:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388078; cv=none; b=u5zRFref4XFXtlbw4xyZFWKrYMyEYz6wdZ01lqx7Gt6R2GFZqCIGb5gHaHmQUwUapKARRMtFfxNs7YIenIUGFC4EPnFvWAyWtECEOfzVc4zxUILY7vNTbq4kc9XYORHCfZ8VEi+LCxiwAdQ1CwKjD5JAIfK6GuOlRLdgkzba+jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388078; c=relaxed/simple;
	bh=WNjjmGmT7PdHmDo3SQCBs5u9toBH2jQnxzOaED9twOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAs3KNCQwH7kzBxG5RId8K7HEkRExz/aB5Aw+VbuzyUueavWaf4dhb6ttp2oPMOcwpZPz4DWtYl2dkB58mdqCKbk/DXlcOaeB7c6/3gWcTeV3iuV+pK2fPpsCRBIX5YiZ6jvLS9wuWy7xLW+MpM92V/yodkn36Xhsstvy/PqeBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XabJ6WGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25842C4CEE7;
	Mon, 13 Oct 2025 20:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760388077;
	bh=WNjjmGmT7PdHmDo3SQCBs5u9toBH2jQnxzOaED9twOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XabJ6WGXJ2LmTgqcvItUm9y/OJS0gL7ey54LFAKhWNlt5i5qQ1slsKQsNSK24/Ief
	 7WiGGIeynu9nNNX6YvsiVE2+D3AwtOlkodu5obUfN06sfnHBBwMAKIz06/hh5X++Rg
	 yJxeNOfeu47K74FX3X35UxI+UuCQkPuEqu82kgHAIq7FoQku6uv87E9P6XOwECa6M0
	 SM5IFrzEUy+PsuUUNpu5epeOUe3+XcoX2zardWg1Ue6jhdpyjGngitkDwxaCYPKnhd
	 Cg6dgd0VzVKMaR3Dad0g0mEeLM7cScJOdErdkTZHlzQkYkl2Hh4ZB3nWT1n/XLDsLO
	 B8i+wHbZ7WjwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+031d0cfd7c362817963f@syzkaller.appspotmail.com,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] media: mc: Clear minor number before put device
Date: Mon, 13 Oct 2025 16:41:15 -0400
Message-ID: <20251013204115.3599451-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101336-tannery-reverb-5975@gregkh>
References: <2025101336-tannery-reverb-5975@gregkh>
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
index 56444edaf1365..6daa7aa994422 100644
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
@@ -281,6 +276,7 @@ void media_devnode_unregister(struct media_devnode *devnode)
 	/* Delete the cdev on this minor as well */
 	cdev_device_del(&devnode->cdev, &devnode->dev);
 	devnode->media_dev = NULL;
+	clear_bit(devnode->minor, media_devnode_nums);
 	mutex_unlock(&media_devnode_lock);
 
 	put_device(&devnode->dev);
-- 
2.51.0


