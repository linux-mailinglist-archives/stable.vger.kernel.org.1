Return-Path: <stable+bounces-124767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C09EAA66B6E
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 08:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59C318968C7
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 07:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914231E51FE;
	Tue, 18 Mar 2025 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iITyY2T4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35361B0402
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 07:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742282406; cv=none; b=m74yc9GUCP6PFJtGPDr9Z7lx2Ut4wRk+iD8JNRWKRIM3uYz0OcZnnzCD5QHycYHOyWciTb8BJQ/PSiyJjNzWLOaG+3GJOxVaUMx1QWjyB9NEAQV/gb20l/kQNeifaMDZdeHuEOUIAKEvvJbH8AKRB7DFTIH+9JmGJ66lCYEkoR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742282406; c=relaxed/simple;
	bh=/FqvHLHh3l3qpRKxK3+0ll66WXp6kEuOb87cz5vDWY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=f2hGsHaS7AptIFHgFEkGX2/AbkvZsayQRUfZjRQ9Lojs584kb3zD2s41M2ajpSETLdR/Innxg0TA7+tW76raEkNUU/72tqbMWvIud4Lbh0z7RLWWTnXcbmnJlQA9eqYCKkXd8TUdJu0r00IuH+ZsokbjQu30MRfswaS5eTg9fmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iITyY2T4; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so455590166b.3
        for <stable@vger.kernel.org>; Tue, 18 Mar 2025 00:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742282403; x=1742887203; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y2N+i92fAmW5afCtJ+wC4iVqk8jRVUIClCZRAiQ7H2Q=;
        b=iITyY2T4d/h4jKGz+G8BVHp6xD2OdDy0llxiAA84YAuU8BJilvz6kiGJsDo8dH7X61
         rYY+H5WxtwsZ1c8xt/7WYifuptxB7PnEgr3VaUcwCT7JP9BZKIoCDVFJ2OhVTivtgbGA
         Mh7a3xcbHrWF4IULz5Kww9PkqdkDe3yE5uORe0I5A2kmMdQMAttzSE2l9Ab5E5pXmWuk
         h7+f126Iw5SYxAXH7wt4Y/BAcqIfo1faGSrxqnRe62/3EdFE9AE4ZKKOdCaBWvhfdlpY
         wD6cY7RUq5FmRdKvT9P8VwGj8A7HpZ/0a7JraKcJn2rlEY6deZSUOUrJxIWkcUUztjIK
         k2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742282403; x=1742887203;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2N+i92fAmW5afCtJ+wC4iVqk8jRVUIClCZRAiQ7H2Q=;
        b=MgO6JMtrt6PyuvGnvlSNGg3KhT7AGESOYUJ/ovUeJQ9MYUw2B9iJ9+o2OHglf+cMls
         AImdHdiTaeJB5vLwhkJq8RP+i3wgryR9E4ZlzvZcf6P2xW5CuMdKKC4dABiXzxVZUGuY
         SVxSFWgypBLFIcQ6kz/UUkI4qQmfMlkuslOuo/VL2Rg8s0g4iOVF/qzcrr0KjPbd/9cv
         wSmxx3vh4y6OjTClxi5NAaqi5chJrdYV62JNcl/otb6QZ3ZF2/pgjnnrzVgDkNUMaIal
         APMDcJiCbO8ezLpQuIb1pgTdRpRn/V4ElcbhV6a4Y5U5r9kDdcgLlFwh8tHfZUF94QWE
         uQ0A==
X-Forwarded-Encrypted: i=1; AJvYcCUg5g1Ll95q7aA43+bXBjK5B/crK7GNzZb3waa6X8XIMHoC8BOPIPvUZbE6q75HaufdEpsi/XI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD0aHbBkXoQWriXavvUOjZMJOqVXk14GjFFOZIXzpXX9auAAVL
	npD0wlNKihDqCjF2W2Kiegpka7lXAX0EW2sDF1u5HFLPk3HGmQfL
X-Gm-Gg: ASbGncuUw7drK5GrJNgQK9BDYTdlzpw05xsekmh1iSi2jlm2a8jw0wP4IzvNIq2rIX7
	gNgUn1iH6kRylTD89/2XGChEwrGtEccO01cuHflY9i6YC9vJqqWobKXvrEYAJPDR0h0/TBeBw9f
	U+vF/Nu0+XgHnbSgRiXhaGMPz4afe77Up7hi9bHZm9lU9K4dZf2Y/6IHotPAwalVAfMaFMwYHB4
	djKNecIr6HTEp0EVOsQgF8havP3QHTxTK3gxi20Cw8sT1UWJmEv3onLOqCeUHD+GgmHnSm9NFZi
	oMXZsfdS7kFnesRbSO7oVyc6b2ugLBpJfvRvj0cP50UE
X-Google-Smtp-Source: AGHT+IFTrUaIZvqpSOupkfSU++2j4fNVNAxXa+4OPtJq3dlti+yGn7AS1teR3IpPUf3Y+VUdCzBPvg==
X-Received: by 2002:a17:906:6a27:b0:ac2:7be7:95c5 with SMTP id a640c23a62f3a-ac3303225c3mr1613675066b.33.1742282402610;
        Tue, 18 Mar 2025 00:20:02 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314858a8fsm781703766b.80.2025.03.18.00.20.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Mar 2025 00:20:02 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	akpm@linux-foundation.org,
	yajun.deng@linux.dev
Cc: linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	stable@vger.kernel.org
Subject: [Patch v2 2/3] mm/memblock: repeat setting reserved region nid if array is doubled
Date: Tue, 18 Mar 2025 07:19:47 +0000
Message-Id: <20250318071948.23854-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20250318071948.23854-1-richard.weiyang@gmail.com>
References: <20250318071948.23854-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Commit 61167ad5fecd ("mm: pass nid to reserve_bootmem_region()") introduce
a way to set nid to all reserved region.

But there is a corner case it will leave some region with invalid nid.
When memblock_set_node() doubles the array of memblock.reserved, it may
lead to a new reserved region before current position. The new region
will be left with an invalid node id.

Repeat the process when detecting it.

Fixes: 61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Mike Rapoport <rppt@kernel.org>
CC: Yajun Deng <yajun.deng@linux.dev>
CC: <stable@vger.kernel.org>

---
v2: move check out side of the loop
---
 mm/memblock.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index 85442f1b7f14..0bae7547d2db 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2179,11 +2179,14 @@ static void __init memmap_init_reserved_pages(void)
 	struct memblock_region *region;
 	phys_addr_t start, end;
 	int nid;
+	unsigned long max_reserved;
 
 	/*
 	 * set nid on all reserved pages and also treat struct
 	 * pages for the NOMAP regions as PageReserved
 	 */
+repeat:
+	max_reserved = memblock.reserved.max;
 	for_each_mem_region(region) {
 		nid = memblock_get_region_node(region);
 		start = region->base;
@@ -2194,6 +2197,13 @@ static void __init memmap_init_reserved_pages(void)
 
 		memblock_set_node(start, region->size, &memblock.reserved, nid);
 	}
+	/*
+	 * 'max' is changed means memblock.reserved has been doubled its
+	 * array, which may result a new reserved region before current
+	 * 'start'. Now we should repeat the procedure to set its node id.
+	 */
+	if (max_reserved != memblock.reserved.max)
+		goto repeat;
 
 	/*
 	 * initialize struct pages for reserved regions that don't have
-- 
2.34.1


