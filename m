Return-Path: <stable+bounces-185524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E48BD6957
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 00:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E804055EE
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 22:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429922E2DFE;
	Mon, 13 Oct 2025 22:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBM/O+a5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5941547D2
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 22:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760393509; cv=none; b=eEVhaO7kaQ7M9sm6zgy0r1/TPALoAzEbl3/TKPDt4dLfpKwmdPmW5TkMOgx3rWFUnM/bQkupbKWy7wjLLNpkfWcTpGsFomQIhduDsJjrGd9xUBrnHDSoWcSSX7O3kKUUBU1JkM3V//+Mmh4vIpsRD9Ij/zARptiIdiN2QOhmk0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760393509; c=relaxed/simple;
	bh=ShhdSaGSPMNfnPp3gSG2zgEceWBo5dCeSWYJUwCaGUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZnMaY/KKyQbcqvwOW8Sy3VSnnCy5WqDCSQ9BP9whx+kN8tdVDNGRQVW68ALRAPqOrB/VKKB7C10nJyZhYAUxpqJFUg4b2XfCfGoxs3OqROE1ekmrzMqxlHhHtRuEJ1tyu1sRC+nHenJNUqNEHsMZ2JTvurBZZFgDZYFFvMXKvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBM/O+a5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E86FC4CEE7;
	Mon, 13 Oct 2025 22:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760393507;
	bh=ShhdSaGSPMNfnPp3gSG2zgEceWBo5dCeSWYJUwCaGUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uBM/O+a5MbltQxcdbN1vqwGi039aV2hsEogIx9JY9mtNViBfRbzsgUfSTqEn9evxu
	 xMwtrKZZg88TrQ2nZMo8OUtrL/Kb0gRu8Sw5S9rXrAzjvEZOqRJ14kEjWgMlwfV7m1
	 arMo9H8+Ys82L/SQHrmACtC5LJ1S1jOBBXesruEVjIwa09aI4tYhciLnmWs+I3vtik
	 0+Y4lO0D/8SkFGme3oUgJQw1y02xuD1Aa1Dgl9ZZf/d2StQX2KtkMNa+o5uruQ57sL
	 8h2WQdgdDD6dU+8q1PVfOE8YzQoJ3EmYiZd36eafODnr1YaUrTgKc+ZZYy+qttYu6a
	 DDkrfei37baVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+031d0cfd7c362817963f@syzkaller.appspotmail.com,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] media: mc: Clear minor number before put device
Date: Mon, 13 Oct 2025 18:11:45 -0400
Message-ID: <20251013221145.3655607-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101338-exalted-uncorrupt-96aa@gregkh>
References: <2025101338-exalted-uncorrupt-96aa@gregkh>
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


