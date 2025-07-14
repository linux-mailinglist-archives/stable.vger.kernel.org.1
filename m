Return-Path: <stable+bounces-161848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0ACB040D8
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 16:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9E6F166398
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 14:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8435D2222A6;
	Mon, 14 Jul 2025 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZURt12En"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8718F25487A
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501612; cv=none; b=QGn7tCf3ZNh+YUs9gSux27LFHkoOqX9qf4Pbl0YRwgLlkMecy0mqMiN6xAjA3IDc9tVGCSabuPXK52ewAY1VcTLSsyQE9shNag+7QHwgAw1yLj7Ymsq1rItGcLNsCYSYitR+XWJCYQO/3CdFJ/DF/mljh0iYg7VdZdweT8e7qAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501612; c=relaxed/simple;
	bh=gi5jLndN60r1GCzdNcPmMBCx/qoYpFg7MWyfJhfkABg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFSSXPscgqfF8AfoFT05KH1ngh2hgrB37ZbYe7hDwlUJNP+kYe8xCWUMteiYOiowoDTZHUwPJJnjLh8keDw6XQ96fx2MToA/DaaXeGI3YKmHdFhviJ0FMNXNPUSenLDblMidLla/kUny8qDqm2z7ICcFQnqGI+jIBsox4sE90qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZURt12En; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-456007cfcd7so120825e9.1
        for <stable@vger.kernel.org>; Mon, 14 Jul 2025 07:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752501609; x=1753106409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zp028BzBWMoMJzcM1QZOC4JCXXo0mx5dWlZ0phPXl4U=;
        b=ZURt12EnAhXgQkMZVo6wcRx+h9Kp4CU7WwMK1YXAz4Zkz7QqjoZUIT092ckEGBQyCr
         uZkbVN9UVdwMLdqDUMJdCvbrc1X5GLRov79TsEY4O1McqLCsl3YMd13QsBrbuNAoJlkl
         I62hZPHUYsApGVnwWvGOUP4zJJJGTZAZREQqQkSd4LsXnM2cvoaUrO+JenvMN89dnlL4
         h7JdqqVTixHE7KIbdweoim4Q2M8muzL/AYKs94mr2wUm0Um+HQknusChg/VNp0FgY/Go
         o8CYQcZxb9TuYWVhp2tezfAOrFLqSEsMh44K3WHnApg07GhvKYBy+sZobJLcx7w+eKc9
         r50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752501609; x=1753106409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zp028BzBWMoMJzcM1QZOC4JCXXo0mx5dWlZ0phPXl4U=;
        b=YHV7jIFEtlYK+DvhywZbQwuH/ceNWj451umwV46cOVPUdyxYn9RJNxQtDH4z8wwF9V
         iF2RQQ/Na506OiYQSaPuXYho+U0nl+hPcVxUru87LcGZI7YqbKCcrKakyJ3c4UOC2Wl7
         cUqaikzp68trMXpQwo/FRFX4x2RUvMkwDzGmU5bKqZ0Z+VW66WlMbMnEbXzfETSAWnb6
         WVQmh9kp1PGP8bp0Yt4xAZ4PlQ1r0BP+QJ3wCAhrtCsWvU7IbJ/w7IL0QFniXZBTWI8S
         gn1WtmrYZUECBjaJhs5HUblFQX6DqXQeiMUcVVhfJsd9DwTNugo66rJ1dMzj5lhOsN9W
         UdAA==
X-Gm-Message-State: AOJu0Ywvi9/X//6ZWczNhDkYXAvzqxtSHYJaT0kqyD78mUHhJYhnodEY
	TYnlTFN/4BbLQvdsTl360ZfryLAbplKp/mtat2JrHRPAIZROnlhoS/8lKdJ4lC+hyCvbcv+RP8D
	uBuXWaYHV
X-Gm-Gg: ASbGncvSsXvoa/k6Q2NQcIbvihqzSWwHitUw9GuGk4j4YhETo8mZAfb1TT8iLe5iWGP
	f0ZyzzctBTArRgGeUsoKtqzzR3DK31qJjFNzoYrmi4ZPr0U2r67/5O2xx/Ifs2os5HAPrQ+A7sb
	+KoEwbg/4yOEXz9BiwYjfkfnqFzzsA4kDFU89k032JgcUMXg1GEbzsMlv08ZNgBixO1jcOHBfH9
	kvQi69dvCyXBRhAKT76xutGmE8DSPFuvs7ekPPeGB4C1cpbe57MP1WPiouoiwfW+jto/Yl6H9zc
	ZnsVqW057h3W1wfox6RmFDSwmcAG27u2aCkwdz9n7PcbL4J0nS8cexoAiIULq3Q3CNdtQ3ZAwAY
	pB+EE5Apc
X-Google-Smtp-Source: AGHT+IHDOlMR0d0zev1YApSlYdsjynsBkgM7pPH4/a11qa+hAa2BHqJXThIMtVE3hR5/PTnbPHUFSA==
X-Received: by 2002:a05:600c:8589:b0:455:fd3e:4e12 with SMTP id 5b1f17b1804b1-45600886fb5mr2381955e9.4.1752501608359;
        Mon, 14 Jul 2025 07:00:08 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:46a:594a:89a5:b3cc])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b5e8dc2087sm12702902f8f.30.2025.07.14.07.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 07:00:07 -0700 (PDT)
From: Jann Horn <jannh@google.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.4.y] x86/mm: Disable hugetlb page table sharing on 32-bit
Date: Mon, 14 Jul 2025 16:00:06 +0200
Message-ID: <20250714140006.411966-1-jannh@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <2025071423-imbecile-slander-d8e9@gregkh>
References: <2025071423-imbecile-slander-d8e9@gregkh>
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
index e92b5eb57acd..30e1b61bc10a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -95,7 +95,7 @@ config X86
 	select ARCH_USE_QUEUED_SPINLOCKS
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
-	select ARCH_WANT_HUGE_PMD_SHARE
+	select ARCH_WANT_HUGE_PMD_SHARE		if X86_64
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select BUILDTIME_EXTABLE_SORT
 	select CLKEVT_I8253
-- 
2.50.0.727.gbf7dc18ff4-goog


