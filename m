Return-Path: <stable+bounces-91932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B36F9C1F00
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 15:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB29EB224C8
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 14:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869651EB9F7;
	Fri,  8 Nov 2024 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mID9JvHS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EEE1E1312
	for <stable@vger.kernel.org>; Fri,  8 Nov 2024 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731075511; cv=none; b=F+eUrSzKdrOR3zyWESGVT9wPRZptMWXWZaOsD+JlC5pqDs6qwXAPRioFlpfD8nAnjAvYg1TV21Fbm8DKsULG032ZwrkYI78Nzc48xWeg9dCZ14c8M1lS0Nxzq1VQkpcsAN1j0kLQDgOHJQkNogdTqiADCMWHqDKf52lGr1x6XrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731075511; c=relaxed/simple;
	bh=VUYfrH7Vq7Lidzdo6j2YqZeIfj1IW2MCYvcHFVUX6EU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MSIyAOihbfh73hucxAHoSgFNR6guT8rPNR5tt1VKw+Uvgq9eCcNBk/ab7PSei9/mumfnPhAgYeBB0ggCQR5/kyrT5iMJtxUPV6UGxFAzb8E8LNiHjmvhm0kcfkjD6g4NTCAWRHvmt70b+MA5gxDUBAByzlVl7Ewvds6PaqhSnK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mID9JvHS; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e5130832aso1750639b3a.0
        for <stable@vger.kernel.org>; Fri, 08 Nov 2024 06:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731075509; x=1731680309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9/BQL8RJCjStFEA1vUZRU0MMoqsNGEVVN9P8ZLRL5OQ=;
        b=mID9JvHSVk6os0JIn/PraypjXljyLBCrnF2ZPzDtsZ2pWVOJd2mF7qqljHcVhRTtEY
         GA39GsjkLl3JFY8c4pUZVTgXVmYNWJJ1SElWvFvssoZE1FynPrk+xZNV9rd7LKk2AAU4
         v5KJZBwc/ybiQUwithYVddoUfyUu7iNmvWE0Et7PK5WDueSev3Hq0Yjsgo2SDX72+6v2
         tpoqzf2p7wMw/HEFwT9vyLNPMFZ6f1psKLpbMMX3sd9z/Emyr2cnuVMM7GkeQEUypCwh
         q+exL9zsNAbO0jJwqwFWHlx2gB6naQ1Br09cEHNwe2Axrb6CbGcbCXyB8075SthnQ0rE
         vkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731075509; x=1731680309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/BQL8RJCjStFEA1vUZRU0MMoqsNGEVVN9P8ZLRL5OQ=;
        b=sy22hdBmSKeV6P08MWLhn4trpi7KJpVAH/HLeMhAwRixvY5hlkGp8mEhFmoqgcnk2q
         P9XxrH5CPzgMC+QuqeZ02H2x0WoYxBn24B6jjdVtozosOjkCRCKMGWMWbOcYrYh5TKsg
         CxkF6d3ih548yKZ/9z0Oa8YB75qI/DNbxmwLGvjaUuQ3B0FpdnUBiU6AVoUQ6j4f/+U+
         St7GcQgkIAwBAobR5O4bBb+ycXda/mmVXHuJb2BM6BWbu7y5he1CW1wn6aYC8TwrmE3F
         09Rub77EQZ2GHyb0sfR+QtnqUc2x7fH9PKGC7U/Jpx1+rcSry6UozFPp8psM7SAa53LV
         aJkg==
X-Forwarded-Encrypted: i=1; AJvYcCXF7fxrkslnpDt5E9qTgTIH4zZGJp1aFj7gfsUm3dlYBHXiIxcO3w33WbJGelm6JFWooG5ANYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwbZbMNK8ppl3/GU1/txm15c3tqJnu83zMAGtuGO+lnnp+Ihba
	Fvsrw5PC2O5QDXPuvK0Ny/GuFzL+VWpbl0vZhSeIEvOLo3mklSKM
X-Google-Smtp-Source: AGHT+IH3c+D72JKSguP5iqxfgtjBvAQWEHR9kwn6DYiM3w5E4T3SEt40wE+/cjQnrEqyPgiCAu/b6w==
X-Received: by 2002:a05:6a21:788e:b0:1db:eb76:578d with SMTP id adf61e73a8af0-1dc22b1b587mr4246234637.36.1731075509147;
        Fri, 08 Nov 2024 06:18:29 -0800 (PST)
Received: from localhost.localdomain ([183.193.178.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a18f51sm3706516b3a.155.2024.11.08.06.18.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2024 06:18:28 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/readahead: Fix large folio support in async readahead
Date: Fri,  8 Nov 2024 22:17:10 +0800
Message-Id: <20241108141710.9721-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When testing large folio support with XFS on our servers, we observed that
only a few large folios are mapped when reading large files via mmap.
After a thorough analysis, I identified it was caused by the
`/sys/block/*/queue/read_ahead_kb` setting. On our test servers, this
parameter is set to 128KB. After I tune it to 2MB, the large folio can
work as expected. However, I believe the large folio behavior should not be
dependent on the value of read_ahead_kb. It would be more robust if the
kernel can automatically adopt to it.

With /sys/block/*/queue/read_ahead_kb set to 128KB and performing a
sequential read on a 1GB file using MADV_HUGEPAGE, the differences in
/proc/meminfo are as follows:

- before this patch
  FileHugePages:     18432 kB
  FilePmdMapped:      4096 kB

- after this patch
  FileHugePages:   1067008 kB
  FilePmdMapped:   1048576 kB

This shows that after applying the patch, the entire 1GB file is mapped to
huge pages. The stable list is CCed, as without this patch, large folios
don’t function optimally in the readahead path. 

It's worth noting that if read_ahead_kb is set to a larger value that isn't
aligned with huge page sizes (e.g., 4MB + 128KB), it may still fail to map
to hugepages.

Fixes: 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file mappings")
Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: stable@vger.kernel.org

---
 mm/readahead.c | 2 ++
 1 file changed, 2 insertions(+)

Changes:
v1->v2:
- Drop the align (Matthew)
- Improve commit log (Andrew)

RFC->v1: https://lore.kernel.org/linux-mm/20241106092114.8408-1-laoar.shao@gmail.com/
- Simplify the code as suggested by Matthew

RFC: https://lore.kernel.org/linux-mm/20241104143015.34684-1-laoar.shao@gmail.com/

diff --git a/mm/readahead.c b/mm/readahead.c
index 3dc6c7a128dd..9b8a48e736c6 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -385,6 +385,8 @@ static unsigned long get_next_ra_size(struct file_ra_state *ra,
 		return 4 * cur;
 	if (cur <= max / 2)
 		return 2 * cur;
+	if (cur > max)
+		return cur;
 	return max;
 }
 
-- 
2.43.5


