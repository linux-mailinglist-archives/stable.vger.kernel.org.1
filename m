Return-Path: <stable+bounces-255020-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMHRC89SGGqwiwgAu9opvQ
	(envelope-from <stable+bounces-255020-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:35:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DDF5F3C55
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BFC9D3058208
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFC63B6C0A;
	Thu, 28 May 2026 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OARE2uLf"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713543D0BE7
	for <stable@vger.kernel.org>; Thu, 28 May 2026 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978122; cv=none; b=pQ1Nsx42gJDOXUIWpqHj9/+9frLfHK21RoyV4rGpVbkmGdorlugHiJSO2j5wW0CzCW3qnKlGW7TG8CSY06aElcMXWhBmc5nWh3aoYAt+oRo+270LPlhfvNBkm3EnXo6e5dLcH8UNIiVAOG0GWPwSiBcX5E+y++XMhLlV31lDk48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978122; c=relaxed/simple;
	bh=qndRqPKBI7+mJgMntZWop/389pamknKCawN23Xk6rso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TL5VQfLFYc1SEDJsIaAr595r0RN0IHVBanU/6NjRJCk07q86DRhS+V/EwswAuURvafQp6ddNsTP1p3SLP67LbPHR4T5EwALiZm1ULnJuEmMM8O9GdMPLD9wEdDGekMKH/bma/7XCiPSXgUJ9CSR8ZBLK8Oo8IwAUYbCbbjInjLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OARE2uLf; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1329fc4bf77so3993885c88.1
        for <stable@vger.kernel.org>; Thu, 28 May 2026 07:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779978119; x=1780582919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAS9z0wKWgBpy9qk4qxfRFZg6O/qEwC7u6d0FgnJwAg=;
        b=OARE2uLfu2MpL/hm1xq2B7YCDfKofFEQGGyKpMaXIk+seEsEwKfpELsjBWKlppxKwY
         keFWkqQCnABjQj+hhsLuUWvkYncMNcET2ru9d6EDTT3l9CPtIdxG7k9c6sDGITeEocGE
         iX9k9q/2T0CeYnDHZKNfHYLUw0gDfkGj57fTdceKyZfxd+UsqIx98gBNd2Bg90CCeua5
         94uvXiqrN5cNt0LKYQCSX/bWkF/IP/n9C8idZW39hpJik6So3k6Iqr+RDBxAoM7uCN39
         QYkINWyQi47PLaclbV46iEorrPqGz3FHNBWb+KTGW9qJ1RZOa975ppe4mtNr00k4eeuz
         UAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779978119; x=1780582919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yAS9z0wKWgBpy9qk4qxfRFZg6O/qEwC7u6d0FgnJwAg=;
        b=XY6lBxuFN92DCJS6sIcd7hD/ETbAybVcs7Cjq8CgIPhJYNvcSnGCRVf7e3C9OYNwHw
         k3lNBjU6+o76iulUcgFEdZK80dQybzif7O5u6hJrJJDJisvK7WVu83RrU6KdTNrkXQoW
         EwkDUDXrZV8PfoZdmnMQd1co8ZEfURXPq3okuC0KcCWohDe5VotD9vMrMknddkFY5SK9
         pQKOW3b+w4K0Htv7Wb349hW3ZXy7xjTORSggTXGIwgYURSzgJmjrIK24WUHvqSTImWIu
         pubGYRVBqKtUfYc36kLE9ULlpqwdFpw/nmKNvtTeHeEM1vVTf9kxK44IXDrKI5lepJG2
         sx6g==
X-Forwarded-Encrypted: i=1; AFNElJ9k7L1w4ViwVpTlACT+9BEmX4rLh81WPRK+Pt3Hg26F8coZuLi17xvfVGbUwTWOwxhvzq6RpkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz935yA5GHnsBn7q6j27m8rRfiaSST22TTg+V1bdaxtSqvTobMv
	RN236yfkkHmZbpJj3EUhAnsEPehqiZ1FRPvvT6TmTClnWo21XSstvU0=
X-Gm-Gg: Acq92OFEtEDaPEk+E3S8Hj3FqieiAExr7jsQrJK7Ms+gyybGBCburyIZkWTvKutPQBg
	BM3AJkoV5G7NGQ0d8NCh85jSp13POI/9OvyVAokq1PRf89VLpJVnrRCx8fqt419kzrrS0koUEKj
	TSzsCnxCq5LYRN0IWcaZzVvj/DsSDMzsBFV0efD3LekyjRvVs6sXH30wOxC7fkLJOxOIai9ejBd
	bkiU/rmLNq7OopvYGwsPs0XwUOmGg2no+vtpCFIbUuDQfOvpU35zYIRqVamx2fPnOXyC5FpPwCm
	z/kXGG7WU5AUX8kqHteHrswhK2nkGYy9ePqSyxX+Z8boM0rKuRRMWsSV/YRFtHr01gbynxYqPjp
	y8u/84IF4qoyTcslt/S7WoKf2u2am9lm7G0NrIcOzRV9O03ohrSVO6nJ3sylUc2TOtnZ8V/G/tv
	7wO2P+2ZFO38eCxL/z0buF+O/XuX2CT3pQMD8O+HW0lcT9wBNpghCH86yJNPN6mp93NtcIKyEqd
	jP2PQJtMyRGQtinSQ2RJYykGS4g2zyY
X-Received: by 2002:a05:7022:913:b0:135:e814:d03f with SMTP id a92af1059eb24-1365fc7d7e9mr10292897c88.36.1779978118278;
        Thu, 28 May 2026 07:21:58 -0700 (PDT)
Received: from localhost.localdomain (157-131-96-99.fiber.dynamic.sonic.net. [157.131.96.99])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a40305csm11602290c88.7.2026.05.28.07.21.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 May 2026 07:21:57 -0700 (PDT)
From: Rochan Avlur <rochan.avlur@gmail.com>
To: yuezhang.mo@sony.com
Cc: linkinjeon@kernel.org,
	linux-fsdevel@vger.kernel.org,
	rochan.avlur@gmail.com,
	rochan.avlur@skydio.com,
	sj1557.seo@samsung.com,
	stable@vger.kernel.org,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v5] exfat: preserve benign secondary entries during rename and move
