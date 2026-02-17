Return-Path: <stable+bounces-216848-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEz+DweHlGmWFQIAu9opvQ
	(envelope-from <stable+bounces-216848-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 16:19:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9297B14D86F
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 16:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C1B63029ACE
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 15:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3436274658;
	Tue, 17 Feb 2026 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHn67X9T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A5722A1D4
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771341572; cv=none; b=KSbzVWnLfPUqHwC9p3IBYgneHtXMAHUomLsWPBUo1ZSQKe5x2QVPSoIq4/8cMokxWmyZa86/5jhg/XIrb3HLeIuNKzxYYc6iZRH2ELpOnhlawDd22szCtoUb+Ky5RexFzBFSboIhRroLyDeFy1lcus4eBRe8vIBuYwxNMEKr7L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771341572; c=relaxed/simple;
	bh=9ijaPeX1dbf76eoM4X9Vdde+V3WBPRzsttAditNkbAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOrfonTx2/9w1aQl7Uv+Z3gcLs2PuyQq3wZPUennHmympBqlslCKX/9lgP1LRXaM1A9Pdd0K1PtTq2teUlrd/cr3ZS7bjYMmx0LfuEkZtSL73dYg9BDxD3zQNGrRCPjRXbjy6a8wHy25yKyJPEis3i/sx8LxvTj+JHF+gNh6yqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHn67X9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73879C4CEF7;
	Tue, 17 Feb 2026 15:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771341572;
	bh=9ijaPeX1dbf76eoM4X9Vdde+V3WBPRzsttAditNkbAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gHn67X9T765AfytTObkeOq+UKNQsU7ussz9U79COl10k4oRONB4tRf5MfFi3IEurL
	 zKpj6q3pP8dd85jn9sHC1WdGWEQtunGTBKpaajXXD2DE2JyZ8uSb1tDHcjtH4ghSTq
	 5e9gJa+l4CQ5/pUBOq73YrDNJdgbyEUjtS6oJerBoDX2SJfSjtKSsTsI2w5Kn5jsxw
	 7kBhwuVy3IV3DgT69Nn9kb9goEVbsMVguzuIThiw9h5itBOMnt128cnepBFkPXNpsL
	 2V4qFuvexPEIPXW6X/BdBzPoSG1TV79RpYULVUdgqVZocqBVO3FzPzEPSG7+R1Z0dR
	 s48XnQ/HFJrdw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
	stable@kernel.org,
	Jinbao Liu <liujinbao1@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] f2fs: fix out-of-bounds access in sysfs attribute read/write
Date: Tue, 17 Feb 2026 10:19:29 -0500
Message-ID: <20260217151929.3676924-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026021753-durable-railway-b5df@gregkh>
References: <2026021753-durable-railway-b5df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-216848-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xiaomi.com:email]
X-Rspamd-Queue-Id: 9297B14D86F
X-Rspamd-Action: no action

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

[ Upstream commit 98ea0039dbfdd00e5cc1b9a8afa40434476c0955 ]

Some f2fs sysfs attributes suffer from out-of-bounds memory access and
incorrect handling of integer values whose size is not 4 bytes.

For example:
vm:~# echo 65537 > /sys/fs/f2fs/vde/carve_out
vm:~# cat /sys/fs/f2fs/vde/carve_out
65537
vm:~# echo 4294967297 > /sys/fs/f2fs/vde/atgc_age_threshold
vm:~# cat /sys/fs/f2fs/vde/atgc_age_threshold
1

carve_out maps to {struct f2fs_sb_info}->carve_out, which is a 8-bit
integer. However, the sysfs interface allows setting it to a value
larger than 255, resulting in an out-of-range update.

atgc_age_threshold maps to {struct atgc_management}->age_threshold,
which is a 64-bit integer, but its sysfs interface cannot correctly set
values larger than UINT_MAX.

The root causes are:
1. __sbi_store() treats all default values as unsigned int, which
prevents updating integers larger than 4 bytes and causes out-of-bounds
writes for integers smaller than 4 bytes.

2. f2fs_sbi_show() also assumes all default values are unsigned int,
leading to out-of-bounds reads and incorrect access to integers larger
than 4 bytes.

This patch introduces {struct f2fs_attr}->size to record the actual size
of the integer associated with each sysfs attribute. With this
information, sysfs read and write operations can correctly access and
update values according to their real data size, avoiding memory
corruption and truncation.

Fixes: b59d0bae6ca3 ("f2fs: add sysfs support for controlling the gc_thread")
Cc: stable@kernel.org
Signed-off-by: Jinbao Liu <liujinbao1@xiaomi.com>
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ adapted F2FS_STAT_ATTR macro to include .size field and used sprintf instead of sysfs_emit in the replaced baseline code ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/sysfs.c | 61 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 06d5791afe90e..4e643abbd891a 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -58,6 +58,7 @@ struct f2fs_attr {
 			 const char *, size_t);
 	int struct_type;
 	int offset;
