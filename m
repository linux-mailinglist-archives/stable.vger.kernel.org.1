Return-Path: <stable+bounces-3356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD5B7FF53A
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405F11C20FC6
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A4F54F9C;
	Thu, 30 Nov 2023 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K0aMNc8X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC6D495C2;
	Thu, 30 Nov 2023 16:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEDEC433C8;
	Thu, 30 Nov 2023 16:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361625;
	bh=as/cPzOFaoD6bcaw3nIzGnTcifXHpjY7TU4o+wki4T8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K0aMNc8X5bvGo4Ix8H+PEH6jIcQPxQenA/GtRQ6NhZl40kn2Ncu4ll0vLQqLSDOvd
	 PSAoWFIKICmzF275F6EG8nJ6Qlzb5asq+vnJESTRBnJlISjyFf0KOabVHm35dJtoLJ
	 bg1l/To9WYYCpwY5+3toyz9j7YbS65bzGEP5VhMA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Coly Li <colyli@suse.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.6 096/112] bcache: check return value from btree_node_alloc_replacement()
Date: Thu, 30 Nov 2023 16:22:23 +0000
Message-ID: <20231130162143.363333493@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
References: <20231130162140.298098091@linuxfoundation.org>
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

From: Coly Li <colyli@suse.de>

commit 777967e7e9f6f5f3e153abffb562bffaf4430d26 upstream.

In btree_gc_rewrite_node(), pointer 'n' is not checked after it returns
from btree_gc_rewrite_node(). There is potential possibility that 'n' is
a non NULL ERR_PTR(), referencing such error code is not permitted in
following code. Therefore a return value checking is necessary after 'n'
is back from btree_node_alloc_replacement().

Signed-off-by: Coly Li <colyli@suse.de>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc:  <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20231120052503.6122-3-colyli@suse.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/bcache/btree.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1527,6 +1527,8 @@ static int btree_gc_rewrite_node(struct
 		return 0;
 
 	n = btree_node_alloc_replacement(replace, NULL);
+	if (IS_ERR(n))
+		return 0;
 
 	/* recheck reserve after allocating replacement node */
 	if (btree_check_reserve(b, NULL)) {



