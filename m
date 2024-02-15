Return-Path: <stable+bounces-20249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E73F3855E9D
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 10:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836811F22533
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 09:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A6663513;
	Thu, 15 Feb 2024 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blw/FIeK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0372A63501
	for <stable@vger.kernel.org>; Thu, 15 Feb 2024 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707991101; cv=none; b=KUmHp8bE9fZgKeLTkJPRzDbrWKylkqnrSC50I8C3WaACLQFLtELA4lcwD2UTwuBfSf8C9vqFDjp80HZRwJT8ARwGpuh/733zfCCdW7WlTTsqD41PX1j/4NwAmQFstOyqt9AzHx0762rVk3u3nvYQFb3LasNtW/adM4FgJ3PqgAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707991101; c=relaxed/simple;
	bh=/vqB72+TcLLCITZXLOYX8LhsB8TSzzb1CLm2wxbztRI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JJ4VoZziOKJj7FyM3vlQNLGn4c/pDR7jjJwOYCz5p53q5HvSFNruTghOPBKXSQD/qKlw0iO1//QDNze/I/WbCtWx2PghtHTMy2AH7kP6IdbmzI2XSBNAEQDoWxt8WmVE6Y8PvbJtO3kJULFrsjsKyCOzM2/h3JOEseIYcaiHEBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blw/FIeK; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d746ce7d13so6294825ad.0
        for <stable@vger.kernel.org>; Thu, 15 Feb 2024 01:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707991099; x=1708595899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/03MR7907qqkPAwHG0qSknvAB6ItWDNRwrijCfs3NA=;
        b=blw/FIeKxjcrJJDgRXjcF+H0ZtZ7weqEXWvV8pbRzHM0z2T0413oF1VJEsZyDzx7/h
         j6u37x5FPCTIDyu6r2AhDMYH1sDKycqn5ATqGiUEc92A1AJNlCvVWdMbTGbegx+eBizN
         /G/I7GWEapnK8qDf0ygwTJaGqQufwtr2hThTv8auek25AbISTy76NIAwkzrxW4NS6gnl
         6yxmWYahFpDYbPjFu7c2ge9FlIH+N1oMejEQ3/Xl83wj98yHa5kBwqu2te2/emH9KsWt
         TPnOVsYu480bhsfCNBtsZBcLLnoAhJpaFP0DVm6zQLNvBO1tSgNX8D/QzKs7l219YolX
         Mu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707991099; x=1708595899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/03MR7907qqkPAwHG0qSknvAB6ItWDNRwrijCfs3NA=;
        b=b/P9MN1rBUl0ROcpaEOFDF1a2HUL9F0ePwvjSfr8H/hMFmHj8xtoQYF+6vcj/NqVlz
         L1r+w0vIe4oa0zSVIKzonL2liZhDmqfV27NW8ls0C/lGmg8C3VOuZQGe6gAXVXo5R2gJ
         H3mrKdQcka0izIsxR9jqUQFjz1IKtURIwn1gEQ0vewhzJ4d/ghrj5sLnl54TKdWPy3Q/
         oNyQDxYsZoocW8NssqH007cqkjjwBnz2+Rda/Hu4CoC13fMgEKK27Uk2kCJptrgT+L03
         X/ebDPQ2qrP14KQGwcWJYY0aaF2VGNgkizo3fJx+Ig0yjcxA5ZyYd+QB0GvNN19QJXOZ
         VSWg==
X-Gm-Message-State: AOJu0Yxh0QwIykYY/zkdHpruh61VHgv7XcjId5RdrWUvSrTVNwkMWeCG
	ImsdpFDLW0Oah7ne3gjkHhzdS5Xu84wc8KR1Jfdlw15mztf2nnhqdV6Fy8Vd
X-Google-Smtp-Source: AGHT+IEMdQMWQFcWMQzb5Cyz4fnatNGPEhuQwwHkPU47Sm291KL8f9ontAhdid262kJyfREOZe4Qsw==
X-Received: by 2002:a17:902:ce8e:b0:1d9:7121:170e with SMTP id f14-20020a170902ce8e00b001d97121170emr1736650plg.35.1707991098570;
        Thu, 15 Feb 2024 01:58:18 -0800 (PST)
Received: from carrot.. (i223-217-149-232.s42.a014.ap.plala.or.jp. [223.217.149.232])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902d05100b001db66f3748bsm887791pll.121.2024.02.15.01.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 01:58:17 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.19 5.4 5.10 5.15 6.1 6.6 6.7] nilfs2: fix data corruption in dsync block recovery for small block sizes
Date: Thu, 15 Feb 2024 18:58:13 +0900
Message-Id: <20240215095813.4189-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 67b8bcbaed4777871bb0dcc888fb02a614a98ab1 upstream.

The helper function nilfs_recovery_copy_block() of
nilfs_recovery_dsync_blocks(), which recovers data from logs created by
data sync writes during a mount after an unclean shutdown, incorrectly
calculates the on-page offset when copying repair data to the file's page
cache.  In environments where the block size is smaller than the page
size, this flaw can cause data corruption and leak uninitialized memory
bytes during the recovery process.

Fix these issues by correcting this byte offset calculation on the page.

Link: https://lkml.kernel.org/r/20240124121936.10575-1-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
Please apply this patch to the stable trees.

This patch is identical to the upstream commit.
I have confirmed that the bug this patch fixes reproduces in all these
stable trees, so I believe it should be applied to them.

I have also confirmed that the build passes and the issue is fixed on
all target stable trees.

Thanks,
Ryusuke Konishi

 fs/nilfs2/recovery.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index 0955b657938f..a9b8d77c8c1d 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -472,9 +472,10 @@ static int nilfs_prepare_segment_for_recovery(struct the_nilfs *nilfs,
 
 static int nilfs_recovery_copy_block(struct the_nilfs *nilfs,
 				     struct nilfs_recovery_block *rb,
-				     struct page *page)
+				     loff_t pos, struct page *page)
 {
 	struct buffer_head *bh_org;
+	size_t from = pos & ~PAGE_MASK;
 	void *kaddr;
 
 	bh_org = __bread(nilfs->ns_bdev, rb->blocknr, nilfs->ns_blocksize);
@@ -482,7 +483,7 @@ static int nilfs_recovery_copy_block(struct the_nilfs *nilfs,
 		return -EIO;
 
 	kaddr = kmap_atomic(page);
-	memcpy(kaddr + bh_offset(bh_org), bh_org->b_data, bh_org->b_size);
+	memcpy(kaddr + from, bh_org->b_data, bh_org->b_size);
 	kunmap_atomic(kaddr);
 	brelse(bh_org);
 	return 0;
@@ -521,7 +522,7 @@ static int nilfs_recover_dsync_blocks(struct the_nilfs *nilfs,
 			goto failed_inode;
 		}
 
-		err = nilfs_recovery_copy_block(nilfs, rb, page);
+		err = nilfs_recovery_copy_block(nilfs, rb, pos, page);
 		if (unlikely(err))
 			goto failed_page;
 
-- 
2.39.3


