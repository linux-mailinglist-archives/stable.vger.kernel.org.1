Return-Path: <stable+bounces-209933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4784BD27F24
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 20:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECC6B30D0CD4
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 18:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B222F3D1CBC;
	Thu, 15 Jan 2026 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8vmqupj"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1942857CD
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 18:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768500884; cv=none; b=aS0hLw39a7sQcvrqerQzgcavvvlfYkkQ/vvfZuZc+VkiWprB79zbQzR+HQCEiOg4FdKi3h0B6Fof+FzthQdzQALQ0KZQwvYfGzFnLX9xbVbLvn58iMLNM5j7fjV0j86zCSwlksbsDQeo3FMsaQmigafKGrscnD/ee29nvoelsbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768500884; c=relaxed/simple;
	bh=PREq6X5dQOSijb3j/ArhlfPtqTgBVODvVTzNWDj0g6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIEkJJRQkWfjoSzjsnK6Ph8pJGzVNCQXKw0hXBzJWdj5gI/15RoAkqDfwU/M3ABoODjSPHd5ZcT6T23yuM/pwMqI3NgSMCQIuUvCNm+VROsIclkSl6d1wiiijyqc8Cm3+HAupDd4BluWZlK+6XK3O3/Ar/yqXXQ8aB99xSyEjMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8vmqupj; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-649166a96a9so228462d50.3
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 10:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768500882; x=1769105682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O45eLppLOCW6F7IMGZ1ULnrc2pXJxucNBG4tS3sUSSc=;
        b=a8vmqupjyGIDJlTY507dJkMjzIUVbErDhw3jbY26KNZAheovldgoxv3L+KdZOsVReo
         K1rlcFtOlI43v88vXKgpNfQPoTEizva0+EDP9Eej5WqVjVMn8aIa1NPL4Y3J3jGx1tzp
         BlBXNnuk9Hl4/1ig+yuXnxpST7JiM+37MluLX/0rZfslqIt1+lAu39AgseOSAriwAw6B
         pe5ji1DBhWW23VwbO+YeMnyilevkdk1mBdqnnXsVV3skZpsghpzfIqZS6FNR0q5Kdm8h
         dPK0Xy5E7PhdmDDm8144GB12TxppcESy69YjlD1x2c81sobru2Vi3hx/LNr+cSqvVKik
         JDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768500882; x=1769105682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O45eLppLOCW6F7IMGZ1ULnrc2pXJxucNBG4tS3sUSSc=;
        b=mar7cR7lGBPY8jnV0i7aKNnjwduZIohwJG54GGt1qZWSWvMDkmc96wIfRZAo3W7Ebm
         HImHXBnkgUlttZUHtBvk1lvU7+CJGZt4STFn1lEKFeOOJe183vKwjpo6pTlIrcGtHbGf
         VXTRnEynAfweHX5s7P9kBDG6D34F7Lnwq93SDDfoS45vQbsFR7U8kobdw/iqK01T5Qey
         aUn+3sNQs0WU8ElbEriFUg43u7vpvMpUAwdNFAoCh7cI20+CfrSIhibZKm82n9xdCkd1
         GXf6PBiJdIjhvr1wsMenOsoRPLGz//1mphAzgjam/55pPL/9kocHCLE2TuMl38af+Bqo
         jXFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgDC8xIaqz9jBnusvOLKGb2+yQFEdhvnJDA73DJIo08FDbgZBLZBqwPtcDc1/TYPkvcJrm1Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLharxaWI6YlRyr/koqc/lwQWL7na69wfQxNf/etMft/eaNcaK
	RI/iTv/6irNvRbPHhdOYXXWMTzT3TJqmGT0jxhCjGc94gsvxaBpR2fgL
