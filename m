Return-Path: <stable+bounces-140933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCACAAAFA9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CACC1A87CF8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2023A1238;
	Mon,  5 May 2025 23:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJvOdEiV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227783A0149;
	Mon,  5 May 2025 23:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486929; cv=none; b=YvVBPNSzqEzqDaG4stUCpwNCkdWap/YC0ORaMwJC+vnr5iUh1izXjHyZhroiZGojIp/HG4zyIctKbI8PfWKKStKPjpHRv82B8T/IavXYqzls2her/H4cHQUl+lkhWLo04S9Ep4Osh/QIvVrmDfsj01UAb7OpjNjE3mtNmC+N6E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486929; c=relaxed/simple;
	bh=FAhPD3BsqrUlgi89cF8VGAiZWkrsoE+dVXeI3KDhXd0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=loC0lURJNSIyCMWXQKEMI1zRHp33gVnORHtEp6G+8l3R7+Wij3YtlpkJkukAEkHKdUBtRqB7E1jOuLBVjb1jQx6tOW0ckCwANmzH1GAwEBs1QtZDF07Rkc/SzyY0m/u4ANz1PqgadtO4QWqwCfVk4W+EvVRcGQtVyXjra/aVLEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJvOdEiV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D8CC4CEE4;
	Mon,  5 May 2025 23:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486928;
	bh=FAhPD3BsqrUlgi89cF8VGAiZWkrsoE+dVXeI3KDhXd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WJvOdEiVGIeKVrJYBSx/TTs4j5trlJ0y0ML0WWSnkDtb0Zs1SeR9DtICgKk1lwoFL
	 UaFL3IJsC2GhRN9AsM9bU3z7rmAY4a2Eb1isga5jWUBjFOOs0YVIsV4VJjrHyI97+j
	 ZxfpstugH/wc8uxplmfS+rEi3Asme/dF5UB+c2A9MPSY0iHe1rGrwexBWI3hVXk4Mm
	 80IJL+QTxp2u39xv+zxnX/2HMh7kFdrMqe9L5Io5l6sVw9oOKu6CeAJyRMRjtRskM0
	 r2DhYsiFIt0TzB+QO4C1urQqiFxe/KOiHUqL4qMi8EafoTqFiD3JBfDqVHUxmICRrH
	 2wYgFL1VcYcIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mike Marshall <hubcap@omnibond.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	devel@lists.orangefs.org
Subject: [PATCH AUTOSEL 5.15 064/153] orangefs: Do not truncate file size
Date: Mon,  5 May 2025 19:11:51 -0400
Message-Id: <20250505231320.2695319-64-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

[ Upstream commit 062e8093592fb866b8e016641a8b27feb6ac509d ]

'len' is used to store the result of i_size_read(), so making 'len'
a size_t results in truncation to 4GiB on 32-bit systems.

Signed-off-by: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Link: https://lore.kernel.org/r/20250305204734.1475264-2-willy@infradead.org
Tested-by: Mike Marshall <hubcap@omnibond.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/orangefs/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index c1bb4c4b5d672..0cf3dcb76d2f4 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -23,9 +23,9 @@ static int orangefs_writepage_locked(struct page *page,
 	struct orangefs_write_range *wr = NULL;
 	struct iov_iter iter;
 	struct bio_vec bv;
-	size_t len, wlen;
+	size_t wlen;
 	ssize_t ret;
-	loff_t off;
+	loff_t len, off;
 
 	set_page_writeback(page);
 
@@ -94,8 +94,7 @@ static int orangefs_writepages_work(struct orangefs_writepages *ow,
 	struct orangefs_write_range *wrp, wr;
 	struct iov_iter iter;
 	ssize_t ret;
-	size_t len;
-	loff_t off;
+	loff_t len, off;
 	int i;
 
 	len = i_size_read(inode);
-- 
2.39.5


