Return-Path: <stable+bounces-201045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01914CBE43F
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 15:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B6FE300181F
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 14:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC773446C3;
	Mon, 15 Dec 2025 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/CA3vtW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B83D3446C5
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808388; cv=none; b=MyXV1Btr1zbKm/DGw3eaRfAN6hnNJwh4C00U3HV0dva5ZMb1SwmgCtlcvE2UPdVzFlDgKMCaPD/2hz6g2QS4649bwgK/T7Esiy8+HrA/DcsOvL8+8QIZhpd4i/leDWcIDhpGjqK1axT1rsg4z/Vhp2Lvn0oB8zfyCuRwoxNy56A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808388; c=relaxed/simple;
	bh=OzMBOJxaVDe8N1dePuBrfiBywTYG3E45s+K3aAqvcXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nolVsdXcSrBPZmrsdBpY2lqK/1bQP67DF/3WJL0EjGl849lH4C2d8x5Dr8geDyytQj9u6p/ttV2k34E1y3W4qk76XpMXApsPnmhe+AgLcbwnp/pXeiDuiTiZuw3q8fQwzi6L73opARyAC8+3heipjd1Z/N9UC2+Quk8r4APQRvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/CA3vtW; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34c2f335681so1682975a91.1
        for <stable@vger.kernel.org>; Mon, 15 Dec 2025 06:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765808385; x=1766413185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sz2ZyabzWF0ZrqxI+wXOJC7zHA/OIk4HRDatPq5ZR/Y=;
        b=A/CA3vtW8Iiob46zM5WfQslL4YcacgGnaT6+e+Pc+wi5BHqXkGfNBR3oNJFjlP6g2u
         mW6lVitN9LWIo63h//QgX1H9ekrxgmbuY7jT11ilMsS9z3vdhMHigO5miVma7zCkFmj+
         vT1p1oU2ycPpdoV5TSG+xSaJembnEUEtF0oF7MAFO4MgrxK9AUPzxm0Pkc9pk9UnGaRF
         Wtia1sSa1ceIVEnbGZJN8epYGlBKmh50t9pJr5o5dP7pU0Et1qz1mHCIVmPwom0FaDrr
         Ti4fjWmWVSz8p6QO3jgBzHFTzkjfjy+4M4wvIXkQdF0DmIpzyMlDh+6oUSuPULcFSJA2
         RFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808385; x=1766413185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sz2ZyabzWF0ZrqxI+wXOJC7zHA/OIk4HRDatPq5ZR/Y=;
        b=mT9hAb9y1O+2Zuqg5szmhvvoEu3ozZqQstESji3NKVSzKx6TB1ScU8ax6v+VMG0Ueo
         EcgDgVQ+Wq8exJk0ZosgWNrfXAiwkEdTF/bt3wxdwat2U3hhRnDov3rV/+DW8I6xxksQ
         +WJ8IG+U+xyY8Thj9geVGRCNV0YM9lxl1gQxtTQiyiBGsmxlKqbgut2stT4MlELTZsht
         L33FwqR5cM8XEBMrtGHP2Tb0sWUZt0AVjnaSvv9oZ0La0Wjvm31XLXheYDPRC9187V0l
         zYA060mw5nOAXU62lDza8XW+YzrLcQykLsoP1IPFkFjmOza6q3LUwDCvA2bg5IbRPwDm
         F/7A==
X-Gm-Message-State: AOJu0YypQkSdIsJ9PSXgb2Pazf2TG4YrlV6d9si7/ZVgiI3kj2hKpRNP
	89cePwjDNsbry2YKNZCGkgZGOZT5Ky2oxPJ/peNRtCFRjWDTZiwjtBY6
