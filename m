Return-Path: <stable+bounces-164543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CED79B0FF05
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 04:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C70A1C86F1E
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 02:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1127C22097;
	Thu, 24 Jul 2025 02:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWLQA/jo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55C91CEADB
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 02:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753325858; cv=none; b=W475yeZvDpB0svPjHi/gUYIf3HIH0OuZIctUM0xJrbMMAY3sqHjwETWhNA699PDAOFXgLOYCfe+0gLVnN7OpxdxDQtUxf5boWmpdK39Lf6nS4dhS/XYaqQcRJsk7hsi50P2h4JrKq6bPJ8FSdCWoSeRyb0fWOnLqBA8K3mVIAiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753325858; c=relaxed/simple;
	bh=TKuRHEkY4cam5Qw50w00A5Y4mkj/8Hp98m4yLFO8jzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lhKeMh/Ngn0xEGOnhDucLUBRUpCTWThBACuRZn6QoQvax9NgffZQB5QKnT9m9WXFf7jubGUZ3VrYl2MwDJTOAjWkBoRk37ZmwvAExnzyTK35lxeAaN0G5DTfaVEtyM5qqImCIjoNNqJgnvgXeDmLi0FLLKKtZblW5jbLRgYNbiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWLQA/jo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC8CC4CEE7;
	Thu, 24 Jul 2025 02:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753325858;
	bh=TKuRHEkY4cam5Qw50w00A5Y4mkj/8Hp98m4yLFO8jzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DWLQA/joMj9IIAVYuqaog0JH/se2lCVeCaKhjeYhq0JVDWCT2tTeUYy8uvC7SGnYf
	 YH4+gI8aa6XvlQMqh7YnjV5XHZpFQFoMk3L5epZHAHougiKWQwMZ3CzKUFBpdmUwM7
	 rH3MhSPP03q/0hH1zmXwW35RHYkX+viwtwTWK84Wxwt61IsmTBaaju0tQlG7agZFvl
	 1s/pP/ag3QfW5SWtFGELzYPYfAXBDfltQZXvP7Bgar/WOQO1bj/Aap7kbAyOrRg6rR
	 +jnXPd+eU/un/sC57i81D/eXHcQbZYOJZU64CsutMe7ARhP8MSLBRxXL2ztldohxZJ
	 kXPUSaxSnoLEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Baokun Li <libaokun1@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 10/11] ext4: correct the error handle in ext4_fallocate()
Date: Wed, 23 Jul 2025 22:57:17 -0400
Message-Id: <20250724025718.1277650-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724025718.1277650-1-sashal@kernel.org>
References: <2025062009-junior-thriving-f882@gregkh>
 <20250724025718.1277650-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 129245cfbd6d79c6d603f357f428010ccc0f0ee7 ]

The error out label of file_modified() should be out_inode_lock in
ext4_fallocate().

Fixes: 2890e5e0f49e ("ext4: move out common parts into ext4_fallocate()")
Reported-by: Baokun Li <libaokun1@huawei.com>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Link: https://patch.msgid.link/20250319023557.2785018-1-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 51b9533416e04..2f9c3cd4f26cc 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4745,7 +4745,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 
 	ret = file_modified(file);
 	if (ret)
-		return ret;
+		goto out_inode_lock;
 
 	if ((mode & FALLOC_FL_MODE_MASK) == FALLOC_FL_ALLOCATE_RANGE) {
 		ret = ext4_do_fallocate(file, offset, len, mode);
-- 
2.39.5


