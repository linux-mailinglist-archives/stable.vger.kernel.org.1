Return-Path: <stable+bounces-179026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CE2B4A0ED
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 06:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A1F177176
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 04:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEED2EB851;
	Tue,  9 Sep 2025 04:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kfjGtuh3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8942DECDD
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 04:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757393525; cv=none; b=fe6ksDofhLAJ9v4Fe/h4mjA53gjQD0iKCKWGordkxE+g0zWDFdbAHcobhmJITMxEqCFOZWaNXwFifaSZqaZIctBfr6E+IqnyzFmUrc/69wdKlBbbj0iJFOnYNzqgUZ7urbY2ONmcyGpoOD0rfm6NlWfxnxatdsR8keP6HlmB8zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757393525; c=relaxed/simple;
	bh=x8VD93zI//O173NdJM5LXc5a35t6Bki9+AMpcHxEaOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hg6rkle04qIWVVGXDa5UD+Qry4xKXBg2wlVn7z4u+c4j9QR4A2OGTG8Kp0lmE8PbARN2FPrvB4LL7pbbs9BZD5Ip02a/h8Ky6mUkMiReij7thGvmtjraaIookPK//4AKskfVKvC8aHScwm1Hw5s3bQQhqCLei7qQlQJAtuQXc44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kfjGtuh3; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4c72885c8bso4242155a12.0
        for <stable@vger.kernel.org>; Mon, 08 Sep 2025 21:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757393523; x=1757998323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RxTekYZw4n/8+pZjM2Wb4q6TEJbbwCkXd1Sr0QZaf6U=;
        b=kfjGtuh3QAS1aGpIO0f+Z1dM2OfZm7/NMiPiaRpY7lsH/vOkGB+pjyUy4pOx/RABV4
         MGlcOD8k8k92FVVuc2vMqWFzeTW4+q77QIOGqItk4d4eaH94FpZCN/owoH5wBZRPk35H
         t1FeNfbl9+J6mKlgca6AAYx75hx6CrYrmHbDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757393523; x=1757998323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RxTekYZw4n/8+pZjM2Wb4q6TEJbbwCkXd1Sr0QZaf6U=;
        b=qcvSicUgK7UlJA4LheH+zCIHh7/BF4V0Ip+suHhUFNS8MrfdGcQy9nWrhuCVaqp13e
         AFWAs9ig86X3G/54cO/lJIyeePsybqH1U27g25ySaKDy0r8U4mn3DofSRsaeqy/YBsm2
         IUgjnFrasVs5HVvVCn0Wgf98CHeUD0IJ/HhWV6O8VbX/DV5BYrhpSusLm6ZvlCQePVs+
         QGY4606k+Qdk/tDiiuwEu4U9K4/cnh8PXMe8k0cRxZUdzntDCpoIvAcbRN6iZlSy9MDY
         FqT5Oqz3DjnmWXvaeqpbogVl0Iw8xuBHL0sgSMyC1sDffS2YUk9AJxjmZm5on2j7eA/9
         Q6sw==
X-Forwarded-Encrypted: i=1; AJvYcCW8CGLCT4NPX2nGMo1MgRtpqYHZFaQnCsVVKEvCjU7BaGSGmXxgUh4d99sYlkqaTQJt/rHQAhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4UKbWiBuM25e1bjtk6cro8vciQAYkCzqvTAO4d21/YMXd9MsC
	SbjUmdMtWZiiJHKWG5rHbhyHpeopJYsbYxyW0SgCszYpgX0bjET7y60BK0FCt2YQwQ==
