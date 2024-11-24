Return-Path: <stable+bounces-95058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F20D99D75FC
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 17:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22950BC1F78
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6141D5AD4;
	Sun, 24 Nov 2024 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1KP4g4C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EBD1D5AD9;
	Sun, 24 Nov 2024 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455846; cv=none; b=Fyh2dsTbx/LL3NL6xlQWJCx5977k/1VMwoH/eDXMrL7K/1kU2WmlUVy/CPXLKyhUlcfzRlZttM8MSNnPgjHkPe+noL2r1KcovkI83jH5j9xwpumK3B2ZbTD8grw6kWDWzpop8LQlPG8Q+vlbgQ6m5+/WmcVEViOCblh8QhWMPko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455846; c=relaxed/simple;
	bh=Cm48ydr7HuUmpf8NLPZ0xlI3ymdHuP7sWgbwamctBOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjeJ07n6auVkSUyBH2BahQDk5qEkwY8RlsylwnxSD9P0DAEwgedlf7OWaRNDdT8noC0Fbn/9E+09WvNJjw0W2fFt7IHLrP/JtNxjqMG9g/s7flHvtMoPVeBaAUHqXRQ5JgGoR74MQYSqgXNpCFbbNafa/jrJDLP9sv1HBphUc8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1KP4g4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F9DC4CECC;
	Sun, 24 Nov 2024 13:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455846;
	bh=Cm48ydr7HuUmpf8NLPZ0xlI3ymdHuP7sWgbwamctBOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u1KP4g4Cfgq8eiW8MHUIYFoDGIZ5wRDBMOXPaJYDlpyR0kpV167ejaUnWiSqFHC9m
	 EZcK2lxnSxeJHuHsYHb+GjhSi3VVCfLVb/rRp278oQqzEjHLiNBgG7CmcpGpXq7TxR
	 n/Z1sr731ULxfEaCm1vQA6tX5m76RMoIclimwkk3eJKMKhsatYuHwuPHhjDE1+S4xq
	 5PB53dwa1p4zM5Q/clEYwe78K37e9Y6QvVujPWytBKQK+3zsuw1KUaL39kkvXTAZCK
	 /IGuJbWGQj1O2Hxa6BrGkYzQuHrrGOe7ZI6GCCIMdYJLBXZzgMNX8FSMugH6NUCxnX
	 tH915TKJxK0mg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	syzbot+65fa06e29859e41a83f3@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	eadavis@qq.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.11 55/87] jfs: array-index-out-of-bounds fix in dtReadFirst
Date: Sun, 24 Nov 2024 08:38:33 -0500
Message-ID: <20241124134102.3344326-55-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>

[ Upstream commit ca84a2c9be482836b86d780244f0357e5a778c46 ]

The value of stbl can be sometimes out of bounds due
to a bad filesystem. Added a check with appopriate return
of error code in that case.

Reported-by: syzbot+65fa06e29859e41a83f3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=65fa06e29859e41a83f3
Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dtree.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 5d3127ca68a42..69fd936fbdb37 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -3086,6 +3086,13 @@ static int dtReadFirst(struct inode *ip, struct btstack * btstack)
 
 		/* get the leftmost entry */
 		stbl = DT_GETSTBL(p);
+
+		if (stbl[0] < 0 || stbl[0] > 127) {
+			DT_PUTPAGE(mp);
+			jfs_error(ip->i_sb, "stbl[0] out of bound\n");
+			return -EIO;
+		}
+
 		xd = (pxd_t *) & p->slot[stbl[0]];
 
 		/* get the child page block address */
-- 
2.43.0


