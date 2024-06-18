Return-Path: <stable+bounces-53593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3D690D28B
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A180282613
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC931AD40C;
	Tue, 18 Jun 2024 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zz997Vcp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9C41AD406;
	Tue, 18 Jun 2024 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716789; cv=none; b=I7w7omI0IHeNcjj9DwXBcVWGIz9oPTzPk82OvdaaAlSONNqQjQf2VU+Io5NLQcKL7P0qkfvqOcUtqBIO8hz3EelXVj2yrzF6RTvgl1cauLfq0B1qKrivAq6RpvwjCdJApzqVua4e8nALyJoG5Qjg+wTa4gYue14pLCFOkVKoiGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716789; c=relaxed/simple;
	bh=6hbYH/LfxV8YLvlFYPbdq4YGgJMX7CLKh9wpjGp3juQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5gQFbo0eNenaX58uwCtylf2QSmZHQ5GyJlyz18axLgFIuMjNl83yZz2O9DlbtW72xiGKJq256v4339V59LXSiaob7OVL1QvliEffBrM40LKCy0o6RIxDwpSAmFdheUpTJ0p5uOa2gMsJTZcWTlj/uO/+t5hweEOq20Aqu5XPOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zz997Vcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FE4C3277B;
	Tue, 18 Jun 2024 13:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716789;
	bh=6hbYH/LfxV8YLvlFYPbdq4YGgJMX7CLKh9wpjGp3juQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zz997VcpKIB5rkvdLFbVz9FO+EWYWJukaeQ2fLwC+0trZBVfGg6L5ZqGsXR7SW1n6
	 HBGSJ7/cZu6LVrTGJL6lj9jCxBJZwSU1eyiJQOV/CaJPAf5rjM4qQU1RpVlM1h5z5W
	 YZx4hRsWPOXdtUPZlyMYcBjojw//dEdww6MbcoBU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 764/770] NFSD: fix possible oops when nfsd/pool_stats is closed.
Date: Tue, 18 Jun 2024 14:40:17 +0200
Message-ID: <20240618123436.761927123@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: NeilBrown <neilb@suse.de>

[ Upstream commit 88956eabfdea7d01d550535af120d4ef265b1d02 ]

If /proc/fs/nfsd/pool_stats is open when the last nfsd thread exits, then
when the file is closed a NULL pointer is dereferenced.
This is because nfsd_pool_stats_release() assumes that the
pointer to the svc_serv cannot become NULL while a reference is held.

This used to be the case but a recent patch split nfsd_last_thread() out
from nfsd_put(), and clearing the pointer is done in nfsd_last_thread().

This is easily reproduced by running
   rpc.nfsd 8 ; ( rpc.nfsd 0;true) < /proc/fs/nfsd/pool_stats

Fortunately nfsd_pool_stats_release() has easy access to the svc_serv
pointer, and so can call svc_put() on it directly.

Fixes: 9f28a971ee9f ("nfsd: separate nfsd_last_thread() from nfsd_put()")
Signed-off-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfssvc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index ee5713fca1870..2a1dd580dfb94 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1084,11 +1084,12 @@ int nfsd_pool_stats_open(struct inode *inode, struct file *file)
 
 int nfsd_pool_stats_release(struct inode *inode, struct file *file)
 {
+	struct seq_file *seq = file->private_data;
+	struct svc_serv *serv = seq->private;
 	int ret = seq_release(inode, file);
-	struct net *net = inode->i_sb->s_fs_info;
 
 	mutex_lock(&nfsd_mutex);
-	nfsd_put(net);
+	svc_put(serv);
 	mutex_unlock(&nfsd_mutex);
 	return ret;
 }
-- 
2.43.0




