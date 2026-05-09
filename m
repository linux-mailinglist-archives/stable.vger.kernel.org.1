Return-Path: <stable+bounces-244867-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HCXL6mG/mnDsQAAu9opvQ
	(envelope-from <stable+bounces-244867-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 02:58:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2646E4FD26D
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 02:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A3593020006
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 00:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAED22D792;
	Sat,  9 May 2026 00:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRmnm0kZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0233F3B1B3
	for <stable@vger.kernel.org>; Sat,  9 May 2026 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778288293; cv=none; b=QCng6qXk2laBA1FokTUvbWq0lshutObRq4RIPJUtmrpkmNgunxpWbFfFcBtpFxAhgn427SKh/b0CzcWE+JPgEFD3HZboox/lAFBHkDKzOTFcBSe7swDdPcj2rYMwzMWSO++w6K6u2SgT7jFcZxbje4JDuUxLFyrRCdIPyn2NIhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778288293; c=relaxed/simple;
	bh=InYWlyC37thMUmgXDuifHMxmt/oIY7WBizAHUXm1Zmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stJaH5K8zkOLUBF4ShLSSdyWGjCYfbZBfbPjA0vFa+T8SrcCthgly/2Nmbr7LRv4ws3Q4aO1o8WP7aWnbpwx8w0L9m9HemMNufJFQiCgW05zNo8kJxwC9xH64HRkx4yxRBN99id5Yc0L/79lP/73l62oRY6/CaHB/jxlLcHw6X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRmnm0kZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6A1C2BCB0;
	Sat,  9 May 2026 00:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778288292;
	bh=InYWlyC37thMUmgXDuifHMxmt/oIY7WBizAHUXm1Zmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XRmnm0kZhIjFaBLmEC+EtrEjQUTcEE2OqeYfB5nx/p3AR5KUqSgvhBe51L+MkDAob
	 Mb7SzOJZTUa9n9o3nPW8haSnvplIjPtWqNLghTO9AIQH2JQAHI+SpQHxbvpw02G4/i
	 g5HEyfLhsimzqc1OxxkUVItrcp30VfbDoh0+FYsXF+jLe7nPO6WyeYKt/kGqC1ODw/
	 hkCP+XRWLsBBiZROB4g+1NrJdtgIHBk/t4rVgKjSziazq8va3L1AI7fW/HclZBU/gQ
	 g/pDy2xCeIsh4FtdxUvxpTEeZAW4+5xYh2jsz5PMG9cgU47tDd7NbkZtQXknLdYRpC
	 1wHpJbgwQF0fQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Charalampos Mitrodimas <charmitro@posteo.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] hfsplus: fix uninit-value by validating catalog record size
Date: Fri,  8 May 2026 20:58:07 -0400
Message-ID: <20260509005809.2569358-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050455-strangle-trimming-ea52@gregkh>
References: <2026050455-strangle-trimming-ea52@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2646E4FD26D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,syzkaller.appspotmail.com,dubeyko.com,posteo.net,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-244867-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,d80abb5b890d39261e72];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dubeyko.com:email,posteo.net:email,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Action: no action

From: Deepanshu Kartikey <kartikey406@gmail.com>

[ Upstream commit b6b592275aeff184aa82fcf6abccd833fb71b393 ]

Syzbot reported a KMSAN uninit-value issue in hfsplus_strcasecmp(). The
root cause is that hfs_brec_read() doesn't validate that the on-disk
record size matches the expected size for the record type being read.

When mounting a corrupted filesystem, hfs_brec_read() may read less data
than expected. For example, when reading a catalog thread record, the
debug output showed:

  HFSPLUS_BREC_READ: rec_len=520, fd->entrylength=26
  HFSPLUS_BREC_READ: WARNING - entrylength (26) < rec_len (520) - PARTIAL READ!

hfs_brec_read() only validates that entrylength is not greater than the
buffer size, but doesn't check if it's less than expected. It successfully
reads 26 bytes into a 520-byte structure and returns success, leaving 494
bytes uninitialized.

This uninitialized data in tmp.thread.nodeName then gets copied by
hfsplus_cat_build_key_uni() and used by hfsplus_strcasecmp(), triggering
the KMSAN warning when the uninitialized bytes are used as array indices
in case_fold().

Fix by introducing hfsplus_brec_read_cat() wrapper that:
1. Calls hfs_brec_read() to read the data
2. Validates the record size based on the type field:
   - Fixed size for folder and file records
   - Variable size for thread records (depends on string length)
3. Returns -EIO if size doesn't match expected

For thread records, check against HFSPLUS_MIN_THREAD_SZ before reading
nodeName.length to avoid reading uninitialized data at call sites that
don't zero-initialize the entry structure.

Also initialize the tmp variable in hfsplus_find_cat() as defensive
programming to ensure no uninitialized data even if validation is
bypassed.

