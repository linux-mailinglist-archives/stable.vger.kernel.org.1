Return-Path: <stable+bounces-53853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7118C90EB07
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 14:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207E72825F8
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 12:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22BC140395;
	Wed, 19 Jun 2024 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UbU9p3A/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA1F79950
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799804; cv=none; b=Pw8pM/pPS6vmNc3IC6yldXYFt/rQmvZ41IqeBo8AY+p7BI9sVIVw67ygtxHnt3O2a6Ne6+NzqKn//W6XkGbE+zYEHTrHZJqrDg16TW1wrfCIXTYNMeUnKmfVPKyYx/GxPB53s8SBfLqJW+/CP4H2iFgE0X9AoRVpurC+qUsHyus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799804; c=relaxed/simple;
	bh=ZXukIq1rZFqk/bnqEbWUpEZ/4ENbjApFcba5c9SPcBA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AIvmSCzLmwb4XuLZUcJmAy7Of9aYVXSqtvqIiuOl02JXW7hIrTuF7L2Zmcdeii4uKArKcVf3BilZ37PzPYgduUapDqagmzR+XHkZd31X94opJypU2tv/2y7yQfjiuXiet+B6fCe9qQZyUGoQj08DOHd8nm5NdJSjCKO7Z+C/jLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UbU9p3A/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D242BC4AF49;
	Wed, 19 Jun 2024 12:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718799804;
	bh=ZXukIq1rZFqk/bnqEbWUpEZ/4ENbjApFcba5c9SPcBA=;
	h=Subject:To:Cc:From:Date:From;
	b=UbU9p3A/Z16VonkDdV/tZU4C/39vXHGCWmLVlt6zdl/gGLI82J89q7cxw8j7nRMEB
	 1IcE8BBOD0BHnieI8GJZZcuJavMSkxDF2UYQgSgncuy0rvGlATcUW8AxgLkJ3T9x+K
	 r4Sgoq9zw12QHCIjEEz+Aj7Alhx6ybHhmJNPRWn0=
Subject: FAILED: patch "[PATCH] irqchip/gic-v3-its: Fix potential race condition in" failed to apply to 5.10-stable tree
To: hagarhem@amazon.com,maz@kernel.org,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 14:23:13 +0200
Message-ID: <2024061913-unpainted-labrador-5bb5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b97e8a2f7130
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061913-unpainted-labrador-5bb5@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



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


