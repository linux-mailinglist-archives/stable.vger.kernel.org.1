Return-Path: <stable+bounces-41702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F15D08B5881
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 14:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8115E289102
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 12:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E8D53E08;
	Mon, 29 Apr 2024 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PcNBED0G"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89933F9C2
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714393632; cv=none; b=Neosi7ldAPsH2T2oSvCSSbJh2f9kHp9LLBI/kC1RApQD6vaUU1rssyHwdb4dJCUPzceY50RNIk5BLiMXXgic/M5DvNQbJoIH4zG1QqgkiuolSlOI3B6oFYHx8D5GsUiXbk5rQH3NFZ+JzpnHy8CGaVSnjNoM44ncqVlYuIPw4XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714393632; c=relaxed/simple;
	bh=fwTcbBZmxDKd30Xxc+UFRhkEvjLzkvsKdkLyt4x7734=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUpbkeImUL9S8D/FRI8J0vYrfVFOwpogxRj1d1ANqVpSbNJcjJgxPbCXg5FEem0+gwrz0H+xV2l4wxamlIvTrXxBsHqr9PjNAXavgyGq2416RVYqMsdEeuz7vyPigQojA3IcOvJi6md1X7PNCFmkGUASz0Av4DypkmCPsXu+lRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PcNBED0G; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714393631; x=1745929631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fwTcbBZmxDKd30Xxc+UFRhkEvjLzkvsKdkLyt4x7734=;
  b=PcNBED0Gq2EmakD7kh4qWsY6mf+ZiRu+VkAh9fPTaPxUs1myWkSnuKZX
   ssl2vGfWkLrV8Lb/ON8RNcZQmuxkgw+rtjAFyc8uKnTaQ1qkEHT//FKnG
   BOqUFBUT2olBlT+pXcSGpjk9J/orWzXsJDV0oIYRpeMRrDg5aa+U7OFDk
   yL25zPqUnv42XRNkEopHIWN07clVIisrkroqvavAHvTCgKAVquPjFUzsM
   sUGBADXe/vCAa2RrprWGzk06Fvzx+yx7kosuEa954kLGlRAHUMJajd8zU
   Fc5ahCBJyV1ep3KEy8+jg6Kjbr78ESiIiY7CyPdws7ynsTROaLxQK2EGu
   A==;
X-CSE-ConnectionGUID: JmWajcJXSxmnJcWvmKfsNw==
X-CSE-MsgGUID: 2ubBO70nT3ewV1l1sQa9lA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10268721"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="10268721"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 05:27:07 -0700
X-CSE-ConnectionGUID: klYzi3psQWyGnupMsiQR6Q==
X-CSE-MsgGUID: L+Wu4kXsRnevL1UFFs4aLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="30894823"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 29 Apr 2024 05:27:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 85C7515B; Mon, 29 Apr 2024 15:27:03 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: stable@vger.kernel.org
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Chris Oo <cho@microsoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 6.6.y] x86/tdx: Preserve shared bit on mprotect()
Date: Mon, 29 Apr 2024 15:27:00 +0300
Message-ID: <20240429122700.4100457-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024042908-modular-case-bbd4@gregkh>
References: <2024042908-modular-case-bbd4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TDX guest platform takes one bit from the physical address to
indicate if the page is shared (accessible by VMM). This bit is not part
of the physical_mask and is not preserved during mprotect(). As a
result, the 'shared' bit is lost during mprotect() on shared mappings.

_COMMON_PAGE_CHG_MASK specifies which PTE bits need to be preserved
during modification. AMD includes 'sme_me_mask' in the define to
preserve the 'encrypt' bit.

To cover both Intel and AMD cases, include 'cc_mask' in
_COMMON_PAGE_CHG_MASK instead of 'sme_me_mask'.

Reported-and-tested-by: Chris Oo <cho@microsoft.com>

Fixes: 41394e33f3a0 ("x86/tdx: Extend the confidential computing API to support TDX guests")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240424082035.4092071-1-kirill.shutemov%40linux.intel.com
(cherry picked from commit a0a8d15a798be4b8f20aca2ba91bf6b688c6a640)
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/coco.h          | 5 ++++-
 arch/x86/include/asm/pgtable_types.h | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index de03537a0182..c72b3553081c 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -12,9 +12,10 @@ enum cc_vendor {
 };
 
 extern enum cc_vendor cc_vendor;
-extern u64 cc_mask;
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
+extern u64 cc_mask;
+
 static inline void cc_set_mask(u64 mask)
 {
 	RIP_REL_REF(cc_mask) = mask;
@@ -24,6 +25,8 @@ u64 cc_mkenc(u64 val);
 u64 cc_mkdec(u64 val);
 void cc_random_init(void);
 #else
+static const u64 cc_mask = 0;
+
 static inline u64 cc_mkenc(u64 val)
 {
 	return val;
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 0b748ee16b3d..9abb8cc4cd47 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -148,7 +148,7 @@
 #define _COMMON_PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |	\
 				 _PAGE_SPECIAL | _PAGE_ACCESSED |	\
 				 _PAGE_DIRTY_BITS | _PAGE_SOFT_DIRTY |	\
-				 _PAGE_DEVMAP | _PAGE_ENC | _PAGE_UFFD_WP)
+				 _PAGE_DEVMAP | _PAGE_CC | _PAGE_UFFD_WP)
 #define _PAGE_CHG_MASK	(_COMMON_PAGE_CHG_MASK | _PAGE_PAT)
 #define _HPAGE_CHG_MASK (_COMMON_PAGE_CHG_MASK | _PAGE_PSE | _PAGE_PAT_LARGE)
 
@@ -173,6 +173,7 @@ enum page_cache_mode {
 };
 #endif
 
+#define _PAGE_CC		(_AT(pteval_t, cc_mask))
 #define _PAGE_ENC		(_AT(pteval_t, sme_me_mask))
 
 #define _PAGE_CACHE_MASK	(_PAGE_PWT | _PAGE_PCD | _PAGE_PAT)
-- 
2.43.0