X-Gm-Gg: AY/fxX6EVuHHgZVzse/TzodFR5GBCMIB1P6rTHQuCrOJ78WTGMeAkSDRTPgRZFc/Uap
	h8s2Mz7ALRpzeEEFldaQ+O5yHcSQn/arBdOGLIDbss6GCIUzHkgI1lumZl0WVzCaJ+ti6Ib+/46
	8wZnT2LMYvxuY85W7o430AJb+N6PjJKlY3803XfL6yZoGoCtbWLx7h27vCpkof/K13iVuJD5Agv
	KpeRZJsyFkV7T10XXoFnlFUUF7oAb9cGPRyQbEojCU+knxVagX2usH2DCVvcl4BCdrMVLV9u5RI
	HeeN3RdN/KeQKd08EvSbRq71IWsMSZsbUETlGwvTkjL+rjl+fgzhBPUWNR5Y7p2SR8ZmQ9dTrNn
	9hmfsaz0Gmsvc2OBRn8an3TfRkSAfHKWf8Nu8EyxHioD+ktQzKxJAhZPbC4XYh//gxESHgNG6dp
	GWvq3QWZqzajVBRiM8wukx
X-Received: by 2002:a05:690e:b46:b0:63f:b634:4224 with SMTP id 956f58d0204a3-64916484f7bmr462440d50.21.1768500881797;
        Thu, 15 Jan 2026 10:14:41 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:44::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c68307b5sm98567b3.32.2026.01.15.10.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 10:14:41 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Wupeng Ma <mawupeng1@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	stable@vger.kernel.org
Subject: [PATCH 1/3] mm/hugetlb: Restore failed global reservations to subpool
Date: Thu, 15 Jan 2026 13:14:35 -0500
Message-ID: <20260115181438.223620-2-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115181438.223620-1-joshua.hahnjy@gmail.com>
References: <20260115181438.223620-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
fixed an underflow error for hstate->resv_huge_pages caused by
incorrectly attributing globally requested pages to the subpool's
reservation.

Unfortunately, this fix also introduced the opposite problem, which would
leave spool->used_hpages elevated if the globally requested pages could
not be acquired. This is because while a subpool's reserve pages only
accounts for what is requested and allocated from the subpool, its
"used" counter keeps track of what is consumed in total, both from the
subpool and globally. Thus, we need to adjust spool->used_hpages in the
other direction, and make sure that globally requested pages are
uncharged from the subpool's used counter.

Each failed allocation attempt increments the used_hpages counter by
how many pages were requested from the global pool. Ultimately, this
renders the subpool unusable, as used_hpages approaches the max limit.

The issue can be reproduced as follows:
1. Allocate 4 hugetlb pages
2. Create a hugetlb mount with max=4, min=2
3. Consume 2 pages globally
4. Request 3 pages from the subpool (2 from subpool + 1 from global)
	4.1 hugepage_subpool_get_pages(spool, 3) succeeds.
		used_hpages += 3
	4.2 hugetlb_acct_memory(h, 1) fails: no global pages left
		used_hpages -= 2
5. Subpool now has used_hpages = 1, despite not being able to
   successfully allocate any hugepages. It believes it can now only
   allocate 3 more hugepages, not 4.

Repeating this process will ultimately render the subpool unable to
allocate any hugepages, since it believes that it is using the maximum
number of hugepages that the subpool has been allotted.

The underflow issue that commit a833a693a490 fixes still remains fixed
as well.

Fixes: a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: stable@vger.kernel.org
---
 mm/hugetlb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2e296d30a8d7..88b9e997c9da 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6560,6 +6560,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	struct resv_map *resv_map;
 	struct hugetlb_cgroup *h_cg = NULL;
 	long gbl_reserve, regions_needed = 0;
+	unsigned long flags;
 	int err;
 
 	/* This should never happen */
@@ -6704,6 +6705,13 @@ long hugetlb_reserve_pages(struct inode *inode,
 		 */
 		hugetlb_acct_memory(h, -gbl_resv);
 	}
+	/* Restore used_hpages for pages that failed global reservation */
+	if (gbl_reserve && spool) {
+		spin_lock_irqsave(&spool->lock, flags);
+		if (spool->max_hpages != -1)
+			spool->used_hpages -= gbl_reserve;
+		unlock_or_release_subpool(spool, flags);
+	}
 out_uncharge_cgroup:
 	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
 					    chg * pages_per_huge_page(h), h_cg);
-- 
2.47.3

