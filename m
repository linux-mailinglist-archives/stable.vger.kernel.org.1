Return-Path: <stable+bounces-34397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E331893F2F
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907D21C2162A
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B7F47A5D;
	Mon,  1 Apr 2024 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AkFWuzFN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BE443AD6;
	Mon,  1 Apr 2024 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987983; cv=none; b=D6wazCsC/BbazgX7tmVsBlgn+5NcE87+t+hvMq9e6jQ2RGgJiLP+yWql7A83VKGrN7Io8Oli2q/cu5IA0HYrpH9bkjMatpkH5jqxFP1SAkepfzEYfqrF3J3wwDAweyTLLKwOW/xsCR6zf5niUju5fay+bY1GYTNGeqKO9+acqJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987983; c=relaxed/simple;
	bh=BYuxlt+smDeVT9tjQ0libUNt497HZlYBRzBExw/vbH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAj5/7Ja+xer4PMIC8z4W+B9qscb/8V5MH1+XqDI+5iLL9UNI0w7eeLTUSLhePLMvWcKc00tOOZuDeDvEx0HsdlxeO3Mt2CsRg/bPBOWLPCBy/qUpwCHTA1SZdmfft5Jz/w/HCawhHXT1LIrShssIOtHf/3qQfuFUiv2tQUnrQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AkFWuzFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8F0C433F1;
	Mon,  1 Apr 2024 16:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987983;
	bh=BYuxlt+smDeVT9tjQ0libUNt497HZlYBRzBExw/vbH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AkFWuzFNcaYzn8Bpmc7DHIb2eRuTInqX3BnxP/F483tPVIm6OXFfnoBtZDW8MTaf4
	 CvVY1+ulxGLTGl90puqTTxhsSmBxXpkGm1Ak3mTmbkNBmHKxpvFSPcBbwW/xs4FHU0
	 vT+AWxM0ON7n7TS8xhxEUYu1NPhMxEUztmBR053s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 050/432] ubifs: Set page uptodate in the correct place
Date: Mon,  1 Apr 2024 17:40:37 +0200
Message-ID: <20240401152554.620491464@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox (Oracle) <willy@infradead.org>

[ Upstream commit 723012cab779eee8228376754e22c6594229bf8f ]

Page cache reads are lockless, so setting the freshly allocated page
uptodate before we've overwritten it with the data it's supposed to have
in it will allow a simultaneous reader to see old data.  Move the call
to SetPageUptodate into ubifs_write_end(), which is after we copied the
new data into the page.

Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ubifs/file.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 2d2b39f843ce9..abf4a77584cf4 100644
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
@@ -462,9 +459,6 @@ static int ubifs_write_begin(struct file *file, struct address_space *mapping,
 				return err;
 			}
 		}
-
-		SetPageUptodate(page);
-		ClearPageError(page);
 	}
 
 	err = allocate_budget(c, page, ui, appending);
@@ -474,10 +468,8 @@ static int ubifs_write_begin(struct file *file, struct address_space *mapping,
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
@@ -568,6 +560,9 @@ static int ubifs_write_end(struct file *file, struct address_space *mapping,
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




