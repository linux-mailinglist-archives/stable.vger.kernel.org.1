Return-Path: <stable+bounces-189066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1099DBFF70C
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 08:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50E53A2832
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 06:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA6B29C33F;
	Thu, 23 Oct 2025 06:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVGXZ3Xe"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CEC279DC9
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 06:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761202763; cv=none; b=OTfF5Q9g1TgfbH4Xz7EZNrCTLKZkan7wLI0ehYyFCIQNw8/NE0ThN9kr2D2HYuw1tibkFKYlttFVIIUE7wGdTkV44juSwmLbjr9RJ6MHxJXFXfRnCUt+BMtAg8EbE0OFwj2Bd4HAZ5HWBw9xlPtuD/FaTFyRgACp+404Y1qYrXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761202763; c=relaxed/simple;
	bh=jv3RRiQeAxRj+yS1gIR9ygnBb8z/VVm8giUZt1eG3P0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mVVHc9gRsGPWEFcGE0sk0XQ2BGgkSfSBwYE9ZDca1RnKBqakn9avbTCwudhwwYaRS7jjxRT0jFz1MK/YHF3ppLPGqgOS/1y5se/PjGGxiCvNFVYF4K6u6PHux/sYq04IcWK9LDk05Nto9KQ9nZZEI2q1wR+XUZsWdmZ4NlSwgM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVGXZ3Xe; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-339d7c4039aso505572a91.0
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 23:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761202761; x=1761807561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rv8wkF7zXzO22qUjEduk8QMkq+ulYIyp393gGAAnjeA=;
        b=PVGXZ3Xe2ueNZRV4NcXS0RxIZYo6klu4qou5aLo+QN3kCfDUYU/6/7b/sErcAIGJA7
         dX+o1EHbquax9OV3euJvpISoPQNtq0hfAdw6J5sahdOUnoCYtUQ+TDrs/sWHpetjSDE2
         w9893JySCFztXCTMllf5rRPpL7HXOm0qPaKzxbciyjYHaabYJ5/tT7EeGyrzzLKvi/RU
         5S+DSjOOuhOb1/HuOR+LJGvjLow4kycrFgd3tLG3X+dleKh8PMqNVyGCqWBMN9yZdtPZ
         6/K4I36co15nwkry3LYId+DOqyDpwObi77gFmxcOdhHoTU0VxzOWJGT5Pk9bsNkFS0nY
         YsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761202761; x=1761807561;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rv8wkF7zXzO22qUjEduk8QMkq+ulYIyp393gGAAnjeA=;
        b=N4c0UbSgMdksDQtKW+egYDf/rD63cEM8oglEbZ+t5MZhvBMD5rKFH8CQ6gQ6Kv6M/Y
         0XWota7jl7klwMmkAJkh4FkumEFuLmrmAPlJds3hT0zVE2kGcx/M2smyf3ZvZn2dwns4
         ABpG7pTgAVjHqj8/KbR0+0qtHU7XAAjqGS5Gqvf7PDjZW13Y08LncLvS/N3ndJQ4JYXb
         YZgMwsWltQVsD3ZrZYN7WjGQgS63BFPLlHeGSF0wvam0RuGPuiZhbv1+aHzYvtyGvu01
         9h8+HK8BL9dH5JjMKMCZYevYVaniQKhjdBRc79MkMHoOQk7ymY3os/bBLWeBrzakU0pB
         EOaw==
X-Forwarded-Encrypted: i=1; AJvYcCWRVFx0s72fqytOh0JLBzDvyu1M2aTtO1jA92cPIqS+/tUlUL8HRSQkDgKPjKAAZvS4x/ALQ7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkG3uR7FcSH964Pmdqf6ZpRP2ChdvoA6lxzwjH1IUE3P3dm+Sa
	OGS47MqDszHwrisahsmy1b/RaGRNDfKz0WF32Z03uKxB/Mgt5oKs2QTM5ePlYywk8Fg=