X-Gm-Gg: AY/fxX4Ui7pcL/I0ntHl0GPd1jUcRLeJcreDO6jI9MMl0RnBg9T/HJujYPDB7aNPHNb
	Lysd2XOPvuTj7S6dnoSN91Tqf1JRdFCCNm5CnSUjPDIeN4sMrqhAI6ga4tipi5NQRAXNaEGZWLE
	AIYqPoqI06cd/vwb0rNdO7cXGXAqPJqDycoEkZjaxTh/SIfSKa9MbPxzku2cAhkUqlf+5YQprcZ
	QDh6mm6oonyjPrc62qW+s+dyWibSnZjCx6MV7LL5WDC+jJFu/iYuu94SYsgfqdlN9KyNXJV0b0d
	u3CxakXmNx9Owk+OUwEQVnAg8e5pz/gpm/Hwsb+JK+0T/afQBoB+5G8klJhcJ9S40rynVU+hPSr
	HdscN0owBajHKTPd2Faowz1o56CORjm0+sNzXIBcL/jT/VaHsKMPWjBXTj2s6sh+JNo00r3jzWL
	YmfSE=
X-Google-Smtp-Source: AGHT+IGdF2f/MNFoSK/nrxLbzKgQ5vS0nfeLfMK+djS7OwzM+f7jzutmhjxvjiyFHRAZZn9EuGNBFQ==
X-Received: by 2002:a17:90b:3c4f:b0:340:9cf1:54d0 with SMTP id 98e67ed59e1d1-34abd7a93f1mr9394279a91.1.1765808385125;
        Mon, 15 Dec 2025 06:19:45 -0800 (PST)
Received: from localhost ([2a12:a304:100::105b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe1ffde5sm9524411a91.1.2025.12.15.06.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:19:44 -0800 (PST)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>,
	syzbot+4d3cc33ef7a77041efa6@syzkaller.appspotmail.com,
	syzbot+fdba5cca73fee92c69d6@syzkaller.appspotmail.com
Subject: [PATCH] mm/readahead: read min folio constraints under invalidate lock
Date: Mon, 15 Dec 2025 22:19:00 +0800
Message-ID: <20251215141936.1045907-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

page_cache_ra_order() and page_cache_ra_unbounded() read mapping minimum folio
constraints before taking the invalidate lock, allowing concurrent changes to
violate page cache invariants.

Move the lookups under filemap_invalidate_lock_shared() to ensure readahead
allocations respect the mapping constraints.

Fixes: 47dd67532303 ("block/bdev: lift block size restrictions to 64k")
Reported-by: syzbot+4d3cc33ef7a77041efa6@syzkaller.appspotmail.com
Reported-by: syzbot+fdba5cca73fee92c69d6@syzkaller.appspotmail.com
Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/readahead.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index b415c9969176..74acd6c4f87c 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -214,7 +214,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	unsigned long index = readahead_index(ractl);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
 	unsigned long mark = ULONG_MAX, i = 0;
-	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
+	unsigned int min_nrpages;
 
 	/*
 	 * Partway through the readahead operation, we will have added
@@ -232,6 +232,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 				      lookahead_size);
 	filemap_invalidate_lock_shared(mapping);
 	index = mapping_align_index(mapping, index);
+	min_nrpages = mapping_min_folio_nrpages(mapping);
 
 	/*
 	 * As iterator `i` is aligned to min_nrpages, round_up the
@@ -467,7 +468,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
 	struct address_space *mapping = ractl->mapping;
 	pgoff_t start = readahead_index(ractl);
 	pgoff_t index = start;
-	unsigned int min_order = mapping_min_folio_order(mapping);
+	unsigned int min_order;
 	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
 	pgoff_t mark = index + ra->size - ra->async_size;
 	unsigned int nofs;
@@ -485,13 +486,16 @@ void page_cache_ra_order(struct readahead_control *ractl,
 
 	new_order = min(mapping_max_folio_order(mapping), new_order);
 	new_order = min_t(unsigned int, new_order, ilog2(ra->size));
-	new_order = max(new_order, min_order);
 
 	ra->order = new_order;
 
 	/* See comment in page_cache_ra_unbounded() */
 	nofs = memalloc_nofs_save();
 	filemap_invalidate_lock_shared(mapping);
+
+	min_order = mapping_min_folio_order(mapping);
+	new_order = max(new_order, min_order);
+
 	/*
 	 * If the new_order is greater than min_order and index is
 	 * already aligned to new_order, then this will be noop as index
-- 
2.43.0