+	int size;
 	int id;
 };
 
@@ -273,11 +274,30 @@ static ssize_t main_blkaddr_show(struct f2fs_attr *a,
 			(unsigned long long)MAIN_BLKADDR(sbi));
 }
 
+static ssize_t __sbi_show_value(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf,
+		unsigned char *value)
+{
+	switch (a->size) {
+	case 1:
+		return sysfs_emit(buf, "%u\n", *(u8 *)value);
+	case 2:
+		return sysfs_emit(buf, "%u\n", *(u16 *)value);
+	case 4:
+		return sysfs_emit(buf, "%u\n", *(u32 *)value);
+	case 8:
+		return sysfs_emit(buf, "%llu\n", *(u64 *)value);
+	default:
+		f2fs_bug_on(sbi, 1);
+		return sysfs_emit(buf,
+				"show sysfs node value with wrong type\n");
+	}
+}
+
 static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 			struct f2fs_sb_info *sbi, char *buf)
 {
 	unsigned char *ptr = NULL;
-	unsigned int *ui;
 
 	ptr = __struct_ptr(sbi, a->struct_type);
 	if (!ptr)
@@ -360,9 +380,30 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 	if (!strcmp(a->attr.name, "revoked_atomic_block"))
 		return sysfs_emit(buf, "%llu\n", sbi->revoked_atomic_block);
 
-	ui = (unsigned int *)(ptr + a->offset);
+	return __sbi_show_value(a, sbi, buf, ptr + a->offset);
+}
 
-	return sprintf(buf, "%u\n", *ui);
+static void __sbi_store_value(struct f2fs_attr *a,
+			struct f2fs_sb_info *sbi,
+			unsigned char *ui, unsigned long value)
+{
+	switch (a->size) {
+	case 1:
+		*(u8 *)ui = value;
+		break;
+	case 2:
+		*(u16 *)ui = value;
+		break;
+	case 4:
+		*(u32 *)ui = value;
+		break;
+	case 8:
+		*(u64 *)ui = value;
+		break;
+	default:
+		f2fs_bug_on(sbi, 1);
+		f2fs_err(sbi, "store sysfs node value with wrong type");
+	}
 }
 
 static ssize_t __sbi_store(struct f2fs_attr *a,
@@ -655,7 +696,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
-	*ui = (unsigned int)t;
+	__sbi_store_value(a, sbi, ptr + a->offset, t);
 
 	return count;
 }
@@ -751,24 +792,27 @@ static struct f2fs_attr f2fs_attr_sb_##_name = {		\
 	.id	= F2FS_FEATURE_##_feat,				\
 }
 
-#define F2FS_ATTR_OFFSET(_struct_type, _name, _mode, _show, _store, _offset) \
+#define F2FS_ATTR_OFFSET(_struct_type, _name, _mode, _show, _store, _offset, _size) \
 static struct f2fs_attr f2fs_attr_##_name = {			\
 	.attr = {.name = __stringify(_name), .mode = _mode },	\
 	.show	= _show,					\
 	.store	= _store,					\
 	.struct_type = _struct_type,				\
-	.offset = _offset					\
+	.offset = _offset,					\
+	.size = _size						\
 }
 
 #define F2FS_RO_ATTR(struct_type, struct_name, name, elname)	\
 	F2FS_ATTR_OFFSET(struct_type, name, 0444,		\
 		f2fs_sbi_show, NULL,				\
-		offsetof(struct struct_name, elname))
+		offsetof(struct struct_name, elname),		\
+		sizeof_field(struct struct_name, elname))
 
 #define F2FS_RW_ATTR(struct_type, struct_name, name, elname)	\
 	F2FS_ATTR_OFFSET(struct_type, name, 0644,		\
 		f2fs_sbi_show, f2fs_sbi_store,			\
-		offsetof(struct struct_name, elname))
+		offsetof(struct struct_name, elname),		\
+		sizeof_field(struct struct_name, elname))
 
 #define F2FS_GENERAL_RO_ATTR(name) \
 static struct f2fs_attr f2fs_attr_##name = __ATTR(name, 0444, name##_show, NULL)
@@ -779,6 +823,7 @@ static struct f2fs_attr f2fs_attr_##_name = {			\
 	.show = f2fs_sbi_show,					\
 	.struct_type = _struct_type,				\
 	.offset = offsetof(struct _struct_name, _elname),       \
+	.size = sizeof_field(struct _struct_name, _elname),	\
 }
 
 F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_urgent_sleep_time,
-- 
2.51.0


