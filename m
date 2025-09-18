Return-Path: <stable+bounces-167632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCE1B230F9
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E5B567EFD
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67EA2FDC52;
	Tue, 12 Aug 2025 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HxtdGSnm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A345C2FD1D7;
	Tue, 12 Aug 2025 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021467; cv=none; b=rdJDJi67IH8sealKrd3Oz1W9oZfBq4dmLfbDvfLWfgtXCSWiLRSl7R7bYe32zQ62aUPGMpFBidRmXolkOKQ5z7XJX+oV4QGodvJhTOreFqJtLNeltjGSXyZLSChZ19qUBR8m3kYN/nzADdn2x+6soLVh7JwSFoqG3wZOKu99Z6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021467; c=relaxed/simple;
	bh=3/Udn/elJdvzqIyNwQLRgt/Kbk0iRAn5f599JPLju2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sEx1h2QuZSlEL4ZEK90HuRsAFFDLj4ypqXd5gt46h94in0Ugr6jYnZFIKyiG1f+yC9yJdueeuGzc9TwBhGsLwS2iY31McYBG8WHGC+31SwQas5SWAUj74wl0McYDYQZ8Ys63DEk9WIBWtF7z+6ejh424rJ3VTWwBVe+S4Z05aOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HxtdGSnm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13944C4CEF6;
	Tue, 12 Aug 2025 17:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755021467;
	bh=3/Udn/elJdvzqIyNwQLRgt/Kbk0iRAn5f599JPLju2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HxtdGSnmNVi9FLO8PjjidmHYmxKGtxXUvJt+EiuyaSkLOHSyRkGFYg/sQWj1jHJA0
	 +x79m5uai7H3X5uWomigAZY646YXgUDYX+4HpFZ+4DlVL2Jr6OeqcS4yNq1pckTYxN
	 x+98gyv2iR9uOeW5WAkWkelhyuFWeGPhBM9U/Miw=
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
Subject: [PATCH 6.6 132/262] proc: use the same treatment to check proc_lseek as ones for proc_read_iter et.al
Date: Tue, 12 Aug 2025 19:28:40 +0200
Message-ID: <20250812172958.724177823@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172952.959106058@linuxfoundation.org>
References: <20250812172952.959106058@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index c8785d68e870..2187d9ca351c 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -567,6 +567,8 @@ static void pde_set_flags(struct proc_dir_entry *pde)
 	if (pde->proc_ops->proc_compat_ioctl)
 		pde->flags |= PROC_ENTRY_proc_compat_ioctl;
 #endif
+	if (pde->proc_ops->proc_lseek)
+		pde->flags |= PROC_ENTRY_proc_lseek;
 }
 
 struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 4b3ae7e0def3..92772702d369 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -494,7 +494,7 @@ static int proc_reg_open(struct inode *inode, struct file *file)
 	typeof_member(struct proc_ops, proc_release) release;
 	struct pde_opener *pdeo;
 
-	if (!pde->proc_ops->proc_lseek)
+	if (!pde_has_proc_lseek(pde))
 		file->f_mode &= ~FMODE_LSEEK;
 
 	if (pde_is_permanent(pde)) {
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 445c74a39a93..fe3781360120 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -98,6 +98,11 @@ static inline bool pde_has_proc_compat_ioctl(const struct proc_dir_entry *pde)
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
index 1aca3f332d9c..85672adc7349 100644
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




