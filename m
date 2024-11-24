Return-Path: <stable+bounces-95222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A74579D744F
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D7D28673E
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276361F7B40;
	Sun, 24 Nov 2024 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0KAip/D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AA91F7B6E;
	Sun, 24 Nov 2024 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456388; cv=none; b=RDonXlEr53n1ExNkEVNwk9WEfie2lPnnZms5XDLW5KedlDtNhskp9mYvA5ixvdoVkz8fqbq5MGjzoHr1e3ElkowQcJ/ZrywUi/G1SvdRqXUWEP6asxrJjBriF2G7RzmuWX+s3+P6+aLOyjluJoRLc7EPtzQADsH/9OfykHcqeV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456388; c=relaxed/simple;
	bh=jNSsyqlhSIiaIQIX0zpuinT53eIK/i05hslL038uZM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXFCVi5iFw6pOweHU9qyEn0P6Vgop4mp7iKiNgmIDVoCxFUguMZ8LSfGUnvD406pxspbnOTr70F6N7yGbDyovHcvXD7SnDm4qsLCzgLpKHopi2cOAag+c3LTQbJTkapwSYabhzjt+ePIL4CjSbdC/92Sx5XZmkRLl69OX3zCWjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0KAip/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B012C4CED3;
	Sun, 24 Nov 2024 13:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456388;
	bh=jNSsyqlhSIiaIQIX0zpuinT53eIK/i05hslL038uZM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g0KAip/Dfbvw45kfs0uA/YeB/NHTd1K5a1LOaZBFA9jJRILTcVYKS3FTShXVIOowa
	 1KBqwNce/RkInG3xeTeaNWAlR+rn44ODtQ0WpKMEb95vyYko9l7xz05cfpiEwOlRwZ
	 vg7A+aUvHH7sSkWucSgUi2WPC2iJkWlraIcxh46lu+7HsG8jdKqbv9ID6QCO6nGZsg
	 ZXRAdzy2hNhzhmrH6xNKrTZ4Elt86hligM89PuJtiMH6a3O+FDX7DCqL5FqRI7PcI7
	 TddsnASLrLpKdJO14W4Of74P4JiiyfkIZ+M7rWJFh9r/Lcy/zfJSaRda4mYGeN5qp3
	 IH9LP6AKHF+Tg==
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
Subject: [PATCH AUTOSEL 5.15 23/36] jfs: array-index-out-of-bounds fix in dtReadFirst
Date: Sun, 24 Nov 2024 08:51:37 -0500
Message-ID: <20241124135219.3349183-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135219.3349183-1-sashal@kernel.org>
References: <20241124135219.3349183-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
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


