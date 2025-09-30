Return-Path: <stable+bounces-182884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C16BAEA45
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 00:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16B6320110
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 22:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202BD22ACE3;
	Tue, 30 Sep 2025 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIYQLr6k"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AB819C540
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 22:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759269913; cv=none; b=VGGP6aL8sHhLRbMp8sgBaiUoI7NGXPWISGPOAg3lxqbG/w6BRyWx4qHxMOwwqbResiPxshffLx7d1enEZzAWzoG27q/wCEmVuvoexNguQ86lCsJxajauh6yOTrVp9IQLZP62V5vCytUCp9hqJtuJ2bX+86krTjIgGngOj9QzyTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759269913; c=relaxed/simple;
	bh=w1NAJI2SiqTL6MsQWksBIE3yrHzETJqjVevVxHYxwB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u92xVtV9LzWH2n9I+++IuxAyIpNPrHQ5fSJGoAchO/7p44mcAT7NZ0O7KR2kAjDinqCey/Udlt5yQgYcL2NQK2vAsB2jHYwYiiysJbAqu1iQhCcyf57UWWthPz4x4aRyE39vqZSVriZ56riS56gSS+akidz97CityuyaZas8ifE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIYQLr6k; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-28832ad6f64so35350795ad.1
        for <stable@vger.kernel.org>; Tue, 30 Sep 2025 15:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759269911; x=1759874711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1YGszLyL9lU+9b7JkUV4nc9DQvr6XDZT596NzLz/MHI=;
        b=JIYQLr6kDbFdbmU8sRIPue/76LGhthmcGxf5/GEvWO2dZC8ctcbl7o1hCArZL1TW8U
         f5KbNTA6+jowCa/NkEOIXgCIvMgRZur7CYL022ojzfd6RzDOF308He4pgGj79piiH4ho
         6bz/0gU9yNXpTlG1ZRR+H2zxokjC/OjTQWAS3VNvGWemQ5gs0RoceeyxM8dumweIcn2w
         c5kiEni3sHlJvuBQy4sN8sjpdhvaRo0cuzn0/iOxho2dAUmBMoSviocKepmcqEeu7pYE
         OfESGV29C9J7bFYtJraORd0LOPJT4ETtb+YyBLFnk/VeSdOhjhYrD7vLZmiJDLqnlszp
         L2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759269911; x=1759874711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1YGszLyL9lU+9b7JkUV4nc9DQvr6XDZT596NzLz/MHI=;
        b=iiarhZvi865FjWOzxijaTUtcOKv5YxhDZZB//cy46rEZHjLAHuO6pT+cFdcyQF6M4X
         kChfJflnpMPZngPt8mwhqVQxKRGvteTzLiFaQki5JQct34LARnwDbs/bl/K3psHr2569
         ZE1BKTzT/TrgTaMxG+gf0ElvxxpVDP0fVij/uRfcfAhO7/msSeAgpC0vQjx4OANf/I9T
         BHJC0uqTWAoBMowxsR+Kg9MAmtKP/ivjsVxiRfgYTCzxpCinjD6rNQszdxk7WY30NGQ+
         N3A2/2qP4x4ZNo6JJ7aILwHuhdftkX6mSURyrHegXmxBDB5obCz7Q2cx9K4FoTfTCL1p
         4lxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaM5CVjnE9xOjDDr02tCNnDnOi2eOSBFVd+qxCiYZzlMbqYO8QnL7ifBjCu4Ixsq/cc+rNIjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8XLS1kobk3eopeFkVv9UdMI8C9JaTLfDYVJonexSOq5miQOwS
	awBmQ7nI26w4Ty89xDL01IZT1SRtwgoUoEuaeZC5whsB2xN6/J80V+Yp
