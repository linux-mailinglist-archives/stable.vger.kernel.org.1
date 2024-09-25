Return-Path: <stable+bounces-77419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3182C985D12
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548591C24D8C
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D185A1B0139;
	Wed, 25 Sep 2024 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbMFNOVQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC4A1D9329;
	Wed, 25 Sep 2024 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265697; cv=none; b=nbzyrMAZH+HZ8FJeyeJfgryxIjKWkw/7xqok6mlUod/OY9BorfAFsXUuaEn3EmzFAjYNxtoEbM8WYXWUMeXEQQBYmPNu/cLQotc1925uBMqpkSJs2Kv0gGuHdWx/7MjqIhl69w+81nvbjGDGwQHCGDmtUbTg8PQka4ftViJPS/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265697; c=relaxed/simple;
	bh=eY6CaTPrbIw6JVjRw/wi01WOdt7z8xWaDckHtDFr7WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFrJHpXqAErs07126/j/yem9itL1Cfp4mG4qqXv/kRFLCFBe+9I14pbJi6i51xiW0L+psTV8wTjqu7vSFt6UeBAtFCq0qjFiqiSW5vZ1Nbi+2bBkh4IFmaRhDkTFd2+hDfH189bOUpgM8K3UgV3ReNd3PQHjJ35Pv+Fhi4PoOsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbMFNOVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03A6C4CEC7;
	Wed, 25 Sep 2024 12:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265697;
	bh=eY6CaTPrbIw6JVjRw/wi01WOdt7z8xWaDckHtDFr7WI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VbMFNOVQGm81LPu5Xo4uQelAm5APg+5jqz8iURGcfH8YW5RdOCjT90H3nQWBujb1N
	 wAXcOiuFaUHdyiUGNZ9s7SONTnrTfruisnasg0XshlXDupNSRtIpbv7vGTqpZokvnt
	 31sk5SyW8mU9TWCcKgS070ei8MTwtWiJnWPxqt/WMgxS7GUEIzd7A8Yt+kCNqIqOib
	 r9xDtRJhJOpDnfbsdeZysGmmIg4orQPgYFw5b9K9F2WNSjOisXzsZGdqqIEm+otarh
	 UdyKY5M6kMiloYpJo5jemlXDoiUgM7FlzY5V1wHQh6EdcFvk8qaBuU+vR8Q3aNLoIE
	 FSv6+3qsWxKWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Breno Leitao <leitao@debian.org>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	ahuang12@lenovo.com,
	maz@kernel.org
Subject: [PATCH AUTOSEL 6.10 074/197] x86/ioapic: Handle allocation failures gracefully
Date: Wed, 25 Sep 2024 07:51:33 -0400
Message-ID: <20240925115823.1303019-74-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

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
index 477b740b2f267..d1ec1dcb637af 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -352,27 +352,26 @@ static void ioapic_mask_entry(int apic, int pin)
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
@@ -387,13 +386,6 @@ static void __remove_pin_from_irq(struct mp_chip_data *data, int apic, int pin)
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
@@ -1002,8 +994,7 @@ static int alloc_isa_irq_from_domain(struct irq_domain *domain,
 	if (irq_data && irq_data->parent_data) {
 		if (!mp_check_pin_attr(irq, info))
 			return -EBUSY;
-		if (__add_pin_to_irq_node(irq_data->chip_data, node, ioapic,
-					  info->ioapic.pin))
+		if (!add_pin_to_irq_node(irq_data->chip_data, node, ioapic, info->ioapic.pin))
 			return -ENOMEM;
 	} else {
 		info->flags |= X86_IRQ_ALLOC_LEGACY;
@@ -3017,10 +3008,8 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
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
@@ -3029,7 +3018,10 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 	irq_data->chip_data = data;
 	mp_irqdomain_get_attr(mp_pin_to_gsi(ioapic, pin), data, info);
 
-	add_pin_to_irq_node(data, ioapic_alloc_attr_node(info), ioapic, pin);
+	if (!add_pin_to_irq_node(data, ioapic_alloc_attr_node(info), ioapic, pin)) {
+		ret = -ENOMEM;
+		goto free_irqs;
+	}
 
 	mp_preconfigure_entry(data);
 	mp_register_handler(virq, data->is_level);
@@ -3044,6 +3036,12 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
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


