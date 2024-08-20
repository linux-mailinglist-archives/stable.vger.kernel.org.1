Return-Path: <stable+bounces-69690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D444E958182
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 10:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89DF71F250AE
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 08:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA5A18A92D;
	Tue, 20 Aug 2024 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FH9HZIgh"
X-Original-To: stable@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C2F18A938;
	Tue, 20 Aug 2024 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724144195; cv=none; b=bfYIlakQzv4acL3RiwlkHKhGVZ8BTFayIZmUpwfT6o1X9LzOnrAEwN1gBdOQKO5RPbNhgo7boMaSJ9RDEvyZJB8dOcR7TVk5mQZqJ9ct7IT3aJ8EUpJeDd+kXLtR3x0DTC721lcYfxQhWt574ckq9bTsngcLPoLIWhv05TM1znI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724144195; c=relaxed/simple;
	bh=iWh8sKb0yUGhqZjx2Qm+qFE6HQ4fbWSlm28WBhoR0gU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKiFN8eF6qox848PrHg1rUbwi3zLWdXIx3bQB80S7TfInRWZgFd+T+wSKW5OLszToY+P+jx6LqARRJW7Zd2c2kGv9O2IDgQ+GJ89ycqq2eq4JX0JxflJjDKyhevTSPtK7UARWWjY5N9Z5sAHeLrZxagqh0ylbkN6hDAxQfBWJxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FH9HZIgh; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724144183; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8uaDmpfMNQCpCM0aUgKOkD6ZL9TOLlGfVf7ZQ6Vh07k=;
	b=FH9HZIghQ9caiTNTW1wr/HM8Fb9p5lMsxm7tqUuDfUyg2DMQPjDuX9BphvQfYw26wwyFNQoblxLlYB4zOt6Wqy1+VcDf2Gi84vMkW0oUT8e+lzE+s/Rq+mAaodaqcVUMS2ISqGalpjl9OqE5vQvD3pzYxAoIaiFw5N/TpjhIBPo=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDHzSAl_1724144181)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 16:56:22 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	syzbot+242ee56aaa9585553766@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Chunhai Guo <guochunhai@vivo.com>
Subject: [PATCH RESEND] erofs: fix out-of-bound access when z_erofs_gbuf_growsize() partially fails
Date: Tue, 20 Aug 2024 16:56:19 +0800
Message-ID: <20240820085619.1375963-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <000000000000f7b96e062018c6e3@google.com>
References: <000000000000f7b96e062018c6e3@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If z_erofs_gbuf_growsize() partially fails on a global buffer due to
memory allocation failure or fault injection (as reported by syzbot [1]),
new pages need to be freed by comparing to the existing pages to avoid
memory leaks.

However, the old gbuf->pages[] array may not be large enough, which can
lead to null-ptr-deref or out-of-bound access.

Fix this by checking against gbuf->nrpages in advance.

[1] https://lore.kernel.org/r/000000000000f7b96e062018c6e3@google.com

Reported-by: syzbot+242ee56aaa9585553766@syzkaller.appspotmail.com
Fixes: d6db47e571dc ("erofs: do not use pagepool in z_erofs_gbuf_growsize()")
Cc: <stable@vger.kernel.org> # 6.10+
Cc: Chunhai Guo <guochunhai@vivo.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
RESEND:
 Add missing link and reported-by.

 fs/erofs/zutil.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index 9b53883e5caf..37afe2024840 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -111,7 +111,8 @@ int z_erofs_gbuf_growsize(unsigned int nrpages)
 out:
 	if (i < z_erofs_gbuf_count && tmp_pages) {
 		for (j = 0; j < nrpages; ++j)
-			if (tmp_pages[j] && tmp_pages[j] != gbuf->pages[j])
+			if (tmp_pages[j] && (j >= gbuf->nrpages ||
+					     tmp_pages[j] != gbuf->pages[j]))
 				__free_page(tmp_pages[j]);
 		kfree(tmp_pages);
 	}
-- 
2.43.5


