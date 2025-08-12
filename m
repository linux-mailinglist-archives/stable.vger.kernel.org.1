Return-Path: <stable+bounces-167216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CFEB22D3D
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A3B165AB6
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD5D2E2DF8;
	Tue, 12 Aug 2025 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lHASeGXj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8192D6622
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015452; cv=none; b=WiaQrf0Cw3JcZ3CRObYODw6SOsm4G2B0CFk+TGDjwBomZheqRHqqDJFgtvqRiBjGB0ibJH7Y+oZq3kQjtusvTM2m9fByr5h5s35wikMUjK682LxDhksJrua34xSdLitG1drTZXOai3B1THVscajanbneqyam94x1SuMBnnFz5yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015452; c=relaxed/simple;
	bh=oXBMZhqXM2rW0UXjqeZQqeJOwILGHbDnQQt/kJ9UYko=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FFL1N1sCid0TOoWMgQ9RPJQ9H/Rugy/CivnInX867z1ROYRD27rD7KAIcme6+mwnLuUkWsZJ96WSA7Gvky4XG61ttexge4PnKQM5PwuxPg/YD0LgOS/dzHxvLw+E588HauuFkfFQWCxTDv/zs5aSI2r11M4oKg8uNVYU6jp54TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lHASeGXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1211C4CEF6;
	Tue, 12 Aug 2025 16:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755015452;
	bh=oXBMZhqXM2rW0UXjqeZQqeJOwILGHbDnQQt/kJ9UYko=;
	h=Subject:To:Cc:From:Date:From;
	b=lHASeGXjoGlMelpzSfXtyAPFrQFCxU5hCYp3rWeXMLqe+AvQA3yhCAk0eOp4bzyvD
	 15NnHFAA9x0IyTOiLcod02OY4vvk9PP69hmKlJZhA7orp40FHpsDyP4bhixWQJrSaO
	 mvCwD96kEKDC/OFRtYpKFiwjrf2AZqyWb+a1XAeE=
Subject: FAILED: patch "[PATCH] mm/hmm: move pmd_to_hmm_pfn_flags() to the respective" failed to apply to 5.4-stable tree
To: andriy.shevchenko@linux.intel.com,akpm@linux-foundation.org,apopple@nvidia.com,jglisse@redhat.com,justinstitt@google.com,leonro@nvidia.com,morbo@google.com,nathan@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 18:17:29 +0200
Message-ID: <2025081229-useable-overhung-5a62@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 188cb385bbf04d486df3e52f28c47b3961f5f0c0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081229-useable-overhung-5a62@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 188cb385bbf04d486df3e52f28c47b3961f5f0c0 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 10 Jul 2025 11:23:53 +0300
Subject: [PATCH] mm/hmm: move pmd_to_hmm_pfn_flags() to the respective
 #ifdeffery

When pmd_to_hmm_pfn_flags() is unused, it prevents kernel builds with
clang, `make W=1` and CONFIG_TRANSPARENT_HUGEPAGE=n:

  mm/hmm.c:186:29: warning: unused function 'pmd_to_hmm_pfn_flags' [-Wunused-function]

Fix this by moving the function to the respective existing ifdeffery
for its the only user.

See also:

  6863f5643dd7 ("kbuild: allow Clang to find unused static inline functions for W=1 build")

Link: https://lkml.kernel.org/r/20250710082403.664093-1-andriy.shevchenko@linux.intel.com
Fixes: 992de9a8b751 ("mm/hmm: allow to mirror vma of a file on a DAX backed filesystem")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Cc: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Jerome Glisse <jglisse@redhat.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/hmm.c b/mm/hmm.c
index f2415b4b2cdd..d545e2494994 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -183,6 +183,7 @@ static inline unsigned long hmm_pfn_flags_order(unsigned long order)
 	return order << HMM_PFN_ORDER_SHIFT;
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline unsigned long pmd_to_hmm_pfn_flags(struct hmm_range *range,
 						 pmd_t pmd)
 {
@@ -193,7 +194,6 @@ static inline unsigned long pmd_to_hmm_pfn_flags(struct hmm_range *range,
 	       hmm_pfn_flags_order(PMD_SHIFT - PAGE_SHIFT);
 }
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
 			      unsigned long end, unsigned long hmm_pfns[],
 			      pmd_t pmd)