Reported-by: syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d80abb5b890d39261e72
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Tested-by: syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Tested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Suggested-by: Charalampos Mitrodimas <charmitro@posteo.net>
Link: https://lore.kernel.org/all/20260120051114.1281285-1-kartikey406@gmail.com/ [v1]
Link: https://lore.kernel.org/all/20260121063109.1830263-1-kartikey406@gmail.com/ [v2]
Link: https://lore.kernel.org/all/20260212014233.2422046-1-kartikey406@gmail.com/ [v3]
Link: https://lore.kernel.org/all/20260214002100.436125-1-kartikey406@gmail.com/T/ [v4]
Link: https://lore.kernel.org/all/20260221061626.15853-1-kartikey406@gmail.com/T/ [v5]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Link: https://lore.kernel.org/r/20260307010302.41547-1-kartikey406@gmail.com
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Stable-dep-of: 90c500e4fd83 ("hfsplus: fix held lock freed on hfsplus_fill_super()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfsplus/bfind.c      | 51 +++++++++++++++++++++++++++++++++++++++++
 fs/hfsplus/catalog.c    |  4 ++--
 fs/hfsplus/dir.c        |  2 +-
 fs/hfsplus/hfsplus_fs.h |  9 ++++++++
 fs/hfsplus/super.c      |  2 +-
 5 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index 26ebac4c60424..41f4f56f90fac 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -287,3 +287,54 @@ int hfs_brec_goto(struct hfs_find_data *fd, int cnt)
 	fd->bnode = bnode;
 	return res;
 }
+
+/**
+ * hfsplus_brec_read_cat - read and validate a catalog record
+ * @fd: find data structure
+ * @entry: pointer to catalog entry to read into
+ *
+ * Reads a catalog record and validates its size matches the expected
+ * size based on the record type.
+ *
+ * Returns 0 on success, or negative error code on failure.
+ */
+int hfsplus_brec_read_cat(struct hfs_find_data *fd, hfsplus_cat_entry *entry)
+{
+	int res;
+	u32 expected_size;
+
+	res = hfs_brec_read(fd, entry, sizeof(hfsplus_cat_entry));
+	if (res)
+		return res;
+
+	/* Validate catalog record size based on type */
+	switch (be16_to_cpu(entry->type)) {
+	case HFSPLUS_FOLDER:
+		expected_size = sizeof(struct hfsplus_cat_folder);
+		break;
+	case HFSPLUS_FILE:
+		expected_size = sizeof(struct hfsplus_cat_file);
+		break;
+	case HFSPLUS_FOLDER_THREAD:
+	case HFSPLUS_FILE_THREAD:
+		/* Ensure we have at least the fixed fields before reading nodeName.length */
+		if (fd->entrylength < HFSPLUS_MIN_THREAD_SZ) {
+			pr_err("thread record too short (got %u)\n", fd->entrylength);
+			return -EIO;
+		}
+		expected_size = hfsplus_cat_thread_size(&entry->thread);
+		break;
+	default:
+		pr_err("unknown catalog record type %d\n",
+		       be16_to_cpu(entry->type));
+		return -EIO;
+	}
+
+	if (fd->entrylength != expected_size) {
+		pr_err("catalog record size mismatch (type %d, got %u, expected %u)\n",
+		       be16_to_cpu(entry->type), fd->entrylength, expected_size);
+		return -EIO;
+	}
+
+	return 0;
+}
diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index 35472cba750e1..136aa1017af2b 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -194,12 +194,12 @@ static int hfsplus_fill_cat_thread(struct super_block *sb,
 int hfsplus_find_cat(struct super_block *sb, u32 cnid,
 		     struct hfs_find_data *fd)
 {
-	hfsplus_cat_entry tmp;
+	hfsplus_cat_entry tmp = {0};
 	int err;
 	u16 type;
 
 	hfsplus_cat_build_key_with_cnid(sb, fd->search_key, cnid);
-	err = hfs_brec_read(fd, &tmp, sizeof(hfsplus_cat_entry));
+	err = hfsplus_brec_read_cat(fd, &tmp);
 	if (err)
 		return err;
 
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 17e651bd04ad3..578da2528bee8 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -49,7 +49,7 @@ static struct dentry *hfsplus_lookup(struct inode *dir, struct dentry *dentry,
 	if (unlikely(err < 0))
 		goto fail;
 again:
-	err = hfs_brec_read(&fd, &entry, sizeof(entry));
+	err = hfsplus_brec_read_cat(&fd, &entry);
 	if (err) {
 		if (err == -ENOENT) {
 			hfs_find_exit(&fd);
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 3d324e4465d04..b971cd9021ba0 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -535,6 +535,15 @@ int hfsplus_submit_bio(struct super_block *sb, sector_t sector, void *buf,
 		       void **data, blk_opf_t opf);
 int hfsplus_read_wrapper(struct super_block *sb);
 
+static inline u32 hfsplus_cat_thread_size(const struct hfsplus_cat_thread *thread)
+{
+	return offsetof(struct hfsplus_cat_thread, nodeName) +
+	       offsetof(struct hfsplus_unistr, unicode) +
+	       be16_to_cpu(thread->nodeName.length) * sizeof(hfsplus_unichr);
+}
+
+int hfsplus_brec_read_cat(struct hfs_find_data *fd, hfsplus_cat_entry *entry);
+
 /*
  * time helpers: convert between 1904-base and 1970-base timestamps
  *
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 954ceaa748e62..4790ddd92a8c1 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -541,7 +541,7 @@ static int hfsplus_fill_super(struct super_block *sb, void *data, int silent)
 	err = hfsplus_cat_build_key(sb, fd.search_key, HFSPLUS_ROOT_CNID, &str);
 	if (unlikely(err < 0))
 		goto out_put_root;
-	if (!hfs_brec_read(&fd, &entry, sizeof(entry))) {
+	if (!hfsplus_brec_read_cat(&fd, &entry)) {
 		hfs_find_exit(&fd);
 		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER)) {
 			err = -EIO;
-- 
2.53.0


