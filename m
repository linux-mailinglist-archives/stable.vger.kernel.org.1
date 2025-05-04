Return-Path: <stable+bounces-139561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C78E4AA8629
	for <lists+stable@lfdr.de>; Sun,  4 May 2025 13:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB751770C9
	for <lists+stable@lfdr.de>; Sun,  4 May 2025 11:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5BD1991D2;
	Sun,  4 May 2025 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W6PIrqvJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A546C14F70
	for <stable@vger.kernel.org>; Sun,  4 May 2025 11:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746356826; cv=none; b=t3OSt7NG3PSG2/XvZQ8qVcTUrhTUaupjxRzy/E5zqJomhviWi4v74KSDL8EhTd3jsh8G8lcZNzyQ4aFf2K0/kopkf1DMcpe5cpf0L4Hrg7FymKtew3umZ2FXGMogj+n+DozMwku/ktasACSF2TiBcD4lrSuBlmVxKmk9l8ycP2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746356826; c=relaxed/simple;
	bh=0VERiJMgiwI6jFZ9ISp9whJpzgJBTRB3apkw4FkBNmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BAd/xcLfwhw9GWVHBE39NWdOcMbjCycF5nzytfEhKIg6rLDH8VwZSN4vc3wsdyFmcBirFiUCOo2xczaDsIiFOCh4xHEMmEX6q854YVHo2vURElCAXHng3lZUebtOsj7l3hj+jqVHUs/q/vr4lhcTp/OGQ68s3d89ByPix5dphcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W6PIrqvJ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-30549dacd53so3017387a91.1
        for <stable@vger.kernel.org>; Sun, 04 May 2025 04:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1746356824; x=1746961624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/pI9Obv7HIXjCZcC433R6qPEf3axp+1OaRirOCKBrC0=;
        b=W6PIrqvJdZxZzEbP/hFZ3QwQ58Vq8C96zq8P7+p0gBjGVizDfXh4L2jVb57LpHw0II
         j9pB6tyzGiW88NTYirw4vQo9fuufjSCToPunJdhCVP7ih855vVAnYLMUi1ninQYvGtvS
         QIzSfoXJr4rLHxf4DPhEL2hvn3P82bFEQUMDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746356824; x=1746961624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/pI9Obv7HIXjCZcC433R6qPEf3axp+1OaRirOCKBrC0=;
        b=O5fFHnlF8DMdVdwkzwz+iFYgRIrwCwX4VVZlH/v2X0Sh9+m5wkT1Afn7nNrJzPdgw2
         oB/edrCyp0+SsHFK0fKN6a/ado/Qq1L8gOdkomfSwMlC08Gfsrr4LRGw7eRrjiGQgFIS
         Sm+wMRdGlOMu0sNEZe8w+g0c2wV3r5QgzErLw9S/VjFodAwrs+fKCxnATj7tdhWJFtG5
         pnfdq4MhgPETvIaG7eakYA1C3r5rQt7A6nlrYYjKQf6HAC7LDd9X1fgLowQjnuwg8vtU
         ldhC+g9cuptN5MasC45WOMVgkraQvZbSbeJEYgF1yX4Qmil5nJjcC60HRH6XFYeisaip
         ngiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLbAaOq2UkLx6I9Zr1l0e+HtLjqvAM1RgnCe4jZN8heJAyu4V8i6yj4Hgz5rgyTs+VRR0Mx2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyotyX8zPhRVlJCp2v4rYnR4wafxykLzzSYh+ARIdEwsOVJHF0z
	vliexcjZQBWCIXaOEo8BZl5qUeYIVVkWHm3sCaO3898T3HOqOC56GrJ1voHXOA==
X-Gm-Gg: ASbGncshcjrBHw+cmOWt5YLVU7gT//5kzjIZy7GosOxjJzIZK7ilRDAegJJSUU/uKtX
	4CceQatJigiSPUj1m+2Yv5Rtr1qX6MuiPmYHkKwazI7LUkf08M0UpiGSD05lHV5+HkurEAdXF3Z
	FLsK+wtQRu2tsjv2CrkhWQ3Hxb5dTcQM98jihTE6gkY6Kylv7kXYzppXCfT60Z6Fj5XkscRaRtn
	T1rlvcAdip0SUzdVICiZzQbi2nml49AHIPDq7jUYfBQIYmejkZA5ncDyXtQOk//HH/MSZUP/OCL
	7oPpvBN3QUnxI5zqPweHP18pXigXr8vEiy50gerH+lBlg0KNcpicxLJK8F1S69MSaYE=
X-Google-Smtp-Source: AGHT+IFlS4+lefR+0LAoamLgv5CoWQCVZEeaRDI30l0lwLe1UVce2xjnxOQ2Kr4rtaaHpkdhR34kEw==
X-Received: by 2002:a17:90b:5247:b0:30a:204e:fe47 with SMTP id 98e67ed59e1d1-30a4e238283mr13971701a91.16.1746356823799;
        Sun, 04 May 2025 04:07:03 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:c979:b45c:9e0c:bf77])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a3480e9d4sm9273491a91.36.2025.05.04.04.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 04:07:03 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Vitaly Wool <vitaly.wool@konsulko.se>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Igor Belousov <igor.b@beldev.am>,
	stable@vger.kernel.org
Subject: [PATCH] zsmalloc: don't underflow size calculation in zs_obj_write()
Date: Sun,  4 May 2025 20:00:22 +0900
Message-ID: <20250504110650.2783619-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not mix class->size and object size during offsets/sizes
calculation in zs_obj_write().  Size classes can merge into
clusters, based on objects-per-zspage and pages-per-zspage
characteristics, so some size classes can store objects
smaller than class->size.  This becomes problematic when
object size is much smaller than class->size - we can determine
that object spans two physical pages, because we use a larger
class->size for this, while the actual object is much smaller
and fits one physical page, so there is nothing to write to
the second page and memcpy() size calculation underflows.

We always know the exact size in bytes of the object
that we are about to write (store), so use it instead of
class->size.

Reported-by: Igor Belousov <igor.b@beldev.am>
Cc: <stable@vger.kernel.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 70406ac94bbd..999b513c7fdf 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1233,19 +1233,19 @@ void zs_obj_write(struct zs_pool *pool, unsigned long handle,
 	class = zspage_class(pool, zspage);
 	off = offset_in_page(class->size * obj_idx);
 
-	if (off + class->size <= PAGE_SIZE) {
+	if (!ZsHugePage(zspage))
+		off += ZS_HANDLE_SIZE;
+
+	if (off + mem_len <= PAGE_SIZE) {
 		/* this object is contained entirely within a page */
 		void *dst = kmap_local_zpdesc(zpdesc);
 
-		if (!ZsHugePage(zspage))
-			off += ZS_HANDLE_SIZE;
 		memcpy(dst + off, handle_mem, mem_len);
 		kunmap_local(dst);
 	} else {
 		/* this object spans two pages */
 		size_t sizes[2];
 
-		off += ZS_HANDLE_SIZE;
 		sizes[0] = PAGE_SIZE - off;
 		sizes[1] = mem_len - sizes[0];
 
-- 
2.49.0.906.g1f30a19c02-goog


