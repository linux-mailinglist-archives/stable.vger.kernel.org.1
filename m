Return-Path: <stable+bounces-198345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 812F0C9F914
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 16:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C72CA300A1F3
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 15:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46E03148A8;
	Wed,  3 Dec 2025 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pnYMGjBP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CEE309EFF;
	Wed,  3 Dec 2025 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776238; cv=none; b=LkVHAo2EDO7cp05No0/UwV6OE0WjLJiEmoHABsDYDjApimVmnP4Ziak0F7+DT/4XE9EOaaLcLU9T6cLuLspgphg02pu58xGRIcxkbN/8BtezYQMT34GqtvTCgrH5TI9yHmeY60P+3i6LYaJWfC29sjACUpiG4apyyF50OUil4jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776238; c=relaxed/simple;
	bh=ZLKxKVTco1gCP0nSaR7qFbc2b3iGM+L0YDhidLik0/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYtpVUl/BhkqICsDYbXmSD/eNad8knPWB0THv9jnW+DVvjRBJ07L7q2TTsoD6P9+HeeCnu0RNUFKLJCUh9uacmOsxtJos/+YulUtOOUQ3+wE5BLfyhSYAbZHZKjEroTV6sara5VKxpofUwq1N5iB3l0QeyssY2Ked0HJ7pNc0Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pnYMGjBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD26C4CEF5;
	Wed,  3 Dec 2025 15:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764776238;
	bh=ZLKxKVTco1gCP0nSaR7qFbc2b3iGM+L0YDhidLik0/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pnYMGjBPPjln3DfPrmaugR58Xgt3FABgkuFSn8GGT3nseokiOIOPRL2+VmfVwustD
	 WH5Rp7AgcjOH8r0+Rw2f6ogdFHl8IMnzU9pigijtLAuMjmgpShNmcKJfe5UHV7dX/G
	 K4PgE88vfop/+DyLTHuheJpvOq+UNOP2veKb9/M4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	NeilBrown <neil@brown.name>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 122/300] allow finish_no_open(file, ERR_PTR(-E...))
Date: Wed,  3 Dec 2025 16:25:26 +0100
Message-ID: <20251203152405.137006317@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152400.447697997@linuxfoundation.org>
References: <20251203152400.447697997@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit fe91e078b60d1beabf5cef4a37c848457a6d2dfb ]

... allowing any ->lookup() return value to be passed to it.

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/open.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 7bcc26b14cd79..f081f09e411ef 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -896,18 +896,20 @@ EXPORT_SYMBOL(finish_open);
  * finish_no_open - finish ->atomic_open() without opening the file
  *
  * @file: file pointer
- * @dentry: dentry or NULL (as returned from ->lookup())
+ * @dentry: dentry, ERR_PTR(-E...) or NULL (as returned from ->lookup())
  *
- * This can be used to set the result of a successful lookup in ->atomic_open().
+ * This can be used to set the result of a lookup in ->atomic_open().
  *
  * NB: unlike finish_open() this function does consume the dentry reference and
  * the caller need not dput() it.
  *
- * Returns "0" which must be the return value of ->atomic_open() after having
- * called this function.
+ * Returns 0 or -E..., which must be the return value of ->atomic_open() after
+ * having called this function.
  */
 int finish_no_open(struct file *file, struct dentry *dentry)
 {
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
 	file->f_path.dentry = dentry;
 	return 0;
 }
-- 
2.51.0




