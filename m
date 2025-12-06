Return-Path: <stable+bounces-200253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE73CAA96A
	for <lists+stable@lfdr.de>; Sat, 06 Dec 2025 16:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCF203009F77
	for <lists+stable@lfdr.de>; Sat,  6 Dec 2025 15:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA9E2C375E;
	Sat,  6 Dec 2025 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZglQs6D2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D8222D4D3
	for <stable@vger.kernel.org>; Sat,  6 Dec 2025 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765036118; cv=none; b=ojU3zqfgSSfb9noQ1+HK+bOMgi87aswDv4PxjY4O9U99f3ksWy4HiBcz3jlDT/dfdD1yXLRVHL5UCcxm/Uzb0a/V+KQZfuOhFZ18spkTAQIHBlSdNHIaN3fn2w4ypIS2apPeJg9jDEYcbCExtRqdjQD/TiXtMX1GGpH7msSFZNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765036118; c=relaxed/simple;
	bh=GuParDz5eBLylVgW96qpjXBZ/qEXhOMxbh9C6uWa7ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=prHmjPE4GHc4oilWaSRyFqsK0P9sK6Njo7Xq2WtF72fJCUwydsPN57gUZLezvqvCdVVyJkUNm0rJlCN4xeMU0LJe6uhkMFFnBrmhFmjrcEcwPGvJPBE/c3XAbB8QlQc4VFffNmKYlAAirWIWQyQF7IG3jKS06GP+4VCktHHuOQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZglQs6D2; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so2833180b3a.3
        for <stable@vger.kernel.org>; Sat, 06 Dec 2025 07:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765036116; x=1765640916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+eRPeM9q2EbXpge8hopYzyHkKbCy3VfPZR9AGB8+LLk=;
        b=ZglQs6D2ftMfHvS+we9HHBisi7eIXXtu65XqpxHtvldyv2BweozscSfpgFwvo2Bk0u
         Rdv0yFuEkrzQUokNZCSETBcQhLMQuRv8Z96XC5Jzypq9pxqVKdNZ5a8aoBLOMe8QXQ+4
         futnYICabMKcfZaTA+MzvF1eOvL8r1bvIKLGroP/W9bUtOnpfGB43uXLjv75QG882ScA
         hgEPLLDsfvOB1gjDH+A4+IB2immCKwnmIHjNjQ1n0cEMM0BovB1ONrdaILjAs+Ydy/qw
         gMeVuS5mh2D1LqxOPXq8+ekWIzwPTFtrNHDYnnbJt58Z6A5cK0od1V5GZu+nAcp19qfv
         3nYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765036116; x=1765640916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eRPeM9q2EbXpge8hopYzyHkKbCy3VfPZR9AGB8+LLk=;
        b=PAjp/LYQ3bTtbmnFdfZrhN0Q16nGyNAjX/sxq7sIgJYWWsHLxWHa1JbVmaRnp0K//Z
         do3Veucv0l450hxpjyNNBCcXNBqgTZb0hB0H6vWf5DJdPClwtGxrJJMfaJLhyiQhDst5
         8mFxqWDS/Ehy7puySLWNI4ljbQYZfBvXpfUsGy9N14y4bwqynW+ptdBqY4ZPvMa++456
         c9Yd0HgkDZJgc7uzO0u47hVd68V7QqXYSULoqcsAVt2YQAqJzKG4RBxlFVqxY09nAGVR
         JYZngIgyeouHnEO9sFBPu2sXpuSlpKu6wmCu2peIy8+N2iAdYvklj2k2yMBmTYGxezJn
         vJkg==
X-Forwarded-Encrypted: i=1; AJvYcCVsRcb7w6VNcWCziLlXlDXzH4d8SFvPLKaJc7tKZVTlHoo7x7LxerNC9tWlsxXkKDDjWfBrLiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuJJFfvJqHIOili8BEkhW7AkgZ+CmvzKqC089lgmkkJQVFjEm6
	vGgbuEB9bLaXpPeO605i/iRbE5ZMKEurlX76YfznNFsHCyaqlZACy7qO
