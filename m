Return-Path: <stable+bounces-192151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B880EC2A6E9
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 08:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3F73B546C
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 07:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33C32C11D9;
	Mon,  3 Nov 2025 07:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="elQMCGSg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07AF2C0F66
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 07:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762156383; cv=none; b=O8nN7okEbgV08U4azP5aEFuR4hetSBLA73XAx5nxh1DF6/qNC1KQRP9hxURt0fyaVyoVOTFSDyQC7NN4gwrjxZs+hyilnB+642OuuAsikhT6G+YjhXqu/6abSuoXq4Ysfb4yGIEgjd64lS72+vzqvHhR6X+0y50e+DpgAoibAfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762156383; c=relaxed/simple;
	bh=e7ed8ZmJa/kqjlXsP+aE5zpUgSJSjGTZ/K4MPhvN53A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kp94n3kjed8DW0u093rGUEf/dTq6T6TEjv/7utezHa2tVcVjGRTustEbnpu2/jA4ZBZMzh6lEIA6+G/2gtIE5vsbiwRbiyMoAjm0igdnk8kbdGzZgWUgxWPjln0TTo7O89ZTG8AnZhjPTXYSauUCZL4wNqDz3x4gJ1KPTMvP838=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=elQMCGSg; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34029c5beabso3707308a91.1
        for <stable@vger.kernel.org>; Sun, 02 Nov 2025 23:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1762156381; x=1762761181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBJR74pL2UFLaHc8oAOxpJBTbxd/tOOTfgjPB+YfL2o=;
        b=elQMCGSgDjLZYuBNpMN++BW0E+0dYaUNLExx7J7TdImQvG/x/W8zGlN2z6oiPCzhPR
         4lHulixrhuwgKCjJCP8QTiKiGqVRRkW7NOTpPR1n1L9m0TltSpBoctakbcoiEjM4EeTc
         xGfHt561B89+epvi5lh/BaxTocK1dJRJO1KQVHv7DvS+3+stZEEvYJPdLjGzm/rkALVs
         1A6Xk+WDCqCA6LEQdOZ5OXUXo3oDTCmsKMDKA5yJ9Wo90/8D6FyzcSWkV6hhFMze3UmH
         JBX1A/VE3usBaVA26UW+yAligTGPdlnFMKtNeSdLckhrtrh9fLtFHx+4jmke8wh9P9mF
         9eCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762156381; x=1762761181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBJR74pL2UFLaHc8oAOxpJBTbxd/tOOTfgjPB+YfL2o=;
        b=Gigaa3ouZHOWo88NA0WcX1LS3u4Zr2Yg9AZb9P+jHAi/Mg2GlMj8l271yn9t74WVYx
         N7QUltvkGX+C6GfBnjCHq0gOeknqDb/u+qo9ayEoulNhbZWXscYbZKJllnvu+z78SA9Z
         G0xcoQ53YA1YepnyCqzL9Wdoa2XzrFx4WCKVy5tpfZNFodHVBBwcjPLcQLx9EsZkwvP+
         poglCGeF+TbNvslkjxDfz7ZByhw1Hwz35tXBP5ShDE2u/Wtn6U6Y3Yb3BNBoyZ8uUqfY
         7fht0s8qswvN9MHCBOXjQTX2u/K+fzAqmc+NZDNwEMVNjnp16wfr1oS7pwisqjpbz1dZ
         jJ0Q==
X-Gm-Message-State: AOJu0YxNlcdxSSgI5eAXZy6BnntaciYcJTwQopvrls2zVFT9v/F1sG82
	4n8MdL7Ey9kmRyi3HzFvP0WMLs776v+weNBxRxg+TKhB15ITCqbXLAEaP98NY0X5CACy/wwhDFb
	V3v3/ZaKHTDIvb5XJLZcbwQnUuMkzQHNX/g8OfGmY4BJyJ8njTntLlOij9+mCDTcIiN1+528CIp
	WKbfCa3FenH1mwW7XHallNKf0zFfA0vO/8IHS219urT2I7X1sz5zU=
X-Gm-Gg: ASbGncv99tiXVT9Y3GSqC6btoy1hnKY2J388WcyREAjyqWj7eiRe4ZVrJ8si+YVoduq
	Zrzx8GKHvbhMlALKeW24+4hZAmzUWJa5e1uvAlZlcLDRuKtwow4YdVBs7k0HePPzKV62jq+p0mP
	rtt4dU34Qb3C996GWPBCFIbmt/OpfTZ/JCwpIvK9MnSjsjWS22vgi/0Tfd3w9VPrrx/gQSrajoA
	aLng6NuL6qFG1w3i6GqTKa4Ei4DuN2zt1pEfqe8NCLb8myJS4dme3rePtZrDYkUunyv/8YZLg1r
	4aPO2c/GVtsUXyMH1kVi9+GnygZteHJxN8QYYoj8xcGVwy9m0wtujx5T3yFPSpVXzog17Z1wTtl
	QCLFAuvsItWB3m0p8P237DUZd8LcjQJ80P+HRmVoXgS2PyoM9CXRFSv62JLc4VBeFsOn5IHID7K
	GjjkXtJdS3Iwa4Pp5eN0KVmsUY
