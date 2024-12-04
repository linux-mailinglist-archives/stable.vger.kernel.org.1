Return-Path: <stable+bounces-98502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6584F9E422B
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26AEF283F5E
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58D9206F33;
	Wed,  4 Dec 2024 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehFrp0tU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C1522FD95;
	Wed,  4 Dec 2024 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332356; cv=none; b=UxuY1j5hoy8Ofx0UIIWz4vzqrZIjlJqLmOWUo2z16D2h6NyN/NUcqD9XnERXw6iaGcHRoSbJkdbauw63jKinhSFUVEWaCrY6MF+gCrs56Kw0cq44ItL9jV33Pw3DUBSeSI/oCe71OrA9+op3QVFawa5BUcz9babPtKBlrhi2HPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332356; c=relaxed/simple;
	bh=GMvvE8+22hdUCBQ2dqIItRlbK6+QnojwZUM4dzwkgI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrypC+l8MzTFNY7x12fWBEtw9rlnucwPLCr7beFF7+rJTzAyx4sJredmngz8Za8wU+0HoQLh80FGgarFNmaZNVbVgpDSWTt0QWlkmRno7pvZ6JQgOyYnmFEh9KvmOzfBhuz1mAx6+5WaCv8HpU/e5zGVluWmwY7rrXR6vBVi5V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehFrp0tU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0534C4CECD;
	Wed,  4 Dec 2024 17:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332356;
	bh=GMvvE8+22hdUCBQ2dqIItRlbK6+QnojwZUM4dzwkgI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ehFrp0tUNG7irjLwccp3jh8XZB1ozFM02tiSTbxFZPKA9TKdnoGqdALWhOex8c3Vg
	 ylzjgZVM8IsZjjLCXhlNysjQvs/Pq+XWQ/nbaMXP2ymq4xeMQW7QW28PVaXTcnvK1u
	 PAbRZkUaZdhSgZuyZBCfmWBQXUE6Eh5D98/2/pF6ShaL3FQVSUy4EJSOWB5pwGPm4m
	 0UgZ7M8TzBYYXf2HPK37OnZErDSdfW0413SWm3FdV/QFlztcld3QUEZkktxMIv6VeL
	 CQWap1bs8xz2GHP4XP2z8+Xx15Xn+8Umqm0cHtEgs6f4kT9aikwhgrQO1F/8nHzN+y
	 wNoFW/uAsnvvw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qianqiang Liu <qianqiang.liu@163.com>,
	syzbot+aa0730b0a42646eb1359@syzkaller.appspotmail.com,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	gfs2@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 02/12] KMSAN: uninit-value in inode_go_dump (5)
Date: Wed,  4 Dec 2024 11:00:59 -0500
Message-ID: <20241204160115.2216718-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160115.2216718-1-sashal@kernel.org>
References: <20241204160115.2216718-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Qianqiang Liu <qianqiang.liu@163.com>

[ Upstream commit f9417fcfca3c5e30a0b961e7250fab92cfa5d123 ]

When mounting of a corrupted disk image fails, the error message printed
can reference uninitialized inode fields.  To prevent that from happening,
always initialize those fields.

Reported-by: syzbot+aa0730b0a42646eb1359@syzkaller.appspotmail.com
Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 1200cb8059995..c2d508cb07e0e 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1567,11 +1567,13 @@ static struct inode *gfs2_alloc_inode(struct super_block *sb)
 	if (!ip)
 		return NULL;
 	ip->i_no_addr = 0;
+	ip->i_no_formal_ino = 0;
 	ip->i_flags = 0;
 	ip->i_gl = NULL;
 	gfs2_holder_mark_uninitialized(&ip->i_iopen_gh);
 	memset(&ip->i_res, 0, sizeof(ip->i_res));
 	RB_CLEAR_NODE(&ip->i_res.rs_node);
+	ip->i_diskflags = 0;
 	ip->i_rahead = 0;
 	return &ip->i_inode;
 }
-- 
2.43.0


