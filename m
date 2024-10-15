Return-Path: <stable+bounces-85389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7D099E71A
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0411E1F23EAB
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA98E1CFEA9;
	Tue, 15 Oct 2024 11:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jExStigZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83471D89F8;
	Tue, 15 Oct 2024 11:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992949; cv=none; b=FjXkhoJZXzh8XnSxG3QvhJ2zVCjf5dbHWqYeZxDsTIrGfZ5XO9RtL6BE34sUCyEinFIQOgw6Vap/Y6lzozi9IlgebjrmHUm9SVcghYrVkmTHCONbXmKJHtaYu8/c/LzVhi6AYoVOe3qp0fp4ZHpkeeNCV55IIax6n2/PZE4pZfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992949; c=relaxed/simple;
	bh=eD5lzpE1takFaAR8EQXSaNguU4FbKP5ORL5ES0t2Bi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thMWDFHwtP/cmcy3XsKDuE1aOmNTE6UN32cEixS6lFWQf7Aw6RVXXkpnfUQdj9FdBaXEwImFnULQqW/pHm7wOrt8kS2ESS3aUUbYrRPoiGU60+yAjsBD0+rnujSDIdhROxIMqUsRUHpjXfCnbeiE77r3jR5ZmP1Q+Nk0kaLRWRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jExStigZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19732C4CEC6;
	Tue, 15 Oct 2024 11:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728992949;
	bh=eD5lzpE1takFaAR8EQXSaNguU4FbKP5ORL5ES0t2Bi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jExStigZ6F6UPVI+71gv10z9E/ZtetnkqeuH6zfRHGl8Zz7qS/ZM6tdxAwWEjlZMQ
	 BQuxSufxf0f+1RREDGKODBXeF6ita6h4z8g0ui9Ut8gMjan6Vty2Pdf6QzfcEP4BJI
	 mTAuAJ6vKdael+wWl21zihMHhWmitcaXZrBR6Jtk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jack Qiu <jack.qiu@huawei.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 266/691] f2fs: optimize error handling in redirty_blocks
Date: Tue, 15 Oct 2024 13:23:34 +0200
Message-ID: <20241015112450.906620603@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jack Qiu <jack.qiu@huawei.com>

[ Upstream commit a4a0e16dbf77582c4f58ab472229dd071b5c4260 ]

Current error handling is at risk of page leaks. However, we dot't seek
any failure scenarios, just use f2fs_bug_on.

Signed-off-by: Jack Qiu <jack.qiu@huawei.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: a4d7f2b3238f ("f2fs: fix to wait page writeback before setting gcing flag")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8551c3d3c2340..2f2cd520f55d6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4011,10 +4011,10 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 
 	for (i = 0; i < page_len; i++, redirty_idx++) {
 		page = find_lock_page(mapping, redirty_idx);
-		if (!page) {
-			ret = -ENOMEM;
-			break;
-		}
+
+		/* It will never fail, when page has pinned above */
+		f2fs_bug_on(F2FS_I_SB(inode), !page);
+
 		set_page_dirty(page);
 		set_page_private_gcing(page);
 		f2fs_put_page(page, 1);
-- 
2.43.0




