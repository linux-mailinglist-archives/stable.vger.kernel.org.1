Return-Path: <stable+bounces-249744-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iONHH1M9DWqquwUAu9opvQ
	(envelope-from <stable+bounces-249744-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 06:49:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBC4587A18
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 06:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73111301F5ED
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 04:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A693385AC;
	Wed, 20 May 2026 04:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LL+OjjAG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EFF2C3266
	for <stable@vger.kernel.org>; Wed, 20 May 2026 04:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779252559; cv=none; b=og4FINdNrWsKKW9Dtt1BiQQqT9EhTHAR4+PqOiHyfzUAy5s5re+EkS1dHSgY3Q7OhYdk0JyMjt58Yn2H7G2CIkexKmHNkgIh4MD+q3uO1HgpnsHz9kvOngAnYxk3vMVT2MmYqnTe7w/GFsUkHmqJsw+zYLV2KYLjDosTm+mJZYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779252559; c=relaxed/simple;
	bh=ziYccg4TdsqjbmtxPiu50UjxLrYVf0KsFRmerfX2hvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAze7Bx6+wl4GEhEzyeCYx2h2WmxUorawDcZaYN0fVR1k0PNuQsmAqFMzOSzjOHG59pdyMkSGUTlEtqBMLzXFdViJHBtW7JvG6nGhb2CuSIjXn26pGKSaTo1OUKqf5UNA0tZ+oQ33ZcOORCOxiZNzxixqyqj+dU8O3oVRwguOuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LL+OjjAG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so64188815e9.2
        for <stable@vger.kernel.org>; Tue, 19 May 2026 21:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779252556; x=1779857356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57hoFoACkrjHC435/bCa26l7dMtPP1jCMndjVz0up2g=;
        b=LL+OjjAGzl8ZrwNnXeEFlBcEFHH0oC7SW5K8wCKoEjDRUw1aNmTHIPvfof9fUZVji7
         s4ewLpBEdFCAKbFF8YFTXI90mPVx9LVBLPoV5kw9HDH12tk+1a85wCQfatqbrGP+Vrmu
         ocZmVHNKmQrRy1Eq+rcOtXpVyMnfwnk1m/g6qyY3tsKKLh74EYpKhOTN3UAnqHYw+vVk
         FWye4W121+Rqgs4b1iO9q8diI4kgO9mOnTFSUzDPL5CS8Ha9FScS9rRj+msF6h75//4R
         UiecdqmhJAtqL+05/C/KQe0wJGRuguyX+BrfjGFJLHn21sGXSmuRC+RDswrxnE2Y6r3n
         flyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779252556; x=1779857356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=57hoFoACkrjHC435/bCa26l7dMtPP1jCMndjVz0up2g=;
        b=nrS/vvle3rDBXjKSPgjDG0MOiPrqZyK3mzPHmAy87mGZxJfN5lVYN2e1nkIbJ4Z1Y1
         pr4L2fPlIF8/jPUPg9Z675jDoJZ2B7u2O6iCNmvNFEYRXIJk55e74he/De9Bd5bwXRku
         DsqiR8OThs2WmIycbvZuqsTcFnkcnY9XaxOU7H5qJS4W+25YulyR8Wq6kRNK5mkufRbl
         yzByXjQWZ576lcHLztBbZpoGh46/eG7asNAneV2mct318BskTM0cxXe2bMiN9JRfngLy
         Cka7cKTaox3shdp/fkWqGiKnRVxEBVTup7DUC3o4Bpi444Pk7c0IJmChiOIfaG8X1EDE
         AjzA==
X-Forwarded-Encrypted: i=1; AFNElJ/MGf+HEnqZzxbTzASHg/m+rfjeAYkSDk0WSEkXaW6vtkKdZwP4xAHW68MOHWMFFtvpf8umu3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/kS5kUU5SSRpop4OQBHNBr3o/Zv6seL5ilxnwI1951nNXPpPv
	PgJ7d5B8v9HCusGQUznAMQQ/j5Pi8V9zKZd1hDNTs7184grFWqB9S74m
X-Gm-Gg: Acq92OFqeysZN3b7ZnndkQz3SRr+F2fBfLryTRyootFj2N5yFC3z7w72ESbZ+s6gVIS
	ViUOmfS6Ev7ywdmJaAw6bdDNGhwSgvR6n1pAMB7uYdQptuJkX9zdiFQRHPZkZxR1FiIj4+K9iyt
	uCmYEvxO9ZIaap0EgzExaBnGmdjr8zFE+QUf75ZnO3/oXWbFuaCBMifo0Hb02Kki+WnV4THqRqT
	+ZK3ZIg5lrP1E+v+35/Fulw47Pha5NXkTotctRRtfSJjhXYuEoK4ra3Q9p+QB71VFu2TUKeXJwc
	zdadxIn7HnLxTkTPEOPhOMso4jZi8YGJOf/vAP3wru/DIdECBl1FFAGPjygpuUlUiQh2et5mn81
	qxc6irmjTzyLSJEvKU97irQ8LOTNQMLCQvre9NRJylq7q1+fsDKIzGr7wv+LUMqmIwL6nT/H4s0
	zjJPykaF1WzqDoumSfy/1gChRiG49cvqK+PziBdiScMpBZ10lb3kkzyiEHgGh4IwnFLw6vNaE65
	ii5bns8Iek=
X-Received: by 2002:a05:600c:1f94:b0:489:1d23:4524 with SMTP id 5b1f17b1804b1-48fe60de736mr327397805e9.5.1779252556299;
        Tue, 19 May 2026 21:49:16 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fea52a0bfsm189071125e9.0.2026.05.19.21.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 21:49:15 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: akpm@linux-foundation.org
Cc: muchun.song@linux.dev,
	david@kernel.org,
	almasrymina@google.com,
	osalvador@suse.de,
	yuehaibing@huawei.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v3] mm/hugetlb: restore reservation on error in hugetlb folio copy paths
