Return-Path: <stable+bounces-223162-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AoBEVfhqGnzyAAAu9opvQ
	(envelope-from <stable+bounces-223162-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 02:50:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7001520A00B
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 02:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CDE4301AF58
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 01:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B981C84CB;
	Thu,  5 Mar 2026 01:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lwdlvx24"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93AB33688A
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 01:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772675412; cv=none; b=LCHPfxjT9MwQYkfaZoBYkYN+AtcLwGx7m7dNUHoxMDzjies+orzD6HkhETI1C+4Wyw91f8M2mnw8Kk1U9s1jyhIi41JlYFhUZucCMU9AhFaDmwxAmMMy5f/0m8HtqZ4AvZNcy+jimspIAZVTCi/WmGDCAwZvpz6KWT9SgDjTWfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772675412; c=relaxed/simple;
	bh=wQ/u9rQKUsL3bd6QgFMGoC5t57NYQRymsZ55pKSghoU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Ze0xoyJrAwktaA6FCXWIjev3DWczPO9/MJhSa5pHzqW20le4ZVJ/i3xxfLk5Z//kjmA6lj2LwTs6qdmG8GZlweI5C1zDdmQuTL0Yo3TlNkjadVMxV9Te6cRToZnu/wnguCV53cG3hR6B+To1MeESHL7XD3YfToCj/MLtpDoLF10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lwdlvx24; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-65bfc858561so4153293a12.2
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 17:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772675409; x=1773280209; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dD52BcDVoMQrtMpMvwdJ0XwlitnIFQsRkhRbjewdIjU=;
        b=Lwdlvx24aN8ihrWBwA0ahku70e5Z4T9+8/9G3OuKgu9xTC07HtG5HVc9OBcQoDiWDU
         YQhW9JelMEB28KuNxW8HVdzhNXChQcSLsNE1osr+qFxWrpRR5vRUXlzUDAAbEmE9Bx30
         voiGbturQenA8mcH5RmCkVBwVoiONC6iSxwKblQkpK1n4WmcSomSvohrcVmVS1p+d8FZ
         WE2CuOIq4f8cqBMbkz/2LxuxAP1tH2m+qVrCvY+MNoKgRdSWbQ4FZ6cfS73N4hVBNPHl
         LySX3+0HwivOXD6EbkFrLYgy27585txZ2KT5lI0COSS0cS3G5dunEHpUyJg+AJABJKWC
         WWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772675409; x=1773280209;
        h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dD52BcDVoMQrtMpMvwdJ0XwlitnIFQsRkhRbjewdIjU=;
        b=NkQeu0qLSOmfpubr9GyjTkjM0ft+A80rIskIEnWF4KmaUNUFG6WMp3z23NcwLS2Tok
         waB6Y7YiAuSsTyaLsPGdRAUS//YJKydv315qgAeawjLiEmqE5hTpf5vvtiFWe0/KGQtl
         Hufh+uVkPXnjfhWbRr/0BsPe328kRTCZhQ0J4Vvt+VCdx1QlMqhYyiuXVCTq30KYPIn8
         8yFw4rzDFcacxYtTZqaVNhrNyThuoQyOub5A1sVsrmn2ndhgwlAc1K5MHa26a3ucoZdz
         FixXS2h9lC5v/7FB8qsW1rak9FYS9OJ9qhH2fOdfQkYbP90VKUc2+fctCSFBZJVkqUfp
         38vA==
X-Forwarded-Encrypted: i=1; AJvYcCXjca48sxC0wBKqsCQP1a5s48Wsxf+hZtMKbcgAmZU/nE2Z1nFZ1IUN3ScOuY1wpAPkmp7KhtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxap+lBxgNlGiKJ58qi3/V0LiUT/MLlaefFC61pnGj/4pTZDQYO
	vgchEmgdEmO3Stq+XkZCaniwaLxN0P0G85nxhPqFpeTJoxHYW5L3R1o+
X-Gm-Gg: ATEYQzyHR3lLpFGo5NU7X99S/dUtCEnHuZRJqDV+4yfNL6QNuKX2zxdoDzqNO02mI6v
	zoa2PT+oVRSiCs2yTZi6ezVJuQEN1bKSBrcsP3Oun+jOe/hPicQGfaOF7jqeE7Bc5HfrwFbHLxm
	9NuxjRu6KNdgJtiJv1AMp9fXfs0IcSU0DHNQeYV9/2u17GKFyc8mGrWoMCeIdVZoox97xNMqMxC
	T9BhnacG6s3EGM4PdrouuvVY9xHjeC5evrq7PuI3Hi9yciVI5voPVwB73LZjBZ/MuLZRg4C8ddt
	7LfIhvU1acuKwYkkSNd1amq58N33fLAlUptj8YZgdaesoXaKklgyC3UzlsMH0mRP+/93qabMr1y
	GiFOgFlSbSy9lSV8O6EqtbUsSSCzFy+skyuwsh9B++x9LXZQ+TY3t8pt+QbdQNEUdP0o1F+jHf+
	WkahAL9nr+QpLOY4xwrhyATg==
X-Received: by 2002:a17:907:97c4:b0:b7d:1cbb:5deb with SMTP id a640c23a62f3a-b93f11d67e3mr303322066b.27.1772675408979;
        Wed, 04 Mar 2026 17:50:08 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935aee3ab4sm821988566b.61.2026.03.04.17.50.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Mar 2026 17:50:08 -0800 (PST)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	riel@surriel.com,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	harry.yoo@oracle.com,
	jannh@google.com,
	gavinguo@igalia.com,
	baolin.wang@linux.alibaba.com,
	ziy@nvidia.com
Cc: linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Lance Yang <lance.yang@linux.dev>,
	stable@vger.kernel.org
Subject: [Patch v4] mm/huge_memory: fix early failure try_to_migrate() when split huge pmd for shared THP
Date: Thu,  5 Mar 2026 01:50:06 +0000
Message-Id: <20260305015006.27343-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 7001520A00B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223162-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,gmail.com,linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,nvidia.com:email,igalia.com:email]
X-Rspamd-Action: no action

