Return-Path: <stable+bounces-187336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B720BEA272
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B24F19A0396
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C5B330B36;
	Fri, 17 Oct 2025 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qt0ocJwP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B63330B39
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715788; cv=none; b=u0vIp7H0bUB26sjRz4w5OlFPOCdZc9cGPKRnIc0qECCcioK0YPcwwb/l9YGzUzaLj1kjVjKaQd6WF87fv13QVAJPF79UhH2XRBhp/KR8oBGRLQi1ZP61G5cbB2bvgYI6neI6K+cgZT79pFkTrnS8zrkEQuAi7PmrW/J1GfwG+ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715788; c=relaxed/simple;
	bh=Yc6ORmek1fsZsaaUN6DgJv9ZOBsBiLCDfzUoQww71us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRlqU7j00gklOhxBBItw7ZgkE7VnWc/CfoewKsbcqJQV5BSMZWSYTqQqoy08pXr9XWF9fsw1pf3wo5qWfzb2iwMVgwa5o+yzL5g5IfsQ7/nAMC8EqHki8KY6TDTtf8qgLYLso8efEgxBnkAibhR79Hn6UrJpaahwWqUP6ARtsMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qt0ocJwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9E3C113D0;
	Fri, 17 Oct 2025 15:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760715787;
	bh=Yc6ORmek1fsZsaaUN6DgJv9ZOBsBiLCDfzUoQww71us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qt0ocJwPEYQunWnEo+Rx8nCE27pBxjBoFCVTBQtek1oAuaucgBzg6DzUgfPyIccKG
	 a+XHKt7ldfiylkD+pcOOAZ8XrbaTQcdsg5ugdUW0DOSu1iukPXT3MCa0WRl3lgSi0E
	 ZkYZdfxLNqAQCDO5D6U1s2tQ8LHkH7VLk61eP6EQFcx35YVuvP/JDtNWQ43FTm4s7m
	 L1Q479/1Kx3Ty+VFeEyT36wDy9YdZXOWd+YxNaNufrFLk1kQpmttvK3QpzwhMU/dan
	 ofMIG+wwCKUCeJ4kgXP8VgPuoSuVbfV7JTgo8pDI6chBVY1yFj+K5kIhE27CK/F6Rw
	 F/ACYPDx9fSZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ma Ke <make24@iscas.ac.cn>,
	Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] media: lirc: Fix error handling in lirc_register()
Date: Fri, 17 Oct 2025 11:43:04 -0400
Message-ID: <20251017154304.4038374-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017154304.4038374-1-sashal@kernel.org>
References: <2025101607-boring-luminance-9766@gregkh>
 <20251017154304.4038374-1-sashal@kernel.org>
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
index 37933c5af5f72..2920327fad6ee 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -748,11 +748,11 @@ int lirc_register(struct rc_dev *dev)
 
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
@@ -776,7 +776,8 @@ int lirc_register(struct rc_dev *dev)
 
 	return 0;
 
-out_ida:
+out_put_device:
+	put_device(&dev->lirc_dev);
 	ida_free(&lirc_ida, minor);
 	return err;
 }
-- 
2.51.0


