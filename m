Return-Path: <stable+bounces-249332-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL4JOxI9C2ouFAUAu9opvQ
	(envelope-from <stable+bounces-249332-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:23:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B7D570D11
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64E833046420
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 16:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BDB480DEC;
	Mon, 18 May 2026 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adSzUe+c"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186653F6C4E
	for <stable@vger.kernel.org>; Mon, 18 May 2026 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120564; cv=none; b=hBmxEEpaGzWRIYY93VZ/gl6piOS9CAO//mHqF9iRXMxRWUOY8GSnrHLe2JtTIlJ6T4rR2ZLgQZEZSX3otnyRknThmjFyqfwlFw+YfV4OSWvHiIg2CDpjWLasoOJdY5VLvByz1Hu7EuoMgyFI9DTLHeTzXxcGSZhBCYZFbvL/MOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120564; c=relaxed/simple;
	bh=D6jlcwbnR+g5EMkQgbi+wNK71CRgyGoU3BDxrCye7Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnR65YWW+LaTe7rfsTsR4W8nyWDFCUR7+P62cRmvRPPhI2QAg9hT1xG9Azzhq4r7LKm68iUeZCTTAMJ5bEZ6f1gPDJ5+noBltsaXZxKljDruJb+IXLD6M9XMqwgzwPgcgPPYqRofz4Kni199ENnopmK7SMHaG/Y5uWn48ARjziw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adSzUe+c; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso8867806eec.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 09:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779120547; x=1779725347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nt5iuo/Mn+BLiddYjPlNVAJnp/6tZOTavwSOYrXtXKE=;
        b=adSzUe+cNe9xAvnLQQDqms+DEcn3jh/VqFO/JuSSO7uUskio7YuXdebPxElVrso5Xu
         kKKB5seuZjExUAT5nJvbRtdTaCU1/lRSCxBjkjrmpVsbHzgrAXY4kkG5uo6c1ZUbiN/+
         u4s0K6WIlVI0Tjycq+zWTjfXWqF0Bj88Z8hHB5qLDcbkiJTEnZmOy1W+GoCKCGGgtw9v
         wMRJKpYDLUU4Q379AHV+vVeUuDHfvbhbxmvwhZ9h6/nqqc7hKY0vP5HEEo9XItaHB+uz
         4s4PoqxzJS2iHN82FXt8HKz5SW3DMDQ1k6g8/cxp0Jt8q/m+tDI/0XQVW2k8tvtavBp3
         IHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779120547; x=1779725347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nt5iuo/Mn+BLiddYjPlNVAJnp/6tZOTavwSOYrXtXKE=;
        b=FwdkOTvJLBaLxmfTP4savl9Z77yZGNFdNst/yZdT7G5WJx1Cu//Plv9CKN5HwmbZAg
         XR+WtcecQv6s4R2eJuYAvHk6PK87kuyZQPKPn6c3a+JQilQyr4DwCS2d16QPVp+JubRi
         tX5axwX48AfaAKsoPk3uL16OxgvyrS7sDQxZVGSVCZDnMloOYEdy2Wt2ETnpFYIol1sW
         LDaQGHBqYthNGPNIhOPLnTDT+Tp9hg1sL5vwtzja9yPY2hjVJppxMiTUYKPJDNM5O+zJ
         hN5Ey/Cn6ujrszQGNXJwpf831q3TJbkAT8DPmMDPX7CcvIfAmKVUP3lscYvyYHDu3lZX
         co1g==
X-Forwarded-Encrypted: i=1; AFNElJ+y1q3JAdf7LPDihmQ7aU1HH+sa7Ugvjp+Pl9UknJgCasZ8MggHe9kI+LHgDidA1fwL0gl7+ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK8K+bt828DeUYmVwSYYAP9cl2feul8NFvGsC2ZyvO+N7P/Lwu
	OLDfBWUqmaENOo/dyH/NF/2PQBxRknHopG5wSEbkW/jpBvrXBNHi3EQ=
X-Gm-Gg: Acq92OHg2KIZoFBUta6YpAQPRWVIFwbE1fAwmRGaopAlxs69Pw3NM+JJg0s2x6gzLvz
	w6p3U7Jychkos4fnsNWAdECTBe9ZWPsZajjDRppjJCk34Pz0lQTsDZRPuovzH8fEV7bGl+pzqAq
	x/Mu3EJ2bowdLuBYoteQBlzJM6sqxbk4HMnS2TrzQ9G+tWNqei5G7HUFDeVl4CGVSFsRl7eOOYH
	P05aMfGqM/3t265GTOqZPjVYcxsipVLjV44ynZVHyKkgwbUpJNjRJGQODdigHws25ByKrNIYESz
	l5oDMfcMO+wpWe/mO+bObfKQg98WIbT2AwSBi93uDgsqa6ZEEddlYMC98OOvrbw5eJX3bryzrty
	O3IbYRgzRgcaQerbNbvn1yksLWjCX4jMWPyIL8cBUdnx7Wyt3cexDaJlgA1V9PmVYk2hmtyFwfo
	lWJuN9XcAJQ0VIRZwWIkHtnaRr2Gcbimm3Xy82YlDADoLhV8JfE4aeW3zzlbV1pSh6ZFGpkFJNU
	v9bJ/9/kcYhdnAeM9I7jcT+Z1POpvsx
X-Received: by 2002:a05:7300:b586:b0:2e2:3381:2fba with SMTP id 5a478bee46e88-3039812a5a6mr6738148eec.3.1779120547150;
        Mon, 18 May 2026 09:09:07 -0700 (PDT)
Received: from localhost.localdomain (157-131-96-99.fiber.dynamic.sonic.net. [157.131.96.99])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bc9d4sm13778284eec.23.2026.05.18.09.09.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 18 May 2026 09:09:06 -0700 (PDT)
From: Rochan Avlur <rochan.avlur@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linkinjeon@kernel.org,
	Yuezhang.Mo@sony.com,
	rochan.avlur@gmail.com,
	rochan.avlur@skydio.com,
	sj1557.seo@samsung.com,
	stable@vger.kernel.org
Subject: [PATCH v3] exfat: preserve benign secondary entries during rename and move
Date: Mon, 18 May 2026 09:08:36 -0700
Message-ID: <20260518160836.29876-1-rochan.avlur@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAKYAXd-1P-bPV5PuUa-cePaObUzmQ+9qTA48mriivEeFeRcvWw@mail.gmail.com>
References: <CAKYAXd-1P-bPV5PuUa-cePaObUzmQ+9qTA48mriivEeFeRcvWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-249332-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,sony.com,gmail.com,skydio.com,samsung.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rochanavlur@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C3B7D570D11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Rochan Avlur <rochan.avlur@skydio.com>

Commit 8258ef28001a ("exfat: handle unreconized benign secondary
entries") added cluster freeing for benign secondary entries inside
exfat_remove_entries().  However, exfat_remove_entries() is also called
from the rename and move paths (exfat_rename_file and exfat_move_file),
where the old entry set is being relocated rather than deleted.  This
causes benign secondary entries such as vendor extension entries to be
silently destroyed on rename or cross-directory move, violating the
exFAT spec requirement (section 8.2) that implementations preserve
unrecognized benign secondary entries.

Fix this by adding a free_benign parameter to exfat_remove_entries()
so that callers can choose whether to free benign secondary clusters,
and helper functions to count and copy trailing benign secondary entries
from the old entry set to the new one.  Both exfat_rename_file() and
exfat_move_file() now use these to preserve extra entries across
relocation.

Also clean up the error paths in both functions so that newly allocated
entry sets are properly deleted on failure, avoiding duplicate directory
entries on disk.

Fixes: 8258ef28001a ("exfat: handle unreconized benign secondary entries")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-fsdevel/CAG7tbBV--waov7XVu2FHQEc6paR92dufS=em9DW5Kzsrpu3iQg@mail.gmail.com/
Signed-off-by: Rochan Avlur <rochan.avlur@skydio.com>
---
v3:
 - Merge exfat_remove_entries_nofree() into exfat_remove_entries() with
   a bool free_benign parameter.
 - Move new_entries and src_start calculations after the early return in
   exfat_copy_trailing_entries().
 - Clean up error paths in exfat_rename_file() and exfat_move_file() to
   delete newly allocated entries on failure.
v2:
 - Resent with proper formatting (no content changes from v1).

 fs/exfat/dir.c      |   4 +-
 fs/exfat/exfat_fs.h |   2 +-
 fs/exfat/namei.c    | 140 +++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 127 insertions(+), 19 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 3045a58e1..04b4ca872 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -505,7 +505,7 @@ void exfat_init_ext_entry(struct exfat_entry_set_cache *es, int num_entries,
 }
 
 void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_cache *es,
-		int order)
+		int order, bool free_benign)
 {
 	int i;
 	struct exfat_dentry *ep;
@@ -513,7 +513,7 @@ void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_cache *es,
 	for (i = order; i < es->num_entries; i++) {
 		ep = exfat_get_dentry_cached(es, i);
 
-		if (exfat_get_entry_type(ep) & TYPE_BENIGN_SEC)
+		if (free_benign && (exfat_get_entry_type(ep) & TYPE_BENIGN_SEC))
 			exfat_free_benign_secondary_clusters(inode, ep);
 
 		exfat_set_entry_type(ep, TYPE_DELETED);
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 176fef625..33fd6e6aa 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -499,7 +499,7 @@ void exfat_init_dir_entry(struct exfat_entry_set_cache *es,
 void exfat_init_ext_entry(struct exfat_entry_set_cache *es, int num_entries,
 		struct exfat_uni_name *p_uniname);
 void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_cache *es,
-		int order);
+		int order, bool free_benign);
 void exfat_update_dir_chksum(struct exfat_entry_set_cache *es);
 int exfat_calc_num_entries(struct exfat_uni_name *p_uniname);
 int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index dfe957493..cac6899bf 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -820,7 +820,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 	exfat_set_volume_dirty(sb);
 
 	/* update the directory entry */
-	exfat_remove_entries(inode, &es, ES_IDX_FILE);
+	exfat_remove_entries(inode, &es, ES_IDX_FILE, true);
 
 	err = exfat_put_dentry_set(&es, IS_DIRSYNC(inode));
 	if (err)
@@ -981,7 +981,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 
 	exfat_set_volume_dirty(sb);
 
-	exfat_remove_entries(inode, &es, ES_IDX_FILE);
+	exfat_remove_entries(inode, &es, ES_IDX_FILE, true);
 
 	err = exfat_put_dentry_set(&es, IS_DIRSYNC(dir));
 	if (err)
@@ -1008,6 +1008,55 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 	return err;
 }
 
