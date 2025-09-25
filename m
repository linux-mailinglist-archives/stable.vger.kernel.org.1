Return-Path: <stable+bounces-181679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 100CBB9E06F
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 10:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02322E74C4
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 08:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF861270EC3;
	Thu, 25 Sep 2025 08:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iyw8xIAF"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E051C28F4
	for <stable@vger.kernel.org>; Thu, 25 Sep 2025 08:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758788634; cv=none; b=IcMdRjUWRHKZEeQybXvOWc2kglPXkmns0/ccyTQ05clG8WY25Qi9iSAifupCguY6WWBEW1o4O+HKkwtU2LUuPPQEmzdimiTTbdbVqGaCKq+McO8ImJGYzooSwpCsbWXMYmzeQCWdmYHb9h0/mviTfIlrqXgXcQx/I3WD/t9jDSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758788634; c=relaxed/simple;
	bh=FyPBMC+u6WmwxxgxQaeDIAbZRbtNrun+FUt2WygiqSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cn/4mWkjrli5wUxmQaQkxR6VN3aGX3li/FRhPDS9T8yR+DtAO5KbpwamhXocvN+/SjL9DKUOAwT9Xvc2+S32R8h9P6z5uWtsh+haO/It1EQyHkvuniZ4w/BZa5hEnHUVXVgC0Kys3b6sTOjCKtKsNihaK/PzngwGjfPoiANUvek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iyw8xIAF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758788630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ZvnS4t8ULDy3oaZBxZU8fjXxnnSXaMVp56Tg/MX2OA=;
	b=Iyw8xIAF/VW1GT/zg90rfv0rzd9a61URRsWetURf0dnbDwhGZzOA66WIXE9JH32K+WRQqZ
	j910rXSfMmDa+BU5Mu9pxRDS4xbfY3frsjVI9oSCUlyt2UbpFNsybddp0aJSITvOnCFZGg
	93sRxWYuhZZ3vV8wMwmNV+er5bU7ySQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-BEnmsVtEMdiCuGdqZvt32g-1; Thu, 25 Sep 2025 04:23:48 -0400
X-MC-Unique: BEnmsVtEMdiCuGdqZvt32g-1
X-Mimecast-MFC-AGG-ID: BEnmsVtEMdiCuGdqZvt32g_1758788627
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f030846a41so459010f8f.2
        for <stable@vger.kernel.org>; Thu, 25 Sep 2025 01:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758788627; x=1759393427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZvnS4t8ULDy3oaZBxZU8fjXxnnSXaMVp56Tg/MX2OA=;
        b=s5Y95NS4/UbN0WrZDVCL1I+mcRJabRV76rEanjZ9+gYL1OICAOAN7L91zJKQP9iDSH
         5vV9/dSH1H4SBXyY/SAycgi/dtD3BeyT44eM5cS5a6JQiZCQjAyT3+Qt4/hlBN6aGgIV
         uO7zBkTzqGybLftf3C+LgiWLRzUwSxB/7MhbXM7/+8ne0N8AsOwe7sNis9/KpqkD0MEo
         INLvsxvFN2W133pSMaiWtMoIfp5rXL7k1zT9b3Jr+huTFICBmdz/01LPiY0CBfD1XcUh
         p2mHF+0DwrN2Nk+q+qPIesSRrKEbIrYVqWd+Iy+8HhBoJsbeoBBJwk2+ptHpOBzBi0tL
         brZQ==
X-Gm-Message-State: AOJu0YymddxRmFRUX9wLOAiUx1oo1wZFwGgm4Y/uzKSAP7WVUG+4HWYk
	M75ruqVtJX3uN+NDWy54a/sgJp4n9bQJOsczhU9S0aMqOadTNrzNJGPRx1wxc7/gZv5m5QdfsGQ
	rZfgKInMn9FI1XDMDrVbPV9eCNvs+mrzXBl++5lDg9fN3cbep3t33YT0oDzCT4dKtQEAuXUegvu
	URylIQIaEpFEh/vAPXQptDdVO5zHwN3scv8Zc5zw==
