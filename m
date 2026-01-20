Return-Path: <stable+bounces-210476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB50D3C5D3
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 11:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0A2AD585E56
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 10:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DEE3491C8;
	Tue, 20 Jan 2026 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dlVNhdu/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DF23D4101
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 10:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904701; cv=none; b=LVLGfmm5qB74C75ScTKwVtA0ZXLbWNpvAPtWJ/4sttcKwGG7uevBpcXIUpXpahawwineCy/ThZQczVUZYuFQVfmO830oF8lxGbDLfcFnQL9IYt2Z+HjwFLo2Ho5ERQedZy4IXtECEDUjlxXuhsQzetaIpi3hqc/5J4sn/QzXd+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904701; c=relaxed/simple;
	bh=Y/J5hmeY8P6xt+jICQZvf1Nb0NO15zApZvNqeWkA7GU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FNSh4LJfKMjPtsiXyTF/QU36K5qNVE7JtNhYWwDnspQycEYsyoGYr41KjzmGEYo5rR1WUeYo03OBzuOxzwkaM4y/+5i58fTZFt9Vz8Ew98BBGxGEdZQctNwRMQOQJTbNsU42PFbOYs11s0ZxTsFTXx38NwofZQxaVj5kADsX2Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dlVNhdu/; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b873a14bb99so95952266b.1
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 02:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1768904697; x=1769509497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4QIb/Z+1VcMgY5q/jZtPEfXlsRsDdbkIp3UqDsbrZUc=;
        b=dlVNhdu/KMjR6xMGQl9qiMFHjx26MWDeA4wFATIMWm8FBRJbreW5QUD7H0Uoavp1hA
         db5ucaFmcCClpTtzlAKXJMZY/BlDaRRaF3voWjAzsIck3QVAEct351jMff+eIVSb9l7C
         UeAj5d+tJWXdiRre3bUQU+LcLyToeGyTCXyZmWenm3/umPPAv+IWhqZQzi3s/ZoPOiM1
         BhGutPrAF6w2rT/Saqhaaw/ESfrWxBTSWfx3lTsGUK6pcmzujiOm/LbyTTwC0j/H4OLM
         8jNQsSmNTQta/lWF5GFU/SGdmJbE5BIw5YH4rgDtmH0oSbuKkWoSx0yRsBIyxakb1uax
         ieKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768904697; x=1769509497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QIb/Z+1VcMgY5q/jZtPEfXlsRsDdbkIp3UqDsbrZUc=;
        b=Mcc9ieOIo1Jy9MVSkELyj27ZTtw3yQQ4Xy7coOT0AdomXiI5VvT5Us7sdhjtsodxqb
         4pRLoTPbvNUdviD67cGJyM6sLfCh6W5oI06G7DX4rZXjzRJNLiK2H5suQFyx2bHek8E4
         ycS3pnXWnL5RDaC1K1aXTKtOlZyrKtJQLQpzoEc32g949LnUQ4TwgFlz4PnEvnPcyn7z
         Xs3Sdb+aHG2Z9grpq7CRxe8NNiIIRko9UIls2oPhUp2bL9UF0fTy0xF6O3AGxIqz5J74
         Zkbn7IWQ2OBHd4hqygXokZd6kosb86dQURpJBwGm8qU+/BzKyGNWag4fqPbTRLIzZNn9
         8x3g==
X-Gm-Message-State: AOJu0YxBGEwG6LhBMuSIqa3ZBn9SLfFJRNtY0WiYOhaxrgXIU8TEQDmN
	oJX9a9FlEmpPLBFThqaiTF2zj+zotgtWcoBr01PK8Q/XIeXifn12aQqU178vZI2NS9kqYmGskch
	XUiV+
X-Gm-Gg: AZuq6aL+tqlmq5bfGaziD6wwT/I/NGY1lzVz+73yP0NoDJwTlTB32s+yJnkxtHGzguR
	3FjWmuRXV6Ujuqo2YOilO6WXK83ErsRyBReok/6RtFKuW2mkdCt+oh8M7or7w8uMdOhT+qF+AU/
	IvARMhCHuKdORh0c7EXgYIwKycGrCQAdhDuFelhURBnRu68PlXHQEJUPymrSOGNeqAiAfPtl+RC
	XyBQytyYtQ9jpUOWg/DtHxqQR8DaUuzhjyPUathS7y1j51kugzpDcJqg+yvOxODzgGzZOcXLAZf
	T0/10WpsjS+XwySatRyxezd6KB4wUoeC/JWR8rB1f2T3JdFOL4lBfSRntmeckJvpWiKywxtYbtv
	0kmDLyIopdIr7qiE0caZBwGm/sMahhA5N89uRKYi+J9AjYbb3HWl2mm2OpmSacajgV3laLdUZ4m
	MEXOj0DAZLIPhR4g74O5d38/jKfMbwsiZ+lrU=
X-Received: by 2002:a17:907:9706:b0:b73:59b0:34c6 with SMTP id a640c23a62f3a-b879302ebb7mr771796866b.4.1768904697155;
        Tue, 20 Jan 2026 02:24:57 -0800 (PST)
Received: from lb02065.fkb.profitbricks.net ([2001:9e8:147d:3700:2c77:8dc8:498a:7917])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959c9a08sm1355766466b.37.2026.01.20.02.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 02:24:56 -0800 (PST)
From: Jack Wang <jinpu.wang@ionos.com>
To: song@kernel.org,
	yukuai@fnnas.com,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] md/bitmap: fix GPF in write_page caused by resize race
Date: Tue, 20 Jan 2026 11:24:56 +0100
Message-ID: <20260120102456.25169-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A General Protection Fault occurs in write_page() during array resize:
RIP: 0010:write_page+0x22b/0x3c0 [md_mod]

This is a use-after-free race between bitmap_daemon_work() and
__bitmap_resize(). The daemon iterates over `bitmap->storage.filemap`
without locking, while the resize path frees that storage via
md_bitmap_file_unmap(). `quiesce()` does not stop the md thread,
allowing concurrent access to freed pages.

Fix by holding `mddev->bitmap_info.mutex` during the bitmap update.

Closes: https://lore.kernel.org/linux-raid/CAMGffE=Mbfp=7xD_hYxXk1PAaCZNSEAVeQGKGy7YF9f2S4=NEA@mail.gmail.com/T/#u
Cc: stable@vger.kernel.org
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/md/md-bitmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 84b7e2af6dba..7bb56d0491a2 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2453,6 +2453,7 @@ static int __bitmap_resize(struct bitmap *bitmap, sector_t blocks,
 		memcpy(page_address(store.sb_page),
 		       page_address(bitmap->storage.sb_page),
 		       sizeof(bitmap_super_t));
+	mutex_lock(&bitmap->mddev->bitmap_info.mutex);
 	spin_lock_irq(&bitmap->counts.lock);
 	md_bitmap_file_unmap(&bitmap->storage);
 	bitmap->storage = store;
@@ -2560,7 +2561,7 @@ static int __bitmap_resize(struct bitmap *bitmap, sector_t blocks,
 			set_page_attr(bitmap, i, BITMAP_PAGE_DIRTY);
 	}
 	spin_unlock_irq(&bitmap->counts.lock);
-
+	mutex_unlock(&bitmap->mddev->bitmap_info.mutex);
 	if (!init) {
 		__bitmap_unplug(bitmap);
 		bitmap->mddev->pers->quiesce(bitmap->mddev, 0);
-- 
2.43.0