X-Gm-Gg: ASbGnctxLOwlEI15OF7HRw3bLuBGTAPUrYodKZ6o5e2A4AvuPsU7nz8XcsnwMME+/CC
	pR4/ZAJ2CY4qW9dPhlLXV4OIT5eianmTC9W7fAtHPN0K+8RjEFRJHqOu0hzMAA+yGR4G/7cseTh
	QpvAzp/p3e7xiXSIIhZ2RjhGs1Bngd+TSCCysUURBW7A28N0uGULfcBF/Zu0U+hQbO0kNWnSKJA
	j9AIhtcTQDO8XIoXol8UY5PM6tViAem5A7zTDyrDrxl5wmJGnmoskhNbEmuK7SU5UC3Hs0kX+lv
	d61Hage7Sqpn8vtKuT3VpXWRt6s6zLhOFOqX4mPXsnJMVI58WWj282kYEi1sRyiUXFoFm/z8/Nd
	d70kYJa153AqlkIMsCtoJM8+mLT34qUodAdnAS8Aqo1gq16v3
X-Google-Smtp-Source: AGHT+IHELyfgjQV2lzS3L+EPdr6RMiKi7ZVHtI7OWwvlxUWsJr5Q80qDuYZaQ1tDaB9WjaWbwYFEhQ==
X-Received: by 2002:a17:903:2287:b0:24c:82ad:a503 with SMTP id d9443c01a7336-2517446f905mr133387135ad.41.1757393523236;
        Mon, 08 Sep 2025 21:52:03 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:337f:225a:40ef:5a60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24af8ab7e7bsm199723815ad.138.2025.09.08.21.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 21:52:02 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Changhui Zhong <czhong@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCHv2] zram: fix slot write race condition
Date: Tue,  9 Sep 2025 13:48:35 +0900
Message-ID: <20250909045150.635345-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parallel concurrent writes to the same zram index result in
leaked zsmalloc handles.  Schematically we can have something
like this:

CPU0                              CPU1
zram_slot_lock()
zs_free(handle)
zram_slot_lock()
				zram_slot_lock()
				zs_free(handle)
				zram_slot_lock()

compress			compress
handle = zs_malloc()		handle = zs_malloc()
zram_slot_lock
zram_set_handle(handle)
zram_slot_lock
				zram_slot_lock
				zram_set_handle(handle)
				zram_slot_lock

Either CPU0 or CPU1 zsmalloc handle will leak because zs_free()
is done too early.  In fact, we need to reset zram entry right
before we set its new handle, all under the same slot lock scope.

Cc: stable@vger.kernel.org
Reported-by: Changhui Zhong <czhong@redhat.com>
Closes: https://lore.kernel.org/all/CAGVVp+UtpGoW5WEdEU7uVTtsSCjPN=ksN6EcvyypAtFDOUf30A@mail.gmail.com/
Fixes: 71268035f5d73 ("zram: free slot memory early during write")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9ac271b82780..78b56cd7698e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1788,6 +1788,7 @@ static int write_same_filled_page(struct zram *zram, unsigned long fill,
 				  u32 index)
 {
 	zram_slot_lock(zram, index);
+	zram_free_page(zram, index);
 	zram_set_flag(zram, index, ZRAM_SAME);
 	zram_set_handle(zram, index, fill);
 	zram_slot_unlock(zram, index);
@@ -1825,6 +1826,7 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	kunmap_local(src);
 
 	zram_slot_lock(zram, index);
+	zram_free_page(zram, index);
 	zram_set_flag(zram, index, ZRAM_HUGE);
 	zram_set_handle(zram, index, handle);
 	zram_set_obj_size(zram, index, PAGE_SIZE);
@@ -1848,11 +1850,6 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	unsigned long element;
 	bool same_filled;
 
-	/* First, free memory allocated to this slot (if any) */
-	zram_slot_lock(zram, index);
-	zram_free_page(zram, index);
-	zram_slot_unlock(zram, index);
-
 	mem = kmap_local_page(page);
 	same_filled = page_same_filled(mem, &element);
 	kunmap_local(mem);
@@ -1894,6 +1891,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	zcomp_stream_put(zstrm);
 
 	zram_slot_lock(zram, index);
+	zram_free_page(zram, index);
 	zram_set_handle(zram, index, handle);
 	zram_set_obj_size(zram, index, comp_len);
 	zram_slot_unlock(zram, index);
-- 
2.51.0.384.g4c02a37b29-goog


