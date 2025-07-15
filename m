Return-Path: <stable+bounces-162468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F262B05E1C
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA801C40619
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9EE2E8DE8;
	Tue, 15 Jul 2025 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pRS0Dfr7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8829D2E8DE0;
	Tue, 15 Jul 2025 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586634; cv=none; b=bNxDGgbwRTfmFEOefAiYyZgMoK0TiYXFyAlRyWx94UxjsSA6vMgMDfxkX9rtCV9Bv7+n5DNLqotA4CkIMg/IY3jG+vawX1+Gl5SzAHHCAuTTNaiwWoapk8Ak29nz7qesGnfxT0gd+wZed/XLMgowAus6KieNLvnemoYqOSOiO4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586634; c=relaxed/simple;
	bh=GriXLbIF0J9zUVt6JIMAfUIUaBNCvI4KR38xed0n/aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rt7WyDO/ImpPq2pNh2cF/cKD2dE1D124ehQoNDxtGgwPR99tYDnDqZBys7SF+oO41KK7WMIV6qK/Nl8mwVbW3Q1WcjSBIIFgUes0EkM03BXdE7jU7ZUKPNhErbI14duwpRcSRl0DxGmoDDXIIihNngm0IqoL0l1zy4hfVUeS0Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pRS0Dfr7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B79C4CEE3;
	Tue, 15 Jul 2025 13:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752586634;
	bh=GriXLbIF0J9zUVt6JIMAfUIUaBNCvI4KR38xed0n/aQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pRS0Dfr7DS+A+EnVitI9z6QGhCRnfCN8Ge9W0T2eTJDa0knj2Kb7CpmasD0U0GxHi
	 3VOy8wbqvMSCLTzzoPTMhDrpFrBZBu/ZniYj3IyFR1ivqmBGaHkZRiIE8DjV2Fzt0Z
	 T9Z6fXyJfP58PX1+1Dv9nGbrp5j17cwYmNIKVb80=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	NeilBrown <neilb@brown.name>,
	Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 108/148] fix proc_sys_compare() handling of in-lookup dentries
Date: Tue, 15 Jul 2025 15:13:50 +0200
Message-ID: <20250715130804.635751101@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130800.293690950@linuxfoundation.org>
References: <20250715130800.293690950@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit b969f9614885c20f903e1d1f9445611daf161d6d ]

There's one case where ->d_compare() can be called for an in-lookup
dentry; usually that's nothing special from ->d_compare() point of
view, but... proc_sys_compare() is weird.

The thing is, /proc/sys subdirectories can look differently for
different processes.  Up to and including having the same name
resolve to different dentries - all of them hashed.

The way it's done is ->d_compare() refusing to admit a match unless
this dentry is supposed to be visible to this caller.  The information
needed to discriminate between them is stored in inode; it is set
during proc_sys_lookup() and until it's done d_splice_alias() we really
can't tell who should that dentry be visible for.

Normally there's no negative dentries in /proc/sys; we can run into
a dying dentry in RCU dcache lookup, but those can be safely rejected.

However, ->d_compare() is also called for in-lookup dentries, before
they get positive - or hashed, for that matter.  In case of match
we will wait until dentry leaves in-lookup state and repeat ->d_compare()
afterwards.  In other words, the right behaviour is to treat the
name match as sufficient for in-lookup dentries; if dentry is not
for us, we'll see that when we recheck once proc_sys_lookup() is
done with it.

While we are at it, fix the misspelled READ_ONCE and WRITE_ONCE there.

Fixes: d9171b934526 ("parallel lookups machinery, part 4 (and last)")
Reported-by: NeilBrown <neilb@brown.name>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/inode.c       |  2 +-
 fs/proc/proc_sysctl.c | 18 +++++++++++-------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index a6bb1b5c903e6..86175a8c04b3f 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -53,7 +53,7 @@ static void proc_evict_inode(struct inode *inode)
 
 	head = ei->sysctl;
 	if (head) {
-		RCU_INIT_POINTER(ei->sysctl, NULL);
+		WRITE_ONCE(ei->sysctl, NULL);
 		proc_sys_evict_inode(inode, head);
 	}
 }
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index f4264dd4ea31b..c8dad20069803 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -928,17 +928,21 @@ static int proc_sys_compare(const struct dentry *dentry,
 	struct ctl_table_header *head;
 	struct inode *inode;
 
-	/* Although proc doesn't have negative dentries, rcu-walk means
-	 * that inode here can be NULL */
-	/* AV: can it, indeed? */
-	inode = d_inode_rcu(dentry);
-	if (!inode)
-		return 1;
 	if (name->len != len)
 		return 1;
 	if (memcmp(name->name, str, len))
 		return 1;
-	head = rcu_dereference(PROC_I(inode)->sysctl);
+
+	// false positive is fine here - we'll recheck anyway
+	if (d_in_lookup(dentry))
+		return 0;
+
+	inode = d_inode_rcu(dentry);
+	// we just might have run into dentry in the middle of __dentry_kill()
+	if (!inode)
+		return 1;
+
+	head = READ_ONCE(PROC_I(inode)->sysctl);
 	return !head || !sysctl_is_seen(head);
 }
 
-- 
2.39.5




