Return-Path: <stable+bounces-114847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFC4A30476
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 08:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19A116654C
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 07:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDE11EC014;
	Tue, 11 Feb 2025 07:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KAVy5F4q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984DE1EB9F4
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 07:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739258895; cv=none; b=lSNPHoblP6+jlKPtA5JB7w8udLDM9okv7O1tz9se0t5xcMfERYsN4iKaD5Vgw4EUnOMGA8z47wvbRz8LlcluOQkF00B8hNwRAFnXQmu/wz8QIbiJYdsHuf+csBcQB8Csi+l5H7XkibAAm+9BnzCcWfh4j117fhbH4d4SN7cpIqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739258895; c=relaxed/simple;
	bh=xDphkzp7YOwassCx3klJnQSoSwa0N8eY8DjCLu7euf4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CZWVKu2C2nWNFNfSws4uEPNG8SbQ1CovpgmehFxQL+e+cV02k1cj7MXioKLYuYeTHdgwnHZKp4g7uT52oQpX1zt2ObgJYczKTM3+rcjPJAoXJYAHLZcEmnzsvPly0Sf6QEoVi2O2A5aqvWoIxRSseGq4FnfGp2Yh4EOJYvx4rAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KAVy5F4q; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fa345713a8so6758076a91.2
        for <stable@vger.kernel.org>; Mon, 10 Feb 2025 23:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739258892; x=1739863692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u8JvwZe222+nCD5D0NlDaqFgopE4s8QEJ665TCjR17Q=;
        b=KAVy5F4qSoiLjA+7OYEDq7MqwzJY7gIB72ynzU1CY1DcFkTAYzC/kX8KGPZ4GVjiFW
         7z5mYuPFyWdKsTLBD4pVsBrC/+0GvFUMq043BmjnaBPwuMrDzm23jsqQQo2eBj3LvhEi
         WRL39VjNnuXSErih5638WF0lFM/CWPj4h2sMCI4cFMEzYVLhyNNAUpYm6uVDou36ZZmx
         uy4myemNHB1NzCjeH5oxHorWvbUE8Y6iiaNgUJfYdcvq22d/6MwpxDAZcrZ6+PQZJXCP
         UcSNLgat75JZ3zPkTmFa46XKnkSui333Tiw1vy/epquGXZPYreHjQOsTNWB9Lr+TjD9i
         0uRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739258892; x=1739863692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8JvwZe222+nCD5D0NlDaqFgopE4s8QEJ665TCjR17Q=;
        b=UF8t3F1rKna0nXtZNqn4IRoY9TCvyQO3bqaJ7EkC4uHgCyaJOUjZvv6x1L3GG1VxM2
         gx1kAWc5dXmQbhBrbfuzRyJ/ZTJejWkvKHIKyK+ISyUWtDNlt6cj18YvpX6ZaxBThBWB
         iITAoeEovIQxE1NGUtEGaLmRLuoEm5MS/cElSk3jiG1obU4imDm83FyogiesX51Sy9uL
         S8UFXUIkQ6Ur2PiK4BGFtr+dRoKIdEZL1yxAUHqfEQxJQt7smIXAv6EgFiRFrcXMmDw7
         AAo4bC51vXNBynLQiYxCvhOkm3wM5363KWX7vlcBzISuqP6QKJ7JzuZF2ctXo1m/Qcnp
         amNw==
X-Forwarded-Encrypted: i=1; AJvYcCVOh3VuM7sd/te2pLakeP7e1H00F+Bn4TAO+VYbs7QmTXD0fNxERribejVR4pQLz7suH2uuD5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcG9ZBBADtCsOBehRa/iWOn8ln6ppKs6Sh19e+lbA3pW4GgNKE
	c/qDvmM/NdPl3vqzBfy+oc1zgZowr0r6UjvIxgk3R5jkGw57xTTSd8LOXdv5W2o=
