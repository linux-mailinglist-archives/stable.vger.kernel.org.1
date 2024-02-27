Return-Path: <stable+bounces-24098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1B38692A0
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EDC11C216E2
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D373213B2AC;
	Tue, 27 Feb 2024 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y2raaKZb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C078B61;
	Tue, 27 Feb 2024 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041027; cv=none; b=jEdXuaq44OY7k1vX1A7GmI30kJGRaMDE+lmkmZLzbW+BlsOvWhpkjUxFSglBoKw2NNQDXQBGnKmedRah27vFP+hOYx9WINRU35V9WCNE2EaAFnoxrUOHvIRpRjUL+SBOT8RtUDOrN6c5kdue43psF9geNKSiYygvL8pHcuLtrqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041027; c=relaxed/simple;
	bh=REzhQlR79ZWmUo2eub80ybvmDxUFVhr5ujbIqP7kD2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TpttxDpbBmHsR//FsI0chkhg+pK1auZIslu3qoliZUOeR/EHAgIQaF/3rosWZxzzUAYeJIGZUuh/OMUWWqdhC+DNj8QKPEYsT1usyKsFX7fUwD2mZ5h8Do5v93GM40KtYPuut4ocVgOsIT5Zc+1wA/0FZxyzaAZpR4SjdUstlew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y2raaKZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1829DC433C7;
	Tue, 27 Feb 2024 13:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041027;
	bh=REzhQlR79ZWmUo2eub80ybvmDxUFVhr5ujbIqP7kD2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y2raaKZb3TBKzFQvim1CiaUB7CKWNUx/C7t9dqIIpj6jr44FSPBHzVxq4StZxn3Os
	 V2rWHtTLDK8MkLsLIP9uRih7Ky7q9UnCzvT9jzY18AO1dT88VGURO8u3gHwrmlCRop
	 hN5vEiVV1T4UU6UkhOKsR2mkzJlni77BihuXggqQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	George Cherian <gcherian@marvell.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 6.7 194/334] irqchip/gic-v3-its: Do not assume vPE tables are preallocated
Date: Tue, 27 Feb 2024 14:20:52 +0100
Message-ID: <20240227131636.959160853@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Upton <oliver.upton@linux.dev>

commit ec4308ecfc887128a468f03fb66b767559c57c23 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-gic-v3-its.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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



