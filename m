Return-Path: <stable+bounces-210272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07208D39F73
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 08:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6E7E3063F54
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 07:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8AA2DB791;
	Mon, 19 Jan 2026 07:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7sgr0tg"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624B52D9EC8
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 07:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768806650; cv=none; b=OkBpw/+ZRkOjaWrX8lZW0DJE3y/GsuRkFADTFGCHuv7R5PYihIGxNxxh7W1OiAkArkQq2MaF1ECZhSMOW5xWEaloW6oS6cFu4Cr/5WWFM6n2ZMqY8nPL+tBw0v+MdNohswePMSDxYM1CjpLwzdcNQDeSFqmfte/68dIfvxoM1/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768806650; c=relaxed/simple;
	bh=S3Y98FFWgoY8a3pcnPVFBrL19HFaL0F70zFtuxAOCe0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=isx+LA34EqBs+w4eC4CreMv5teaWEy5UVYEyL1RlNGaqmweLetlF5gVLtkjVo8dPVYQhIxLfQx/S8fkSCLdl3Ck2ugzGDvn3FQh0m6BqwlhVce/T6szH0chuZ9pRjCYC1C0ATNlUj5ZVmrtGFuTrLvDM9uBePic4cXy6BA4v364=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7sgr0tg; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-888bd3bd639so47280186d6.1
        for <stable@vger.kernel.org>; Sun, 18 Jan 2026 23:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768806647; x=1769411447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gKM15vI5ObaHuQbAnvaLHXhQIMY9SS6X3bJEvEg+p4E=;
        b=M7sgr0tgEqxU85NZwJXA0fJ7ksaOXe6UK4eRTS1rsoNH5NYiD/ICYEV2fV4Z2JLz6l
         Zk4FHXMO3n7O612o9SENbGsWzYCqdU6ol8hUShUZB1aNN3m3oviyUIPufkPTTwJ13121
         RNHk7ACCZ2/tZrhcbqAH0QRRqpwYZCjjRMkWLwymPK3K2jfIw5uyGLj09Gq869sDSR8/
         8M81UMFqjq0CaeHK6jvN0h8hMq1wIq9LTga5offRTuTcCWgFwmjM/+vsGKHOO/Z23EnB
         +3N+TZO/YzgbAgsiQ+gTZDggeHAy4xD3kRgVlUK6/mIyLbQHJfivjL+BosbRvxibvVfs
         Y6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768806647; x=1769411447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKM15vI5ObaHuQbAnvaLHXhQIMY9SS6X3bJEvEg+p4E=;
        b=U3kCpYufNv23idkLi4mynkMTqby2LYeiLEkYgbDCLzvomXVVBoCZ18ciAfIEYI97OF
         MxkiHaehwTGRhqw5Ntr3y2wxBPSwoE8Ptih6xkJIy8NyTGUxILgsF9kQmwM2iteDA4bG
         64CqSq1ey/Splb/Sl5RJMTpFmyKPf624XGXhRVLlgs4qhwLy6UTy0R8oic5nd3uZlvJP
         5rersQgI1/w8AL1tnw49Z4QMGU7gxlsatbGs+5S89cBTZX5eZBKAqQ9duBgPdrTmuKG+
         LbM9vhIrlS/MDCplVXHT1ASO/H2z53Q5ruO6qnHxACOHnrUpdaxxyxur0TSP8dM7hkN+
         DXiw==
X-Forwarded-Encrypted: i=1; AJvYcCXJCDzbPmMYNCPV5whAjAUd3U+i5fSXHnhi0/QCEwA6tJWAVa2BTWKWnry4TsxWje86YGYJOuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0tvLZ4MGSg8OViv7DN1Mrcq+7WCRUF9acgmRVDSqcux0MuoRK
	LRnbslFFc/M8JcyPeoqA5gFQ/1vkrDVg8sBfNP2CfvnFk1aABDP8JqZm
X-Gm-Gg: AY/fxX7Ca+BbY73lPdGDtYMtQAQB3N6NcWxIFFhwpYBuyZh5DohtWRQHjlfrLNVhKRe
	6cvGp3x+w9Q6p1OIP+1u/uE4El+uE83VDVOVz4sXUYrKPioAZwntwiYcw6slmVN7PSJxv+3XTe8
	jiUK8dKRHw7P05zez6lYvezbgTSuQsL93s75bg9fPTDeXZn8J33KbKU2udsRWEIBwVgHU6aCbB5
	gelIdkc28A43KX6AJZqwabhyP8qLvMFk5nY6mk3idisE53ZB1QTV4cp6/ERnaokxt0tPOztBI0C
	xwvcg8RbB/aGWVpjmznBFE1pjrG3kNZLaSdtejJB1pioKDnTu3whR4+k+Qx/VeFYP72d+UIUTTO
	nRihzeP6rmx4GvCF/AnhzgcNduPC+THmHnIB91t7atL0T0hjRP0f5Gja9b4g1CIgWcjmb2oXYgh
	bWRo+HsBmluwPS2KY/Av0FIbQF48c0cuAZ1s0aHQ/KBwFNmbp00jyMMDLWx5Pem6b+O9m8EwZLR
	miNo/kkUpO05Rg7Rdbs37nKJA==
