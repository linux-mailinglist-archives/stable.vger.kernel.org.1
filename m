Return-Path: <stable+bounces-142059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B0AAAE0BA
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 15:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB64985B82
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 13:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3D825E82E;
	Wed,  7 May 2025 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+oIRqXf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4EF204C3B;
	Wed,  7 May 2025 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746624493; cv=none; b=j/zTcz22Cm1ru2s3vl0dj/vflN3teljDuP9c9vqVU0y55hpO3s0eq5PDOYayZz8aqqGj+Je6RVZdRuwxPih4kkztMCI13otvrcbANizWwneuc+4CClD9M9z6feGtAwGmtSumOuDhgbQtWEkgI/we4lccPK2Y1sEySJ1kTjd7nBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746624493; c=relaxed/simple;
	bh=u7t3YwRqCubqZJgkioqTSzOU6Zs4YmB1mlSyEw9Mr7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XeZ6Mmc7KmeCu14H31H6MGc2WCV2xyEUpiKb3VUp/sBtJAFj/y2+LwBtfQsnWYe7p6I8VENTqZm9km40BREDG122jsbIs3q2O+vhDaQBLJIFu5VHs77xad+WnySY3wetTRIvh1xuzZD9vjG2CgnH5pVbkygP2/+Leu2FzT+TLAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+oIRqXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98745C4CEE7;
	Wed,  7 May 2025 13:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746624492;
	bh=u7t3YwRqCubqZJgkioqTSzOU6Zs4YmB1mlSyEw9Mr7o=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=C+oIRqXf2RPVTUUgOoPZHXrz6HD7qSjBgFaXlGKlYoww0svSFtn3CK95j8Zgma7tY
	 K2bR3kc7c4DUUW8NF/bEo5MjO2HZTBZpAYs5PCTofTZqve+afzr4YWLBv3WQWja4zr
	 Zlzx2OdnlI3x3VU/g1OheR7+TGWljTYqp1F0OUPMJTnEdg4l9/bQWSrmqcX+V99dA/
	 8Q2BwAp1QKFSbr48KBfTmKIrX1El+ILYHEA4ptpmIJJwcxBF9Hz6Gl9/RYjyMWnM14
	 99rBuFNOYQEftkhLME237UwkGPx4oEFQ1h07BZ0mlYbFI2Rhmn/cs6gejF1cF8J/tL
	 4i+ufbO71RyBw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83339C3ABC0;
	Wed,  7 May 2025 13:28:12 +0000 (UTC)
From: Ignacio Moreno Gonzalez via B4 Relay <devnull+Ignacio.MorenoGonzalez.kuka.com@kernel.org>
Date: Wed, 07 May 2025 15:28:06 +0200
Subject: [PATCH v5] mm: mmap: map MAP_STACK to VM_NOHUGEPAGE only if THP is
 enabled
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v5-1-c6c38cfefd6e@kuka.com>
X-B4-Tracking: v=1; b=H4sIAOVfG2gC/63PzWrDMAwH8FcpPk/Dn3XS095jjOLZcmPS2CFOz
 UrJu8/pLqHHMIwOfyH0kx8k4xQwk9PhQSYsIYcUa1BvB2I7Ey8IwdVMOOWKSt7AYMa1znk2toc
 5QRnOMXW3C46mTqd4vUPwMHcjhAwYzfcVHViU1DCHtFWO1N3jhD78PN3Pr5q7kOc03Z9nFLZ2/
 0RF+U6xMKiPCWuPQlqn2Ed/6827TQNZwcK3yHEvwoGCZ8xTq1vZaP6CiC2i9yKi/qShLW+9oM5
 r/4LIf0FkRWQjtG0Ft9yIDbIsyy/9iVPGKAIAAA==
X-Change-ID: 20250428-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-ce40a1de095d
To: lorenzo.stoakes@oracle.com
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
 yang@os.amperecomputing.com, david@redhat.com, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746624491; l=4009;
 i=Ignacio.MorenoGonzalez@kuka.com; s=20220915; h=from:subject:message-id;
 bh=KRtim3yfth2l4PHic4jekA4cmgo5wuFooLe0ZbE9+RI=;
 b=FiOh6lew9Hv1XHsuhoxjwZdijxRDLbIWX9cpBYSWYVXzDW5CLDt21UWHU0wikslAeX5CwFivm
 fDJFj/UjWKTAkzDTmzlAaAYzx5fSBK77NOPaTPE0rCUTw3XUJo1XSkF
X-Developer-Key: i=Ignacio.MorenoGonzalez@kuka.com; a=ed25519;
 pk=j7nClQnc5Q1IDuT4eS/rYkcLHXzxszu2jziMcJaFdBQ=
X-Endpoint-Received: by B4 Relay for
 Ignacio.MorenoGonzalez@kuka.com/20220915 with auth_id=391
X-Original-From: Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>
Reply-To: Ignacio.MorenoGonzalez@kuka.com

From: Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>

commit c4608d1bf7c6 ("mm: mmap: map MAP_STACK to VM_NOHUGEPAGE") maps
the mmap option MAP_STACK to VM_NOHUGEPAGE. This is also done if
CONFIG_TRANSPARENT_HUGEPAGE is not defined. But in that case, the
VM_NOHUGEPAGE does not make sense.

I discovered this issue when trying to use the tool CRIU to checkpoint
and restore a container. Our running kernel is compiled without
CONFIG_TRANSPARENT_HUGEPAGE. CRIU parses the output of
/proc/<pid>/smaps and saves the "nh" flag. When trying to restore the
container, CRIU fails to restore the "nh" mappings, since madvise()
MADV_NOHUGEPAGE always returns an error because
CONFIG_TRANSPARENT_HUGEPAGE is not defined.

Fixes: c4608d1bf7c6 ("mm: mmap: map MAP_STACK to VM_NOHUGEPAGE")
Cc: stable@vger.kernel.org
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Yang Shi <yang@os.amperecomputing.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>
---
I discovered this issue when trying to use the tool CRIU to checkpoint
and restore a container. Our running kernel is compiled without
CONFIG_TRANSPARENT_HUGEPAGE. CRIU parses the output of /proc/<pid>/smaps
and saves the "nh" flag. When trying to restore the container, CRIU
fails to restore the "nh" mappings, since madvise() MADV_NOHUGEPAGE
always returns an error because CONFIG_TRANSPARENT_HUGEPAGE is not
defined.

The mapping MAP_STACK -> VM_NOHUGEPAGE was introduced by commit
c4608d1bf7c6 ("mm: mmap: map MAP_STACK to VM_NOHUGEPAGE") in order to
fix a regression introduced by commit efa7df3e3bb5 ("mm: align larger
anonymous mappings on THP boundaries"). The change introducing the
regression (efa7df3e3bb5) was limited to THP kernels, but its fix
(c4608d1bf7c6) is applied without checking if THP is set.

The mapping MAP_STACK -> VM_NOHUGEPAGE should only be applied if THP is
enabled.
---
Changes in v5:
- Correct typo CONFIG_TRANSPARENT_HUGETABLES -> CONFIG_TRANSPARENT_HUGEPAGE in patch description
- Link to v4: https://lore.kernel.org/r/20250507-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v4-1-4837c932c2a3@kuka.com

Changes in v4:
- Correct typo CONFIG_TRANSPARENT_HUGETABLES -> CONFIG_TRANSPARENT_HUGEPAGE
- Copy description from cover letter to commit description
- Link to v3: https://lore.kernel.org/r/20250507-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v3-1-80929f30df7f@kuka.com

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



