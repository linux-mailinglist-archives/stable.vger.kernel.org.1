Return-Path: <stable+bounces-187719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC57BEBFB8
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 01:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D327F350C40
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 23:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3B324886E;
	Fri, 17 Oct 2025 23:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oC6RKkGO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D92C354AE7
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 23:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760743107; cv=none; b=uUkYctC1tKQpzArP6n1G5FGIzepzunW0u7SNgBWXO2DL/jExh/LNtHuy/YnAgqWk+6HPrtOpIyLiJGSRr9el/d9QVCfAyrR4qtvAs9Od52Osi7hMLwKeMpRsyNynITwPJggiXWA7EBUqFyQw1L3xXuSEP9iodxBthbqBpNRDSWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760743107; c=relaxed/simple;
	bh=4/xejeDPFDxOJe9YK/VeObb0TOoOZch4hRWIHGmlCgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOQaAtUTgcq3CKtsvVAVWl1evogYSi4hJ+HVSQvn8G1LZ6uLKNUpRBj0Pd/AzF9Tyi6d3Inxi4I1TbZhd3roxGRPSgilQZL6HlaqtqRxAtdp8nRZM/UI4W5QN4wAM223LJFi4K8yd+Xh2bb18nRVWVSQzSFTqnN3n033FBD+jMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oC6RKkGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BCBC4CEF9;
	Fri, 17 Oct 2025 23:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760743106;
	bh=4/xejeDPFDxOJe9YK/VeObb0TOoOZch4hRWIHGmlCgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oC6RKkGOUM0SeztsbhVa7t67GcktPr6/RPnDccrHTM5n2B4MnVWIfiSv/74he0myB
	 bUiNBfF0VOqZPZwU2mj+st74nciID/++rixls5DOjA9ourcxInjSDNQgRNgAVEq3tg
	 yPHhNQ5oYeXAD2PuHPa2MACi760sqPnmlpfd25AEpUS0mXKX+PFtK+Q+5jwEEO4fyj
	 uEXbuhkGmyoX56YopbFohBlqlKZe0PfoCNlM7aFOhp2gANx+9Bw4JNpPfVwyz81nt8
	 iVzgSNnLFu9VXyJuLiFFYa3df8LaaBufZB1knTO9OyOWxqNmxXBja5PQ90UfUJWsMK
	 jTYxYjSVrwvJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ma Ke <make24@iscas.ac.cn>,
	Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] media: lirc: Fix error handling in lirc_register()
Date: Fri, 17 Oct 2025 19:18:23 -0400
Message-ID: <20251017231823.30098-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017231823.30098-1-sashal@kernel.org>
References: <2025101607-carrousel-blush-1a4d@gregkh>
 <20251017231823.30098-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ma Ke <make24@iscas.ac.cn>

[ Upstream commit 4f4098c57e139ad972154077fb45c3e3141555dd ]

When cdev_device_add() failed, calling put_device() to explicitly
release dev->lirc_dev. Otherwise, it could cause the fault of the
reference count.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: a6ddd4fecbb0 ("media: lirc: remove last remnants of lirc kapi")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/lirc_dev.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/media/rc/lirc_dev.c b/drivers/media/rc/lirc_dev.c
index 3131b3d7a6719..ad9c75de5e989 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -747,11 +747,11 @@ int lirc_register(struct rc_dev *dev)
 
 	cdev_init(&dev->lirc_cdev, &lirc_fops);
 
+	get_device(&dev->dev);
+
 	err = cdev_device_add(&dev->lirc_cdev, &dev->lirc_dev);
 	if (err)
-		goto out_ida;
-
-	get_device(&dev->dev);
+		goto out_put_device;
 
 	switch (dev->driver_type) {
 	case RC_DRIVER_SCANCODE:
@@ -775,7 +775,8 @@ int lirc_register(struct rc_dev *dev)
 
 	return 0;
 
-out_ida:
+out_put_device:
+	put_device(&dev->lirc_dev);
 	ida_free(&lirc_ida, minor);
 	return err;
 }
-- 
2.51.0


