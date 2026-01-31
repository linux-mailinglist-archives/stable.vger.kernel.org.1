Return-Path: <stable+bounces-212963-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBwiDA93fmlZZQIAu9opvQ
	(envelope-from <stable+bounces-212963-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 22:41:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84749C40BD
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 22:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C57B3019F2A
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 21:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96BC366802;
	Sat, 31 Jan 2026 21:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.b="cUAbjPlU"
X-Original-To: stable@vger.kernel.org
Received: from sg-1-23.ptr.blmpb.com (sg-1-23.ptr.blmpb.com [118.26.132.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA840367F5B
	for <stable@vger.kernel.org>; Sat, 31 Jan 2026 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769895622; cv=none; b=ZzROzjayu0IWAX5dVO5esIoFvb/wjMgSMXKR94KagQJyYQBIg70Y0WRXeAomPss0yutcv1ilXE3mQupSJKR0dMIBh2lAi1UllloyOIV8BuVvCHsmpExk7tMGZuTAgoOwxY29Obz32Sje23CDt/VMuKWQrMFMK13cyg+4CxXxUoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769895622; c=relaxed/simple;
	bh=JO0MPpLaBNFRB+tkUqJa6oEVpzFjRQGYn/mqydWirJY=;
	h=Cc:Mime-Version:Subject:Message-Id:In-Reply-To:Content-Type:To:
	 References:From:Date; b=er+dC/Qwcm7tvgYOSSxDWF06IVftA5S6ncj1m19Epui7y7r+FusGkPzyM8wmev790uCsq/rKlLSI+pLsBX4ejNGupjAmFpnd+1+DfyqOFk47gZykrsANbcsuPHENR/05iqaT8z7cjVwQwRnLYr6k6B8hCe4Y6zuH9TodjNTfAhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com; spf=pass smtp.mailfrom=oss.cipunited.com; dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.b=cUAbjPlU; arc=none smtp.client-ip=118.26.132.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1769895609;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=1w7UIR8sRaPsW3O428nS/3i5tUkg2B4CW9AvsT9+G4o=;
 b=cUAbjPlUlP90wACw51L49Di/PlUJH6LPUXfqYlVsFDg2Z2R54zFRAPp29MTG5q676CgHVI
 yUBfDtBTaExVOgdXiyJy936JsULLi1+904WTzWBJcuOLPxD855KYGhKLAHGSdrXhnuQyfy
 lmQGZeRX4N4mCol0KzgzmGrWzzjNRyZZ2ayO1Ht/F7IWe+MrkUUGk87FBNULUUYOeE7K3U
 tTElZaVGyy2rWGvnvimMKwPOhHILJxuX4gVyt3lRhHA/9n5zNmo4jIFY0X3blmrT7+D/J8
 TPL67mN7mhG0KudJhsouNS9mEUpgXcMCML/g/MQb65Zdju93PJiKfVrIDfSiiQ==
X-Original-From: Rong Zhang <rongrong@oss.cipunited.com>
Cc: "Rong Zhang" <rongrong@oss.cipunited.com>, "Rong Zhang" <i@rong.moe>, 
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	<linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Beiyan Yun" <root@infi.wang>, 
	"Yao Zi" <me@ziyao.cc>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+2697e76b8+ab85ff+vger.kernel.org+rongrong@oss.cipunited.com>
Received: from tb.lan ([223.88.91.217]) by smtp.feishu.cn with ESMTPS; Sun, 01 Feb 2026 05:40:07 +0800
Subject: [PATCH 2/2] MIPS: Loongson2ef: Use pcibios_align_resource() to block io range
Message-Id: <20260131214003.833520-3-rongrong@oss.cipunited.com>
Content-Transfer-Encoding: 7bit
In-Reply-To: <20260131214003.833520-1-rongrong@oss.cipunited.com>
Content-Type: text/plain; charset=UTF-8
To: "Jiaxun Yang" <jiaxun.yang@flygoat.com>, 
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
References: <20260131214003.833520-1-rongrong@oss.cipunited.com>
From: "Rong Zhang" <rongrong@oss.cipunited.com>
Date: Sun,  1 Feb 2026 05:32:59 +0800
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oss.cipunited.com,none];
	R_DKIM_ALLOW(-0.20)[oss.cipunited.com:s=feishu2303200042];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212963-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rongrong@oss.cipunited.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[oss.cipunited.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.cipunited.com:mid,oss.cipunited.com:dkim,ziyao.cc:email]
X-Rspamd-Queue-Id: 84749C40BD
X-Rspamd-Action: no action

Loongson2ef reserves io range below 0x4000 (LOONGSON_PCI_IO_START) while
ISA-mode only IDE controller on the south bridge still has a hard
dependency on ISA IO ports.

The reservation was done by lifting loongson_pci_io_resource.start onto
0x4000. Prior to commit ae81aad5c2e1 ("MIPS: PCI: Use
pci_enable_resources()"), the arch specific pcibios_enable_resources()
did not check if the resources were claimed, which diverges from what
PCI core checks, effectively hiding the fact that IDE IO resources were
not properly within the resource tree. After starting to use
pcibios_enable_resources() from PCI core, enabling IDE controller fails:

  pata_cs5536 0000:00:0e.2: BAR 0 [io  0x01f0-0x01f7]: not claimed; can't enable device
  pata_cs5536 0000:00:0e.2: probe with driver pata_cs5536 failed with error -22

MIPS PCI code already has support for enforcing lower bounds using
PCIBIOS_MIN_IO in pcibios_align_resource() without altering the IO
window start address itself. Make Loongson2ef PCI code use
PCIBIOS_MIN_IO too.

Fixes: ae81aad5c2e1 ("MIPS: PCI: Use pci_enable_resources()")
Cc: stable@vger.kernel.org
Tested-by: Beiyan Yun <root@infi.wang>
Tested-by: Yao Zi <me@ziyao.cc>
Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
---
 arch/mips/loongson2ef/common/pci.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/mips/loongson2ef/common/pci.c b/arch/mips/loongson2ef/common/pci.c
index 55524f9a7b96b..0f11392104bfd 100644
--- a/arch/mips/loongson2ef/common/pci.c
+++ b/arch/mips/loongson2ef/common/pci.c
@@ -17,7 +17,7 @@ static struct resource loongson_pci_mem_resource = {
 
 static struct resource loongson_pci_io_resource = {
 	.name	= "pci io space",
-	.start	= LOONGSON_PCI_IO_START,
+	.start	= 0x00000000UL, /* See loongson2ef_pcibios_init(). */
 	.end	= IO_SPACE_LIMIT,
 	.flags	= IORESOURCE_IO,
 };
@@ -77,6 +77,15 @@ void __init loongson2ef_pcibios_init(void)
 {
 	setup_pcimap();
 
+	/*
+	 * ISA-mode only IDE controllers have a hard dependency on ISA IO ports.
+	 *
+	 * Claim them by setting PCI IO space to start at 0x00000000, and set
+	 * PCIBIOS_MIN_IO to prevent non-legacy PCI devices from touching
+	 * reserved regions.
+	 */
+	PCIBIOS_MIN_IO = LOONGSON_PCI_IO_START;
+
 	loongson_pci_controller.io_map_base = mips_io_port_base;
 	register_pci_controller(&loongson_pci_controller);
 }
-- 
2.51.0

