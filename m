Return-Path: <stable+bounces-178371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2990B47E65
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD386189FAFC
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F6120E00B;
	Sun,  7 Sep 2025 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="quD+AfYY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416A51F1921;
	Sun,  7 Sep 2025 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757276623; cv=none; b=B49QJJ1ztdYZbSxyvZfg0xhH6nK1fSSUVmG5iokDVvQwxI6J2rkoXkjGnzblPZ89uhUZDSrOqX23NsnWTkpsa57L2Svhr4xOPbzXwVYu5cjfDPhtpUEsYGlHEYSI7wN8cNjhl2qbqtlBTnGtasT6E3woZNTdekfi/DSRRswK95c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757276623; c=relaxed/simple;
	bh=cE3N1Xe30iIEhzjfCyxcUU7ku+9uYgE9/XSM27omgNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EsgTePTroQLGOZuo9DE4aDJyzlxV3bMYmrboso17/+oMIqvaeMKxeAvOBwMu80lEGgkrEG/WlW8Hp4MQkMpjbZYXmArOXRgrfkrcRIYyF1oya9vthyZArvixXHpAlRIGR2X/7h8fNg9ul4bLm1SFuY74y19YrszDKEF3it2k9RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=quD+AfYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC87C4CEF0;
	Sun,  7 Sep 2025 20:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757276623;
	bh=cE3N1Xe30iIEhzjfCyxcUU7ku+9uYgE9/XSM27omgNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=quD+AfYYlhp3Gh/ezlF9zzOSiLGDPl5aKnbYa5nzDuC4XX9e2cY+UIQC3AYv6rWfB
	 ZURjTDK4wBPNAtiThOZnXerKMSNCER/9DYrLjJ1ejvbUEb1eG8h6mX2VmHiWp8pTBT
	 GKI+guOOyaXX4uqhoC+nIPOaQ6+OU+Cy9Z4HLf0E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	wangzijie <wangzijie1@honor.com>,
	Lars Wendler <polynomial-c@gmx.de>,
	Stefano Brivio <sbrivio@redhat.com>,
	=?UTF-8?q?Petr=20Van=C4=9Bk?= <pv@excello.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	"Kirill A. Shutemov" <k.shutemov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 059/121] proc: fix missing pde_set_flags() for net proc files
Date: Sun,  7 Sep 2025 21:58:15 +0200
Message-ID: <20250907195611.352952180@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195609.817339617@linuxfoundation.org>
References: <20250907195609.817339617@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: wangzijie <wangzijie1@honor.com>

commit 2ce3d282bd5050fca8577defeff08ada0d55d062 upstream.

To avoid potential UAF issues during module removal races, we use
pde_set_flags() to save proc_ops flags in PDE itself before
proc_register(), and then use pde_has_proc_*() helpers instead of directly
dereferencing pde->proc_ops->*.

However, the pde_set_flags() call was missing when creating net related
proc files.  This omission caused incorrect behavior which FMODE_LSEEK was
being cleared inappropriately in proc_reg_open() for net proc files.  Lars
reported it in this link[1].

Fix this by ensuring pde_set_flags() is called when register proc entry,
and add NULL check for proc_ops in pde_set_flags().

[wangzijie1@honor.com: stash pde->proc_ops in a local const variable, per Christian]
  Link: https://lkml.kernel.org/r/20250821105806.1453833-1-wangzijie1@honor.com
Link: https://lkml.kernel.org/r/20250818123102.959595-1-wangzijie1@honor.com
Link: https://lore.kernel.org/all/20250815195616.64497967@chagall.paradoxon.rec/ [1]
Fixes: ff7ec8dc1b64 ("proc: use the same treatment to check proc_lseek as ones for proc_read_iter et.al")
Signed-off-by: wangzijie <wangzijie1@honor.com>
Reported-by: Lars Wendler <polynomial-c@gmx.de>
Tested-by: Stefano Brivio <sbrivio@redhat.com>
Tested-by: Petr Vaněk <pv@excello.cz>
Tested by: Lars Wendler <polynomial-c@gmx.de>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Kirill A. Shutemov <k.shutemov@gmail.com>
Cc: wangzijie <wangzijie1@honor.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/generic.c |   38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -362,6 +362,25 @@ static const struct inode_operations pro
 	.setattr	= proc_notify_change,
 };
 
+static void pde_set_flags(struct proc_dir_entry *pde)
+{
+	const struct proc_ops *proc_ops = pde->proc_ops;
+
+	if (!proc_ops)
+		return;
+
+	if (proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
+		pde->flags |= PROC_ENTRY_PERMANENT;
+	if (proc_ops->proc_read_iter)
+		pde->flags |= PROC_ENTRY_proc_read_iter;
+#ifdef CONFIG_COMPAT
+	if (proc_ops->proc_compat_ioctl)
+		pde->flags |= PROC_ENTRY_proc_compat_ioctl;
+#endif
+	if (proc_ops->proc_lseek)
+		pde->flags |= PROC_ENTRY_proc_lseek;
+}
+
 /* returns the registered entry, or frees dp and returns NULL on failure */
 struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
 		struct proc_dir_entry *dp)
@@ -369,6 +388,8 @@ struct proc_dir_entry *proc_register(str
 	if (proc_alloc_inum(&dp->low_ino))
 		goto out_free_entry;
 
+	pde_set_flags(dp);
+
 	write_lock(&proc_subdir_lock);
 	dp->parent = dir;
 	if (pde_subdir_insert(dir, dp) == false) {
@@ -557,20 +578,6 @@ struct proc_dir_entry *proc_create_reg(c
 	return p;
 }
 
-static void pde_set_flags(struct proc_dir_entry *pde)
-{
-	if (pde->proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
-		pde->flags |= PROC_ENTRY_PERMANENT;
-	if (pde->proc_ops->proc_read_iter)
-		pde->flags |= PROC_ENTRY_proc_read_iter;
-#ifdef CONFIG_COMPAT
-	if (pde->proc_ops->proc_compat_ioctl)
-		pde->flags |= PROC_ENTRY_proc_compat_ioctl;
-#endif
-	if (pde->proc_ops->proc_lseek)
-		pde->flags |= PROC_ENTRY_proc_lseek;
-}
-
 struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
 		struct proc_dir_entry *parent,
 		const struct proc_ops *proc_ops, void *data)
@@ -581,7 +588,6 @@ struct proc_dir_entry *proc_create_data(
 	if (!p)
 		return NULL;
 	p->proc_ops = proc_ops;
-	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_data);
@@ -632,7 +638,6 @@ struct proc_dir_entry *proc_create_seq_p
 	p->proc_ops = &proc_seq_ops;
 	p->seq_ops = ops;
 	p->state_size = state_size;
-	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_seq_private);
@@ -663,7 +668,6 @@ struct proc_dir_entry *proc_create_singl
 		return NULL;
 	p->proc_ops = &proc_single_ops;
 	p->single_show = show;
-	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_single_data);



