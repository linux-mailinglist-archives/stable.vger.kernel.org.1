Return-Path: <stable+bounces-181830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D4DBA67F0
	for <lists+stable@lfdr.de>; Sun, 28 Sep 2025 06:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09CD43B676A
	for <lists+stable@lfdr.de>; Sun, 28 Sep 2025 04:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDD0221FDE;
	Sun, 28 Sep 2025 04:49:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8AF221F34
	for <stable@vger.kernel.org>; Sun, 28 Sep 2025 04:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759034964; cv=none; b=EO45I8EW9D6p0bgf0tDU+B/cuCpSsa+GaMdBlhMGs/PSQzVduI4f1SpqaddoCycVIF5RH15VTNstaNZ5A8U2rMEOGoet/++lFIEqjaGVA8sBxGLgPkAwXV4Kh7tLqKArE3jauOrlvIORFpIWy5k77Jb3Rj1odGqMmNHO6RA+o5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759034964; c=relaxed/simple;
	bh=3JXHdTFd0Do4NsJQmtnD90PGDnc76HJueRPgFM3FauY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rbUxKhxGRlaiIynvDLH0V5fdixUleThGcg/saOeFnW95qup3uWE2DzSXNaLaPWzEjCXctKRROSEL1QfuUSKcwNIXt/WyYPQwKaBcN+LiNXFbuJVfvZ/+cuMMo0L2XV68S9167sNzcd7lo2cVhnPZW8f5Q1P6IFMyX3RjJkmqJjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3f42b54d1b9so3478613f8f.0
        for <stable@vger.kernel.org>; Sat, 27 Sep 2025 21:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759034961; x=1759639761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DyUaaqdWAgLg9ININm7xedY+UnymRaRfwlVA8p6wolQ=;
        b=lPqeuiDb9VdmJw1Pwwfxkgwx0POZH9+KJ7YbqjfG9e5EYFILC5bofvj63HtVqcIjTl
         fp1Y0rM9MhrdGz/r6jsOb+MhnNqXt4dBJcsLhJX0lC3mcWh/llq58yMVZKnOZTRn6X05
         ThvsmLLXIScOjZcZS3u1upM8E+TlCU2ib6a0TXpOD9H5iU0SQ16J4TcYRbek7SbFTyMe
         RolxA9ePkm2ZymotEIevFEujqGpeTvhchAuT7IEfkkrKczHMwJsfo84i3p6RlBDtrRhZ
         WON7Tr/BjxqvpHVfahXQwss/Kl+LfF6TUAndUz1kJc9p/dh8PbBYsBu/jFbBFw54C8Kl
         QO3A==
X-Forwarded-Encrypted: i=1; AJvYcCW96lvZxjFepZzygMKD3RaC1tIcOnL7BvgdKr50zXYw6lBvOZYMTQeVQcZVwNuTDC3nViFIdBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxchvTfgwdrZPrtA/V4wT9paa1fFj116RMdT7h3ClwVb+suv5Ss
	LCdNxP/TgOlyv8BWC7B+Xeqv7on2yKHEmsIrduNrgDD7eUfNj4/OQkFa
X-Gm-Gg: ASbGncuoaSNz0rXKdhfOgnVOF9r0lIDFDeb0hwvN9sKqyLH0aouL2LCL/0af+Za7nBF
	G0VEVoskRZx2e76QaMWO0/aVlwdHSvJ7KaScoSG6AjaVWK5ffpgmAsOTUVDgmOdi2Oe/JPuCept
	FF7uk/JSzj/Ehjf9yvvP8LROpPaJpLiUbmlqg0DJjADTdpg6b47V8GWskSX1pCXxvLqcoFTW8sw
	yOWPkbU4LgWUozk+gM4XmGjjKjH9qtuiBLFEBuErS6BhQ1pCAZQTcqwGDKsbB/visxd4huxhPZV
	USpkr5V7lpMMQBITeHQSXdaESrIB6BiAwXi+Aug3Ix0amZBss4SnI46aiEUDrM+ucCe0Lk08E27
	fBxwnQ1/xJ3atFql/l/7HxuBDvKXAX4QdmA==
X-Google-Smtp-Source: AGHT+IFtXLQOdcvQ7Xjrg3v0c2+UOl4vx5bR+h7AWQ6ssWZLLcWyTpq2xRAkUoQVnuyBrbH3ylk2aQ==
X-Received: by 2002:a05:6000:2dc9:b0:3ec:ce37:3a6a with SMTP id ffacd0b85a97d-40e4458ce65mr11243196f8f.22.1759034960758;
        Sat, 27 Sep 2025 21:49:20 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a09:0:1:2::302c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb8811946sm13119628f8f.18.2025.09.27.21.49.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 27 Sep 2025 21:49:20 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	npache@redhat.com,
	riel@surriel.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	harry.yoo@oracle.com,
	jannh@google.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	usamaarif642@gmail.com,
	yuzhao@google.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ioworker0@gmail.com,
	stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH 1/1] mm/rmap: fix soft-dirty bit loss when remapping zero-filled mTHP subpage to shared zeropage
Date: Sun, 28 Sep 2025 12:48:55 +0800
Message-ID: <20250928044855.76359-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

When splitting an mTHP and replacing a zero-filled subpage with the shared
zeropage, try_to_map_unused_to_zeropage() currently drops the soft-dirty
bit.

For userspace tools like CRIU, which rely on the soft-dirty mechanism for
incremental snapshots, losing this bit means modified pages are missed,
leading to inconsistent memory state after restore.

Preserve the soft-dirty bit from the old PTE when creating the zeropage
mapping to ensure modified pages are correctly tracked.

Cc: <stable@vger.kernel.org>
Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when splitting isolated thp")
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 mm/migrate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index ce83c2c3c287..bf364ba07a3f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -322,6 +322,10 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 
 	newpte = pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
 					pvmw->vma->vm_page_prot));
+
+	if (pte_swp_soft_dirty(ptep_get(pvmw->pte)))
+		newpte = pte_mksoft_dirty(newpte);
+
 	set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
 
 	dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));
-- 
2.49.0


