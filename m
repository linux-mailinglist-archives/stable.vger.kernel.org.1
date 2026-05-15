Return-Path: <stable+bounces-248910-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YP+ZGhyCB2qQ5gIAu9opvQ
	(envelope-from <stable+bounces-248910-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:29:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AF45576DB
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C8AD3009CFD
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486E03E2757;
	Fri, 15 May 2026 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Id9Gsgf4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CF83E171E
	for <stable@vger.kernel.org>; Fri, 15 May 2026 20:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778876951; cv=none; b=jD5wTxO1FNiOWI34fxxNX5SVb2PRTBtEAM9Kf/jv5aTbSjspGqlTsAkHFwBT2eJWKFtCiDlJWe9Ps8v4XlVxqm/1ZUwjKfxd41Z1X5G8a9UlEL0/4W+CCOOfw48KN9XfyD5MeKfkMR9uPcBQIStJWMwYNQ6Akt/cs+Scug95fPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778876951; c=relaxed/simple;
	bh=QO6Y6YhH1LVeqeFD6+YWOTp74M9wQObDTIqOFlYfkdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n1JI9Kozy6RgwoKXQWRmGlbrdwjcnwRm0x58t9rvKpdMQ1C1wJKn7E9UngHJytgt89h/7lRs2VQnQDX5uPrGyqwD7todJeyxMSsLKzjdD4knW4fFelDURaFinenEk1xDk9JTYnNAPdbdp8OsbUQIFyrM7/1/CRyBDOqeaidhYm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Id9Gsgf4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48e56c1bf5dso945325e9.3
        for <stable@vger.kernel.org>; Fri, 15 May 2026 13:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778876946; x=1779481746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hB4x7rO0kWraX/2vch0MYRJ2VJ/csAYjyg45Hf0A9bM=;
        b=Id9Gsgf4xo+DkOyIjRCfrGHsdNgvHrYDSYMtsR14oMjssim8kmGWVwlxZZ3Fi0re5t
         jTituTfduv4P1yCCC0z7vY74+XrNaFE/8nsuMYZOEZNpnyeS4/gVGmiLzuMSmPMQeR5W
         /5JfWvsRK/f7ue0bKMyv0l2FDEVuRDs0QyKSan8pqdQfLVVxIhJXPF0Y5kR58b1WpX/r
         MVvG0ZdbfZxe8jKJb9qLRgIPC3WuECBmK0BE2JP8b6MkH+z78JupJig+lfrmIDVg2GDI
         tuACxCCa8HFbmvr/4pOMJudMTYKzNRbdGk3deTCHArknmqcbA3CaNJxI+fLjBKLCgU3r
         xNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778876946; x=1779481746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hB4x7rO0kWraX/2vch0MYRJ2VJ/csAYjyg45Hf0A9bM=;
        b=Lf8Hsf8DvXMDF8C8iljByd2kJ6bhQs4zM2sCSOq9nCgtPdi+VwOJd39/gNcs4mFLHZ
         w8sUjZ+PNbAAny0UC688qlUIJgOyq79KjcY3/W0pmwRmJ9kqYnG6bh3o2Hg3Ft/35zWn
         EYplRELgqrWDWi/mL8xMTvwtPRsaT7INLCZsYbvSP94y6b6ssPpfUP/J9NZyRpA9uBof
         +qEO7pbPRNGIEwl/+NnA1prx9LJiUkIrt0bKXQBOb36stKweBj11ZgLf/FUwYj/ZVyOk
         Xs+Jg+VZNEDZ8qJxKkhh0qym/K1/56WHCmYQwQM7iqBFS15ZKa1mDXNFuOSIfsLSDcCG
         cwpg==
X-Forwarded-Encrypted: i=1; AFNElJ+iLvoZsjNAGhhL1YQcLMjGqqNv4KJ25A98EqmUrpDi6pD6krA0UNPDHrL/djrLzmmVYqngmj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz25uuBhcpGGzCM/Wz5MBn+ndb7U86X9r15Pqobyqlm6u1ClcbK
	+HgXMSpOsEbooTISlD5j3nFAdx/YE26Htc1EIzF6Omw31o7ftKAk+PT4
X-Gm-Gg: Acq92OGdwfERywm/etiXaALHGXmyMydBSgBWzwn8NviHyDeBElhRfVhhiaA6ndjTSEu
	DcfH8VMR+22tBZapCYbBlh+fh8tdXZ3WpS+4UdcH+8HitL8VBU3ee86W3P/VBFnWOp1yQ23Wc7J
	QTsREDX/1VoyeTxltigkChi40y7CLEws4PUC5syMvLOlK9KzhiXFDCjI92ISN/B8J6EFRUeu/Oc
	43niNy/j80LmstA9U109EDaljifsO4ZFurJ4eOfpArKsruhnXgs7gszRJP+utJdIIQttiTg1ubn
	zDwgi8rgZSC6Rl0yireNW30j9piKvW7C6E6u9h8+mRj1km48upZK8WMkIwVxMC3cUGtfHT6H0im
	wqnX5qB/UeUVTocnNlSHqLmc9UXJy3twpLNXbT1iNMq8LNRjxgUzR5eC/ODTFZKUhDZnPE0cM6f
	prDSxpLw1sG8mm6t8e2U38BvMNZOu5L2m8BUrJuUrqqZrifBw/29Q3aiHNhRwyHACxP0b5tQcdB
	uk4fFKlObmCZ+UqFPIvOQ==
X-Received: by 2002:a05:600c:a406:b0:48f:e230:1d12 with SMTP id 5b1f17b1804b1-48fe6329913mr66632025e9.31.1778876945902;
        Fri, 15 May 2026 13:29:05 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0f72sm18422463f8f.25.2026.05.15.13.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 13:29:05 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	joshua.hahnjy@gmail.com,
	mawupeng1@huawei.com,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] mm/hugetlb: restore subpool used_hpages on alloc_hugetlb_folio error
