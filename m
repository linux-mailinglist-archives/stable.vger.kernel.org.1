Return-Path: <stable+bounces-1731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CCE7F8118
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1773B1C214F4
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9D135F1A;
	Fri, 24 Nov 2023 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BoptarSv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AD828DBB;
	Fri, 24 Nov 2023 18:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993DDC433C8;
	Fri, 24 Nov 2023 18:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852134;
	bh=fwmNgd+nitHqWyU4tJW1SM9r5GXQnq2m6kdxHqqyH/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BoptarSvMe+IK7SBKhiIT3x9dDRsPxTfoTnKEhuVnbTw3urMx1iuUWB0tzKNI57Yz
	 yHRm6CUe/qq88qKtf9BN+GDLB9aKBf8+YMX1cD1dYSiGdpMtkKwoHp6Jazq4lPHcqX
	 sR7oKUrlhTqa/POognu9aMQNF6NBZ1uBv++8lI8k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Raul E Rangel <rrangel@chromium.org>,
	Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 6.1 234/372] ima: detect changes to the backing overlay file
Date: Fri, 24 Nov 2023 17:50:21 +0000
Message-ID: <20231124172018.320729333@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mimi Zohar <zohar@linux.ibm.com>

commit b836c4d29f2744200b2af41e14bf50758dddc818 upstream.

Commit 18b44bc5a672 ("ovl: Always reevaluate the file signature for
IMA") forced signature re-evaulation on every file access.

Instead of always re-evaluating the file's integrity, detect a change
to the backing file, by comparing the cached file metadata with the
backing file's metadata.  Verifying just the i_version has not changed
is insufficient.  In addition save and compare the i_ino and s_dev
as well.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Tested-by: Eric Snowberg <eric.snowberg@oracle.com>
Tested-by: Raul E Rangel <rrangel@chromium.org>
Cc: stable@vger.kernel.org
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/overlayfs/super.c              |    2 +-
 security/integrity/ima/ima_api.c  |    5 +++++
 security/integrity/ima/ima_main.c |   16 +++++++++++++++-
 security/integrity/integrity.h    |    2 ++
 4 files changed, 23 insertions(+), 2 deletions(-)

--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -2155,7 +2155,7 @@ static int ovl_fill_super(struct super_b
 		ovl_trusted_xattr_handlers;
 	sb->s_fs_info = ofs;
 	sb->s_flags |= SB_POSIXACL;
-	sb->s_iflags |= SB_I_SKIP_SYNC | SB_I_IMA_UNVERIFIABLE_SIGNATURE;
+	sb->s_iflags |= SB_I_SKIP_SYNC;
 
 	err = -ENOMEM;
 	root_dentry = ovl_get_root(sb, upperpath.dentry, oe);
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -243,6 +243,7 @@ int ima_collect_measurement(struct integ
 {
 	const char *audit_cause = "failed";
 	struct inode *inode = file_inode(file);
+	struct inode *real_inode = d_real_inode(file_dentry(file));
 	const char *filename = file->f_path.dentry->d_name.name;
 	struct ima_max_digest_data hash;
 	int result = 0;
@@ -305,6 +306,10 @@ int ima_collect_measurement(struct integ
 	iint->ima_hash = tmpbuf;
 	memcpy(iint->ima_hash, &hash, length);
 	iint->version = i_version;
+	if (real_inode != inode) {
+		iint->real_ino = real_inode->i_ino;
+		iint->real_dev = real_inode->i_sb->s_dev;
+	}
 
 	/* Possibly temporary failure due to type of read (eg. O_DIRECT) */
 	if (!result)
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -26,6 +26,7 @@
 #include <linux/ima.h>
 #include <linux/iversion.h>
 #include <linux/fs.h>
+#include <linux/iversion.h>
 
 #include "ima.h"
 
@@ -202,7 +203,7 @@ static int process_measurement(struct fi
 			       u32 secid, char *buf, loff_t size, int mask,
 			       enum ima_hooks func)
 {
-	struct inode *inode = file_inode(file);
+	struct inode *backing_inode, *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
 	struct ima_template_desc *template_desc = NULL;
 	char *pathbuf = NULL;
@@ -278,6 +279,19 @@ static int process_measurement(struct fi
 		iint->measured_pcrs = 0;
 	}
 
+	/* Detect and re-evaluate changes made to the backing file. */
+	backing_inode = d_real_inode(file_dentry(file));
+	if (backing_inode != inode &&
+	    (action & IMA_DO_MASK) && (iint->flags & IMA_DONE_MASK)) {
+		if (!IS_I_VERSION(backing_inode) ||
+		    backing_inode->i_sb->s_dev != iint->real_dev ||
+		    backing_inode->i_ino != iint->real_ino ||
+		    !inode_eq_iversion(backing_inode, iint->version)) {
+			iint->flags &= ~IMA_DONE_MASK;
+			iint->measured_pcrs = 0;
+		}
+	}
+
 	/* Determine if already appraised/measured based on bitmask
 	 * (IMA_MEASURE, IMA_MEASURED, IMA_XXXX_APPRAISE, IMA_XXXX_APPRAISED,
 	 *  IMA_AUDIT, IMA_AUDITED)
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -164,6 +164,8 @@ struct integrity_iint_cache {
 	unsigned long flags;
 	unsigned long measured_pcrs;
 	unsigned long atomic_flags;
+	unsigned long real_ino;
+	dev_t real_dev;
 	enum integrity_status ima_file_status:4;
 	enum integrity_status ima_mmap_status:4;
 	enum integrity_status ima_bprm_status:4;