X-Google-Smtp-Source: AGHT+IHCeuWblU4UX1TsHgam4EVLA+G+yYi1frynG5wZVaDx/qokn9yyEJcHgqKW4FWQHlMPmkrGgA==
X-Received: by 2002:a17:90a:d450:b0:340:a961:80c5 with SMTP id 98e67ed59e1d1-340a961873emr10029797a91.32.1762156380212;
        Sun, 02 Nov 2025 23:53:00 -0800 (PST)
Received: from .shopee.com ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159a16652sm34552a91.20.2025.11.02.23.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 23:52:59 -0800 (PST)
From: Leon Huang Fu <leon.huangfu@shopee.com>
To: stable@vger.kernel.org,
	greg@kroah.com
Cc: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	corbet@lwn.net,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeelb@google.com,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	sjenning@redhat.com,
	ddstreet@ieee.org,
	vitaly.wool@konsulko.com,
	lance.yang@linux.dev,
	leon.huangfu@shopee.com,
	shy828301@gmail.com,
	yosryahmed@google.com,
	sashal@kernel.org,
	vishal.moola@gmail.com,
	cerasuolodomenico@gmail.com,
	nphamcs@gmail.com,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Xin Hao <vernhao@tencent.com>,
	Michal Hocko <mhocko@suse.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 6.6.y 1/7] mm: memcg: add THP swap out info for anonymous reclaim
Date: Mon,  3 Nov 2025 15:51:29 +0800
Message-ID: <20251103075135.20254-2-leon.huangfu@shopee.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103075135.20254-1-leon.huangfu@shopee.com>
References: <20251103075135.20254-1-leon.huangfu@shopee.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xin Hao <vernhao@tencent.com>

[ Upstream commit 811244a501b967b00fecb1ae906d5dc6329c91e0 ]

At present, we support per-memcg reclaim strategy, however we do not know
the number of transparent huge pages being reclaimed, as we know the
transparent huge pages need to be splited before reclaim them, and they
will bring some performance bottleneck effect.  for example, when two
memcg (A & B) are doing reclaim for anonymous pages at same time, and 'A'
memcg is reclaiming a large number of transparent huge pages, we can
better analyze that the performance bottleneck will be caused by 'A'
memcg.  therefore, in order to better analyze such problems, there add THP
swap out info for per-memcg.

[akpm@linux-foundation.orgL fix swap_writepage_fs(), per Johannes]
  Link: https://lkml.kernel.org/r/20230913213343.GB48476@cmpxchg.org
Link: https://lkml.kernel.org/r/20230913164938.16918-1-vernhao@tencent.com
Signed-off-by: Xin Hao <vernhao@tencent.com>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Leon Huang Fu <leon.huangfu@shopee.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 9 +++++++++
 mm/memcontrol.c                         | 2 ++
 mm/page_io.c                            | 8 ++++----
 mm/vmscan.c                             | 1 +
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index b26b5274eaaf..622a7f28db1f 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1532,6 +1532,15 @@ PAGE_SIZE multiple when read back.
 		collapsing an existing range of pages. This counter is not
 		present when CONFIG_TRANSPARENT_HUGEPAGE is not set.

+	  thp_swpout (npn)
+		Number of transparent hugepages which are swapout in one piece
+		without splitting.
+
+	  thp_swpout_fallback (npn)
+		Number of transparent hugepages which were split before swapout.
+		Usually because failed to allocate some continuous swap space
+		for the huge page.
+
   memory.numa_stat
 	A read-only nested-keyed file which exists on non-root cgroups.

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2d2cada8a8a4..c61c90ea72a4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -704,6 +704,8 @@ static const unsigned int memcg_vm_event_stat[] = {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	THP_FAULT_ALLOC,
 	THP_COLLAPSE_ALLOC,
+	THP_SWPOUT,
+	THP_SWPOUT_FALLBACK,
 #endif
 };

diff --git a/mm/page_io.c b/mm/page_io.c
index fe4c21af23f2..cb559ae324c6 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -208,8 +208,10 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 static inline void count_swpout_vm_event(struct folio *folio)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (unlikely(folio_test_pmd_mappable(folio)))
+	if (unlikely(folio_test_pmd_mappable(folio))) {
+		count_memcg_folio_events(folio, THP_SWPOUT, 1);
 		count_vm_event(THP_SWPOUT);
+	}
 #endif
 	count_vm_events(PSWPOUT, folio_nr_pages(folio));
 }
@@ -278,9 +280,6 @@ static void sio_write_complete(struct kiocb *iocb, long ret)
 			set_page_dirty(page);
 			ClearPageReclaim(page);
 		}
-	} else {
-		for (p = 0; p < sio->pages; p++)
-			count_swpout_vm_event(page_folio(sio->bvec[p].bv_page));
 	}

 	for (p = 0; p < sio->pages; p++)
@@ -296,6 +295,7 @@ static void swap_writepage_fs(struct page *page, struct writeback_control *wbc)
 	struct file *swap_file = sis->swap_file;
 	loff_t pos = page_file_offset(page);

+	count_swpout_vm_event(page_folio(page));
 	set_page_writeback(page);
 	unlock_page(page);
 	if (wbc->swap_plug)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 258f5472f1e9..774bae2f54d7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1922,6 +1922,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 								folio_list))
 						goto activate_locked;
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+					count_memcg_folio_events(folio, THP_SWPOUT_FALLBACK, 1);
 					count_vm_event(THP_SWPOUT_FALLBACK);
 #endif
 					if (!add_to_swap(folio))
--
2.50.1

