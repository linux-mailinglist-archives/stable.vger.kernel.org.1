Return-Path: <stable+bounces-161846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F6CB040B8
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 15:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6E7175C9D
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 13:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D3725485F;
	Mon, 14 Jul 2025 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rc3GOreL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318AC25524D
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501375; cv=none; b=jMXEmV7asxlI8Dh0bUBdb8+I81YHp7ECDDiFszXN3bE27pJHn02zBahXGQlYLgZzFBXc4NoaGoMQU4SojJ3MhSCe/s1L2TYgIZMTLVQ4+BjoJ0SjU069JiZ3uL7aSzpUrV5eH+IAtynYY6/Er78E74spBB2gEgCrWfd1maMUjm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501375; c=relaxed/simple;
	bh=dGC9bRUNZGlcNV36rhJL6OTAAiXOz5wIj7z1AQ1JzQQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnAG5F2mxXs0IGsC/hNgZf10MB4Rl69Q+s/My9WHDDcjw1mRK8qERwSQubHYp+Ovnaxe2eEcPPDX63EfG9+PU2O676HHayse0HdgD5vHBeboRL39obrl+HvkKoJuXFCjN0J8df0HI5a23f+y3q54AGppD4etsdIMSVkgx7Zr11Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rc3GOreL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4561b43de62so55555e9.0
        for <stable@vger.kernel.org>; Mon, 14 Jul 2025 06:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752501372; x=1753106172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KBxRz+zti1JF2riJrt8oaqzPLmA5PlDKn+ksPn9iXm4=;
        b=Rc3GOreLnVJzcVfUpQNjugfogs8p0b3zcs/jUbjIfkggukWcBQIfu0vwF93S+NSqTx
         iUMP8l0L3UXZwGmQ6tbryBjFtgPHSDRVQ9xygI8Q2RhT1KP6MqdY7QD7KQ6EzopSdaio
         yRgKtGvC5Rf/kDskk6gsuaCaUMdNsSSgT0alTHBS49sy1JMHbiVi1BAlT8Z3cXDD8w3x
         KrhQyJP4t9V2nvS37Sn7eKSr6dUpghlRzme8e5PXwEKE/6TgtW9EjWLki2LNcR6pBR2V
         28kMSn1lC2+0MPshzXPc4ZHmC8edHM9KpXjJFwRMMlIvKReYVNzIKcc1J0uquQm4h6jn
         cYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752501372; x=1753106172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBxRz+zti1JF2riJrt8oaqzPLmA5PlDKn+ksPn9iXm4=;
        b=vNvtZ3wJiwGNiPSY+rAJqePMl3kWx01eR/55S05/TVMfgpkEgKk9IuicblKNVdZehT
         4H0ck1NnN2YEvJkhVrWUP3khUyPp4Hdiv9VDgmUWlAklnGG3mOxRzfvobGGVv67Rpn3V
         knGwaIQnQxRp90hZPPgyuk5Htp2JFHQ9z4BVp70LXSx8XUZTtxlwf7p8jQZ7KHT7dRf4
         f8qIGQbSf71KEWI4L2ljxg+MNFTnsFPlfwYV9DQInNUvn7JtJ429u5Lw71jCVlt4H2Xk
         dVrD3ak7Lmuc6eNcPPdrJHlOw6f+HBmUTLhzCrTusJMEWzUoIvdj2ih/JUmfyOBFKHUA
         38hg==
X-Gm-Message-State: AOJu0Yx3p9W0mdFQpgpnMp4oewbh2RptPCYcQ1fcYiHad2hVB+N4cfkh
	ugWGFYTBgjsBUxv4ZaT1oCxPBJi7JgPIbu6jbT5mchHDNboXmxNSJqter8Sy5Pww7zUzsQOZbuB
	pIzUY7TnN
X-Gm-Gg: ASbGncvAnsmRwV0i3SbnFb91tDGuyS/VA+iAyVgCMBDun2VEqdJagc6Q6x1hHf6vklL
	JyZuH1UY8wE4g4VkMXh2YMCcHDEL0pk15zdD5pwry5RAS0fn3/D42o+vC2l+DTPA6znxJ6AKWls
	gsB+N9SGMImf4tRLV0rRIBjghmp8Fo4jIHqPRXItEMURmKT9++2TgzCzoRDUn9eXhIxa9OJLDAg
	+Thh5eTBKBDdsLfcD3HdBesdXg6wL2mWZYR8IcG4MjHeconID2ozCnfC7KgGQCjnqby3JtoNR3G
	y7yZhxRY5ZzwOF5LXnB7/PLzViprZTBU03+Ih6rAM7i2itjV1GI0Y9qJouHmNld2CSlTbCOtarr
	9sNgXGGTEZQ==
X-Google-Smtp-Source: AGHT+IHXwF4KNXyI+wehDzqCcSbq2HOMjObF27csbZ2tHqPAaUQkfDUcXF0H34pKCq+XT+0EJ1cT8g==
X-Received: by 2002:a05:600c:47d2:b0:455:fb2e:95e9 with SMTP id 5b1f17b1804b1-456008a349bmr2651285e9.6.1752501372130;
        Mon, 14 Jul 2025 06:56:12 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:46a:594a:89a5:b3cc])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b5e8dc1de0sm12363290f8f.24.2025.07.14.06.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:56:11 -0700 (PDT)
From: Jann Horn <jannh@google.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y] x86/mm: Disable hugetlb page table sharing on 32-bit
Date: Mon, 14 Jul 2025 15:56:09 +0200
Message-ID: <20250714135609.360394-1-jannh@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <2025071421-molar-theme-43d7@gregkh>
References: <2025071421-molar-theme-43d7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only select ARCH_WANT_HUGE_PMD_SHARE on 64-bit x86.
Page table sharing requires at least three levels because it involves
shared references to PMD tables; 32-bit x86 has either two-level paging
(without PAE) or three-level paging (with PAE), but even with
three-level paging, having a dedicated PGD entry for hugetlb is only
barely possible (because the PGD only has four entries), and it seems
unlikely anyone's actually using PMD sharing on 32-bit.

Having ARCH_WANT_HUGE_PMD_SHARE enabled on non-PAE 32-bit X86 (which
has 2-level paging) became particularly problematic after commit
59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count"),
since that changes `struct ptdesc` such that the `pt_mm` (for PGDs) and
the `pt_share_count` (for PMDs) share the same union storage - and with
2-level paging, PMDs are PGDs.

(For comparison, arm64 also gates ARCH_WANT_HUGE_PMD_SHARE on the
configuration of page tables such that it is never enabled with 2-level
paging.)

Closes: https://lore.kernel.org/r/srhpjxlqfna67blvma5frmy3aa@altlinux.org
Fixes: cfe28c5d63d8 ("x86: mm: Remove x86 version of huge_pmd_share.")
Reported-by: Vitaly Chikunov <vt@altlinux.org>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
Acked-by: David Hildenbrand <david@redhat.com>
Tested-by: Vitaly Chikunov <vt@altlinux.org>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250702-x86-2level-hugetlb-v2-1-1a98096edf92%40google.com
(cherry picked from commit 76303ee8d54bff6d9a6d55997acd88a6c2ba63cf)
Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4eca434fd80b..3b9ba4b227d5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -118,7 +118,7 @@ config X86
 	select ARCH_WANT_DEFAULT_BPF_JIT	if X86_64
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_WANTS_NO_INSTR
-	select ARCH_WANT_HUGE_PMD_SHARE
+	select ARCH_WANT_HUGE_PMD_SHARE		if X86_64
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
-- 
2.50.0.727.gbf7dc18ff4-goog


