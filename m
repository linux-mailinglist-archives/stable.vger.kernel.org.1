Return-Path: <stable+bounces-166805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 800C6B1DDC3
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 22:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF67580BB5
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 20:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C77215198;
	Thu,  7 Aug 2025 20:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mc66A36I"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670074438B
	for <stable@vger.kernel.org>; Thu,  7 Aug 2025 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597063; cv=none; b=J9vRJd/Oo6k2XeeSsSaSGlbNlDqee5Pvh6NKuLD2F/bqlkivB/mw83wKXVRhs3ecSaqC44Cz1bki10Pk6dudk9vDRTDof8QPLtWONospYRXCybSpgOddAABRnC9tVa+fPrMk4FqEdgL4MTF8uvROWLn7IrHXA5m4g7m5leeNKGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597063; c=relaxed/simple;
	bh=yAdVlTNcDD9pFesPs0syjVkGybrtiBA8rVOi7e+fVgU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GNyywv/e4PspD0d0UBGbozwMo6Wxlh2gwHu2pzWg9hXjXf6IJ5I6BKelgZSo+TAY39ypYJ8Vp1E1e83L6hUUFt6iXIoT1GsdDOOuDh+88Asns+gET4Pq0uiigqvqd4tDrkN8H5ipKYbNM8P6P7Mrdhq+5jXWl+5941/tk/rg4lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mc66A36I; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76be4422a36so1989510b3a.0
        for <stable@vger.kernel.org>; Thu, 07 Aug 2025 13:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754597062; x=1755201862; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LopBZLPomTxRQOxqmq+ignoUy2OT7BDqSe/zG/uSirI=;
        b=mc66A36I2r0ssqiwNNIdYzFzNVd4SVb6T/iiIBp6uOzO8gcbPuR26k64+cbzykoGrg
         ewA2mmEV5YC9OMgZigMUpLYjW0PBntStO8oQwBTs3SU2AMGmdUiF5Tplq34y5Aw+ZV5W
         Wzas7LMdtsKYRaDFxs82Z9MY53hCRkv73Mduwvsl0rIw9I4NovhueiYqTa4XKcbEaiDW
         cK23kdJoGVMfntk+yT92ytt8yB0tJdtOMDPDVEYANk2X5duTfoQWmLjb3ozaVsey2xKA
         79sR5qjx25kVVnTJMzciKAyij9qreFlTlSUoNJvC+IPDqrH0eQIvItuTHrVbmxn4YYFZ
         lv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754597062; x=1755201862;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LopBZLPomTxRQOxqmq+ignoUy2OT7BDqSe/zG/uSirI=;
        b=v9AHLw0OnNvtFsbj/4DbJ6CxbLpxNRsTjKHl2TbjZXZnA252RTiwpDfNtYBVJJGV4B
         WUP4a8gkEdDYTcHFU2OgFYCtEM5djZ/xnu2QPKP7eAZY2OvUWv/xp28LBbdqWMcG1kvW
         UePaaH/GTSVf1sOvnPfRlxLMpFmHB7/KvAJEbC/PT2wsTu4wB1g0fn0I3zyJpRm2ivrm
         xBGa3UpOkB9W4xo9wndrea/7fqP4nUiKd8RNgB422YWk4BSuhxDhniMUsMQ6bgaMH7JL
         nAkScnNviJktLx6tfR7ATKB6nSU+oM8boa1xR3O31sjSFJbZbLZv66xlNoZN8sSsv+r7
         WGGw==
X-Forwarded-Encrypted: i=1; AJvYcCWyn8vYfrLKVUcK3KyXRCpA7VUyQi8pZUtjj8wMWkEN6ufJxUJn/yZkdMGEAnEow+1EY7K2L38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQoacrjHlHExpbSO+mYrd2B96KOEQd/0dZsUR7WJ3aOkCp/seY
	6P0jamvvok+AWnhopASE6ueHKQDyI0KEa5g59P3OJRx/5I8oPlwroHZmlawVeEmpPl0tQNWxIet
	3fRojGA==
X-Google-Smtp-Source: AGHT+IFfxdE58fnJSmEe7IBG3NEKzHhTu/Wj771qmKF+e/CxQGVaBBcd11vmFgPtdAqEdHyAx5FA9bsYdtI=
X-Received: from pfsy42.prod.google.com ([2002:a05:6a00:3aa:b0:76b:dec5:1cb3])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a128:b0:23d:e6ec:5410
 with SMTP id adf61e73a8af0-240556a77cemr188540637.17.1754597061631; Thu, 07
 Aug 2025 13:04:21 -0700 (PDT)
Date: Thu,  7 Aug 2025 13:04:18 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250807200418.1963585-1-surenb@google.com>
Subject: [PATCH v5 1/1] userfaultfd: fix a crash in UFFDIO_MOVE when PMD is a
 migration entry
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: peterx@redhat.com, david@redhat.com, aarcange@redhat.com, 
	lokeshgidra@google.com, surenb@google.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When UFFDIO_MOVE encounters a migration PMD entry, it proceeds with
obtaining a folio and accessing it even though the entry is swp_entry_t.
Add the missing check and let split_huge_pmd() handle migration entries.
While at it also remove unnecessary folio check.

Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@google.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: stable@vger.kernel.org
---
Applies to mm-unstable after reverting older v4 [1] version.

Changes since v4 [1]
- Removed extra folio check, per David Hildenbrand

[1] https://lore.kernel.org/all/20250806220022.926763-1-surenb@google.com/

 mm/userfaultfd.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 5431c9dd7fd7..aefdf3a812a1 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1826,13 +1826,16 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 			/* Check if we can move the pmd without splitting it. */
 			if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
 			    !pmd_none(dst_pmdval)) {
-				struct folio *folio = pmd_folio(*src_pmd);
-
-				if (!folio || (!is_huge_zero_folio(folio) &&
-					       !PageAnonExclusive(&folio->page))) {
-					spin_unlock(ptl);
-					err = -EBUSY;
-					break;
+				/* Can be a migration entry */
+				if (pmd_present(*src_pmd)) {
+					struct folio *folio = pmd_folio(*src_pmd);
+
+					if (!is_huge_zero_folio(folio) &&
+					    !PageAnonExclusive(&folio->page)) {
+						spin_unlock(ptl);
+						err = -EBUSY;
+						break;
+					}
 				}
 
 				spin_unlock(ptl);
-- 
2.50.1.703.g449372360f-goog


