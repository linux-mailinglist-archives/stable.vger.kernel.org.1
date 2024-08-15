Return-Path: <stable+bounces-68921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 458BB9534A1
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14892873A1
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697EF1A7068;
	Thu, 15 Aug 2024 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pb/uRYAQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291481A7048;
	Thu, 15 Aug 2024 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732091; cv=none; b=M+iCoKHKEyPZeFoXJ6v6L25YSDDuyqcwGgtU3Iye6wroovAe+doNAUFZoX2BDODsT9bhf7yDiHFRuicJ+MbHGmp8CgZEkgoRd5olVQbAZKamn+OV4qdJKzEeysu4V2vLxTTHjsPcr88VYhbuKNN3wCX9N+PAQOE8ueAd6GWpua4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732091; c=relaxed/simple;
	bh=HuV12umUZobTc8CBbJfoBTM/5LBzxKjhtrnZiAIf1e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FdW6s3uk33F4kIdlVuzAtfrDBxo7T9ye+MgT8U8QIVs0sZpTlvbSV1AMQ1ad3igRFAzjCevHunAbjCpPzCZ//L/DOI8XldIcTHRLZFAwr6UdbPTldpbSSzLTdVl5TT6DwjK2CL4MlXaftvQHXT1/coh/hbCun/1bK56vXO+fITw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pb/uRYAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C98FC4AF0E;
	Thu, 15 Aug 2024 14:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723732090;
	bh=HuV12umUZobTc8CBbJfoBTM/5LBzxKjhtrnZiAIf1e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pb/uRYAQJ4WmHkT9e/SDhv6PkHSY0cPDzWGduj8ahftqatHPhhwOinWyN16VPHMDv
	 E7YawiM4IuazOOT9KoU6c9/XaslxvqHcVe/3x//CWcNv53roOCZ3qV2dIcYo5yFMGN
	 eOzBq16WDXi6RWKbR5Vbdu3GFeJfuXhDWV8SnzHM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 071/352] KVM: s390: pv: properly handle page flags for protected guests
Date: Thu, 15 Aug 2024 15:22:17 +0200
Message-ID: <20240815131921.986115023@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131919.196120297@linuxfoundation.org>
References: <20240815131919.196120297@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

[ Upstream commit 380d97bd02fca7b9b41aec2d1c767874d602bc78 ]

Introduce variants of the convert and destroy page functions that also
clear the PG_arch_1 bit used to mark them as secure pages.

The PG_arch_1 flag is always allowed to overindicate; using the new
functions introduced here allows to reduce the extent of overindication
and thus improve performance.

These new functions can only be called on pages for which a reference
is already being held.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Link: https://lore.kernel.org/r/20210920132502.36111-7-imbrenda@linux.ibm.com
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Stable-dep-of: 3f29f6537f54 ("s390/uv: Don't call folio_wait_writeback() without a folio reference")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/pgtable.h |  9 ++++++---
 arch/s390/include/asm/uv.h      | 10 ++++++++--
 arch/s390/kernel/uv.c           | 34 ++++++++++++++++++++++++++++++++-
 arch/s390/mm/gmap.c             |  4 +++-
 4 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 2338345912a31..e967cc2a01f7e 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1080,8 +1080,9 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 	pte_t res;
 
 	res = ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
+	/* At this point the reference through the mapping is still present */
 	if (mm_is_protected(mm) && pte_present(res))
-		uv_convert_from_secure(pte_val(res) & PAGE_MASK);
+		uv_convert_owned_from_secure(pte_val(res) & PAGE_MASK);
 	return res;
 }
 
@@ -1097,8 +1098,9 @@ static inline pte_t ptep_clear_flush(struct vm_area_struct *vma,
 	pte_t res;
 
 	res = ptep_xchg_direct(vma->vm_mm, addr, ptep, __pte(_PAGE_INVALID));
+	/* At this point the reference through the mapping is still present */
 	if (mm_is_protected(vma->vm_mm) && pte_present(res))
-		uv_convert_from_secure(pte_val(res) & PAGE_MASK);
+		uv_convert_owned_from_secure(pte_val(res) & PAGE_MASK);
 	return res;
 }
 
