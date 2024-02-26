Return-Path: <stable+bounces-23774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D71486837E
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 23:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE6D1C22615
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 22:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45FE131E2F;
	Mon, 26 Feb 2024 22:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CHgg/k3Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08028131E21
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708985422; cv=none; b=NYOjZk4uOs476W3e7+JDSWTCOTasmPV1Wz51lortTH6ShTosSvVAx0F4OiKEURT/Q5aP1arUwy1ePjWkKnsCb9qrPaeb0Fsl/akSQPC2FMaOIgs8TsYu4ZDtf39yOV8kCKT1c//BvVOZHcISgeglk0y6q70uToBuZ9LkBzXvSD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708985422; c=relaxed/simple;
	bh=PyTT3VI/YpVMJtPmUCJ8e5edoNcCiL3yZpsFchkMDIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n+FUviCBlBs/NZCbtx8c5cwEji0T5t/HhGONzepgWee7Pme8Pg1Hq59HSD6x8gDRiRbjOo7+8PpaPmS3pajSt/UxLHGBHv0eK+5gaejOZjnGDav1r1D0czJHNGhfEEouIlcyT3LT1ehlE1dH7wlipBOPYPc5dTmhNZovZdkVKVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CHgg/k3Y; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6087ffdac8cso54169477b3.2
        for <stable@vger.kernel.org>; Mon, 26 Feb 2024 14:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708985420; x=1709590220; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E2dE49aR1EZ+/UQvJfZcmpYRYeuSVrOUnf6pun/lGUk=;
        b=CHgg/k3YaJVjJp4GCLpMFwS8aCWQwh58yi7yru3CvsT0wZNeshnv2xwW4ddvPy7ioC
         +Bl6YHcT6AlU1kp6PxeXbvZkF3TIZC8aQiWOg+sz/IWqfxKC5qnEqWymNgw/42+VzDAf
         MhpTmawQ63wCJOtWWcbCjr3Ou/CfoQOGLJ2+QvqccZLdMEW9h6BoFMHaFp4pGdmfqByl
         OzSrXs5AuUPN9E7+Ab+ZOBEc2plaerxfWUNL6h2EXZomJdohFdH9HwbgVPXTxb3f75Ke
         StYhteOTD1O9b/4edTiJAJP++nZLxWDI8rm7NEz3rTmELpmNwe76THdx6OXrwqxHOamS
         G8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708985420; x=1709590220;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E2dE49aR1EZ+/UQvJfZcmpYRYeuSVrOUnf6pun/lGUk=;
        b=g/Yr40WIoxwuxO6iLyjWGXfSTIMXHZhz26bxpaAEjWdbBJphqULwdOUUiIlJyj5Str
         yxAC4FLjv+Zw6eMTw95We/P+48KypoSAiVTSuD5nRurlpskyiMB9i4629YDsr/GjfBcy
         L7ojHfePHu6Qxe5jiDbdLVOBaaaFS9ph8EUPGjbAKk7B6nF134JYhElDMHYXv2IFKgPB
         OTk7EAHDF9B45UVFJSW0K/ZMrCdXhITHxBtvUKDb6GVpl7SPh/bTawrlZImtGodR2Y1V
         d5PSiCmFjgXR7doyHb1As5c1RLOn8QZ7ANH0Lhzaof8rjzU4ZT8+Zvr82/SVXurOZh9y
         uU2Q==
X-Gm-Message-State: AOJu0Yx4DrxBQrYkIbZYwJVSENqtkzV4LIkvJNlcfJNgK5EejDDt9BeO
	p4VP96a6pIMEIyi7yvsxBF0U9iaQpCaxuVJPZEUtMiQ8WkjAAidbqvQn/6rnSNPKajmZC7Ew91s
	aAVjhMi+4HpHTjSzgGipNaKAV9apKjPohTnQkQtrEwKjzPaRU11HtaSc7MXqZBbdfx1cP5QVzUI
	DXDaI3RVP1uGNSq/Xa7oEwl+5ujfKuvd0vD7L9YqYQWBN2Gaa35xBk9g==
X-Google-Smtp-Source: AGHT+IHiY9jwlfkz2nz0dGtRKQJwLt6eUBrgFW37132m57s625Z4L1hMH4SOUc5Pht8Kq1BdmCdJ9W8jaG09Fpfk
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a0d:d511:0:b0:609:2031:1e09 with SMTP
 id x17-20020a0dd511000000b0060920311e09mr98950ywd.6.1708985420023; Mon, 26
 Feb 2024 14:10:20 -0800 (PST)
Date: Mon, 26 Feb 2024 22:10:17 +0000
In-Reply-To: <2024022611-tropics-deferred-2483@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024022611-tropics-deferred-2483@gregkh>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240226221017.1332778-1-yosryahmed@google.com>
Subject: [PATCH] mm: zswap: fix missing folio cleanup in writeback race path
From: Yosry Ahmed <yosryahmed@google.com>
To: stable@vger.kernel.org
Cc: Yosry Ahmed <yosryahmed@google.com>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

In zswap_writeback_entry(), after we get a folio from
__read_swap_cache_async(), we grab the tree lock again to check that the
swap entry was not invalidated and recycled.  If it was, we delete the
folio we just added to the swap cache and exit.

However, __read_swap_cache_async() returns the folio locked when it is
newly allocated, which is always true for this path, and the folio is
ref'd.  Make sure to unlock and put the folio before returning.

This was discovered by code inspection, probably because this path handles
a race condition that should not happen often, and the bug would not crash
the system, it will only strand the folio indefinitely.

Link: https://lkml.kernel.org/r/20240125085127.1327013-1-yosryahmed@google.com
Fixes: 04fc7816089c ("mm: fix zswap writeback race condition")
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit e3b63e966cac0bf78aaa1efede1827a252815a1d)
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/zswap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index 37d2b1cb2ecb4..4e0f0a7b30737 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1100,6 +1100,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	if (zswap_rb_search(&tree->rbroot, swp_offset(entry->swpentry)) != entry) {
 		spin_unlock(&tree->lock);
 		delete_from_swap_cache(page_folio(page));
+		unlock_page(page);
+		put_page(page);
 		ret = -ENOMEM;
 		goto fail;
 	}
-- 
2.44.0.rc1.240.g4c46232300-goog


