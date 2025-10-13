Return-Path: <stable+bounces-185511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB13BD6127
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 22:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B2018A64CD
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 20:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748CA1DDA18;
	Mon, 13 Oct 2025 20:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UheskVKl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314C6259CBD
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 20:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387191; cv=none; b=cAh5Z8+g3PhZpRJCA8cSiVPaDKqf74zsoOIJ9PYaJeaYOoQYzKDmH8Ma4LYCpjBSvpDSXOmZKtrEYYDVptIRJjbcAEPU2LgDtVp4mCKeqygNb+L/WQeaHdEx2B/9xcyIW5mu9fu74XHjLXdECwOmJpdDT5zLdaJVof0Bmo18EVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387191; c=relaxed/simple;
	bh=WNjjmGmT7PdHmDo3SQCBs5u9toBH2jQnxzOaED9twOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txcbLFx+QOpjsCRuV/a7Mr/JQhuFaKR3uddorsUv47HkDMGaoD4giue4/faZyHPBoh2ZXr181rygIcxjqYbK+cv0OV1bbN4fnheGmD/ICNqax3ipGvWp77h/q82DAMgYFYaoHD1hm5g5VaGegllgtq70sdVYpUhydm4Q8tYFY4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UheskVKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66C8C4CEE7;
	Mon, 13 Oct 2025 20:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760387190;
	bh=WNjjmGmT7PdHmDo3SQCBs5u9toBH2jQnxzOaED9twOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UheskVKlna/rBFI6WBzkgKo4540m/ypJpsf57+/ScX/SRJDZE+KhNZLSiUpVFVsw0
	 V4vmBiHksf8OTFBw2Ac7M/4AdIlsTU3ZeBsRZv0SvfuNo13tq9+zEUb5N7LjNiiwG9
	 bzpt2Lghn68A4P8VGT5SvN9NAkP+A5fDdhICqa8ePVykIsy4ZhhrZHs8JE7U0LTWPD
	 z2rRWxDYGhEJYmbouru6fQ4pTLzFzX01bH4agQat7jQACLGC/c3frVbNby646n+Rkf
	 IceYmljbWyE6Uigy6lV0rL51f8NCL55MqpVRqxgJQmppKcqR2dA6G948/ypXCD+RM3
	 zE8VU9weUncdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+031d0cfd7c362817963f@syzkaller.appspotmail.com,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y] media: mc: Clear minor number before put device
Date: Mon, 13 Oct 2025 16:26:24 -0400
Message-ID: <20251013202625.3590659-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101335-script-feeble-03de@gregkh>
References: <2025101335-script-feeble-03de@gregkh>
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


