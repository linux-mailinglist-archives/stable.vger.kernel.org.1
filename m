Return-Path: <stable+bounces-142004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AE5AADB29
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 11:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9854C14C0
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 09:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EE0237165;
	Wed,  7 May 2025 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeJdwO0j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4A5236A73;
	Wed,  7 May 2025 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746609110; cv=none; b=kGEARRxIEGxy4Vnp2Fd4ap9ADiCJ2PIGOkdxhggwu2wyoja1iiK1dqR9eL/ifwHgfjaygDMnSEJaE6Sv32GEGcc5ObW4GFlyM5gN264pxN0lmhvr1L/CmnUGR7/ivsz4u2VA7mjMm0/gXhgg1QEgh4UBO3halidasETcoDD6W2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746609110; c=relaxed/simple;
	bh=ruOPmaR3kq6WkNEpmIlLEkIQx5iMRlPXDJqT7pUWy1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GIZA7aczb3+9NG3Rrs9kV4i0QikclbByMK0oWMaLs7RtqfZPUZKMctTDOXwZQ2/v/8vU8IePPtskBBWT+zq6hMzGZPP72jP/gJmYCL4NVjHs0JrpL0yQz0q3ctyiHmvN25eD0keZTM0i/6JYaW6WcGsP8+7o4hJi8px5y4qzzck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeJdwO0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B6EAC4CEE7;
	Wed,  7 May 2025 09:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746609109;
	bh=ruOPmaR3kq6WkNEpmIlLEkIQx5iMRlPXDJqT7pUWy1A=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=BeJdwO0jzY3YVOG8vT7lLaMqjxDvOWOEFuBBQEqnpKqBZkIRo01mThdSqhhUEWcio
	 beD+4EyszAifl7/k8knkVSUrBkGBq1AXKsyDmVolxi/u4Idm2JYkyyVaO4wfwCv3nc
	 zM3vLqtNOhN1jjgWymJhZKS8C+6uJyh87qGemKzZJ8T74YoBpf4ByAtLXVro+lNiJf
	 HCKAUj+QzPjEXUaihpHnnRi+2P+0ErAUGsfkfCTSrvh7eIDWCeCvzsMWCD6/r3AeZh
	 VVOk7ZWOxbD5pAslD1y8WyVKtdAw2LI7FB3iTG6xXdkjkBSY+5dO5K2TwbD3PFgvnE
	 3fXyFUkQ8/OKw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574B2C3ABC5;
	Wed,  7 May 2025 09:11:49 +0000 (UTC)
From: Ignacio Moreno Gonzalez via B4 Relay <devnull+Ignacio.MorenoGonzalez.kuka.com@kernel.org>
Date: Wed, 07 May 2025 11:11:48 +0200
Subject: [PATCH v3] mm: mmap: map MAP_STACK to VM_NOHUGEPAGE only if THP is
 enabled
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v3-1-80929f30df7f@kuka.com>
X-B4-Tracking: v=1; b=H4sIANMjG2gC/53OwQ6CMAwG4FcxO1uzjYHiyfcwhsytkwXYCINFQ
 nh3B148m6aHv2n6dSEBB4uBXA8LGTDaYL1LITseiKqleyFYnTLhlOdU8At0st+6CqNUDYweYlc
 5X08v7GXa9q6dwRoY6x5sAHTy2aIGhYJKppGWuSbpdj+gse/dvT9Srm0Y/TDvb0S2Tb9iTvmfY
 mSQimVKFZlQOme3ZmrkSfmObGDkv0jxL8KBgmHMUHUuxeXMf5B1XT9iL/yTXgEAAA==
