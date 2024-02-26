Return-Path: <stable+bounces-23686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CAB867502
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 13:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96041C24ED0
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 12:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6546667754;
	Mon, 26 Feb 2024 12:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TkTc4v2O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2582566B25
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 12:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950666; cv=none; b=UOA3RE/B3ZeOk4Q41WSgEx4RLPeuj+81JS30TyDFd560vr0PzIqhzwZssKIg02gkhiev+tQalpVaiXzeuqpZeMcq0FVXDFKgwCU1pi+P9F+NHziJBrcF5XxwyUZ5XYPEIudpaAYf1c7VBzVoRA/jcyR8CONblRB4de5gJ/FRHBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950666; c=relaxed/simple;
	bh=+rKisg+OUaKtsILNy2sAxehhR1YE+jwtCmyOjgW1NjU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AFwtg6cYSHQl9V+aarlmf4MQ+UzLDqJMz89LrEAi6uj5TYschoWtHr5RqYeq85UG0zwDCSCTyDzJTgyyxunoNvrxs/P/oH7RY4vXf+ybenYhEk4YRQv6NPb0yKYLd2lJTP4Z48GZnv4CJInYlSTlqz9f/txFr8J8PcivdWoZh+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TkTc4v2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61057C433F1;
	Mon, 26 Feb 2024 12:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708950665;
	bh=+rKisg+OUaKtsILNy2sAxehhR1YE+jwtCmyOjgW1NjU=;
	h=Subject:To:Cc:From:Date:From;
	b=TkTc4v2O4bl/JuyH8mkxUCaMrDB71xv48aUDiKB745birnMatsBh9n7EEMZYZbwQj
	 Rjw1vhjU8Sk0zL3NugZUN+SUi24T25u7ZGseX+9zynmG8IvVUHPX48Wh79sQzCEieL
	 FcLPFB8lS+HEpFM9KYhqa7X5d/2iQiomx/nr0FgE=
Subject: FAILED: patch "[PATCH] irqchip/gic-v3-its: Do not assume vPE tables are preallocated" failed to apply to 4.19-stable tree
To: oliver.upton@linux.dev,gcherian@marvell.com,maz@kernel.org,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Feb 2024 13:31:02 +0100
Message-ID: <2024022602-daunting-dreamland-882c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x ec4308ecfc887128a468f03fb66b767559c57c23
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022602-daunting-dreamland-882c@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

ec4308ecfc88 ("irqchip/gic-v3-its: Do not assume vPE tables are preallocated")
c0cdc89072a3 ("irqchip/gic-v3-its: Give the percpu rdist struct its own flags field")
5e5168461c22 ("irqchip/gic-v4.1: VPE table (aka GICR_VPROPBASER) allocation")
b25319d279b6 ("irqchip/gic-v3: Detect GICv4.1 supporting RVPEID")
576a83429757 ("irqchip/gic-v3-its: Kill its->device_ids and use TYPER copy instead")
ffedbf0cba15 ("irqchip/gic-v3-its: Kill its->ite_size and use TYPER copy instead")
0dd57fed6b46 ("irqchip/gic-v3-its: Make is_v4 use a TYPER copy")
8424312516e5 ("irqchip/gic-v3-its: Use the exact ITSList for VMOVP")
5f51f803826e ("irqchip/gic-v3: Add EPPI range support")
81a43273045b ("irqchip/gic-v3: Dynamically allocate PPI NMI refcounts")
1a60e1e64391 ("irqchip/gic: Prepare for more than 16 PPIs")
211bddd210a6 ("irqchip/gic-v3: Add ESPI range support")
e91b036e1c20 ("irqchip/gic-v3: Add INTID range and convertion primitives")
13d22e2e1f35 ("irqchip/gic: Rework gic_configure_irq to take the full ICFGR base")
3d8dfe75ef69 ("Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ec4308ecfc887128a468f03fb66b767559c57c23 Mon Sep 17 00:00:00 2001
From: Oliver Upton <oliver.upton@linux.dev>
Date: Mon, 19 Feb 2024 18:58:06 +0000
Subject: [PATCH] irqchip/gic-v3-its: Do not assume vPE tables are preallocated

The GIC/ITS code is designed to ensure to pick up any preallocated LPI
tables on the redistributors, as enabling LPIs is a one-way switch. There
is no such restriction for vLPIs, and for GICv4.1 it is expected to
allocate a new vPE table at boot.

This works as intended when initializing an ITS, however when setting up a
redistributor in cpu_init_lpis() the early return for preallocated RD
tables skips straight past the GICv4 setup. This all comes to a head when
trying to kexec() into a new kernel, as the new kernel silently fails to
set up GICv4, leading to a complete loss of SGIs and LPIs for KVM VMs.

Slap a band-aid on the problem by ensuring its_cpu_init_lpis() always
initializes GICv4 on the way out, even if the other RD tables were
preallocated.

Fixes: 6479450f72c1 ("irqchip/gic-v4: Fix occasional VLPI drop")
Reported-by: George Cherian <gcherian@marvell.com>
Co-developed-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240219185809.286724-2-oliver.upton@linux.dev

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 53abd4779914..b822752c4261 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3181,6 +3181,7 @@ static void its_cpu_init_lpis(void)
 	val |= GICR_CTLR_ENABLE_LPIS;
 	writel_relaxed(val, rbase + GICR_CTLR);
 
+out:
 	if (gic_rdists->has_vlpis && !gic_rdists->has_rvpeid) {
 		void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
 
@@ -3216,7 +3217,6 @@ static void its_cpu_init_lpis(void)
 
 	/* Make sure the GIC has seen the above */
 	dsb(sy);
-out:
 	gic_data_rdist()->flags |= RD_LOCAL_LPI_ENABLED;
 	pr_info("GICv3: CPU%d: using %s LPI pending table @%pa\n",
 		smp_processor_id(),


