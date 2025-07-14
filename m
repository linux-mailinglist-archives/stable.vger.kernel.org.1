Return-Path: <stable+bounces-161845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB35B0409E
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 15:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D7F169875
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 13:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CB22517A5;
	Mon, 14 Jul 2025 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gNfkaPbX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DED1EEE0
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501250; cv=none; b=uVLKxpWM+u7T57gWICye+Ypy963RbOo3Z/wz3YueV7g2j/EpvFkaWoaESfxps39DqO6Vp6Qr10iwcwBNxut5QIE/pQqjxTztkpmzIEcCP9k9pf0ZtQ8sG4sCGIMHc5iQPxgwbopkMVn0y29tUrEIXYubPuHYri8/CIEvvVMs7+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501250; c=relaxed/simple;
	bh=sjwxrpZWEiQJI7NuiyG74uVLJ5/A89oGO0PVXO2lt9Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iq2u4Ft+IWqBB7jSY4KC4/F52FxPdoGLX8YN6RPA9QLFtOcf1HjvpHs16q6n3b/MLDqAUz7W38gCZOT/IFnCo9N8Rvs/JE2fB6DP5XVlvgqiCxGrOOsOgPHlF9jl4A8LFrmUnfU7Rw2L46ByZCslyTkp5hFu00b4eEOWKIQCUj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gNfkaPbX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45390dcca6dso71555e9.1
        for <stable@vger.kernel.org>; Mon, 14 Jul 2025 06:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752501247; x=1753106047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ISGEOigzwsV3K+qPLuzuuMSZ796iJrx/HHZTsfXfh9A=;
        b=gNfkaPbXTk3QshksUS1hYhSbMs/ppKJMjfaS+WJOZptk4BBeVskod6KcQx8treaLaG
         DpSEaKte9tQq4k8o07yCqo/p/x31zYf2RrwLKpKzrYiTzn2ixAO/rfa94JBiFBZsaHuB
         ltov71FF4hzCh7VeIW1IWKRfL8KdNJjzOZBxotFYLh1pbdY8gS8DKoDzGBqB93MuurVp
         APvEqolallc9dC210XBPjw9joqZLY4EOhXX6riUhfO6ATa7ikXhcea8dZjk/UuypjUGx
         HvBWyJGZqN/MZBoUXUQaT8QWkZqBUChJa4um+aNamwmDzJTcvhlkjg0fnI/i/utjdJ09
         zUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752501247; x=1753106047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISGEOigzwsV3K+qPLuzuuMSZ796iJrx/HHZTsfXfh9A=;
        b=ZEYMjA8mcKY7VVuSrN0tDarrjA6lXtSc0Q8KzC9fbEFQ6GgWAQECLqUnhF58jZIH/e
         11cBT2gwTxo5ZYNObS+BygwE5gjNAJAhga8U4xLhQo6nIQB5TZJCxXJ7lVnXIpGZQ76d
         a36Bhurid7osimOn5QierqQpnBmqGDZ2p9e7HC46KwxCf+4k3vCPeaux3D8SzjIr9iOE
         BMT0Glva8W+ZV1y6B9Vpgsp8L43BBrCFAh2ud657dXMk/CQ5gNsKvy31oc8doFV9NRmS
         8vL9vBzuhKWcN5Gp1kKzeC/wCcx5jb3uIyxzXDaUq4QsEiYz19OMAtIQCZZacZIK0tUQ
         fNlA==
X-Gm-Message-State: AOJu0YxIQRSJokFejpBYDDZ/Y8Tozj4p3njrJ6Hw59wRM1+LYCk9guF/
	GByXzjfLMunjhbA+WtiW+DdFZZYOGkHLUtJPBTyI+wG0+O8js5ZV9005NNKLVVk6qW8PsFqd4h1
	iU+hSc5wj
X-Gm-Gg: ASbGnctxbRHW2WtzcREA7tS214zDRk2715CsIkcTaq1vO9cGHZzOdFUMwLSFmJiP6Q6
	psw42bKq5VAN382ZveuEN7VpJNTQ46PlEbRCWOntApSOzsPzNCbM7lCKaPmCt3t/FNF6xQHmlDN
	DJiZf5a59XshoyRYb6qQ9hrxIRGBQHXLpxxBmlk4KV09V+nxNNLyPchVOR+RmKw1mJfTfaFrohZ
	ubHBA6cZVXIklb27ptZy0UJsHD+WYG3872+oRr5TPVuxHiZ5NzgMtyeqmssaM1oslEeIxY6xb75
	Xrk4Qp6IeB5G5a0z8YEh7q4c/QeD5zEEffPZqOi56nD6rXEF3qbVJZw30q96O7uXrc/DjIilx2/
	vHs2pddMU
X-Google-Smtp-Source: AGHT+IFjZwUhxi4Wf+A5ph2Tqg2qE2rrKH/BS2QEj3ulFaXCrVOZRIIJT6DGzyChlZfJsEFY1QUVkQ==
X-Received: by 2002:a05:600c:c059:20b0:450:ceac:62cf with SMTP id 5b1f17b1804b1-45604745429mr1912475e9.5.1752501246490;
        Mon, 14 Jul 2025 06:54:06 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:46a:594a:89a5:b3cc])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45612aa11d4sm51555845e9.36.2025.07.14.06.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:54:05 -0700 (PDT)
From: Jann Horn <jannh@google.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y] x86/mm: Disable hugetlb page table sharing on 32-bit
Date: Mon, 14 Jul 2025 15:54:00 +0200
Message-ID: <20250714135400.357924-1-jannh@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <2025071420-occupy-vowel-a8a5@gregkh>
References: <2025071420-occupy-vowel-a8a5@gregkh>
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
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1da950b1d41a..f23510275076 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -124,7 +124,7 @@ config X86
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANT_GENERAL_HUGETLB
-	select ARCH_WANT_HUGE_PMD_SHARE
+	select ARCH_WANT_HUGE_PMD_SHARE		if X86_64
 	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP	if X86_64
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_THP_SWAP		if X86_64
-- 
2.50.0.727.gbf7dc18ff4-goog


