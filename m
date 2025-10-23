Return-Path: <stable+bounces-189162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4C1C03076
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 20:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D74E5463C3
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 18:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4D129BD85;
	Thu, 23 Oct 2025 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbYHX8F6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08150295516
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244482; cv=none; b=pSwVJkm9li8Rxz8PyEr7pbTP9yo6dOhJCJeIeDS9pywZrhv7BUQBAd+uQojy2oJtbClo8eCROOxgIlo41xzj9xoDJvZed4I5hHVsF7WPlU11sxCKOpenPyw2ZDVsazjELL+89Pg1raGlPL4tEhKi98am2yiA/gH+4Lt5ZUUs9eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244482; c=relaxed/simple;
	bh=9pJM7vhFYlQ3z1udIhUA2jWv28p7f4FGl0YTaHcYnaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UU5GBRiei6xrpt9yr9x2ZuVeESsA23ElCH+P1eeYl8J1luZK2O0jBpqRmbfRvMedG2RHJ5z8xeqshlJWkBvICuuRCdpwLvktypCAJ+KoMkVIHNm7ajiuLAQ7bh9gm96v1XppLwJu6H0z7W3PcfMHbykyYlkq5YyRR+ilTiUjwUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbYHX8F6; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-339c9bf3492so1504785a91.2
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 11:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761244480; x=1761849280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7/VA0enLRKccdP14FA/Vaa8mbbHGSiaGqmOz4vjURDc=;
        b=hbYHX8F6K/bjtq7X5IJPENfNSLolVq+ewt7SHqaK3YkumCitDvvrbpOejDw40XFQT8
         QykJCRNc0+t6D5LL9BOqjf/bTIf6OYOAH7u827Fa94kYJo1iybKhy8bSVr5ZS4vj8kox
         DKHx042I7o2QvNk/52282nUAHQEREKe9P+LrZmUotAD0AFVQkVEtdhnPN94DQEbzZPyP
         cVJ9E7wpkGSjSR/STGN4Xtp0gTipHdWHpadDZpj/UpfQbctBv//4+tNpN7s4xeYxLL2A
         sx/tehQ22eYzlJ5FQ1Bl6CtHrgsrTXXefgk7YWv2Z1L7bno3wEkEQYT7dDqfFVcDMs/z
         6uYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244480; x=1761849280;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7/VA0enLRKccdP14FA/Vaa8mbbHGSiaGqmOz4vjURDc=;
        b=d8hycRTjk49IrHyQQxT9p12l+qaV1eIzUpSOSlTf9Klpmg37zWzMnqgxvF7S8YWZHv
         FWdbYcBBUfSBBNLmd4DVzCTdBilmqCp3gCaPPX8ZhivcUJ8Gwp+WfFhX/dKlY6At0NYL
         ZwSjn/B92Y5aajWjGT4++z5FzBNGwh+MHcShUa5rTABxgkCr/MzZccN8a0E19E3IS3aK
         NTBIKoiulHuctM+3Sh7f+BqjjQcEGMU2rF99p5ByZmp/S4VoikN06JNK2N0IWM42b890
         vDLbUjWas6sFk9WWaGJ7POMGhEISyEC4JjfN1MCdjyAAGsBNrQSDTb39welFQ4Sdlil+
         9gRg==
X-Forwarded-Encrypted: i=1; AJvYcCWOOtnbICBbp7l8ED9E658lZ3LAqjHnHVMYCW6d5OsHfb1eY7TbignSoZDAalYY4n/uaAZc7LY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHuJLhywUjY5fq11E+c4qVC3uYHohibJ7TaVlmlKXetkaLIhGg
	v7L/QUgs0gP+xP1ApeTvC9IAkuB7pmlBF7Ed++NeJj+LOAvqAMm4OKVQ
