Return-Path: <stable+bounces-247270-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNnVD6gPBmoFegIAu9opvQ
	(envelope-from <stable+bounces-247270-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 20:08:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBABD545ACA
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 20:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3309301544C
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 18:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6039E372069;
	Thu, 14 May 2026 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1B+JfYZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BAA33B6F1
	for <stable@vger.kernel.org>; Thu, 14 May 2026 18:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778782115; cv=none; b=O4ZYDDgSqStSNq0GmRjmaiW0G9Z4Syr2kvFsgUlsxeNlX5t4xSXTCRzEGioco7LPVYFrz9aznsOX+U2lY4+AenF1xsRrs2A3HCy2n52z6RmZcvL/94rj7tlczw2HFwRZ8ZkV2X1aGNWT21xcI282AAgReV1GsV18Z+XkZTGg90Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778782115; c=relaxed/simple;
	bh=h960HNNe+V92ZvI6gP4RcHkyEzNtTuItTy+rZhYvONw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r9Yc8htX1vdxTq2FXG+bruhcg16tJ5Hk0/ESOV52bq8zORZM7IX/CxwWgSewlL+Xlyjq/h1KRznDHvDsKp7rtgvvsDp+kp9RUrxzbFOpvg4Df4gl3mk/DYOumW+RqZFzdCbrW2FXqXtSc7eY2ECgXXc7wVXBzpgeIp+mYvpB+Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1B+JfYZ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-366330b6751so5672980a91.1
        for <stable@vger.kernel.org>; Thu, 14 May 2026 11:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778782113; x=1779386913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VfK6dWNOnCHbnZz/I7gFF8NkM/beIlUpgruzfOvGbLA=;
        b=i1B+JfYZPFT6jhx1TBIEHA00RotfcPsHOmW9w5moILxFkl8+vpe8IzUaFYMVIGY5Lw
         6Q+2PqxRuZEN0+T4mMVWg2d+en30wMMGuTzBQAsh/Z7Te9ZJCxnqaWZev4O/c5EUCG3g
         3Yb3fIfUeNi+/olQXjLyAl8g84fhMXB0zPf94pUtuB5iaOyI5bkOP5NHUhR3SJVkJCvb
         MiFelLwFZB19n4IXJjT8hGFSyZ+9Ua3hpnaW8nx6Rx5GXwP1KAwUqdfDic1JcgaC8Etq
         3z59zQuxazqcmcpWsvmG0FzWyqIy8pK16Hlpzz6aqmHdVCveG9SDNJdatF66Kb1J/PI+
         OA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778782113; x=1779386913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfK6dWNOnCHbnZz/I7gFF8NkM/beIlUpgruzfOvGbLA=;
        b=aFJp0t0hv0pX7N6F2fZBafdbhrQ/5YxgBSeu5oXK2mGr1tbdIeP0H/ViOIgKzq0/R2
         sy6cX7pzwFTFD+0Z/Ryme2hGttE76JMAxR4NhQ1OZS5aEcJxO/W5c9dIppL52BPoWdya
         ozzi/Km0nXxUQKLDUSjEMdBkSD/dqj41PuYGKdzXg5pC7ZpyoYfAxUgEMloMagRVhKr5
         KG9YngaLmoxDBhnlWDGZUaKGQrKgsJ91DgWq+fdfzYpq2G7yeHnER+SP6WNVWc1rQn9S
         xpxzDLm3UTHl55D+PFlMeS47hT4vRexBGb+DFTkZmNKadRl0AV8N6TJ0AyMOsQSkRDKJ
         GnZQ==
X-Forwarded-Encrypted: i=1; AFNElJ+OJ66lZxxR+jJ868DNKmnhF0XDHoHHSEaVVjGj+uuQfGTHqdB6ftrvbZMe8eKOqTUnhmsD+GI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySASKZO9iMzmuFclHUZ8Us1ujklgwIQYIpNIcaD5+NHgN1ShIq
	GOiCnHFahsNUWQ8zhlgf0TDJxnylx0YIf8Sl5Bc8An/XxfIYf43ndCzwGiKfJ28f
X-Gm-Gg: Acq92OFHavzn4WWTvIGMRY0Tt8zOR4OOoxEzGp4SEvn9/ad11nbgWw48tysB1iMUooV
	dSp1C7hpaGCgqKdFwEs4SDC8Hm6aELsq8/PswpTF3ahwuHqKUeWmdFqsfPEmqgFwixed/bSxeOb
	i7aLqqF9s/bMqaO/Nch9ibKjhyXXafmmZY5u53SM9OIvBHpBYy6eroE8PTlgfFUlCg8xPmMXf5N
	uZYZyM7sY0MUAMxkAh+5/b7w2mG2xjvoinBntGZgcVQdRTyXwYmABiZhyHMWh7xfwEFGoEamDbP
	VcEXCj0SKtYwK/o+fNDg9MuoF+aV81DJrhPcUYUZ785HT2+j0EkGQPqL6aBEKEB0EyVKqcyRg74
	HXdJw++Nw1HsLS4qEGKTx0mwQjB+bPy/q6ohi0dTqBBWm113fWcRMNUSbflAIVxbZPxb42XznE3
	+DInL4C5ZxhlzDMLRY81nhmMi5wQ+2A5wcY+UlmZgHRWF2/QDdjCSye1MfLxzX6Zrf
X-Received: by 2002:a17:90b:3dc4:b0:365:fca2:8bdd with SMTP id 98e67ed59e1d1-36951778509mr545563a91.0.1778782112950;
        Thu, 14 May 2026 11:08:32 -0700 (PDT)
Received: from sprasad-dev1.corp.microsoft.com ([167.220.110.104])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb121cd6sm3134589a12.30.2026.05.14.11.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 11:08:32 -0700 (PDT)
From: nspmangalore@gmail.com
X-Google-Original-From: sprasad@microsoft.com
To: linux-cifs@vger.kernel.org,
	smfrench@gmail.com,
	pc@manguebit.org,
	bharathsm@microsoft.com,
	dhowells@redhat.com,
	henrique.carvalho@suse.com,
	ematsumiya@suse.de
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 01/17] cifs: invalidate cfid on unlink/rename/rmdir
Date: Thu, 14 May 2026 23:38:07 +0530
Message-ID: <20260514180823.497293-1-sprasad@microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DBABD545ACA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247270-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,manguebit.org,microsoft.com,redhat.com,suse.com,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Shyam Prasad N <sprasad@microsoft.com>

