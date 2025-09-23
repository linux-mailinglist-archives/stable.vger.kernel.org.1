Return-Path: <stable+bounces-181442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D338EB94DB1
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 09:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF9E480388
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 07:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4532E3164BE;
	Tue, 23 Sep 2025 07:51:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m3279.qiye.163.com (mail-m3279.qiye.163.com [220.197.32.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335D3314B64
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 07:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613883; cv=none; b=lzMdu5dLQC4X3igNFALODdGLkodxiajuvV9o0EzGNNO+oJCLq08H+z3ebaEhnu3HIQGyjGB/0DegzYHmujRPo8Vi4N31jzcqZ8xt6PbUhbmdOg4MIbP4u9a78HKkuagIlJntihCrdFGz15TVLxMWXey8RwbvFPABCayYnNf8ibA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613883; c=relaxed/simple;
	bh=kLmtJbh9w1qEihs5/ztDJj/xTv8uW3xbtqxgmNpBfK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rQD49nLHf6H1prfh3ENty+2mjvVxK0ZwFyKaobidp95bAEuW8x5zYEHItKKDy+sl7ba8OKBqNiPvQXlM42OBzGAr9oPZwuS/pQJIgqrkxCEoGX4g9/dgXloG6LYALa73nmjiLqCW3raNbJOEMQ1mVgYmfe5/1XqeatHGlV2xfos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=220.197.32.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 109e4c685;
	Tue, 23 Sep 2025 15:51:12 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: dhowells@redhat.com,
	marc.dionne@auristor.com
Cc: linux-afs@lists.infradead.org,
	Zhen Ni <zhen.ni@easystack.cn>,
	stable@vger.kernel.org
Subject: [PATCH] afs: Fix potential null pointer dereference in afs_put_server
Date: Tue, 23 Sep 2025 15:51:04 +0800
Message-Id: <20250923075104.1141803-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99758e1f390229kunm96c99c5dd1431
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQkwYVhkdQx1KHx9OTBlLT1YVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0JKVUpLS1
	VLWQY+

afs_put_server() accessed server->debug_id before the NULL check, which
could lead to a null pointer dereference. Move the debug_id assignment,
ensuring we never dereference a NULL server pointer.

Fixes: 2757a4dc1849 ("afs: Fix access after dec in put functions")
Cc: stable@vger.kernel.org
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 fs/afs/server.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/afs/server.c b/fs/afs/server.c
index a97562f831eb..c4428ebddb1d 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -331,13 +331,14 @@ struct afs_server *afs_use_server(struct afs_server *server, bool activate,
 void afs_put_server(struct afs_net *net, struct afs_server *server,
 		    enum afs_server_trace reason)
 {
-	unsigned int a, debug_id = server->debug_id;
+	unsigned int a, debug_id;
 	bool zero;
 	int r;
 
 	if (!server)
 		return;
 
+	debug_id = server->debug_id;
 	a = atomic_read(&server->active);
 	zero = __refcount_dec_and_test(&server->ref, &r);
 	trace_afs_server(debug_id, r - 1, a, reason);
-- 
2.20.1