X-Received: by 2002:a05:6214:21ef:b0:87c:19af:4b76 with SMTP id 6a1803df08f44-89398144853mr211893076d6.17.1768806647373;
        Sun, 18 Jan 2026 23:10:47 -0800 (PST)
Received: from abc-virtual-machine.localdomain (c-76-150-86-52.hsd1.il.comcast.net. [76.150.86.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6043a6sm79024586d6.18.2026.01.18.23.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 23:10:46 -0800 (PST)
From: Yuhao Jiang <danisjiang@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: [PATCH v2] io_uring/rsrc: fix RLIMIT_MEMLOCK bypass by removing cross-buffer accounting
Date: Mon, 19 Jan 2026 01:10:39 -0600
Message-Id: <20260119071039.2113739-1-danisjiang@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When multiple registered buffers share the same compound page, only the
first buffer accounts for the memory via io_buffer_account_pin(). The
subsequent buffers skip accounting since headpage_already_acct() returns
true.

When the first buffer is unregistered, the accounting is decremented,
but the compound page remains pinned by the remaining buffers. This
creates a state where pinned memory is not properly accounted against
RLIMIT_MEMLOCK.

On systems with HugeTLB pages pre-allocated, an unprivileged user can
exploit this to pin memory beyond RLIMIT_MEMLOCK by cycling buffer
registrations. The bypass amount is proportional to the number of
available huge pages, potentially allowing gigabytes of memory to be
pinned while the kernel accounting shows near-zero.

Fix this by removing the cross-buffer accounting optimization entirely.
Each buffer now independently accounts for its pinned pages, even if
the same compound pages are referenced by other buffers. This prevents
accounting underflow when buffers are unregistered in arbitrary order.

The trade-off is that memory accounting may be overestimated when
multiple buffers share compound pages, but this is safe and prevents
the security issue.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
Fixes: de2939388be5 ("io_uring: improve registered buffer accounting for huge pages")
Cc: stable@vger.kernel.org
Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
---
Changes in v2:
  - Remove cross-buffer accounting logic entirely
  - Link to v1: https://lore.kernel.org/all/20251218025947.36115-1-danisjiang@gmail.com/

 io_uring/rsrc.c | 43 -------------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 41c89f5c616d..f35652f36c57 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -619,47 +619,6 @@ int io_sqe_buffers_unregister(struct io_ring_ctx *ctx)
 	return 0;
 }
 
-/*
- * Not super efficient, but this is just a registration time. And we do cache
- * the last compound head, so generally we'll only do a full search if we don't
- * match that one.
- *
- * We check if the given compound head page has already been accounted, to
- * avoid double accounting it. This allows us to account the full size of the
- * page, not just the constituent pages of a huge page.
- */
-static bool headpage_already_acct(struct io_ring_ctx *ctx, struct page **pages,
-				  int nr_pages, struct page *hpage)
-{
-	int i, j;
-
-	/* check current page array */
-	for (i = 0; i < nr_pages; i++) {
-		if (!PageCompound(pages[i]))
-			continue;
-		if (compound_head(pages[i]) == hpage)
-			return true;
-	}
-
-	/* check previously registered pages */
-	for (i = 0; i < ctx->buf_table.nr; i++) {
-		struct io_rsrc_node *node = ctx->buf_table.nodes[i];
-		struct io_mapped_ubuf *imu;
-
-		if (!node)
-			continue;
-		imu = node->buf;
-		for (j = 0; j < imu->nr_bvecs; j++) {
-			if (!PageCompound(imu->bvec[j].bv_page))
-				continue;
-			if (compound_head(imu->bvec[j].bv_page) == hpage)
-				return true;
-		}
-	}
-
-	return false;
-}
-
 static int io_buffer_account_pin(struct io_ring_ctx *ctx, struct page **pages,
 				 int nr_pages, struct io_mapped_ubuf *imu,
 				 struct page **last_hpage)
@@ -677,8 +636,6 @@ static int io_buffer_account_pin(struct io_ring_ctx *ctx, struct page **pages,
 			if (hpage == *last_hpage)
 				continue;
 			*last_hpage = hpage;
-			if (headpage_already_acct(ctx, pages, i, hpage))
-				continue;
 			imu->acct_pages += page_size(hpage) >> PAGE_SHIFT;
 		}
 	}
-- 
2.34.1


