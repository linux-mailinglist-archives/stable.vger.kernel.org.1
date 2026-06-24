Return-Path: <stable+bounces-268198-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9xS3HIILPGqejAgAu9opvQ
	(envelope-from <stable+bounces-268198-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 18:53:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE8F6C01C3
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 18:53:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268198-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-268198-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C35B30135E2
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 16:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057A634C990;
	Wed, 24 Jun 2026 16:51:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cache8.serv00.com (cache8.serv00.com [128.204.223.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA1C33DEF7;
	Wed, 24 Jun 2026 16:51:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319915; cv=none; b=KIjELuLJ9q4mALpe20PkpoHpTn8hGGMq0YwIWXyQibBOrkc28JfUIP5QJ6uBQ6P1ibpMgdzQqt/4R0/MeGcOqEDZX6DlXr+mRhhzwPi2Nl3sLbZ6JKEuWmooAcm+ZHvPrYhFfbZvpVbdpebzD/GWmp5u1cXQFlti7WSj8OQIrRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319915; c=relaxed/simple;
	bh=49+HNziQ6DaJS8BYEKYppoYy7/F7F+2/UbGJSXITjQ8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=E7TTBIM5fHDW1iASYyLlWJxx2HR3Oa8lLpGa35FypnLFGvltVS+nUi86UlHKjSFMvPptH/ISPr0kjWyVhtoO5w3xZR43slTOq95TdFBFILmtk/wjTnosotc9YbMi8ESW04sbe9rWUKuZ7A0dHqd1Q4FVKpLNX3vURsBmj1RjbCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simplelinux.cn.eu.org; spf=pass smtp.mailfrom=simplelinux.cn.eu.org; arc=none smtp.client-ip=128.204.223.114
Message-ID: <a4c057ae-cba3-453d-8bd0-54c94dbfe491@simplelinux.cn.eu.org>
Date: Thu, 25 Jun 2026 00:15:36 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yuanzhen Gan <elysia-best@simplelinux.cn.eu.org>
Subject: Re: [PATCH] LoongArch: Add PIO for early access before ACPI PCI root
 register
Reply-To: elysia-best@simplelinux.cn.eu.org
To: Huacai Chen <chenhuacai@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
 Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Kexy Biscuit <kexybiscuit@aosc.io>,
 Mingcong Bai <jeffbai@aosc.io>
References: <20260622065843.3961572-1-chenhuacai@loongson.cn>
Content-Language: en-US
Autocrypt: addr=elysia-best@simplelinux.cn.eu.org; keydata=
 xjMEaJsoJxYJKwYBBAHaRw8BAQdAmKn44BnjrSjnLk+4kelzELvhTTWpOZTPmez2jy8squ3N
 KkVseXNpYSA8ZWx5c2lhLWJlc3RAc2ltcGxlbGludXguY24uZXUub3JnPsKPBBMWCAA3FiEE
 dKkzyG7ab0S7lAwAAxs1vPhHLWAFAmibKCcFCQWjmoACGwMECwkIBwUVCAkKCwUWAgMBAAAK
 CRADGzW8+EctYL66AQDlhTx8ZtQRjonY5JZbBWPQVwKrtjiANGgP5/uQLMR6/wD8CXOeYIYb
 qQVkLZZmcf/iabf19/mheoBBsyh4BrUCPQzOOARomygnEgorBgEEAZdVAQUBAQdAbDmqQT+f
 Z6Ivru0sdFV+yHivtibOx9K+K4riXcwfajYDAQgHwn4EGBYIACYWIQR0qTPIbtpvRLuUDAAD
 GzW8+EctYAUCaJsoJwUJBaOagAIbDAAKCRADGzW8+EctYDIvAQCtWFldeDqEJZ5C/JDBcogi
 zbSGxdlsfdtUyI69Y86lWwD8DlA4dIOH0o5tohTYA6hw74fAmR1jMkPfEE8dsy0ohg8=
In-Reply-To: <20260622065843.3961572-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-System-Sender: elysia-best@simplelinux.cn.eu.org
X-System-UID: 5146
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[simplelinux.cn.eu.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268198-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:chenhuacai@loongson.cn,m:chenhuacai@kernel.org,m:loongarch@lists.linux.dev,m:lixuefeng@loongson.cn,m:guoren@kernel.org,m:kernel@xen0n.name,m:jiaxun.yang@flygoat.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:kexybiscuit@aosc.io,m:jeffbai@aosc.io,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[elysia-best@simplelinux.cn.eu.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	HAS_REPLYTO(0.00)[elysia-best@simplelinux.cn.eu.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elysia-best@simplelinux.cn.eu.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,simplelinux.cn.eu.org:replyto,simplelinux.cn.eu.org:email,simplelinux.cn.eu.org:mid,simplelinux.cn.eu.org:from_mime,aosc.io:email,loongson.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6FE8F6C01C3

On Mon, 22 Jun 2026 14:58:43 +0800, Huacai Chen <chenhuacai@loongson.cn> 
wrote:
  > For ACPI system we suppose the ISA/LPC PIO range is registered together
  > with PCI root bridge. But the fact is there may be some early access to
  > the ISA/LPC PIO range before ACPI PCI root register (most of them are
  > due to abnormal BIOS). Unconditionally register the ISA/LPC PIO range
  > usually causes ACPI PCI root register fail because of the address range
  > confliction. So we add a pair of helpers: acpi_add_early_pio() to add
  > PIO for early access, and acpi_remove_early_pio() to remove PIO before
  > PCI root register. Since acpi_remove_early_pio() may be called multiple
  > times, we add an acpi_pio flag to ensure PIO be removed only once.
  >
  > Cc: <stable@vger.kernel.org>
  > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
  > ---
  >  arch/loongarch/include/asm/acpi.h |  2 ++
  >  arch/loongarch/kernel/acpi.c      | 28 ++++++++++++++++++++++++++++
  >  arch/loongarch/kernel/setup.c     |  2 ++
  >  arch/loongarch/pci/acpi.c         |  2 ++
  >  4 files changed, 34 insertions(+)
  >
  > diff --git a/arch/loongarch/include/asm/acpi.h 
b/arch/loongarch/include/asm/acpi.h
  > index eda9d4d0a493..c05168aedcaa 100644
  > --- a/arch/loongarch/include/asm/acpi.h
  > +++ b/arch/loongarch/include/asm/acpi.h
  > @@ -38,6 +38,8 @@ static inline bool acpi_has_cpu_in_madt(void)
  >  extern struct list_head acpi_wakeup_device_list;
  >  extern struct acpi_madt_core_pic acpi_core_pic[MAX_CORE_PIC];
  >
  > +extern void acpi_add_early_pio(void);
  > +extern void acpi_remove_early_pio(void);
  >  extern int __init parse_acpi_topology(void);
  >
  >  #endif /* !CONFIG_ACPI */
  > diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
  > index 058f0dbe8e8f..8f650c9ffecd 100644
  > --- a/arch/loongarch/kernel/acpi.c
  > +++ b/arch/loongarch/kernel/acpi.c
  > @@ -16,6 +16,7 @@
  >  #include <linux/memblock.h>
  >  #include <linux/of_fdt.h>
  >  #include <linux/serial_core.h>
  > +#include <linux/vmalloc.h>
  >  #include <asm/io.h>
  >  #include <asm/numa.h>
  >  #include <asm/loongson.h>
  > @@ -59,6 +60,33 @@ void __iomem 
*acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
  >  		return ioremap_cache(phys, size);
  >  }
  >
  > +#define PIO_BASE (unsigned long)PCI_IOBASE
  > +#define PIO_SIZE ALIGN(ISA_IOSIZE, PAGE_SIZE)
  > +
  > +static bool acpi_pio;
  > +
  > +/* Add PIO for early access */
  > +void acpi_add_early_pio(void)
  > +{
  > +	if (!acpi_disabled) {
  > +		acpi_pio = true;
  > +		vmap_page_range(PIO_BASE, PIO_BASE + PIO_SIZE,
  > +				LOONGSON_LIO_BASE, pgprot_device(PAGE_KERNEL));
  > +	}
  > +}
  > +
  > +/* Remove PIO for PCI register */
  > +void acpi_remove_early_pio(void)
  > +{
  > +	if (!acpi_pio)
  > +		return;
  > +
  > +	if (!acpi_disabled) {
  > +		acpi_pio = false;
  > +		vunmap_range(PIO_BASE, PIO_BASE + PIO_SIZE);
  > +	}
  > +}
  > +
  >  #ifdef CONFIG_SMP
  >  static int set_processor_mask(u32 id, u32 pass)
  >  {
  > diff --git a/arch/loongarch/kernel/setup.c 
b/arch/loongarch/kernel/setup.c
  > index 369262117c63..eaebb52bd36e 100644
  > --- a/arch/loongarch/kernel/setup.c
  > +++ b/arch/loongarch/kernel/setup.c
  > @@ -502,6 +502,8 @@ static __init int arch_reserve_pio_range(void)
  >  {
  >  	struct device_node *np;
  >
  > +	acpi_add_early_pio();
  > +
  >  	for_each_node_by_name(np, "isa") {
  >  		struct of_range range;
  >  		struct of_range_parser parser;
  > diff --git a/arch/loongarch/pci/acpi.c b/arch/loongarch/pci/acpi.c
  > index b02698a338ee..ccbcea61fcd9 100644
  > --- a/arch/loongarch/pci/acpi.c
  > +++ b/arch/loongarch/pci/acpi.c
  > @@ -65,6 +65,8 @@ static int acpi_prepare_root_resources(struct 
acpi_pci_root_info *ci)
  >  	struct resource_entry *entry, *tmp;
  >  	struct acpi_device *device = ci->bridge;
  >
  > +	acpi_remove_early_pio();
  > +
  >  	status = acpi_pci_probe_root_resources(ci);
  >  	if (status > 0) {
  >  		acpi_evaluate_integer(device->handle, "PCIH", NULL, &pci_h);

I have tested this patch on my Loongson-3A6000 system with Kunlun 
firmware. The patch successfully resolves the ACPI PCI root bridge 
registration issue caused by early ISA/LPC PIO access.

On this platform, the DSDT defines _CRS methods for UAR and LPT devices 
that call the ENFG() and EXFG() methods from the ITE1 device. This 
causes early writes to the ISA/LPC PIO range before PCI root bridge 
registration. The patch's early PIO registration mechanism properly 
handles this firmware quirk.

Test environment:
- Platform: Seewo OEM 3A6000 (CB,L3A6.MA01 V1.0)
- Firmware: Kunlun BIOS
- CPU: Loongson-3A6000-HV @ 2.50 GHz
- OS: AOSC OS 13.2.0 (loongarch64)
- Kernel: Linux 7.0.13-aosc-main-16k

The system boots successfully when the patch is applied.

Cc: Mingcong Bai <jeffbai@aosc.io>
Cc: Kexy Biscuit <kexybiscuit@aosc.io>
Tested-by: Yuanzhen Gan <elysia-best@simplelinux.cn.eu.org>


