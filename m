Return-Path: <stable+bounces-235919-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mINJGJuQ3Gl/TAkAu9opvQ
	(envelope-from <stable+bounces-235919-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:43:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D4F3E7DFB
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE44630166C6
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FB73921E4;
	Mon, 13 Apr 2026 06:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="jVboKk/4"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9132A3921E0
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062597; cv=none; b=UjjxqvD1grgxSOjd6xmx+Tt3jSTOnTzx+7nKK+WY4fy/bPuUq5oYnWlIuQOWEqIVgOxJ6IhZ4C4e1acLMOueFXqRu+bnR3YT/H/3OG4uSc+XMyInMnCU+cClJonpCad4Oic/j84e72GHGHiYaxif6RdhX+Sdh+R7Oiwg+n6cPZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062597; c=relaxed/simple;
	bh=ZmHiMYyJeCSvDM5aKOqbDl9bWl8RIZyT//zlF/Red0E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UthJ97cr6Ft674nBOOyArF7PNPHIsIOT3dArVrcaNHy486IHTF4LRk7EfzrvoXADuXoY1bVuLAzw0+GrIEnSjmgndtM6vnRJ0Z0svmVZAd9QH+sJRGo+cxgamrBaG7hapJtoJO2C1tOcBuPe/r4G3qiX3GDmat65Ke/i85jFZVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=jVboKk/4; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 61F363F20E
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776062594;
	bh=axOvx9+o24IJ3CzhQdCj/hZeo3fClP31m22PHHvlOLI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=jVboKk/4SGERVyWDeSxViuK/UXbCyOtvPRm51tumwJb3gWRkbo9fWwM0ixXUeoIlS
	 AJThDox053mO8dozYJaySqhudLN/HoO/IKiawYMNnQ5FBpgBzp6lIQ4P/Ls2NX/N2D
	 l1JsHen6TEDyH9vhvM6ITCYYbGE7jWgkKC4RlD4Omgh5Ut4/zME5A1vLHSdBbbXb5p
	 72Tp7awLpw83KWRjhUZ1lBe5aLqfL7XWIb5atSCumMj79qn6h+Aq6CKX+uwzzfBscL
	 xpdRjqHNnulxBNREJafsio5wQJl94zg1MG7JLqKe0TAj6T5MMctaJuccROmXCtcXUt
	 iNyyi2679NhOusagBv30idPrGPIsuUPjYC9fflne9WhBlB/3wuDLkvbGQ15qjvOTl5
	 dHDvLZSVxrEv2wrGPLORGVBaULd9Hqh2uH4TTtJmj34BMcN5nYv9CilAg7enYv5DvW
	 zRUUf4a/QmuoctEMGdo9DoVJW0vdYXwQ70UXrmvzhvvqqL4rhoJxeAVHYxn5tTN3oG
	 lCcIeO30ia5ShXzB57RYKSySX1z64z5Q104qOgxS6ZvFb93jATmrUNbP0MIEJZ36+i
	 Nx/l+FEGUl8fEbTnntiL9JZp3emGFeFVOkDSlFdt6G5bkGuOKon7SrfctcYvGjOoZJ
	 iZXxs/1Wo7LdC8Ae+lmW7O9I=
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b4654f9bb6so2273385ad.2
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 23:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776062593; x=1776667393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=axOvx9+o24IJ3CzhQdCj/hZeo3fClP31m22PHHvlOLI=;
        b=XLyYhVK3sMNmohlqIvhWpbR00AUNltl9XhEQf6IYgTfgz3izGekpu7qvg+Nr9oUSb9
         f1kvtfUZ7P9OuyKTtmC/MWYDBGI4gITt38AIdOxq+NapGnM9ubtIwGys54Hy3ZOSTeU1
         bpmVvYp5H7S21FZzJTG4qedKTfHsxgEFImRMkX3djoBBRozrKt9Nq5G6v+TXFw8n+ZVl
         q5hXqVjfCvAcg7tq6atV6uRtdFPJZKw4000lIx/EQOvKOAINrW/2OxQaHgh8cnsyHELl
         pf+G2Q0sHEbMo13ldg4+bDDvD1NeZN7waUTHvXARKHu1UBefMWUpce4GXOVREeyMOZfu
         uyeg==
X-Gm-Message-State: AOJu0Yz3jMUE02arqUw7+E6qCNF5ciFwu3Z1ydpWcy6n6TDgIuUyvVjf
	0fcT5Es9p5vdfPT4vi0c5D0Q3mqRXNjkAcnq1oRjfzUgRyT38c2nYDedlfIHseubsaZm/1dbi0r
	fquFvCW9sspbnKcNScEU8GKTbzXKkg8C4mKR6IU4AZ9iWukDql3R8o+122ppUSoX09kFJ5yzj8/
	CS8jyWLw==
X-Gm-Gg: AeBDiet3AsK8Fge6JVhVUKGOQHh8HJQwOj6D4SaYOd6h78L4PxmxzsuKhsDhh85k0mu
	Moj/Hgk5+J6K+Jqi9YsWH5tXyqFw/BI97lg9WkJC9gyqIxQ6CvYbNivwYL6J4Z2Bxp/PWZ95h/n
	wz4rgi0zyYhT6d2dcUUVPTbDMLSU54cVEvtPKsitkpkoqHca3kZqGcRfwgU/HZ8Q0JP+p8IddKp
	AGfOvbrhEHKhdbaP8NZET5nVgycwSHcKnSQPQzX9pdl5MwnHqUCVKy7zFRkuW6eNsDXXgH9a2Uu
	DTMw6RtwFFXlOZzIGYjuI7G0Wlk2YPzRPq/MONdjyfkGL5fxIq6k9EKIbo1Z9uv8xfaIYx9Dmms
	ytRTJQbelujLRGKqSHOfbXHjl2nQ=
X-Received: by 2002:a17:903:1207:b0:2b2:5637:1480 with SMTP id d9443c01a7336-2b2d5a95dacmr123820875ad.40.1776062592992;
        Sun, 12 Apr 2026 23:43:12 -0700 (PDT)
X-Received: by 2002:a17:903:1207:b0:2b2:5637:1480 with SMTP id d9443c01a7336-2b2d5a95dacmr123820625ad.40.1776062592505;
        Sun, 12 Apr 2026 23:43:12 -0700 (PDT)
Received: from localhost ([50.47.147.90])
        by smtp.googlemail.com with UTF8SMTPSA id d9443c01a7336-2b46151801dsm15024835ad.78.2026.04.12.23.43.11
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 23:43:12 -0700 (PDT)
From: John Johansen <john.johansen@canonical.com>
To: stable@vger.kernel.org
Subject: [PATCH 10/11] apparmor: fix race on rawdata dereference
Date: Sun, 12 Apr 2026 23:39:19 -0700
Message-ID: <20260413064256.1578919-11-john.johansen@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260413064256.1578919-1-john.johansen@canonical.com>
References: <20260413064256.1578919-1-john.johansen@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235919-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[canonical.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.johansen@canonical.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,canonical.com:dkim,canonical.com:email,canonical.com:mid]
X-Rspamd-Queue-Id: 16D4F3E7DFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit a0b7091c4de45a7325c8780e6934a894f92ac86b upstream.

There is a race condition that leads to a use-after-free situation:
because the rawdata inodes are not refcounted, an attacker can start
open()ing one of the rawdata files, and at the same time remove the
last reference to this rawdata (by removing the corresponding profile,
for example), which frees its struct aa_loaddata; as a result, when
seq_rawdata_open() is reached, i_private is a dangling pointer and
freed memory is accessed.

The rawdata inodes weren't refcounted to avoid a circular refcount and
were supposed to be held by the profile rawdata reference.  However
during profile removal there is a window where the vfs and profile
destruction race, resulting in the use after free.

Fix this by moving to a double refcount scheme. Where the profile
refcount on rawdata is used to break the circular dependency. Allowing
for freeing of the rawdata once all inode references to the rawdata
are put.

Fixes: 5d5182cae401 ("apparmor: move to per loaddata files, instead of replicating in profiles")
Reported-by: Qualys Security Advisory <qsa@qualys.com>
Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>
Reviewed-by: Maxime Bélair <maxime.belair@canonical.com>
Reviewed-by: Cengiz Can <cengiz.can@canonical.com>
Tested-by: Salvatore Bonaccorso <carnil@debian.org>
Signed-off-by: John Johansen <john.johansen@canonical.com>
---
 security/apparmor/apparmorfs.c            | 35 ++++++-----
 security/apparmor/include/policy_unpack.h | 71 ++++++++++++++---------
 security/apparmor/policy.c                | 12 ++--
 security/apparmor/policy_unpack.c         | 32 +++++++---
 4 files changed, 93 insertions(+), 57 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 122066bb8bda..d7f9bfa5b661 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -79,7 +79,7 @@ static void rawdata_f_data_free(struct rawdata_f_data *private)
 	if (!private)
 		return;
 
-	aa_put_loaddata(private->loaddata);
+	aa_put_i_loaddata(private->loaddata);
 	kvfree(private);
 }
 
