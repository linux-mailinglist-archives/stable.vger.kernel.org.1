Return-Path: <stable+bounces-183002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB9BBB2487
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 03:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A97DA1C6475
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 01:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11435537E9;
	Thu,  2 Oct 2025 01:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTpduTkN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044A1A59
	for <stable@vger.kernel.org>; Thu,  2 Oct 2025 01:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759369112; cv=none; b=iQ/9iSy8s9NlbqGmC45NMqch4oJHfyKi/FsMaGJRN/m7YR+1bFkxaFH3JS2PaIoZo/Ts4OCbUNhhloGEMcfDNxcaH41wKBsCRuib6xfj3yxzMoBdtKzJpXwrIkOlj1esZ74hs9VVgnTzu+L6s8h0kU216UlK/xa5nxUSHG+xfVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759369112; c=relaxed/simple;
	bh=8YzC51JPZ0HB5StgwEw+cbANxX6bc+oN2mcNNFa/M/U=;
	h=From:To:Cc:Subject:Date:Message-Id; b=X7xW7eR0P1gvJqQzkZEAivzjpintw+Ce2zu7cEvYU6ykGkIAXEEcfNyLXX7mURPxtd77zNdCfrn6RWqpePXFjoxtIc4DTupAbWGXBGMALwoBqAJ0V/u9CZZil+fDwZhwgqIRlIn2JAypHUA82R2iQF5Obg4UoGad5QZBsgppwPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTpduTkN; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3b27b50090so100982166b.0
        for <stable@vger.kernel.org>; Wed, 01 Oct 2025 18:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759369109; x=1759973909; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDDnGBDOOGji4bOsQZ3Ul8bZ6/fdo9llPBcLLrM9Xhw=;
        b=VTpduTkNOM+6qS6UWVJ8Dut+8Iql0fHSoPvG0KXmiQg8LEV9i2tTJ49RO4LPIu2I/Q
         XXQtOx2up6Zg1/ImPJyd1zDvsrXpkJkWUvl4HWmmETKgDIeET2j6TJhGtvCPDwsfX6uh
         7aWhtJfrp+ZpPzMP7aYPKV/goyrdGtgNF0NX8G8t1NbIr8A1OARBFSed7SHHIAeJIYpu
         8eBW8dHxJ1JoAdtdD1H1Ko9VQMyXAu9ZIJAFqj0hvGNRPbpRlEn0lMIK83fhpwa3gCwD
         glJbOVG9Mnkmza+j8rdvpDo6EQ1LJ/oH6+l/D9mZE4DHIfEt5Fr5fEPEju86+xsTGmZU
         dz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759369109; x=1759973909;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDDnGBDOOGji4bOsQZ3Ul8bZ6/fdo9llPBcLLrM9Xhw=;
        b=FuqaLhYTsOPLQ7y/z7llDUfMm0tiNncIQytiaR+ljn3+dMRdqQb7WleWM/e2owRQh4
         mun1pIGJMI1WTUGjFz97Zj1J7bTpICskztmsaZuMQUtlXeM1LIUfbUz4F7d1xMlbpHb4
         ti8lGAQ1n4jAEsP8jon5r739VcLcqYyXBrHsCU33mPim5vKTyLPlJ3GUU3nfrp3wiQPb
         xQulRzsvABvlihUU8NiqNs7Qck8a5Z9gSK4+Pt21v7YUOyz0tW54QZKpAh69MMelh48x
         PrdqSpd0eKDwCyYbfDF26XtnRTWwMMspcv/4ncab/2QSHYORH274/2XEX33uZtF1HhYM
         Kd0A==
X-Forwarded-Encrypted: i=1; AJvYcCWicmJh4tQVsLMjyJc2J2EGWcf04cRvVfYaYPu2t88qT9rpcWn4tBXqXi+iJunYjQwRjxFpEkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Slg6yzUJSDUBlze943VTSiYHi2o/nu7nnbnMPooQT5fvHWno
	rCjuWpaaXfmrtByQhXhliecBP+D2N/g/DcEEbD2JOlf5bEbBHyDZAvSz
X-Gm-Gg: ASbGnctRO3igNdgOaDgZ7rw6gfBktvrLfeNyQrX6dCboD3LBhc8mc/1A+T11sJVduhn
	RaUSE8XevxFYr+5+XguXFGXY5uouj6DoLcZxkhK05BfuGcB2lgOVgI5ENA/ul6apjsv78cbyvK5
	dTZSq4gqef3zYrbh0jLWGUySoaWtwAJ9sdFt9eyzzNJ1rjlEFh6BJw5ktjzZmwUln0YEsQ4fIAk
	dcskCLDXnvLlV7zVXV8Nk8ChctEQffIuDC4cUf5LzXhO7me304nnD1gtO6AmPrG6qzIcLEuacAo
	543TIS7aZ3POu3CSsdSjevzEiYKaEQ3ZCRTFo2SqXgX6LNLniIVbw9RzP8McvkZjtBC17DyKtjD
	dBpE4hX6DVKf6isj0EpSLNzEGZq4irqzbYv1Fqr2IofW/PV+UAQ==
X-Google-Smtp-Source: AGHT+IGYkhK9D83thDffjxtcF3fdgyIYZDpOc53LuXBxHq3bDwX85vgQKbTPEoz+O+2+HOtqs+z6Qw==
X-Received: by 2002:a17:907:6d0b:b0:b46:abad:430e with SMTP id a640c23a62f3a-b46e47910c6mr675645966b.37.1759369109107;
        Wed, 01 Oct 2025 18:38:29 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b32bsm87824466b.50.2025.10.01.18.38.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Oct 2025 18:38:28 -0700 (PDT)
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
	Wei Yang <richard.weiyang@gmail.com>,
	stable@vger.kernel.org
Subject: [Patch v2] mm/huge_memory: add pmd folio to ds_queue in do_huge_zero_wp_pmd()
Date: Thu,  2 Oct 2025 01:38:25 +0000
Message-Id: <20251002013825.20448-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
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
Cc: <stable@vger.kernel.org>

---
v2:
  * add fix, cc stable and put description about the flow of current
    code
  * move deferred_split_folio() into map_anon_folio_pmd()
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1b81680b4225..f13de93637bf 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1232,6 +1232,7 @@ static void map_anon_folio_pmd(struct folio *folio, pmd_t *pmd,
 	count_vm_event(THP_FAULT_ALLOC);
 	count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
 	count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
+	deferred_split_folio(folio, false);
 }
 
 static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
@@ -1272,7 +1273,6 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
 		map_anon_folio_pmd(folio, vmf->pmd, vma, haddr);
 		mm_inc_nr_ptes(vma->vm_mm);
-		deferred_split_folio(folio, false);
 		spin_unlock(vmf->ptl);
 	}
 
-- 
2.34.1


