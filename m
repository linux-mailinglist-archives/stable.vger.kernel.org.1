Return-Path: <stable+bounces-141516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A94AAB73B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8A73B0121
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A892949FB;
	Tue,  6 May 2025 00:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bELJILS/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4422280CCE;
	Mon,  5 May 2025 23:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486555; cv=none; b=Y9PMKjjP13buBs5SQ6ycJT01SLGzTV9oe1zNfrwxriVap1E5Bnw6p07o+LAcstbzZ/ekz0PLgTJ5NG5Hg+2CXXzdKbp0zrrjvotd+u93UacQyEfEeJOZbXJkWjlfz6u6SHZxNLCywTAXDEInB8RWYLFEPQrysobDip9O9lsqhm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486555; c=relaxed/simple;
	bh=VLmPVKRTDLh7bBgAVXDRQ5oH+GsZgA6fXTxvCcWcfz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hamiWJmsyuiNLi5/hmjce0zqfK1sCzG34cwGH1ADxn3sCGYOQZgpeoJwg/lTvWPsRy3IhXGMFlATPDCV0dezpI+235fgCl7GclRiPqKJ3d1FkjXA5r1h0bw/uPvv7TdEShcvYIBT/ZD+sUOL1K19MOwchymgxoqxexAHxrWgo3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bELJILS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5874C4CEF1;
	Mon,  5 May 2025 23:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486555;
	bh=VLmPVKRTDLh7bBgAVXDRQ5oH+GsZgA6fXTxvCcWcfz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bELJILS/z5T5f3ZiqUE1zD8FLrKx24x4PwGYLjWLFI/fGuyMezzYOVLvGue0oB1lt
	 /tGKkt6rbyJ003aWxC30EYLybJTiYZbku5R04HyknJr81WdBquppnoBlKfWFqB7saA
	 cDbzCEkKhARBjg+OBq/LkV7Z/Auy1HNbacPk18Qm+L5itpiw7MIqZEJ3m0+GNPvtM6
	 tVwzwCsnUrOXhvi8Bd7dEhWwYf6mO/2Q+LkwdV4GRrSMVR3P8GX8F62K5n/euhFRMs
	 f1CpOddvfuCr/YrzYk2Thrr5vuxDfQojZdktaXVgbSY8mKdjn2z3oNlqnHv1Gx0W0d
	 elUVXE4+mQvpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mike Marshall <hubcap@omnibond.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	devel@lists.orangefs.org
Subject: [PATCH AUTOSEL 6.1 089/212] orangefs: Do not truncate file size
Date: Mon,  5 May 2025 19:04:21 -0400
Message-Id: <20250505230624.2692522-89-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index b3bbb5a5787ac..cc81ff6ac735e 100644
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


