Return-Path: <stable+bounces-23683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E062A8674FF
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 13:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A253283BA1
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 12:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B41E6350F;
	Mon, 26 Feb 2024 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eTBC1wnC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1785633EF
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950654; cv=none; b=D/etP5MZNbV5HmDRJZpqqO6/y7P5yqhoh8XYsslxyWzGI9STDI9+RCgZYyHhegYgTFaFX4AC6k/oywqB4RbCZpTeKm5OIyeFMCdU5TzBe0qnCZEgJ4rtxq82HindnwTIApilwTmuNUUVjazpOWUYiej9LTEFbwT5qHawMV5PuOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950654; c=relaxed/simple;
	bh=9aScO8XkyGOJZIXe6eN1r9cuwhNBuX8XI2o/2TD5u4E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jGyXgpXaEuHLGtKrOMrzCArwyT1PUxjZCqSshoNHYSBn+Ig1zATxFlFHvi9/CseSe4tLjnBovNfd99EhLZuMIoD8Dk4lbfC9qK7eO2TlVoUNQ4hlGaw1F1yRj4wJ65Y4LunSAkAENjDkNCbLLwqlzut9mTtSH77azsM3yIzcgWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eTBC1wnC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AECAC433C7;
	Mon, 26 Feb 2024 12:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708950653;
	bh=9aScO8XkyGOJZIXe6eN1r9cuwhNBuX8XI2o/2TD5u4E=;
	h=Subject:To:Cc:From:Date:From;
	b=eTBC1wnCYwcDOCRego3PO9MFbLrPFPphb5Srv7m5ryHieI0nfVv9vFWLFV5Gc3K6e
	 vUyKOBXaoS4I2wjH5kDPHS5tRax2Qz2csu/9y0PduQKqgwGYK7IXgpZ93hp9tBER76
	 g2k2s2Xoghux1dfZm3Cb1SWRd2jkrCqudV3/8xMs=
Subject: FAILED: patch "[PATCH] irqchip/gic-v3-its: Do not assume vPE tables are preallocated" failed to apply to 5.15-stable tree
To: oliver.upton@linux.dev,gcherian@marvell.com,maz@kernel.org,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Feb 2024 13:30:50 +0100
Message-ID: <2024022650-washroom-undusted-2aff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ec4308ecfc887128a468f03fb66b767559c57c23
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022650-washroom-undusted-2aff@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

ec4308ecfc88 ("irqchip/gic-v3-its: Do not assume vPE tables are preallocated")
c0cdc89072a3 ("irqchip/gic-v3-its: Give the percpu rdist struct its own flags field")

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


