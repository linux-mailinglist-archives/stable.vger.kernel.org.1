Return-Path: <stable+bounces-187726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E685FBEC006
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 01:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A63365E574A
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 23:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F79629BDA5;
	Fri, 17 Oct 2025 23:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiF+ckFL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC8C2641FB
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 23:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760743921; cv=none; b=dNoGv/0s6sIN3cRaSL1b7f9dzfMaVFHpGHBHZaaSgmzSkFCHuJ+Ta/60wE2FtXw9PJ4Z438d8VYr/lEpVV8vLF4ARsxCVe+1RuYslC32cHPvE+aPzYUhX4iWufx6XuCZHItzwd8WIC9SeJHrGPzMpty+sMy05yVPy5YBjv0gSBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760743921; c=relaxed/simple;
	bh=YVcaBXgH0z0P2XkVt48lJ9ANwjRJqawyY/126E9b+R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1jR+1jT425mr/EH0gylrBbw93wpplR9Ve5xNeejaJquXwn05rFwJkelYt9YJ/YXITzHGjskGw2qBpyposWVdWk9jCBu72is9pGZdvpJZnV5lDIq0rdx+QmM0JdnDjvXABV9/qYK2ZLyycFHQjP3tRv+mGzhZNUe86M0qvnX6nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiF+ckFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E736C113D0;
	Fri, 17 Oct 2025 23:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760743920;
	bh=YVcaBXgH0z0P2XkVt48lJ9ANwjRJqawyY/126E9b+R8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TiF+ckFLLO1bpkTtZCD1Rw1J/KlMHT1M1XqJ+bHFMOQyFd72m00C9RNK5aN7ERyPi
	 IghrARFNnP3EotG1uiRaXhnwe9jZrByHxxD10Dza7LJ+rWtUabv4I67el0Pwp6fNNf
	 yPNGiLfyaVUUR6c+4zLkBKi13OHR9gqakIOdfg/DqhPcdFxq95zG0y5ztcs4B6TMEj
	 +ic+B00d0c95UAHcGgci8fnAYHKNnRwVp91ranNgeCqUVlAnNHAr1q8g83o9ZkDvMy
	 tEzRUzz1tFTE+A57T2dnMAbY0532kqOW/qMsuH2DY28CX7q0FoT7pFkyrRJ9eQlt2C
	 lY35eA1Xa13Ug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ma Ke <make24@iscas.ac.cn>,
	Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 2/2] media: lirc: Fix error handling in lirc_register()
Date: Fri, 17 Oct 2025 19:31:51 -0400
Message-ID: <20251017233151.37969-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017233151.37969-1-sashal@kernel.org>
References: <2025101607-contend-gentleman-9ae0@gregkh>
 <20251017233151.37969-1-sashal@kernel.org>
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
index 9c9eac2e1182f..aeff7d7155fdf 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -762,11 +762,11 @@ int ir_lirc_register(struct rc_dev *dev)
 
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
@@ -790,7 +790,8 @@ int ir_lirc_register(struct rc_dev *dev)
 
 	return 0;
 
-out_ida:
+out_put_device:
+	put_device(&dev->lirc_dev);
 	ida_free(&lirc_ida, minor);
 	return err;
 }
-- 
2.51.0