@@ -1122,8 +1124,9 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 	} else {
 		res = ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
 	}
+	/* At this point the reference through the mapping is still present */
 	if (mm_is_protected(mm) && pte_present(res))
-		uv_convert_from_secure(pte_val(res) & PAGE_MASK);
+		uv_convert_owned_from_secure(pte_val(res) & PAGE_MASK);
 	return res;
 }
 
diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index 12c5f006c1364..bbd51aa94d05c 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -351,8 +351,9 @@ static inline int is_prot_virt_host(void)
 }
 
 int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb);
-int uv_destroy_page(unsigned long paddr);
+int uv_destroy_owned_page(unsigned long paddr);
 int uv_convert_from_secure(unsigned long paddr);
+int uv_convert_owned_from_secure(unsigned long paddr);
 int gmap_convert_to_secure(struct gmap *gmap, unsigned long gaddr);
 
 void setup_uv(void);
@@ -362,7 +363,7 @@ void adjust_to_uv_max(unsigned long *vmax);
 static inline void setup_uv(void) {}
 static inline void adjust_to_uv_max(unsigned long *vmax) {}
 
-static inline int uv_destroy_page(unsigned long paddr)
+static inline int uv_destroy_owned_page(unsigned long paddr)
 {
 	return 0;
 }
@@ -371,6 +372,11 @@ static inline int uv_convert_from_secure(unsigned long paddr)
 {
 	return 0;
 }
+
+static inline int uv_convert_owned_from_secure(unsigned long paddr)
+{
+	return 0;
+}
 #endif
 
 #if defined(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) || IS_ENABLED(CONFIG_KVM)
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 422765c81dd69..5173c24a02637 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -121,7 +121,7 @@ static int uv_pin_shared(unsigned long paddr)
  *
  * @paddr: Absolute host address of page to be destroyed
  */
-int uv_destroy_page(unsigned long paddr)
+static int uv_destroy_page(unsigned long paddr)
 {
 	struct uv_cb_cfs uvcb = {
 		.header.cmd = UVC_CMD_DESTR_SEC_STOR,
@@ -141,6 +141,22 @@ int uv_destroy_page(unsigned long paddr)
 	return 0;
 }
 
+/*
+ * The caller must already hold a reference to the page
+ */
+int uv_destroy_owned_page(unsigned long paddr)
+{
+	struct page *page = phys_to_page(paddr);
+	int rc;
+
+	get_page(page);
+	rc = uv_destroy_page(paddr);
+	if (!rc)
+		clear_bit(PG_arch_1, &page->flags);
+	put_page(page);
+	return rc;
+}
+
 /*
  * Requests the Ultravisor to encrypt a guest page and make it
  * accessible to the host for paging (export).
@@ -160,6 +176,22 @@ int uv_convert_from_secure(unsigned long paddr)
 	return 0;
 }
 
+/*
+ * The caller must already hold a reference to the page
+ */
+int uv_convert_owned_from_secure(unsigned long paddr)
+{
+	struct page *page = phys_to_page(paddr);
+	int rc;
+
+	get_page(page);
+	rc = uv_convert_from_secure(paddr);
+	if (!rc)
+		clear_bit(PG_arch_1, &page->flags);
+	put_page(page);
+	return rc;
+}
+
 /*
  * Calculate the expected ref_count for a page that would otherwise have no
  * further pins. This was cribbed from similar functions in other places in
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index ad4bae2465b19..46daa9115a192 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2693,8 +2693,10 @@ static int __s390_reset_acc(pte_t *ptep, unsigned long addr,
 {
 	pte_t pte = READ_ONCE(*ptep);
 
+	/* There is a reference through the mapping */
 	if (pte_present(pte))
-		WARN_ON_ONCE(uv_destroy_page(pte_val(pte) & PAGE_MASK));
+		WARN_ON_ONCE(uv_destroy_owned_page(pte_val(pte) & PAGE_MASK));
+
 	return 0;
 }
 
-- 
2.43.0




