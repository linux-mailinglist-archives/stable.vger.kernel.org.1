Return-Path: <stable+bounces-220820-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDLyOYZfo2myBQUAu9opvQ
	(envelope-from <stable+bounces-220820-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:35:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 308D81C926D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 757C531EF582
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1978495508;
	Sat, 28 Feb 2026 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaH1Fu+6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42F6411E2B;
	Sat, 28 Feb 2026 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300705; cv=none; b=HCHaZwFyrmAB0AN4DUMv5Qffck374wsWIzu8twudMMyHj9zNX+O14PU+WggBf/tXWmW/14fOB+9cOcNC/0S4KhLse9UbaK9vXQ6F0G8bdAEzB4b/nfE4w72qN/e+KNMt8wHmPrMTpdzXjgUTanrORLB42JVzRjcBwOf6H9z9m1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300705; c=relaxed/simple;
	bh=dQkMmHrbcqCy/oztNkPAM72dHeZZl1pyQ+qFF3r0YC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MsOisw1kwQvqwdmsSkZ5dZmEyxO3JbMMESa7eC+PvDVOZ7FAfIAABNMgQKQc6nY2SwmNuLLxVcd2x93uZYTU5wu9ro/ZoZmWdUySDAnVk88lN6FpF70rs3SAUzO7BqgYf/W20L56xa1axFtkf7G3oZehpMEirroXMnjj2h2wvVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaH1Fu+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD117C2BC9E;
	Sat, 28 Feb 2026 17:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300705;
	bh=dQkMmHrbcqCy/oztNkPAM72dHeZZl1pyQ+qFF3r0YC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KaH1Fu+61XWb7Axkzw/fh5eZq7nMjzxfnMtDAa6aOQiuU12Lv+1QQc/MdbfX448kC
	 yxZvJ3s22FvcD8SlN7TnKhLqu7xM7bZ8APZsJhdz5NPpiEKAQnbFj7+vLoC/GL0xBD
	 2Z4+mqCtbtnL2CHvn6r6sLRkbyCKVpzSaVtLDqOGcuL60yEihRnraWsd/8Eu5mb6R/
	 uvmJK7e6BKkhmFc6nnQjQDNnftfcEJ+fGjjobZKMA4D600mpW55ftUScnwni7xqRRV
	 zLcqZKE2lXtDUX5kyYYZMVgYGRD8vqpEnm2KE0KiQezyyeRaI/0d4F6tuOo6Y4QdNQ
	 m5EEVW/s/5KFA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rong Zhang <rongrong@oss.cipunited.com>,
	Beiyan Yun <root@infi.wang>,
	Yao Zi <me@ziyao.cc>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 741/844] MIPS: Loongson2ef: Register PCI controller in early stage
Date: Sat, 28 Feb 2026 12:30:54 -0500
Message-ID: <20260228173244.1509663-742-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-220820-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.960];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flygoat.com:email,franken.de:email,ziyao.cc:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cipunited.com:email,infi.wang:email]
X-Rspamd-Queue-Id: 308D81C926D
X-Rspamd-Action: add header
X-Spam: Yes

From: Rong Zhang <rongrong@oss.cipunited.com>

[ Upstream commit 6a00c043af07492502ba7a2263ddc4cdb01b66a7 ]

We are about to set loongson_pci_io_resource.start to 0 and adopt
PCIBIOS_MIN_IO. As the first step, PCI controller needs to be registered
in early stage to make it the root of other resources (e.g., i8259) and
prevent resource conflicts.

Register it in plat_mem_setup() instead of arch_initcall().

Fixes: ae81aad5c2e1 ("MIPS: PCI: Use pci_enable_resources()")
Cc: stable@vger.kernel.org
Tested-by: Beiyan Yun <root@infi.wang>
Tested-by: Yao Zi <me@ziyao.cc>
Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
Acked-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/mach-loongson2ef/loongson.h | 6 ++++++
 arch/mips/loongson2ef/common/pci.c                | 7 +------
 arch/mips/loongson2ef/common/setup.c              | 1 +
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson2ef/loongson.h b/arch/mips/include/asm/mach-loongson2ef/loongson.h
index 4a098fb102325..0e586787eb87a 100644
--- a/arch/mips/include/asm/mach-loongson2ef/loongson.h
+++ b/arch/mips/include/asm/mach-loongson2ef/loongson.h
@@ -324,4 +324,10 @@ extern unsigned long _loongson_addrwincfg_base;
 
 #endif	/* ! CONFIG_CPU_SUPPORTS_ADDRWINCFG */
 
+#ifdef CONFIG_PCI
+void loongson2ef_pcibios_init(void);
+#else
+static inline void loongson2ef_pcibios_init(void) { }
+#endif
+
 #endif /* __ASM_MACH_LOONGSON2EF_LOONGSON_H */
diff --git a/arch/mips/loongson2ef/common/pci.c b/arch/mips/loongson2ef/common/pci.c
index 7d9ea51e8c01e..55524f9a7b96b 100644
--- a/arch/mips/loongson2ef/common/pci.c
+++ b/arch/mips/loongson2ef/common/pci.c
@@ -73,15 +73,10 @@ static void __init setup_pcimap(void)
 #endif
 }
 
-static int __init pcibios_init(void)
+void __init loongson2ef_pcibios_init(void)
 {
 	setup_pcimap();
 
 	loongson_pci_controller.io_map_base = mips_io_port_base;
 	register_pci_controller(&loongson_pci_controller);
-
-
-	return 0;
 }
-
-arch_initcall(pcibios_init);
diff --git a/arch/mips/loongson2ef/common/setup.c b/arch/mips/loongson2ef/common/setup.c
index 4fd27f4f90edb..a639e35acce59 100644
--- a/arch/mips/loongson2ef/common/setup.c
+++ b/arch/mips/loongson2ef/common/setup.c
@@ -27,4 +27,5 @@ EXPORT_SYMBOL(__wbflush);
 
 void __init plat_mem_setup(void)
 {
+	loongson2ef_pcibios_init();
 }
-- 
2.51.0


