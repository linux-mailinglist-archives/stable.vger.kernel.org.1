Return-Path: <stable+bounces-116876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9172A3A96D
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0374116641E
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315AA2139CD;
	Tue, 18 Feb 2025 20:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMVYB0No"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D582139C4;
	Tue, 18 Feb 2025 20:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910429; cv=none; b=Su5lkSmrcDoJ7g9s7zsoIhu8X2q1M26YjMkwoIAhzIPhPU8x31djKLhiZftUdA0stvoe0iCvmDQYEnySx7Qrt8t4l3qpYXkgEE6WgTXo/U1Vm82THWPi09VonXIDyRiEmhUfr6esDLujPTiNRRgzxDKMEC8QXoLkjmd/qUWqIHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910429; c=relaxed/simple;
	bh=2sohyi4xEaTC1NwXXc7Lqb9YoGirX8UCnEFaPIM4CvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ov5PouKVh1FBASFhdkHNyaqUJnAZhyRXg3mJyDNRBIOJbWXsKeOK6uM9gMYt9zNsx914nxgiHkN+Izz4zRVZdOm+omqNjmpVSnrkRZFFIsrsTCdnjUHKTEIw+ua05FnaKr83eTXV1h7XR7cOfm7wfoNPa5hlkCxhfvHZ7S0pJQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMVYB0No; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4626C4CEE2;
	Tue, 18 Feb 2025 20:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910428;
	bh=2sohyi4xEaTC1NwXXc7Lqb9YoGirX8UCnEFaPIM4CvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bMVYB0No8vuUs/c2IoJS1UPeFhxRLp+5e/+5RrmW7OYTxf1RFCnm57ILm3Cs4eK0q
	 y/iai5Q7uMI2HiFAL/c4dY1I4sCQTvkNFYzKaHicdsiEvw07kqar895v5Pa65dQIK2
	 lUOM8HAQdKA9SZm7lOF+ujOGYvXPiaHEMAmBIOjWiXoamlurGkhnQqgTIuuLG7hAYM
	 dk+pkrtEf0KWWafhQEskDx8bbb9UCQ1wlIm/CCAHPtv+bDKFZQnftdkaNgd5YCA2HD
	 y0YinMNdqA2SLtPUykm3noJCMLc5wzg1lChDCjbwtrZ0xEVdfckbNbV8DfW6yJzKji
	 zIyjWAqscnp1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	benjamin.berg@intel.com,
	thehajime@gmail.com,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 23/31] um: convert irq_lock to raw spinlock
Date: Tue, 18 Feb 2025 15:26:09 -0500
Message-Id: <20250218202619.3592630-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202619.3592630-1-sashal@kernel.org>
References: <20250218202619.3592630-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.15
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 96178631c3f53398044ed437010f7632ad764bf8 ]

Since this is deep in the architecture, and the code is
called nested into other deep management code, this really
needs to be a raw spinlock. Convert it.

Link: https://patch.msgid.link/20250110125550.32479-8-johannes@sipsolutions.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/kernel/irq.c | 79 ++++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 32 deletions(-)

diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 534e91797f892..ebf8012bbec45 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -52,7 +52,7 @@ struct irq_entry {
 	bool sigio_workaround;
 };
 
-static DEFINE_SPINLOCK(irq_lock);
+static DEFINE_RAW_SPINLOCK(irq_lock);
 static LIST_HEAD(active_fds);
 static DECLARE_BITMAP(irqs_allocated, UM_LAST_SIGNAL_IRQ);
 static bool irqs_suspended;
@@ -257,7 +257,7 @@ static struct irq_entry *get_irq_entry_by_fd(int fd)
 	return NULL;
 }
 
-static void free_irq_entry(struct irq_entry *to_free, bool remove)
+static void remove_irq_entry(struct irq_entry *to_free, bool remove)
 {
 	if (!to_free)
 		return;
@@ -265,7 +265,6 @@ static void free_irq_entry(struct irq_entry *to_free, bool remove)
 	if (remove)
 		os_del_epoll_fd(to_free->fd);
 	list_del(&to_free->list);
-	kfree(to_free);
 }
 
 static bool update_irq_entry(struct irq_entry *entry)
