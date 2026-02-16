Return-Path: <stable+bounces-216660-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEgCCza3kmlDwwEAu9opvQ
	(envelope-from <stable+bounces-216660-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 07:20:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA03A1411AC
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 07:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F8B9300D954
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 06:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4B52DC783;
	Mon, 16 Feb 2026 06:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALAEpDBW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAA9291C10
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 06:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771222828; cv=none; b=tWocWdO4FklysqvOupmTArIwjkCClm5kbGqbUa98E+ldzsE79ivs4GrTsCdAIaDdAkeN42z+imAGjUALxgPFJrH7UK/VqYyGt0BuroIURPR5XbxspXg3YwO+H0KCkAxdVeuHiUaW9XQwqxxr7AyVdsaT27ah5eBrInYWFCtS3z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771222828; c=relaxed/simple;
	bh=lweh5wTqdn5NyXCEB1iITaZxpjD9zsXuEt4pDx+EBK4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BOY1VJlQqFW2cGbLWKQ1K22LYoV3cKJYcPc19lTQC1N23l7plD2XCVs/8MUU8MeJCWWMI8d6vIvAdyOJr0WuQY3xNFCDrE8YkVsjlMp7+bo9XERrLx323uDdo/66TCKTDfQQWm3plKJayJAcpHZ7jcI7q2mjZBYkOX80ekxtMdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALAEpDBW; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-824adc96ad2so2886759b3a.3
        for <stable@vger.kernel.org>; Sun, 15 Feb 2026 22:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771222826; x=1771827626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gq3u6/pH6XaIhkLYyxC209miQpGjF2eS8OFp0J3cin8=;
        b=ALAEpDBWJxUjzuwSWKAnp/tMqGNmMxFuwNAjeuQXGFVfxHaXlhJ+ZT8cxJX/qPwao/
         hYz0pxajX5pN/xjXORvEfNN8AMMFd1LiRivuBTmv693BuH7gqJwWHgcVVtwgqwvgxQn0
         x2h9k0gSCiHgWYDMOXBhrU9pbVgRj8k42Z3X325TwHdOLJQg+/9BMlq0X69+nC8M/NNb
         gy63Ha8sdQnw+PL5ePrmGT6RaMGKuQbCtxmQxVgy6y0HaHfmJ2rOagsVynAN6t27zh7F
         TMXqpTMeTHwOqXee/2AhBRUwg9lVJEzsXhkWbY3XvE2l2OLfNOxJW9IRe5Phn+xYd33u
         MwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771222826; x=1771827626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gq3u6/pH6XaIhkLYyxC209miQpGjF2eS8OFp0J3cin8=;
        b=SLDYl/V6/DWquWOyr0YYT2+vFk64d3a1xoxLiPqUgbZ5/q+AdC1AFCbWGs0ioveVPQ
         NRkhxPL3K1wisW5qBzRYn+cEqxyoEh3SWEdTSLyZuSxy5M5i2RTwfWj1J3Zi0wbLLy0P
         Q9+7rl4sT4XeeK8iDE+JHnIzi51OE6rYmHA12i/8k9tgynH8SR4mysfXuUVX9HOX0Ijv
         qkdJI/JZBgVmNstV9Fetbs6QMh+KdNpzngmarkuJ4iqmZG86pnNcW3LMq0Q+w3/mVBqw
         2VVhSl7X/5tMGp6NCalvi9wlzABx11dpRHaYBG9GZ8eNDHUozDjSbgwTOBN+v+Vcuf2t
         dFWg==
X-Forwarded-Encrypted: i=1; AJvYcCUcK2GKDqCUPoLLFgnSO01RIGiSAn6EZx8LXiqoTSDSUbWoB5xC/wT/TWuHUL4QG598D72eMIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrd/w8n35indtTaOdJX5biMr++fytaYOHHKuj17dQocod2blcM
	i6zbv2yYnI9tipVzBECeAKW8RJwn5q9gfoZbuIGoLcDEW2uxSxJVXmcKCnwnBO0A
X-Gm-Gg: AZuq6aImhXpZtZcD5X0k+0nIU6kL1WqR60PIOTngbXy9UCY7PBzyWC+mE7rzX42o3Bq
	K5+eGVQx2lBRZg8AgAvbzS4CCnHgs3C7AWL4KfVR7F8YZlv38E+bfxzxY2GrZI8f4LvZl1p3LBs
	GSe+xMjC0Bt4qI62a3h2jPjQgWzaIQ25IxVNJkUrg2LruvIG2NtA4400G2S1shxzoa9nrMVY61f
	GEK41zZiZWctHHM1M3Hk8yWuIzNaPQaRFkVstZhaIrfj5V54TvwDmX4t4K9ijbvD/k7oaAWnhtv
	78nsmhtJSus1lcLNjKaPBDlXK1UVA9WqFDjvkv/5IJw60B9iu+crJNZT9YSBh7WA5R5+Cm2qRao
	wn+45/dRAsNLdofaK1CCLP8tJf8FtIm4edDVQzU+P6r8dJ2VTBtLNU9nPyqaA/xOoWiyRy16HF4
	54J14vlUWHQZwA9VMF3hZ7DWxOqwOvBQF32jQ3IA==
X-Received: by 2002:a05:6a00:7543:b0:81e:12f1:d83 with SMTP id d2e1a72fcca58-824c6102ba1mr7161063b3a.42.1771222826432;
        Sun, 15 Feb 2026 22:20:26 -0800 (PST)
Received: from localhost.localdomain ([114.79.136.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a626bfsm8992768b3a.28.2026.02.15.22.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 22:20:26 -0800 (PST)
From: Prithvi Tambewagh <activprithvi@gmail.com>
To: martin.petersen@oracle.com,
	d.bogdanov@yadro.com,
	bvanassche@acm.org,
	viro@zeniv.linux.org.uk
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
Subject: [PATCH v4] scsi: target: fix recursive locking in __configfs_open_file()
Date: Mon, 16 Feb 2026 11:50:02 +0530
Message-Id: <20260216062002.61937-1-activprithvi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e854293d7f44b5a5];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-216660-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linuxfoundation.org,gmail.com,kernel.org,syzkaller.appspotmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[activprithvi@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,f6e8174215573a84b797];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA03A1411AC
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
Reviewed-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
Changes since v3:
 - Add LOOKUP_DIRECTORY flag in call to kern_path() so as to check presence 
   of directory checks more efficiently

v3 link: https://lore.kernel.org/all/20260205162624.117957-1-activprithvi@gmail.com/T/#m175d152067817dd6e9dc1821b6fbf626e47a4007


Note:
I checked out and found that when I try to test on commit 3a8660878839faadb4f1a6dd72c3179c1df56787
(latest commit on which bug dashboard reports the bug on, in upstream repository) 
syzbot uses, in its kernel config:

CONFIG_CC_VERSION_TEXT="gcc (Debian 12.2.0-14+deb12u1) 12.2.0"

Ref: https://syzkaller.appspot.com/x/.config?x=e854293d7f44b5a5
Syzbot Reply: https://lore.kernel.org/all/6767d8ea.050a0220.226966.0021.GAE@google.com/T/#m62bc76de5549460ae98e843bb120712548489794

While when #syz test (i.e. on HEAD commit of upstream) is used, it uses, in
its kernel config:

CONFIG_CC_VERSION_TEXT="gcc (Debian 14.2.0-19) 14.2.0"

Ref: https://syzkaller.appspot.com/x/.config?x=99ac58566e9eb044
Syzbot reply: https://lore.kernel.org/all/6767d8ea.050a0220.226966.0021.GAE@google.com/T/#me8b79610e4c18a8d8a7d8d6bc249d1c7cf2f8819

However in both cases it uses:

gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Probably due to mismatch in compiler version which syzbot actually uses and 
whats present in kernel config, the build fails for the first case. However, 
the patch succeeds in fixing the bug in second case.

Earlier for v1 patch (sine v2 patch involved minor change to commit message 
and v3 involved adding a missed out Reviewed-by tag) patch the kernel builds 
as well as testing succeeded since syzbot used this in its kernel config:

CONFIG_CC_VERSION_TEXT="gcc (Debian 12.2.0-14+deb12u1) 12.2.0"

as well as used the compiler:

gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40 

Changes since v2:
 - Add Reviewed-by tag received from Dmitry Bogdanov, which was accidentally
   left to be added in v2 patch.

v2 link: https://lore.kernel.org/linux-scsi/20260122154051.64132-1-activprithvi@gmail.com/T/#u
Reference for Reviewed-by Tag: https://lore.kernel.org/all/20260108191523.303114-1-activprithvi@gmail.com/T/#mb22d0fc06e747e2b2df8320a15afd2a0670fd0e7


Changes since v1:
 - Update commit message to reflect the fact that same file, which code was 
   currently operating on, was tried to be opened again, leading to 
   acquiring the same semaphore in nested manner & possibility of recursive
   locking.

v1 link: https://lore.kernel.org/all/20260108191523.303114-1-activprithvi@gmail.com/T/

 drivers/target/target_core_configfs.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index b19acd662726..f94c242eff97 100644
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
@@ -131,17 +131,14 @@ static ssize_t target_core_item_dbroot_store(struct config_item *item,
 		db_root_stage[read_bytes - 1] = '\0';
 
 	/* validate new db root before accepting it */
-	fp = filp_open(db_root_stage, O_RDONLY, 0);
-	if (IS_ERR(fp)) {
+	r = kern_path(db_root_stage, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &path);
+	if (r) {
 		pr_err("db_root: cannot open: %s\n", db_root_stage);
+		if (r == -ENOTDIR)
+			pr_err("db_root: not a directory: %s\n", db_root_stage);
 		goto unlock;
 	}
-	if (!S_ISDIR(file_inode(fp)->i_mode)) {
-		filp_close(fp, NULL);
-		pr_err("db_root: not a directory: %s\n", db_root_stage);
-		goto unlock;
-	}
-	filp_close(fp, NULL);
+	path_put(&path);
 
 	strscpy(db_root, db_root_stage);
 	pr_debug("Target_Core_ConfigFS: db_root set to %s\n", db_root);

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.34.1


