Return-Path: <stable+bounces-49099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F5C8FEBD9
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0EA1C25173
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FB719882B;
	Thu,  6 Jun 2024 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ep7Q5CFD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759DA196DA2;
	Thu,  6 Jun 2024 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683301; cv=none; b=ckM3HYKaOucVvwpsMWDe9hNEaoReJTqhdWhBEy9VLPgBfEfobcYmj035UxksERJqJtFJR91PCWj9fJVkofFaOyWX2cvcMmY0SVBWqMsZwDiMt+e/lRF4RgjH2OkCT/RfFMUIAZ5gcMWcYlnqLxFhiZY+ak58NIT89QMXWhoQg4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683301; c=relaxed/simple;
	bh=jgJrVRMICS/joXkUK0KHV9PjLGqOO665CFmz5icET2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkegNaSqTSgzFCC88YKAZi/3pB8Q5CqVQohHEXTHBLnPYimx8sTSLJyl03Me4E8D6BWom0oxiTQ/MWM0zrNgjen/yx3vBBstRTGEJ7LyVeUyzxfuZ4J3Buk+KZmMsjKsgI1SdAopN24OUeh/H9bJPm7q3DD5J6XK2MpIHq6Bb1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ep7Q5CFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55781C32786;
	Thu,  6 Jun 2024 14:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683301;
	bh=jgJrVRMICS/joXkUK0KHV9PjLGqOO665CFmz5icET2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ep7Q5CFDIOaLNHFrW9xp+kmQCNdBDEuW2UUSvwDqIlXhIX1989CklQElD59Fcz2hi
	 vsTNQE6Gs0IhVFcHEYZfiEnfPt+izMbN3FT16wPGaJ4AQVRJFoF7xnmKmZrYa0sXzy
	 igSveQnzpXD20mwDzxH0RB8uHtEwb9pUpwLkKaU4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Duoming Zhou <duoming@zju.edu.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 182/473] ax25: Use kernel universal linked list to implement ax25_dev_list
Date: Thu,  6 Jun 2024 16:01:51 +0200
Message-ID: <20240606131705.947094867@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Duoming Zhou <duoming@zju.edu.cn>

[ Upstream commit a7d6e36b9ad052926ba2ecba3a59d8bb67dabcb4 ]

The origin ax25_dev_list implements its own single linked list,
which is complicated and error-prone. For example, when deleting
the node of ax25_dev_list in ax25_dev_device_down(), we have to
operate on the head node and other nodes separately.

This patch uses kernel universal linked list to replace original
ax25_dev_list, which make the operation of ax25_dev_list easier.

We should do "dev->ax25_ptr = ax25_dev;" and "dev->ax25_ptr = NULL;"
while holding the spinlock, otherwise the ax25_dev_device_up() and
ax25_dev_device_down() could race.

Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/85bba3af651ca0e1a519da8d0d715b949891171c.1715247018.git.duoming@zju.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: b505e0319852 ("ax25: Fix reference count leak issues of ax25_dev")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ax25.h  |  3 +--
 net/ax25/ax25_dev.c | 40 +++++++++++++++-------------------------
 2 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/include/net/ax25.h b/include/net/ax25.h