Today we do not invalidate the cached_dirent or the entire
parent cfid when a dentry in a dir has been removed/moved.

This change invalidates the parent cfid so that we don't serve
directory contents from the cache.

Cc: <stable@vger.kernel.org>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
---
 fs/smb/client/inode.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 16a5310155d5a..61f4b9ba2bd25 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -28,6 +28,23 @@
 #include "cached_dir.h"
 #include "reparse.h"
 
+static void cifs_invalidate_cached_dir(struct cifs_tcon *tcon,
+				       struct dentry *parent)
+{
+	struct cached_fid *parent_cfid = NULL;
+
+	if (!tcon || !parent)
+		return;
+
+	if (!open_cached_dir_by_dentry(tcon, parent, &parent_cfid)) {
+		mutex_lock(&parent_cfid->dirents.de_mutex);
+		parent_cfid->dirents.is_valid = false;
+		parent_cfid->dirents.is_failed = true;
+		mutex_unlock(&parent_cfid->dirents.de_mutex);
+		close_cached_dir(parent_cfid);
+	}
+}
+
 /*
  * Set parameters for the netfs library
  */
@@ -2067,6 +2084,9 @@ static int __cifs_unlink(struct inode *dir, struct dentry *dentry, bool sillyren
 		cifs_set_file_info(inode, attrs, xid, full_path, origattr);
 
 out_reval:
+	if (!rc && dentry->d_parent)
+		cifs_invalidate_cached_dir(tcon, dentry->d_parent);
+
 	if (inode) {
 		cifs_inode = CIFS_I(inode);
 		cifs_inode->time = 0;	/* will force revalidate to get info
@@ -2378,7 +2398,6 @@ int cifs_rmdir(struct inode *inode, struct dentry *direntry)
 	}
 
 	rc = server->ops->rmdir(xid, tcon, full_path, cifs_sb);
-	cifs_put_tlink(tlink);
 
 	cifsInode = CIFS_I(d_inode(direntry));
 
@@ -2388,6 +2407,8 @@ int cifs_rmdir(struct inode *inode, struct dentry *direntry)
 		i_size_write(d_inode(direntry), 0);
 		clear_nlink(d_inode(direntry));
 		spin_unlock(&d_inode(direntry)->i_lock);
+		if (direntry->d_parent)
+			cifs_invalidate_cached_dir(tcon, direntry->d_parent);
 	}
 
 	/* force revalidate to go get info when needed */
@@ -2402,6 +2423,7 @@ int cifs_rmdir(struct inode *inode, struct dentry *direntry)
 
 	inode_set_ctime_current(d_inode(direntry));
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
+	cifs_put_tlink(tlink);
 
 rmdir_exit:
 	free_dentry_path(page);
@@ -2668,6 +2690,12 @@ cifs_rename2(struct mnt_idmap *idmap, struct inode *source_dir,
 	}
 
 	/* force revalidate to go get info when needed */
+	if (!rc) {
+		cifs_invalidate_cached_dir(tcon, source_dentry->d_parent);
+		if (target_dentry->d_parent != source_dentry->d_parent)
+			cifs_invalidate_cached_dir(tcon, target_dentry->d_parent);
+	}
+
 	CIFS_I(source_dir)->time = CIFS_I(target_dir)->time = 0;
 
 cifs_rename_exit:
-- 
2.43.0


