Return-Path: <stable+bounces-188415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E14BF8309
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 21:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7BED4EE139
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 19:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E14346E7A;
	Tue, 21 Oct 2025 19:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqebElYu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F149264612
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 19:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761073492; cv=none; b=a1UU6okVEf8u0NgOIVLYEYSsW85jF9ZPa1m92nhGSBB0MPkCcntBp6ISFu8IOQylvqYSL78FLSLonOMxf8jfTO69XqToyLG0UM8VdnXdO6Es5wuFKoUZJTr/6pzv8LFpz993cB6O2kbozA9mFEC5iqkZ5J7md001rYfAs6E1Ifw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761073492; c=relaxed/simple;
	bh=q11VqPhISxAq83SdAd0VRiD2EuJuQ7IvglCXKCEFYKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a91Yq3pRSEiNEVnTxRe836amu8HHBG/mRG6hfhbVHTkzPcbmPgsYIG62QVEMDK+CyZOBBynP3C8bN7nW8k5WENi1alqSeZODp5M7M++FWSLrfhGlhZ/M4YwVGNVY8wzTH4nWo9J3Zwvtb0o4bnwYVeVQqxSpwE4l0yaG5atNg+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqebElYu; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-781997d195aso4564779b3a.3
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 12:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761073490; x=1761678290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ISZWYz7jwfSXd9tq4inzuqOWmGJUHyHpKimpAOEt6OY=;
        b=kqebElYuOlYJNumYFTw1asnsmq8yZDSltsM6ONFo+C6Gm72w7xccRCkXQ9dLcUKecC
         m+57wsUYiBYNOCm/626ue3KMLeSNfcJ1mas+VzcwuB3uwYpPKiSJOPLy4UwS21d7OQ1E
         Khzxh6ZDVIxADvRb2BojG5aH1BN94DN4aC4o1CIv0Y7o8mba6wqM1xZi5hvMwlIXnL4J
         t1DMNYPNOvadyeMRf/GIHGU8A6mRottlgJfkZRTvUSEQghoCsFrRq8oeeO1untZtGTNw
         w5tlMvoKWBiFIRcFaaLPRtIiXtYJmexE6FkFqAca4aloixqFLVSku1i9N5wsF60Q8wje
         g2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761073490; x=1761678290;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISZWYz7jwfSXd9tq4inzuqOWmGJUHyHpKimpAOEt6OY=;
        b=Y1KQD+qkBpkCV7ThKydy0bpvvx0Hq1IBlv4nGwymgaaLnvxi9PMl8Nr9vgmX5L9/m8
         si4134PbQiOvX8wa2avb8unicMwcKUYlWaVODlooonCMGvLcPto3opYhFpEtv39gU7uD
         zQm+TEW+DlyZ4tsUD5PilBFqWWR9YjCUIyTZtMO4k8BMgrU+yFseGcHoRovMdNsVhlEx
         WShtitT3RzubLFCRQt/p/Hai9h38ECbw8z/bbAbfo34DOH13cQAq7cKyPJsJ3GooioJz
         HcvrPdnZiMWVlgdZQxsfLdZNiwhvePyu7Q2oYbyeXS51F+RjVjbehjjuL3K9ZAwucgVM
         Hj2g==
X-Forwarded-Encrypted: i=1; AJvYcCWQrb2IReJymzW0JvC+a7yWnwT+pWaVNPIu76QSKh9nFRpmzc23436yzYPMAiB1B6k/nCQs+5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAkzXFSS08A0qZnFlmYicidqEZp5oXkk2Yg2fWEBESfP2p9Wot
	dfiBnVMGE2zVnGIRHMCdMb8Tn5os+o5uBIBZDpFZFmfJaTp7HuNtE1vE
