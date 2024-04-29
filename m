Return-Path: <stable+bounces-41667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F6F8B56A6
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20CA1C23058
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A6B4596C;
	Mon, 29 Apr 2024 11:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vvcRFLIw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6E440872
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390160; cv=none; b=jSgGK2+GymM5HWsCeTUB1gsAEafSzeWzgJ+o1+Z/SL0K8xeQSfX+wqDvXG+nv+Dy0pZT9YGrPIc2J0iNXfVl90bCZV2164w8Sf5y9uaHXWebYZSZtH9Rff3cfHw+AS94kO6zoBzFPJPgpys9uIoAnoLk/LPkXY0VcVoCuod/em4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390160; c=relaxed/simple;
	bh=yEQB3iTyLLi9otOnvAvpQzrxYGHdLW1gPTVzwkAVD1E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EqYPXp5UmiU+gU4TNRm2OcFw8fo3g+3rCJ22VhiZ82rdFflJDl9O57Yvlwx2HVRIz9OQrxsG2iNCaEuvoagSx6AWv0+ju/hNYtr4kh84oYOUbQnoG3QSLiy2MRVGqeP/XVRf/hi9af6zziYXrv6rQGSaASz5Z7VD0l18qRZ3Gg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vvcRFLIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BD4C113CD;
	Mon, 29 Apr 2024 11:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714390160;
	bh=yEQB3iTyLLi9otOnvAvpQzrxYGHdLW1gPTVzwkAVD1E=;
	h=Subject:To:Cc:From:Date:From;
	b=vvcRFLIwr8ziuw5rLjfwSTzUsjU7WwWyVyzruxjMXa4mUJ+V/IQkj17JWWkREgjSp
	 8DF7mGgpZYjQ9Mi9HKgUPaA9acPaNYGVCc16H2iBnfl6vwPW9z38aB6SlyYqAx/y+I
	 s1kN8X3NuIPErByig3oh++/X/GO9nTBvZHH0q0yc=
Subject: FAILED: patch "[PATCH] x86/tdx: Preserve shared bit on mprotect()" failed to apply to 6.1-stable tree
To: kirill.shutemov@linux.intel.com,cho@microsoft.com,dave.hansen@linux.intel.com,rick.p.edgecombe@intel.com,sathyanarayanan.kuppuswamy@linux.intel.com,thomas.lendacky@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 13:29:09 +0200
Message-ID: <2024042908-cesarean-sulfur-8a97@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a0a8d15a798be4b8f20aca2ba91bf6b688c6a640
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042908-cesarean-sulfur-8a97@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

a0a8d15a798b ("x86/tdx: Preserve shared bit on mprotect()")
e45964771007 ("x86/coco: Define cc_vendor without CONFIG_ARCH_HAS_CC_PLATFORM")
df57721f9a63 ("Merge tag 'x86_shstk_for_6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a0a8d15a798be4b8f20aca2ba91bf6b688c6a640 Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 24 Apr 2024 11:20:35 +0300
Subject: [PATCH] x86/tdx: Preserve shared bit on mprotect()

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

diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index c086699b0d0c..aa6c8f8ca958 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -25,6 +25,7 @@ u64 cc_mkdec(u64 val);
 void cc_random_init(void);
 #else
 #define cc_vendor (CC_VENDOR_NONE)
+static const u64 cc_mask = 0;
 
 static inline u64 cc_mkenc(u64 val)
 {
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


