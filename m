Return-Path: <stable+bounces-211254-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKyUGhRFcmnpfAAAu9opvQ
	(envelope-from <stable+bounces-211254-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 16:41:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFD069104
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 16:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D11DD3000717
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 15:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253B644A702;
	Thu, 22 Jan 2026 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UInVgzqJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316824418CE
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096465; cv=none; b=cmZa4VPJIMjxMYo0NDYKs3Q5hMyi3VpoiDDyNKRwOEKCosVVqx4u9iwHtvpGFeiA9D6r5HVRRL78KDbyWGWez8tzL450gKdBh7EKXGyniS8qMTV3l0YzwGzOEzqlNlqaun4c8k+Uv+M/CNFudZjKb2RkPXwFBHq09zY4gKcqPcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096465; c=relaxed/simple;
	bh=uONlpUsG6B+1SJNCDttGGY2DFAbNfSVv6+TjnGPV9Ro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rv+Rq81PXTJjO50IV6Xez6XrnF4SB9i1SZgLwUHp2l/Tf1e8ASF4QLWj6I1S2xbAl+9HjVrdRVI/scqbNsnTznNHHtro54WEIzMlmB9pJjYLtlh9R6UD3Hi6LF+p4wvT0DSuTebcFw4oLXb6fzQoXGY+y1QcN1gBmFZmdv9/+E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UInVgzqJ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-81e821c3d4eso1007256b3a.3
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 07:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769096462; x=1769701262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iC3BQrsx4m1KIySd6SGYfoOdN/kOmKuZK6JhgQwLLwU=;
        b=UInVgzqJdiwkrpta0q1byxIFltiwJbGYlfvUihTy1JF0VxZ1EhsDOfpEfaK1nd3awD
         aoGR4DIcNaGc5hur+fI4/Dfy4NUzWJ6T7sxdXa/K2CDXIngiw9lZZU+NwnyZUVetns9I
         5bEOzxsZp/MF6zlIFd3hw+f403B5rP6M2o2KK6F506alIzWt23EZ7AP2yabYG7Zw2Z0W
         kXLMV3IbFrh3fa66hRBG1Xu3xXjcorVd6T0uIX3QuIkOmWqn0x+GjjRt1BCPHy+A45kt
         RbC39LlbzbC1Dun65yFK840m4+2/1XTmQPWHXzMuJxU6XNhm2b0OZ2wNuV2n+cTT7K4x
         RG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769096462; x=1769701262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iC3BQrsx4m1KIySd6SGYfoOdN/kOmKuZK6JhgQwLLwU=;
        b=NKR6moLtvnJM9qtDAUmzg3Hregbfiqf56A+FRwEOute/tyFTJxyVJeGvWFsFHOcWdi
         suQhoYOXMD1gi1Dpe42oNyv6lWLAnZ0KCIcpZuX8z30lHQ+pFgFyZpFjg4oDZaoQ0jDJ
         ay5J2D3DOi4sxwnYOdc/aIaHhMF/eKQ7SMMROasPcRuRUJtj2ybHYS2eHHXRJgMFewD/
         eJfPJUSX5LANtXl2BLWEsWxHsqVaFWSaxX9BhCC8TowBmLTsziYOyXt3IyLjcyDuC2Dv
         fCcrpUTlz+jvKhMDw15AFpC5suri9p9sz8kC5VsOcWtcHCcbUV2U+nXwK+TIg8Em6fdG
         z0bw==
X-Forwarded-Encrypted: i=1; AJvYcCVnQY6d8eAPmHkL9hb1ihq0CIJdq+cDbf2GKcCwYaD4Rc6bF6HPt0lg1I8vcoNO0c3EGZDlqzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwqeuu1ywSdauow37WvvOUteccHr+PbeeE25fJXkgqHpLv0XTm
	NPbIsUWp/4mC2FBtPW2jp/acoVyBUuznsIdY5CXY8BMivvvTJvurHF1j
X-Gm-Gg: AZuq6aIqULry0aDXL2sLWO41otY35FK3UpGl3UM3nbJBggfJ1sRrA72MACBU0gJK9cK
	xBlBBQUtqVsapS5yBIX664xv23WxuMaexJSJ1Tpkmou5T91pdZHAngE1oRj9RexJTNpPr8d76D4
	XqP+mRHLXQo15QIcVjNIZXF/N5snKxr84ZxzNyNz9S2WOgrIBsOGRNfqGonJIZr7SGg7cAXEhlU
	7eL/J6X4kjWiv8WN7DWRyJ+XjWBNtPoAWfrf5dP/1v5FfoGtcHKVjbRl93yq5wvlq3MmMUcbwGW
	CioGmKeAP4wTB53KMgEh+qLZEx8yJXwoQZsrC2K1UtU8S1tJ6pW2UfgW1zjZNPgUAALcF2BIOl8
	3VNPeeTzGxM0xBcv/Of6rqT83ch3072wxQi/vFRX5/KvuleuXDsrhIIA8Bs3PEMo4NnbftX1oNR
	nUSE4vKT5XxH4AHv6SOpAm4MQmPusD
X-Received: by 2002:a05:6a00:1302:b0:823:1117:39e6 with SMTP id d2e1a72fcca58-82311173ef0mr798121b3a.33.1769096462238;
        Thu, 22 Jan 2026 07:41:02 -0800 (PST)
Received: from localhost.localdomain ([111.125.231.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82181d6f7f7sm3474462b3a.50.2026.01.22.07.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 07:41:01 -0800 (PST)
From: Prithvi Tambewagh <activprithvi@gmail.com>
To: martin.petersen@oracle.com,
	d.bogdanov@yadro.com,
	bvanassche@acm.org
Cc: linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Prithvi Tambewagh <activprithvi@gmail.com>,
	syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] scsi: target: fix recursive locking in __configfs_open_file()
Date: Thu, 22 Jan 2026 21:10:51 +0530
Message-Id: <20260122154051.64132-1-activprithvi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linuxfoundation.org,gmail.com,kernel.org,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-211254-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[activprithvi@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,f6e8174215573a84b797];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CFFD069104
X-Rspamd-Action: no action

In flush_write_buffer, &p->frag_sem is acquired and then the loaded store
function is called, which, here, is target_core_item_dbroot_store().
This function called filp_open(), following which these functions were
called (in reverse order), according to the call trace:

down_read
__configfs_open_file
do_dentry_open
vfs_open
do_open
path_openat
do_filp_open
file_open_name
filp_open
target_core_item_dbroot_store
flush_write_buffer
configfs_write_iter

target_core_item_dbroot_store() tries to validate the new file path by
trying to open the file path provided to it; however, in this case,
the bug report shows:

db_root: not a directory: /sys/kernel/config/target/dbroot

indicating that the same configfs file was tried to be opened, on which
it is currently working on. Thus, it is trying to acquire frag_sem
semaphore of the same file of which it already holds the semaphore obtained
in flush_write_buffer(), leading to acquiring the semaphore in a nested
manner and a possibility of recursive locking.

Fix this by modifying target_core_item_dbroot_store() to use kern_path()
instead of filp_open() to avoid opening the file using filesystem-specific
function __configfs_open_file(), and further modifying it to make this
fix compatible.

Reported-by: syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f6e8174215573a84b797
Tested-by: syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
---
Changes since v1:
 - Update commit message to reflect the fact that same file, which code was 
   currently operating on, was tried to be opened again, leading to 
   acquiring the same semaphore in nested manner & possibility of recursive
   locking.

v1 link: https://lore.kernel.org/all/20260108191523.303114-1-activprithvi@gmail.com/T/ 

 drivers/target/target_core_configfs.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index b19acd662726..f29052e6a87d 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -108,8 +108,8 @@ static ssize_t target_core_item_dbroot_store(struct config_item *item,
 					const char *page, size_t count)
 {
 	ssize_t read_bytes;
-	struct file *fp;
 	ssize_t r = -EINVAL;
+	struct path path = {};
 
 	mutex_lock(&target_devices_lock);
 	if (target_devices) {
@@ -131,17 +131,18 @@ static ssize_t target_core_item_dbroot_store(struct config_item *item,
 		db_root_stage[read_bytes - 1] = '\0';
 
 	/* validate new db root before accepting it */
-	fp = filp_open(db_root_stage, O_RDONLY, 0);
-	if (IS_ERR(fp)) {
+	r = kern_path(db_root_stage, LOOKUP_FOLLOW, &path);
+	if (r) {
 		pr_err("db_root: cannot open: %s\n", db_root_stage);
 		goto unlock;
 	}
-	if (!S_ISDIR(file_inode(fp)->i_mode)) {
-		filp_close(fp, NULL);
+	if (!d_is_dir(path.dentry)) {
+		path_put(&path);
 		pr_err("db_root: not a directory: %s\n", db_root_stage);
+		r = -ENOTDIR;
 		goto unlock;
 	}
-	filp_close(fp, NULL);
+	path_put(&path);
 
 	strscpy(db_root, db_root_stage);
 	pr_debug("Target_Core_ConfigFS: db_root set to %s\n", db_root);

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.34.1


