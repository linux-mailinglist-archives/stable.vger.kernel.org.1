Return-Path: <stable+bounces-12321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A514C833701
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 00:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A061F224FC
	for <lists+stable@lfdr.de>; Sat, 20 Jan 2024 23:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B454514F7E;
	Sat, 20 Jan 2024 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qwh/+t6V"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB2214ABD
	for <stable@vger.kernel.org>; Sat, 20 Jan 2024 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705792117; cv=none; b=NRLKQakmuOWNgkpc9DHoQGtmwN6RuaKXst+HlsEHqkzTVmvDyTJsjZzGoHLH50k1HgANWQFN9/+FbYWB/NFerZYyksoT+hhALQzAUuY3PkubUdJBldj8Rz9jH5GXJ3s1WnFQhnHt/iE3xqiaBINn4EcFEHv+qNvo3mkTVjHuchw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705792117; c=relaxed/simple;
	bh=9fF2Mzl7hsf7wLiCxhkBAlk9xFQdduBkwE9hpqZNBWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHcyvoH9dMjGiQ8B28btRqjx3NVmS/l1KXT2m0Fsq4OiwmEgLT0yVK7K465oZ6P0Jqw3a8Hug5Qkgojq5uw1X1X6vy6fqQ1rjDs7x6k40QRqm0QvnXvMusehT974pCl+zCiQjK9bvTB1h8y1aYEOOvcBFdJ8ky3JFaTW9W20/Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qwh/+t6V; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=XkaHGMGt53SwjvP38fxIGwhU3n+LAaDVWYrWt4x1lLk=; b=qwh/+t6VGbMzPwT954U9+opLGO
	VxH6WuCucZRU5DkSfTUOMXxraAshL73pJihDm7n5wB79X1J6Ko8DqI4/k6wEvM0iwk9b/NGhTAado
	8vac6fELjzGCvjxXl6AnygIGtmsf6eIaDp1wQKw7j4zVhiIYQQJ3ndAcqvAMEYztIYEznT/VETr6E
	ADsrK5mqCgiMbH2JlWLqw/IMpedOP46b0icbbA9a2PKzK5i6BbeaqAW+sGB+6Op7Gmu2GoXRV/N9V
	IFDiOHA5AWCsmNiutWSsl7cZJpFSMtzoi+SK6Ww/nTwaCm1GmFXwlfb7juL8vxqsO93yfT30XEmtf
	nU60UYEw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rRKRu-0000000AzVy-3QZr;
	Sat, 20 Jan 2024 23:08:26 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Richard Weinberger <richard@nod.at>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mtd@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH 01/15] ubifs: Set page uptodate in the correct place
Date: Sat, 20 Jan 2024 23:08:09 +0000
Message-ID: <20240120230824.2619716-2-willy@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240120230824.2619716-1-willy@infradead.org>
References: <20240120230824.2619716-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Page cache reads are lockless, so setting the freshly allocated page
uptodate before we've overwritten it with the data it's supposed to have
in it will allow a simultaneous reader to see old data.  Move the call
to SetPageUptodate into ubifs_write_end(), which is after we copied the
new data into the page.

Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ubifs/file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 5029eb3390a5..40a9b03ef821 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -463,9 +463,6 @@ static int ubifs_write_begin(struct file *file, struct address_space *mapping,
 				return err;
 			}
 		}
-
-		SetPageUptodate(page);
-		ClearPageError(page);
 	}
 
 	err = allocate_budget(c, page, ui, appending);
@@ -569,6 +566,9 @@ static int ubifs_write_end(struct file *file, struct address_space *mapping,
 		goto out;
 	}
 
+	if (len == PAGE_SIZE)
+		SetPageUptodate(page);
+
 	if (!PagePrivate(page)) {
 		attach_page_private(page, (void *)1);
 		atomic_long_inc(&c->dirty_pg_cnt);
-- 
2.43.0


