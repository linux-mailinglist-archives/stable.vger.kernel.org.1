Return-Path: <stable+bounces-95255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11399D749E
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76AA7287B17
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E76243F75;
	Sun, 24 Nov 2024 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acCi4MU8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96184243F6E;
	Sun, 24 Nov 2024 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456490; cv=none; b=MAjh/xWEoIdlcnKGjoVjM8B2Vh6w/8C3y4Y7UgBKevVnh3RVX/djFvPCskD8ekVJdQaDv0LTMF2XshfnL3VkKGPzHFj4zY7kGx75AFvL/VkhFOaDBQkivmbjuTBYsbU2gQoX1UQJgJjkq8ZfaJdlAa+YvZqtJNQ66e3PSEn/GKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456490; c=relaxed/simple;
	bh=jNSsyqlhSIiaIQIX0zpuinT53eIK/i05hslL038uZM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+ZsZNWZvHSL+jGPY/Z/km5xSq9w3IQDnCEOTfJv+EvLpTlhFU1GbE1ELgSPhsGHyVNUfcZeAdgvkjua/i4Jt0pRVYzBVQ+Da34CbNdQcbMFdbw/HKzLuWGuLJ6eftMk9vxGtQXNQPPk/oScIlX0cEcgiBfMhKLgnZ2/JHfireU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acCi4MU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29430C4CED1;
	Sun, 24 Nov 2024 13:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456490;
	bh=jNSsyqlhSIiaIQIX0zpuinT53eIK/i05hslL038uZM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=acCi4MU8g8CscQnIyXTFDAgI0+t3NLCWSnMJ2UJDZl6B276ALfJ3lTennst5EWnQL
	 DMd5XrTt9YyoGo1+X0BrL9jP34YUdLtWl27QiKgmgffyLIRqTLlLQN1+ZrqgFOK424
	 jJFb9mwxxDZQrLCPIV7Jz+HdrRG88S16ULuIoe3ulroGbYIPYvw4mXx4rQw7fk9KNi
	 aDJ0WxnToX4ktdRjr3E/adZlEop+aOUlks5Mx1UflYv3Fhj+omBSGgOZYgIecWiRHn
	 II13Q98VfyNwCZ8LdqnwjzPSQaQjvfMV5JiuUJP8hPAz/JhE46qjMbNXsHc23wvUr8
	 m0evl3V0QkJww==
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
Subject: [PATCH AUTOSEL 5.10 20/33] jfs: array-index-out-of-bounds fix in dtReadFirst
Date: Sun, 24 Nov 2024 08:53:32 -0500
Message-ID: <20241124135410.3349976-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135410.3349976-1-sashal@kernel.org>
References: <20241124135410.3349976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
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
index a222a9d71887f..8f7ce1bea44c5 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -3382,6 +3382,13 @@ static int dtReadFirst(struct inode *ip, struct btstack * btstack)
 
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


