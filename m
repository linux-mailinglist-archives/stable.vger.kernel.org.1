Return-Path: <stable+bounces-187718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C185BEBFB5
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 01:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8BA14E20F4
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 23:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C6413AD26;
	Fri, 17 Oct 2025 23:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrDHFU7Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527BE354AE7
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 23:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760743106; cv=none; b=K5FJ+ITC3MgMx7k+fZLRgQwr6VhZW3g4pWcAUEuzpYMje6UAfRFZgrKC9UrBblLyYACeYnj+0d1Io4j3jUCQMWZb9uYzOQJ3om5Q1EyUtMfqp+xbzgxMOBKZggCnhaCIaOU83E0UKLcMzAfuYU3yJCNuVFyFJoYm6pd1rqN7f1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760743106; c=relaxed/simple;
	bh=/OHjcILlmUKsHAIum5N50sbfQqEMj8BFlN0SV0o2HGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUA2iBqXxQV49BZIpQr1ut0wT2FXwA/snBOKO9C6YPlw6uTHVfAjuv0ugpLaB9BX6VQ1H2UjbhOJ0Fgp+/4yU3Jje93h7IFfuz/g0OsbJ4ff5Hhs1YRMQqaGJ5Z5BZAuvikd7zpqfPtZDUhUdFVyJNzmuK2w2KKR84ptx8riwrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrDHFU7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D42AC4CEE7;
	Fri, 17 Oct 2025 23:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760743105;
	bh=/OHjcILlmUKsHAIum5N50sbfQqEMj8BFlN0SV0o2HGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BrDHFU7ZUnwFCW8tz71YkYWdhB2hdPCmj2VDnynAdYfqFlfrT4sLd9vXRPwaYHgNR
	 5LwDJMMt8sNmckwcxsPW1R49/yChpBjElkY1CNQWzBF+XHj71HujWaAzhHCQhPm78b
	 KGSmUKdtjMrH6T554EoqAgD6nr3qd5HNYYj4BJIkRhhnV/f4maYTDsJ/x6TXIvOGKj
	 W6uiA1hRP9IOf4heEm4uZdsqpFcLqGEhgkf93FtGnH7RtqOazoCg/2MjMqu7f6K7JT
	 cbUl6cj2e0Y8s8HLZnNE93xy50Gt5A/Tres0u5oJkdnPYgXXOgP/vQG16iNrYk3eKH
	 c9XOoTVV6hr8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: keliu <liuke94@huawei.com>,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] media: rc: Directly use ida_free()
Date: Fri, 17 Oct 2025 19:18:22 -0400
Message-ID: <20251017231823.30098-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101607-carrousel-blush-1a4d@gregkh>
References: <2025101607-carrousel-blush-1a4d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: keliu <liuke94@huawei.com>

[ Upstream commit cd54ff938091d890edf78e6555ec30c63dcd2eb5 ]

Use ida_alloc() and ida_free() instead of the deprecated
ida_simple_get() and ida_simple_remove().

Signed-off-by: keliu <liuke94@huawei.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Stable-dep-of: 4f4098c57e13 ("media: lirc: Fix error handling in lirc_register()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/lirc_dev.c | 6 +++---
 drivers/media/rc/rc-main.c  | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/rc/lirc_dev.c b/drivers/media/rc/lirc_dev.c
index c59601487334c..3131b3d7a6719 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -731,7 +731,7 @@ int lirc_register(struct rc_dev *dev)
 	const char *rx_type, *tx_type;
 	int err, minor;
 
-	minor = ida_simple_get(&lirc_ida, 0, RC_DEV_MAX, GFP_KERNEL);
+	minor = ida_alloc_max(&lirc_ida, RC_DEV_MAX - 1, GFP_KERNEL);
 	if (minor < 0)
 		return minor;
 
@@ -776,7 +776,7 @@ int lirc_register(struct rc_dev *dev)
 	return 0;
 
 out_ida:
-	ida_simple_remove(&lirc_ida, minor);
+	ida_free(&lirc_ida, minor);
 	return err;
 }
 
@@ -794,7 +794,7 @@ void lirc_unregister(struct rc_dev *dev)
 	spin_unlock_irqrestore(&dev->lirc_fh_lock, flags);
 
 	cdev_device_del(&dev->lirc_cdev, &dev->lirc_dev);
-	ida_simple_remove(&lirc_ida, MINOR(dev->lirc_dev.devt));
+	ida_free(&lirc_ida, MINOR(dev->lirc_dev.devt));
 }
 
 int __init lirc_dev_init(void)
diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index 8e88dc8ea6c5e..169a0b632a616 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -1897,7 +1897,7 @@ int rc_register_device(struct rc_dev *dev)
 	if (!dev)
 		return -EINVAL;
 
-	minor = ida_simple_get(&rc_ida, 0, RC_DEV_MAX, GFP_KERNEL);
+	minor = ida_alloc_max(&rc_ida, RC_DEV_MAX - 1, GFP_KERNEL);
 	if (minor < 0)
 		return minor;
 
@@ -1980,7 +1980,7 @@ int rc_register_device(struct rc_dev *dev)
 out_raw:
 	ir_raw_event_free(dev);
 out_minor:
-	ida_simple_remove(&rc_ida, minor);
+	ida_free(&rc_ida, minor);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(rc_register_device);
@@ -2040,7 +2040,7 @@ void rc_unregister_device(struct rc_dev *dev)
 
 	device_del(&dev->dev);
 
-	ida_simple_remove(&rc_ida, dev->minor);
+	ida_free(&rc_ida, dev->minor);
 
 	if (!dev->managed_alloc)
 		rc_free_device(dev);
-- 
2.51.0


