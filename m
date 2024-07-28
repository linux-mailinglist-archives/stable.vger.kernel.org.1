Return-Path: <stable+bounces-62043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB42993E24A
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 03:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC71A1C203B3
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 01:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D20F18F2C7;
	Sun, 28 Jul 2024 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca62VEKV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AC518EFFF;
	Sun, 28 Jul 2024 00:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127798; cv=none; b=W+HfIwwUByD5R+6b7fJE7enZfu3Fpa13Jot/pEyue9BWPpU2llv0/DzgfbASm7aUGInpS6xARz1Lm3YwUCoT63Ux1oq4wFfvf5SByNWIO6L7yYTKT+i7Ecp8/CBw7R/eKrJ1KEnHEam9B4r60e9N1N7oPVkCkTkZuoEa+lk8rGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127798; c=relaxed/simple;
	bh=cVpANbBpyjABr/uwdE5+zHiR2KnbawAzmIIg/G1xH9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XT3MJEmlHfHziyjBULBfPFMFxYfFBp2AqwQnDrCyFW3B7mZ8cs2YooRBPNGfcp8x4/ttxXCAsNTVwXRu2sDcBu7sJj9NKWc82eDEiidi0ACASuQLf6woPvu9HmE+oMXh5IMUoBxUOn6qcxFI5d3Fk9fSuN6PXoar4kgEJjHjqD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca62VEKV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71818C32781;
	Sun, 28 Jul 2024 00:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127798;
	bh=cVpANbBpyjABr/uwdE5+zHiR2KnbawAzmIIg/G1xH9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ca62VEKVSZ4du/QbzmQULMpO3q3t0hMzJuNgYpCE0i1wYDiSyh8qjxH8Obx6IPVnB
	 QapihDBV9lZQ5CR5C3F59b3KX6s4PJVcYUuUfOqXFzGmIfSoj4c0HBnnjQqFt/6Yon
	 1kob8PvmVUzqqaQl819z7klVYURh1cbUseZdy4W8t1XRh4r2rS/vhDyz0ztoo7OBkh
	 I6ynsjk6QwOKFzWsAoZULuklXMQXgDqwLR80LJWPEWESMkGGgYdBYC+RQF8O4IIbta
	 3+V0hrH3gHyPJe9iclzOGh7Ggs/GIk326sQUAgeRb/2Mnz3xmR4TrsAV4tVKNLd7yi
	 pjFqR9Zs9yQQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	sstabellini@kernel.org,
	xen-devel@lists.xenproject.org
Subject: [PATCH AUTOSEL 6.6 3/3] xen: privcmd: Switch from mutex to spinlock for irqfds
Date: Sat, 27 Jul 2024 20:49:51 -0400
Message-ID: <20240728004952.1707781-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728004952.1707781-1-sashal@kernel.org>
References: <20240728004952.1707781-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit 1c682593096a487fd9aebc079a307ff7a6d054a3 ]

irqfd_wakeup() gets EPOLLHUP, when it is called by
eventfd_release() by way of wake_up_poll(&ctx->wqh, EPOLLHUP), which
gets called under spin_lock_irqsave(). We can't use a mutex here as it
will lead to a deadlock.

Fix it by switching over to a spin lock.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/a66d7a7a9001424d432f52a9fc3931a1f345464f.1718703669.git.viresh.kumar@linaro.org
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/privcmd.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index da88173bac432..923f064c7e3e9 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -841,7 +841,7 @@ static long privcmd_ioctl_mmap_resource(struct file *file,
 #ifdef CONFIG_XEN_PRIVCMD_IRQFD
 /* Irqfd support */
 static struct workqueue_struct *irqfd_cleanup_wq;
-static DEFINE_MUTEX(irqfds_lock);
+static DEFINE_SPINLOCK(irqfds_lock);
 static LIST_HEAD(irqfds_list);
 
 struct privcmd_kernel_irqfd {
@@ -905,9 +905,11 @@ irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode, int sync, void *key)
 		irqfd_inject(kirqfd);
 
 	if (flags & EPOLLHUP) {
-		mutex_lock(&irqfds_lock);
+		unsigned long flags;
+
+		spin_lock_irqsave(&irqfds_lock, flags);
 		irqfd_deactivate(kirqfd);
-		mutex_unlock(&irqfds_lock);
+		spin_unlock_irqrestore(&irqfds_lock, flags);
 	}
 
 	return 0;
@@ -925,6 +927,7 @@ irqfd_poll_func(struct file *file, wait_queue_head_t *wqh, poll_table *pt)
 static int privcmd_irqfd_assign(struct privcmd_irqfd *irqfd)
 {
 	struct privcmd_kernel_irqfd *kirqfd, *tmp;
+	unsigned long flags;
 	__poll_t events;
 	struct fd f;
 	void *dm_op;
@@ -964,18 +967,18 @@ static int privcmd_irqfd_assign(struct privcmd_irqfd *irqfd)
 	init_waitqueue_func_entry(&kirqfd->wait, irqfd_wakeup);
 	init_poll_funcptr(&kirqfd->pt, irqfd_poll_func);
 
-	mutex_lock(&irqfds_lock);
+	spin_lock_irqsave(&irqfds_lock, flags);
 
 	list_for_each_entry(tmp, &irqfds_list, list) {
 		if (kirqfd->eventfd == tmp->eventfd) {
 			ret = -EBUSY;
-			mutex_unlock(&irqfds_lock);
+			spin_unlock_irqrestore(&irqfds_lock, flags);
 			goto error_eventfd;
 		}
 	}
 
 	list_add_tail(&kirqfd->list, &irqfds_list);
-	mutex_unlock(&irqfds_lock);
+	spin_unlock_irqrestore(&irqfds_lock, flags);
 
 	/*
 	 * Check if there was an event already pending on the eventfd before we
@@ -1007,12 +1010,13 @@ static int privcmd_irqfd_deassign(struct privcmd_irqfd *irqfd)
 {
 	struct privcmd_kernel_irqfd *kirqfd;
 	struct eventfd_ctx *eventfd;
+	unsigned long flags;
 
 	eventfd = eventfd_ctx_fdget(irqfd->fd);
 	if (IS_ERR(eventfd))
 		return PTR_ERR(eventfd);
 
-	mutex_lock(&irqfds_lock);
+	spin_lock_irqsave(&irqfds_lock, flags);
 
 	list_for_each_entry(kirqfd, &irqfds_list, list) {
 		if (kirqfd->eventfd == eventfd) {
@@ -1021,7 +1025,7 @@ static int privcmd_irqfd_deassign(struct privcmd_irqfd *irqfd)
 		}
 	}
 
-	mutex_unlock(&irqfds_lock);
+	spin_unlock_irqrestore(&irqfds_lock, flags);
 
 	eventfd_ctx_put(eventfd);
 
@@ -1069,13 +1073,14 @@ static int privcmd_irqfd_init(void)
 static void privcmd_irqfd_exit(void)
 {
 	struct privcmd_kernel_irqfd *kirqfd, *tmp;
+	unsigned long flags;
 
-	mutex_lock(&irqfds_lock);
+	spin_lock_irqsave(&irqfds_lock, flags);
 
 	list_for_each_entry_safe(kirqfd, tmp, &irqfds_list, list)
 		irqfd_deactivate(kirqfd);
 
-	mutex_unlock(&irqfds_lock);
+	spin_unlock_irqrestore(&irqfds_lock, flags);
 
 	destroy_workqueue(irqfd_cleanup_wq);
 }
-- 
2.43.0


