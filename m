Return-Path: <stable+bounces-55812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAD2917421
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 00:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08661C20ED1
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 22:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CDA17E8F0;
	Tue, 25 Jun 2024 22:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pBmpNcdr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XwxQdioi"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCB617E8E8;
	Tue, 25 Jun 2024 22:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719353544; cv=none; b=ohQH6JFEBEKwEvJJxYLxlqM4rSFzysYicwkypXHY2TOD8K9D1hfL1u+pd4jirZiRwKAvsIXPqG/nDoWBoprQv4He5tIh104Kzq4f4tW4rRQiIoOCvFmaDloL2Lzk2H7mS0b0vim5Nqtrrfh8kNFT3VDm5n3s/IBcog+zn/zLhLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719353544; c=relaxed/simple;
	bh=Ftu3WsTt5XKxN+pi5Lmx1LZaz7n0qjVViDvMcD4JHgc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=AW6Tgq9FjwbE8wtzUXNnKdCMdlGzichnXzv07Wk4xUCvq6TbTF4wm9094+S5iAHlkxu4JUT4Xw3amY0aeKl0aqDCb9bgO9lTzfh56YOOlhl0dyk691BZnOeNl8gFxdF9GSlCHaro7EL0TPpntY6aYDKi9yyIFUY+T6jEsWjhMEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pBmpNcdr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XwxQdioi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Jun 2024 22:12:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719353540;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XHw6rhwX8j0QHpBV2/9r5LmlHycquzQ7fMaPHli9yUo=;
	b=pBmpNcdr3OQ+AWo7nf3nVz/jQa7Oy3unpwd5dGmjvSsVp0SnNZgpT8XG4d2Ap7NPBOYgiy
	aK6uSpUq0kRxAbP59Yqm3mz11HxEa1aUuudoZ2SQtdVJWJcSqIW0d4k91i7fCSMIH3DbdH
	LlT/5OkuzrayTAjw36ghAvMt01cqYd6siH9s0OVxKGtVEd8Qx0RxgRWeqFInTldWvN8b73
	qB+Fl7GzRqc55AwPEC3m+jwgsNefATlqGZs2C4hLWC7lPwp9QxgakQ/QbX58JWgFzJT4M9
	mvbOdw2vjL5klvR7ze+HGLWaYx9dX85BnUG6JmU5AkE/Gv6ltB4ZphLz9yTdow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719353540;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XHw6rhwX8j0QHpBV2/9r5LmlHycquzQ7fMaPHli9yUo=;
	b=XwxQdioiVdOUJM7oUcsedffzBnbjBlpcT9NFo/xuFBs8q/TU9UFw1RMBH/6SIcbj5HnxwP
	gk8TW5Aa0aCoPcAw==
From: "tip-bot2 for Dexuan Cui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dexuan Cui <decui@microsoft.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Kelley <mikelley@microsoft.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, Kai Huang <kai.huang@intel.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171935353976.2215.5616750471664330747.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e1b8ac3aae589bb57a2c2e49fa76235c687c4d23
Gitweb:        https://git.kernel.org/tip/e1b8ac3aae589bb57a2c2e49fa76235c687c4d23
Author:        Dexuan Cui <decui@microsoft.com>
AuthorDate:    Mon, 20 May 2024 19:12:38 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 25 Jun 2024 14:45:22 -07:00

x86/tdx: Support vmalloc() for tdx_enc_status_changed()

When a TDX guest runs on Hyper-V, the hv_netvsc driver's netvsc_init_buf()
allocates buffers using vzalloc(), and needs to share the buffers with the
host OS by calling set_memory_decrypted(), which is not working for
vmalloc() yet. Add the support by handling the pages one by one.

Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240521021238.1803-1-decui%40microsoft.com
---
 arch/x86/coco/tdx/tdx.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index c1cb903..abf3cd5 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -7,6 +7,7 @@
 #include <linux/cpufeature.h>
 #include <linux/export.h>
 #include <linux/io.h>
+#include <linux/mm.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -778,6 +779,19 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
 	return false;
 }
 
+static bool tdx_enc_status_changed_phys(phys_addr_t start, phys_addr_t end,
+					bool enc)
+{
+	if (!tdx_map_gpa(start, end, enc))
+		return false;
+
+	/* shared->private conversion requires memory to be accepted before use */
+	if (enc)
+		return tdx_accept_memory(start, end);
+
+	return true;
+}
+
 /*
  * Inform the VMM of the guest's intent for this physical page: shared with
  * the VMM or private to the guest.  The VMM is expected to change its mapping
@@ -785,15 +799,22 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
  */
 static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 {
-	phys_addr_t start = __pa(vaddr);
-	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
+	unsigned long start = vaddr;
+	unsigned long end = start + numpages * PAGE_SIZE;
+	unsigned long step = end - start;
+	unsigned long addr;
 
-	if (!tdx_map_gpa(start, end, enc))
-		return false;
+	/* Step through page-by-page for vmalloc() mappings */
+	if (is_vmalloc_addr((void *)vaddr))
+		step = PAGE_SIZE;
 
-	/* shared->private conversion requires memory to be accepted before use */
-	if (enc)
-		return tdx_accept_memory(start, end);
+	for (addr = start; addr < end; addr += step) {
+		phys_addr_t start_pa = slow_virt_to_phys((void *)addr);
+		phys_addr_t end_pa   = start_pa + step;
+
+		if (!tdx_enc_status_changed_phys(start_pa, end_pa, enc))
+			return false;
+	}
 
 	return true;
 }

