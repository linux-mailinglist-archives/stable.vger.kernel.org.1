Return-Path: <stable+bounces-98474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB429E4201
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF92DB635E8
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA3017BB1C;
	Wed,  4 Dec 2024 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cte/nRm6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83604202C5D;
	Wed,  4 Dec 2024 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332292; cv=none; b=i3mITmqPgH3Cv69NTMt6Tc36Abt7Up755cwTt5tSjYSUU2SMnMTdbA7L+JGEog+2LpT2kYaHuirIEYujBYeCBt7x8ibJZZY+lps9TPZbzchsLEP3IHMIrtoib7Dr0zSfkhjluZUEDFReRmEt8yvpFiz+4ggg5iv389yVdy6EJYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332292; c=relaxed/simple;
	bh=Kdj8ZYQXb2wgy6ePNcx0/oAFu7VqFEnEy4hstoJ9W/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzYvyipyIW7Cup4K6rtfJTYJ/aa8Dlq1n0uv0zflVHiW6MNKIRL32wXoGArrJ7GMKkXg5yel5vKPZkuohSQZLANs3rdsA5S8EYNGuZyGmEvyiJswE9RhUsFENuSDr9gk4rPWqYBKy9LNveCmmT+LxShrCkKeR0xpfRAAF54dWxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cte/nRm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE05C4CED6;
	Wed,  4 Dec 2024 17:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332292;
	bh=Kdj8ZYQXb2wgy6ePNcx0/oAFu7VqFEnEy4hstoJ9W/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cte/nRm6jNfszAv/dNNUCwFG0AIYnTgC0avVYGDuEaabN2PhdchUZIAPxf9IG/Cco
	 tXX4FS6yzVOsIM399qrdetvObM/Up/qBZDKFepIc8UYT0iU/4Nl7/sRHm7/oeVpINv
	 PMj9bzEOvqMox0u3+ieiM8G0iFNS/MH5bqki6DlMBMb2f19dtK4cZXZbbVmlOYgTvz
	 zTzHLqoJ5VPyoS/GnoW25PaLbpvlSMGhnP/Yv/hJUu5lpw9hoy6AvvPlAeXmQCikm0
	 tXar6Ps32hiSYJHU1ZRdjCe28BVazgwBZhwu9tXqwvSkTV/ygjKOmkZ+VmzQKaf2E2
	 6bNKqpCpjPaLg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qianqiang Liu <qianqiang.liu@163.com>,
	syzbot+aa0730b0a42646eb1359@syzkaller.appspotmail.com,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	gfs2@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 02/15] KMSAN: uninit-value in inode_go_dump (5)
Date: Wed,  4 Dec 2024 10:59:50 -0500
Message-ID: <20241204160010.2216008-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160010.2216008-1-sashal@kernel.org>
References: <20241204160010.2216008-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index 6678060ed4d2b..d60d53810bc12 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1537,11 +1537,13 @@ static struct inode *gfs2_alloc_inode(struct super_block *sb)
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