@@ -286,17 +285,19 @@ static bool update_irq_entry(struct irq_entry *entry)
 	return false;
 }
 
-static void update_or_free_irq_entry(struct irq_entry *entry)
+static struct irq_entry *update_or_remove_irq_entry(struct irq_entry *entry)
 {
-	if (!update_irq_entry(entry))
-		free_irq_entry(entry, false);
+	if (update_irq_entry(entry))
+		return NULL;
+	remove_irq_entry(entry, false);
+	return entry;
 }
 
 static int activate_fd(int irq, int fd, enum um_irq_type type, void *dev_id,
 		       void (*timetravel_handler)(int, int, void *,
 						  struct time_travel_event *))
 {
-	struct irq_entry *irq_entry;
+	struct irq_entry *irq_entry, *to_free = NULL;
 	int err, events = os_event_mask(type);
 	unsigned long flags;
 
@@ -304,9 +305,10 @@ static int activate_fd(int irq, int fd, enum um_irq_type type, void *dev_id,
 	if (err < 0)
 		goto out;
 
-	spin_lock_irqsave(&irq_lock, flags);
+	raw_spin_lock_irqsave(&irq_lock, flags);
 	irq_entry = get_irq_entry_by_fd(fd);
 	if (irq_entry) {
+already:
 		/* cannot register the same FD twice with the same type */
 		if (WARN_ON(irq_entry->reg[type].events)) {
 			err = -EALREADY;
@@ -316,11 +318,22 @@ static int activate_fd(int irq, int fd, enum um_irq_type type, void *dev_id,
 		/* temporarily disable to avoid IRQ-side locking */
 		os_del_epoll_fd(fd);
 	} else {
-		irq_entry = kzalloc(sizeof(*irq_entry), GFP_ATOMIC);
-		if (!irq_entry) {
-			err = -ENOMEM;
-			goto out_unlock;
+		struct irq_entry *new;
+
+		/* don't restore interrupts */
+		raw_spin_unlock(&irq_lock);
+		new = kzalloc(sizeof(*irq_entry), GFP_ATOMIC);
+		if (!new) {
+			local_irq_restore(flags);
+			return -ENOMEM;
 		}
+		raw_spin_lock(&irq_lock);
+		irq_entry = get_irq_entry_by_fd(fd);
+		if (irq_entry) {
+			to_free = new;
+			goto already;
+		}
+		irq_entry = new;
 		irq_entry->fd = fd;
 		list_add_tail(&irq_entry->list, &active_fds);
 		maybe_sigio_broken(fd);
@@ -339,12 +352,11 @@ static int activate_fd(int irq, int fd, enum um_irq_type type, void *dev_id,
 #endif
 
 	WARN_ON(!update_irq_entry(irq_entry));
-	spin_unlock_irqrestore(&irq_lock, flags);
-
-	return 0;
+	err = 0;
 out_unlock:
-	spin_unlock_irqrestore(&irq_lock, flags);
+	raw_spin_unlock_irqrestore(&irq_lock, flags);
 out:
+	kfree(to_free);
 	return err;
 }
 
@@ -358,19 +370,20 @@ void free_irq_by_fd(int fd)
 	struct irq_entry *to_free;
 	unsigned long flags;
 
-	spin_lock_irqsave(&irq_lock, flags);
+	raw_spin_lock_irqsave(&irq_lock, flags);
 	to_free = get_irq_entry_by_fd(fd);
-	free_irq_entry(to_free, true);
-	spin_unlock_irqrestore(&irq_lock, flags);
+	remove_irq_entry(to_free, true);
+	raw_spin_unlock_irqrestore(&irq_lock, flags);
+	kfree(to_free);
 }
 EXPORT_SYMBOL(free_irq_by_fd);
 
 static void free_irq_by_irq_and_dev(unsigned int irq, void *dev)
 {
-	struct irq_entry *entry;
+	struct irq_entry *entry, *to_free = NULL;
 	unsigned long flags;
 
-	spin_lock_irqsave(&irq_lock, flags);
+	raw_spin_lock_irqsave(&irq_lock, flags);
 	list_for_each_entry(entry, &active_fds, list) {
 		enum um_irq_type i;
 
@@ -386,12 +399,13 @@ static void free_irq_by_irq_and_dev(unsigned int irq, void *dev)
 
 			os_del_epoll_fd(entry->fd);
 			reg->events = 0;
-			update_or_free_irq_entry(entry);
+			to_free = update_or_remove_irq_entry(entry);
 			goto out;
 		}
 	}
 out:
-	spin_unlock_irqrestore(&irq_lock, flags);
+	raw_spin_unlock_irqrestore(&irq_lock, flags);
+	kfree(to_free);
 }
 
 void deactivate_fd(int fd, int irqnum)
@@ -402,7 +416,7 @@ void deactivate_fd(int fd, int irqnum)
 
 	os_del_epoll_fd(fd);
 
-	spin_lock_irqsave(&irq_lock, flags);
+	raw_spin_lock_irqsave(&irq_lock, flags);
 	entry = get_irq_entry_by_fd(fd);
 	if (!entry)
 		goto out;
@@ -414,9 +428,10 @@ void deactivate_fd(int fd, int irqnum)
 			entry->reg[i].events = 0;
 	}
 
-	update_or_free_irq_entry(entry);
+	entry = update_or_remove_irq_entry(entry);
 out:
-	spin_unlock_irqrestore(&irq_lock, flags);
+	raw_spin_unlock_irqrestore(&irq_lock, flags);
+	kfree(entry);
 
 	ignore_sigio_fd(fd);
 }
@@ -546,7 +561,7 @@ void um_irqs_suspend(void)
 
 	irqs_suspended = true;
 
-	spin_lock_irqsave(&irq_lock, flags);
+	raw_spin_lock_irqsave(&irq_lock, flags);
 	list_for_each_entry(entry, &active_fds, list) {
 		enum um_irq_type t;
 		bool clear = true;
@@ -579,7 +594,7 @@ void um_irqs_suspend(void)
 				!__ignore_sigio_fd(entry->fd);
 		}
 	}
-	spin_unlock_irqrestore(&irq_lock, flags);
+	raw_spin_unlock_irqrestore(&irq_lock, flags);
 }
 
 void um_irqs_resume(void)