Date: Thu, 28 May 2026 07:21:37 -0700
Message-ID: <20260528142137.49121-1-rochan.avlur@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <PUZPR04MB63162D8FEE0B2F486C14888E810B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB63162D8FEE0B2F486C14888E810B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255020-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[rochanavlur@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,skydio.com,samsung.com,sony.com];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 38DDF5F3C55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
so callers can suppress cluster freeing during relocation, and
extending exfat_init_ext_entry() to copy trailing benign secondary
entries from the old entry set into the new one internally.  Also
clean up the error paths to delete newly allocated entries on failure.

Fixes: 8258ef28001a ("exfat: handle unreconized benign secondary entries")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-fsdevel/CAG7tbBV--waov7XVu2FHQEc6paR92dufS=em9DW5Kzsrpu3iQg@mail.gmail.com/
Signed-off-by: Rochan Avlur <rochan.avlur@gmail.com>
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
---
v5:
 - Add Reviewed-by tag.
v4:
 - Fold benign secondary copy into exfat_init_ext_entry(), removing
   exfat_copy_trailing_entries(); handle in-place shrink internally.
 - Simplify relocation condition to avoid unnecessary ENOSPC.
v3:
 - Merge exfat_remove_entries_nofree() into exfat_remove_entries() with
   a bool free_benign parameter.
 - Move new_entries and src_start calculations after the early return in
   exfat_copy_trailing_entries().
 - Clean up error paths in exfat_rename_file() and exfat_move_file() to
   delete newly allocated entries on failure.
v2:
 - Resent with proper formatting (no content changes from v1).

 fs/exfat/dir.c      | 50 ++++++++++++++++++++++---
 fs/exfat/exfat_fs.h |  5 ++-
 fs/exfat/namei.c    | 89 +++++++++++++++++++++++++++++++++++----------
 3 files changed, 116 insertions(+), 28 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index ac008ccaa97d..2f883107be6e 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -470,32 +470,70 @@ static void exfat_free_benign_secondary_clusters(struct inode *inode,
 	exfat_free_cluster(inode, &dir);
 }
 
