Return-Path: <stable+bounces-69686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC62958132
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 10:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B00AAB21A56
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 08:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D62518A928;
	Tue, 20 Aug 2024 08:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i/fgr7Ww"
X-Original-To: stable@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C1218A6C2;
	Tue, 20 Aug 2024 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724143378; cv=none; b=OI1/y0FCHovnVwgdamFwYJljgDfwJM8NXGrESFl8hd684vpk7MAikARIhKWdCbqPOOQHUCRpCSPEJ4u1uM7xB/ayHyxi8hw9l7ZMMwcIHqxaoXxiibW+X4kPlIz/7N8qfwYKZUNNyquMMrdb4nO1F4K3JSBps9YUP+6VxoZaW/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724143378; c=relaxed/simple;
	bh=2ADMSSnxj95Vez5zAq6a5RYGc4V3FqFN2H9zYFWUj18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCtoTLyAYpQAR56N0apdwdT5A90x5vufJ2CehwdPgfaGlJD0v5iAEwr/Ta8KBlGB313KCvcaZIgSb5+gBj9LaafKwWCkG8mnDeo1zggR53+cl+3BL4eeme2dqv22XyKzUQRUFtiy7awdpQslC2siw0wM72/lsyBRpynULObnim0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i/fgr7Ww; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724143372; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zSU3ZuEA3dA+56IDYHfcCAO49YuI8Kb2yUbkZ45XGow=;
	b=i/fgr7WwM/gykOdetpwN8G9jDJKj4YKGaatTdgxH+Rsu6HEqG92OzTiX/+A0gF4h6aGaiVA1u1+z+HAJ7H8g9P1xQwBNng7Znh8LsOENsiehFgQ0zy1XLhbSmF65sGQCuZK9jHjw5C69Q5cGhMsMpSdOQ1YxwMnrRU4xEIf0Gj8=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDI0MLF_1724143354)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 16:42:51 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	stable@vger.kernel.org,
	Chunhai Guo <guochunhai@vivo.com>
Subject: [PATCH] erofs: fix out-of-bound access when z_erofs_gbuf_growsize() partially fails
Date: Tue, 20 Aug 2024 16:42:24 +0800
Message-ID: <20240820084224.1362129-1-hsiangkao@linux.alibaba.com>
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

Fixes: d6db47e571dc ("erofs: do not use pagepool in z_erofs_gbuf_growsize()")
Cc: <stable@vger.kernel.org> # 6.10+
Cc: Chunhai Guo <guochunhai@vivo.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
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


