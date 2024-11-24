Return-Path: <stable+bounces-95309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2D79D7525
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7508C166B4E
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2003624E58C;
	Sun, 24 Nov 2024 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Th3iWFlP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D054424E589;
	Sun, 24 Nov 2024 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456655; cv=none; b=BWsRbYcHQB+MUoDoW7hJf5UPd27P4OGqBL3sBk8709Az2mTUYYMHPateo9LHdz/R6e7ZwE6DnqEazWtJngPh5uwFySAll1HqMAtHQTlTQk1MHNBt4oOojlGsapyL/Z4dGhFuoF0gx4EJvZTMQ1DULA/wtz4S54GljYpiNSKm/30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456655; c=relaxed/simple;
	bh=iNbmMf2FVfiFgUQvZi4s/vvglrLrQa18tavvRQLvihw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cW/NojJNMFF1YzclWwRPreAzZ6BVlb0hXj4y6nJcq2kCFegm8okPnj2JIFmXBIkVUvm14HB069ObBjaIeVqc9gR1D1jmw9mV4tpyRfd0egQhoiE1Q2oMeWRVxb5SphvzEBpxnfOGYE4nFuLBcN7LIm8wG2ZwWj3elfr713V5Tjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Th3iWFlP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC97FC4CED1;
	Sun, 24 Nov 2024 13:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456655;
	bh=iNbmMf2FVfiFgUQvZi4s/vvglrLrQa18tavvRQLvihw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Th3iWFlPb4tY+eA2hENg4+YwJIFwTAL6QBxwWmBO+fI1xYKz078/BX6TkTrrRqNl4
	 u67QveFDZ6B8lARJg3bt+EQnii/a/CjJHmyHihgRLnyyErhXYytTG+wOqkW/MF+kxf
	 6960AjU6V0KfjPp83W2KgZ7tLsACNuYDBe7Wr0rvZLuDuFQb+6Pty2/Uw02YOi4Xk1
	 dB6L/RuVIcYZ7WegFwXxF1aXkbPbKfW0HgYFFqA7zyqATK2zhuq84tfaMrOFU91hOg
	 AZPJaavHHNJR0CyK+RFzyioO9zZDQoyELdVGuc9N5czpsRmfA3AYqw6Xp5pftYqaqg
	 /lQxp9qQ8yJdg==
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
Subject: [PATCH AUTOSEL 4.19 13/21] jfs: array-index-out-of-bounds fix in dtReadFirst
Date: Sun, 24 Nov 2024 08:56:46 -0500
Message-ID: <20241124135709.3351371-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135709.3351371-1-sashal@kernel.org>
References: <20241124135709.3351371-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.324
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
index ea2c8f0fe832c..a2186b6f274a7 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -3395,6 +3395,13 @@ static int dtReadFirst(struct inode *ip, struct btstack * btstack)
 
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


