Return-Path: <stable+bounces-187723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D17BEBFFD
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 01:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96DE31AA66C0
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 23:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE08629A9CD;
	Fri, 17 Oct 2025 23:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S23ICbaI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA3F1A2C11
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 23:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760743915; cv=none; b=sDCIyCGswW3JjL8UbDLws0OooTadWPpnC/0xl1UuEq6sZVtzfsf/4w07glF1xh+neBYieBGzelY2O2O5vvIv+Rv3moep1cXvhujVYqVnSC8VQ5DjEoU7EdPNvN2wLK2XOL5mugf1FNXhsyLZXuM03VEjh5ffcw65Yf5p5BfbrZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760743915; c=relaxed/simple;
	bh=4yDArTjqukelIPu1w2W4k0+eXlIt3wNOQ/tmXV7Eg2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZkrbe2Ss61qiP9IPoyhYunNlufcEsi0uKR7G139OQMocvJUcZPTA3SgGCzQ019HnRVHa9QoB+ykTwnj15gG8mnl0vvfkihZL5GsSXC0YyiuOoBDXOw9IrmcMVxLc/jeetbFBOQ6db3nAfip1pT0sRUtv9+c2HiPrdz057ENM+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S23ICbaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8167C4CEE7;
	Fri, 17 Oct 2025 23:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760743915;
	bh=4yDArTjqukelIPu1w2W4k0+eXlIt3wNOQ/tmXV7Eg2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S23ICbaI8Hgz+Ue4qFK3OLaKdLUdnCoD9gu8nD/7XxREfSNmuvsCzP0HEHgIkD6G9
	 XsMR/jbubq8M2zCz7HZkXgzWYvBlojTU/mrsqZdFE1XKnzc4IcoWpfRBwH64Uq9jxx
	 r+fygMB2n9Iv0Pfb3wS8AeVNiq1lgFIkukHmgEzvjlSRiSxsjEwaeKj8diPgkipC7n
	 B7+WgXqhjm3XM55VVKAM3lLaZ84fQfQtkaT3tsg3NXbfnW5SxPg4/WhlECT4esMWYg
	 RT3soi6SfMkbRKaamE7BH+PoLeKjaVdBpXZTMFJaoWxsF9qWXEWAYm7HgPDtA7Mn90
	 IRRM5vwkhhnVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: keliu <liuke94@huawei.com>,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 1/2] media: rc: Directly use ida_free()
Date: Fri, 17 Oct 2025 19:31:50 -0400
Message-ID: <20251017233151.37969-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101607-contend-gentleman-9ae0@gregkh>
References: <2025101607-contend-gentleman-9ae0@gregkh>
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
index 7de97c26b622a..9c9eac2e1182f 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -746,7 +746,7 @@ int ir_lirc_register(struct rc_dev *dev)
 	const char *rx_type, *tx_type;
 	int err, minor;
 
-	minor = ida_simple_get(&lirc_ida, 0, RC_DEV_MAX, GFP_KERNEL);
+	minor = ida_alloc_max(&lirc_ida, RC_DEV_MAX - 1, GFP_KERNEL);
 	if (minor < 0)
 		return minor;
 
@@ -791,7 +791,7 @@ int ir_lirc_register(struct rc_dev *dev)
 	return 0;
 
 out_ida:
-	ida_simple_remove(&lirc_ida, minor);
+	ida_free(&lirc_ida, minor);
 	return err;
 }
 
@@ -809,7 +809,7 @@ void ir_lirc_unregister(struct rc_dev *dev)
 	spin_unlock_irqrestore(&dev->lirc_fh_lock, flags);
 
 	cdev_device_del(&dev->lirc_cdev, &dev->lirc_dev);
-	ida_simple_remove(&lirc_ida, MINOR(dev->lirc_dev.devt));
+	ida_free(&lirc_ida, MINOR(dev->lirc_dev.devt));
 }
 
 int __init lirc_dev_init(void)
diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index ee80f38970bc4..e5cbe8c50ce1e 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -1861,7 +1861,7 @@ int rc_register_device(struct rc_dev *dev)
 	if (!dev)
 		return -EINVAL;
 
-	minor = ida_simple_get(&rc_ida, 0, RC_DEV_MAX, GFP_KERNEL);
+	minor = ida_alloc_max(&rc_ida, RC_DEV_MAX - 1, GFP_KERNEL);
 	if (minor < 0)
 		return minor;
 
@@ -1944,7 +1944,7 @@ int rc_register_device(struct rc_dev *dev)
 out_raw:
 	ir_raw_event_free(dev);
 out_minor:
-	ida_simple_remove(&rc_ida, minor);
+	ida_free(&rc_ida, minor);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(rc_register_device);
@@ -2004,7 +2004,7 @@ void rc_unregister_device(struct rc_dev *dev)
 
 	device_del(&dev->dev);
 
-	ida_simple_remove(&rc_ida, dev->minor);
+	ida_free(&rc_ida, dev->minor);
 
 	if (!dev->managed_alloc)
 		rc_free_device(dev);
-- 
2.51.0


