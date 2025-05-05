Return-Path: <stable+bounces-140622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3037AAAA3E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C470E1886C68
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B40377664;
	Mon,  5 May 2025 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ry+pjD6Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87906360A4E;
	Mon,  5 May 2025 22:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485377; cv=none; b=c1LavmQix2UzVCly0V428XHad9GDisWms/zS8S8kAu9IvjMKXzOM6pfemme9eOFjEbgvhClsYqPSP2EGIeGdPphMY5Qtnx8jx6FL6r0I/x17sE//54HXB2GZ471gZjC69I/oT9uIBQLDIFN+x006vHwoZaRYaLb/A9m+2mubgPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485377; c=relaxed/simple;
	bh=IIXK9K2DVzIQoWl91FaWaC67MYNxQPN0H26Z8DZxsgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a7kPa8V549lK/vNntnF9tj18pjxbtgjq3h2o5cLkci436sVhjrnWUH5dVG/XWEO53HKfKymiom2NSI9xABJcDerneidjdVXp2JvqfsoHKQL86oeivLThzlauumRr2DuAeG6OikZXZgRiKIezJgOwoxw3Mtslv9zW0K4d6hDgiIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ry+pjD6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B0BC4CEED;
	Mon,  5 May 2025 22:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485376;
	bh=IIXK9K2DVzIQoWl91FaWaC67MYNxQPN0H26Z8DZxsgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ry+pjD6YMpviKAtn30mSSsQi2gJkZEZJcj5Q9SLYvUOXu+cG61VTho7HfliPj/SSP
	 AtBg2jRgGIbs9EO2u+KH7aq8Hs8t/vdhyGZSYqDndDMrQzCAHz0wh4/4nnGtgncGJX
	 CG13G4jMVj7as3lVReppNPpEsrVWOuQdXMhyIGYsLJHNvEOn1owvl3BGDYcmZvBoNg
	 m3jfRg5YVamLzl8a9uqDRF/MdAimf/Mu+Mju4EiZd6AM80QFznZct4a9aYTAq4UjZ8
	 AVRl2lYMsRa1El2P7BtCTLVe7IF2t8Lxv9oTa5jUUcr0BDHSgprBEQlU4rz3n5wQ+N
	 4osKjEbvSQMTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Anup Patel <apatel@ventanamicro.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	anup@brainfault.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 298/486] irqchip/riscv-imsic: Separate next and previous pointers in IMSIC vector
Date: Mon,  5 May 2025 18:36:14 -0400
Message-Id: <20250505223922.2682012-298-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Anup Patel <apatel@ventanamicro.com>

[ Upstream commit 0f67911e821c67ecfccc365a2103ce276a9a56fe ]

Currently, there is only one "move" pointer in struct imsic_vector so
during vector movement the old vector points to the new vector and new
vector points to itself.

To support forced cleanup of the old vector, add separate "move_next" and
"move_prev" pointers to struct imsic_vector, where during vector movement
the "move_next" pointer of the old vector points to the new vector and the
"move_prev" pointer of the new vector points to the old vector.

Both "move_next" and "move_prev" pointers are cleared separately by
__imsic_local_sync() with a restriction that "move_prev" on the new
CPU is cleared only after the old CPU has cleared "move_next".

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250217085657.789309-8-apatel@ventanamicro.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-riscv-imsic-early.c |  8 ++-
 drivers/irqchip/irq-riscv-imsic-state.c | 96 +++++++++++++++++--------
 drivers/irqchip/irq-riscv-imsic-state.h |  7 +-
 3 files changed, 78 insertions(+), 33 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
index c5c2e6929a2f5..b5def6268936e 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -77,6 +77,12 @@ static void imsic_handle_irq(struct irq_desc *desc)
 	struct imsic_vector *vec;
 	unsigned long local_id;
 
