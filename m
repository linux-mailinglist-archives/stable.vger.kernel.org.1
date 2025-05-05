Return-Path: <stable+bounces-141066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D853AAADAC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF16A4E088E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7057B30D241;
	Mon,  5 May 2025 23:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnSkk5gD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AA53BBDDC;
	Mon,  5 May 2025 23:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487369; cv=none; b=C7fEneOb98N/k37QID0AFBv0Y+EhJ99W+E3MFOehuNzXq8b06hb4HnevJFWnsHWLMbEabN6tAbibzdRRfYsWCNh5X3J7xi8i5OJwsOLQJElK6egsufWXEVxnoeCSMg2fV7zt3G8ORk+Ve8ZCWsD8N2CKQCkZSzENbh3c+N3FirA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487369; c=relaxed/simple;
	bh=L5sEatoPjyM4mHaAjsx8JKfwAoeHsbDmu6JdEp7O9lI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kCSrxjmfkOYmswrsH1tcMdSESsuZH8EFGMolWxh0MPakU0kIA7xYwiDRzdzYv17S4Q1POqfCWcI3rwHv8DXrRd6ldwsHq1w1Bw0Q2mPgyOeldoi+6aXD04kgzfQ+h7khrbVyNhH3cWf5I0IAELx53Hm277NPFzc1Sj9X+o0qvM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnSkk5gD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD13C4CEED;
	Mon,  5 May 2025 23:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487367;
	bh=L5sEatoPjyM4mHaAjsx8JKfwAoeHsbDmu6JdEp7O9lI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qnSkk5gDgMxf3J5988Vj6qRoAUJYmvwNey4Z1d/WaU+UYseE1s7kZdbyZbvF7tqwz
	 prUuLgwbl0KzvJgmINtNDXiQGPOeEKbhoI/2LGFAm9jWkGWRmv22CHmSBuiSCy8CWD
	 c/PE1dA9V1ZCfsi6qR/eNszCHS6fgWavrAzkxBynDsrPUe3952FuWL3HU6yMlR1nfT
	 V6qKHlZFHHIilLvx+ZCH/Ie8wtODsK24CyZoxuX5tRaj9kn3juBzTZ97/Nf4+1H119
	 D499DjRgYrws1wpE7CIlBzHwIkQtF8mXdRrgBsGdCcU9XaRyfN+CQ+MMLS3pWWxSrL
	 oqgCAk1QrF/fw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mike Marshall <hubcap@omnibond.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	devel@lists.orangefs.org
Subject: [PATCH AUTOSEL 5.4 33/79] orangefs: Do not truncate file size
Date: Mon,  5 May 2025 19:21:05 -0400
Message-Id: <20250505232151.2698893-33-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
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
index 636892ffec0ba..238773a508bac 100644
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
 
@@ -98,8 +98,7 @@ static int orangefs_writepages_work(struct orangefs_writepages *ow,
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


