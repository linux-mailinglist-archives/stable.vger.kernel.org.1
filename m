Return-Path: <stable+bounces-95407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB619D8913
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 16:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D593C161F5E
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 15:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F7A1AF0B6;
	Mon, 25 Nov 2024 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzR5lic9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A8D1A0AF0
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 15:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548060; cv=none; b=jpu4xpCquQCOM3dH2IuLAdc1x+bp9LA/jYShaTvHqLv1nAAUieYzOz+qHbpPlVerjAQjrgJpbgGNmRRSuAV17JWM8aW5DgWVqQuYsSFyw4gijGTGiXKAxjkye8yRM5vE3NhGzpog3qDtyHY0CQxXEuHgMa1grM5YoV5EoRWJwhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548060; c=relaxed/simple;
	bh=nSFIGZS9DUbsKHI80DTE8TdrFy/caLej/p5mCHGDdMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXpnLgAjKIVUwlbYO0umg73iIgoZH3vz5AB5DDS1WiT2BEQH/z/p84y4nZHHFltCNd86qOdRBWMxqtBofm5dx/bnwiUNxhO/cidmJeB73Edur+RL2uuA1Nbgl6Uo8r4Wu37C0BFE8aGu9LkScJ8KWAW0xWNPnPzt7/i4vZk9YuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzR5lic9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CD4C4CECE;
	Mon, 25 Nov 2024 15:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732548059;
	bh=nSFIGZS9DUbsKHI80DTE8TdrFy/caLej/p5mCHGDdMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GzR5lic9XbDrRy72hveL1jYYibIkeixQGuIiPNMxBCR/Bq1IEQTyjhlJlGXXNTHSm
	 RNmWYA9vfKl6ZVkUx60LxUR9sm7OeM2Dum7mfOlXYFdoL+RCfOLAQFE5GWt5VXFJCz
	 tNP6OIWthKlxmjuU4PbRUtj6Bri70+Qlt2k1WPrLlK8EgoO95deGMoqwyar1TiJDV+
	 hFpRjX9BBC+LWLqXCG+Cxdu60x8E5X/Us4O93Fh1No8D32jVpZeLzNRCaMxioojIBq
	 969xe3a1Yw5KeWPg8Ih7Xtuq4pm+0UzlX7LWqygKNBMXPbHQcIrN1M2M2wa9d6hhet
	 RRjjPaLE4Ba2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6/6.1] fs/inode: Prevent dump_mapping() accessing invalid dentry.d_name.name
Date: Mon, 25 Nov 2024 10:20:57 -0500
Message-ID: <20241125094402-56c5f80b6eb265fd@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241125080401.3630757-1-xiangyu.chen@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 7f7b850689ac06a62befe26e1fd1806799e7f152

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Li Zhijian <lizhijian@fujitsu.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: ef921bc72328)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-25 09:34:22.550930390 -0500
+++ /tmp/tmp.KhG7yJ4lZP	2024-11-25 09:34:22.544724589 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 7f7b850689ac06a62befe26e1fd1806799e7f152 ]
+
 It's observed that a crash occurs during hot-remove a memory device,
 in which user is accessing the hugetlb. See calltrace as following:
 
@@ -87,15 +89,19 @@
 Link: https://lore.kernel.org/r/20240826055503.1522320-1-lizhijian@fujitsu.com
 Reviewed-by: Jan Kara <jack@suse.cz>
 Signed-off-by: Christian Brauner <brauner@kernel.org>
+Signed-off-by: Sasha Levin <sashal@kernel.org>
+[Xiangyu: Bp to fix CVE: CVE-2024-49934, modified strscpy step due to 6.1/6.6 need pass
+the max len to strscpy]
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
  fs/inode.c | 10 +++++++---
  1 file changed, 7 insertions(+), 3 deletions(-)
 
 diff --git a/fs/inode.c b/fs/inode.c
-index aacd05749c1f8..af78f515403f3 100644
+index 9cafde77e2b0..030e07b169c2 100644
 --- a/fs/inode.c
 +++ b/fs/inode.c
-@@ -616,6 +616,7 @@ void dump_mapping(const struct address_space *mapping)
+@@ -593,6 +593,7 @@ void dump_mapping(const struct address_space *mapping)
  	struct hlist_node *dentry_first;
  	struct dentry *dentry_ptr;
  	struct dentry dentry;
@@ -103,12 +109,12 @@
  	unsigned long ino;
  
  	/*
-@@ -652,11 +653,14 @@ void dump_mapping(const struct address_space *mapping)
+@@ -628,11 +629,14 @@ void dump_mapping(const struct address_space *mapping)
  		return;
  	}
  
 +	if (strncpy_from_kernel_nofault(fname, dentry.d_name.name, 63) < 0)
-+		strscpy(fname, "<invalid>");
++		strscpy(fname, "<invalid>", 63);
  	/*
 -	 * if dentry is corrupted, the %pd handler may still crash,
 -	 * but it's unlikely that we reach here with a corrupt mapping
@@ -121,3 +127,6 @@
  }
  
  void clear_inode(struct inode *inode)
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |

