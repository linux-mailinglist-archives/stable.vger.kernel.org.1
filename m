Return-Path: <stable+bounces-95284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A039D74E3
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E639282605
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9601E8848;
	Sun, 24 Nov 2024 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icTv9iwU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41021E8842;
	Sun, 24 Nov 2024 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456580; cv=none; b=L5Rdwz1IivPZWvFyrZrBA3sOMfeRlbaKXWjNtaZHCKMT0gSziUPyZ45sx9atBMgEoVvOpsedX/mq3kCHy/AJlRq0nrLwkL17Pd319Bzcozy6wYKYfDwf6CyEBYhdQczLD3twM/WkV3XJkCqdquhlzHvegZn6NQkKBSwESM0lKCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456580; c=relaxed/simple;
	bh=nKbQPBXDRXouY5ktcE8PMUrDLsRicIqcK7UhJDvsnx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oM+PbJzWafMD8Izt0v2GUDRlSF8tLD5SvwFJy2bWCjvTgcDhdJ2lZPBqHVIpSp3bhvn7bNJk3mobdFfcKsCW/zm8K05c/5jhDD4P7rYSe+l56TINbH0P7KwYcIlRbYqNKhwpxVxcWRQ9UfPNpkx+HXh6y4uaZr8uKSfy4HLjx/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icTv9iwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70D6C4CED1;
	Sun, 24 Nov 2024 13:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456580;
	bh=nKbQPBXDRXouY5ktcE8PMUrDLsRicIqcK7UhJDvsnx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=icTv9iwU4XXVWnKBqvfo9JfhEIEge8mPs7DA3dzrF0LIb0DEwD4H+iyaAtOWRcEMQ
	 DNCrCmDWIe2SxsLg5gG5A/3N0Ao2gjSGHQOsuP84MvkFb1UCV/sIzpjqeFr0kio4wB
	 m6wOd2o+5gxjy01E8KUb+ySpARu5mW8ilV1XqRwYwpW8HB6MnA87dPiUrgXeQnKWkL
	 c0J5SEptyiQHc3DcPCSBdxGANpggwD+DhgS2ZvWa1SGHospVbnA0fKvDWEaBp9xFmp
	 vC1bLmdEDTCuclgYtoEs+vnFXVnhFdyrv7XNLBME4zBy0wuZZa0GlLVIbde+/5s3sJ
	 v5cAMAJxbhwqQ==
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
Subject: [PATCH AUTOSEL 5.4 16/28] jfs: array-index-out-of-bounds fix in dtReadFirst
Date: Sun, 24 Nov 2024 08:55:16 -0500
Message-ID: <20241124135549.3350700-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135549.3350700-1-sashal@kernel.org>
References: <20241124135549.3350700-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
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
index 077a87e530205..bd198b04c388f 100644
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


