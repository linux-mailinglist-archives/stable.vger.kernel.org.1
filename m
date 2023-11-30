Return-Path: <stable+bounces-3431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7487FF59A
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1341C21060
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D654878B;
	Thu, 30 Nov 2023 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GK3eVx0k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F38351002;
	Thu, 30 Nov 2023 16:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4B8C433C8;
	Thu, 30 Nov 2023 16:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361815;
	bh=cAuO7KJa7Itwwp/aTZZgv872r2PYV1MygvbzRy9HNjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GK3eVx0kAQmiPHhTlGWnQDyMhbQIvyDxbTkcbwOQxznMNwWOYkclDmttKVa+mFdWV
	 Yh0D3mF8GXYX8Lku22L5thHP+CUkLQFBMV3iefWxS71o7zFNQhisjfOG0NneZTZA3M
	 7x+gNWZz0LgrzPFD0Gturp1ILwgdq124e9sZSR28=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zheng Wang <zyytlz.wz@163.com>,
	Coly Li <colyli@suse.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 58/82] bcache: replace a mistaken IS_ERR() by IS_ERR_OR_NULL() in btree_gc_coalesce()
Date: Thu, 30 Nov 2023 16:22:29 +0000
Message-ID: <20231130162137.810729566@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162135.977485944@linuxfoundation.org>
References: <20231130162135.977485944@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Coly Li <colyli@suse.de>

commit f72f4312d4388376fc8a1f6cf37cb21a0d41758b upstream.

Commit 028ddcac477b ("bcache: Remove unnecessary NULL point check in
node allocations") do the following change inside btree_gc_coalesce(),

31 @@ -1340,7 +1340,7 @@ static int btree_gc_coalesce(
32         memset(new_nodes, 0, sizeof(new_nodes));
33         closure_init_stack(&cl);
34
35 -       while (nodes < GC_MERGE_NODES && !IS_ERR_OR_NULL(r[nodes].b))
36 +       while (nodes < GC_MERGE_NODES && !IS_ERR(r[nodes].b))
37                 keys += r[nodes++].keys;
38
39         blocks = btree_default_blocks(b->c) * 2 / 3;

At line 35 the original r[nodes].b is not always allocatored from
__bch_btree_node_alloc(), and possibly initialized as NULL pointer by
caller of btree_gc_coalesce(). Therefore the change at line 36 is not
correct.

This patch replaces the mistaken IS_ERR() by IS_ERR_OR_NULL() to avoid
potential issue.

Fixes: 028ddcac477b ("bcache: Remove unnecessary NULL point check in node allocations")
Cc:  <stable@vger.kernel.org> # 6.5+
Cc: Zheng Wang <zyytlz.wz@163.com>
Signed-off-by: Coly Li <colyli@suse.de>
Link: https://lore.kernel.org/r/20231120052503.6122-9-colyli@suse.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/bcache/btree.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1342,7 +1342,7 @@ static int btree_gc_coalesce(struct btre
 	memset(new_nodes, 0, sizeof(new_nodes));
 	closure_init_stack(&cl);
 
-	while (nodes < GC_MERGE_NODES && !IS_ERR(r[nodes].b))
+	while (nodes < GC_MERGE_NODES && !IS_ERR_OR_NULL(r[nodes].b))
 		keys += r[nodes++].keys;
 
 	blocks = btree_default_blocks(b->c) * 2 / 3;



