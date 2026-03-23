Return-Path: <stable+bounces-227934-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YK3oHVELwWmtPwQAu9opvQ
	(envelope-from <stable+bounces-227934-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:43:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 119B82EF43C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9E89303B146
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 09:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8324386C14;
	Mon, 23 Mar 2026 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VaCXrhFW"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD7129992B
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258822; cv=none; b=H22g3LviJHb9YysBA2ICbmdmbgQ0ijVUb8IqsP305WYfDQteW/XTn9ctuzrHcrTwbFSinGMvqRB9MI+EQKIjoLmXk1xnerCTBdtDDG8n8K06fbepHMdXY650FS0WlX6i38NWlEglKduw/41tlX1RBIgx4ahE4+sUNE4QfsSPph0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258822; c=relaxed/simple;
	bh=QMhP9ISMPM6kCpLiQYJSezS8/ndakvzCzC0hZ3AYsuc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=L4gAP4NRRBTI3J2u2Xsq5nOF5I90toGfRaXr25wXormgNw5D3VE0jhsZR5Psnglu7TuP/l6ivxNcnASstylQ0cHkuvcBjGCgYECp86xRLt+J497qND9eikIFGvoI0n/edFcycTaKggPR3FvRFWJuB+JPC+lvbl7u0ZcjOhQ4Chc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VaCXrhFW; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79ab5fd969aso6459757b3.0
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 02:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774258820; x=1774863620; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ek3QMzzuCdQ2kmTVHTH653xAneszL99lr6ZT2m0+zdo=;
        b=VaCXrhFW3thS7V/v3Qm/6pH/np5PzuUbffymxJT1msQ5NZvFRKXnzK8FHIOJ8miyr3
         srTx+MfH7UDZGTQ2VVhpJcldHNy1WdI9ZgXUJ7+LB7Cynk6mAJL/vyE5lOTS1Yr/bwHo
         8K8qzWc9GtCQpjKWL3/p6/YeV+BcoCBfT+hLOPPgg8vjDSSBbrfia9ycdr09/JCqntUw
         GXi4W+6GjCVv3B/k6ZS0U2TuhPBfO7rMTZWka++OV5f/EbO7H++NXruDlN+q8ayYOG1j
         8JKD351Q/TlnOTOpF7z47MItwew0CiV+7ZC+Z35xjhOT6a8LbDiRESmVmVtLEqRzjq/P
         sqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774258820; x=1774863620;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ek3QMzzuCdQ2kmTVHTH653xAneszL99lr6ZT2m0+zdo=;
        b=mJvX05iKq40pwWS6IVJE2DInUyoeHg6kyMz00NVKxehzPmoS09v3mB9fYk2SXZZFbG
         /caGaFTp6BLy5qAmexUrFly/PWmc5AARn9o35zmAAPr9ok9smKppimmwnPP63B7y7Fet
         k3B6eM0LpsXO5J8SOiDvVUuFxTdTK3zMDjp7Zra0Qxb/IhYo9Uyqb8pi89bO1HOUmXFj
         09gFplo/OuxB7Fi2U6GPs04oLc5YG5kFA1hWXbFl+YgHY1NVADWM6kYaTl/d4LajfYQe
         xXZ3dsfqEycJWLFIS5qGjnvvMG9S5lGCnqbOwDBQ3RsIqPj4HELtyiN0e0LFHQbutIXK
         213A==
X-Forwarded-Encrypted: i=1; AJvYcCUrtFuNlt+zTxClpIfOQVVoFZti8qRIamvpN+O1lHa/cX0EAQ+T+Ixy//tV7Js9yhaqH3jrFYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXm4oUGDAaNqU8wWqnz9EsfMn+n23WJo/bZhr5bTJvY6ORKsoK
	P8IRHp50ACLeRVK2+JZjSFYNoVy/NBw3iGH/6IxdZsNLQsnTqUwX/uH3IrZcETZwGA==
X-Gm-Gg: ATEYQzwwd7PvE1QH/bLyB9MG2Qg4xRDGc9bZfbuhr3/F6qhX7q5O1qsrWq4xp73wXPk
	wciPk5AfW00D4YxS67KP1SWelBjaAgmIKfJHUy4ct68H7VpBKF7YvYSBvvjUMrpexMndNkvqfUe
	+CrSnJxV2LUI/X09s+jgh5bIx46F/ii2HAHcLooVcC60rQLIjA34y7KMtTx6WHDijYUj8UX4coT
	3ICtSM3tsD9Ibku2LAk3Ce4V6t1UStWqFMXsDvG9l8ss8kFHlFwuoRM88EqLxKp/HmVU0Do/BP0
	vG4mQiRbe1UiGG9A8Q7YlituxfBPEqeanrG9/7i+55SQsz8JW99g9pqZp3XBjBNotns9OOBynvx
	jMdvblCssh42rxkAAJH3VNYI62zgz55Rqz30aw7ovaCht6LrpQXO57F0lQr39NqcdFMprdjqdIz
	awKiffD/kpkfh6UZ5GtdE1jqKaopDy1xBW0o1wF+HLwNZMrX/MA/JhDZlABkOhpOwYcswDbV2cR
	ajt1ccWol3vjcbU9pndJA==
X-Received: by 2002:a05:690c:f14:b0:79a:4f03:b2a4 with SMTP id 00721157ae682-79a90bd0735mr123494717b3.29.1774258819463;
        Mon, 23 Mar 2026 02:40:19 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a90554a03sm54544347b3.23.2026.03.23.02.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 02:40:19 -0700 (PDT)
Date: Mon, 23 Mar 2026 02:40:16 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, Baoquan He <bhe@redhat.com>, 
    Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
    David Hildenbrand <david@kernel.org>, Dev Jain <dev.jain@arm.com>, 
    Greg Thelen <gthelen@google.com>, Guenter Roeck <groeck@google.com>, 
    Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
    Lance Yang <lance.yang@linux.dev>, Matthew Wilcox <willy@infradead.org>, 
    Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, stable@vger.kernel.org
Subject: [PATCH 6.12.y 3/4] mm/shmem, swap: improve cached mTHP handling and
 fix potential hang
In-Reply-To: <a07eace6-82f2-32a8-0cbc-85972d4b1eee@google.com>
Message-ID: <318493ca-2bc3-acad-43bf-b9f694e643b0@google.com>
References: <a07eace6-82f2-32a8-0cbc-85972d4b1eee@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,linux-foundation.org,linux.alibaba.com,redhat.com,kernel.org,arm.com,tencent.com,huaweicloud.com,linux.dev,infradead.org,gmail.com,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-227934-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hughd@google.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,arm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huaweicloud.com:email,alibaba.com:email,infradead.org:email,linux-foundation.org:email]
X-Rspamd-Queue-Id: 119B82EF43C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kairui Song <kasong@tencent.com>

