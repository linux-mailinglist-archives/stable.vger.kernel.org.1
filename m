Return-Path: <stable+bounces-60652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1959387CD
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 05:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CD5E1C20D57
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 03:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9F512B8B;
	Mon, 22 Jul 2024 03:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="elW/bGba"
X-Original-To: stable@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307F81396;
	Mon, 22 Jul 2024 03:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721620288; cv=none; b=HT/gfvTEZyj0BGNtwUnR7oldh8Or9scLTmCoCbtUqgBBrOr0dExX/8auF8zIFMGrtLjwGURTU/DREANQ5+vW1giJPmmwgpyOQpr3DLblB0HcNobFMe3WmNKIUWfdbXFFDF9qDNoxUZsqYyI2B2qMdl1ZFFfC0PHkIok2fDFu0fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721620288; c=relaxed/simple;
	bh=lPq8KTyliuz8pXToGn6zxt+fkJi+KsQbqQrMmLXBZJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ExezoLoVCpV9MJ+tFDVY6IlmNjSWVYJ92y9MJJ311fWQ5nXBmgz+Er9dFSuhdpDwnd1NkkQX/bCe4xzfCqtp7glQn+uGaQ4ay6oLjjMj3ZZWBrJdU1DBtLz3ieQ5BNk5fVqWTHW3LpFyVtdXdrS26zmCrZvDJf81cYNbJYATmzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=elW/bGba; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721620276; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=gG41asDe00WrhOVbN58kYIBjCmdqNSzuFI+5LAtSebs=;
	b=elW/bGbauAyhDsIT4xwRJVN2u7CnRH2F+8lRiRA52pHIn4ZcASYuIFl6qUX401DGcas24qH4jJrdHH9OXpybjPXF/ywIZdjiLI8B8NDNLj1mUp8c882VzeJ9cvQzAAm83g20ywPDapwsR2Qp7IwAQYQvoF42YMkfER1HRjBS6qA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0WAyY.Ac_1721620271;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAyY.Ac_1721620271)
          by smtp.aliyun-inc.com;
          Mon, 22 Jul 2024 11:51:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	stable@vger.kernel.org,
	Chunhai Guo <guochunhai@vivo.com>
Subject: [PATCH] erofs: fix race in z_erofs_get_gbuf()
Date: Mon, 22 Jul 2024 11:51:10 +0800
Message-ID: <20240722035110.3456740-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In z_erofs_get_gbuf(), the current task may be migrated to another
CPU between `z_erofs_gbuf_id()` and `spin_lock(&gbuf->lock)`.

Therefore, z_erofs_put_gbuf() will trigger the following issue
which was found by stress test:

<2>[772156.434168] kernel BUG at fs/erofs/zutil.c:58!
..
<4>[772156.435007]
<4>[772156.439237] CPU: 0 PID: 3078 Comm: stress Kdump: loaded Tainted: G            E      6.10.0-rc7+ #2
<4>[772156.439239] Hardware name: Alibaba Cloud Alibaba Cloud ECS, BIOS 1.0.0 01/01/2017
<4>[772156.439241] pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
<4>[772156.439243] pc : z_erofs_put_gbuf+0x64/0x70 [erofs]
<4>[772156.439252] lr : z_erofs_lz4_decompress+0x600/0x6a0 [erofs]
..
<6>[772156.445958] stress (3127): drop_caches: 1
<4>[772156.446120] Call trace:
<4>[772156.446121]  z_erofs_put_gbuf+0x64/0x70 [erofs]
<4>[772156.446761]  z_erofs_lz4_decompress+0x600/0x6a0 [erofs]
<4>[772156.446897]  z_erofs_decompress_queue+0x740/0xa10 [erofs]
<4>[772156.447036]  z_erofs_runqueue+0x428/0x8c0 [erofs]
<4>[772156.447160]  z_erofs_readahead+0x224/0x390 [erofs]
..

Fixes: f36f3010f676 ("erofs: rename per-CPU buffers to global buffer pool and make it configurable")
Cc: <stable@vger.kernel.org> # 6.10+
Cc: Chunhai Guo <guochunhai@vivo.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zutil.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index b80f612867c2..9b53883e5caf 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -38,11 +38,13 @@ void *z_erofs_get_gbuf(unsigned int requiredpages)
 {
 	struct z_erofs_gbuf *gbuf;
 
+	migrate_disable();
 	gbuf = &z_erofs_gbufpool[z_erofs_gbuf_id()];
 	spin_lock(&gbuf->lock);
 	/* check if the buffer is too small */
 	if (requiredpages > gbuf->nrpages) {
 		spin_unlock(&gbuf->lock);
+		migrate_enable();
 		/* (for sparse checker) pretend gbuf->lock is still taken */
 		__acquire(gbuf->lock);
 		return NULL;
@@ -57,6 +59,7 @@ void z_erofs_put_gbuf(void *ptr) __releases(gbuf->lock)
 	gbuf = &z_erofs_gbufpool[z_erofs_gbuf_id()];
 	DBG_BUGON(gbuf->ptr != ptr);
 	spin_unlock(&gbuf->lock);
+	migrate_enable();
 }
 
 int z_erofs_gbuf_growsize(unsigned int nrpages)
-- 
2.43.5


