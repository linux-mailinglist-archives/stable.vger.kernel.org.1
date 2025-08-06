Return-Path: <stable+bounces-166743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F11BB1CEDC
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 00:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E5618C654A
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 22:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10B621CFE0;
	Wed,  6 Aug 2025 22:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h4/y6t/s"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0D5E55A
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517627; cv=none; b=fPLz6Lw7TVt0RiMVbrVzF5gJCpjatTHH5bZtK0xH/ZPm8aFxYPbMOV2tssqXtKHkqrNc9mcbR/th2iPurxvXRnwaYYthQOv5xbXSBSETtq5bsxbz0BDj0C4vB34o7JTLXfq71difqtNTp+8TgG75TX4aNECBqs9yeIkZWdjhZAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517627; c=relaxed/simple;
	bh=5lOaVPIox90EtPwO5fOrQolK9YVZjng1IH3ugUBN0Nw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fFqrlJgzmi9Uviy0kzIFKOcJpZQ1wmuc4vWbv9wIMtbwh7C3fJoTLMosUniFA9AG+uueiW0D3kOUbZNl09sadfehd3VT+u4rCWCZ0ULY6nXwrVyGXci+g2daPTMD1822JBtVNRBRFrGIFHEofXQJuKcbSy9o/7q783U0rDI1/AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h4/y6t/s; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c37558eccso231362a12.1
        for <stable@vger.kernel.org>; Wed, 06 Aug 2025 15:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754517625; x=1755122425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0DGq3Zp4fJ6DZNHeIX2b5x/XDF+UYujZX+55RuFP5IM=;
        b=h4/y6t/skR7JP+Cp9WK/W7dx276vx6bPQvD4bSWg8UwTfwKsnZFu+PVcmH1Z7h+miB
         MoIZz6gXvYESgR0G+WZ3tGWhjUJPHE1tCsSpmy5YDRKRQzqUOQ6jabsgcpHU33mY/OPm
         0ZfGku4CQSRDHyN5Vsk9gQnY8dxS0w/oduiuKrk/VjR0ARzgHNtZdyTiRV5FEy8LCB6x
         zqBMj+j+ypGPjehE0SvUITJTiG8UDqCTKr49n3xNiC22n14AkH17xBdETk5aBI9MytSz
         MN1qQgKkzmDQeE3ojMlnTkC1nbl1l3PNidWv8fZQQ3HvEWkw7SxcENExvYvHXAvOeGfA
         yelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754517625; x=1755122425;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0DGq3Zp4fJ6DZNHeIX2b5x/XDF+UYujZX+55RuFP5IM=;
        b=jbSnMURNwxrxDvn5m0qy18fv7V4E5EbmazmslytfZD1NuKnJqiAIVbe53LV6t2hqTQ
         pyjeSMdC4oEl+w5C5SqOpeIw2JQ1r5koJCuTeH7cUQLx7LCc6HAnklAAQqKvJo5rds9m
         4f1/UIB5Q328gRa4fG7zQKS51bk6PEZydTzh/WCkLdfRvxCwz8hIXsRdhDHXrBCytb0s
         9xW03AX00hXByEt8FG8n8zJvMZ6LG3lqKJIFaxzQ5ysC2ZozQ8AXzhKDnvquEaCTkDTC
         2xiYT40vtplMrhnPdFov1BALlzMttoewvB+vjmCtTNsHME8HwAXwGG+x82HGAJJX9ijU
         uhDA==
X-Forwarded-Encrypted: i=1; AJvYcCVmbJdLIf20hmZ7cttC2rMEanmcH/JhHgiXoS6RLSfbcqcMCuw+nqnXgUCr77Y6Bnqt8ichxzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSDbLHr3uyNfVLQiIvGBuHix31tI4SOSkir0W6fErynDGtrNLX
	0elIuLKaE4MmZmQh4Ni7n9RG8zvhBt468MYuxf9JdnlaSt8N2KIjzlM6F45yshJLkmF5cqD8wz7
	Gbw1Ewg==
X-Google-Smtp-Source: AGHT+IEgXVgvOPOZLzpUU0uxEIMp34b7pNlfgpNcH4fA0yFqf6+H+2ZoRWuQLabxen09rQvlDcn4hw3n9b0=
X-Received: from pjob20.prod.google.com ([2002:a17:90a:8c94:b0:31f:a0:fad4])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54b:b0:240:8f4:b36e
 with SMTP id d9443c01a7336-2429f30a072mr61870205ad.34.1754517625374; Wed, 06
 Aug 2025 15:00:25 -0700 (PDT)
Date: Wed,  6 Aug 2025 15:00:22 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806220022.926763-1-surenb@google.com>
Subject: [PATCH v4 1/1] userfaultfd: fix a crash in UFFDIO_MOVE when PMD is a
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

Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@google.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: stable@vger.kernel.org
---
Changes since v3 [1]
- Updated the title and changelog, per Peter Xu
- Added Reviewed-by: per Peter Xu

[1] https://lore.kernel.org/all/20250806154015.769024-1-surenb@google.com/

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


