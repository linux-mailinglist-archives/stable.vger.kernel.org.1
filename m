Return-Path: <stable+bounces-146437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 802FBAC4FCD
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 15:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E781897751
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 13:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57172741BC;
	Tue, 27 May 2025 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="24PigdeB"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5C11957FC
	for <stable@vger.kernel.org>; Tue, 27 May 2025 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748352782; cv=none; b=b76MjYxIIFAW189+49VhYUpZ6fhC2sI4lV7xMaXj4Nt219OSEOy7I2RnG8neE1k3mokUgIUTmExQyfzBAOUirey9rKc4U2KLSO3ySEupEiNmgWwTPvVieGqVvyenB4pRfAyV1VmvMK2HLWpBTZk9BEX07HC6IeM/oNZ4IoDQc1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748352782; c=relaxed/simple;
	bh=Ta0o493G8dZQ9exOXUgb0qjqzgnesEWUiLmRzB7kuto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSqxBy5cS+EhIj6unsQ9Mp2k/GVQ4n9A3NVsoh/kCZiVxJoLQqhUFk0AvK+E7X4tJztSYbQaL2uzqMenTKs8pYTd5VkH12WeFZjh9eVsEpAmEX2pZ/jT1svyfKluMtqbdBIyFxbwKNWkUg/lfL+kFvnTrr+pDmnLdcizyDnAJo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=24PigdeB; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d6d6d82633so9344495ab.0
        for <stable@vger.kernel.org>; Tue, 27 May 2025 06:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748352780; x=1748957580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ebJZEHhwjhHTIP/mcxILxjWWkcG3pg6+COKM6quTvE=;
        b=24PigdeB78/rqeekF24/pKyUXiXfsjz/BXK7Rrax5/XRQy7SBj+Y1TmILoLtrqXYYW
         Miru/4xjzGEBZVcAC91OJjj6VdegYkE00RyXJVj8a1wmIIRklobiunSL0wfCZ8uHi5l5
         fGbyqy/IRnXc1JZSJ/InLt6rD2pkwLwHHV0f1e3TmKHngHdcIZVVCd3ovLgWiyPsKRyq
         f+d/ehwl+RkAZyx1jf11X+3gN0/DFnIqKl5LGVuZCMj9HuUtFfP4c6arkV+db+2HKgA6
         1DFSV0X8js6zxlbyriXPGzAUp4vjFtO50+4lgs431oBI8xNqRsvNC050rgo7pB2mAMU/
         B4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748352780; x=1748957580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ebJZEHhwjhHTIP/mcxILxjWWkcG3pg6+COKM6quTvE=;
        b=o0KU7+OiKJpI0jGnCR+szP9g1JWAWEqDUon2bA9vLOifIppq4KrsRvM0e4wM9IFSR2
         /pqWwLBH0v8cJnx3AH4bB55QidMFYUYnF0Av+0XINn/L9bHwTEMqRwjvhK5WzJyyvjG2
         CHOKlXq40AaLWASLLkFkw6T8gr+2QrsqCmzS55EbFAMPD6vJ6bg8D+F+7xknpAXD2kR8
         HE0Mqymnw4E/wi3fRS48Cc3UsNuEmNj7CNGC9H60bQUvC9j8jfIyVjlr2bEBCldExWn5
         Tq6mhqiqsiUmFA92opMvdHAWaiUINRdkaY8/F1Ykz77ihdskhKMwmm5OwK/OwJZqlIIi
         XQPg==
X-Forwarded-Encrypted: i=1; AJvYcCURFU68pWCUIgw0JNEvXXibunyAFPg8oTLTw9NERoalD9wYAV61goYj+mIl/QfRta43MNd7olQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGflZlgavMpYBtOXXQTr7Zg3ICd429Q6TzcCvc0Ch5/2fceLvL
	R7T1PP0AOcAx+SgmIrYKGRs/mjM6pwX92i3rSCAg3J+Bs2fXezdWe93IaHaSnbgV/Ew=
X-Gm-Gg: ASbGncuhAC7pK9MYJViZivruCO/FT1tFFAtBp6njF5Hh1w7dSPCI5scQbQz4MR/yN81
	CDQFiWJm2jq5wlVk2c0qkH7z7fHsGY71x+tx4QFeMmbMAgu2QGCt3Ae1yjyT+Ggfm/oH49XJrtT
	eGPVmjEmjv6UswRzouTS0iiomYztnc0RWmQdUtOzYPzRFZqqHWJ22Lhwsg6bT0YDAreL2ZVPJso
	r9/Rokxsmq0qUnbDeOW0VGShoYF5ajdRMXgGRvewEeweSO2bLHlRaN3w2aUtnJ4TiMbd2HtMVs5
	BdvoVhvIDZjhk+GlBYxc8Mr0QjkKazLgla5Msa825xbnEdVmFPkgHfw=
X-Google-Smtp-Source: AGHT+IFp/X/5UUpH8g2DOmyJ2V3xTfVbLCQ8ySA0o44nnZboGRt19eNfMW7odE8piPyYyqztlkpc6Q==
X-Received: by 2002:a05:6e02:164a:b0:3dc:8e8b:42a8 with SMTP id e9e14a558f8ab-3dc9b70f7e8mr90997545ab.16.1748352779941;
        Tue, 27 May 2025 06:32:59 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc8298d8a2sm37404315ab.18.2025.05.27.06.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 06:32:58 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	djwong@kernel.org,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	trondmy@hammerspace.com,
	Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org
Subject: [PATCH 1/5] mm/filemap: gate dropbehind invalidate on folio !dirty && !writeback
Date: Tue, 27 May 2025 07:28:52 -0600
Message-ID: <20250527133255.452431-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527133255.452431-1-axboe@kernel.dk>
References: <20250527133255.452431-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's possible for the folio to either get marked for writeback or
redirtied. Add a helper, filemap_end_dropbehind(), which guards the
folio_unmap_invalidate() call behind check for the folio being both
non-dirty and not under writeback AFTER the folio lock has been
acquired. Use this helper folio_end_dropbehind_write().

Cc: stable@vger.kernel.org
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Fixes: fb7d3bc41493 ("mm/filemap: drop streaming/uncached pages when writeback completes")
Link: https://lore.kernel.org/linux-fsdevel/20250525083209.GS2023217@ZenIV/
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 7b90cbeb4a1a..008a55290f34 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1589,6 +1589,16 @@ int folio_wait_private_2_killable(struct folio *folio)
 }
 EXPORT_SYMBOL(folio_wait_private_2_killable);
 
+static void filemap_end_dropbehind(struct folio *folio)
+{
+	struct address_space *mapping = folio->mapping;
+
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+
+	if (mapping && !folio_test_writeback(folio) && !folio_test_dirty(folio))
+		folio_unmap_invalidate(mapping, folio, 0);
+}
+
 /*
  * If folio was marked as dropbehind, then pages should be dropped when writeback
  * completes. Do that now. If we fail, it's likely because of a big folio -
@@ -1604,8 +1614,7 @@ static void folio_end_dropbehind_write(struct folio *folio)
 	 * invalidation in that case.
 	 */
 	if (in_task() && folio_trylock(folio)) {
-		if (folio->mapping)
-			folio_unmap_invalidate(folio->mapping, folio, 0);
+		filemap_end_dropbehind(folio);
 		folio_unlock(folio);
 	}
 }
-- 
2.49.0


