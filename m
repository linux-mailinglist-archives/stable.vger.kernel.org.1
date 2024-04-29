Return-Path: <stable+bounces-41714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6597A8B595E
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 15:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18C5228AE71
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D5354905;
	Mon, 29 Apr 2024 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nlcpst8q"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAE653E08
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 13:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395824; cv=none; b=jc8bNnoJFMfI8+4K7M7SpyM6oUbuNZ5T2kioXB7waBfrcLHThP0kULEXFMRFqNfT9AWnzrCSVPf6mUVsiKqiprvLKFxdWTISZq+XnQ4pUinWXh0F+5PMKL0HhDCMYLk+Gfpi046Vct1cuOWoSg8C3lMub+2UdutkruHi2MUzDp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395824; c=relaxed/simple;
	bh=s+wl6/a5NHwbPwH1CMvyZN/Vs2XdIwQE41uea25G+74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VziR/5kGP56/E0LDCG0cg1nYzzq+bWalFNVWvUr3k05V4oelxFlyjTiqrpzzEI6hama9vLRosB6g0f8AIqGN6ZGjnuca2ng+M/AwEp9Xn4enUE+sTIVuLACD8ioCbxZDJPO0NC1+/QBUkU+UXOrrtJCKkPY7AqsR9pk/8uBHiHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nlcpst8q; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714395823; x=1745931823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s+wl6/a5NHwbPwH1CMvyZN/Vs2XdIwQE41uea25G+74=;
  b=nlcpst8qDxHGxMhHbzsRq9cKPLQP1d350OqKDS+1ObsdgW1u9I1Kro85
   a9R8oCTaWQLB2ZC4KDb3SGD9EQz3J3f/YsmLgYoK8xZJdeBPFY6XkvZoH
   F6plf9DAU8B+7X7dY0C4kk6sjNx+Y980K3nZg8/K1103fCTY3F0e6H+yu
   1Oem8NvSuSEjSyADwqRGXf4r/ZmxkdF2kkFldC2TSmy7dVTZVmN9HX8lb
   DC/fGgnjT4Nmd7hKCsgKFYsED9x7+HlANOaK9FthQoOD9/SqIvKqx2xJB
   EvSPMWkhOweP4r7l+MclL28kfXRJpZ2G1WeW3sUKHjD0/2u7Rp/ANGfS3
   w==;
X-CSE-ConnectionGUID: clZvmD19Sq2Iw7NFEv7XmA==
X-CSE-MsgGUID: KB4AC9I0Sm+a7N5auvntow==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="32554072"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="32554072"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 06:03:43 -0700
X-CSE-ConnectionGUID: iyi9BDO3Tg+FEC1S+qmrbg==
X-CSE-MsgGUID: 0q/rjLZSQ/i27+cjP7Zucg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26609152"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 29 Apr 2024 06:03:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4F0CF179; Mon, 29 Apr 2024 16:03:39 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: stable@vger.kernel.org
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Chris Oo <cho@microsoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 6.1.y] x86/tdx: Preserve shared bit on mprotect()
Date: Mon, 29 Apr 2024 16:03:36 +0300
Message-ID: <20240429130336.1622067-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024042908-cesarean-sulfur-8a97@gregkh>
References: <2024042908-cesarean-sulfur-8a97@gregkh>
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
index 1f97d00ad858..100a752c33bb 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -13,9 +13,10 @@ enum cc_vendor {
 };
 
 extern enum cc_vendor cc_vendor;
-extern u64 cc_mask;
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
+extern u64 cc_mask;
+
 static inline void cc_set_mask(u64 mask)
 {
 	RIP_REL_REF(cc_mask) = mask;
@@ -25,6 +26,8 @@ u64 cc_mkenc(u64 val);
 u64 cc_mkdec(u64 val);
 void cc_random_init(void);
 #else
+static const u64 cc_mask = 0;
+
 static inline u64 cc_mkenc(u64 val)
 {
 	return val;
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index f6116b66f289..f0b9b37c4609 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -127,7 +127,7 @@
  */
 #define _COMMON_PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |	       \
 				 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |\
-				 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP | _PAGE_ENC | \
+				 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP | _PAGE_CC | \
 				 _PAGE_UFFD_WP)
 #define _PAGE_CHG_MASK	(_COMMON_PAGE_CHG_MASK | _PAGE_PAT)
 #define _HPAGE_CHG_MASK (_COMMON_PAGE_CHG_MASK | _PAGE_PSE | _PAGE_PAT_LARGE)
@@ -153,6 +153,7 @@ enum page_cache_mode {
 };
 #endif
 
+#define _PAGE_CC		(_AT(pteval_t, cc_mask))
 #define _PAGE_ENC		(_AT(pteval_t, sme_me_mask))
 
 #define _PAGE_CACHE_MASK	(_PAGE_PWT | _PAGE_PCD | _PAGE_PAT)
-- 
2.43.0


