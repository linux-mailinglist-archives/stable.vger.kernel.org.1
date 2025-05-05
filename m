Return-Path: <stable+bounces-139987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7360AAA35F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0CAB1888916
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A850A283FC3;
	Mon,  5 May 2025 22:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mx9VpjFz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642EA2F231D;
	Mon,  5 May 2025 22:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483830; cv=none; b=OQA0Qu7cR95BEouWBpILoY4e+M2zDwlPmgOFNDLUPdvHjz4ijryK+Or+eCEaKHgO7Ma7L1FZd+XGLBFibCuR6UcBg2gHCxNJ07N7uIQ0QZiwJXNGxLvNqsI2Uaco0uxOJN/0AAXM9Xkg4WMbWC83vpJvL5iVmXxxMcGb5oF9lDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483830; c=relaxed/simple;
	bh=EB1GnnZT7mucs92J9m0dnFJwYjl6rxK5W6sSbkkOZoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EZZrc0HIl5JPU3nTnQMjd4Vo4mMORKgABgJ1+Ip21ImZRHS1pe5qVsYzXzo6EbcHcUnOdcR6SOYFlk0l4Hbrc7RmqtSG4ByKL6zgDTjoluNzOqvlGAo1WuqE6X0O8fshZl+M8SoXgD9vDCbtgQwhvIUSisTVLuMWccAg2dvGV44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mx9VpjFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758B4C4CEEE;
	Mon,  5 May 2025 22:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483830;
	bh=EB1GnnZT7mucs92J9m0dnFJwYjl6rxK5W6sSbkkOZoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mx9VpjFz1oN52ftmAUnZQu8yimzeDSCD+J1EqIH2sRxyF3q7RKZGs69YXqjAfCkNP
	 beHxVhxB02qF7rKCmmkQ+Ubv3NafEPO3eBB1aYop9vyzhcM9CjgaXAHLPGfZMJ6hoI
	 KC6ekM0FjNbyKu5rLBNrdTvG140msvRzzyio4EICElBh9LzD7KcCJ3O1IA0gb88QM9
	 NqVvvQNGGoi7qtaKmFpOa31xyavLvPgHXeOh1F+KRKBX+138BYwxV5QHKTra6NKZsy
	 jFoKEDfuYS+STDNHztjkj0zEo4UzXFmmwWszpAzIZ+crHn29wNzDpmtncxYDsosN2O
	 J03oY3l/ut76g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mike Marshall <hubcap@omnibond.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	devel@lists.orangefs.org
Subject: [PATCH AUTOSEL 6.14 240/642] orangefs: Do not truncate file size
Date: Mon,  5 May 2025 18:07:36 -0400
Message-Id: <20250505221419.2672473-240-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index aae6d2b8767df..63d7c1ca0dfd3 100644
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
 
@@ -91,8 +91,7 @@ static int orangefs_writepages_work(struct orangefs_writepages *ow,
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


