Return-Path: <stable+bounces-241839-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGKPCg298WkHkQEAu9opvQ
	(envelope-from <stable+bounces-241839-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 10:10:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A1D491046
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 10:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E22FD303D2E6
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 08:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C5B3A7835;
	Wed, 29 Apr 2026 08:07:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE7B3A6B88;
	Wed, 29 Apr 2026 08:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777450042; cv=none; b=sWiAR+orQSbftOdOYddb7Uwe7zFuP/EvtW3OekwhLitzjGWGN8zg/64C/u6xRZkT5Hy3LrP5UpTgHUsIFOX9xK5m5tGJJz55A8rix3PBEaY2BV99KMxdTb6AtiPsFQysemUNOJsFL1yKXEiw/ngduti8exKoclFDH193ZtYRc0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777450042; c=relaxed/simple;
	bh=wGu32IMiCnyAgb/TzjLP4pLAkh62VIhosTQmkTrQI4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJ8Y8VfOuMurgdcHUPGs3ba1hsIFrEkhSl4vdjgk7vHbIkVCTx/m4EA3uNBmuTLLemjGLKn2y6yNWScYGuidFg3pPVqkHJMVYyTFFWhpS7FZsHeIXkapuqDXTWEh+HODhhoxRlDEce+CAzozUaGarC3K13rdAocNmdLUEwU7+wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.8])
	by gateway (Coremail) with SMTP id _____8AxFek1vPFpVBAFAA--.11038S3;
	Wed, 29 Apr 2026 16:07:17 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.8])
	by front1 (Coremail) with SMTP id qMiowJDxhcAwvPFp7ix3AA--.43297S2;
	Wed, 29 Apr 2026 16:07:16 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org,
	Chao Li <lichao@loongson.cn>,
	Dongyan Qian <qiandongyan@loongson.cn>
Subject: [PATCH] LoongArch: Use per-root-bridge PCIH flag to skip mem resource fixup
Date: Wed, 29 Apr 2026 16:07:04 +0800
Message-ID: <20260429080704.2425187-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxhcAwvPFp7ix3AA--.43297S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFy5Gr17AFW7ArWkurWfWFX_yoW8tF1fpF
	ySvw48Gr48Gw17Kws8X34UXF4rZF9YkrW3WF43G34a9an5XryUZw45uryqqa45Aan5Ka1Y
	qFWDJryUWF4DAagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU8EeHDUUUUU==
X-Rspamd-Queue-Id: 79A1D491046
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241839-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@loongson.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.440];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:mid,loongson.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

When firmware enables 64-bit PCI host bridge support, some root bridges
already provide valid 64-bit mem resource windows through ACPI.

In this case, the LoongArch-specific mem resource high-bits fixup in
acpi_prepare_root_resources() should not be applied unconditionally.
Otherwise, the kernel may override the native resource layout derived
from firmware, and later BAR assignment can fail to place device BARs
into the intended 64-bit address space correctly.

Add a per-root-bridge ACPI flag, PCIH, and evaluate it from the current
root bridge device scope. When PCIH is set, skip the mem resource high-
bits fixup path and let the kernel use the firmware-provided resource
description directly. When PCIH is absent or cleared, keep the existing
behavior and continue filling the high address bits from the host bridge
address.

This makes the behavior per-root-bridge configurable and avoids breaking
valid 64-bit BAR space allocation on bridges whose 64-bit windows have
already been fully described by firmware.

Cc: stable@vger.kernel.org
Suggested-by: Chao Li <lichao@loongson.cn>
Tested-by: Dongyan Qian <qiandongyan@loongson.cn>
Signed-off-by: Dongyan Qian <qiandongyan@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/pci/acpi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/loongarch/pci/acpi.c b/arch/loongarch/pci/acpi.c
index 0dde3ddcd544..b02698a338ee 100644
--- a/arch/loongarch/pci/acpi.c
+++ b/arch/loongarch/pci/acpi.c
@@ -61,11 +61,16 @@ static void acpi_release_root_info(struct acpi_pci_root_info *ci)
 static int acpi_prepare_root_resources(struct acpi_pci_root_info *ci)
 {
 	int status;
+	unsigned long long pci_h = 0;
 	struct resource_entry *entry, *tmp;
 	struct acpi_device *device = ci->bridge;
 
 	status = acpi_pci_probe_root_resources(ci);
 	if (status > 0) {
+		acpi_evaluate_integer(device->handle, "PCIH", NULL, &pci_h);
+		if (pci_h)
+			return status;
+
 		resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
 			if (entry->res->flags & IORESOURCE_MEM) {
 				entry->offset = ci->root->mcfg_addr & GENMASK_ULL(63, 40);
-- 
2.52.0