+	/*
+	 * Process pending local synchronization instead of waiting
+	 * for per-CPU local timer to expire.
+	 */
+	imsic_local_sync_all(false);
+
 	chained_irq_enter(chip, desc);
 
 	while ((local_id = csr_swap(CSR_TOPEI, 0))) {
@@ -120,7 +126,7 @@ static int imsic_starting_cpu(unsigned int cpu)
 	 * Interrupts identities might have been enabled/disabled while
 	 * this CPU was not running so sync-up local enable/disable state.
 	 */
-	imsic_local_sync_all();
+	imsic_local_sync_all(true);
 
 	/* Enable local interrupt delivery */
 	imsic_local_delivery(true);
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index b97e6cd89ed74..1aeba76d72795 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -124,10 +124,11 @@ void __imsic_eix_update(unsigned long base_id, unsigned long num_id, bool pend,
 	}
 }
 
-static void __imsic_local_sync(struct imsic_local_priv *lpriv)
+static bool __imsic_local_sync(struct imsic_local_priv *lpriv)
 {
 	struct imsic_local_config *mlocal;
 	struct imsic_vector *vec, *mvec;
+	bool ret = true;
 	int i;
 
 	lockdep_assert_held(&lpriv->lock);
@@ -143,35 +144,75 @@ static void __imsic_local_sync(struct imsic_local_priv *lpriv)
 			__imsic_id_clear_enable(i);
 
 		/*
-		 * If the ID was being moved to a new ID on some other CPU
-		 * then we can get a MSI during the movement so check the
-		 * ID pending bit and re-trigger the new ID on other CPU
-		 * using MMIO write.
+		 * Clear the previous vector pointer of the new vector only
+		 * after the movement is complete on the old CPU.
 		 */
-		mvec = READ_ONCE(vec->move);
-		WRITE_ONCE(vec->move, NULL);
-		if (mvec && mvec != vec) {
+		mvec = READ_ONCE(vec->move_prev);
+		if (mvec) {
+			/*
+			 * If the old vector has not been updated then
+			 * try again in the next sync-up call.
+			 */
+			if (READ_ONCE(mvec->move_next)) {
+				ret = false;
+				continue;
+			}
+
+			WRITE_ONCE(vec->move_prev, NULL);
+		}
+
+		/*
+		 * If a vector was being moved to a new vector on some other
+		 * CPU then we can get a MSI during the movement so check the
+		 * ID pending bit and re-trigger the new ID on other CPU using
+		 * MMIO write.
+		 */
+		mvec = READ_ONCE(vec->move_next);
+		if (mvec) {
 			if (__imsic_id_read_clear_pending(i)) {
 				mlocal = per_cpu_ptr(imsic->global.local, mvec->cpu);
 				writel_relaxed(mvec->local_id, mlocal->msi_va);
 			}
 
+			WRITE_ONCE(vec->move_next, NULL);
 			imsic_vector_free(&lpriv->vectors[i]);
 		}
 
 skip:
 		bitmap_clear(lpriv->dirty_bitmap, i, 1);
 	}
+
+	return ret;
 }
 
-void imsic_local_sync_all(void)
+#ifdef CONFIG_SMP
+static void __imsic_local_timer_start(struct imsic_local_priv *lpriv)
+{
+	lockdep_assert_held(&lpriv->lock);
+
+	if (!timer_pending(&lpriv->timer)) {
+		lpriv->timer.expires = jiffies + 1;
+		add_timer_on(&lpriv->timer, smp_processor_id());
+	}
+}
+#else
+static inline void __imsic_local_timer_start(struct imsic_local_priv *lpriv)
+{
+}
+#endif
+
+void imsic_local_sync_all(bool force_all)
 {
 	struct imsic_local_priv *lpriv = this_cpu_ptr(imsic->lpriv);
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&lpriv->lock, flags);
-	bitmap_fill(lpriv->dirty_bitmap, imsic->global.nr_ids + 1);
-	__imsic_local_sync(lpriv);
+
+	if (force_all)
+		bitmap_fill(lpriv->dirty_bitmap, imsic->global.nr_ids + 1);
+	if (!__imsic_local_sync(lpriv))
+		__imsic_local_timer_start(lpriv);
+
 	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
 }
 
@@ -190,12 +231,7 @@ void imsic_local_delivery(bool enable)
 #ifdef CONFIG_SMP
 static void imsic_local_timer_callback(struct timer_list *timer)
 {
-	struct imsic_local_priv *lpriv = this_cpu_ptr(imsic->lpriv);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&lpriv->lock, flags);
-	__imsic_local_sync(lpriv);
-	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
+	imsic_local_sync_all(false);
 }
 
 static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsigned int cpu)