X-Gm-Gg: ASbGncu055pbLwMmSXHdN7yCHA2kBLk3vIsftkPtL0PWLLzXAzKtOECp+UyImIfFy85
	Ugrb7N0aYJn3JB0jzRAUcJHfdRqWxZEmw1IeLqQJ5xGqa+lt+mNLTQsKliScVsRru3aw8cY9Nkl
	PAG6U+gm/ZZWCxMOOfnYPqapLKMH20rEJpyvfpvHc+VKROODS78WozuiIekm9eOk1thHsLwXwWQ
	T7SiZ+L/8UmfJ8jB/lAoJTz3HrupFHqW/1aXBZsE6lGMtHyBcvEepbZZMoBFUFWWZfY3Wm3TYu3
	NFxRKnbGTiK3epyj2zLeDryHsTkteAQBz4CNaKOEkZmBipBE95yLsx6f2wCcee3x1cd1VYYLoje
	LDViAZNvJDx8GqHoCPaFYfksG3JGU8bb/rWCWNEISlC7yBSTE3zqbbcILQ3V0HjLxWSUT9YPaKl
	jSpQH495jQXZhTGw==
X-Google-Smtp-Source: AGHT+IGY9vl7Ys2QrXyChnMJJ8Hm15T8p66vefo6gmsF42VNf8SOd0Wf86nEbGrndI9aN+e5mM9IXw==
X-Received: by 2002:a17:90b:1dc4:b0:33b:ade7:51d3 with SMTP id 98e67ed59e1d1-33bcf8f78c4mr32616407a91.20.1761202760650;
        Wed, 22 Oct 2025 23:59:20 -0700 (PDT)
Received: from KASONG-MC4 ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fb016f83fsm1351963a91.12.2025.10.22.23.59.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Oct 2025 23:59:19 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Hugh Dickins <hughd@google.com>,
	Dev Jain <dev.jain@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Liam Howlett <liam.howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mariano Pache <npache@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] mm/shmem: fix THP allocation and fallback loop
Date: Thu, 23 Oct 2025 14:59:13 +0800
Message-ID: <20251023065913.36925-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
Reply-To: Kairui Song <ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

The order check and fallback loop is updating the index value on every
loop, this will cause the index to be wrongly aligned by a larger value
while the loop shrinks the order.

This may result in inserting and returning a folio of the wrong index
and cause data corruption with some userspace workloads [1].

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-mm/CAMgjq7DqgAmj25nDUwwu1U2cSGSn8n4-Hqpgottedy0S6YYeUw@mail.gmail.com/ [1]
Fixes: e7a2ab7b3bb5d ("mm: shmem: add mTHP support for anonymous shmem")
Signed-off-by: Kairui Song <kasong@tencent.com>

---

Changes from V2:
- Introduce a temporary variable to improve code,
  no behavior change, generated code is identical.
- Link to V2: https://lore.kernel.org/linux-mm/20251022105719.18321-1-ryncsn@gmail.com/

Changes from V1:
- Remove unnecessary cleanup and simplify the commit message.
- Link to V1: https://lore.kernel.org/linux-mm/20251021190436.81682-1-ryncsn@gmail.com/

---
 mm/shmem.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b50ce7dbc84a..e1dc2d8e939c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1882,6 +1882,7 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	unsigned long suitable_orders = 0;
 	struct folio *folio = NULL;
+	pgoff_t aligned_index;
 	long pages;
 	int error, order;
 
@@ -1895,10 +1896,12 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 		order = highest_order(suitable_orders);
 		while (suitable_orders) {
 			pages = 1UL << order;
-			index = round_down(index, pages);
-			folio = shmem_alloc_folio(gfp, order, info, index);
-			if (folio)
+			aligned_index = round_down(index, pages);
+			folio = shmem_alloc_folio(gfp, order, info, aligned_index);
+			if (folio) {
+				index = aligned_index;
 				goto allocated;
+			}
 
 			if (pages == HPAGE_PMD_NR)
 				count_vm_event(THP_FILE_FALLBACK);
-- 
2.51.0


