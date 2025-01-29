Return-Path: <stable+bounces-111118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD223A21CA1
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 12:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E911884103
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 11:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016381D63CE;
	Wed, 29 Jan 2025 11:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgtXkhMd"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFD51DB14C
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 11:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738151665; cv=none; b=rD+tmPdrzk0O1BD4Ydoi7K01kNdSdIs8f6fd921umHBGDnnmt5FDraAFu2sTeF9GondpOUkn9A8Z6j7AdQOxQh6fM8AgnakbneNF1hKzEuMSKkN2E3ohiTth0U66ul87Va7bDCY/jjHKoOevs7To3x+GrwJmgksYPP2fQVSwBVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738151665; c=relaxed/simple;
	bh=dVjhgUnbY5S2QZp19159xKSfA9DylzeqzqhG6tjWiv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6BcUrkB9WMvfEsSSwuVQRlpxFcaGmpZvL5mw0ZAXMWHa/jS69Tveb/itne+4rDbLgCPQkVIkvqiN0WLo7By1TnWK9UghAsu0OqVfbJTdriJ73u4UwHnsDL7UkGFEhDD+Vb3bTQqwUyyH07YhKC5ZMCoKzwgJLKININcIrfRyRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dgtXkhMd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738151663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=herznK9N3+37fO8/yUnjjPI+kU1qrhYMSQrHDNQrbI8=;
	b=dgtXkhMd1JRBkDaU3GOlEzqu8vKYgBC3QQsXctI799RtnlDx5F3TU4BZPf8kEsXkbDFHfT
	Ib76mgNaq00yAHpMDEnmkVmfhOUncop4HzmAJrYMhfgGcnaceBpbn33G1B1LYMclSdpPWs
	2oLzEgH/aa7zbLYfjyCLVMlsNKw+pNk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-6OQxgePaPk2pzLyJf-9L0Q-1; Wed, 29 Jan 2025 06:54:21 -0500
X-MC-Unique: 6OQxgePaPk2pzLyJf-9L0Q-1
X-Mimecast-MFC-AGG-ID: 6OQxgePaPk2pzLyJf-9L0Q
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4362f893bfaso36483485e9.1
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 03:54:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738151661; x=1738756461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=herznK9N3+37fO8/yUnjjPI+kU1qrhYMSQrHDNQrbI8=;
        b=EUvdtYWYbGilqahxIq+Gt7kyezRmSMDbOiFkiTnJR9vZS7vFfyUjSOw5Y5Mu50tNlt
         LF1NoxE8AOkzjA1Lc7BukWMhhKHlKI8mRJhHbC6YNJo+EwBQ5u5g/IkkjynY1coMk6Q6
         UGzy9NdB5NT+vktVywOOfhnDRIcSATvVCFWwZLq0K89VLsF3w7+K4rZGheN7Qt8Z8ZQo
         QnsJleRcaJW8VztU7//657QUiMDFWQntgrJMW9CN3qUBPswoK+hI/C7JQvXNoVBXmCp2
         adVatlVIrKgTNwuK1409ckqITZAHT7oM1urjd0Cb7c6jLwz6jCSZkexzd9iNfnnfMqMZ
         UMbA==
X-Forwarded-Encrypted: i=1; AJvYcCXERhdINmfxLmoaZhSpkA+gHocO80aCQ1jJ+uridvH2PXRJzQUlo3EFmnCzEchM8CRBABW22+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YztBzCfCHCYLYgXtqxisCCN1xUcLQ5y4wp038uc5Jo1Sv5/f4ie
	u27g5lb2yMKoQw40QYMMSTsEF3V65iwfyiWWUr928Y/LVWsXbe/UsiLne5Awg/+NnPObeFvSqKR
	AGXKdl5x0KMPA4U1/4B3FoywpO48A/a0H+oCgkqE4a6KBYRj1b3SooA==
X-Gm-Gg: ASbGncs2Jx6UrjPbIxm5IjjTmLD1Qo5UR7BsU0zXRuJSqB8s2PEaohkMNHnfz18HTxO
	0XfgjLSD/mnO19C2Kik0DN5lx4kWN/6aau+YOZpwhKPD1TNONfivnuN81/wBaE5sBjm/947DKiv
	DaajxyVYPWJkV1QtUHakE5neOfaTum/HkXmjOoMEfdNDqA5hb9HK/v3RprMXPFk3/W+knvwMDHT
	nsapU55CcMZBU4kRQrQkDrZOTH33lujwXgVvyysJnjaTbjcM+Q1XWkxyqsvflXHNv1+czmT2SAm
	7baxI9tQpLwrzBOSFAWmFqGpeEnb1PkHsxhoNCfFrxT7WChi+g49ZlWnP58Bp50JOg==
X-Received: by 2002:a05:600c:5486:b0:433:c76d:d57e with SMTP id 5b1f17b1804b1-438dc3a40d3mr26190495e9.5.1738151660687;
        Wed, 29 Jan 2025 03:54:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEopxoArzHie066mjWjUvNKTSc/02V79PTjUrPj2QcjbwdMpR1m12X2+qvEI4pAjYXanIEeWA==
X-Received: by 2002:a05:600c:5486:b0:433:c76d:d57e with SMTP id 5b1f17b1804b1-438dc3a40d3mr26190115e9.5.1738151660040;
        Wed, 29 Jan 2025 03:54:20 -0800 (PST)
Received: from localhost (p200300cbc7053b0064b867195794bf13.dip0.t-ipconnect.de. [2003:cb:c705:3b00:64b8:6719:5794:bf13])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-438dcbbc52dsm21427725e9.0.2025.01.29.03.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 03:54:18 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org,
	nouveau@lists.freedesktop.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Peter Xu <peterx@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH v1 02/12] mm/rmap: reject hugetlb folios in folio_make_device_exclusive()
Date: Wed, 29 Jan 2025 12:54:00 +0100
Message-ID: <20250129115411.2077152-3-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250129115411.2077152-1-david@redhat.com>
References: <20250129115411.2077152-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even though FOLL_SPLIT_PMD on hugetlb now always fails with -EOPNOTSUPP,
let's add a safety net in case FOLL_SPLIT_PMD usage would ever be reworked.

In particular, before commit 9cb28da54643 ("mm/gup: handle hugetlb in the
generic follow_page_mask code"), GUP(FOLL_SPLIT_PMD) would just have
returned a page. In particular, hugetlb folios that are not PMD-sized
would never have been prone to FOLL_SPLIT_PMD.

hugetlb folios can be anonymous, and page_make_device_exclusive_one() is
not really prepared for handling them at all. So let's spell that out.

Fixes: b756a3b5e7ea ("mm: device exclusive memory access")
Cc: <stable@vger.kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index c6c4d4ea29a7..17fbfa61f7ef 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2499,7 +2499,7 @@ static bool folio_make_device_exclusive(struct folio *folio,
 	 * Restrict to anonymous folios for now to avoid potential writeback
 	 * issues.
 	 */
-	if (!folio_test_anon(folio))
+	if (!folio_test_anon(folio) || folio_test_hugetlb(folio))
 		return false;
 
 	rmap_walk(folio, &rwc);
-- 
2.48.1


