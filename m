Return-Path: <stable+bounces-147355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E4EAC574F
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87DE4A6BE5
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A7827CCF0;
	Tue, 27 May 2025 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SoFrzF9B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7DB1AF0BB;
	Tue, 27 May 2025 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367086; cv=none; b=USRmTS2tAItZL7SS927B3+GqcgyDvHv+VPyXNrJ4rUxXsYKmY9PI+0/GisFiid5jJC3wNPb0j0ENkMwJYkNowh8LYxTvusmya8AoihjjhxsycnQGYhXB7S7FlTdNi1jxCw1GI9cjr5yBspiaj9dORaSfOn1hme4lZk0Et6KtDR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367086; c=relaxed/simple;
	bh=ZT1Gg0E/qR9+7xC620eBe14irxPgUOMdnfMwBRWsC1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bs35KwIXT52BA4GHLKHcZm3a8ZBwRS87olYFB9al++vMZ3z2+7SNIQPAN7mPGEEyWD0tIEw1nR2iw9WtU5tFsIylr/OCx6tjXbNzT6lp9wNAXADHzLMmFyaSqQoLbDfqczZvhiDRACmd+q7EOJMF33qFAjZxE8pv+NCjuYAyM3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SoFrzF9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3799C4CEE9;
	Tue, 27 May 2025 17:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748367086;
	bh=ZT1Gg0E/qR9+7xC620eBe14irxPgUOMdnfMwBRWsC1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SoFrzF9Bl3b58bru9lzGYUzYUkm9QJErgcdKFuQqfBN2krHQnAti+umq9Ko5lWqBb
	 w8pWuZA0u3NQpvB3cCj2f6i0GGugQwH3VXapEO5eQr3hvRDmPYEbWKRrxesE0WUrYa
	 AGr8DbGFTXGGu26zuwdsWH24bnJYns/+HakaS1Kg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mike Marshall <hubcap@omnibond.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 273/783] orangefs: Do not truncate file size
Date: Tue, 27 May 2025 18:21:10 +0200
Message-ID: <20250527162524.204464604@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox (Oracle) <willy@infradead.org>

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