+/*
+ * Count benign secondary entries beyond the filename entries.
+ * Returns the count, or -EIO if the entry set is inconsistent.
+ */
+static int exfat_count_extra_entries(struct exfat_entry_set_cache *es)
+{
+	struct exfat_dentry *stream;
+	unsigned int name_entries;
+	int extra;
+
+	stream = exfat_get_dentry_cached(es, ES_IDX_STREAM);
+	name_entries = EXFAT_FILENAME_ENTRY_NUM(stream->dentry.stream.name_len);
+	extra = es->num_entries - (ES_IDX_FIRST_FILENAME + name_entries);
+
+	return extra >= 0 ? extra : -EIO;
+}
+
+/*
+ * Copy benign secondary entries from @src_es to @dst_es, placing them after
+ * the new filename entries.  Updates num_ext and the directory checksum.
+ */
+static int exfat_copy_trailing_entries(struct exfat_entry_set_cache *src_es,
+		struct exfat_entry_set_cache *dst_es)
+{
+	struct exfat_dentry *ep;
+	int extra = exfat_count_extra_entries(src_es);
+	int new_entries, src_start, i;
+
+	if (extra <= 0)
+		return extra < 0 ? extra : 0;
+
+	new_entries = dst_es->num_entries - extra;
+	src_start = src_es->num_entries - extra;
+
+	if (new_entries < ES_IDX_FIRST_FILENAME ||
+	    src_start < ES_IDX_FIRST_FILENAME)
+		return -EIO;
+
+	for (i = 0; i < extra; i++) {
+		*exfat_get_dentry_cached(dst_es, new_entries + i) =
+			*exfat_get_dentry_cached(src_es, src_start + i);
+	}
+
+	ep = exfat_get_dentry_cached(dst_es, ES_IDX_FILE);
+	ep->dentry.file.num_ext += extra;
+	exfat_update_dir_chksum(dst_es);
+	return 0;
+}
+
 static int exfat_rename_file(struct inode *parent_inode,
 		struct exfat_uni_name *p_uniname, struct exfat_inode_info *ei)
 {
@@ -1016,6 +1065,8 @@ static int exfat_rename_file(struct inode *parent_inode,
 	struct super_block *sb = parent_inode->i_sb;
 	struct exfat_entry_set_cache old_es, new_es;
 	int sync = IS_DIRSYNC(parent_inode);
+	unsigned int num_old_name_entries, num_new_name_entries;
+	unsigned int num_extra_entries, num_total_entries;
 
 	if (unlikely(exfat_forced_shutdown(sb)))
 		return -EIO;
@@ -1023,21 +1074,34 @@ static int exfat_rename_file(struct inode *parent_inode,
 	num_new_entries = exfat_calc_num_entries(p_uniname);
 	if (num_new_entries < 0)
 		return num_new_entries;
+	num_new_name_entries = EXFAT_FILENAME_ENTRY_NUM(p_uniname->name_len);
 
 	ret = exfat_get_dentry_set_by_ei(&old_es, sb, ei);
-	if (ret) {
-		ret = -EIO;
-		return ret;
-	}
+	if (ret)
+		return -EIO;
 
 	epold = exfat_get_dentry_cached(&old_es, ES_IDX_FILE);
 
-	if (old_es.num_entries < num_new_entries) {
+	ret = exfat_count_extra_entries(&old_es);
+	if (ret < 0)
+		goto put_old_es;
+	num_extra_entries = ret;
+	num_total_entries = num_new_entries + num_extra_entries;
+	/* needed to detect whether in-place rename would shift extras */
+	num_old_name_entries =
+		old_es.num_entries - ES_IDX_FIRST_FILENAME - num_extra_entries;
+
+	/*
+	 * Relocate when the old slot is too small, or when extra
+	 * entries exist and the name entry count changes.
+	 */
+	if (old_es.num_entries < num_total_entries ||
+	    (num_extra_entries && num_old_name_entries != num_new_name_entries)) {
 		int newentry;
 		struct exfat_chain dir;
 
 		newentry = exfat_find_empty_entry(parent_inode, &dir,
-				num_new_entries, &new_es);
+				num_total_entries, &new_es);
 		if (newentry < 0) {
 			ret = newentry; /* -EIO or -ENOSPC */
 			goto put_old_es;
@@ -1056,11 +1120,24 @@ static int exfat_rename_file(struct inode *parent_inode,
 
 		exfat_init_ext_entry(&new_es, num_new_entries, p_uniname);
 
-		ret = exfat_put_dentry_set(&new_es, sync);
+		ret = exfat_copy_trailing_entries(&old_es, &new_es);
 		if (ret)
+			goto put_new_es;
+
+		ret = exfat_put_dentry_set(&new_es, sync);
+		if (ret) {
+			/* Best-effort delete to avoid duplicate entries */
+			if (!exfat_get_dentry_set(&new_es, sb, &dir,
+						  newentry,
+						  ES_ALL_ENTRIES)) {
+				exfat_remove_entries(parent_inode, &new_es,
+						    ES_IDX_FILE, false);
+				exfat_put_dentry_set(&new_es, false);
+			}
 			goto put_old_es;
+		}
 
-		exfat_remove_entries(parent_inode, &old_es, ES_IDX_FILE);
+		exfat_remove_entries(parent_inode, &old_es, ES_IDX_FILE, false);
 		ei->dir = dir;
 		ei->entry = newentry;
 	} else {
@@ -1069,11 +1146,19 @@ static int exfat_rename_file(struct inode *parent_inode,
 			ei->attr |= EXFAT_ATTR_ARCHIVE;
 		}
 
-		exfat_remove_entries(parent_inode, &old_es, ES_IDX_FIRST_FILENAME + 1);
+		exfat_remove_entries(parent_inode, &old_es,
+				num_new_entries + num_extra_entries, false);
 		exfat_init_ext_entry(&old_es, num_new_entries, p_uniname);
+		if (num_extra_entries) {
+			epold->dentry.file.num_ext += num_extra_entries;
+			exfat_update_dir_chksum(&old_es);
+		}
 	}
 	return exfat_put_dentry_set(&old_es, sync);
 
+put_new_es:
+	exfat_remove_entries(parent_inode, &new_es, ES_IDX_FILE, false);
+	exfat_put_dentry_set(&new_es, false);
 put_old_es:
 	exfat_put_dentry_set(&old_es, false);
 	return ret;
@@ -1086,6 +1171,7 @@ static int exfat_move_file(struct inode *parent_inode,
 	struct exfat_dentry *epmov, *epnew;
 	struct exfat_entry_set_cache mov_es, new_es;
 	struct exfat_chain newdir;
+	unsigned int num_extra_entries, num_total_entries;
 
 	num_new_entries = exfat_calc_num_entries(p_uniname);
 	if (num_new_entries < 0)
@@ -1095,8 +1181,14 @@ static int exfat_move_file(struct inode *parent_inode,
 	if (ret)
 		return -EIO;
 
+	ret = exfat_count_extra_entries(&mov_es);
+	if (ret < 0)
+		goto put_mov_es;
+	num_extra_entries = ret;
+	num_total_entries = num_new_entries + num_extra_entries;
+
 	newentry = exfat_find_empty_entry(parent_inode, &newdir,
-			num_new_entries, &new_es);
+			num_total_entries, &new_es);
 	if (newentry < 0) {
 		ret = newentry; /* -EIO or -ENOSPC */
 		goto put_mov_es;
@@ -1115,20 +1207,36 @@ static int exfat_move_file(struct inode *parent_inode,
 	*epnew = *epmov;
 
 	exfat_init_ext_entry(&new_es, num_new_entries, p_uniname);
-	exfat_remove_entries(parent_inode, &mov_es, ES_IDX_FILE);
+
+	ret = exfat_copy_trailing_entries(&mov_es, &new_es);
+	if (ret)
+		goto put_new_es;
+
+	exfat_remove_entries(parent_inode, &mov_es, ES_IDX_FILE, false);
 
 	ei->dir = newdir;
 	ei->entry = newentry;
 
 	ret = exfat_put_dentry_set(&new_es, IS_DIRSYNC(parent_inode));
-	if (ret)
+	if (ret) {
+		/* Best-effort delete to avoid duplicate entries */
+		if (!exfat_get_dentry_set(&new_es, parent_inode->i_sb,
+					  &newdir, newentry,
+					  ES_ALL_ENTRIES)) {
+			exfat_remove_entries(parent_inode, &new_es,
+					    ES_IDX_FILE, false);
+			exfat_put_dentry_set(&new_es, false);
+		}
 		goto put_mov_es;
+	}
 
 	return exfat_put_dentry_set(&mov_es, IS_DIRSYNC(parent_inode));
 
+put_new_es:
+	exfat_remove_entries(parent_inode, &new_es, ES_IDX_FILE, false);
+	exfat_put_dentry_set(&new_es, false);
 put_mov_es:
 	exfat_put_dentry_set(&mov_es, false);
-
 	return ret;
 }
 
@@ -1202,7 +1310,7 @@ static int __exfat_rename(struct inode *old_parent_inode,
 			goto del_out;
 		}
 
-		exfat_remove_entries(new_inode, &es, ES_IDX_FILE);
+		exfat_remove_entries(new_inode, &es, ES_IDX_FILE, true);
 
 		ret = exfat_put_dentry_set(&es, IS_DIRSYNC(new_inode));
 		if (ret)
-- 
2.45.2


