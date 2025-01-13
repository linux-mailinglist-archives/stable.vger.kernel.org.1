Return-Path: <stable+bounces-108525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF145A0C0A6
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 19:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE491608DF
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 18:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9975D1F8F10;
	Mon, 13 Jan 2025 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eZiLsQnN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j13ia3qP"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24BC1CB9EA;
	Mon, 13 Jan 2025 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793725; cv=none; b=te1wkNuJVSi0kjWgwUm3xesTZz9MF2hrL+xngA+6QuYXYuj+iGDMnS5bWYpkL6jNCh5YenbN5H49T2B/a0xsJ2Up+l0bGuO0zQgdXAYeA7Y7va3lrP3hwI36LBGGDlu6vrPc5+y9DtRbOP2/NHAN4mZ9HbNsgQzeH+touBqtktw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793725; c=relaxed/simple;
	bh=NpkWrxLyqWav5bqkyXZ9inIpibcfU0CPcasMLtxKS9M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TpMyTSrJfsE0H1+zGE+8djJwX75me8niC+efTi3eaQ5f3fZoLJFr5dUCOPuDdc8813cexxam2QJwnN8KNlyyY5iC7o1WOTsRguJFENAZZRyT/4rKo7Ou/oj1y8y+GDwkvqV8MCIEydup0q1ecFfIGI2tf2Dsv5ACroUO44Dcwtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eZiLsQnN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j13ia3qP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 13 Jan 2025 18:41:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736793721;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dBICddZb8u28z0y5v5ADLkIjvzCu+NsnlhgJ7kSGVNg=;
	b=eZiLsQnNhPHDAdj+p7vU5DWJ+EBjKu/njlYof/DU3GftTRGnLgnX7yTIv74FKknieEMa+M
	V5sW1VGewib4Kzio0SnBIQdfK0WjVDmZeMZqi54Q8yqp40T7HlethQd1jdoor+Oa0PheXG
	5OGvr3ytW9DqTRAZWEnM7R2F2lgZw8GAXDedzpwAP4X6WxNGKiezy4EleqRfMyPeePWFZY
	aM09HdMFLxosip9+YYe2so8whrXgoTMxlekmN6EvcRyVrsEQIdkmJle1T1MpikuwYkQgL3
	Jw1DTpIgIMasgeLsOlb8TghLJg7iqoGMhPYHEI8m0T4+hViHbyiTS3HN4haaxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736793721;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dBICddZb8u28z0y5v5ADLkIjvzCu+NsnlhgJ7kSGVNg=;
	b=j13ia3qP317tFTMUhVEFkDD4xJ0Jq1f4RqqsHjkY/nv5NplMbB2rBskY4qV3gNTCrYYiuJ
	wL2TSlI87glAHQDA==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm: Make memremap(MEMREMAP_WB) map memory as
 encrypted by default
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
	#@tip-bot2.tec.linutronix.de, 6.11+@tip-bot2.tec.linutronix.de,
	x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250113131459.2008123-3-kirill.shutemov@linux.intel.com>
References: <20250113131459.2008123-3-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173679371937.399.5477810359716725907.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     95093e066cfdd18271619248b569c26cfc8fa024
Gitweb:        https://git.kernel.org/tip/95093e066cfdd18271619248b569c26cfc8fa024
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Mon, 13 Jan 2025 15:14:59 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 13 Jan 2025 15:49:12 +01:00

x86/mm: Make memremap(MEMREMAP_WB) map memory as encrypted by default

Currently memremap(MEMREMAP_WB) can produce decrypted/shared mapping:

memremap(MEMREMAP_WB)
  arch_memremap_wb()
    ioremap_cache()
      __ioremap_caller(.encrytped = false)

In such cases, the IORES_MAP_ENCRYPTED flag on the memory will determine
if the resulting mapping is encrypted or decrypted.

Creating a decrypted mapping without explicit request from the caller is
risky:

  - It can inadvertently expose the guest's data and compromise the
    guest.

  - Accessing private memory via shared/decrypted mapping on TDX will
    either trigger implicit conversion to shared or #VE (depending on
    VMM implementation).

    Implicit conversion is destructive: subsequent access to the same
    memory via private mapping will trigger a hard-to-debug #VE crash.

The kernel already provides a way to request decrypted mapping
explicitly via the MEMREMAP_DEC flag.

Modify memremap(MEMREMAP_WB) to produce encrypted/private mapping by
default unless MEMREMAP_DEC is specified.

Fix a crash due to #VE on kexec in TDX guests if CONFIG_EISA is enabled.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org # 6.11+
Link: https://lore.kernel.org/r/20250113131459.2008123-3-kirill.shutemov@linux.intel.com
---
 arch/x86/include/asm/io.h | 3 +++
 arch/x86/mm/ioremap.c     | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index ed580c7..1a0dc2b 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -175,6 +175,9 @@ extern void __iomem *ioremap_prot(resource_size_t offset, unsigned long size, un
 extern void __iomem *ioremap_encrypted(resource_size_t phys_addr, unsigned long size);
 #define ioremap_encrypted ioremap_encrypted
 
+void *arch_memremap_wb(phys_addr_t phys_addr, size_t size, unsigned long flags);
+#define arch_memremap_wb arch_memremap_wb
+
 /**
  * ioremap     -   map bus memory into CPU space
  * @offset:    bus address of the memory
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 8d29163..3c36f3f 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -503,6 +503,14 @@ void iounmap(volatile void __iomem *addr)
 }
 EXPORT_SYMBOL(iounmap);
 
+void *arch_memremap_wb(phys_addr_t phys_addr, size_t size, unsigned long flags)
+{
+	if (flags & MEMREMAP_DEC)
+		return (void __force *)ioremap_cache(phys_addr, size);
+
+	return (void __force *)ioremap_encrypted(phys_addr, size);
+}
+
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access

