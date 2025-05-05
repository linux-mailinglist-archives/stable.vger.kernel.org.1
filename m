Return-Path: <stable+bounces-141200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09DFAAB668
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1853D3A4EF9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D052D440B;
	Tue,  6 May 2025 00:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKJMoRul"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D622749F0;
	Mon,  5 May 2025 22:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485480; cv=none; b=lf3stPeEZxlrPso3T//F3TKuwmCNY9o4CGkr3yfm/qO/k02bNCouw/CppTzMa4HdD5CPPaM8yJBqo8bzuoS5bXdxnJkJxy51dFA22i3Rs/gaNwmilOqTxglIekBwUen5yWKn5r+N/nrKq9DM7VhZ+6ZcVzWKEyQA900WUYUG2Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485480; c=relaxed/simple;
	bh=lFmRf0UqXzAD/H+cDJ45OmX59Qe26LwGgupNtdazpJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LnFM5b7CVE/oBLoE8d8ytVh842RMKG2DGw90b6rdC05NfSKUzi86ZEUsS74bm55T4zQPhLIMRIjzwD/YqE4lcDHMXv4UvwP9Uy9PbaPIkUXIeFxtyR1DLfTNCJXqyrNxCip8O8z6Px8onkibVmb/WF4IfPHb8aWJh5BPPvfRm5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKJMoRul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928EDC4CEE4;
	Mon,  5 May 2025 22:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485480;
	bh=lFmRf0UqXzAD/H+cDJ45OmX59Qe26LwGgupNtdazpJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PKJMoRulYn9MPLX0kzFLep1MuNVfyDWb4/5sCYHFX0mYehFW4Pu2HrbfDkf4LsJNz
	 W3Syo1BGukpYzUrglSIa/7/yWpg343IWZ4LvyGeEkpTwyztHP3RJykWiadXeAWWAJw
	 ngAiEA+AkA2Hm9zKSJgvc1VvE8b/0HfDoHVlHzp9hW4gNCJyKRmkR1g6HHSHZ9aZj0
	 Bn3/A3+iIe9T7ei9JG6hAO3JPFlxoK77tFMarovzskQl5LcrI3rXIZ7ZbSLTRdr9Ik
	 BpMQ0CYHQK2U2tbzBid74zcG5Ek3gYRdERRLrqFciCvjLKmSbRVUTgWXVD5mfQdnVN
	 Y7Ry0LWfROdhg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tejun Heo <tj@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.12 337/486] kernfs: Acquire kernfs_rwsem in kernfs_get_parent_dentry().
Date: Mon,  5 May 2025 18:36:53 -0400
Message-Id: <20250505223922.2682012-337-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 122ab92dee80582c39740609a627198dd5b6b595 ]

kernfs_get_parent_dentry() passes kernfs_node::parent to
kernfs_get_inode().

Acquire kernfs_root::kernfs_rwsem to ensure kernfs_node::parent isn't
replaced during the operation.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20250213145023.2820193-3-bigeasy@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/kernfs/mount.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 0f6379ae258d1..4a0ff08d589ca 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -145,7 +145,9 @@ static struct dentry *kernfs_fh_to_parent(struct super_block *sb,
 static struct dentry *kernfs_get_parent_dentry(struct dentry *child)
 {
 	struct kernfs_node *kn = kernfs_dentry_node(child);
+	struct kernfs_root *root = kernfs_root(kn);
 
+	guard(rwsem_read)(&root->kernfs_rwsem);
 	return d_obtain_alias(kernfs_get_inode(child->d_sb, kn->parent));
 }
 
-- 
2.39.5


