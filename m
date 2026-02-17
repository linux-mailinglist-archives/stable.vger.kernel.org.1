Return-Path: <stable+bounces-216862-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAVuCI6WlGn1FgIAu9opvQ
	(envelope-from <stable+bounces-216862-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 17:25:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C099C14E26D
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 17:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51E8630217EF
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 16:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0E136EABB;
	Tue, 17 Feb 2026 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHaqsprI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B196236EAB9
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771345501; cv=none; b=amAx07DE9PVNvN5tFXK5uwNygxI9UpilqfwEK4qcRUHD2Ep9Ldy8wnESfPR7pUDKhnrdTzkC8RZAiMednWXUI4QUmB/M9SR7oFZpKvFifZ+d7KM0Qqj1VRFtzh1pCbaGuJbND2JbjfbMzh1gtJ+781Zgq3330w2D1FF/JcRPsJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771345501; c=relaxed/simple;
	bh=Qhv3Q0aMut4YRYw4rIuNj5FeaHl2KptzIDUDlDYshWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5dZ4OsMSwlAd9WpGl+qKw2LgYOaSw45RHz116btDFOo1NIK/lpIlD/Eir+ai/tMPaFJlLYUZ+DsRz+BNCkJ7DL1NW25nw/l/pUlntrNhoUY2Jm33DvULlbSHqR2xS13JPMLL38iO10Huv0rbmTlFoxVLjgUkCHdj6E5SkvDmQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHaqsprI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DFDC4CEF7;
	Tue, 17 Feb 2026 16:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771345501;
	bh=Qhv3Q0aMut4YRYw4rIuNj5FeaHl2KptzIDUDlDYshWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AHaqsprI2+CF1smelbLSGxPxbtf4tvxHBX5xyauWgX2S9viY9gaNPYvODRFu4L7aA
	 5MWWE/8BzsxDFEF+5nH+WZcsQyfIK5/lnFRxD6uWiTxnEczjhPoPlRzRLbePpDienE
	 Fv2xZMiipuH3FejYAXTbi6HjxcTJW1qailUoVnC5Mkv8zfM31ipS2K9DRMPNewujyA
	 7KSUEp5toivpLarTV/r0oipjOFNvOsSW1O3uH4V6nIJggzu11yyABwIxskXWxw7oTb
	 nSbESnIBZVMwdiogEeJ+AJn2QSsDQMAlIbNZDpcYhLEAiVxq9dsHAUrhBVvwlLCVgX
	 uzWP2OAjuLbWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
	stable@kernel.org,
	Jinbao Liu <liujinbao1@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] f2fs: fix out-of-bounds access in sysfs attribute read/write
Date: Tue, 17 Feb 2026 11:24:58 -0500
Message-ID: <20260217162458.3771870-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026021754-flakily-replica-d539@gregkh>
References: <2026021754-flakily-replica-d539@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-216862-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C099C14E26D
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
[ f2fs_sbi_show() changes + .size for F2FS_STAT_ATTR ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/sysfs.c | 58 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 2501c11d8c468..f57df76ee71cc 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -43,6 +43,7 @@ struct f2fs_attr {
 			 const char *, size_t);
 	int struct_type;
 	int offset;
+	int size;
 	int id;
 };
 
@@ -232,11 +233,30 @@ static ssize_t main_blkaddr_show(struct f2fs_attr *a,
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
@@ -263,9 +283,30 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 		return len;
 	}
 
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
@@ -409,7 +450,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
-	*ui = (unsigned int)t;
+	__sbi_store_value(a, sbi, ptr + a->offset, t);
 
 	return count;
 }
@@ -502,19 +543,21 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
 	return 0;
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
 
 #define F2FS_RW_ATTR(struct_type, struct_name, name, elname)	\
 	F2FS_ATTR_OFFSET(struct_type, name, 0644,		\
 		f2fs_sbi_show, f2fs_sbi_store,			\
-		offsetof(struct struct_name, elname))
+		offsetof(struct struct_name, elname),		\
+		sizeof_field(struct struct_name, elname))
 
 #define F2FS_GENERAL_RO_ATTR(name) \
 static struct f2fs_attr f2fs_attr_##name = __ATTR(name, 0444, name##_show, NULL)
@@ -532,6 +575,7 @@ static struct f2fs_attr f2fs_attr_##_name = {			\
 	.show = f2fs_sbi_show,					\
 	.struct_type = _struct_type,				\
 	.offset = offsetof(struct _struct_name, _elname),       \
+	.size = sizeof_field(struct _struct_name, _elname),	\
 }
 
 F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_urgent_sleep_time,
-- 
2.51.0