Date: Wed, 20 May 2026 05:49:12 +0100
Message-ID: <20260520044912.6751-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519230503.121293-1-devnexen@gmail.com>
References: <20260519230503.121293-1-devnexen@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,google.com,suse.de,huawei.com,kvack.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-249744-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DCBC4587A18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Two sites in mm/hugetlb.c allocate a hugetlb folio via
alloc_hugetlb_folio() (consuming a VMA reservation) and then call
copy_user_large_folio(), which became int-returning in commit
1cb9dc4b475c ("mm: hwpoison: support recovery from HugePage
copy-on-write faults") and can now fail (e.g. -EHWPOISON on a
hwpoisoned source page). On the failure path, folio_put() restores
the global hugetlb pool count through free_huge_folio(), but the
per-VMA reservation map entry is left marked consumed:

  - hugetlb_mfill_atomic_pte() resubmission path (UFFDIO_COPY)
  - copy_hugetlb_page_range() fork-time CoW path when
    hugetlb_try_dup_anon_rmap() fails (rare: pinned hugetlb anon
    folio under fork)

User-visible effect: on UFFDIO_COPY into a private hugetlb VMA where
the resubmission copy fails, the reservation for that address is
leaked from the VMA's reserve map. A subsequent fault at the same
address takes the no-reservation path, and under hugetlb pool
pressure the task is SIGBUSed at an address it had previously
reserved. The fork-time CoW path leaks the same way in the child
VMA's reserve map, though it requires the much rarer combination
of pinned hugetlb anon page + hwpoisoned source.

Add the missing restore_reserve_on_error() call before folio_put()
on both error paths.

Fixes: 1cb9dc4b475c ("mm: hwpoison: support recovery from HugePage copy-on-write faults")
Cc: <stable@vger.kernel.org>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
v3:
  - Fold the copy_hugetlb_page_range() sibling fix into this patch
    (per Muchun) -- same Fixes commit, same fix pattern, single
    backport unit for stable.
  - Reworded changelog to cover both sites.

v2: https://lore.kernel.org/all/20260519230503.121293-1-devnexen@gmail.com/
v1: https://lore.kernel.org/all/20260322052120.14021-1-devnexen@gmail.com/

 mm/hugetlb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4b80b167cc9c..ba7c3ed96835 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4974,6 +4974,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 							    addr, dst_vma);
 				folio_put(pte_folio);
 				if (ret) {
+					restore_reserve_on_error(h, dst_vma, addr, new_folio);
 					folio_put(new_folio);
 					break;
 				}
@@ -6270,6 +6271,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 		folio_put(*foliop);
 		*foliop = NULL;
 		if (ret) {
+			restore_reserve_on_error(h, dst_vma, dst_addr, folio);
 			folio_put(folio);
 			goto out;
 		}
-- 
2.53.0


