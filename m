Return-Path: <stable+bounces-200742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 368EBCB3DF0
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 20:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B13030184F9
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 19:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D17326947;
	Wed, 10 Dec 2025 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhtbgHgZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA83D30EF89
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 19:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765395224; cv=none; b=e7inyhtUDWERFu5vUrLqcwKrS8BbPjQE7o7UFO89v8gimf0KI5BBLNH1Ss9fBvEPzZ0R7gQPu+OPloyoLmWX94a06Z65NZqv6fmVD/q6Ne4YjyXGaMj52UseZvbvdEOm6eAmwTeVvjv+orCqrMX4/0480QUxpaAblKg2HeyvilU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765395224; c=relaxed/simple;
	bh=8UjBTc/l5QErbH4PdB/3AyuN4ByBmBhkEBcnEF8mCkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oX/HtaGCcPGcOL4FbVGETp2BO5THuE7JYXHJSMCHo3H5T7XBbYG3cxtleSuAttSoTXZvLt5BVUd0itprS9SMvGHA1cHbRrDt1OiU5MS2HUkBnn6NnswWVTvllmpSY0nCeQA7xC1rEf2GLKJRDYrrzKPtZ2utkEyE/mANhCLLCWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhtbgHgZ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so164440b3a.3
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 11:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765395222; x=1766000022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I/RcrEPeLqKl6bQA60QkstM/GSbzDgJ1lLxqTexZoic=;
        b=DhtbgHgZ+7sSiv5+qawseouOqruy86dngVXvOPN5hG0m9LLqMLYN4JmHKErgK6nnbo
         F/hEKQZ1sXPUp+soNfNhbcJk23tP0nNdfI+3qwTZtwi7/Kc5fSN1vG4wZ2liFzk/ZrCk
         73ymBtDNlDBVqdvSIZN6g3Cqxew4LlCHgXAGpC0ZWYqiHderD3x7OMvNMNa05agwmuqR
         DXLEkPOQzkUnGSn0+b3z7EMj2YZLjjxcMd5NuE0b+tpf3Eq5rE3+c5uEb2QDdY6Xk6r6
         DZcouNYMhdq6eRM/D8q6MfhMcd3i5qgRkV/cVdWOQwW5WADfabjBG+LHDwuqZSZrWyiH
         1jLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765395222; x=1766000022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/RcrEPeLqKl6bQA60QkstM/GSbzDgJ1lLxqTexZoic=;
        b=IFDs3CDZRGsBL/CeCs07KY61gQ1/1Timj9xlFlILgpf0lXzCJySJV5sCfs6R/9jLOr
         3q9q1EwAQHnEJDu4CFUSDe6ify22ULX/kD0TT7K86pDffraZsgHSRagNHAg2B2Ohw0XD
         xYbbF4PZ7H+IY77mSIkUcG97lfhguIl3zzwN8kbQ6bC6HK2syKZhnEC6xSS3klcPxyXk
         NPc9J0dfwOA2OyaNOYQggYPNeDo+qbRwqLuSXw3js4035yGc717s5Ff3Rq+VQ1oZ4v77
         9XC629I8fgjpS4jt5KHI81+16hDcKqxEXrLCRZR87+UetbAmyzK+p7DjLw1FNz0wNRHd
         vXFw==
X-Forwarded-Encrypted: i=1; AJvYcCWf2cFrpI4jIccpJY8IY4LB4U+0u/TjhmdpHHAoCKcqHLoHecqcqDxY9CHDq7V47dVym8Dhz3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAEqvTtGyvjisR7yrw9q++obOBCzAcDxlNvvdMAQhrIbOuclx4
	DmJcMiyPQCYJMehA4t9HxuIHfaN/FVUw73f4HqoFoM/W/x1BTiy2sFOz
X-Gm-Gg: AY/fxX7jCO0TmLo9I6kvkBbXN0oj7B8LZZn7iZhL2sCBd5DJy+eKwfxZbxeXsubZcQX
	hLaWEOxZ7VHUtDiagi2bgSkdEihKMYuH6IPBLITn09d9zVb6ihAAB0rZRi7v/H5aPT0ZmJwfGBq
	dHPt02UKLQ5d/m1IRPzmgVVQJ57XNVb6sJVxeXnspiMvECjCkEKsU82Ruequ1GKtc9mvGlYQGt5
	LVHEurSZ/QhtEghuCbqJLzSHwe1rl1TgvQLfN5l/rbUge3hX7Lg5jfvjDCXLOlZ4oGpWfKqA5+H
	bUNC/LjyyNUqDRD2iYV1a5ERgcmnLYTjlJ6jb4ukO/hoEtwr9MKvNNfcB8UtjkO1oPxJ//q1tId
	rLJf1yb4P6t6Nel7Bw29clgK81LlXF1mhsW3UYwiN2gRtE8PI0TQ7SazFWzuTrvFeUZiJiAzhqL
	/R6KueA09UUTaBQdDuldKSJKeJxpgx9PGC26q56A==
X-Google-Smtp-Source: AGHT+IH/7AZHVflGDIAmJDUB8km9duB1spqmtxvC8h5wY8EGyhYSwMmwBdGOw/GUihrZdBUrNpWeqQ==
X-Received: by 2002:a05:6a00:94f1:b0:7e8:43f5:bd0c with SMTP id d2e1a72fcca58-7f22f716104mr3793601b3a.33.1765395222112;
        Wed, 10 Dec 2025 11:33:42 -0800 (PST)
Received: from localhost.localdomain ([111.125.240.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c27771b3sm304828b3a.27.2025.12.10.11.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 11:33:41 -0800 (PST)
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
Subject: [PATCH v2] ocfs2: fix kernel BUG in ocfs2_write_block
Date: Thu, 11 Dec 2025 01:02:55 +0530
Message-ID: <20251210193257.25500-1-activprithvi@gmail.com>
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
v1->v2:
 - Remove usage of le16_to_cpu() from ocfs2_error()
 - Cast bh->b_blocknr to unsigned long long
 - Remove type casting for OCFS2_SUPER_BLOCK_BLKNO
 - Fix Sparse warnings reported in v1 by kernel test robot
 - Update title from 'ocfs2: Fix kernel BUG in ocfs2_write_block' to
   'ocfs2: fix kernel BUG in ocfs2_write_block'

v1 link: https://lore.kernel.org/all/20251206154819.175479-1-activprithvi@gmail.com/T/

 fs/ocfs2/slot_map.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/ocfs2/slot_map.c b/fs/ocfs2/slot_map.c
index e544c704b583..e916a2e8f92d 100644
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
+				     (unsigned long long)bh->b_blocknr,
+				     OCFS2_SUPER_BLOCK_BLKNO);
+		if (!status)
+			return -EIO;
+		return status;
+	}
 
 	status = ocfs2_write_block(osb, bh, INODE_CACHE(si->si_inode));
 	if (status < 0)

base-commit: 24172e0d79900908cf5ebf366600616d29c9b417
-- 
2.43.0


