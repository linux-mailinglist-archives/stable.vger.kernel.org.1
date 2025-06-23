Return-Path: <stable+bounces-155902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDBBAE4462
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322BE3B83B7
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1476239E63;
	Mon, 23 Jun 2025 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QS/qDEGk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601504C6E;
	Mon, 23 Jun 2025 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685631; cv=none; b=I+lv5PEmHc3fO6L8VSYGnIWE5aUEo0k7CtKoA71mY4uv6OGxVq7P6h5PsOcckj73kWxqy7b90C1g6cqELfL323lfP3a07rrVjWBWikIZC5ExCY6eyDhvEFIvcLyWgwWIzt3C9AJ2goC8XaQ86JK4DfaZgcqBCty5sYasMCS84R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685631; c=relaxed/simple;
	bh=xAkdDISWyMgQwWE1nAclAhbiYEAdQbRRjYArRi//S9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bb9gVwuKme8EbFuUC7AP3i2Jv6PnTwwdMH6hutPntsSqD7QIfUxmwzJTuFjsDXKgRzfNghJtNSoHAc4t3RotOVQL6ccEwLB9O7RZfM+uRPbpfvewS7x/qFPv3QNjwCG95lZTrHnqlKEYqu2NtzRpuSfxSr54M8V8d+z9j/bU4L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QS/qDEGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8765C4CEEA;
	Mon, 23 Jun 2025 13:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750685631;
	bh=xAkdDISWyMgQwWE1nAclAhbiYEAdQbRRjYArRi//S9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QS/qDEGkh7238/AJdsJF72NfTWI7OJALCVjqR2JqDl3hKQWMDNKlshiJLQGy7ZNCG
	 8pCMqL/0+KpfVxB8TJ9s7/Z9NkE0L3YYnBGvFhGyBHGWdjtEd3JpXQbHDLu4k5QOTx
	 lYLas6bDGbGTmfN1j5GVOHXdUE0NspuOB91+vLRc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 064/355] nilfs2: add pointer check for nilfs_direct_propagate()
Date: Mon, 23 Jun 2025 15:04:25 +0200
Message-ID: <20250623130628.754027634@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.716971725@linuxfoundation.org>
References: <20250623130626.716971725@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit f43f02429295486059605997bc43803527d69791 ]

Patch series "nilfs2: improve sanity checks in dirty state propagation".

This fixes one missed check for block mapping anomalies and one improper
return of an error code during a preparation step for log writing, thereby
improving checking for filesystem corruption on writeback.

This patch (of 2):

In nilfs_direct_propagate(), the printer get from nilfs_direct_get_ptr()
need to be checked to ensure it is not an invalid pointer.

If the pointer value obtained by nilfs_direct_get_ptr() is
NILFS_BMAP_INVALID_PTR, means that the metadata (in this case, i_bmap in
the nilfs_inode_info struct) that should point to the data block at the
buffer head of the argument is corrupted and the data block is orphaned,
meaning that the file system has lost consistency.

Add a value check and return -EINVAL when it is an invalid pointer.

Link: https://lkml.kernel.org/r/20250428173808.6452-1-konishi.ryusuke@gmail.com
Link: https://lkml.kernel.org/r/20250428173808.6452-2-konishi.ryusuke@gmail.com
Fixes: 36a580eb489f ("nilfs2: direct block mapping")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nilfs2/direct.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nilfs2/direct.c b/fs/nilfs2/direct.c
index 7faf8c285d6c9..a72371cd6b956 100644
--- a/fs/nilfs2/direct.c
+++ b/fs/nilfs2/direct.c
@@ -273,6 +273,9 @@ static int nilfs_direct_propagate(struct nilfs_bmap *bmap,
 	dat = nilfs_bmap_get_dat(bmap);
 	key = nilfs_bmap_data_get_key(bmap, bh);
 	ptr = nilfs_direct_get_ptr(bmap, key);
+	if (ptr == NILFS_BMAP_INVALID_PTR)
+		return -EINVAL;
+
 	if (!buffer_nilfs_volatile(bh)) {
 		oldreq.pr_entry_nr = ptr;
 		newreq.pr_entry_nr = ptr;
-- 
2.39.5




