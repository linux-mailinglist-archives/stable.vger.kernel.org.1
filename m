Return-Path: <stable+bounces-68543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACB39532DA
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8C2DB22B2C
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD27E1AC427;
	Thu, 15 Aug 2024 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sq6uvZrN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C11A44376;
	Thu, 15 Aug 2024 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730901; cv=none; b=D2XxHjOgA7kHHnOaYt/rWP85YzqH5yAYoTEbTE6eWvj1KUsf9UM0dcIHh0zhkl0YfD5TvLimpXJ2QWN5q4qlBGEHYtWH9PUNm2svOnUmmIdd2lAPueiuGDGJCHy2I/Kq5Plz2EuzS+hmWvcVXVXxe9iUXOXF+M1MTDK5Z2UM4Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730901; c=relaxed/simple;
	bh=50ZwpOstUmYkDYBi2NnkghgtLvlzo/ZrLNT7DeG97Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CoqaXk0L2pWv/+iL0s1pkoueiu2X6m6KBg6PX7Hq+JBUNVMB3lPRztKgctQsXsKr3q2Wyk9iOJz/1l3zKNz7AWClZMHFVNCPRwRQtbAfkGTg7dUaq00qsfHmIa1qfMfCol8bKhrlp6GRy1Bm2byryXzv+IMio5+08iFKyOSirAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sq6uvZrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B3FC32786;
	Thu, 15 Aug 2024 14:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723730901;
	bh=50ZwpOstUmYkDYBi2NnkghgtLvlzo/ZrLNT7DeG97Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sq6uvZrNbws2EX9xLiwcudGOzsJVZWWlTisjApS0TsN2RTMGUmpygBy/Mvekhcoqu
	 iFopNnaWTNyVwcwEvAnd4p9UqfrpOF1821ChXienuukaYMaqZuPGUErI28Ez/0f7jW
	 JEgbYxYfAZpPseKUqNRtsPh14Jk2JTDm2wE3jqZA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+411debe54d318eaed386@syzkaller.appspotmail.com,
	Manas Ghandat <ghandatmanas@gmail.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 29/67] jfs: fix shift-out-of-bounds in dbJoin
Date: Thu, 15 Aug 2024 15:25:43 +0200
Message-ID: <20240815131839.446390501@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131838.311442229@linuxfoundation.org>
References: <20240815131838.311442229@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manas Ghandat <ghandatmanas@gmail.com>

[ Upstream commit cca974daeb6c43ea971f8ceff5a7080d7d49ee30 ]

Currently while joining the leaf in a buddy system there is shift out
of bound error in calculation of BUDSIZE. Added the required check
to the BUDSIZE and fixed the documentation as well.

Reported-by: syzbot+411debe54d318eaed386@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=411debe54d318eaed386
Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index cb3cda1390adb..8eec84c651bfb 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -2763,7 +2763,9 @@ static int dbBackSplit(dmtree_t *tp, int leafno, bool is_ctl)
  *	leafno	- the number of the leaf to be updated.
  *	newval	- the new value for the leaf.
  *
- * RETURN VALUES: none
+ * RETURN VALUES:
+ *  0		- success
+ *	-EIO	- i/o error
  */
 static int dbJoin(dmtree_t *tp, int leafno, int newval, bool is_ctl)
 {
@@ -2790,6 +2792,10 @@ static int dbJoin(dmtree_t *tp, int leafno, int newval, bool is_ctl)
 		 * get the buddy size (number of words covered) of
 		 * the new value.
 		 */
+
+		if ((newval - tp->dmt_budmin) > BUDMIN)
+			return -EIO;
+
 		budsz = BUDSIZE(newval, tp->dmt_budmin);
 
 		/* try to join.
-- 
2.43.0




