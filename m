Return-Path: <stable+bounces-1347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A0F7F7F36
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0A7282455
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38160364DE;
	Fri, 24 Nov 2023 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wJ/9OwY0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8114633E9;
	Fri, 24 Nov 2023 18:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D83C433C7;
	Fri, 24 Nov 2023 18:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851174;
	bh=GnzSjpOj05g0O14IEOg9G4ASmg8wkFDRfPBtgf7H9Ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wJ/9OwY0qO+CVgCiSEXd1TULyKwWYH1mvEYnmSpseNZdnaATUKW6GNbfM1CLupitB
	 a8Ckx2PB12JCaHuO49YiuaCDdCLyksdR/93/sBgzS/Idz0SOHEeySQgbZmBOKaKOfO
	 o3TbeIdZo51SGXiBlxgZ0Uem67NTkgvwTKYMl4uc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com
Subject: [PATCH 6.5 325/491] ima: annotate iint mutex to avoid lockdep false positive warnings
Date: Fri, 24 Nov 2023 17:49:21 +0000
Message-ID: <20231124172034.328642280@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit e044374a8a0a99e46f4e6d6751d3042b6d9cc12e upstream.

It is not clear that IMA should be nested at all, but as long is it
measures files both on overlayfs and on underlying fs, we need to
annotate the iint mutex to avoid lockdep false positives related to
IMA + overlayfs, same as overlayfs annotates the inode mutex.

Reported-and-tested-by: syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/integrity/iint.c |   48 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 11 deletions(-)

--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -66,9 +66,32 @@ struct integrity_iint_cache *integrity_i
 	return iint;
 }
 
-static void iint_free(struct integrity_iint_cache *iint)
+#define IMA_MAX_NESTING (FILESYSTEM_MAX_STACK_DEPTH+1)
+
+/*
+ * It is not clear that IMA should be nested at all, but as long is it measures
+ * files both on overlayfs and on underlying fs, we need to annotate the iint
+ * mutex to avoid lockdep false positives related to IMA + overlayfs.
+ * See ovl_lockdep_annotate_inode_mutex_key() for more details.
+ */
+static inline void iint_lockdep_annotate(struct integrity_iint_cache *iint,
+					 struct inode *inode)
+{
+#ifdef CONFIG_LOCKDEP
+	static struct lock_class_key iint_mutex_key[IMA_MAX_NESTING];
+
+	int depth = inode->i_sb->s_stack_depth;
+
+	if (WARN_ON_ONCE(depth < 0 || depth >= IMA_MAX_NESTING))
+		depth = 0;
+
+	lockdep_set_class(&iint->mutex, &iint_mutex_key[depth]);
+#endif
+}
+
+static void iint_init_always(struct integrity_iint_cache *iint,
+			     struct inode *inode)
 {
-	kfree(iint->ima_hash);
 	iint->ima_hash = NULL;
 	iint->version = 0;
 	iint->flags = 0UL;
@@ -80,6 +103,14 @@ static void iint_free(struct integrity_i
 	iint->ima_creds_status = INTEGRITY_UNKNOWN;
 	iint->evm_status = INTEGRITY_UNKNOWN;
 	iint->measured_pcrs = 0;
+	mutex_init(&iint->mutex);
+	iint_lockdep_annotate(iint, inode);
+}
+
+static void iint_free(struct integrity_iint_cache *iint)
+{
+	kfree(iint->ima_hash);
+	mutex_destroy(&iint->mutex);
 	kmem_cache_free(iint_cache, iint);
 }
 
@@ -104,6 +135,8 @@ struct integrity_iint_cache *integrity_i
 	if (!iint)
 		return NULL;
 
+	iint_init_always(iint, inode);
+
 	write_lock(&integrity_iint_lock);
 
 	p = &integrity_iint_tree.rb_node;
@@ -153,25 +186,18 @@ void integrity_inode_free(struct inode *
 	iint_free(iint);
 }
 
-static void init_once(void *foo)
+static void iint_init_once(void *foo)
 {
 	struct integrity_iint_cache *iint = (struct integrity_iint_cache *) foo;
 
 	memset(iint, 0, sizeof(*iint));
-	iint->ima_file_status = INTEGRITY_UNKNOWN;
-	iint->ima_mmap_status = INTEGRITY_UNKNOWN;
-	iint->ima_bprm_status = INTEGRITY_UNKNOWN;
-	iint->ima_read_status = INTEGRITY_UNKNOWN;
-	iint->ima_creds_status = INTEGRITY_UNKNOWN;
-	iint->evm_status = INTEGRITY_UNKNOWN;
-	mutex_init(&iint->mutex);
 }
 
 static int __init integrity_iintcache_init(void)
 {
 	iint_cache =
 	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
-			      0, SLAB_PANIC, init_once);
+			      0, SLAB_PANIC, iint_init_once);
 	return 0;
 }
 DEFINE_LSM(integrity) = {



