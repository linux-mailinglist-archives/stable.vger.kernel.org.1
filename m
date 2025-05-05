Return-Path: <stable+bounces-141693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7222AAAB5B6
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B595E3A4A4F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27613AE03D;
	Tue,  6 May 2025 00:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdgsHApE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DE22F7C5A;
	Mon,  5 May 2025 23:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487180; cv=none; b=P7MK1h/qUxfeijQBGn7vwudk+jf6PaFwSwDOZBxWBDF5yKe9aNjQeOehcZqvHpJ4xCoUoIWsTJE5kjpjgRz43MZxfjWOPWiTuap+K1Jh3ya//W5FgXiqfjvYBOePBD3PRAH1yEx9HydSIyDUMeIFi+Hyw5Q6RUyIc/19kpDVMpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487180; c=relaxed/simple;
	bh=VB8ZGSyJuAItWpCVh8ohvazWLOFRbppw6ILeU3tIXY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JKxezTVvNhDFDa1PcMiPa4MPZelJXALiRM0chmeuRLaLRk/kmJ9o1vJqEUsZ6tcRftCPrtexAhQAi76j+X5KFlBqog11kvPvWl/ABafrBLKBrdpz/oIE0f9RyaB3Y/fLRY98WHiJUuYlZ/9tGWiV0zzLFgur4EziYpEI+6R9ufQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdgsHApE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EA1C4CEEE;
	Mon,  5 May 2025 23:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487180;
	bh=VB8ZGSyJuAItWpCVh8ohvazWLOFRbppw6ILeU3tIXY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EdgsHApEs9pq5CuuEK/YKbQCoCQ6h1kPi5Yv9sEYjOcwja1B0ZLZnQiEZ89OVRh74
	 gnEsRdTvj7cYdqlTK/A5aCP+adBSNubw5LtyzRDfYdJNpvMyzMpzI9ObVqvlZCx7z4
	 S+ildFYCt0kxvzZankLh+M15c7ZsfyVRLthknpriLCOoeBJM3SA+FeWGbiW+cM0p1u
	 M8NJLg6COF4ttAhVjJw5YjG08RZD8JM/V7uxCBb7oMhRKIf1RNHJF3dKXWo/lfaNG4
	 gyj/QgwTdDRSxbwnPI6bJZWvi1r+esofOCXA/ihkL9fAAzvdwNcygzUpYA6FioMlGx
	 av+JTxMbwP3sg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mike Marshall <hubcap@omnibond.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	devel@lists.orangefs.org
Subject: [PATCH AUTOSEL 5.10 045/114] orangefs: Do not truncate file size
Date: Mon,  5 May 2025 19:17:08 -0400
Message-Id: <20250505231817.2697367-45-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index 48f0547d4850e..cd70ded309e47 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -22,9 +22,9 @@ static int orangefs_writepage_locked(struct page *page,
 	struct orangefs_write_range *wr = NULL;
 	struct iov_iter iter;
 	struct bio_vec bv;
-	size_t len, wlen;
+	size_t wlen;
 	ssize_t ret;
-	loff_t off;
+	loff_t len, off;
 
 	set_page_writeback(page);
 
@@ -93,8 +93,7 @@ static int orangefs_writepages_work(struct orangefs_writepages *ow,
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


