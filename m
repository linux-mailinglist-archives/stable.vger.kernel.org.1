Return-Path: <stable+bounces-253903-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ExVFtFCEWrsjAYAu9opvQ
	(envelope-from <stable+bounces-253903-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 08:01:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B9B5BD61F
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 08:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65625301C6E3
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 06:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FDD23909C;
	Sat, 23 May 2026 06:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dEmddc0A"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381CD331A5B
	for <stable@vger.kernel.org>; Sat, 23 May 2026 06:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779516098; cv=none; b=gWg7h6fWvgi0TFWg/n7dcDt9MfZ/hHxAHkRuZSileX4KgtPs1v7OVUkqoweAITz2sev2zGuBYTpsTZX7ab0BiIWk3Z7Xcobi9pda12VxRWdANYhugTgIqcLzr88o5b5NrtIUpsydGiQIQUCJOR5PVFC7VIDAfCBYL7rB0Y38ALM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779516098; c=relaxed/simple;
	bh=Y7Ymyf7qiTxbyZXUgZlO+YnhYDIJGDl/f5myYr0BMMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQUuG9bzzsibzYRFbi5GUu2ohTz3UVuUL88c8bhae/JwKqUH6i0f66wNKKKBrU1hCgHy/hiSmI3Q6iXrtJi2hjoNdQUtFgY93RzJs9VvMgmi9VTRRb+MmI6LSnxpiadISLAF3c4KRFxaNTGlGNhZA1u50Dl28ktteJiMlboj6sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dEmddc0A; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36a8ee1e28cso696379a91.0
        for <stable@vger.kernel.org>; Fri, 22 May 2026 23:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1779516094; x=1780120894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=63lvyRs9Tc58HIWr/RdMFYbATzvXY2B5nVbtsmU63VE=;
        b=dEmddc0AswWYSJPKOZqmxQhXe6GrACWsmgt/aZRuRlasYbtejVuoQZm+dSQ9jQjcc6
         C70imSO7H8uHs/MrlomWFIFGCHYCrwn6g22bAZ/GpR0rT7QkBUEz8+jRF77RinRyGTnd
         0BVpWcIRVs67Bh3RjlPtUOcIeTytto3TgdMnXTJp2XxwNKTWrtWW00JJs1A7wfInQNJG
         lmN1/BE6gJkV0uuKpTJqq0XQmVlx8dRscEVJsDDQQ/PdsJAWUEkw4/xpNuqhtuAu4y+O
         uJAvQEmWUnhGs2pm3/Mn8bYdvTmdAmkibinyn28zKArMUPjLwvIV5sFukuuACGB1ETj2
         Rv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779516094; x=1780120894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63lvyRs9Tc58HIWr/RdMFYbATzvXY2B5nVbtsmU63VE=;
        b=gxxYzAcYAFXjYk3Beaaf8OAGOlFQjZcozK/TRYJJTtca8wc7tg7rit23zoq5mPBO+3
         jZURsyA+sFh8SaB6NjduQAmIT+ShWAliR74ZQC5y/Y0yJ8UgK7/jOYQX1q7eYPt41WBI
         10KGgSJBmdLaiENDKVpoymTRsPO4tNLPQdOfug0wqhRUu8mey/OkQbjp/0wxncbtuFZO
         aud8Kd/HnHFHJXXQ1XHKXTE4lKf6NdJfqFmkkfjTBsguHte1Oe+us32ZWGdkCVFoRbiS
         KdhNVCTBdlRjq3AIwFmSZv5uYzX1SvfBmIcHU+rL7qTrMO3cuw4lO5EsqfE2qFBiprqq
         +sSA==
X-Forwarded-Encrypted: i=1; AFNElJ/9uqT5tV/MLsSdQw3eHIptcNVCCufjsAJojymOrAikB2iYttBriLkk5veTaJ+W9cZEWRY61zA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFvUSTeRoWv+hTJDcfDVbINcq+FDIENdb4JqqFFuFzMaJ3obCU
	EKaPMccJUrXY50bOKtxgqOdzbd+s9ztCdT1wL9yUTrRXpo1fSXngCkC/CscHvWFAbzo=
X-Gm-Gg: Acq92OGH9phenI3lvekQQtzMRCwQu3IWy5rBVV3splWTCsrLmtDpSXrifc1RMREXLFJ
	7RysM5ExJ4HeFrbpHxfyZ2WfUzaPJDSrdMt3GgPQa87pmZc7AoLz176xb8mYiaVGXFwPdIjT15Y
	OCW+GrDz5CXS7NMM93MDyzH9Rh0Zg7mZQLc4tyJbqyEJvCrBhkkhV2z0n0GHw9032e7iPe8mRbw
	HbLAPqQVA10VYKSmzrKDrQQJMfbS01Z5egnqHdaDThvvrvUvyrmSwQDDQ8tGfdXh3bPpKkeMJcF
	uGYVrna4fnUysGXwDs2P1D+up3aZGCA2PVpe8EZWUnKqdHwz3XL/VDAVnaGQiUedfQJwwqzyAHH
	mUYnBPhO4GNLJjwppprZvkAxhB81nm8M4yq4e0NCtq1v+JZt7+TEiaTfPDBxZAZJminGstx2gro
	QrcubwsZQS9ANfcEZOsYNUFgEhesKZyhE0FFjSViYqa22r+ikvJG7fHOQ=
X-Received: by 2002:a17:90a:fc44:b0:369:bddb:79b5 with SMTP id 98e67ed59e1d1-36a676dc2d0mr6917568a91.2.1779516093645;
        Fri, 22 May 2026 23:01:33 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a7265a001sm3431127a91.7.2026.05.22.23.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 23:01:32 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	linux-mm@kvack.org
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Frank van der Linden <fvdl@google.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH v2] mm/cma: fix reserved page leak on activation failure
Date: Sat, 23 May 2026 14:01:23 +0800
Message-ID: <20260523060123.2207992-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253903-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_NEQ_ENVFROM(0.00)[songmuchun@bytedance.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[bytedance.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bytedance.com:email,bytedance.com:mid,bytedance.com:dkim]
X-Rspamd-Queue-Id: E8B9B5BD61F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If cma_activate_area() fails after allocating only part of the range
bitmaps, the cleanup path still has to release the reserved pages when
CMA_RESERVE_PAGES_ON_ERROR is clear.

That is still worth doing even in this __init path. A bitmap_zalloc()
failure does not necessarily mean the system cannot make further progress:
freeing the reserved CMA pages can return a substantial amount of memory
to the buddy allocator and may relieve the temporary memory shortage that
caused the allocation failure in the first place.

However, the cleanup path currently uses the bitmap-freeing bound for page
release as well. That is only correct for ranges whose bitmap allocation
already succeeded. The failed range and all later ranges still keep their
reserved pages, so a partial bitmap allocation failure can permanently
leak them.

Fix this by releasing reserved pages for all ranges. Use the saved
early_pfn[] value for ranges whose bitmap allocation already succeeded and
for the failed range, and use cmr->early_pfn for later ranges whose bitmap
allocation was never attempted.

Fixes: c009da4258f9 ("mm, cma: support multiple contiguous ranges, if requested")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v1->v2:
- fix the failed-range cleanup to avoid using cmr->early_pfn after
  bitmap_zalloc() failure, as pointed out by Sashiko
- explain why the cleanup should still release reserved CMA pages in this
  __init failure path
---
 mm/cma.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index c7ca567f4c5c..a13ce4999b39 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -188,10 +188,13 @@ static void __init cma_activate_area(struct cma *cma)
 
 	/* Expose all pages to the buddy, they are useless for CMA. */
 	if (!test_bit(CMA_RESERVE_PAGES_ON_ERROR, &cma->flags)) {
-		for (r = 0; r < allocrange; r++) {
+		for (r = 0; r < cma->nranges; r++) {
+			unsigned long start_pfn;
+
 			cmr = &cma->ranges[r];
+			start_pfn = r <= allocrange ? early_pfn[r] : cmr->early_pfn;
 			end_pfn = cmr->base_pfn + cmr->count;
-			for (pfn = early_pfn[r]; pfn < end_pfn; pfn++)
+			for (pfn = start_pfn; pfn < end_pfn; pfn++)
 				free_reserved_page(pfn_to_page(pfn));
 		}
 	}

base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
-- 
2.54.0