commit 5c241ed8d031693dadf33dd98ed2e7cc363e9b66 upstream.

The current swap-in code assumes that, when a swap entry in shmem mapping
is order 0, its cached folios (if present) must be order 0 too, which
turns out not always correct.

The problem is shmem_split_large_entry is called before verifying the
folio will eventually be swapped in, one possible race is:

    CPU1                          CPU2
shmem_swapin_folio
/* swap in of order > 0 swap entry S1 */
  folio = swap_cache_get_folio
  /* folio = NULL */
  order = xa_get_order
  /* order > 0 */
  folio = shmem_swap_alloc_folio
  /* mTHP alloc failure, folio = NULL */
  <... Interrupted ...>
                                 shmem_swapin_folio
                                 /* S1 is swapped in */
                                 shmem_writeout
                                 /* S1 is swapped out, folio cached */
  shmem_split_large_entry(..., S1)
  /* S1 is split, but the folio covering it has order > 0 now */

Now any following swapin of S1 will hang: `xa_get_order` returns 0, and
folio lookup will return a folio with order > 0.  The
`xa_get_order(&mapping->i_pages, index) != folio_order(folio)` will always
return false causing swap-in to return -EEXIST.

And this looks fragile.  So fix this up by allowing seeing a larger folio
in swap cache, and check the whole shmem mapping range covered by the
swapin have the right swap value upon inserting the folio.  And drop the
redundant tree walks before the insertion.