+/*
+ * exfat_init_ext_entry - initialize extension entries in a directory entry set
+ * @es:          target entry set
+ * @num_entries: number of entries excluding benign secondary entries
+ * @p_uniname:   filename to store
+ * @old_es:      optional source entry set with benign secondary entries, or NULL
+ * @num_extra:   number of benign secondary entries to copy from @old_es
+ *
+ * Set up the file, stream extension, and filename entries in @es, optionally
+ * preserving @num_extra benign secondary entries from @old_es.  @es and @old_es
+ * may refer to the same entry set; excess entries are marked as deleted.
+ */
 void exfat_init_ext_entry(struct exfat_entry_set_cache *es, int num_entries,
-		struct exfat_uni_name *p_uniname)
+		struct exfat_uni_name *p_uniname,
+		struct exfat_entry_set_cache *old_es, int num_extra)
 {
-	int i;
+	int i, src_start = 0, old_num;
 	unsigned short *uniname = p_uniname->name;
 	struct exfat_dentry *ep;
 
-	es->num_entries = num_entries;
+	if (WARN_ON(num_extra < 0 || (num_extra && (!old_es ||
+		    old_es->num_entries < ES_IDX_FIRST_FILENAME + num_extra))))
+		num_extra = 0;
+
+	/*
+	 * Save old entry count and source position before modifying
+	 * es->num_entries, since old_es and es may point to the same
+	 * entry set.
+	 */
+	old_num = es->num_entries;
+	if (old_es && num_extra > 0)
+		src_start = old_es->num_entries - num_extra;
+
+	es->num_entries = num_entries + num_extra;
 	ep = exfat_get_dentry_cached(es, ES_IDX_FILE);
-	ep->dentry.file.num_ext = (unsigned char)(num_entries - 1);
+	ep->dentry.file.num_ext = (unsigned char)(num_entries - 1 + num_extra);
 
 	ep = exfat_get_dentry_cached(es, ES_IDX_STREAM);
 	ep->dentry.stream.name_len = p_uniname->name_len;
 	ep->dentry.stream.name_hash = cpu_to_le16(p_uniname->name_hash);
 
+	if (old_es && num_extra > 0) {
+		for (i = 0; i < num_extra; i++)
+			*exfat_get_dentry_cached(es, num_entries + i) =
+				*exfat_get_dentry_cached(old_es, src_start + i);
+	}
+
 	for (i = ES_IDX_FIRST_FILENAME; i < num_entries; i++) {
 		ep = exfat_get_dentry_cached(es, i);
 		exfat_init_name_entry(ep, uniname);
 		uniname += EXFAT_FILE_NAME_LEN;
 	}
 
+	/* Mark excess old entries as deleted (in-place shrink) */
+	for (i = num_entries + num_extra; i < old_num; i++) {
+		ep = exfat_get_dentry_cached(es, i);
+		exfat_set_entry_type(ep, TYPE_DELETED);
+	}
+
 	exfat_update_dir_chksum(es);
 }
 
 void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_cache *es,
