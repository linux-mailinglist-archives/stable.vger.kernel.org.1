Return-Path: <stable+bounces-15731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A900E83B0DD
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 19:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 163B2B35E15
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 17:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D793512AADD;
	Wed, 24 Jan 2024 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GpzadNX7"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D217281ABA
	for <stable@vger.kernel.org>; Wed, 24 Jan 2024 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118791; cv=none; b=etlRCPYQh0S+TrLZGijcwbAgMDfKTaF2HMJqQZkc9KoUGS17RtrGfXv0xvvAZEvrbpvbK/e7Qd2VRPSvdYWvAnyKVEZTcEft3Hb/qphtai09mnK3c68NA7/hHRsHTA+XqeNTXquOMumuUfz+nUlzPCwkpYyVAKjXyuAT1tyJlKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118791; c=relaxed/simple;
	bh=PbRocE61KW0yDkiOR60kDrwRlsBBjr5ay8hv50KUPTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQ4rxUQrOkt67szo89IKE1/QxIwGX/AkhQSYp48VZB5XkAfRtcBbwmuEpG5+8zcKQzAwR9hoOawIc47KjWT2XD4eHzrJw2BNkWJve22SRt7Pv+dIfBzdtG9vboh5JQs0sb2YcephYX/p9I0fUV2BT9kOoDLGH5gayJcdXMVQ6RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GpzadNX7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=4BLcXtunv8K55EIbLY6Cz+Ba9KEcTs01x6W2txMgvd4=; b=GpzadNX7vKAg0W1zJQWMGP7nCA
	hAnJIOYgyBkTKcMI2XJly6GLL1gfJal3ppuBSXC2I7G3rXSvMwhZdSysVwJkg8b7XeGLtvJIhO51R
	bBD4ZFNAwtKm6d4N5PdxWgFxE2et9YXSw0a8leQbv8KBQ/KmTnFRZvfrhkKmkX5zsnONCs5sGsskR
	9lEb1/MZRDfTZ77H0QdkNIlaOJ7dHF4rPrMWfyg1anktS/AxY7xYAkgNQi0szLNBCvNB14vJicKou
	vvS0PPM/+9thoNkE+N5R+w0tfm6TPL0lmi2dMod1Fbp9fFszvXVjcAtpWKF0bPDBffMu2eZOu8j2q
	yTYeDm0g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rShQu-00000007LVL-3I7V;
	Wed, 24 Jan 2024 17:53:04 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Richard Weinberger <richard@nod.at>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mtd@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH v2 01/15] ubifs: Set page uptodate in the correct place
Date: Wed, 24 Jan 2024 17:52:44 +0000
Message-ID: <20240124175302.1750912-2-willy@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124175302.1750912-1-willy@infradead.org>
References: <20240124175302.1750912-1-willy@infradead.org>
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
 fs/ubifs/file.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 5029eb3390a5..d0694b83dd02 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -261,9 +261,6 @@ static int write_begin_slow(struct address_space *mapping,
 				return err;
 			}
 		}
-
-		SetPageUptodate(page);
-		ClearPageError(page);
 	}
 
 	if (PagePrivate(page))
@@ -463,9 +460,6 @@ static int ubifs_write_begin(struct file *file, struct address_space *mapping,
 				return err;
 			}
 		}
-
-		SetPageUptodate(page);
-		ClearPageError(page);
 	}
 
 	err = allocate_budget(c, page, ui, appending);
@@ -475,10 +469,8 @@ static int ubifs_write_begin(struct file *file, struct address_space *mapping,
 		 * If we skipped reading the page because we were going to
 		 * write all of it, then it is not up to date.
 		 */
-		if (skipped_read) {
+		if (skipped_read)
 			ClearPageChecked(page);
-			ClearPageUptodate(page);
-		}
 		/*
 		 * Budgeting failed which means it would have to force
 		 * write-back but didn't, because we set the @fast flag in the
@@ -569,6 +561,9 @@ static int ubifs_write_end(struct file *file, struct address_space *mapping,
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