@@ -404,7 +404,8 @@ static struct aa_loaddata *aa_simple_write_to_buffer(const char __user *userbuf,
 
 	data->size = copy_size;
 	if (copy_from_user(data->data, userbuf, copy_size)) {
-		aa_put_loaddata(data);
+		/* trigger free - don't need to put pcount */
+		aa_put_i_loaddata(data);
 		return ERR_PTR(-EFAULT);
 	}
 
@@ -432,7 +433,10 @@ static ssize_t policy_update(u32 mask, const char __user *buf, size_t size,
 	error = PTR_ERR(data);
 	if (!IS_ERR(data)) {
 		error = aa_replace_profiles(ns, label, mask, data);
-		aa_put_loaddata(data);
+		/* put pcount, which will put count and free if no
+		 * profiles referencing it.
+		 */
+		aa_put_profile_loaddata(data);
 	}
 end_section:
 	end_current_label_crit_section(label);
@@ -503,7 +507,7 @@ static ssize_t profile_remove(struct file *f, const char __user *buf,
 	if (!IS_ERR(data)) {
 		data->data[size] = 0;
 		error = aa_remove_profiles(ns, label, data->data, size);
-		aa_put_loaddata(data);
+		aa_put_profile_loaddata(data);
 	}
  out:
 	end_current_label_crit_section(label);
@@ -1227,18 +1231,17 @@ static const struct file_operations seq_rawdata_ ##NAME ##_fops = {	      \
 static int seq_rawdata_open(struct inode *inode, struct file *file,
 			    int (*show)(struct seq_file *, void *))
 {
-	struct aa_loaddata *data = __aa_get_loaddata(inode->i_private);
+	struct aa_loaddata *data = aa_get_i_loaddata(inode->i_private);
 	int error;
 
 	if (!data)
-		/* lost race this ent is being reaped */
 		return -ENOENT;
 
 	error = single_open(file, show, data);
 	if (error) {
 		AA_BUG(file->private_data &&
 		       ((struct seq_file *)file->private_data)->private);
-		aa_put_loaddata(data);
+		aa_put_i_loaddata(data);
 	}
 
 	return error;
@@ -1249,7 +1252,7 @@ static int seq_rawdata_release(struct inode *inode, struct file *file)
 	struct seq_file *seq = (struct seq_file *) file->private_data;
 
 	if (seq)
-		aa_put_loaddata(seq->private);
+		aa_put_i_loaddata(seq->private);
 
 	return single_release(inode, file);
 }
@@ -1371,9 +1374,8 @@ static int rawdata_open(struct inode *inode, struct file *file)
 	if (!aa_current_policy_view_capable(NULL))
 		return -EACCES;
 
-	loaddata = __aa_get_loaddata(inode->i_private);
+	loaddata = aa_get_i_loaddata(inode->i_private);
 	if (!loaddata)
-		/* lost race: this entry is being reaped */
 		return -ENOENT;
 
 	private = rawdata_f_data_alloc(loaddata->size);
@@ -1398,7 +1400,7 @@ static int rawdata_open(struct inode *inode, struct file *file)
 	return error;
 
 fail_private_alloc:
-	aa_put_loaddata(loaddata);
+	aa_put_i_loaddata(loaddata);
 	return error;
 }
 
@@ -1415,9 +1417,9 @@ static void remove_rawdata_dents(struct aa_loaddata *rawdata)
 
 	for (i = 0; i < AAFS_LOADDATA_NDENTS; i++) {
 		if (!IS_ERR_OR_NULL(rawdata->dents[i])) {
-			/* no refcounts on i_private */
 			aafs_remove(rawdata->dents[i]);
 			rawdata->dents[i] = NULL;
+			aa_put_i_loaddata(rawdata);
 		}
 	}
 }
@@ -1456,18 +1458,21 @@ int __aa_fs_create_rawdata(struct aa_ns *ns, struct aa_loaddata *rawdata)
 	if (IS_ERR(dir))
 		/* ->name freed when rawdata freed */
 		return PTR_ERR(dir);
+	aa_get_i_loaddata(rawdata);
 	rawdata->dents[AAFS_LOADDATA_DIR] = dir;
 
 	dent = aafs_create_file("abi", S_IFREG | 0444, dir, rawdata,
 				      &seq_rawdata_abi_fops);
 	if (IS_ERR(dent))
 		goto fail;
+	aa_get_i_loaddata(rawdata);
 	rawdata->dents[AAFS_LOADDATA_ABI] = dent;
 
 	dent = aafs_create_file("revision", S_IFREG | 0444, dir, rawdata,
 				      &seq_rawdata_revision_fops);
 	if (IS_ERR(dent))
 		goto fail;
+	aa_get_i_loaddata(rawdata);
 	rawdata->dents[AAFS_LOADDATA_REVISION] = dent;
 
 	if (aa_g_hash_policy) {
@@ -1475,6 +1480,7 @@ int __aa_fs_create_rawdata(struct aa_ns *ns, struct aa_loaddata *rawdata)
 					      rawdata, &seq_rawdata_hash_fops);
 		if (IS_ERR(dent))
 			goto fail;
+		aa_get_i_loaddata(rawdata);
 		rawdata->dents[AAFS_LOADDATA_HASH] = dent;
 	}
 
