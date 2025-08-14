Return-Path: <stable+bounces-169604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623DCB26D08
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 18:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AC84B6165A
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 16:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1366E1FF1C9;
	Thu, 14 Aug 2025 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SznRsunT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C605B2040B6
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190440; cv=none; b=mGThzxtQthi7xk9/CbUsn580w21ZwXkXtmCebP7FlLPIj2xZEuf5GxtHOWXj2lCZfl8YzMIWzP3DmG3f4wCeAfeU1pogP/F7xso9sLLfhpNISF4DGolqLbkWl8QHXdYxwVdwdCknW11FaLSHEywstrnDaIqcEHbJ0jWEsFT51og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190440; c=relaxed/simple;
	bh=f/wLue3peOLjixeAvVnVfrO9pUwjazkiYvqHq/QRurU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sxRqYl7yJbtDxRmstHFGD2y/DKizzquWnO+J3ZDqkbEqkziYOtmIiFScjKjXKm5L4UFypOirQCV2k+9f5qHbAvw0682Rx2LsYunK+s3KoVHsPEICHoMMKM/dXri5OcNfNBaxdXWFvX8Kt5WFzC9a8SAHVFtumxZu6gzM6OXrouA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SznRsunT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11425C4CEF1;
	Thu, 14 Aug 2025 16:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755190440;
	bh=f/wLue3peOLjixeAvVnVfrO9pUwjazkiYvqHq/QRurU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SznRsunTTpHmUHdPESXYrmPNbRHu3LNCXWTXHFVDQDvvnTz8Ld4smNH65sZCkig44
	 TE1/V7j4pwAHF5gcXormGDnlP+jOPZ1ixujrrFkW4bqVKS4dfPn7SSJ0g4fv40MM4X
	 miG5DqkVSMAI8g5ZTCcYV4f7BRb4TByCDwT8Ms1G4P0KLfUU+fSMFzHnvG1krOyxcV
	 fajYxTOFVWOs2QJlkUUYOkN1+FZ6qxW1r+XmM2+tBrFn4tm7nYcWsaKoC1eQbzC11y
	 zaiVguyHTsSVRFapAXON9amJT95nl3riVwuCQFmSimrjMN0o1B4bjWO4On2yY2Imz1
	 hZyRrhWnnRoYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Bill Wendling <morbo@google.com>,
	Jerome Glisse <jglisse@redhat.com>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] mm/hmm: move pmd_to_hmm_pfn_flags() to the respective #ifdeffery
Date: Thu, 14 Aug 2025 12:53:56 -0400
Message-Id: <20250814165356.2131524-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025081229-useable-overhung-5a62@gregkh>
References: <2025081229-useable-overhung-5a62@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 188cb385bbf04d486df3e52f28c47b3961f5f0c0 ]

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
[ Minor context adjustment ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 902f5fa6bf93..e0dccfc8db60 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -392,6 +392,7 @@ static int hmm_vma_walk_hole(unsigned long addr, unsigned long end,
 	return hmm_vma_walk_hole_(addr, end, fault, write_fault, walk);
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline uint64_t pmd_to_hmm_pfn_flags(struct hmm_range *range, pmd_t pmd)
 {
 	if (pmd_protnone(pmd))
@@ -401,7 +402,6 @@ static inline uint64_t pmd_to_hmm_pfn_flags(struct hmm_range *range, pmd_t pmd)
 				range->flags[HMM_PFN_VALID];
 }
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
 		unsigned long end, uint64_t *pfns, pmd_t pmd)
 {
-- 
2.39.5