Commit 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and
split_huge_pmd_locked()") return false unconditionally after
split_huge_pmd_locked(). This may fail try_to_migrate() early when
TTU_SPLIT_HUGE_PMD is specified.

The reason is the above commit adjusted try_to_migrate_one() to, when a
PMD-mapped THP entry is found, and TTU_SPLIT_HUGE_PMD is specified (for
example, via unmap_folio()), return false unconditionally. This breaks the
rmap walk and fail try_to_migrate() early, if this PMD-mapped THP is mapped
in multiple processes.

The user sensible impact of this bug could be:

  * On memory pressure, shrink_folio_list() may split partially mapped
    folio with split_folio_to_list(). Then free unmapped pages without IO.
    If failed, it may not be reclaimed.
  * On memory failure, memory_failure() would call try_to_split_thp_page()
    to split folio contains the bad page. If succeed, the PG_has_hwpoisoned
    bit is only set in the after-split folio contains @split_at. By doing
    so, we limit bad memory. If failed to split, the whole folios is not
    usable.

One way to reproduce:

    Create an anonymous THP range and fork 512 children, so we have a
    THP shared mapped in 513 processes. Then trigger folio split with
    /sys/kernel/debug/split_huge_pages debugfs to split the THP folio to
    order 0.

Without the above commit, we can successfully split to order 0.
With the above commit, the folio is still a large folio.

And currently there are two core users of TTU_SPLIT_HUGE_PMD:

  * try_to_unmap_one()
  * try_to_migrate_one()

try_to_unmap_one() would restart the rmap walk, so only
try_to_migrate_one() is affected.

We can't simply revert commit 60fbb14396d5 ("mm/huge_memory: adjust
try_to_migrate_one() and split_huge_pmd_locked()"), since it removed some
duplicated check covered by page_vma_mapped_walk().

This patch fixes this by restart page_vma_mapped_walk() after
split_huge_pmd_locked(). Since we cannot simply return "true" to fix the
problem, as that would affect another case:

    When invoking folio_try_share_anon_rmap_pmd() from
    split_huge_pmd_locked(), the latter can fail and leave a large folio
    mapped through PTEs, in which case we ought to return true from
    try_to_migrate_one(). This might result in unnecessary walking of the
    rmap but is relatively harmless.

Fixes: 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and split_huge_pmd_locked()")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Tested-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Gavin Guo <gavinguo@igalia.com>
Acked-by: David Hildenbrand (arm) <david@kernel.org>
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Cc: Gavin Guo <gavinguo@igalia.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: <stable@vger.kernel.org>

---
v4:
  * only commit msg adjustment
    - rephrase the reason analysis
    - move reproduce method afterward
    - more explanation on user sensible effect of the bug, especially expand
      what "Limit bad page" means
    - remove the explanation on whey it need to fork 512 child for reproduce
    - explain why simply revert commit 60fbb14396d5 is not taken
    - mention TTU_SPLIT_HUGE_PMD users and confirm not affect others
    - rephrase the reason why can't simply return true
v3:
  * gather RB
  * adjust the commit log and comment per David
  * add userspace-visible runtime effect in change log
v2:
  * restart page_vma_mapped_walk() after split_huge_pmd_locked()
---
 mm/rmap.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index beb423f3e8ec..e609dd5b382f 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2444,11 +2444,17 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			__maybe_unused pmd_t pmdval;
 
 			if (flags & TTU_SPLIT_HUGE_PMD) {
+				/*
+				 * split_huge_pmd_locked() might leave the
+				 * folio mapped through PTEs. Retry the walk
+				 * so we can detect this scenario and properly
+				 * abort the walk.
+				 */
 				split_huge_pmd_locked(vma, pvmw.address,
 						      pvmw.pmd, true);
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				flags &= ~TTU_SPLIT_HUGE_PMD;
+				page_vma_mapped_walk_restart(&pvmw);
+				continue;
 			}
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 			pmdval = pmdp_get(pvmw.pmd);
-- 
2.34.1