@@ -588,7 +603,7 @@ void um_irqs_resume(void)
 	unsigned long flags;
 
 
-	spin_lock_irqsave(&irq_lock, flags);
+	raw_spin_lock_irqsave(&irq_lock, flags);
 	list_for_each_entry(entry, &active_fds, list) {
 		if (entry->suspended) {
 			int err = os_set_fd_async(entry->fd);
@@ -602,7 +617,7 @@ void um_irqs_resume(void)
 			}
 		}
 	}
-	spin_unlock_irqrestore(&irq_lock, flags);
+	raw_spin_unlock_irqrestore(&irq_lock, flags);
 
 	irqs_suspended = false;
 	send_sigio_to_self();
@@ -613,7 +628,7 @@ static int normal_irq_set_wake(struct irq_data *d, unsigned int on)
 	struct irq_entry *entry;
 	unsigned long flags;
 
-	spin_lock_irqsave(&irq_lock, flags);
+	raw_spin_lock_irqsave(&irq_lock, flags);
 	list_for_each_entry(entry, &active_fds, list) {
 		enum um_irq_type t;
 
@@ -628,7 +643,7 @@ static int normal_irq_set_wake(struct irq_data *d, unsigned int on)
 		}
 	}
 unlock:
-	spin_unlock_irqrestore(&irq_lock, flags);
+	raw_spin_unlock_irqrestore(&irq_lock, flags);
 	return 0;
 }
 #else
-- 
2.39.5


