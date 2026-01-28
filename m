Return-Path: <stable+bounces-211955-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBXZFUvueWm61AEAu9opvQ
	(envelope-from <stable+bounces-211955-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 12:08:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E4AA0136
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 12:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD9643006B72
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 11:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144312E7166;
	Wed, 28 Jan 2026 11:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="bnJKDl1H"
X-Original-To: stable@vger.kernel.org
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4835274B51
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 11:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769598478; cv=none; b=a4qAd2xyKcArP7Cj59/6ydvKSEGW/7Kwntr1jZMxpvWdc1Bw3440tytOaRWcgzUI5hQo+AMCMYQIJWy6R+gFyDAAyPG7jKxp9C9ttf+lEOL0guhJz35h/2V0pLPnI4mq9A4r6dHeD3xYHmNcTmq97PR79N3jGLgkmjvinbwlwnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769598478; c=relaxed/simple;
	bh=RUGGpwkfB69IwIV9Bof4rchzolFtnWarnpHbFpCu+C4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lUBl+aRfGqt2sITLQLZqu/bKSCifrLBjFjzvoYvzq9SQ10xXPQotN6NVly/AdWT2Gi/Zn+7rJrkgIQ3+ndZ/aVT6DLvMybLB/r3B/d73ytmtJJbmS9OuWTFqIRFxCRnQ7q3Y2tv9Uzhcj45VKqDr69cgW/6GpYn37TgIujgGZoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=bnJKDl1H; arc=none smtp.client-ip=120.232.169.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=bnJKDl1HI2cmGg+E4mU5d1PgO8JmPEzzfEdcvNDkpjH70gx74gqr/Lh4jnc4JjkDyPR1wORfuGpVK
	 ZsTma7Dzo4rBgJ1GcKvYZDUd47ZF1Qgd+HM713lasc6ertATBmPS7G3LixZXrJtNADegKYNu3XnLAh
	 NmwcdyByxRx69ZMM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from ubuntu24.corp.ad.wrs.com (unknown[120.244.194.8])
	by rmsmtp-lg-appmail-20-12023 (RichMail) with SMTP id 2ef76979ede7530-6b421;
	Wed, 28 Jan 2026 19:07:44 +0800 (CST)
X-RM-TRANSID:2ef76979ede7530-6b421
From: Bin Lan <lanbincn@139.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>,
	stable@kernel.org,
	Eric Biggers <ebiggers@google.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Bin Lan <lanbincn@139.com>
Subject: [PATCH 5.15.y] ext4: fix memory leaks in ext4_fname_{setup_filename,prepare_lookup}
Date: Wed, 28 Jan 2026 11:07:20 +0000
Message-ID: <20260128110720.4134-1-lanbincn@139.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[139.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[139.com];
	TAGGED_FROM(0.00)[bounces-211955-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[lanbincn@139.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,kernel.org,google.com,mit.edu,139.com];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DKIM_TRACE(0.00)[139.com:-];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,crypto_buf.name:url,139.com:mid,139.com:email]
X-Rspamd-Queue-Id: A0E4AA0136
X-Rspamd-Action: no action

From: Luís Henriques <lhenriques@suse.de>

[ Upstream commit 7ca4b085f430f3774c3838b3da569ceccd6a0177 ]

If the filename casefolding fails, we'll be leaking memory from the
fscrypt_name struct, namely from the 'crypto_buf.name' member.

Make sure we free it in the error path on both ext4_fname_setup_filename()
and ext4_fname_prepare_lookup() functions.

Cc: stable@kernel.org
Fixes: 1ae98e295fa2 ("ext4: optimize match for casefolded encrypted dirs")
Signed-off-by: Luís Henriques <lhenriques@suse.de>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Link: https://lore.kernel.org/r/20230803091713.13239-1-lhenriques@suse.de
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[ fs/ext4/crypto.c was removed by commit
  a7550b30ab70 ("ext4 crypto: migrate into vfs's crypto engine") since
  v4.8, so apply this patch to fs/ext4/ext4.h in v5.15. Move
  ext4_fname_free_filename() to the front of ext4_fname_setup_filename()
  to fix a build issue. ]
Signed-off-by: Bin Lan <lanbincn@139.com>
---
 fs/ext4/ext4.h | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 389251ee9ac9..d2158866a4b5 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2749,6 +2749,23 @@ static inline void ext4_fname_from_fscrypt_name(struct ext4_filename *dst,
 	dst->crypto_buf = src->crypto_buf;
 }
 
+static inline void ext4_fname_free_filename(struct ext4_filename *fname)
+{
+	struct fscrypt_name name;
+
+	name.crypto_buf = fname->crypto_buf;
+	fscrypt_free_filename(&name);
+
+	fname->crypto_buf.name = NULL;
+	fname->usr_fname = NULL;
+	fname->disk_name.name = NULL;
+
+#ifdef CONFIG_UNICODE
+	kfree(fname->cf_name.name);
+	fname->cf_name.name = NULL;
+#endif
+}
+
 static inline int ext4_fname_setup_filename(struct inode *dir,
 					    const struct qstr *iname,
 					    int lookup,
@@ -2765,6 +2782,8 @@ static inline int ext4_fname_setup_filename(struct inode *dir,
 
 #ifdef CONFIG_UNICODE
 	err = ext4_fname_setup_ci_filename(dir, iname, fname);
+	if (err)
+		ext4_fname_free_filename(fname);
 #endif
 	return err;
 }
@@ -2784,26 +2803,11 @@ static inline int ext4_fname_prepare_lookup(struct inode *dir,
 
 #ifdef CONFIG_UNICODE
 	err = ext4_fname_setup_ci_filename(dir, &dentry->d_name, fname);
+	if (err)
+		ext4_fname_free_filename(fname);
 #endif
 	return err;
 }
-
-static inline void ext4_fname_free_filename(struct ext4_filename *fname)
-{
-	struct fscrypt_name name;
-
-	name.crypto_buf = fname->crypto_buf;
-	fscrypt_free_filename(&name);
-
-	fname->crypto_buf.name = NULL;
-	fname->usr_fname = NULL;
-	fname->disk_name.name = NULL;
-
-#ifdef CONFIG_UNICODE
-	kfree(fname->cf_name.name);
-	fname->cf_name.name = NULL;
-#endif
-}
 #else /* !CONFIG_FS_ENCRYPTION */
 static inline int ext4_fname_setup_filename(struct inode *dir,
 					    const struct qstr *iname,
-- 
2.43.0



