Return-Path: <stable+bounces-158861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 089FBAED2DD
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 05:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED8D16AE15
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 03:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C318229CE6;
	Mon, 30 Jun 2025 03:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KX9WY1hR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBF81DA55;
	Mon, 30 Jun 2025 03:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751253602; cv=none; b=SYCMZKPT8Az/n17+WUcjZkmlv6WpKg98wRHinNRqc6FYAKi46hQy/xh2qo29FP2MtHkxN9NlXc48MpLG6FmQheCobT9LDzsMjIdj11VGjAYMsGMBx2cyPDdSB0vGL+Ij/Rdh4rSo6mF3VLx7tsg+yzWw/iWZef6G0AjbZZXErc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751253602; c=relaxed/simple;
	bh=I+E03Pih6Nc8R/ntsygbzVXB+VC/CQ5HinZSLniQbM0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VBetRoR4XfWH97Z/L1vprH4ofAOJSuBALEAE9v35uEU3E9IZHe57wbvY10zy5dlnAl6HnLkjyMbO9PmpdvgOb8scM4z91AKazbOqioi75KcjFu5vSJqEUpvYrrk7MVl3j41YK4HOs6guWrylQcel2qwAHEwNtdW4YuYHuZ9dOIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KX9WY1hR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04368C4CEEB;
	Mon, 30 Jun 2025 03:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751253602;
	bh=I+E03Pih6Nc8R/ntsygbzVXB+VC/CQ5HinZSLniQbM0=;
	h=From:To:Cc:Subject:Date:From;
	b=KX9WY1hRAbcunK11JaGE9UFymH5CUhaFBBbpAQTkvvBP+HAPGNz/+9Byw6Sl1tcDg
	 72Js+EaI382Ylk9jtThNh0JCi7/sQzn6YAu3U2mehSspH6WwrYsE7Le42wy5jCXBny
	 aSVNvXXrsLUGm2eL0MngEhD8WUzxvf0El9qeKoNPp8HX6B+n24zM3EO0cW7+qWcevy
	 zJSxxT54eEPe96wHEVspKO5lW6DEMjOHyM1OjIfZXniNY4g4KDesTBy6pcaonAOOwE
	 GYyZ0MfiZupg4Yj0i7QL+pds5x6obGOPMHfyCTTfQSdm4jXMkeCdZaT5w693AhJFaD
	 JUCSbcTohKVtA==
From: Sasha Levin <sashal@kernel.org>
To: akpm@linux-foundation.org,
	peterx@redhat.com
Cc: aarcange@redhat.com,
	surenb@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] mm/userfaultfd: fix missing PTE unmap for non-migration entries
Date: Sun, 29 Jun 2025 23:19:58 -0400
Message-Id: <20250630031958.1225651-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When handling non-swap entries in move_pages_pte(), the error handling
for entries that are NOT migration entries fails to unmap the page table
entries before jumping to the error handling label.

This results in a kmap/kunmap imbalance which on CONFIG_HIGHPTE systems
triggers a WARNING in kunmap_local_indexed() because the kmap stack is
corrupted.

Example call trace on ARM32 (CONFIG_HIGHPTE enabled):
  WARNING: CPU: 1 PID: 633 at mm/highmem.c:622 kunmap_local_indexed+0x178/0x17c
  Call trace:
    kunmap_local_indexed from move_pages+0x964/0x19f4
    move_pages from userfaultfd_ioctl+0x129c/0x2144
    userfaultfd_ioctl from sys_ioctl+0x558/0xd24

The issue was introduced with the UFFDIO_MOVE feature but became more
frequent with the addition of guard pages (commit 7c53dfbdb024 ("mm: add
PTE_MARKER_GUARD PTE marker")) which made the non-migration entry code
path more commonly executed during userfaultfd operations.

Fix this by ensuring PTEs are properly unmapped in all non-swap entry
paths before jumping to the error handling label, not just for migration
entries.

Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/userfaultfd.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 8253978ee0fb1..7c298e9cbc18f 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1384,14 +1384,15 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 
 		entry = pte_to_swp_entry(orig_src_pte);
 		if (non_swap_entry(entry)) {
+			pte_unmap(src_pte);
+			pte_unmap(dst_pte);
+			src_pte = dst_pte = NULL;
 			if (is_migration_entry(entry)) {
-				pte_unmap(src_pte);
-				pte_unmap(dst_pte);
-				src_pte = dst_pte = NULL;
 				migration_entry_wait(mm, src_pmd, src_addr);
 				err = -EAGAIN;
-			} else
+			} else {
 				err = -EFAULT;
+			}
 			goto out;
 		}
 
-- 
2.39.5


