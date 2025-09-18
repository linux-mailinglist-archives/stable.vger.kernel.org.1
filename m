Return-Path: <stable+bounces-177157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73403B4037B
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34F153AE812
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94608272E7C;
	Tue,  2 Sep 2025 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FCu1B8X0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0F930DD34;
	Tue,  2 Sep 2025 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819765; cv=none; b=Ax6Uf+KyXjQHVPmW1YVAEZH8i5FEM6tn3LcFnQv9zWOjkT3gAnQE1IpPybMH0H5jCOE0fmkMxp57tUF086o6BmbB9J4MUlUClnQ4D13vlziADoIyAXeFoblIJmHLfdlYZj5aAOYr+XsKvFRoHI76m8TqwJfWEzCwjri71whI2dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819765; c=relaxed/simple;
	bh=psjcQ4UQYahFVEgCFiTMFuA2BQ66D0iGmw2IFXsuuds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/slL0ExGNplpt5AQrniLxJujBjkcweoR8LtqSqn2WC8uPcV7uhRFSAMJj0CRCP2CvmNXxen6HnDXaSzjxu1p0HtgTJLvJ+0fZDNLaw6DVnDMNNmw4MU12HjaVTAadAGjv9e1BUGx9SlEx4KRiczq91I5kEXrOCWTMAzkpFk0KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FCu1B8X0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFBCC4CEED;
	Tue,  2 Sep 2025 13:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756819765;
	bh=psjcQ4UQYahFVEgCFiTMFuA2BQ66D0iGmw2IFXsuuds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FCu1B8X0bL8SpIG0aWzjqJloCE6LAYoHcPslQU6vTc4f8lPOGw2nWnHowDv2i42cc
	 YrqO5TExQD+v3XXB9IcWNywyg7OMaryumbaG/oeGaR4Fn73Xl0KIdFGmNcPXzWix9D
	 eeR2mEQEaqxr+RjeBptEol9bu5XZRCjsbozh4nEM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Nan <linan122@huawei.com>,
	Wu Guanghao <wuguanghao3@huawei.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 100/142] efivarfs: Fix slab-out-of-bounds in efivarfs_d_compare
Date: Tue,  2 Sep 2025 15:20:02 +0200
Message-ID: <20250902131952.109101405@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131948.154194162@linuxfoundation.org>
References: <20250902131948.154194162@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Nan <linan122@huawei.com>

[ Upstream commit a6358f8cf64850f3f27857b8ed8c1b08cfc4685c ]

Observed on kernel 6.6 (present on master as well):

  BUG: KASAN: slab-out-of-bounds in memcmp+0x98/0xd0
  Call trace:
   kasan_check_range+0xe8/0x190
   __asan_loadN+0x1c/0x28
   memcmp+0x98/0xd0
   efivarfs_d_compare+0x68/0xd8
   __d_lookup_rcu_op_compare+0x178/0x218
   __d_lookup_rcu+0x1f8/0x228
   d_alloc_parallel+0x150/0x648
   lookup_open.isra.0+0x5f0/0x8d0
   open_last_lookups+0x264/0x828
   path_openat+0x130/0x3f8
   do_filp_open+0x114/0x248
   do_sys_openat2+0x340/0x3c0
   __arm64_sys_openat+0x120/0x1a0

If dentry->d_name.len < EFI_VARIABLE_GUID_LEN , 'guid' can become
negative, leadings to oob. The issue can be triggered by parallel
lookups using invalid filename:

  T1			T2
  lookup_open
   ->lookup
    simple_lookup
     d_add
     // invalid dentry is added to hash list

			lookup_open
			 d_alloc_parallel
			  __d_lookup_rcu
			   __d_lookup_rcu_op_compare
			    hlist_bl_for_each_entry_rcu
			    // invalid dentry can be retrieved
			     ->d_compare
			      efivarfs_d_compare
			      // oob

Fix it by checking 'guid' before cmp.

Fixes: da27a24383b2 ("efivarfs: guid part of filenames are case-insensitive")
Signed-off-by: Li Nan <linan122@huawei.com>
Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/efivarfs/super.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 284d6dbba2ece..5c0d45cccc10e 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -152,6 +152,10 @@ static int efivarfs_d_compare(const struct dentry *dentry,
 {
 	int guid = len - EFI_VARIABLE_GUID_LEN;
 
+	/* Parallel lookups may produce a temporary invalid filename */
+	if (guid <= 0)
+		return 1;
+
 	if (name->len != len)
 		return 1;
 
-- 
2.50.1




