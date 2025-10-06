Return-Path: <stable+bounces-183491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9BBBBF23C
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 22:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B104189A6F6
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 20:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097502264D6;
	Mon,  6 Oct 2025 20:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izBSrTzq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D272DC764
	for <stable@vger.kernel.org>; Mon,  6 Oct 2025 20:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759780990; cv=none; b=RmvwPg4qAmcnOswePY6NRI0YmgA4VbEcLDnlQ0nP7mCjOrXo6keFCu+s1u3VYpx2Pe7+Ke1gvIpueY1/nArHD22ialldH7QqtJAYK7Icrx99j6R9ZUHc28/TfXbfwLUDSEBbIxjlnyrXOpD04IWs9mPQcYZzKt4S4FIwb+spLcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759780990; c=relaxed/simple;
	bh=Sq9BZkzhI30LkCNbkX6MyuInjbp5KHwDN549JuJlWgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NiZ20zI7DsIr1X5hmaquXReTR+YX6VrcptCzFaEsk5m9r/oF57t5n4XViPnf+C8hQ5uoMkp2moKu8Y39fArfikwGZIBlXays87OXbA5jiFz2YNNUxkqtXi5F8BODtNKzeEQ2I7tJ4aK+y6bmo0kZ+sZb8z4xfDHJXw50z7Ev+8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izBSrTzq; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3369dcfef12so5992462a91.2
        for <stable@vger.kernel.org>; Mon, 06 Oct 2025 13:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759780988; x=1760385788; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/FfTKpzDhNY44hq6VBsPjCO9xlzMvi5CioCxjggBxGo=;
        b=izBSrTzqIrbOb2CvT1BZWhYTSG7nRvyhBYL0g/pNXtOiZmqGbYMYXU4QHXjXbFVfq5
         kanMiwI1tLAbM0XAvST0kmBcVlpAxVvE+gd13ZQwhkzm8tn9GPW7El/GI9grq2+Rcm35
         nIEZoNgALAQ71f2SWfNHqSUw8mIifmmzKcqCrEUIZO8gK5I+UHfenqHzusd+ohNPtOom
         +RdJxth/baoTYapNYGrQkLmUEb/XCzywL06CAc4lwn6R+tnvYpnY7qWd/H6pKDZKF2v5
         gV0430vQD6QCFqYO6ht7eA3qTNOiWTr71fogrrHNsBK0h1B8MYbwrgRQlnGW9hBwlUSz
         F+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759780988; x=1760385788;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FfTKpzDhNY44hq6VBsPjCO9xlzMvi5CioCxjggBxGo=;
        b=CG67l0ZSzJt67ORal85/m12tV5LNtplB45wF0Ozz4j9HG9564RW9F8k3u84zqxFyb6
         u6MqR0Lq3blzJQHFDeJI38ThsXjBToZGz6M8ZWFrh8b2LAjNFG6PAWyRJE46um2srC2I
         N4K4ApOS6AiNat2zwuH4cEz4j2ITyWBn0CTTQhhoZtNaEuagylaXUugUmqrEnheN9lyb
         adtVD90OvI3QuaZE0Q58H4LEZAQft0g+KrqjhAnh1KG3Zg8acl7XtrOh4HHyAgbATbCZ
         8sGOln9PLjWftpUz7JhQH8g1GHB2Cn6rFBwcNOvZ9ZQQd5OLHknT3nElK9BKGiVpjYhf
         ZW+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXULfQp2aHt787ylhZ6bobe2HjVXUA0qG1gw6H0Yn9Glyu2Vzp471HOECcOBVEbyLGugyKPXUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOADQdg+i85Y8Tya6zrVIKkRUl+m4uoChay98a3QqquZfSk3nO
	ACDKP+JfEyZzPazQLQo5MDe1n27LULwkoPjcpMLYBOB1pH31+1hUdSs6
X-Gm-Gg: ASbGncvRAx/0Uy3OX9qm6ru3Q4+CcAxah7LbPdFtOE4/4KEYho7WUl/5SijEVibPed5
	MyJWL4p93fVfGgP/2lKJaE8K97YO+8oUApqVbH76WaRkS8rlprnQlSAeGoIhTyYF1M+Rg9J31rg
	eceFy1q9c2qTJEtEbh0KXFUtVlbIaO12/wXOCVBg/rOX5ml2Z2jYLx6GAwEyHBAeQUkiLsaeqJS
	9FuvAtJekWGHVoik+5DC5ze7YaHxUrJxANbp7sxYE8CdtF5ih5McGzKEZfomO6KjSXwFFqX4sWB
	dpr4DR8ZofRrV69ZpOprBSVuVPs0PwEyiifBldboBKgaUQDKp7tEHnTSyoweDYZSYxV88YzXE1Q
	pQvxtPV9+x8R/MqsIfq8obtEBtP/r/GZb38hRyDJ9dxhs/7dt1r2D+11+DCbI3bI=