-		int order)
+		int order, bool free_benign)
 {
 	int i;
 	struct exfat_dentry *ep;
@@ -503,7 +541,7 @@ void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_cache *es,
 	for (i = order; i < es->num_entries; i++) {
 		ep = exfat_get_dentry_cached(es, i);
 
-		if (exfat_get_entry_type(ep) & TYPE_BENIGN_SEC)
+		if (free_benign && (exfat_get_entry_type(ep) & TYPE_BENIGN_SEC))
 			exfat_free_benign_secondary_clusters(inode, ep);
 
 		exfat_set_entry_type(ep, TYPE_DELETED);
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 89ef5368277f..e22b4ca3ec7f 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -524,9 +524,10 @@ void exfat_init_dir_entry(struct exfat_entry_set_cache *es,
 		unsigned int type, unsigned int start_clu,
 		unsigned long long size, struct timespec64 *ts);
 void exfat_init_ext_entry(struct exfat_entry_set_cache *es, int num_entries,
-		struct exfat_uni_name *p_uniname);
+		struct exfat_uni_name *p_uniname,
+		struct exfat_entry_set_cache *old_es, int num_extra);
 void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_cache *es,
-		int order);
+		int order, bool free_benign);
 void exfat_update_dir_chksum(struct exfat_entry_set_cache *es);
 int exfat_calc_num_entries(struct exfat_uni_name *p_uniname);
 int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 2c5636634b4a..76b2e2db80fb 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -503,7 +503,7 @@ static int exfat_add_entry(struct inode *inode, const char *path,
 	 * the first cluster is not determined yet. (0)
 	 */
 	exfat_init_dir_entry(&es, type, start_clu, clu_size, &ts);
-	exfat_init_ext_entry(&es, num_entries, &uniname);
+	exfat_init_ext_entry(&es, num_entries, &uniname, NULL, 0);
 
 	ret = exfat_put_dentry_set(&es, IS_DIRSYNC(inode));
 	if (ret)
@@ -814,7 +814,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 	exfat_set_volume_dirty(sb);
 
 	/* update the directory entry */
-	exfat_remove_entries(inode, &es, ES_IDX_FILE);
+	exfat_remove_entries(inode, &es, ES_IDX_FILE, true);
 
 	err = exfat_put_dentry_set(&es, IS_DIRSYNC(inode));
 	if (err)
@@ -969,7 +969,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 
 	exfat_set_volume_dirty(sb);
 
-	exfat_remove_entries(inode, &es, ES_IDX_FILE);
+	exfat_remove_entries(inode, &es, ES_IDX_FILE, true);
 
 	err = exfat_put_dentry_set(&es, IS_DIRSYNC(dir));
 	if (err)
@@ -996,6 +996,23 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
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
 static int exfat_rename_file(struct inode *parent_inode,
 		struct exfat_uni_name *p_uniname, struct exfat_inode_info *ei)
 {
@@ -1004,6 +1021,7 @@ static int exfat_rename_file(struct inode *parent_inode,
 	struct super_block *sb = parent_inode->i_sb;
 	struct exfat_entry_set_cache old_es, new_es;
 	int sync = IS_DIRSYNC(parent_inode);
+	unsigned int num_extra_entries, num_total_entries;
 
 	if (unlikely(exfat_forced_shutdown(sb)))
 		return -EIO;
@@ -1013,19 +1031,23 @@ static int exfat_rename_file(struct inode *parent_inode,
 		return num_new_entries;
 
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
+
+	if (old_es.num_entries < num_total_entries) {
 		int newentry;
 		struct exfat_chain dir;
 
 		newentry = exfat_find_empty_entry(parent_inode, &dir,
-				num_new_entries, &new_es);
+				num_total_entries, &new_es);
 		if (newentry < 0) {
 			ret = newentry; /* -EIO or -ENOSPC */
 			goto put_old_es;
@@ -1042,13 +1064,23 @@ static int exfat_rename_file(struct inode *parent_inode,
 		epnew = exfat_get_dentry_cached(&new_es, ES_IDX_STREAM);
 		*epnew = *epold;
 
-		exfat_init_ext_entry(&new_es, num_new_entries, p_uniname);
+		exfat_init_ext_entry(&new_es, num_new_entries, p_uniname,
+				     &old_es, num_extra_entries);
 
 		ret = exfat_put_dentry_set(&new_es, sync);
-		if (ret)
+		if (ret) {
+			/* Best-effort delete to avoid duplicate entries */
+			if (!exfat_get_dentry_set(&new_es, sb,
+						  &dir, newentry,
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
@@ -1057,8 +1089,8 @@ static int exfat_rename_file(struct inode *parent_inode,
 			ei->attr |= EXFAT_ATTR_ARCHIVE;
 		}
 
-		exfat_remove_entries(parent_inode, &old_es, ES_IDX_FIRST_FILENAME + 1);
-		exfat_init_ext_entry(&old_es, num_new_entries, p_uniname);
+		exfat_init_ext_entry(&old_es, num_new_entries, p_uniname,
+				     &old_es, num_extra_entries);
 	}
 	return exfat_put_dentry_set(&old_es, sync);
 
@@ -1074,6 +1106,7 @@ static int exfat_move_file(struct inode *parent_inode,
 	struct exfat_dentry *epmov, *epnew;
 	struct exfat_entry_set_cache mov_es, new_es;
 	struct exfat_chain newdir;
+	unsigned int num_extra_entries, num_total_entries;
 
 	num_new_entries = exfat_calc_num_entries(p_uniname);
 	if (num_new_entries < 0)
@@ -1083,8 +1116,14 @@ static int exfat_move_file(struct inode *parent_inode,
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
@@ -1102,21 +1141,31 @@ static int exfat_move_file(struct inode *parent_inode,
 	epnew = exfat_get_dentry_cached(&new_es, ES_IDX_STREAM);
 	*epnew = *epmov;
 
-	exfat_init_ext_entry(&new_es, num_new_entries, p_uniname);
-	exfat_remove_entries(parent_inode, &mov_es, ES_IDX_FILE);
+	exfat_init_ext_entry(&new_es, num_new_entries, p_uniname,
+			     &mov_es, num_extra_entries);
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
 
 put_mov_es:
 	exfat_put_dentry_set(&mov_es, false);
-
 	return ret;
 }
 
@@ -1190,7 +1239,7 @@ static int __exfat_rename(struct inode *old_parent_inode,
 			goto del_out;
 		}
 
-		exfat_remove_entries(new_inode, &es, ES_IDX_FILE);
+		exfat_remove_entries(new_inode, &es, ES_IDX_FILE, true);
 
 		ret = exfat_put_dentry_set(&es, IS_DIRSYNC(new_inode));
 		if (ret)
-- 
2.45.2


