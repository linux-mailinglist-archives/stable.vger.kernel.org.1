Return-Path: <stable+bounces-210115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B59F2D387B4
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 21:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A3EB30024E0
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 20:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24742EACF2;
	Fri, 16 Jan 2026 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0FA/kil"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD042EB860
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768596040; cv=none; b=EhEiLjHUn82vfpDirBZKxr3hbtcCql94H/Fn/WVUlsIneJS2hBpfJyoYOfwLR1Qeval+SfYSyio96fIvBDnxBTNSmQw4WcWwg8wywbk0GrqSWfAISntM9sxCbaVe46qv7KtHwQa61DvuGrH/z1xdvze7CivMUUvH7wy2uSgSXTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768596040; c=relaxed/simple;
	bh=F9y/hUlElgS4/q5TL+nwejP7LZRYllGQ+bR8klfBFc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=maENz9OsxojpB69tq6Zrhc1jl1FR2qyGu0eeWR8tqFB7qq/NuqOfaMvJkqT/68+XXGg3OxsFmi5f4Q5AEXAeFcqRU1UYVyBFGKrUGYWT7DWNWQ/4DWP2IQYDiP13nYst7gGGnwxCgw6HQ6Z7oWS20pcJfWNNEUmU4jQbKw1QrmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0FA/kil; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78fba1a1b1eso39839177b3.1
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 12:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768596038; x=1769200838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=plLru19BPw4Gzl5/9w7riKopb0P86akIwhjnuskNV1s=;
        b=d0FA/kilqJCsYv7zaqQ/DF9QXT/eIxuDpqa0Bgc/1tlwQ0jMgR53oXqRPXGLcOCqXJ
         ajV2gwh6IUcllzawrA03I5x6F0u6QfppbK32qusRSyHIH1zCV45P9n+9DalMMIh+FpsO
         YCY0DyF8VGl2MZQSh4+QaxhkAF+83743/R/riG3D69F3M0fcxPcm0tk5w9MioibTAhmK
         +yjyfjD2yiCehVntU//YLsEColGNKy6Lso3/UT91Zq2Kc3e8hRneYDUo6xDp1iEbZhko
         lqsj0gWt4uVfsOkHtxRqO+/0ANjUwNFZBPX6PcF+LolHrBVIY1/qHzofAqUX3V4xDpvy
         HwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768596038; x=1769200838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plLru19BPw4Gzl5/9w7riKopb0P86akIwhjnuskNV1s=;
        b=ELxSpDRgYTDtP1LtS3Ar0sCoMye8qodWOFIQ6BcjiuZ/ODArbzWiYXN6vTXNNp+4Nr
         n9ycJFXiHBHXnhQRpSat2IoLsyEcEnphHq54u/sFW8k9daZXF4mXapyGfzJRm87W07R2
         abWqtooGHpzvKGDrz2m4gz7KPIrMw2k3fskqkLJ5rzVRww/RGazmpLLTMNF8+wPFhTIa
         eKBW028apcKSBM544Z3M/PKAQRGM1KkPO7COMfP4ZzdEPbu6n+o03/pb/9rooj6AW7Ns
         5OI9J+2uoQ5AaqO80xhMtGyRVPSHVgXiK8DK63ioceTUbCN3YP5gvklJrXPg1dlNI0eJ
         3RLw==
X-Forwarded-Encrypted: i=1; AJvYcCVe+ZrPqKBS+YsQtV4XL6azYoRKEKKT7/M5lDtCGTQ0DWDddfWt5whMGArdlXSB7WRlOX204/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW3FNb+GmczZcxsCpGhfiSq+02O/XqM3FDnLORrf8CZRluu5UD
	bdSp6BlpuwF6rGitrpIMNZFuHTWIYS1ZssNx/erFPQDg6qBi7yk+qiw0
X-Gm-Gg: AY/fxX70RoMdmYG64i1tHJtQCttEzaR+cfwmSnF2gdE4f8aXxA6V6AjbDO35QUFFyzz
	n275MKeia+2zA806G762r/ApknFfSq9XNMB+bL9oqeSerliOQzOpKBTvxVQnENBfyqCBCRBhze3
	VGqCPZzPjpFLhjoO7OXKSHPThL5mN/USB4A/iSafTi130BlzKZD5F+macbqN4CrYLpXQrIqZMPJ
	wY3pgIR5LoXyabixVhyF82pzMK+NfFFX1EJ0KHYEnxUAk7EPvF8nOGJQ7LhkCQcOY7Q7XMyqBgz
	KNy917mxoLrcxgUbgXbYT1laua2T4/tqNBPOlY5QT5oMMqWbjXWVcaZA1o/CrLRIxx3gZew3k1L
	lfEWUAMKlx9LQfzacOnMo2UvJNkF2XlGLSXExh3yqshZqjPCoT94neq5t0XwxgBsKCdNhCU1XUr
	Eple39gqqzpQ==
X-Received: by 2002:a05:690c:10d:b0:793:c7df:9dd5 with SMTP id 00721157ae682-793c7df9e51mr26768467b3.33.1768596038285;
        Fri, 16 Jan 2026 12:40:38 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:51::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66c72bcsm13184287b3.2.2026.01.16.12.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 12:40:37 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Wupeng Ma <mawupeng1@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2] mm/hugetlb: Restore failed global reservations to subpool
Date: Fri, 16 Jan 2026 15:40:36 -0500
Message-ID: <20260116204037.2270096-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
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

The underflow issue that the original commit fixes still remains fixed
as well.

Fixes: a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: stable@vger.kernel.org
---
v1 --> v2
- Moved "unsigned long flags" definition into the if statement it is used in
- Separated fix patch from cleanup patches for easier backporting for stable.

 mm/hugetlb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5a147026633f..e48ff0c771f8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6713,6 +6713,15 @@ long hugetlb_reserve_pages(struct inode *inode,
 		 */
 		hugetlb_acct_memory(h, -gbl_resv);
 	}
+	/* Restore used_hpages for pages that failed global reservation */
+	if (gbl_reserve && spool) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&spool->lock, flags);
+		if (spool->max_hpages != -1)
+			spool->used_hpages -= gbl_reserve;
+		unlock_or_release_subpool(spool, flags);
+	}
 out_uncharge_cgroup:
 	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
 					    chg * pages_per_huge_page(h), h_cg);

base-commit: c1a60bf0f6df5c8a6cb6840a0d2fb0e9caf9f7cc
-- 
2.47.3

