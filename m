Return-Path: <stable+bounces-159205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47125AF0E1B
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 10:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D27F189FD68
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 08:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3D0229B13;
	Wed,  2 Jul 2025 08:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pKJmf6CS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53DE38F91
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 08:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751445161; cv=none; b=ooWltcdx+qmPHcF9CL5t5H/e3UEBj+VCbVZZjP7bQW9e7i9q3qZ+mRySPAfWh8uaZn4yQeLhSCQ7bnFEGVex3lcqzDbAgBM0K+YBeYriS7N6fKRnxUAebkMyc4StiZqMYIb3/HF2PeGeRhgfXAYBc8ziPU1difLD+K8Qcu7O3lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751445161; c=relaxed/simple;
	bh=eAWfGBOp2OE5o/uIStw/ne4ImpbU6xw1RGKMdwD5PrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jZvuPb7fTVEWaDfeniU3JlXDyfe5nty7G+MQFZNvdH//MURo21p0Ay0Fsq74TXpiXEESujxagC4kJNbdGSBNRh2ZomSPEXd6W1X9t5Rh+DLCVb6IZGr87UGNEr1ecYQjahuVtxWr+IzIczWpUljBLAlLEAjS1ajENzBSREBzGww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pKJmf6CS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-453663b7bf1so154155e9.0
        for <stable@vger.kernel.org>; Wed, 02 Jul 2025 01:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751445158; x=1752049958; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XvcsilU1sW9ZroJrInpDuRq5bTBfyCF/BMtQir5LxGI=;
        b=pKJmf6CSnbKkUTpRWEhYuPD3V7TxP6eps2N3K8Bo9XygZT5XfR+vdSQhnay49QNroC
         zlKsFPwC43QQRX6CYn0+TLVzRh8FCENVFAfyc9u21KavLZLueyRT7AStfUNdSITbGUGz
         G9NXZQ+1+i1sGstITI9mbvQoY2ne6sRbaCrsjv1ccbTL+idQVXnHavh4XwthdTfBYCho
         4G9j1jJP0UmjP3sc3tPzUrBv6E2vRGFqswwWeN3zuRfY2VI3ZXyILjy7rOW6H77YCbVd
         GkMJGyVBA8oePbKvlhTyL/85fo9aJz9QpIVrWNOKmGNeIAASq/KO/uxhbIl0Tm5+1Rvt
         v3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751445158; x=1752049958;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XvcsilU1sW9ZroJrInpDuRq5bTBfyCF/BMtQir5LxGI=;
        b=UDyb5TqP0XGZaFapQkCGhxuHTOgPMdoV1ztaMzZRJnFIqACyT+OcKnoR4A/IJ1QJp1
         1IuPm7IN0WTjQ+e5dEKHinKCFoR5cbzUeHSoBM+VARWOGR06R4RaMHtfY2MRADUlXU3n
         gyPbpNvx8qvu3/qnWT8EiC+Cu4hk33ycRB7FJdYRQWCFP1moKxrJCCJrOEcFF4kF9+y0
         PFnF7bwFE6uwpyHF/EWhzwpdoCTHlpDZcgJGB4rxkrCAecwp97bXcy8FCzziyP+Wj/aY
         epGEfFbYcIs2NxeeIa53O5pNPm5ayRJ6aAO3O2KEzoKl7bTpQyFVg2eTI5tkpU3QaNJw
         c6jg==
X-Forwarded-Encrypted: i=1; AJvYcCVQt83+XBSAK6nWy+51hctpyLZaKg5tHVDq0qPs2zLoRsXTcmS3foiKiSF5TaikSykQkiAY4f8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEPVfGi7L5RRzB4J4BMJ2mthaL12PdHQjua243xQgU0LweMjXg
	J/OnOMcgqCWdzjSWXKLXYHrK5tmyA9HgDhXLzKE2kfDYZ1EIl2N+HKVrYC0Aso9cuw==
