Return-Path: <stable+bounces-183596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 299B9BC4388
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 11:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A8022351235
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 09:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127E12EC0A6;
	Wed,  8 Oct 2025 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kV/lta4c"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0E72BD035
	for <stable@vger.kernel.org>; Wed,  8 Oct 2025 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759917348; cv=none; b=rC+hs3WQScF/kX60u8kfWuMJZccIcfMeI9giLT287U5eK1Vi1+cXUec27AhZ3i3gpaiYtZGhNbkXvJRBx1vWS2MAwDnzbGyeHsFQpcJFUqOEJ49HKR8FEqu928LopHIJiRUq7rSsVl9SPaB6EP2uQvQx42gEhxAmzM6mXhzUfyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759917348; c=relaxed/simple;
	bh=XmXiRndi9JYA5aA7FmSd2/UBeE8sUXwk3HpTo9b2aMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uCucDDnf1igQw6cG5XI/elmbVVp9MfsH5UVdlDSN6+uk47NjzTzhm/7MdwT5YAubFt2YPQwi1qQ9LjqMhgM3fQXx6QSE7/49QfxXC6beT8AuyR8fngiXa75mqUDNFeYiWrxolVLGQ+PKMxISVQp+TxGlxtf5nbXO7Qa49FOV+a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kV/lta4c; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b07d4d24d09so1347187666b.2
        for <stable@vger.kernel.org>; Wed, 08 Oct 2025 02:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759917345; x=1760522145; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pDRBkYZdOzZGDYzEgVoLqa44ujNT7h8FiknWLKuaMVA=;
        b=kV/lta4cQm40USxrcrWfmUWmExTRPbtWkred32MX776dBsj4mUmxSI5FGOTDKhPzeG
         2KfRJesSr7HvU4Q4INtkeTs88OuXtme05w2EuqFe6bHS3ItdJGwDD0Iy/Ixh+VvaNFSv
         AaSsXAXEYGMY2+wBItstqKIN97iYEMhTinScKZjgZMFdxPLfy3Tf5zIeiW1+i1NCRdls
         0JCRaHLz4MQ5Pj2oylnuRsw2qpkGJTunM1NZTH3Ab00jRopYtIpPi/ZYU7mz9yOL67YN
         OPXpYih+sWlySRF903QfKQP+CRAIkMnuyyHiDEgr/c2P4t1tpmAFfiUURoq6PhfFws9M
         td/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759917345; x=1760522145;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pDRBkYZdOzZGDYzEgVoLqa44ujNT7h8FiknWLKuaMVA=;
        b=hG1l+sO65UPntes/vtJ+hS6UA3d9Hocbp1mwiGOIv/HG3kUkvJ5COAaJUwD3b3BPNo
         kSvC6GRP8zfjylpywnQIWXG5oUydipCL0M14wBFX+ZMmP6dBitpoFPeHVag3GyHiGdo3
         Yw39/7p64zqJtR9EPCSekpoyhJbKzlrfpGLo0uFZjv0tG87w+Kk9h30LdVloDHbUbmjC
         iz+kd+5W/+dpO437QtKxYrGdf++Uwo/Vqqw+CbN8/6i67N2tbWsAUK4GWQlNiNvarty3
         QmHHn+Vwc1DYCuStYg5aV02rmX84Ob3UJDBtNLCe57HVIJUBwmdDSho2JIZxf2P+rfx2
         l4UA==
X-Forwarded-Encrypted: i=1; AJvYcCUEWEZMYt7lcaDPoMIZikV6OvR0FtWauws5/eSTiQWCWgIrLJQvlrR95seR+gXzx3q1cDYn1yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvoqjR0rNeA/fhtGn58nCk2C4TLAN6rfzEJWQIYU626fdrG8MX
	o4jTdnoglg8EXm2/oqV6pQVxdYxEVB5h043+V4FgJYjPix/4sTxaTxiJ
X-Gm-Gg: ASbGncs2fdjz2znQUCTupXQkKDHjnXj/BDsqyDufwxB0haeYh1HOze848JEOkF3Z4kG
	g7uJmnMb9F/qisKJ89JyLExre8V2eaIWfmXycVcS9b83YByMxPisoGevJpYpUAwgrF+5BApa7BA
	RpMOB7mR214cBPI8rY2yZf+2civs5C6ckYFOi8kLrUAXwMnx6POn0SXjFaL9zI52m3rbNXD6OrB
	I4+OqvHC/pjifQ1qdmV6Hrl1gkPo5CuYeM+PJztFtQH2DBI6eJRCijEXzOsHIc0pigwQw3bnMv6
	FRD9xK7BoV/O2rhwaFEcDLb486Lp/Ashrcan6gG7Yv3Y7dIBFjcqfx9GqmYImeN7zExHlOJpNbF
	gANogmNSfc2Lrg407jWKOJwCIiaRI6FCch8gDpnzophSnv+ywFQ==
X-Google-Smtp-Source: AGHT+IES8vgaoCILf24BCoYwS+m5uezp0yX3+AYvqyTN8cEUddNOPvKhWr9uhGYOvdam1IrwoNqe1w==
X-Received: by 2002:a17:906:468f:b0:b50:a067:2d83 with SMTP id a640c23a62f3a-b50ac0cc340mr256921366b.31.1759917345375;
        Wed, 08 Oct 2025 02:55:45 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4f7eacdfe6sm416425466b.27.2025.10.08.02.55.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Oct 2025 02:55:45 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	wangkefeng.wang@huawei.com
Cc: linux-mm@kvack.org,
	usamaarif642@gmail.com,
	willy@infradead.org,
	Wei Yang <richard.weiyang@gmail.com>,
	stable@vger.kernel.org
Subject: [Patch v3 1/2] mm/huge_memory: add pmd folio to ds_queue in do_huge_zero_wp_pmd()
Date: Wed,  8 Oct 2025 09:54:52 +0000
Message-Id: <20251008095453.18772-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20251008095453.18772-1-richard.weiyang@gmail.com>
References: <20251008095453.18772-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

We add pmd folio into ds_queue on the first page fault in
__do_huge_pmd_anonymous_page(), so that we can split it in case of
memory pressure. This should be the same for a pmd folio during wp
page fault.

Commit 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault") miss
to add it to ds_queue, which means system may not reclaim enough memory
in case of memory pressure even the pmd folio is under used.

Move deferred_split_folio() into map_anon_folio_pmd() to make the pmd
folio installation consistent.

Fixes: 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Dev Jain <dev.jain@arm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Acked-by: Usama Arif <usamaarif642@gmail.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>

---
v3:
  * rebase on latest mm-new
  * gather rb and acked-by
v2:
  * add fix, cc stable and put description about the flow of current
    code
  * move deferred_split_folio() into map_anon_folio_pmd()
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 002922bb6e42..e86699306c5e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1317,6 +1317,7 @@ static void map_anon_folio_pmd(struct folio *folio, pmd_t *pmd,
 	count_vm_event(THP_FAULT_ALLOC);
 	count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
 	count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
+	deferred_split_folio(folio, false);
 }
 
 static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
@@ -1357,7 +1358,6 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
 		map_anon_folio_pmd(folio, vmf->pmd, vma, haddr);
 		mm_inc_nr_ptes(vma->vm_mm);
-		deferred_split_folio(folio, false);
 		spin_unlock(vmf->ptl);
 	}
 
-- 
2.34.1