X-Gm-Gg: ASbGncvfFdyoHJoyE3HHbtH8dXj8exTkSKJOFWpGGkNk887N/azoYyfPQHLAMDI0pxG
	D+ZWdBWQDX8uQBhGHRYgODJyGs5XSupiM10MfH5/C7x5GpbLs9f54mwgckyLdv/1TrSn1LcwAPv
	ueH2oO5HXNPK8v+rcSAJwO8YCXExocJPvfpgG/I9G5pOPuXXsYZm+F1ZbaHCX/yI3dCa+/0WWKc
	5fg7WJsAacILFJnNJ/2Q8k0Rl7W97+RPmxP5ffS/54KPNH9sZQD5eI4n0pt6sz/uUQEn4ucf0hg
	2VcxelQP3aO3dF2kMMfHT/6OryESwv4jhI0+z2GGJegqcujOkude4GwvwBNajlNBVK+OXhvRBoA
	sJP8E8rfWN6pZpxSR9szyuNmsh3/UGdiSlKUeFcdpVekh2lv5WWG4EO2eUlf7K6mZd2eaIjRx5p
	kmLHgMlcV/E/tOl9f4ChJXK3HHBg==
X-Google-Smtp-Source: AGHT+IHFctVdxlEN7Gl0atqGBbR40knvStVEAlZWL5HG/t6ahFYt4XUQze3IxeMz74Bn6QMNjDZeag==
X-Received: by 2002:a05:6a20:a11e:b0:364:31e:2cb1 with SMTP id adf61e73a8af0-36617e6c5dfmr2683085637.17.1765036116169;
        Sat, 06 Dec 2025 07:48:36 -0800 (PST)
Received: from localhost.localdomain ([114.79.178.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6875cc8eesm7645210a12.16.2025.12.06.07.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 07:48:35 -0800 (PST)
From: Prithvi Tambewagh <activprithvi@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Prithvi Tambewagh <activprithvi@gmail.com>,
	syzbot+c818e5c4559444f88aa0@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] ocfs2: Fix kernel BUG in ocfs2_write_block
Date: Sat,  6 Dec 2025 21:18:19 +0530
Message-ID: <20251206154819.175479-1-activprithvi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the filesystem is being mounted, the kernel panics while the data
regarding slot map allocation to the local node, is being written to the
disk. This occurs because the value of slot map buffer head block
number, which should have been greater than or equal to
`OCFS2_SUPER_BLOCK_BLKNO` (evaluating to 2) is less than it, indicative
of disk metadata corruption. This triggers
BUG_ON(bh->b_blocknr < OCFS2_SUPER_BLOCK_BLKNO) in ocfs2_write_block(),
causing the kernel to panic.

This is fixed by introducing an if condition block in
ocfs2_update_disk_slot(), right before calling ocfs2_write_block(), which
checks if `bh->b_blocknr` is lesser than `OCFS2_SUPER_BLOCK_BLKNO`; if
yes, then ocfs2_error is called, which prints the error log, for
debugging purposes, and the return value of ocfs2_error() is returned
back to caller of ocfs2_update_disk_slot() i.e. ocfs2_find_slot(). If
the return value is zero. then error code EIO is returned.

Reported-by: syzbot+c818e5c4559444f88aa0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c818e5c4559444f88aa0
Tested-by: syzbot+c818e5c4559444f88aa0@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
---
 fs/ocfs2/slot_map.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/ocfs2/slot_map.c b/fs/ocfs2/slot_map.c
index e544c704b583..788924fc3663 100644
--- a/fs/ocfs2/slot_map.c
+++ b/fs/ocfs2/slot_map.c
@@ -193,6 +193,16 @@ static int ocfs2_update_disk_slot(struct ocfs2_super *osb,
 	else
 		ocfs2_update_disk_slot_old(si, slot_num, &bh);
 	spin_unlock(&osb->osb_lock);
+	if (bh->b_blocknr < OCFS2_SUPER_BLOCK_BLKNO) {
+		status = ocfs2_error(osb->sb,
+				     "Invalid Slot Map Buffer Head "
+				     "Block Number : %llu, Should be >= %d",
+				     le16_to_cpu(bh->b_blocknr),
+				     le16_to_cpu((int)OCFS2_SUPER_BLOCK_BLKNO));
+		if (!status)
+			return -EIO;
+		return status;
+	}
 
 	status = ocfs2_write_block(osb, bh, INODE_CACHE(si->si_inode));
 	if (status < 0)

base-commit: 24172e0d79900908cf5ebf366600616d29c9b417
-- 
2.43.0


