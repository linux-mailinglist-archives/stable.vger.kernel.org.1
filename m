Return-Path: <stable+bounces-83066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A83A9953F3
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 18:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEA7D284E0D
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 16:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E22D1E0DBD;
	Tue,  8 Oct 2024 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZdBBzgNk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YHfLCFcj"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955E04C62B;
	Tue,  8 Oct 2024 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403236; cv=none; b=VesFYt7yFFf5KLOjdLIM0baRh2SCh6xCZtDTwj9mKej9DyJEAcZadlps2/u46VRStGdAF/6h37CmguFTpUTrd0JoNpeCxrkG8Z+qUU2caP8O8DL9+/vhHBj1NIh4ITVnurT+7g/MFy+GhH+uaUJFLazzK5Gk9SeRAgJts+CS1nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403236; c=relaxed/simple;
	bh=crha7KbcBHq2QFdZjF/n3wxVMQu0q6ok+Vkg/tSm5NQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SfCe7+x2/U35yR0Icp9o9CI/2PzYSfO40dvUHzvlaqwgmRfIZTUsZBFMPkHx2qPFgYfhz2XHN0CvdMAHQvWAWAYnWzDSWyG7HCSUmjHhx/oIUvI7SMdlGNaGIEwu5wqrin7SxKDwhOQq/FQ2dbbFjVZc8j4Bw8F3DSuoqB1TPTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZdBBzgNk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YHfLCFcj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 16:00:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728403233;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAq+88YDfpZ9tT11XN0jVkuu680sFNkXTJbj/wfu4PY=;
	b=ZdBBzgNk4WBs4IjLx55a1H2nUdO5U2I1dAuNJtPAJldCoqPTkU6OWYDviKAJ70kd3S09fM
	grNe5L8rrspiVjXVTzn9W0JHuW4w3kWJidc5Pg8WhWuqdD1ICR1k7sAk3vV9GLrGyHaq6D
	PPHqpYv/NBFGdhlCItoktHEhyyo2j4yjF4ej8HWVrIy83iCh5ERJ5iqVp9+yGJHDinEF0y
	IPqnzwhOZs3vev0tKbjiZo3JB7NRr1msuC6DlHLh+kzGZPST7lU1BAD+zgXN/WAXWt+d7d
	gJ5ciVTdY1l97V+Ogghmto95iloYiVKaMWLgYxcCss6lCY9UEqzFWZtJx74lcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728403233;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAq+88YDfpZ9tT11XN0jVkuu680sFNkXTJbj/wfu4PY=;
	b=YHfLCFcjk0bctRrdHlcebfjCd1kDjTv8qGHEPdRO6nOfH3EYPW8yg1+q8nnWNgEpy5EJDi
	Mawugp0JYFko8rBg==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v4: Don't allow a VMOVP on a dying VPE
Cc: Kunkun Jiang <jiangkunkun@huawei.com>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <c182ece6-2ba0-ce4f-3404-dba7a3ab6c52@huawei.com>
References: <c182ece6-2ba0-ce4f-3404-dba7a3ab6c52@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172840323235.1442.15816504613853040169.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     1442ee0011983f0c5c4b92380e6853afb513841a
Gitweb:        https://git.kernel.org/tip/1442ee0011983f0c5c4b92380e6853afb513841a
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 02 Oct 2024 21:49:59 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 08 Oct 2024 17:44:27 +02:00

irqchip/gic-v4: Don't allow a VMOVP on a dying VPE

Kunkun Jiang reported that there is a small window of opportunity for
userspace to force a change of affinity for a VPE while the VPE has already
been unmapped, but the corresponding doorbell interrupt still visible in
/proc/irq/.

Plug the race by checking the value of vmapp_count, which tracks whether
the VPE is mapped ot not, and returning an error in this case.

This involves making vmapp_count common to both GICv4.1 and its v4.0
ancestor.

Fixes: 64edfaa9a234 ("irqchip/gic-v4.1: Implement the v4.1 flavour of VMAPP")
Reported-by: Kunkun Jiang <jiangkunkun@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/c182ece6-2ba0-ce4f-3404-dba7a3ab6c52@huawei.com
Link: https://lore.kernel.org/all/20241002204959.2051709-1-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c   | 18 ++++++++++++------
 include/linux/irqchip/arm-gic-v4.h |  4 +++-
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index fdec478..ab597e7 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -797,8 +797,8 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
 	its_encode_valid(cmd, desc->its_vmapp_cmd.valid);
 
 	if (!desc->its_vmapp_cmd.valid) {
+		alloc = !atomic_dec_return(&desc->its_vmapp_cmd.vpe->vmapp_count);
 		if (is_v4_1(its)) {
-			alloc = !atomic_dec_return(&desc->its_vmapp_cmd.vpe->vmapp_count);
 			its_encode_alloc(cmd, alloc);
 			/*
 			 * Unmapping a VPE is self-synchronizing on GICv4.1,
@@ -817,13 +817,13 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
 	its_encode_vpt_addr(cmd, vpt_addr);
 	its_encode_vpt_size(cmd, LPI_NRBITS - 1);
 
+	alloc = !atomic_fetch_inc(&desc->its_vmapp_cmd.vpe->vmapp_count);
+
 	if (!is_v4_1(its))
 		goto out;
 
 	vconf_addr = virt_to_phys(page_address(desc->its_vmapp_cmd.vpe->its_vm->vprop_page));
 
-	alloc = !atomic_fetch_inc(&desc->its_vmapp_cmd.vpe->vmapp_count);
-
 	its_encode_alloc(cmd, alloc);
 
 	/*
@@ -3807,6 +3807,13 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	unsigned long flags;
 
 	/*
+	 * Check if we're racing against a VPE being destroyed, for
+	 * which we don't want to allow a VMOVP.
+	 */
+	if (!atomic_read(&vpe->vmapp_count))
+		return -EINVAL;
+
+	/*
 	 * Changing affinity is mega expensive, so let's be as lazy as
 	 * we can and only do it if we really have to. Also, if mapped
 	 * into the proxy device, we need to move the doorbell
@@ -4463,9 +4470,8 @@ static int its_vpe_init(struct its_vpe *vpe)
 	raw_spin_lock_init(&vpe->vpe_lock);
 	vpe->vpe_id = vpe_id;
 	vpe->vpt_page = vpt_page;
-	if (gic_rdists->has_rvpeid)
-		atomic_set(&vpe->vmapp_count, 0);
-	else
+	atomic_set(&vpe->vmapp_count, 0);
+	if (!gic_rdists->has_rvpeid)
 		vpe->vpe_proxy_event = -1;
 
 	return 0;
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index ecabed6..7f1f11a 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -66,10 +66,12 @@ struct its_vpe {
 				bool	enabled;
 				bool	group;
 			}			sgi_config[16];
-			atomic_t vmapp_count;
 		};
 	};
 
+	/* Track the VPE being mapped */
+	atomic_t vmapp_count;
+
 	/*
 	 * Ensures mutual exclusion between affinity setting of the
 	 * vPE and vLPI operations using vpe->col_idx.