X-Gm-Gg: ASbGnctUPUZjxj0ao5GDehM5qtz4PBhtvnDl6NjAL4AhWpFr1oA2Vvhk11hOf6HqPqh
	dv2t+zwN30itLpuGdB1CSPgK/NVjHi4k7163uFZCfsRngSQ5tnjQ/Y/scloX/HZSzPU2US2x/J9
	5KQYaeT8/rgJjfDkUbveZdjmYAl+4mpu+BhLifuhE/gr3ir5f7GceGF7soVKGLEA7S57t16bICf
	+p3pzFXj8JwY2c2Hr2Po00D92WQHwdsZGNLCf7GUdVKLDSo/gZsNMnu6EJp2cRTLm43aBTDmbO8
	Qu+6j2N/kvlqdCrZA5Gola0Ka170wzyC5jRnb9v4Wd+70oXFlHE4Hqo4bmCRRPlux8Yb30GKbUZ
	SC0oVxp4RfpUTRq1j6MoPYKUi8VZqGpUOf9SxFPRtXpMeDHMeXPNXmz2Y1nmHk9kfJKEFSqwIjy
	xbU7nVnIlbqLQRm0EFMgUG7WinA7fiIBc=
X-Google-Smtp-Source: AGHT+IGiqCrNfq39nDPGx1DT9imwuvzaEJqhlEfe6FGy7mEh7Ihbg5SRkM8lVhCfXKJmF5QOtT3auw==
X-Received: by 2002:a17:90b:3f8d:b0:33b:be31:8193 with SMTP id 98e67ed59e1d1-33bcf85d59dmr35534624a91.6.1761244480179;
        Thu, 23 Oct 2025 11:34:40 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dfb7d6b54sm3876533a91.4.2025.10.23.11.34.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 23 Oct 2025 11:34:39 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Kairui Song <ryncsn@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	YoungJun Park <youngjun.park@lge.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/5] mm, swap: do not perform synchronous discard during allocation
