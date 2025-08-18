Return-Path: <stable+bounces-169916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C810B297A2
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 06:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9EF169FA9
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 04:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CADD25C838;
	Mon, 18 Aug 2025 04:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="Ap/zqDUq"
X-Original-To: stable@vger.kernel.org
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7141214228
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 04:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755489953; cv=none; b=gBkY3up87T8LC4o8Ub7ZMOODChibGGfhTK6bcAS6CeATW2SSICw9LmZ5mgtn19xnPEcoNt23m8HaxKRwju0XLl9VfXTU5EQ8u97iiJfOA9FUbTWK7Kexsz5knA/RqRtoVlxa049Ax5id9oBJLfyf48vna3kPWZ0J5le0tk3rOX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755489953; c=relaxed/simple;
	bh=241GMDtQFPTad17nsb8K4ns2GfmB8X7VHCtkkfWYmlE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EAWHJG/jNH0h3dVFTczr6WRhJnx+SWUb7ZadBhLXDjR25oKAUWvPEmNUfSX0oDpz6PkA/AEmyb5SaTg8hE9DXiJeAPZ97lZVr8icRA+RwDpTcQBiLYOqbvtVzl+bTBdIYEEYb1CS5DOghiFW/xT15g9MYxUqcPrqdGgTEpEBiO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=Ap/zqDUq; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=TGr0CJdWjvW6XSRyCCqtBV1odyJvmpfAvpUsJkjheDY=;
	b=Ap/zqDUq6Mwo8BJ3AavHOtCDWPhi4lUfNglH85EmkiXb8oOt4gf2XfA8OE6KNKAkW30o7YRwd
	so5NB6hoHxzJ1dLAToP6YCuSYcS2aLR7frOVULr7hNgL0WvkAG2qQjoCvBjCXYJ5jYYy8K/QhW2
	+yQo6lGUCihhCG4Fh3gPt3M=
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4c4zdj1JpnzYkxfN;
	Mon, 18 Aug 2025 12:05:29 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 18 Aug
 2025 12:05:37 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 18 Aug
 2025 12:05:36 +0800
From: wangzijie <wangzijie1@honor.com>
To: <akpm@linux-foundation.org>, <viro@zeniv.linux.org.uk>,
	<adobriyan@gmail.com>, <rick.p.edgecombe@intel.com>, <ast@kernel.org>,
	<kirill.shutemov@linux.intel.com>
CC: <polynomial-c@gmx.de>, <gregkh@linuxfoundation.org>,
	<stable@vger.kernel.org>, <regressions@lists.linux.dev>, wangzijie
	<wangzijie1@honor.com>
Subject: [PATCH] proc: fix wrong behavior of FMODE_LSEEK clearing for net related proc file
Date: Mon, 18 Aug 2025 12:05:35 +0800
Message-ID: <20250818040535.564611-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w010.hihonor.com (10.68.28.113) To a011.hihonor.com
 (10.68.31.243)

For avoiding pde->proc_ops->... dereference(which may cause UAF in rmmod race scene),
we call pde_set_flags() to save this kind of information in PDE itself before
proc_register() and call pde_has_proc_XXX() to replace pde->proc_ops->... dereference.
But there has omission of pde_set_flags() in net related proc file create, which cause
the wroing behavior of FMODE_LSEEK clearing in proc_reg_open() for net related proc file
after commit ff7ec8dc1b64("proc: use the same treatment to check proc_lseek as ones for
proc_read_iter et.al"). Lars reported it in this link[1]. So call pde_set_flags() when
create net related proc file to fix this bug.

[1]: https://lore.kernel.org/all/20250815195616.64497967@chagall.paradoxon.rec/

Fixes: ff7ec8dc1b64 ("proc: use the same treatment to check proc_lseek as ones for proc_read_iter et.al)
Signed-off-by: wangzijie <wangzijie1@honor.com>
---
 fs/proc/generic.c  | 2 +-
 fs/proc/internal.h | 1 +
 fs/proc/proc_net.c | 4 ++++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 76e800e38..57ec5e385 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -561,7 +561,7 @@ struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
 	return p;
 }
 
-static void pde_set_flags(struct proc_dir_entry *pde)
+void pde_set_flags(struct proc_dir_entry *pde)
 {
 	if (pde->proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
 		pde->flags |= PROC_ENTRY_PERMANENT;
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index e737401d7..c4f7cbc7d 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -284,6 +284,7 @@ extern struct dentry *proc_lookup(struct inode *, struct dentry *, unsigned int)
 struct dentry *proc_lookup_de(struct inode *, struct dentry *, struct proc_dir_entry *);
 extern int proc_readdir(struct file *, struct dir_context *);
 int proc_readdir_de(struct file *, struct dir_context *, struct proc_dir_entry *);
+void pde_set_flags(struct proc_dir_entry *);
 
 static inline void pde_get(struct proc_dir_entry *pde)
 {
diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index 52f0b75cb..20bc7481b 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -124,6 +124,7 @@ struct proc_dir_entry *proc_create_net_data(const char *name, umode_t mode,
 	p->proc_ops = &proc_net_seq_ops;
 	p->seq_ops = ops;
 	p->state_size = state_size;
+	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL_GPL(proc_create_net_data);
@@ -170,6 +171,7 @@ struct proc_dir_entry *proc_create_net_data_write(const char *name, umode_t mode
 	p->seq_ops = ops;
 	p->state_size = state_size;
 	p->write = write;
+	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL_GPL(proc_create_net_data_write);
@@ -217,6 +219,7 @@ struct proc_dir_entry *proc_create_net_single(const char *name, umode_t mode,
 	pde_force_lookup(p);
 	p->proc_ops = &proc_net_single_ops;
 	p->single_show = show;
+	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL_GPL(proc_create_net_single);
@@ -261,6 +264,7 @@ struct proc_dir_entry *proc_create_net_single_write(const char *name, umode_t mo
 	p->proc_ops = &proc_net_single_ops;
 	p->single_show = show;
 	p->write = write;
+	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL_GPL(proc_create_net_single_write);
-- 
2.25.1