X-Gm-Gg: ASbGnctsXlsAG9NmoZMPMj9L0YUB/rkgcGlXyyXV6aNIEqXOylGvLcJcsIU9ErU6oRZ
	HfNlsClmCcbF6RswoCh4pyjZRkS0Wjenz5UZYw453wwNqFQ7Jw4KRkXS8ZpMgDy1cCj0GWgCDbc
	joZ6gIuCfano8XQORdD7hLNpOqQYBkwKpHUlsuoT4hVzQhuXBE262JoU/HFI+MpfizxtaL4LCrz
	mg31joTouwicVZxa8OKyrvWrxN/e39Db0UGnCRs7ymFeBLgmPDaZZvpi321uDhubc0n7PK8J2Ic
	lt5sVlQA9KTcZPHBn3udyyZGzyhs8j12U677u8H0NQf+3fq8wX4+gZh1LXTMfLzczVUpGlPo/Kd
	SCu8ou1xWDFFjgh8cHsMmh2n4ChWz3rUyVYsWnA3zvDtVYpbAeWhleLGP0cIdSoCm6adO37K0Bh
	MUTymUIaqaHjc+xn0BtCoNNT2JVMnafio=
X-Google-Smtp-Source: AGHT+IHkT8UoFnBBi1CBq+2YccEgjqBI+DLZKtcKn0a9UNxsMkVcsdd6kuH2vJPgljjD95mJq5TuRg==
X-Received: by 2002:a17:902:fc8e:b0:27e:ef96:c153 with SMTP id d9443c01a7336-290c9ca73a0mr247432075ad.19.1761073490421;
        Tue, 21 Oct 2025 12:04:50 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebca5csm117664615ad.19.2025.10.21.12.04.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Oct 2025 12:04:49 -0700 (PDT)
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
Subject: [PATCH] mm/shmem: fix THP allocation size check and fallback
Date: Wed, 22 Oct 2025 03:04:36 +0800
Message-ID: <20251021190436.81682-1-ryncsn@gmail.com>
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

There are some problems with the code implementations of THP fallback.
suitable_orders could be zero, and calling highest_order on a zero value
returns an overflowed size. And the order check loop is updating the
index value on every loop which may cause the index to be aligned by a
larger value while the loop shrinks the order. And it forgot to try order
0 after the final loop.

This is usually fine because shmem_add_to_page_cache ensures the shmem
mapping is still sane, but it might cause many potential issues like
allocating random folios into the random position in the map or return
-ENOMEM by accident. This triggered some strange userspace errors [1],
and shouldn't have happened in the first place.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-mm/CAMgjq7DqgAmj25nDUwwu1U2cSGSn8n4-Hqpgottedy0S6YYeUw@mail.gmail.com/ [1]
Fixes: e7a2ab7b3bb5d ("mm: shmem: add mTHP support for anonymous shmem")
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/shmem.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b50ce7dbc84a..25303711f123 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1824,6 +1824,9 @@ static unsigned long shmem_suitable_orders(struct inode *inode, struct vm_fault
 	unsigned long pages;
 	int order;
 
+	if (!orders)
+		return 0;
+
 	if (vma) {
 		orders = thp_vma_suitable_orders(vma, vmf->address, orders);
 		if (!orders)
@@ -1888,27 +1891,28 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
 		orders = 0;
 
-	if (orders > 0) {
-		suitable_orders = shmem_suitable_orders(inode, vmf,
-							mapping, index, orders);
+	suitable_orders = shmem_suitable_orders(inode, vmf,
+						mapping, index, orders);
 
+	if (suitable_orders) {
 		order = highest_order(suitable_orders);
-		while (suitable_orders) {
+		do {
 			pages = 1UL << order;
-			index = round_down(index, pages);
-			folio = shmem_alloc_folio(gfp, order, info, index);
-			if (folio)
+			folio = shmem_alloc_folio(gfp, order, info, round_down(index, pages));
+			if (folio) {
+				index = round_down(index, pages);
 				goto allocated;
+			}
 
 			if (pages == HPAGE_PMD_NR)
 				count_vm_event(THP_FILE_FALLBACK);
 			count_mthp_stat(order, MTHP_STAT_SHMEM_FALLBACK);
 			order = next_order(&suitable_orders, order);
-		}
-	} else {
-		pages = 1;
-		folio = shmem_alloc_folio(gfp, 0, info, index);
+		} while (suitable_orders);
 	}
+
+	pages = 1;
+	folio = shmem_alloc_folio(gfp, 0, info, index);
 	if (!folio)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.51.0