X-Change-ID: 20250428-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-ce40a1de095d
To: lorenzo.stoakes@oracle.com
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
 yang@os.amperecomputing.com, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746609108; l=3053;
 i=Ignacio.MorenoGonzalez@kuka.com; s=20220915; h=from:subject:message-id;
 bh=/MtKRql7ItkYcZxcaRWd5jbyLrdw5wLAjEr52LPM+gk=;
 b=QGykkmGizMl/Qs3eTfiT7sngvK4B8FBhNaATEoCQbvxX6Nuvwk5NPySUYzBi0gxfIqG0hYTr1
 AOf+mrM9ExTDqPXoFHTEP4x+UunC8r3hoqB7IKDj3P3snYN864keY91
X-Developer-Key: i=Ignacio.MorenoGonzalez@kuka.com; a=ed25519;
 pk=j7nClQnc5Q1IDuT4eS/rYkcLHXzxszu2jziMcJaFdBQ=
X-Endpoint-Received: by B4 Relay for
 Ignacio.MorenoGonzalez@kuka.com/20220915 with auth_id=391
X-Original-From: Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>
Reply-To: Ignacio.MorenoGonzalez@kuka.com

From: Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>

commit c4608d1bf7c6 ("mm: mmap: map MAP_STACK to VM_NOHUGEPAGE") maps
the mmap option MAP_STACK to VM_NOHUGEPAGE. This is also done if
CONFIG_TRANSPARENT_HUGETABLES is not defined. But in that case, the
VM_NOHUGEPAGE does not make sense.

Fixes: c4608d1bf7c6 ("mm: mmap: map MAP_STACK to VM_NOHUGEPAGE")
Cc: stable@vger.kernel.org
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Yang Shi <yang@os.amperecomputing.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>
---
I discovered this issue when trying to use the tool CRIU to checkpoint
and restore a container. Our running kernel is compiled without
CONFIG_TRANSPARENT_HUGETABLES. CRIU parses the output of
/proc/<pid>/smaps and saves the "nh" flag. When trying to restore the
container, CRIU fails to restore the "nh" mappings, since madvise()
MADV_NOHUGEPAGE always returns an error because
CONFIG_TRANSPARENT_HUGETABLES is not defined.

The mapping MAP_STACK -> VM_NOHUGEPAGE was introduced by commit
c4608d1bf7c6 ("mm: mmap: map MAP_STACK to VM_NOHUGEPAGE") in order to
fix a regression introduced by commit efa7df3e3bb5 ("mm: align larger
anonymous mappings on THP boundaries"). The change introducing the
regression (efa7df3e3bb5) was limited to THP kernels, but its fix
(c4608d1bf7c6) is applied without checking if THP is set.

The mapping MAP_STACK -> VM_NOHUGEPAGE should only be applied if THP is
enabled.
---
Changes in v3:
- Exclude non-stable patch (for huge_mm.h) from this series to avoid mixing stable and non-stable patches, as suggested by Andrew.
- Extend description in cover letter.
- Link to v2: https://lore.kernel.org/r/20250506-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v2-0-f11f0c794872@kuka.com

Changes in v2:
- [Patch 1/2] Use '#ifdef' instead of '#if defined(...)'
- [Patch 1/2] Add 'Fixes: c4608d1bf7c6...'
- Create [Patch 2/2]

- Link to v1: https://lore.kernel.org/r/20250502-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v1-1-113cc634cd51@kuka.com
---
 include/linux/mman.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mman.h b/include/linux/mman.h
index bce214fece16b9af3791a2baaecd6063d0481938..f4c6346a8fcd29b08d43f7cd9158c3eddc3383e1 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -155,7 +155,9 @@ calc_vm_flag_bits(struct file *file, unsigned long flags)
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
 	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
 	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	       _calc_vm_trans(flags, MAP_STACK,	     VM_NOHUGEPAGE) |
+#endif
 	       arch_calc_vm_flag_bits(file, flags);
 }
 

---
base-commit: fc96b232f8e7c0a6c282f47726b2ff6a5fb341d2
change-id: 20250428-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-ce40a1de095d

Best regards,
-- 
Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>