Date: Fri, 15 May 2026 21:29:02 +0100
Message-ID: <20260515202902.461539-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 15AF45576DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,suse.de,kernel.org,gmail.com,huawei.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248910-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Action: no action

Commit a833a693a490 added a !gbl_chg guard around the
hugepage_subpool_put_pages() call in alloc_hugetlb_folio()'s
out_subpool_put path so a failed allocation wouldn't drive
h->resv_huge_pages negative.  But hugepage_subpool_get_pages()
increments spool->used_hpages whenever max_hpages != -1, regardless
of whether the request was satisfied from subpool reserves or needs
global pages.  When gbl_chg > 0 and a later step fails (cgroup
charge, dequeue, buddy alloc), used_hpages is never put back.

Each such failure leaks one count; eventually used_hpages reaches
max_hpages and the subpool refuses every further allocation even
though no pages are held.

Commit 1d3f9bb4c8af fixed the same defect in hugetlb_reserve_pages();
apply the equivalent restore here, guarded by spool and max_hpages.

Fixes: a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
Signed-off-by: David Carlier <devnexen@gmail.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Wupeng Ma <mawupeng1@huawei.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: David Hildenbrand <david@kernel.org>
Cc: <stable@vger.kernel.org>
---
 mm/hugetlb.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cfb7cb2e9806..9614330889de 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3010,9 +3010,22 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	 * put page to subpool iff the quota of subpool's rsv_hpages is used
 	 * during hugepage_subpool_get_pages.
 	 */
-	if (map_chg && !gbl_chg) {
-		gbl_reserve = hugepage_subpool_put_pages(spool, 1);
-		hugetlb_acct_memory(h, -gbl_reserve);
+	if (map_chg) {
+		/*
+		 * Put used_hpages back for the global portion of the request that
+		 * was never actually consumed; restore the subpool-reservation
+		 * portion via hugepage_subpool_put_pages() so rsv_hpages is rebuilt.
+		 */
+		if (!gbl_chg) {
+			gbl_reserve = hugepage_subpool_put_pages(spool, 1);
+			hugetlb_acct_memory(h, -gbl_reserve);
+		} else if (spool && spool->max_hpages != -1) {
+			unsigned long flags;
+
+			spin_lock_irqsave(&spool->lock, flags);
+			spool->used_hpages -= 1;
+			unlock_or_release_subpool(spool, flags);
+		}
 	}
 
 
-- 
2.53.0


