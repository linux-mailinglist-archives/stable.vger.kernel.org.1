Return-Path: <stable+bounces-220821-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAKwDkFNo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220821-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:17:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB91E1C823A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36FBB330A4AF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3BC414BE9;
	Sat, 28 Feb 2026 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idxqwU+t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8D6414BE3;
	Sat, 28 Feb 2026 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300707; cv=none; b=qjxTicEmzIFXrsIXt17dyMPCMQaXDAqmAHsUs2nn2YwXZVRBPA1yPeVYCzv31VVOvXin9CcOhqXtZ/UsdzK3R7tZCjOakavnKJ9T3AKZVbYVMjGBknslEafI0QlxgCE7rucpQEuy4lRoz3dK6IcPaNx1pulgmcMSzpU/223L0dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300707; c=relaxed/simple;
	bh=POVVDLSYNt4aqCKww6t4rhfVjfjD+cYHX5CfY2Bk1SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDi2CQdQIjrIDJw/euEAC+zB1dnciRjIauBB/6haEtz0YievV0ywLepR4TeQRQ+7Iy5sPLGRQhJYdd1YGJ8SqDO6+MLDY4wxeH9mimo/IR8q4iORBVNpMgkjwjwyLMeka24Horsh45XXZbzCFvV8yytg1Cara2butluUfKxp9tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idxqwU+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA92FC116D0;
	Sat, 28 Feb 2026 17:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300706;
	bh=POVVDLSYNt4aqCKww6t4rhfVjfjD+cYHX5CfY2Bk1SE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=idxqwU+tkce8n+F1kQLF3q0NFEO527lqqDmonVC2SLc0eOJp6/Tv85g2D87wCSv2Q
	 Lerg0AFcq9lra1di9KtU64eebge1C0UxRxycsrMYCWVC4pRQWq0nvYtqnyFntwt0s4
	 BhDzQTUFGYKi0AZLS/jiOxWEAEQpXKYlOMai/U5quy+P2WzHW4GouD/LlQ29kGbVHt
	 Bp1PbF+Zh4IxEBcuo6vIH/XwUPXj73aL+9pwH/A7q3bqm+1wc+vYkkP9mEIOfvwp01
	 9K08nc1fMTmgf5V1svu3/cjyQJ2ab+zVc9KNhG7LIKsGnmb1LfWISmttKrE38OYv4W
	 5PCi54QDCAixQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rong Zhang <rongrong@oss.cipunited.com>,
	Beiyan Yun <root@infi.wang>,
	Yao Zi <me@ziyao.cc>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 742/844] MIPS: Loongson2ef: Use pcibios_align_resource() to block io range
Date: Sat, 28 Feb 2026 12:30:55 -0500
Message-ID: <20260228173244.1509663-743-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[ziyao.cc:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-220821-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.965];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infi.wang:email,flygoat.com:email,franken.de:email,cipunited.com:email]
X-Rspamd-Queue-Id: CB91E1C823A
X-Rspamd-Action: add header
X-Spam: Yes

From: Rong Zhang <rongrong@oss.cipunited.com>

[ Upstream commit 32ec465103527ede09b640cd0ab0636dc58827fb ]

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
Acked-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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