X-Gm-Gg: ASbGncufbI4C2adlc35iVIIfLDdpU7Q1SUYGS551Mfqdy5Ssh0euSfQmC2iUlnAxKSD
	MEaVvlFQw/n/3s70rB0rLKKd+AO4y5g1sSioQmoUVWL3jOqsVVF0qva6a2d4PEb8Qaz8FBsmDxr
	8Mkp7pthLG45QiLYCX056a3H5LzeOAJI2ZGrMPTvntcrsEeeqKxaWFo5RiDNPyd7PVhSxawsZT9
	Hu1sS+f7xgIvj7HazsdqqZqhi5hdTuewuc9SsO7Z65komwU0l5LN4nkQnyOa0+oxGNNdIezqg/2
	NhRuIoNdfZvyY4JAiNL/LyqNLdqCN+SaYq97wof5hiP8rWpu2g==
X-Google-Smtp-Source: AGHT+IFpZv2X4ec+NbYvtOFfMUhTvi0IIqKMta9hdoetaYBvp/OQbbyq8JB7TaOnylqpXCpoJ83zzg==
X-Received: by 2002:a05:600c:a301:b0:453:5ffb:e007 with SMTP id 5b1f17b1804b1-453e03a982cmr2406815e9.4.1751445157740;
        Wed, 02 Jul 2025 01:32:37 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:a624:383a:b7f6:98b6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4538a3fe587sm194408345e9.19.2025.07.02.01.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 01:32:37 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Wed, 02 Jul 2025 10:32:04 +0200
Subject: [PATCH v2] x86/mm: Disable hugetlb page table sharing on 32-bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-x86-2level-hugetlb-v2-1-1a98096edf92@google.com>
X-B4-Tracking: v=1; b=H4sIAIPuZGgC/32NQQ6DIBBFr2Jm3WkAg5queg/josIIJFQasMTGc
 PdSD9Dle8l//4BE0VGCW3NApOySC2sFcWlA2cdqCJ2uDIIJybqW4T50KDxl8mjfhjY/48z1sNA
 spFQEdfiKtLj9jI5TZevSFuLn/Mj8Z//mMkeOrO+Vlq0eavVuQjCerio8YSqlfAGMxjZptQAAA
 A==
X-Change-ID: 20250630-x86-2level-hugetlb-b1d8feb255ce
To: Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Vitaly Chikunov <vt@altlinux.org>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Dave Hansen <dave.hansen@intel.com>, 
 stable@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751445128; l=2325;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=eAWfGBOp2OE5o/uIStw/ne4ImpbU6xw1RGKMdwD5PrM=;
 b=3IjgsDhfn/5nRf4zEn2iPWeV2Su1iX72bqKFpVCmdzkQTIJkAmz8QikSuctlSlKeSLatqT9Nr
 pRjGbWN0vROA/pzHLwqxQRbqBtzR/FFfjEDRD+fhdunfjKxp7ptnLTV
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

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

Reported-by: Vitaly Chikunov <vt@altlinux.org>
Closes: https://lore.kernel.org/r/srhpjxlqfna67blvma5frmy3aa@altlinux.org
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Tested-by: Vitaly Chikunov <vt@altlinux.org>
Fixes: cfe28c5d63d8 ("x86: mm: Remove x86 version of huge_pmd_share.")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
I'm carrying over Vitaly Chikunov's "Tested-by" from v1.

Changes in v2:
- disable it for 32-bit entirely (Dave Hansen)
- Link to v1: https://lore.kernel.org/r/20250630-x86-2level-hugetlb-v1-1-077cd53d8255@google.com
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 71019b3b54ea..4e0fe688cc83 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -147,7 +147,7 @@ config X86
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANT_GENERAL_HUGETLB
-	select ARCH_WANT_HUGE_PMD_SHARE
+	select ARCH_WANT_HUGE_PMD_SHARE		if X86_64
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANT_OPTIMIZE_DAX_VMEMMAP	if X86_64
 	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64

---
base-commit: d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af
change-id: 20250630-x86-2level-hugetlb-b1d8feb255ce

-- 
Jann Horn <jannh@google.com>