X-Gm-Gg: ASbGnctnwN+K/wbnLKkcn3V1vAUyOyxTx3B9mOIbN/6d+qmCXW5spniW2FX2zKt6yPm
	rCdU3XIWbSHt+DFjQ7gq2rfUJ8eQgaAhM5VBLpEJmtbl87g/BMy0f23gzuNe+IBck8IyPHkQGQ+
	u09YqaaexmK7WaDN8C78th7yl8SXHuby88J6TGbh1Qt3J//piZJGIEK+CVXBxM8vnCNimKOH8D4
	HG+32iHVnoPQynM71yvBcvoUrzuMLajBEMWSciYIAA3sh5mx3boiaSM0ZmCVzvX5jdwMVRhUJmQ
	/+gTNyBSr9bk1E99bQbuJeygY4H2YfCA4qHB7y8ilMPaWXFCAmx87hTJF848DJwv3WT4CfgT5b9
	WBvEcvwhe1QQspFzbIiFN9WB1w1DXGznspWmRJNSZ7Yq952PP3oM7I3pvL0mJeRO2KJu42YXqab
	3IMu1HSgpk3M4mK/chbmkZFl8DkWHD
X-Google-Smtp-Source: AGHT+IEAmgEAvvFPVs4Q4OV1e3aUossyWXIXaKbDnHZQSgw190HB3dExH83dgEAu5opV8IRGn/hHKQ==
X-Received: by 2002:a17:903:19e6:b0:24a:a6c8:d6c4 with SMTP id d9443c01a7336-28e7f2dcc13mr14255085ad.26.1759269911354;
        Tue, 30 Sep 2025 15:05:11 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2401:4900:4176:b4f9:480e:ed50:969b:5d2b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ab74fasm166454855ad.132.2025.09.30.15.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 15:05:10 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: syzbot+9db318d6167044609878@syzkaller.appspotmail.com
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ext4: fix use-after-free in extent header access
Date: Wed,  1 Oct 2025 03:35:02 +0530
Message-ID: <20250930220502.771163-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

syzbot reported use-after-free bugs when accessing extent headers in
ext4_ext_insert_extent() and ext4_ext_correct_indexes(). These occur
when the extent path structure becomes invalid during operations.

The crashes show two patterns:
1. In ext4_ext_map_blocks(), the extent header can be corrupted after
   ext4_find_extent() returns, particularly during concurrent writes
   to the same file.
2. In ext4_ext_correct_indexes(), accessing path[depth] causes a
   use-after-free, indicating the path structure itself is corrupted.

This is partially exposed by commit 665575cff098 ("filemap: move
prefaulting out of hot write path") which changed timing windows in
the write path, making these races more likely to occur.

Fix this by adding validation checks:
- In ext4_ext_map_blocks(): validate the extent header after getting
  the path from ext4_find_extent()
- In ext4_ext_correct_indexes(): validate the path pointer before
  dereferencing and check extent header magic

While these checks are defensive and don't address the root cause of
path corruption, they prevent kernel crashes from invalid memory access.
A more comprehensive fix to path lifetime management may be needed in
the future.

Reported-by: syzbot+9db318d6167044609878@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9db318d6167044609878
Fixes: 665575cff098 ("filemap: move prefaulting out of hot write path")
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/extents.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index ca5499e9412b..903578d5f68d 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1708,7 +1708,9 @@ static int ext4_ext_correct_indexes(handle_t *handle, struct inode *inode,
 	struct ext4_extent *ex;
 	__le32 border;
 	int k, err = 0;
-
+	if (!path || depth < 0 || depth > EXT4_MAX_EXTENT_DEPTH) {
+		return -EFSCORRUPTED;
+	}
 	eh = path[depth].p_hdr;
 	ex = path[depth].p_ext;
 
@@ -4200,6 +4202,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	unsigned int allocated_clusters = 0;
 	struct ext4_allocation_request ar;
 	ext4_lblk_t cluster_offset;
+	struct ext4_extent_header *eh;
 
 	ext_debug(inode, "blocks %u/%u requested\n", map->m_lblk, map->m_len);
 	trace_ext4_ext_map_blocks_enter(inode, map->m_lblk, map->m_len, flags);
@@ -4212,7 +4215,12 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	}
 
 	depth = ext_depth(inode);
-
+	eh = path[depth].p_hdr;
+	if (!eh || le16_to_cpu(eh->eh_magic) != EXT4_EXT_MAGIC) {
+		EXT4_ERROR_INODE(inode, "invalid extent header after find_extent");
+		err = -EFSCORRUPTED;
+		goto out;
+	}
 	/*
 	 * consistent leaf must not be empty;
 	 * this situation is possible, though, _during_ tree modification;
-- 
2.43.0


