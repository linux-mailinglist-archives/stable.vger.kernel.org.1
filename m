Return-Path: <stable+bounces-84698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE4199D192
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3E6F1F24648
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FFB1C0DFD;
	Mon, 14 Oct 2024 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LnSrXeJn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAEE1AB6DA;
	Mon, 14 Oct 2024 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918901; cv=none; b=DzTEe2FFeLhSSzxBVwAwY42Kv9Op+i43zv32YScuMfUKF6Sj3swDf3Y6j08vj31REGVCz8URnBH0uiceFAzs25q7Wbb012wDKZa7EeKAv4YbU3JecgbPLb//4rccnVCU8Ke3ALe2/8fvUiw7W33FsTYTPaaDwWisnAeUBhbzRSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918901; c=relaxed/simple;
	bh=MRVGZMo4YNQB+cj0v+eyNyJgcNVjdvezsDykBo9fU9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+GRbBz2/MkYVaBcxa51chXjocR0nqjqIu9aKKbnQXDx6Qw697rekXLjj3GqNXE+62CABytEHdx23JpIsj4p4xx8igRdqrRiqQtTWV798f7NFtgWzB9i6P3egWBPSDAadQzh1d9b+kRraPj1eoLZCCVhdgIGIDlVJO+S9TkjG4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LnSrXeJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7012AC4CEC3;
	Mon, 14 Oct 2024 15:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918901;
	bh=MRVGZMo4YNQB+cj0v+eyNyJgcNVjdvezsDykBo9fU9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LnSrXeJnsAdiQz81PqUvj5ur2hMN1LOmiXFAZOKXRkjN2q5i3z73lGpfDiflv8mzB
	 2urBEBfizn2KxiwieJ0o0+LSXJ3/klRiYwJgseA1g/Vmn/gnFFa9tp2W+yERTxDTgj
	 ckntnsc5Sq9vdqxcqFErWsWR6pK/gpzOw3Jy8rsY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 455/798] x86/ioapic: Handle allocation failures gracefully
Date: Mon, 14 Oct 2024 16:16:49 +0200
Message-ID: <20241014141235.846993017@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 830802a0fea8fb39d3dc9fb7d6b5581e1343eb1f ]

Breno observed panics when using failslab under certain conditions during
runtime:

   can not alloc irq_pin_list (-1,0,20)
   Kernel panic - not syncing: IO-APIC: failed to add irq-pin. Can not proceed

   panic+0x4e9/0x590
   mp_irqdomain_alloc+0x9ab/0xa80
   irq_domain_alloc_irqs_locked+0x25d/0x8d0
   __irq_domain_alloc_irqs+0x80/0x110
   mp_map_pin_to_irq+0x645/0x890
   acpi_register_gsi_ioapic+0xe6/0x150
   hpet_open+0x313/0x480

That's a pointless panic which is a leftover of the historic IO/APIC code
which panic'ed during early boot when the interrupt allocation failed.

The only place which might justify panic is the PIT/HPET timer_check() code
which tries to figure out whether the timer interrupt is delivered through
the IO/APIC. But that code does not require to handle interrupt allocation
failures. If the interrupt cannot be allocated then timer delivery fails
and it either panics due to that or falls back to legacy mode.

Cure this by removing the panic wrapper around __add_pin_to_irq_node() and
making mp_irqdomain_alloc() aware of the failure condition and handle it as
any other failure in this function gracefully.

Reported-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Breno Leitao <leitao@debian.org>
Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Link: https://lore.kernel.org/all/ZqfJmUF8sXIyuSHN@gmail.com
Link: https://lore.kernel.org/all/20240802155440.275200843@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/apic/io_apic.c | 46 ++++++++++++++++------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index efa87b6bb1cde..5e606477960ca 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -351,27 +351,26 @@ static void ioapic_mask_entry(int apic, int pin)
  * shared ISA-space IRQs, so we have to support them. We are super
  * fast in the common case, and fast for shared ISA-space IRQs.
  */
-static int __add_pin_to_irq_node(struct mp_chip_data *data,
-				 int node, int apic, int pin)
+static bool add_pin_to_irq_node(struct mp_chip_data *data, int node, int apic, int pin)
 {
 	struct irq_pin_list *entry;
 
-	/* don't allow duplicates */
-	for_each_irq_pin(entry, data->irq_2_pin)
+	/* Don't allow duplicates */
+	for_each_irq_pin(entry, data->irq_2_pin) {
 		if (entry->apic == apic && entry->pin == pin)
-			return 0;
+			return true;
+	}
 
 	entry = kzalloc_node(sizeof(struct irq_pin_list), GFP_ATOMIC, node);
 	if (!entry) {
-		pr_err("can not alloc irq_pin_list (%d,%d,%d)\n",
-		       node, apic, pin);
-		return -ENOMEM;
+		pr_err("Cannot allocate irq_pin_list (%d,%d,%d)\n", node, apic, pin);
+		return false;
 	}
+
 	entry->apic = apic;
 	entry->pin = pin;
 	list_add_tail(&entry->list, &data->irq_2_pin);
-
-	return 0;
+	return true;
 }
 
 static void __remove_pin_from_irq(struct mp_chip_data *data, int apic, int pin)
@@ -386,13 +385,6 @@ static void __remove_pin_from_irq(struct mp_chip_data *data, int apic, int pin)
 		}
 }
 
-static void add_pin_to_irq_node(struct mp_chip_data *data,
-				int node, int apic, int pin)
-{
-	if (__add_pin_to_irq_node(data, node, apic, pin))
-		panic("IO-APIC: failed to add irq-pin. Can not proceed\n");
-}
-
 /*
  * Reroute an IRQ to a different pin.
  */
@@ -1001,8 +993,7 @@ static int alloc_isa_irq_from_domain(struct irq_domain *domain,
 	if (irq_data && irq_data->parent_data) {
 		if (!mp_check_pin_attr(irq, info))
 			return -EBUSY;
-		if (__add_pin_to_irq_node(irq_data->chip_data, node, ioapic,
-					  info->ioapic.pin))
+		if (!add_pin_to_irq_node(irq_data->chip_data, node, ioapic, info->ioapic.pin))
 			return -ENOMEM;
 	} else {
 		info->flags |= X86_IRQ_ALLOC_LEGACY;
@@ -3038,10 +3029,8 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 		return -ENOMEM;
 
 	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, info);
-	if (ret < 0) {
-		kfree(data);
-		return ret;
-	}
+	if (ret < 0)
+		goto free_data;
 
 	INIT_LIST_HEAD(&data->irq_2_pin);
 	irq_data->hwirq = info->ioapic.pin;
@@ -3050,7 +3039,10 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 	irq_data->chip_data = data;
 	mp_irqdomain_get_attr(mp_pin_to_gsi(ioapic, pin), data, info);
 
-	add_pin_to_irq_node(data, ioapic_alloc_attr_node(info), ioapic, pin);
+	if (!add_pin_to_irq_node(data, ioapic_alloc_attr_node(info), ioapic, pin)) {
+		ret = -ENOMEM;
+		goto free_irqs;
+	}
 
 	mp_preconfigure_entry(data);
 	mp_register_handler(virq, data->is_level);
@@ -3065,6 +3057,12 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 		    ioapic, mpc_ioapic_id(ioapic), pin, virq,
 		    data->is_level, data->active_low);
 	return 0;
+
+free_irqs:
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+free_data:
+	kfree(data);
+	return ret;
 }
 
 void mp_irqdomain_free(struct irq_domain *domain, unsigned int virq,
-- 
2.43.0




