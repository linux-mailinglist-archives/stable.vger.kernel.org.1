Return-Path: <stable+bounces-119737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0439A46A40
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 19:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E4918899F2
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 18:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F15237A4F;
	Wed, 26 Feb 2025 18:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="foF0lP3C"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38718236A7B
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 18:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596117; cv=none; b=U58XMXnC02IsEKSdcPIJMUe06Eu8F9tia5rgzNX9IzAAwMRo6wBCdefFuYyg5sT6KfnJR5dCt9fIeydoKUUpg+Y0vP7kE3YF15mlf9MCTgqPrcoUFhdzswDFl4jmz6LGgqE7mXKmXT195qljVjGbZqOs9zq5BEW31UkLrkO963Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596117; c=relaxed/simple;
	bh=Sd20295/OHQnaZMcApYJTd7Cd2Wh17OwbyGl6CLOl/4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ihIYdVs7tNLwUTXWNxgnG8gMPLaE4Z8GRltEmrNwVyGbSTYeJXir6FIUG1qkyscXKHIbmxQsmQzmBV87P/uBaU1/hlq2wCDnkX8xexHpwqhJVgwewZIUG/2m0UgOVpxDdao3z1vZ9STo/HuDC94Z5E34WFhkU5riTCqWxCJ2eK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=foF0lP3C; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fe8fa38f6eso324830a91.2
        for <stable@vger.kernel.org>; Wed, 26 Feb 2025 10:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740596115; x=1741200915; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ds9BQrxGPLyNAd9raX4LmiVN9lc2UNQzgASQxqxWRTg=;
        b=foF0lP3Cr74kyUtIn44/nKFMNauhp4jTasME0Le7z+CsUlPla7NtcWrwBeGGkRjNvX
         Hapc4qPPRQ9ofync6fcNN1bssIDHMcUOB7I4/a01FBTP9H5bKYhTei/fGX3QxoUVkClu
         C5AbaZ6SbGHbvNlfR3YwFyVMmQjBA2VgRg79kSOir1YXmALhx/XFm/d3CI0lRlKEeB/B
         x3Db7sEB2EjOeXtRCFG7+95QUJwq9sQUGhrI307DtbM59iLG7G5gLTiBuMP7r+V61F2Y
         +mwjJn2NxUrpT9ohe8OSzb++syHHAd3KWE2tFyPWX+sQANnVzrpOBGp05sLT2aTjEdeY
         JXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740596115; x=1741200915;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ds9BQrxGPLyNAd9raX4LmiVN9lc2UNQzgASQxqxWRTg=;
        b=K+qIUqnOVv300DrDDtv/iThVy+u2x7E5fUFUUI+xfhqigDqIN9TgSKESaZoxJ20EvB
         5e8CCTNc40bUhn7n0ck2+JX/QizjXwiZRt1+usEVPhFZUWJphAjFruX39mZT93Ucvg8m
         Zmng7iL4t0ILxa54+70pAENWjS/oCtksCXWBw0hQ0eZLbu/tcdUXTQO/kUoRkB4oyJ2E
         MHhuBpWUxsR5GTWOW1xHVI8oT3Ul2fjb5n1qvsmkKzMu55CSm5GBL8Bh2EhwxzYCYxoE
         OX53+SxIF1Z1LePo4x8pUSJ9dMAB6e1BJnIShjYvNYikhepSLD+IofVOlp3+Ae7Tz4d0
         9clA==
X-Forwarded-Encrypted: i=1; AJvYcCUgfU8/qhm1Wo7yEhdjAV5t+kJTqkcPT9q13gpRjFX73FpnvNrvJRbe56npUKkZRK46fu3f0tE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrBWV0ml/ic1OcOl/+HIUPhv/K/E1LwnFm5MMK9ofviQgGYPVX
	UOY1YxZkCWVBYFUbEwYdr9oHM08/Ir5ZMrCD6WCmrwALBJMh4YE3yuuGaSYF/+AaSjrGBGVdFHc
	iqg==