X-Google-Smtp-Source: AGHT+IGKgvoWh2AlA1gEXZJS741XwWofagS2eT43KDPpL42IYIXONw/GpTUsn2xjQoYVEGK0eUrkbg==
X-Received: by 2002:a17:90b:5807:b0:339:dcc3:82ca with SMTP id 98e67ed59e1d1-339dcc38971mr8109209a91.6.1759780988397;
        Mon, 06 Oct 2025 13:03:08 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339ee0ba20asm163148a91.4.2025.10.06.13.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 13:03:07 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 07 Oct 2025 04:02:33 +0800
Subject: [PATCH 1/4] mm, swap: do not perform synchronous discard during
 allocation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-swap-clean-after-swap-table-p1-v1-1-74860ef8ba74@tencent.com>
References: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
In-Reply-To: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 David Hildenbrand <david@redhat.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Ying Huang <ying.huang@linux.alibaba.com>, Kairui Song <ryncsn@gmail.com>, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.14.3

From: Kairui Song <kasong@tencent.com>

Since commit 1b7e90020eb77 ("mm, swap: use percpu cluster as allocation
fast path"), swap allocation is protected by a local lock, which means
we can't do any sleeping calls during allocation.

However, the discard routine is not taken well care of. When the swap
allocator failed to find any usable cluster, it would look at the
pending discard cluster and try to issue some blocking discards. It may
not necessarily sleep, but the cond_resched at the bio layer indicates
this is wrong when combined with a local lock. And the bio GFP flag used
for discard bio is also wrong (not atomic).

It's arguable whether this synchronous discard is helpful at all. In
most cases, the async discard is good enough. And the swap allocator is
doing very differently at organizing the clusters since the recent
change, so it is very rare to see discard clusters piling up.

So far, no issues have been observed or reported with typical SSD setups
under months of high pressure. This issue was found during my code
review. But by hacking the kernel a bit: adding a mdelay(100) in the
async discard path, this issue will be observable with WARNING triggered
by the wrong GFP and cond_resched in the bio layer.

So let's fix this issue in a safe way: remove the synchronous discard in
the swap allocation path. And when order 0 is failing with all cluster
list drained on all swap devices, try to do a discard following the swap
device priority list. If any discards released some cluster, try the
allocation again. This way, we can still avoid OOM due to swap failure
if the hardware is very slow and memory pressure is extremely high.

Cc: <stable@vger.kernel.org>
Fixes: 1b7e90020eb77 ("mm, swap: use percpu cluster as allocation fast path")
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index cb2392ed8e0e..0d1924f6f495 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1101,13 +1101,6 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 			goto done;
 	}
 
-	/*
-	 * We don't have free cluster but have some clusters in discarding,
-	 * do discard now and reclaim them.
-	 */
-	if ((si->flags & SWP_PAGE_DISCARD) && swap_do_scheduled_discard(si))
-		goto new_cluster;
-
 	if (order)
 		goto done;
 
@@ -1394,6 +1387,33 @@ static bool swap_alloc_slow(swp_entry_t *entry,
 	return false;
 }
 
+/*
+ * Discard pending clusters in a synchronized way when under high pressure.
+ * Return: true if any cluster is discarded.
+ */
+static bool swap_sync_discard(void)
+{
+	bool ret = false;
+	int nid = numa_node_id();
+	struct swap_info_struct *si, *next;
+
+	spin_lock(&swap_avail_lock);
+	plist_for_each_entry_safe(si, next, &swap_avail_heads[nid], avail_lists[nid]) {
+		spin_unlock(&swap_avail_lock);
+		if (get_swap_device_info(si)) {
+			if (si->flags & SWP_PAGE_DISCARD)
+				ret = swap_do_scheduled_discard(si);
+			put_swap_device(si);
+		}
+		if (ret)
+			break;
+		spin_lock(&swap_avail_lock);
+	}
+	spin_unlock(&swap_avail_lock);
+
+	return ret;
+}
+
 /**
  * folio_alloc_swap - allocate swap space for a folio
  * @folio: folio we want to move to swap
@@ -1432,11 +1452,17 @@ int folio_alloc_swap(struct folio *folio, gfp_t gfp)
 		}
 	}
 
+again:
 	local_lock(&percpu_swap_cluster.lock);
 	if (!swap_alloc_fast(&entry, order))
 		swap_alloc_slow(&entry, order);
 	local_unlock(&percpu_swap_cluster.lock);
 
+	if (unlikely(!order && !entry.val)) {
+		if (swap_sync_discard())
+			goto again;
+	}
+
 	/* Need to call this even if allocation failed, for MEMCG_SWAP_FAIL. */
 	if (mem_cgroup_try_charge_swap(folio, entry))
 		goto out_free;

-- 
2.51.0