This will actually improve performance, as it avoids two redundant Xarray
tree walks in the hot path, and the only side effect is that in the
failure path, shmem may redundantly reallocate a few folios causing
temporary slight memory pressure.

And worth noting, it may seems the order and value check before inserting
might help reducing the lock contention, which is not true.  The swap
cache layer ensures raced swapin will either see a swap cache folio or
failed to do a swapin (we have SWAP_HAS_CACHE bit even if swap cache is
bypassed), so holding the folio lock and checking the folio flag is
already good enough for avoiding the lock contention.  The chance that a
folio passes the swap entry value check but the shmem mapping slot has
changed should be very low.

Link: https://lkml.kernel.org/r/20250728075306.12704-1-ryncsn@gmail.com
Link: https://lkml.kernel.org/r/20250728075306.12704-2-ryncsn@gmail.com
Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Chris Li <chrisl@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

[ hughd: removed skip_swapcache dependencies ]
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 9b7df8397efc..1b95e8e7d68d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -794,7 +794,9 @@ static int shmem_add_to_page_cache(struct folio *folio,
 				   pgoff_t index, void *expected, gfp_t gfp)
 {
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio));
-	long nr = folio_nr_pages(folio);
+	unsigned long nr = folio_nr_pages(folio);
+	swp_entry_t iter, swap;
+	void *entry;
 
 	VM_BUG_ON_FOLIO(index != round_down(index, nr), folio);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
@@ -806,14 +808,25 @@ static int shmem_add_to_page_cache(struct folio *folio,
 
 	gfp &= GFP_RECLAIM_MASK;
 	folio_throttle_swaprate(folio, gfp);
+	swap = radix_to_swp_entry(expected);
 
 	do {
+		iter = swap;
 		xas_lock_irq(&xas);
-		if (expected != xas_find_conflict(&xas)) {
-			xas_set_err(&xas, -EEXIST);
-			goto unlock;
+		xas_for_each_conflict(&xas, entry) {
+			/*
+			 * The range must either be empty, or filled with
+			 * expected swap entries. Shmem swap entries are never
+			 * partially freed without split of both entry and
+			 * folio, so there shouldn't be any holes.
+			 */
+			if (!expected || entry != swp_to_radix_entry(iter)) {
+				xas_set_err(&xas, -EEXIST);
+				goto unlock;
+			}
+			iter.val += 1 << xas_get_order(&xas);
 		}
-		if (expected && xas_find_conflict(&xas)) {
+		if (expected && iter.val - nr != swap.val) {
 			xas_set_err(&xas, -EEXIST);
 			goto unlock;
 		}
@@ -2189,7 +2202,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			error = -ENOMEM;
 			goto failed;
 		}
-	} else if (order != folio_order(folio)) {
+	} else if (order > folio_order(folio)) {
 		/*
 		 * Swap readahead may swap in order 0 folios into swapcache
 		 * asynchronously, while the shmem mapping can still stores
@@ -2214,14 +2227,22 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 
 			swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
 		}
+	} else if (order < folio_order(folio)) {
+		swap.val = round_down(swap.val, 1 << folio_order(folio));
+		index = round_down(index, 1 << folio_order(folio));
 	}
 
-	/* We have to do this with folio locked to prevent races */
+	/*
+	 * We have to do this with the folio locked to prevent races.
+	 * The shmem_confirm_swap below only checks if the first swap
+	 * entry matches the folio, that's enough to ensure the folio
+	 * is not used outside of shmem, as shmem swap entries
+	 * and swap cache folios are never partially freed.
+	 */
 	folio_lock(folio);
 	if (!folio_test_swapcache(folio) ||
-	    folio->swap.val != swap.val ||
 	    !shmem_confirm_swap(mapping, index, swap) ||
-	    xa_get_order(&mapping->i_pages, index) != folio_order(folio)) {
+	    folio->swap.val != swap.val) {
 		error = -EEXIST;
 		goto unlock;
 	}

