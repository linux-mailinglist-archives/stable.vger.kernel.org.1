Return-Path: <stable+bounces-141263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3AEAAB1DE
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 010DC7B8FB0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A882D3A8E;
	Tue,  6 May 2025 00:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGtDIoeh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131E12D47CD;
	Mon,  5 May 2025 22:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485641; cv=none; b=gkJQ16uLKlNjOMRfFq91sOE2l+7SJEvwfDpWCQwDk7IeijRtexbkwb0ELN71FV187MsFo0qhz4yKf6kxkYadPopcTNkCxWKx3g/uWdCyBF/SV9wt36rQZHvnt/wxTIArBSviNBeHPIRhp46Rg4KN9Brco2aNvKqHGVtqNRfBnWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485641; c=relaxed/simple;
	bh=+wZxgz632sHvnLOgr6eoUPj4ket6MHQdjGTN8+zbFzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m5fWVpr9b/ME7ZwjpYgPAXsyYVC4yj6OlqO/Da8suzNL3caMdOLMJVRPqIGQqYTywfTIcdNCEt0CZtXQwO92/Tq+bXiISXUvoIjCkDPqzVXJJzCXaTmyst4KVBOJZoaSTiexxuJXArHCPqwdjcQtFN5lm6fNfY9VTcGk6FpwspA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGtDIoeh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496FAC4CEED;
	Mon,  5 May 2025 22:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485639;
	bh=+wZxgz632sHvnLOgr6eoUPj4ket6MHQdjGTN8+zbFzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fGtDIoehVn0264eGyISR/0K7vi68gTim5Dz8QBX00ajpppAhpgiDCyxpKs9VX3OnV
	 XucYYZ6BQDjwekdF5W1rQn8DXRQPCE8RWTFb4/cCCNv66ikxqN9uygr3gQURrVk5Y6
	 /X9Y/B4tggTtkNv2VWB+TxJtsA035QmA/KHvMf7332e3E2sMm6CECKwCJwfI00GFKW
	 f8UPhxVtw1fcJVWBEkl21606AdJqg8yee2+df5cO16cyA4oanHKpM1tPmHU8jgB0WR
	 b0XqBMrqS6M+v1tGlr+SjlERShzGQqTNsR/mipTqGgh18nKHFu6tP7/cnXeGqS58iz
	 KkZAFYsrCurHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 400/486] pstore: Change kmsg_bytes storage size to u32
Date: Mon,  5 May 2025 18:37:56 -0400
Message-Id: <20250505223922.2682012-400-sashal@kernel.org>
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

From: Kees Cook <kees@kernel.org>

[ Upstream commit 5674609535bafa834ab014d90d9bbe8e89223a0b ]

The types around kmsg_bytes were inconsistent. The global was unsigned
long, the argument to pstore_set_kmsg_bytes() was int, and the filesystem
option was u32. Given other internal limits, there's not much sense
in making a single pstore record larger than INT_MAX and it can't be
negative, so use u32 everywhere. Additionally, use READ/WRITE_ONCE and a
local variable in pstore_dump() to avoid kmsg_bytes changing during a
dump.

Link: https://lore.kernel.org/r/20250206191655.work.798-kees@kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pstore/inode.c    |  2 +-
 fs/pstore/internal.h |  4 ++--
 fs/pstore/platform.c | 11 ++++++-----
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 56815799ce798..9de6b280c4f41 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -265,7 +265,7 @@ static void parse_options(char *options)
 static int pstore_show_options(struct seq_file *m, struct dentry *root)
 {
 	if (kmsg_bytes != CONFIG_PSTORE_DEFAULT_KMSG_BYTES)
-		seq_printf(m, ",kmsg_bytes=%lu", kmsg_bytes);
+		seq_printf(m, ",kmsg_bytes=%u", kmsg_bytes);
 	return 0;
 }
 
diff --git a/fs/pstore/internal.h b/fs/pstore/internal.h
index 801d6c0b170c3..a0fc511969100 100644
--- a/fs/pstore/internal.h
+++ b/fs/pstore/internal.h
@@ -6,7 +6,7 @@
 #include <linux/time.h>
 #include <linux/pstore.h>
 
-extern unsigned long kmsg_bytes;
+extern unsigned int kmsg_bytes;
 
 #ifdef CONFIG_PSTORE_FTRACE
 extern void pstore_register_ftrace(void);
@@ -35,7 +35,7 @@ static inline void pstore_unregister_pmsg(void) {}
 
 extern struct pstore_info *psinfo;
 
-extern void	pstore_set_kmsg_bytes(int);
+extern void	pstore_set_kmsg_bytes(unsigned int bytes);
 extern void	pstore_get_records(int);
 extern void	pstore_get_backend_records(struct pstore_info *psi,
 					   struct dentry *root, int quiet);
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index f56b066ab80ce..557cf9d40177f 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -92,8 +92,8 @@ module_param(compress, charp, 0444);
 MODULE_PARM_DESC(compress, "compression to use");
 
 /* How much of the kernel log to snapshot */
-unsigned long kmsg_bytes = CONFIG_PSTORE_DEFAULT_KMSG_BYTES;
-module_param(kmsg_bytes, ulong, 0444);
+unsigned int kmsg_bytes = CONFIG_PSTORE_DEFAULT_KMSG_BYTES;
+module_param(kmsg_bytes, uint, 0444);
 MODULE_PARM_DESC(kmsg_bytes, "amount of kernel log to snapshot (in bytes)");
 
 static void *compress_workspace;
@@ -107,9 +107,9 @@ static void *compress_workspace;
 static char *big_oops_buf;
 static size_t max_compressed_size;
 
-void pstore_set_kmsg_bytes(int bytes)
+void pstore_set_kmsg_bytes(unsigned int bytes)
 {
-	kmsg_bytes = bytes;
+	WRITE_ONCE(kmsg_bytes, bytes);
 }
 
 /* Tag each group of saved records with a sequence number */
@@ -278,6 +278,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 			struct kmsg_dump_detail *detail)
 {
 	struct kmsg_dump_iter iter;
+	unsigned int	remaining = READ_ONCE(kmsg_bytes);
 	unsigned long	total = 0;
 	const char	*why;
 	unsigned int	part = 1;
@@ -300,7 +301,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 	kmsg_dump_rewind(&iter);
 
 	oopscount++;
-	while (total < kmsg_bytes) {
+	while (total < remaining) {
 		char *dst;
 		size_t dst_size;
 		int header_size;
-- 
2.39.5


