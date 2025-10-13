Return-Path: <stable+bounces-185529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A53FABD6A54
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 00:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F2918A52FC
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 22:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85058308F28;
	Mon, 13 Oct 2025 22:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDSLBOG9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432DF158DA3
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760394982; cv=none; b=tSFt/mvlvUPYB5soSMiLhCM0MAiDZotSxVKAVXlEX7kUkKRGWk5P/pq68NpKyY0FKNI6v5I0oTt3Ocze85mcJOkm3Hr/RCjjrwD81jTumICG5lakvrr1SSICw0BYw9zuef9ytg07EXO85grBf8V7XEmA85YEhmZidM0lFyDxOl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760394982; c=relaxed/simple;
	bh=SPnlhZFfWC1tysTb7iIRRnyH45rfFqRinc4g0EKEJJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4lJWU0h8uArbDn6AZt39wBvTUfzZmiGoloRBKAlSsFouFCgQwtp9Bx/NyqXNN2Ad45INL5y/1W8eeI6E4rAXWpw9NBS2Ub/zYzN570XTvwaLmg4v4VV4mYOBjOnq18jidGMAfASWlq3ChxqZifJJqWYqP3Zwy3NmECjs7wlehI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDSLBOG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7984C4CEE7;
	Mon, 13 Oct 2025 22:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760394981;
	bh=SPnlhZFfWC1tysTb7iIRRnyH45rfFqRinc4g0EKEJJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jDSLBOG9TncOQ/gM287D3np9QtSxT2UDQigkwTVHVgneqr0xK+BgkZS2kHop7eLXB
	 MuwuVHM8NfQJPoUDTS99fj32KR0i+jvOAoejIFbjzbkZxkmMssontt4Vi7RMIPNnth
	 tLwegU/svxxgNn6eYKTeEwcHBdzj8ofPEI9xb7TltVFNMiV+rdTuDrqJffYFY9doO7
	 8mWKvI7kNBbqgFnAEA0WoMNaTCrnM/ODJjXJy9uQFJWpDqysbcHvbolVvYQGRe27Tl
	 jo+/9+46z70dKKrb7bdWaO5+VF//7Um1Wq9d/Qxc20FS8Zz6Y76JbXqMpUEc1PFp5b
	 vC9CmprrnVRaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+031d0cfd7c362817963f@syzkaller.appspotmail.com,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] media: mc: Clear minor number before put device
Date: Mon, 13 Oct 2025 18:36:18 -0400
Message-ID: <20251013223618.3673050-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101339-polygraph-crept-0130@gregkh>
References: <2025101339-polygraph-crept-0130@gregkh>
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


