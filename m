Return-Path: <stable+bounces-210462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B75BD3C3E5
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 10:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CFDE68130C
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 09:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB953D3CF2;
	Tue, 20 Jan 2026 09:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dl091rOh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="89D+SmkN"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A024E3D3CF4;
	Tue, 20 Jan 2026 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900608; cv=none; b=Uxu0Zwr1Yu/wpCuAjDxlY2sTbB5sVk0ZZiMsE8yG+mzgxocaci10YenoYICoAbtFcmA8LNfY/BDXS9aw3U17yun15eGgcxd4/RzhAxU6onu4/JVu0CZaR02XG2liZkhBybFyXFpZM6dS2bcjA+S495K7jwjaHB6+9WNXHzPdsCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900608; c=relaxed/simple;
	bh=MKnEI4wXGnREWVIvl4mOC36iVROiOD6trGeDI9Bc0PU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=efHl1B+VqjPpXgZ65Gy08KvjqcB1rW8TGHQjwWVoRvXqwwf7LYPW4GT1bOFjLyOlAbPOuU/eaHX0XgvE0BMltvtuVRQVyOfbPVrloBpVFtVu7xwXTarLiSPQ7yEuB0O0yb6Qw2dqEJkdnZISeMt37dmtesVeZUfDjy809KntRQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dl091rOh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=89D+SmkN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Jan 2026 09:16:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768900604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hxNhbyJEivzoznFWaiIoRCDOCS9Vu6oTNEvfPxOzV6s=;
	b=Dl091rOhJ52kp+I4VMfJr8bp4HwuRNG+6x/4zIQAJVJfBAHe9Vot5N7ktJCGss5i9MKbxa
	Fn+QE2iMb1KJFcxYAPFahYpw3fCciutD9xIkhQ26dZnix2NC2/DxQpCvuH5ckUh4Os0thL
	Lpy+O9qnotyiyX8hGNNM76OJ8zslSBIgOLkXJ2M21nWWDrd0q0dBK7BGjvTP/j2W7EzBKV
	IH+69rIN1kQy+KSn+pgTcP/jfEdHeuEPdwd9rFyFv+Z2rUgPoZjWzDp0mk6ith/MalT+8p
	FvvNyxK7zrSWXvyrbYOMpd4mO5l8hkblSH1E6ZuxRXUbCRx9pMLGRnP3jcYlFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768900604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hxNhbyJEivzoznFWaiIoRCDOCS9Vu6oTNEvfPxOzV6s=;
	b=89D+SmkNAWsM+NMPQbDeD4oCMZstR1VJLAsF4ev6xi2hjwly8LomENYAHltNOvoKnuGNfB
	cDUK+uelH4afjuDQ==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] irqchip/gic-v3-its: Avoid truncating memory addresses
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>,
 Marc Zyngier <maz@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260119201603.2713066-1-arnd@kernel.org>
References: <20260119201603.2713066-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176890059957.510.2813927143084043841.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     8d76a7d89c12d08382b66e2f21f20d0627d14859
Gitweb:        https://git.kernel.org/tip/8d76a7d89c12d08382b66e2f21f20d0627d=
14859
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Mon, 19 Jan 2026 21:15:12 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 20 Jan 2026 10:11:29 +01:00

irqchip/gic-v3-its: Avoid truncating memory addresses

On 32-bit machines with CONFIG_ARM_LPAE, it is possible for lowmem
allocations to be backed by addresses physical memory above the 32-bit
address limit, as found while experimenting with larger VMSPLIT
configurations.

This caused the qemu virt model to crash in the GICv3 driver, which
allocates the 'itt' object using GFP_KERNEL. Since all memory below
the 4GB physical address limit is in ZONE_DMA in this configuration,
kmalloc() defaults to higher addresses for ZONE_NORMAL, and the
ITS driver stores the physical address in a 32-bit 'unsigned long'
variable.

Change the itt_addr variable to the correct phys_addr_t type instead,
along with all other variables in this driver that hold a physical
address.

The gicv5 driver correctly uses u64 variables, while all other irqchip
drivers don't call virt_to_phys or similar interfaces. It's expected that
other device drivers have similar issues, but fixing this one is
sufficient for booting a virtio based guest.

Fixes: cc2d3216f53c ("irqchip: GICv3: ITS command queue")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260119201603.2713066-1-arnd@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-it=
s.c
index ada585b..2988def 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -709,7 +709,7 @@ static struct its_collection *its_build_mapd_cmd(struct i=
ts_node *its,
 						 struct its_cmd_block *cmd,
 						 struct its_cmd_desc *desc)
 {
-	unsigned long itt_addr;
+	phys_addr_t itt_addr;
 	u8 size =3D ilog2(desc->its_mapd_cmd.dev->nr_ites);
=20
 	itt_addr =3D virt_to_phys(desc->its_mapd_cmd.dev->itt);
@@ -879,7 +879,7 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_nod=
e *its,
 					   struct its_cmd_desc *desc)
 {
 	struct its_vpe *vpe =3D valid_vpe(its, desc->its_vmapp_cmd.vpe);
-	unsigned long vpt_addr, vconf_addr;
+	phys_addr_t vpt_addr, vconf_addr;
 	u64 target;
 	bool alloc;
=20
@@ -2477,10 +2477,10 @@ retry_baser:
 	baser->psz =3D psz;
 	tmp =3D indirect ? GITS_LVL1_ENTRY_SIZE : esz;
=20
-	pr_info("ITS@%pa: allocated %d %s @%lx (%s, esz %d, psz %dK, shr %d)\n",
+	pr_info("ITS@%pa: allocated %d %s @%llx (%s, esz %d, psz %dK, shr %d)\n",
 		&its->phys_base, (int)(PAGE_ORDER_TO_SIZE(order) / (int)tmp),
 		its_base_type_string[type],
-		(unsigned long)virt_to_phys(base),
+		(u64)virt_to_phys(base),
 		indirect ? "indirect" : "flat", (int)esz,
 		psz / SZ_1K, (int)shr >> GITS_BASER_SHAREABILITY_SHIFT);
=20