@@ -1483,24 +1489,25 @@ int __aa_fs_create_rawdata(struct aa_ns *ns, struct aa_loaddata *rawdata)
 				&seq_rawdata_compressed_size_fops);
 	if (IS_ERR(dent))
 		goto fail;
+	aa_get_i_loaddata(rawdata);
 	rawdata->dents[AAFS_LOADDATA_COMPRESSED_SIZE] = dent;
 
 	dent = aafs_create_file("raw_data", S_IFREG | 0444,
 				      dir, rawdata, &rawdata_fops);
 	if (IS_ERR(dent))
 		goto fail;
+	aa_get_i_loaddata(rawdata);
 	rawdata->dents[AAFS_LOADDATA_DATA] = dent;
 	d_inode(dent)->i_size = rawdata->size;
 
 	rawdata->ns = aa_get_ns(ns);
 	list_add(&rawdata->list, &ns->rawdata_list);
-	/* no refcount on inode rawdata */
 
 	return 0;
 
 fail:
 	remove_rawdata_dents(rawdata);
-
+	aa_put_i_loaddata(rawdata);
 	return PTR_ERR(dent);
 }
 #endif /* CONFIG_SECURITY_APPARMOR_EXPORT_BINARY */
diff --git a/security/apparmor/include/policy_unpack.h b/security/apparmor/include/policy_unpack.h
index e89b701447bc..e06031c6d42e 100644
--- a/security/apparmor/include/policy_unpack.h
+++ b/security/apparmor/include/policy_unpack.h
@@ -85,17 +85,29 @@ struct aa_ext {
 	u32 version;
 };
 