X-Google-Smtp-Source: AGHT+IFcJCXuyF0wiZx7bOR1HEPmTXt8+rT2+rQ4qFqtP/5aygIpSvhmaCmY0HxoJ0P5eJwqc4YHPU/rkPM=
X-Received: from pjboi16.prod.google.com ([2002:a17:90b:3a10:b0:2fc:1eb0:5743])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:54c7:b0:2ee:5111:a54b
 with SMTP id 98e67ed59e1d1-2fe68d05e2bmr12186917a91.31.1740596115492; Wed, 26
 Feb 2025 10:55:15 -0800 (PST)
Date: Wed, 26 Feb 2025 10:55:08 -0800
In-Reply-To: <20250226185510.2732648-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250226185510.2732648-1-surenb@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250226185510.2732648-2-surenb@google.com>
Subject: [PATCH 1/2] userfaultfd: do not block on locking a large folio with
 raised refcount
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: lokeshgidra@google.com, aarcange@redhat.com, 21cnbao@gmail.com, 
	v-songbaohua@oppo.com, david@redhat.com, peterx@redhat.com, 
	willy@infradead.org, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	hughd@google.com, jannh@google.com, kaleshsingh@google.com, surenb@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Lokesh recently raised an issue about UFFDIO_MOVE getting into a deadlock
state when it goes into split_folio() with raised folio refcount.
split_folio() expects the reference count to be exactly
mapcount + num_pages_in_folio + 1 (see can_split_folio()) and fails with
EAGAIN otherwise. If multiple processes are trying to move the same
large folio, they raise the refcount (all tasks succeed in that) then
one of them succeeds in locking the folio, while others will block in
folio_lock() while keeping the refcount raised. The winner of this
race will proceed with calling split_folio() and will fail returning
EAGAIN to the caller and unlocking the folio. The next competing process
will get the folio locked and will go through the same flow. In the
meantime the original winner will be retried and will block in
folio_lock(), getting into the queue of waiting processes only to repeat
the same path. All this results in a livelock.
An easy fix would be to avoid waiting for the folio lock while holding
folio refcount, similar to madvise_free_huge_pmd() where folio lock is
acquired before raising the folio refcount. Since we lock and take a
refcount of the folio while holding the PTE lock, changing the order of
these operations should not break anything.
Modify move_pages_pte() to try locking the folio first and if that fails
and the folio is large then return EAGAIN without touching the folio
refcount. If the folio is single-page then split_folio() is not called,
so we don't have this issue.
Lokesh has a reproducer [1] and I verified that this change fixes the
issue.

[1] https://github.com/lokeshgidra/uffd_move_ioctl_deadlock

Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Reported-by: Lokesh Gidra <lokeshgidra@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: stable@vger.kernel.org
---
Note this patch is v2 of [2] but I did not bump up the version because now
it's part of the patchset which is at its v1. Hopefully that's not too
confusing.

Changes since v1 [2]:
- Rebased over mm-hotfixes-unstable to avoid merge conflicts with [3]
- Added Reviewed-by, per Peter Xu
- Added a note about PTL lock in the changelog, per Liam R. Howlett
- CC'ed stable

[2] https://lore.kernel.org/all/20250225204613.2316092-1-surenb@google.com/
[3] https://lore.kernel.org/all/20250226003234.0B98FC4CEDD@smtp.kernel.org/

 mm/userfaultfd.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 8eae4ea3cafd..e0f1e38ac5d8 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1250,6 +1250,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 		 */
 		if (!src_folio) {
 			struct folio *folio;
+			bool locked;
 
 			/*
 			 * Pin the page while holding the lock to be sure the
@@ -1269,12 +1270,26 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 				goto out;
 			}
 
+			locked = folio_trylock(folio);
+			/*
+			 * We avoid waiting for folio lock with a raised refcount
+			 * for large folios because extra refcounts will result in
+			 * split_folio() failing later and retrying. If multiple
+			 * tasks are trying to move a large folio we can end
+			 * livelocking.
+			 */
+			if (!locked && folio_test_large(folio)) {
+				spin_unlock(src_ptl);
+				err = -EAGAIN;
+				goto out;
+			}
+
 			folio_get(folio);
 			src_folio = folio;
 			src_folio_pte = orig_src_pte;
 			spin_unlock(src_ptl);
 
-			if (!folio_trylock(src_folio)) {
+			if (!locked) {
 				pte_unmap(&orig_src_pte);
 				pte_unmap(&orig_dst_pte);
 				src_pte = dst_pte = NULL;
-- 
2.48.1.658.g4767266eb4-goog


