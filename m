Return-Path: <stable+bounces-181676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89280B9E057
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 10:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9954119C1211
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 08:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AA6270545;
	Thu, 25 Sep 2025 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dc9lC4jn"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD27419CCF5
	for <stable@vger.kernel.org>; Thu, 25 Sep 2025 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758788405; cv=none; b=skvZ87wP3hra0U9lA0VBYhwRhqoVXjzzk3eOIse08ZbXpweMGv6phQE/LMZTSGrsYP/hAMcqh4sXj0Y40btM2MpC7+N/DF2Kz7fdyGsg8vyP4WJjDVbIujQTM5Tcy5KKMjhDTrD81WI2qDPBVTRySGjoL/2w1ao1biiSqVwAUjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758788405; c=relaxed/simple;
	bh=dkgLMYye0SYLLb+A/lIxXrRrw0TYoTaQ/2n4/sHy1gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=di6DjY3auGmuxCUy4KkemnockhH2bdOUlYsfrVB985yYr/ojF6/mfnLkXjp7VkuMNUXevSUI+pH9ITTH3C8da3gXgAjEWl1TEk8rz4N863Lc2Ib0WMcR3hfXLDhOtZA+8cBZWqUENg6KT3YQphp0dOqZz7q1M8yKZ2h3AtqBZd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dc9lC4jn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758788402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dt/4W+oqi8hOmboeA6NMHOzDnnOSX/FWFcKdqFw6DIA=;
	b=Dc9lC4jnY+AbxEodyihKQeL/WDgYylLCIHWG5hJypdfz/q7LHBeibEFamr3WwNjiH8Ag8d
	Rq3Hg8eXUaGmMM1gQhHsLnPb9k3+aPDzvshJAFsfaPDBxSxka6JMSnBZZ9FFJDPwkEZ17G
	NmDQSA9xBJnLlMjaf7MdP0uBvRiIFvU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-HT_ulA5VPV-sfN9EiFRIqA-1; Thu, 25 Sep 2025 04:20:00 -0400
X-MC-Unique: HT_ulA5VPV-sfN9EiFRIqA-1
X-Mimecast-MFC-AGG-ID: HT_ulA5VPV-sfN9EiFRIqA_1758788399
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3eb8e43d556so755715f8f.1
        for <stable@vger.kernel.org>; Thu, 25 Sep 2025 01:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758788399; x=1759393199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dt/4W+oqi8hOmboeA6NMHOzDnnOSX/FWFcKdqFw6DIA=;
        b=Iih+/4uyKINHm4C05DIzOS7j57nnViCIJDNr1sxWWIxCiQUio++9Muq5vpqsE8GkGo
         aJZTJRFJL6gwab2oZrp6cGvpPjy/uONI98N007ASzi9m4Xf0lzNXm9VcCjfr3WnZkdkt
         Ark1yH2H3jUSVHr/fM3JxfG+PQPARRfVBpQ0e/P0DgGRi0B0D6SnH2ZWS8C50+8El57K
         6TEHQndQfUbXbdnQUmd2fNm/XjrATe5TfAOg9rZjSx4kRq9S9gN/9lW1Zk/fvcdRCDVq
         k90GEDMcCHsveIIzMLC+27HjlvRfl2U95LdK1fFgcRTIbXYyV347QA6ASZYq+bsACQxo
         MbuA==
X-Gm-Message-State: AOJu0YzirZdj79hBzjpdfs54MkR0YFlgE0DfL8uJYcVMfbC9aGontNCA
	PU6bvjwVviEnU34/wEJSBQcoWMgK5+sxDTgYmTosZXClyWldzCvptkaZ3Bbv4cXasRgUM+5NGKs
	doAOplZ3y+s+WFml57HwbX8yfd85qz8VbM9MiCIsrEJTVyeBKwqn8BmqhX3XsB1B59K2ldGEJaD
	5xac3f08d//Y17hHlgbCVUPkCbN5B2UxuVR2xoHw==
X-Gm-Gg: ASbGncuEe+RNYtcBnXHh4HFyvuFfioUSnBIhUAgCzFghBEsqoe4m4JZ6/Va/UyaISD6
	vkh9fWDBe3Qt90/rqSh2m5GrX7ksUUjQOSWxvlrKzGjhAnYu4G1R3KHOcn8LBj6cP9sx4yLt8Wv
	JXQXjVJVIlyfA+hCk1W2B6msqFQY+23gxcAyeIU0JT4YoUOG+GX3e94xu2F/Oods13a3LyjAuXk
	KTDEszAyrlaXMZXbMIEA5U6dA0Api/8Q1KlFygsXNJhrDKb+I6Grj7x+7V9zNJ3SSeGGXbwTIbY
	mxTr2th6LQF3QNElZclV1k6cdmwc84EYvIK8pzVHk3P4BwtArf2UugiOrWLMdEmvivsaKyBniUy
	FVJYqp0jh90jUuJUSh0duQzQyYQ==
X-Received: by 2002:a05:6000:610:b0:3ee:11d1:2a1e with SMTP id ffacd0b85a97d-40f5fea54d4mr1470384f8f.10.1758788399298;
        Thu, 25 Sep 2025 01:19:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCmL6IcJzR81nn1zjBi3mVjL9imP2afVOUxLsTA1aITrClZ80cCqOsn6rBksXQQny10pYe9A==
X-Received: by 2002:a05:6000:610:b0:3ee:11d1:2a1e with SMTP id ffacd0b85a97d-40f5fea54d4mr1470343f8f.10.1758788398782;
        Thu, 25 Sep 2025 01:19:58 -0700 (PDT)
Received: from localhost (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fb72fb6b7sm2038140f8f.2.2025.09.25.01.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 01:19:58 -0700 (PDT)
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
Subject: [PATCH 6.6.y 1/2] mm: migrate_device: use more folio in migrate_device_finalize()
Date: Thu, 25 Sep 2025 10:19:52 +0200
Message-ID: <20250925081953.3752830-2-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925081953.3752830-1-david@redhat.com>
References: <2025022401-batting-december-cf51@gregkh>
 <20250925081953.3752830-1-david@redhat.com>
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
index 8ac1f79f754a2..06a52612b2c45 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -814,42 +814,45 @@ void migrate_device_finalize(unsigned long *src_pfns,
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