X-Gm-Gg: ASbGncty5wrSEQGuX6K77wE+RrAibuBpEcDUx8OF1pIq3f5RDGn5+nez5Gy5tdc49Jb
	VcltxICyfeKZhy9McxSFySMHsi3WEaO92h2N2Xt5XHvn6WFGvXpu7EhdRCWFkHtUZdZbn4iiwuh
	xH4RvFw4PaT/NnheBCS8GRxt8NxfgGSrl0HPaBL8PoxmfqVPBYXxmXsZqkfSIYB9IWV+wGVZY6c
	h77mImvOTB4I4x5z8tdDBVjNENooszTRcmKkjpV01m1kc2QOP91nOhU68wPQa1VwhASGPn7EE+2
	HL5NCkAwf635e+Z0ajOoa3uTEmxmAwdFLhwCaGfTMbbtnkEUA1ToOmUoaCmYtvdsslbFh8BFP4B
	J2rrP2EcczoKPkAEvN0cbNcuMLw==
X-Received: by 2002:a05:6000:2386:b0:3ee:15c6:9a55 with SMTP id ffacd0b85a97d-40e4a05bc72mr2223515f8f.34.1758788627370;
        Thu, 25 Sep 2025 01:23:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm90tVZvBju/h6968L7JmuA7sRhW0+B1DnSBTpqFRGnLb0y8Ms9f0kgjcdG7a5Y11nOhUS8w==
X-Received: by 2002:a05:6000:2386:b0:3ee:15c6:9a55 with SMTP id ffacd0b85a97d-40e4a05bc72mr2223482f8f.34.1758788626789;
        Thu, 25 Sep 2025 01:23:46 -0700 (PDT)
Received: from localhost (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fc6cf3835sm1918420f8f.46.2025.09.25.01.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 01:23:46 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH 6.1.y 1/2] mm: migrate_device: use more folio in migrate_device_finalize()
Date: Thu, 25 Sep 2025 10:23:42 +0200
Message-ID: <20250925082343.3771875-2-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925082343.3771875-1-david@redhat.com>
References: <2025022402-footprint-usher-aa6e@gregkh>
 <20250925082343.3771875-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kefeng Wang <wangkefeng.wang@huawei.com>

Saves a couple of calls to compound_head() and remove last two callers of
putback_lru_page().

Link: https://lkml.kernel.org/r/20240826065814.1336616-5-wangkefeng.wang@huawei.com
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 58bf8c2bf47550bc94fea9cafd2bc7304d97102c)
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate_device.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 721b2365dbca9..180dbb99c320b 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -829,42 +829,45 @@ void migrate_device_finalize(unsigned long *src_pfns,
 	unsigned long i;
 
 	for (i = 0; i < npages; i++) {
-		struct folio *dst, *src;
+		struct folio *dst = NULL, *src = NULL;
 		struct page *newpage = migrate_pfn_to_page(dst_pfns[i]);
 		struct page *page = migrate_pfn_to_page(src_pfns[i]);
 
+		if (newpage)
+			dst = page_folio(newpage);
+
 		if (!page) {
-			if (newpage) {
-				unlock_page(newpage);
-				put_page(newpage);
+			if (dst) {
+				folio_unlock(dst);
+				folio_put(dst);
 			}
 			continue;
 		}
 
-		if (!(src_pfns[i] & MIGRATE_PFN_MIGRATE) || !newpage) {
-			if (newpage) {
-				unlock_page(newpage);
-				put_page(newpage);
+		src = page_folio(page);
+
+		if (!(src_pfns[i] & MIGRATE_PFN_MIGRATE) || !dst) {
+			if (dst) {
+				folio_unlock(dst);
+				folio_put(dst);
 			}
-			newpage = page;
+			dst = src;
 		}
 
-		src = page_folio(page);
-		dst = page_folio(newpage);
 		remove_migration_ptes(src, dst, false);
 		folio_unlock(src);
 
-		if (is_zone_device_page(page))
-			put_page(page);
+		if (folio_is_zone_device(src))
+			folio_put(src);
 		else
-			putback_lru_page(page);
+			folio_putback_lru(src);
 
-		if (newpage != page) {
-			unlock_page(newpage);
-			if (is_zone_device_page(newpage))
-				put_page(newpage);
+		if (dst != src) {
+			folio_unlock(dst);
+			if (folio_is_zone_device(dst))
+				folio_put(dst);
 			else
-				putback_lru_page(newpage);
+				folio_putback_lru(dst);
 		}
 	}
 }
-- 
2.51.0