Date: Fri, 24 Oct 2025 02:34:11 +0800
Message-ID: <20251024-swap-clean-after-swap-table-p1-v2-1-c5b0e1092927@tencent.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024-swap-clean-after-swap-table-p1-v2-0-c5b0e1092927@tencent.com>
References: <20251024-swap-clean-after-swap-table-p1-v2-0-c5b0e1092927@tencent.com>
Reply-To: Kairui Song <ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From: Kairui Song <kasong@tencent.com>=0D
=0D
Since commit 1b7e90020eb77 ("mm, swap: use percpu cluster as allocation=0D
fast path"), swap allocation is protected by a local lock, which means=0D
we can't do any sleeping calls during allocation.=0D
=0D
However, the discard routine is not taken well care of. When the swap=0D
allocator failed to find any usable cluster, it would look at the=0D
pending discard cluster and try to issue some blocking discards. It may=0D
not necessarily sleep, but the cond_resched at the bio layer indicates=0D
this is wrong when combined with a local lock. And the bio GFP flag used=0D
for discard bio is also wrong (not atomic).=0D
=0D
It's arguable whether this synchronous discard is helpful at all. In=0D
most cases, the async discard is good enough. And the swap allocator is=0D
doing very differently at organizing the clusters since the recent=0D
change, so it is very rare to see discard clusters piling up.=0D
=0D
So far, no issues have been observed or reported with typical SSD setups=0D
under months of high pressure. This issue was found during my code=0D
review. But by hacking the kernel a bit: adding a mdelay(500) in the=0D
async discard path, this issue will be observable with WARNING triggered=0D
by the wrong GFP and cond_resched in the bio layer for debug builds.=0D
=0D
So now let's apply a hotfix for this issue: remove the synchronous=0D
discard in the swap allocation path. And when order 0 is failing with=0D
all cluster list drained on all swap devices, try to do a discard=0D
following the swap device priority list. If any discards released some=0D
cluster, try the allocation again. This way, we can still avoid OOM due=0D
to swap failure if the hardware is very slow and memory pressure is=0D
extremely high.=0D
=0D
This may cause more fragmentation issues if the discarding hardware is=0D
really slow. Ideally, we want to discard pending clusters before=0D
continuing to iterate the fragment cluster lists. This can be=0D
implemented in a cleaner way if we clean up the device list iteration=0D
part first.=0D
=0D
Cc: stable@vger.kernel.org=0D
Fixes: 1b7e90020eb77 ("mm, swap: use percpu cluster as allocation fast path=
")=0D
Acked-by: Nhat Pham <nphamcs@gmail.com>=0D
Signed-off-by: Kairui Song <kasong@tencent.com>=0D
---=0D
 mm/swapfile.c | 40 +++++++++++++++++++++++++++++++++-------=0D
 1 file changed, 33 insertions(+), 7 deletions(-)=0D
=0D
diff --git a/mm/swapfile.c b/mm/swapfile.c=0D
index cb2392ed8e0e..33e0bd905c55 100644=0D
--- a/mm/swapfile.c=0D
+++ b/mm/swapfile.c=0D
@@ -1101,13 +1101,6 @@ static unsigned long cluster_alloc_swap_entry(struct=
 swap_info_struct *si, int o=0D
 			goto done;=0D
 	}=0D
 =0D
-	/*=0D
-	 * We don't have free cluster but have some clusters in discarding,=0D
-	 * do discard now and reclaim them.=0D
-	 */=0D
-	if ((si->flags & SWP_PAGE_DISCARD) && swap_do_scheduled_discard(si))=0D
-		goto new_cluster;=0D
-=0D
 	if (order)=0D
 		goto done;=0D
 =0D
@@ -1394,6 +1387,33 @@ static bool swap_alloc_slow(swp_entry_t *entry,=0D
 	return false;=0D
 }=0D
 =0D
+/*=0D
+ * Discard pending clusters in a synchronized way when under high pressure=
.=0D
+ * Return: true if any cluster is discarded.=0D
+ */=0D
+static bool swap_sync_discard(void)=0D
+{=0D
+	bool ret =3D false;=0D
+	int nid =3D numa_node_id();=0D
+	struct swap_info_struct *si, *next;=0D
+=0D
+	spin_lock(&swap_avail_lock);=0D
+	plist_for_each_entry_safe(si, next, &swap_avail_heads[nid], avail_lists[n=
id]) {=0D
+		spin_unlock(&swap_avail_lock);=0D
+		if (get_swap_device_info(si)) {=0D
+			if (si->flags & SWP_PAGE_DISCARD)=0D
+				ret =3D swap_do_scheduled_discard(si);=0D
+			put_swap_device(si);=0D
+		}=0D
+		if (ret)=0D
+			return true;=0D
+		spin_lock(&swap_avail_lock);=0D
+	}=0D
+	spin_unlock(&swap_avail_lock);=0D
+=0D
+	return false;=0D
+}=0D
+=0D
 /**=0D
  * folio_alloc_swap - allocate swap space for a folio=0D
  * @folio: folio we want to move to swap=0D
@@ -1432,11 +1452,17 @@ int folio_alloc_swap(struct folio *folio, gfp_t gfp=
)=0D
 		}=0D
 	}=0D
 =0D
+again:=0D
 	local_lock(&percpu_swap_cluster.lock);=0D
 	if (!swap_alloc_fast(&entry, order))=0D
 		swap_alloc_slow(&entry, order);=0D
 	local_unlock(&percpu_swap_cluster.lock);=0D
 =0D
+	if (unlikely(!order && !entry.val)) {=0D
+		if (swap_sync_discard())=0D
+			goto again;=0D
+	}=0D
+=0D
 	/* Need to call this even if allocation failed, for MEMCG_SWAP_FAIL. */=0D
 	if (mem_cgroup_try_charge_swap(folio, entry))=0D
 		goto out_free;=0D
=0D
-- =0D
2.51.0=0D
=0D