index f8cf3629a4193..1d55e8ee08b4f 100644
--- a/include/net/ax25.h
+++ b/include/net/ax25.h
@@ -216,7 +216,7 @@ typedef struct {
 struct ctl_table;
 
 typedef struct ax25_dev {
-	struct ax25_dev		*next;
+	struct list_head	list;
 
 	struct net_device	*dev;
 	netdevice_tracker	dev_tracker;
@@ -333,7 +333,6 @@ int ax25_addr_size(const ax25_digi *);
 void ax25_digi_invert(const ax25_digi *, ax25_digi *);
 
 /* ax25_dev.c */
-extern ax25_dev *ax25_dev_list;
 extern spinlock_t ax25_dev_lock;
 
 #if IS_ENABLED(CONFIG_AX25)
diff --git a/net/ax25/ax25_dev.c b/net/ax25/ax25_dev.c
index c5462486dbca1..a56d12fae464b 100644
--- a/net/ax25/ax25_dev.c
+++ b/net/ax25/ax25_dev.c
@@ -22,11 +22,12 @@
 #include <net/sock.h>
 #include <linux/uaccess.h>
 #include <linux/fcntl.h>
+#include <linux/list.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
 
-ax25_dev *ax25_dev_list;
+static LIST_HEAD(ax25_dev_list);
 DEFINE_SPINLOCK(ax25_dev_lock);
 
 ax25_dev *ax25_addr_ax25dev(ax25_address *addr)
@@ -34,7 +35,7 @@ ax25_dev *ax25_addr_ax25dev(ax25_address *addr)
 	ax25_dev *ax25_dev, *res = NULL;
 
 	spin_lock_bh(&ax25_dev_lock);
-	for (ax25_dev = ax25_dev_list; ax25_dev != NULL; ax25_dev = ax25_dev->next)
+	list_for_each_entry(ax25_dev, &ax25_dev_list, list)
 		if (ax25cmp(addr, (const ax25_address *)ax25_dev->dev->dev_addr) == 0) {
 			res = ax25_dev;
 			ax25_dev_hold(ax25_dev);
@@ -59,7 +60,6 @@ void ax25_dev_device_up(struct net_device *dev)
 	}
 
 	refcount_set(&ax25_dev->refcount, 1);
-	dev->ax25_ptr     = ax25_dev;
 	ax25_dev->dev     = dev;
 	netdev_hold(dev, &ax25_dev->dev_tracker, GFP_KERNEL);
 	ax25_dev->forward = NULL;
@@ -85,8 +85,8 @@ void ax25_dev_device_up(struct net_device *dev)
 #endif
 
 	spin_lock_bh(&ax25_dev_lock);
-	ax25_dev->next = ax25_dev_list;
-	ax25_dev_list  = ax25_dev;
+	list_add(&ax25_dev->list, &ax25_dev_list);
+	dev->ax25_ptr     = ax25_dev;
 	spin_unlock_bh(&ax25_dev_lock);
 	ax25_dev_hold(ax25_dev);
 
@@ -111,32 +111,25 @@ void ax25_dev_device_down(struct net_device *dev)
 	/*
 	 *	Remove any packet forwarding that points to this device.
 	 */
-	for (s = ax25_dev_list; s != NULL; s = s->next)
+	list_for_each_entry(s, &ax25_dev_list, list)
 		if (s->forward == dev)
 			s->forward = NULL;
 
-	if ((s = ax25_dev_list) == ax25_dev) {
-		ax25_dev_list = s->next;
-		goto unlock_put;
-	}
-
-	while (s != NULL && s->next != NULL) {
-		if (s->next == ax25_dev) {
-			s->next = ax25_dev->next;
+	list_for_each_entry(s, &ax25_dev_list, list) {
+		if (s == ax25_dev) {
+			list_del(&s->list);
 			goto unlock_put;
 		}
-
-		s = s->next;
 	}
-	spin_unlock_bh(&ax25_dev_lock);
 	dev->ax25_ptr = NULL;
+	spin_unlock_bh(&ax25_dev_lock);
 	ax25_dev_put(ax25_dev);
 	return;
 
 unlock_put:
+	dev->ax25_ptr = NULL;
 	spin_unlock_bh(&ax25_dev_lock);
 	ax25_dev_put(ax25_dev);
-	dev->ax25_ptr = NULL;
 	netdev_put(dev, &ax25_dev->dev_tracker);
 	ax25_dev_put(ax25_dev);
 }
@@ -200,16 +193,13 @@ struct net_device *ax25_fwd_dev(struct net_device *dev)
  */
 void __exit ax25_dev_free(void)
 {
-	ax25_dev *s, *ax25_dev;
+	ax25_dev *s, *n;
 
 	spin_lock_bh(&ax25_dev_lock);
-	ax25_dev = ax25_dev_list;
-	while (ax25_dev != NULL) {
-		s        = ax25_dev;
-		netdev_put(ax25_dev->dev, &ax25_dev->dev_tracker);
-		ax25_dev = ax25_dev->next;
+	list_for_each_entry_safe(s, n, &ax25_dev_list, list) {
+		netdev_put(s->dev, &s->dev_tracker);
+		list_del(&s->list);
 		kfree(s);
 	}
-	ax25_dev_list = NULL;
 	spin_unlock_bh(&ax25_dev_lock);
 }
-- 
2.43.0




