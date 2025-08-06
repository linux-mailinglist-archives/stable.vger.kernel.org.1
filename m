Return-Path: <stable+bounces-166714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93460B1C8DF
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 17:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73FF018A161B
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 15:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE03291C1B;
	Wed,  6 Aug 2025 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0zMuj7od"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583B019A
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494820; cv=none; b=er/BrR7YwcS5CbjTQHYqW7RUzBkWXSC1R1q3SJHiY9pDcVgCupsopE2NGEjBjqfqM1Pfe+1yN6zmnGF0TKwLkXo86DQwj5kRdMYYus8CN+yWpmjMMa+PNmNF7eoqfa5J/NDiRfXPV5ngwZsGRVGkAQ9D08+3AWUg95fjLDfJk3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494820; c=relaxed/simple;
	bh=YKmeLfJVeftgXNpU/CCjjFjhzT4YXi3X/6DOHGjU/QI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=to+Nlyw2Paoq1Wj+sCZRNgu5mMoaFw1941TdyJDo5glcJlfSsnOVO1uJ7+9ry6XCBrbPR4XkvmC75ShmsufrIujtKTtLX6ZSFUk1WqXvWpKmV3MZb3IzHLJKyHoyBlWmY/uML0JEMg52pWVyi8IXEeXqzDBllshbpLRFEuJTwDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0zMuj7od; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2400117dd80so48357035ad.2
        for <stable@vger.kernel.org>; Wed, 06 Aug 2025 08:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754494819; x=1755099619; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/rcbJP9GsUTVLgzIeF6EjF73i2MBiTUObyAO9IzHFJw=;
        b=0zMuj7od9xgDueMQ7xT3ACgyG+ve2iB/nq+gjnhlF9ZcJAWS2oDHdbdvDhzSODyfCM
         WeQaYN4ycd/9vh4i3Xc4h6GGYwpSoz6qVRS5QVcS3lx6DXxUogt6M4+EuOnvPzcpzojf
         1OViMSV96/pSQKRFRtGHObq8wieGk8jIU7XmeN2vdIi34SNQVTC+WQOfPewAfm2JIgxc
         HQRcyQMzHXFSkqpK9SU7hI0znJM91KMJf/GaW6PMI10rdaSO3NrOwGKxXQ+UB/+T4wH/
         hn4WUPxCGR16qZao5hhOBvNazPvTgyitlRmN3KHq1VOY91iMHwABcqW5kj9YONS0OccX
         nRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754494819; x=1755099619;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/rcbJP9GsUTVLgzIeF6EjF73i2MBiTUObyAO9IzHFJw=;
        b=axYvViRwJkNc3sVqV1fyvVFmN41d1Nq1ksi3P6JmNFu0cETkZ5lIsnyJHANRNGRUZe
         sg6CHp3NPU2GRh97tKwcjfnJbPTvvIUnKtwgUxiE6vCtssLOfv7MpRrj5rrbdK2pl/NE
         YzlyN6lrZw7SBnK93pgv//u7xEJbBWmIsxG/e40O2zc1Mmpk5WuzKQj6RVUC/W5FT732
         nTaqp9NFXZINkVonlbPEoBxFZ4wlBSZBL+f/MP9utyU44KFn+7A3sGjD307ysrO+kTLu
         P9creo5xnFHqem0fhYRW9Smaioar8+fblPZt30MJ0By7K2LRgbHe2sVUqDdQ47ki12cQ
         t8bA==
X-Forwarded-Encrypted: i=1; AJvYcCVRUN/whYkzOtr0XRwjHCrnhs2UTAIeW8TrWhMU4gP2GfWIALNfYL9Yx6mk6wD+sWo0uxPpB8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4T+584xph9opwSsTNT2ZPeugaiQP9doKNi8EV67LCEHu4A5ia
	lR1CUk7lfdfFPe1uR8ga+lHESh6iipNdiT1/rcJvJwrlsnVMda6X4K0uJqaPBS6eLjl0ksvjZOF
	bZqDsKw==
X-Google-Smtp-Source: AGHT+IGi3LZt6GUnUZOPcAyMejp52TBB0RjJh6S5HK/q7683T2GfXcCeCP9l0/WWit8jiCrja5/iLHKI5zY=
X-Received: from plbko5.prod.google.com ([2002:a17:903:7c5:b0:23f:e9a5:d20a])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f70e:b0:23f:fa2c:3aff
 with SMTP id d9443c01a7336-2429f5adf47mr38827855ad.52.1754494818714; Wed, 06
 Aug 2025 08:40:18 -0700 (PDT)
Date: Wed,  6 Aug 2025 08:40:15 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806154015.769024-1-surenb@google.com>
Subject: [PATCH v3 1/1] userfaultfd: fix a crash in UFFDIO_MOVE with some
 non-present PMDs
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: peterx@redhat.com, david@redhat.com, aarcange@redhat.com, 
	lokeshgidra@google.com, surenb@google.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it
encounters a non-present PMD (migration entry), it proceeds with folio
access even though the folio is not present. Add the missing check and
let split_huge_pmd() handle migration entries.

Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@google.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org
---
Changes since v2 [1]
- Updated the title and changelog, per David Hildenbrand
- Removed extra checks for non-present not-migration PMD entries,
per Peter Xu

[1] https://lore.kernel.org/all/20250731154442.319568-1-surenb@google.com/

 mm/userfaultfd.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 5431c9dd7fd7..116481606be8 100644
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
+					if (!folio || (!is_huge_zero_folio(folio) &&
+						       !PageAnonExclusive(&folio->page))) {
+						spin_unlock(ptl);
+						err = -EBUSY;
+						break;
+					}
 				}
 
 				spin_unlock(ptl);

base-commit: 8e7e0c6d09502e44aa7a8fce0821e042a6ec03d1
-- 
2.50.1.565.gc32cd1483b-goog