X-Gm-Gg: ASbGncu3iJq1aDHzhXe6nwVoU6qDX3oXbuPoIthyQKo1+EaLb19Uswf1wiV3lt16XNz
	VRGbTPnnQ0ssRuOO2w3a3b/a+QnUb2S+ttWJu2NcjIVYrSf/pF+HDz3raJDLYkNHxlpOoZvR955
	y6dSpcb+b0QbgcurVed2BljBK5MsxKpnfi8UXmVxF5JrsWgEnwGkpzh95G1QkSpRqi/GgAWB6F6
	U3Wxuy9TP/7M/9bSXwtMoAqoIyRqYqGL3iaylzseqdEXgfvcjYtMYGf3ZbJ5zTBPzDqeUQaOWOk
	rEuJ1agfI6WtQGrxBxwYCc16q9UQB+8x1MeixUxGkuuZQfEAucAm2zyc
X-Google-Smtp-Source: AGHT+IEGFQNt5sPJaZzJIBOUWjXNir7ONpzC/zGumrQumqkRxYesmObQGhXHsFIIUFr5ys2Z+8JnCg==
X-Received: by 2002:a05:6a21:350d:b0:1ed:9e58:5195 with SMTP id adf61e73a8af0-1ee03a45ccdmr32137005637.13.1739258891851;
        Mon, 10 Feb 2025 23:28:11 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad54a066811sm3946778a12.8.2025.02.10.23.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 23:28:11 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: brauner@kernel.org,
	willy@infradead.org,
	ziy@nvidia.com,
	quwenruo.btrfs@gmx.com,
	david@redhat.com,
	jannh@google.com,
	akpm@linux-foundation.org,
	david@fromorbit.com,
	djwong@kernel.org,
	muchun.song@linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm: pgtable: fix incorrect reclaim of non-empty PTE pages
Date: Tue, 11 Feb 2025 15:26:25 +0800
Message-Id: <20250211072625.89188-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In zap_pte_range(), if the pte lock was released midway, the pte entries
may be refilled with physical pages by another thread, which may cause a
non-empty PTE page to be reclaimed and eventually cause the system to
crash.

To fix it, fall back to the slow path in this case to recheck if all pte
entries are still none.

Fixes: 6375e95f381e ("mm: pgtable: reclaim empty PTE page in madvise(MADV_DONTNEED)")
Reported-by: Christian Brauner <brauner@kernel.org>
Closes: https://lore.kernel.org/all/20250207-anbot-bankfilialen-acce9d79a2c7@brauner/
Reported-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
Closes: https://lore.kernel.org/all/152296f3-5c81-4a94-97f3-004108fba7be@gmx.com/
Tested-by: Zi Yan <ziy@nvidia.com>
Cc: stable@vger.kernel.org
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/memory.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index a8196ae72e9ae..7c7193cb21248 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1721,7 +1721,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	pmd_t pmdval;
 	unsigned long start = addr;
 	bool can_reclaim_pt = reclaim_pt_is_enabled(start, end, details);
-	bool direct_reclaim = false;
+	bool direct_reclaim = true;
 	int nr;
 
 retry:
@@ -1736,8 +1736,10 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	do {
 		bool any_skipped = false;
 
-		if (need_resched())
+		if (need_resched()) {
+			direct_reclaim = false;
 			break;
+		}
 
 		nr = do_zap_pte_range(tlb, vma, pte, addr, end, details, rss,
 				      &force_flush, &force_break, &any_skipped);
@@ -1745,11 +1747,20 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			can_reclaim_pt = false;
 		if (unlikely(force_break)) {
 			addr += nr * PAGE_SIZE;
+			direct_reclaim = false;
 			break;
 		}
 	} while (pte += nr, addr += PAGE_SIZE * nr, addr != end);
 
-	if (can_reclaim_pt && addr == end)
+	/*
+	 * Fast path: try to hold the pmd lock and unmap the PTE page.
+	 *
+	 * If the pte lock was released midway (retry case), or if the attempt
+	 * to hold the pmd lock failed, then we need to recheck all pte entries
+	 * to ensure they are still none, thereby preventing the pte entries
+	 * from being repopulated by another thread.
+	 */
+	if (can_reclaim_pt && direct_reclaim && addr == end)
 		direct_reclaim = try_get_and_clear_pmd(mm, pmd, &pmdval);
 
 	add_mm_rss_vec(mm, rss);
-- 
2.20.1


