Return-Path: <stable+bounces-53614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DD090D316
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E64E61C245B3
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4518C15D5CD;
	Tue, 18 Jun 2024 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t7Jhw13f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D61155725
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717621; cv=none; b=rZqey3UzXrAIgpTa1rioOrtn7AQ1sOnfUmD55O9cK2ti70kCBOg50RBUKPZOcoUIWLjXBKT570geprGtobw4sc6NUaxQjjl0Jhv9//kk1OLV5BBlpQQMs3bJzjF4A2qBAeAxXOTcrLS4YIHWekOH8lEH+EIzFcpKUJCAHelkLNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717621; c=relaxed/simple;
	bh=ovcbows6yahMhlsYKKZQMBYwsrxxHANto197LaDFgOg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SsjLq3MUodYAyGPA+aZW8sFBTKvrStFuTXmRZ5NeH1GzXgnxTBjTlfpLR/g/OcLpOYdaVTuZVf+ZhI20kRU/M+MF7Ie+ipKVjph0FLCHygui3ZLm327O3S5wRkhIw+aC2IYPy/p9CvTygh46L5sLXqeIJR/cbcFKhCbPuE3Z8kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t7Jhw13f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26633C3277B;
	Tue, 18 Jun 2024 13:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718717620;
	bh=ovcbows6yahMhlsYKKZQMBYwsrxxHANto197LaDFgOg=;
	h=Subject:To:Cc:From:Date:From;
	b=t7Jhw13fPTUGkNE3JA3V4hpU4ZfhfGWE3Z3WyL/e4mEv+f6ZPkcoBHPs71w7wMd3T
	 PTRIQPR5E11V7GRycEE9UPC/BHh+tw9qEjPiZXF7Q2qBODoikikL+1B4u7HlqbCRau
	 7ubQJbBz5Eb93QMccXpJf3B/CrZXlrUzp9Ekmi54=
Subject: FAILED: patch "[PATCH] irqchip/gic-v3-its: Fix potential race condition in" failed to apply to 5.4-stable tree
To: hagarhem@amazon.com,maz@kernel.org,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Jun 2024 15:23:14 +0200
Message-ID: <2024061814-opacity-connected-5c75@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x b97e8a2f7130a4b30d1502003095833d16c028b3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061814-opacity-connected-5c75@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

b97e8a2f7130 ("irqchip/gic-v3-its: Fix potential race condition in its_vlpi_prop_update()")
11635fa26dc7 ("irqchip/gic-v3-its: Make vlpi_lock a spinlock")
046b5054f566 ("irqchip/gic-v3-its: Lock VLPI map array before translating it")
c1d4d5cd203c ("irqchip/gic-v3-its: Add its_vlpi_map helpers")
425c09be0f09 ("irqchip/gic-v3-its: Allow LPI invalidation via the DirectLPI interface")
2f4f064b3131 ("irqchip/gic-v3-its: Factor out wait_for_syncr primitive")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b97e8a2f7130a4b30d1502003095833d16c028b3 Mon Sep 17 00:00:00 2001
From: Hagar Hemdan <hagarhem@amazon.com>
Date: Fri, 31 May 2024 16:21:44 +0000
Subject: [PATCH] irqchip/gic-v3-its: Fix potential race condition in
 its_vlpi_prop_update()

its_vlpi_prop_update() calls lpi_write_config() which obtains the
mapping information for a VLPI without lock held. So it could race
with its_vlpi_unmap().

Since all calls from its_irq_set_vcpu_affinity() require the same
lock to be held, hoist the locking there instead of sprinkling the
locking all over the place.

This bug was discovered using Coverity Static Analysis Security Testing
(SAST) by Synopsys, Inc.

[ tglx: Use guard() instead of goto ]

Fixes: 015ec0386ab6 ("irqchip/gic-v3-its: Add VLPI configuration handling")
Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20240531162144.28650-1-hagarhem@amazon.com

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 40ebf1726393..3c755d5dad6e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1846,28 +1846,22 @@ static int its_vlpi_map(struct irq_data *d, struct its_cmd_info *info)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	u32 event = its_get_event_id(d);
-	int ret = 0;
 
 	if (!info->map)
 		return -EINVAL;
 
-	raw_spin_lock(&its_dev->event_map.vlpi_lock);
-
 	if (!its_dev->event_map.vm) {
 		struct its_vlpi_map *maps;
 
 		maps = kcalloc(its_dev->event_map.nr_lpis, sizeof(*maps),
 			       GFP_ATOMIC);
-		if (!maps) {
-			ret = -ENOMEM;
-			goto out;
-		}
+		if (!maps)
+			return -ENOMEM;
 
 		its_dev->event_map.vm = info->map->vm;
 		its_dev->event_map.vlpi_maps = maps;
 	} else if (its_dev->event_map.vm != info->map->vm) {
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	/* Get our private copy of the mapping information */
@@ -1899,46 +1893,32 @@ static int its_vlpi_map(struct irq_data *d, struct its_cmd_info *info)
 		its_dev->event_map.nr_vlpis++;
 	}
 
-out:
-	raw_spin_unlock(&its_dev->event_map.vlpi_lock);
-	return ret;
+	return 0;
 }
 
 static int its_vlpi_get(struct irq_data *d, struct its_cmd_info *info)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	struct its_vlpi_map *map;
-	int ret = 0;
-
-	raw_spin_lock(&its_dev->event_map.vlpi_lock);
 
 	map = get_vlpi_map(d);
 
-	if (!its_dev->event_map.vm || !map) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!its_dev->event_map.vm || !map)
+		return -EINVAL;
 
 	/* Copy our mapping information to the incoming request */
 	*info->map = *map;
 
-out:
-	raw_spin_unlock(&its_dev->event_map.vlpi_lock);
-	return ret;
+	return 0;
 }
 
 static int its_vlpi_unmap(struct irq_data *d)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	u32 event = its_get_event_id(d);
-	int ret = 0;
 
-	raw_spin_lock(&its_dev->event_map.vlpi_lock);
-
-	if (!its_dev->event_map.vm || !irqd_is_forwarded_to_vcpu(d)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!its_dev->event_map.vm || !irqd_is_forwarded_to_vcpu(d))
+		return -EINVAL;
 
 	/* Drop the virtual mapping */
 	its_send_discard(its_dev, event);
@@ -1962,9 +1942,7 @@ static int its_vlpi_unmap(struct irq_data *d)
 		kfree(its_dev->event_map.vlpi_maps);
 	}
 
-out:
-	raw_spin_unlock(&its_dev->event_map.vlpi_lock);
-	return ret;
+	return 0;
 }
 
 static int its_vlpi_prop_update(struct irq_data *d, struct its_cmd_info *info)
@@ -1992,6 +1970,8 @@ static int its_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 	if (!is_v4(its_dev->its))
 		return -EINVAL;
 
+	guard(raw_spinlock_irq)(&its_dev->event_map.vlpi_lock);
+
 	/* Unmap request? */
 	if (!info)
 		return its_vlpi_unmap(d);