@@ -216,14 +252,11 @@ static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsigned int cpu
 	 */
 	if (cpu_online(cpu)) {
 		if (cpu == smp_processor_id()) {
-			__imsic_local_sync(lpriv);
-			return;
+			if (__imsic_local_sync(lpriv))
+				return;
 		}
 
-		if (!timer_pending(&lpriv->timer)) {
-			lpriv->timer.expires = jiffies + 1;
-			add_timer_on(&lpriv->timer, cpu);
-		}
+		__imsic_local_timer_start(lpriv);
 	}
 }
 #else
@@ -278,8 +311,9 @@ void imsic_vector_unmask(struct imsic_vector *vec)
 	raw_spin_unlock(&lpriv->lock);
 }
 
-static bool imsic_vector_move_update(struct imsic_local_priv *lpriv, struct imsic_vector *vec,
-				     bool new_enable, struct imsic_vector *new_move)
+static bool imsic_vector_move_update(struct imsic_local_priv *lpriv,
+				     struct imsic_vector *vec, bool is_old_vec,
+				     bool new_enable, struct imsic_vector *move_vec)
 {
 	unsigned long flags;
 	bool enabled;
@@ -289,7 +323,10 @@ static bool imsic_vector_move_update(struct imsic_local_priv *lpriv, struct imsi
 	/* Update enable and move details */
 	enabled = READ_ONCE(vec->enable);
 	WRITE_ONCE(vec->enable, new_enable);
-	WRITE_ONCE(vec->move, new_move);
+	if (is_old_vec)
+		WRITE_ONCE(vec->move_next, move_vec);
+	else
+		WRITE_ONCE(vec->move_prev, move_vec);
 
 	/* Mark the vector as dirty and synchronize */
 	bitmap_set(lpriv->dirty_bitmap, vec->local_id, 1);
@@ -322,8 +359,8 @@ void imsic_vector_move(struct imsic_vector *old_vec, struct imsic_vector *new_ve
 	 * interrupt on the old vector while device was being moved
 	 * to the new vector.
 	 */
-	enabled = imsic_vector_move_update(old_lpriv, old_vec, false, new_vec);
-	imsic_vector_move_update(new_lpriv, new_vec, enabled, new_vec);
+	enabled = imsic_vector_move_update(old_lpriv, old_vec, true, false, new_vec);
+	imsic_vector_move_update(new_lpriv, new_vec, false, enabled, old_vec);
 }
 
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
@@ -386,7 +423,8 @@ struct imsic_vector *imsic_vector_alloc(unsigned int hwirq, const struct cpumask
 	vec = &lpriv->vectors[local_id];
 	vec->hwirq = hwirq;
 	vec->enable = false;
-	vec->move = NULL;
+	vec->move_next = NULL;
+	vec->move_prev = NULL;
 
 	return vec;
 }
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
index 391e442808275..f02842b84ed58 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -23,7 +23,8 @@ struct imsic_vector {
 	unsigned int				hwirq;
 	/* Details accessed using local lock held */
 	bool					enable;
-	struct imsic_vector			*move;
+	struct imsic_vector			*move_next;
+	struct imsic_vector			*move_prev;
 };
 
 struct imsic_local_priv {
@@ -74,7 +75,7 @@ static inline void __imsic_id_clear_enable(unsigned long id)
 	__imsic_eix_update(id, 1, false, false);
 }
 
-void imsic_local_sync_all(void);
+void imsic_local_sync_all(bool force_all);
 void imsic_local_delivery(bool enable);
 
 void imsic_vector_mask(struct imsic_vector *vec);
@@ -87,7 +88,7 @@ static inline bool imsic_vector_isenabled(struct imsic_vector *vec)
 
 static inline struct imsic_vector *imsic_vector_get_move(struct imsic_vector *vec)
 {
-	return READ_ONCE(vec->move);
+	return READ_ONCE(vec->move_prev);
 }
 
 void imsic_vector_move(struct imsic_vector *old_vec, struct imsic_vector *new_vec);
-- 
2.39.5


