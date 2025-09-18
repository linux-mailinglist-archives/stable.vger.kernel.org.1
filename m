Return-Path: <stable+bounces-169056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BC6B237EE
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1481B6732A
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443FD21A43B;
	Tue, 12 Aug 2025 19:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f4TUmKjW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0207620E023;
	Tue, 12 Aug 2025 19:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026232; cv=none; b=UJ+YB48OlEZ3BbfRbgQMZmsqSswPu/xVewHJJ3csTMlo7S35qKET9uJSY1xLA9DWSIu/AkRkyz44QBvsvAZhqZSrKq/c1iu5mcwTVpUPRluTmLTr+7VZm3Trfsw0NBObfbooejuJgSiN6uMGc8r56bac46BLNZ/FgLAClL9bhfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026232; c=relaxed/simple;
	bh=lkc8TkyRWGIynRLrPZvPwBWXVVyCjlHsC1QQWak5tMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGGAMiprzw5G947MnlJGc6IRur0pyVcZZImJa2toSBfCmnLbUQr1eKbBftJlLKg+r/Z2ZnB94bvSQmWLDGhfxLWMqz944R+DM377X34a+wFu2jjruNNTveWPNoO97CLitMBAZmXO60JSWjm3Oy5Cdq0w8fK6KzZppPTWYX0Z2IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f4TUmKjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71153C4CEF0;
	Tue, 12 Aug 2025 19:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755026231;
	bh=lkc8TkyRWGIynRLrPZvPwBWXVVyCjlHsC1QQWak5tMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f4TUmKjWHBrmZDhuaUw5t1Cn5ipefiNWK+Ds6eELFKIRxSxJQD9q5y4a4bJnz1xDj
	 13diCeDZOHI3BaM//T03zHGv0zx/DfWtveVTt9obCdCEkL7G0nE6h6g558cY6W/kz1
	 QTQJ7QZJF/y3XcsD/B3Fw3gxRdV64GGPEjWJZrB4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	wangzijie <wangzijie1@honor.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"Kirill A. Shuemov" <kirill.shutemov@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 276/480] proc: use the same treatment to check proc_lseek as ones for proc_read_iter et.al
Date: Tue, 12 Aug 2025 19:48:04 +0200
Message-ID: <20250812174408.823582640@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: wangzijie <wangzijie1@honor.com>

[ Upstream commit ff7ec8dc1b646296f8d94c39339e8d3833d16c05 ]

Check pde->proc_ops->proc_lseek directly may cause UAF in rmmod scenario.
It's a gap in proc_reg_open() after commit 654b33ada4ab("proc: fix UAF in
proc_get_inode()").  Followed by AI Viro's suggestion, fix it in same
manner.

Link: https://lkml.kernel.org/r/20250607021353.1127963-1-wangzijie1@honor.com
Fixes: 3f61631d47f1 ("take care to handle NULL ->proc_lseek()")
Signed-off-by: wangzijie <wangzijie1@honor.com>
Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/generic.c       | 2 ++
 fs/proc/inode.c         | 2 +-
 fs/proc/internal.h      | 5 +++++
 include/linux/proc_fs.h | 1 +
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index a3e22803cddf..e0e50914ab25 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -569,6 +569,8 @@ static void pde_set_flags(struct proc_dir_entry *pde)
 	if (pde->proc_ops->proc_compat_ioctl)
 		pde->flags |= PROC_ENTRY_proc_compat_ioctl;
 #endif
+	if (pde->proc_ops->proc_lseek)
+		pde->flags |= PROC_ENTRY_proc_lseek;
 }
 
 struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 3604b616311c..129490151be1 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -473,7 +473,7 @@ static int proc_reg_open(struct inode *inode, struct file *file)
 	typeof_member(struct proc_ops, proc_open) open;
 	struct pde_opener *pdeo;
 
-	if (!pde->proc_ops->proc_lseek)
+	if (!pde_has_proc_lseek(pde))
 		file->f_mode &= ~FMODE_LSEEK;
 
 	if (pde_is_permanent(pde)) {
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 96122e91c645..3d48ffe72583 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -99,6 +99,11 @@ static inline bool pde_has_proc_compat_ioctl(const struct proc_dir_entry *pde)
 #endif
 }
 
+static inline bool pde_has_proc_lseek(const struct proc_dir_entry *pde)
+{
+	return pde->flags & PROC_ENTRY_proc_lseek;
+}
+
 extern struct kmem_cache *proc_dir_entry_cache;
 void pde_free(struct proc_dir_entry *pde);
 
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index ea62201c74c4..703d0c76cc9a 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -27,6 +27,7 @@ enum {
 
 	PROC_ENTRY_proc_read_iter	= 1U << 1,
 	PROC_ENTRY_proc_compat_ioctl	= 1U << 2,
+	PROC_ENTRY_proc_lseek		= 1U << 3,
 };
 
 struct proc_ops {
-- 
2.39.5