-/*
- * struct aa_loaddata - buffer of policy raw_data set
+/* struct aa_loaddata - buffer of policy raw_data set
+ * @count: inode/filesystem refcount - use aa_get_i_loaddata()
+ * @pcount: profile refcount - use aa_get_profile_loaddata()
+ * @list: list the loaddata is on
+ * @work: used to do a delayed cleanup
+ * @dents: refs to dents created in aafs
+ * @ns: the namespace this loaddata was loaded into
+ * @name:
+ * @size: the size of the data that was loaded
+ * @compressed_size: the size of the data when it is compressed
+ * @revision: unique revision count that this data was loaded as
+ * @abi: the abi number the loaddata uses
+ * @hash: a hash of the loaddata, used to help dedup data
  *
- * there is no loaddata ref for being on ns list, nor a ref from
- * d_inode(@dentry) when grab a ref from these, @ns->lock must be held
- * && __aa_get_loaddata() needs to be used, and the return value
- * checked, if NULL the loaddata is already being reaped and should be
- * considered dead.
+ * There is no loaddata ref for being on ns->rawdata_list, so
+ * @ns->lock must be held when walking the list. Dentries and
+ * inode opens hold refs on @count; profiles hold refs on @pcount.
+ * When the last @pcount drops, do_ploaddata_rmfs() removes the
+ * fs entries and drops the associated @count ref.
  */
 struct aa_loaddata {
 	struct kref count;
+	struct kref pcount;
 	struct list_head list;
 	struct work_struct work;
 	struct dentry *dents[AAFS_LOADDATA_NDENTS];
@@ -117,52 +129,55 @@ struct aa_loaddata {
 int aa_unpack(struct aa_loaddata *udata, struct list_head *lh, const char **ns);
 
 /**
- * __aa_get_loaddata - get a reference count to uncounted data reference
+ * aa_get_loaddata - get a reference count from a counted data reference
  * @data: reference to get a count on
  *
- * Returns: pointer to reference OR NULL if race is lost and reference is
- *          being repeated.
- * Requires: @data->ns->lock held, and the return code MUST be checked
- *
- * Use only from inode->i_private and @data->list found references
+ * Returns: pointer to reference
+ * Requires: @data to have a valid reference count on it. It is a bug
+ *           if the race to reap can be encountered when it is used.
  */
 static inline struct aa_loaddata *
-__aa_get_loaddata(struct aa_loaddata *data)
+aa_get_i_loaddata(struct aa_loaddata *data)
 {
-	if (data && kref_get_unless_zero(&(data->count)))
-		return data;
 
-	return NULL;
+	if (data)
+		kref_get(&(data->count));
+	return data;
 }
 
+
 /**
- * aa_get_loaddata - get a reference count from a counted data reference
+ * aa_get_profile_loaddata - get a profile reference count on loaddata
  * @data: reference to get a count on
  *
- * Returns: point to reference
- * Requires: @data to have a valid reference count on it. It is a bug
- *           if the race to reap can be encountered when it is used.
+ * Returns: pointer to reference
+ * Requires: @data to have a valid reference count on it.
  */
 static inline struct aa_loaddata *
-aa_get_loaddata(struct aa_loaddata *data)
+aa_get_profile_loaddata(struct aa_loaddata *data)
 {
-	struct aa_loaddata *tmp = __aa_get_loaddata(data);
-
-	AA_BUG(data && !tmp);
-
-	return tmp;
+	if (data)
+		kref_get(&(data->pcount));
+	return data;
 }
 
 void __aa_loaddata_update(struct aa_loaddata *data, long revision);
 bool aa_rawdata_eq(struct aa_loaddata *l, struct aa_loaddata *r);
 void aa_loaddata_kref(struct kref *kref);
+void aa_ploaddata_kref(struct kref *kref);
 struct aa_loaddata *aa_loaddata_alloc(size_t size);
-static inline void aa_put_loaddata(struct aa_loaddata *data)
+static inline void aa_put_i_loaddata(struct aa_loaddata *data)
 {
 	if (data)
 		kref_put(&data->count, aa_loaddata_kref);
 }
 
+static inline void aa_put_profile_loaddata(struct aa_loaddata *data)
+{
+	if (data)
+		kref_put(&data->pcount, aa_ploaddata_kref);
+}
+
 #if IS_ENABLED(CONFIG_KUNIT)
 bool aa_inbounds(struct aa_ext *e, size_t size);
 size_t aa_unpack_u16_chunk(struct aa_ext *e, char **chunk);
diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index ba94b3f7f9da..c94e7a6d64b1 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -266,7 +266,7 @@ void aa_free_profile(struct aa_profile *profile)
 	}
 
 	kfree_sensitive(profile->hash);
-	aa_put_loaddata(profile->rawdata);
+	aa_put_profile_loaddata(profile->rawdata);
 	aa_label_destroy(&profile->label);
 
 	kfree_sensitive(profile);
@@ -966,7 +966,7 @@ ssize_t aa_replace_profiles(struct aa_ns *policy_ns, struct aa_label *label,
 	LIST_HEAD(lh);
 
 	op = mask & AA_MAY_REPLACE_POLICY ? OP_PROF_REPL : OP_PROF_LOAD;
-	aa_get_loaddata(udata);
+	aa_get_profile_loaddata(udata);
 	/* released below */
 	error = aa_unpack(udata, &lh, &ns_name);
 	if (error)
@@ -1018,10 +1018,10 @@ ssize_t aa_replace_profiles(struct aa_ns *policy_ns, struct aa_label *label,
 			if (aa_rawdata_eq(rawdata_ent, udata)) {
 				struct aa_loaddata *tmp;
 
-				tmp = __aa_get_loaddata(rawdata_ent);
+				tmp = aa_get_profile_loaddata(rawdata_ent);
 				/* check we didn't fail the race */
 				if (tmp) {
-					aa_put_loaddata(udata);
+					aa_put_profile_loaddata(udata);
 					udata = tmp;
 					break;
 				}
@@ -1033,7 +1033,7 @@ ssize_t aa_replace_profiles(struct aa_ns *policy_ns, struct aa_label *label,
 		struct aa_policy *policy;
 
 		if (aa_g_export_binary)
-			ent->new->rawdata = aa_get_loaddata(udata);
+			ent->new->rawdata = aa_get_profile_loaddata(udata);
 		error = __lookup_replace(ns, ent->new->base.hname,
 					 !(mask & AA_MAY_REPLACE_POLICY),
 					 &ent->old, &info);
@@ -1149,7 +1149,7 @@ ssize_t aa_replace_profiles(struct aa_ns *policy_ns, struct aa_label *label,
 
 out:
 	aa_put_ns(ns);
-	aa_put_loaddata(udata);
+	aa_put_profile_loaddata(udata);
 	kfree(ns_name);
 
 	if (error)
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 9e6f3e0d4265..afc6987d79a0 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -112,34 +112,47 @@ bool aa_rawdata_eq(struct aa_loaddata *l, struct aa_loaddata *r)
 	return memcmp(l->data, r->data, r->compressed_size ?: r->size) == 0;
 }
 
+static void do_loaddata_free(struct aa_loaddata *d)
+{
+	kfree_sensitive(d->hash);
+	kfree_sensitive(d->name);
+	kvfree(d->data);
+	kfree_sensitive(d);
+}
+
+void aa_loaddata_kref(struct kref *kref)
+{
+	struct aa_loaddata *d = container_of(kref, struct aa_loaddata, count);
+
+	do_loaddata_free(d);
+}
+
 /*
  * need to take the ns mutex lock which is NOT safe most places that
  * put_loaddata is called, so we have to delay freeing it
  */
-static void do_loaddata_free(struct work_struct *work)
+static void do_ploaddata_rmfs(struct work_struct *work)
 {
 	struct aa_loaddata *d = container_of(work, struct aa_loaddata, work);
 	struct aa_ns *ns = aa_get_ns(d->ns);
 
 	if (ns) {
 		mutex_lock_nested(&ns->lock, ns->level);
+		/* remove fs ref to loaddata */
 		__aa_fs_remove_rawdata(d);
 		mutex_unlock(&ns->lock);
 		aa_put_ns(ns);
 	}
-
-	kfree_sensitive(d->hash);
-	kfree_sensitive(d->name);
-	kvfree(d->data);
-	kfree_sensitive(d);
+	/* called by dropping last pcount, so drop its associated icount */
+	aa_put_i_loaddata(d);
 }
 
-void aa_loaddata_kref(struct kref *kref)
+void aa_ploaddata_kref(struct kref *kref)
 {
-	struct aa_loaddata *d = container_of(kref, struct aa_loaddata, count);
+	struct aa_loaddata *d = container_of(kref, struct aa_loaddata, pcount);
 
 	if (d) {
-		INIT_WORK(&d->work, do_loaddata_free);
+		INIT_WORK(&d->work, do_ploaddata_rmfs);
 		schedule_work(&d->work);
 	}
 }
@@ -157,6 +170,7 @@ struct aa_loaddata *aa_loaddata_alloc(size_t size)
 		return ERR_PTR(-ENOMEM);
 	}
 	kref_init(&d->count);
+	kref_init(&d->pcount);
 	INIT_LIST_HEAD(&d->list);
 
 	return d;
-- 
2.51.0


