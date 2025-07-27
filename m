Return-Path: <stable+bounces-164856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7FAB12F20
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 12:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21DDA3BF8A1
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 10:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FB120E6E2;
	Sun, 27 Jul 2025 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Atdtr0iS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDA81F03C7;
	Sun, 27 Jul 2025 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753610587; cv=none; b=Vqw7sMmrvv7bXuqc5zOx9M4jxifLZ9/NaZ9rcz9zo6z7AicbOUkFE/jyAFSYP5/orxl2Ml3nHp/uNzGg+/Rn4ecTC4pVqrBpgRLFqk87GQQvOkXigHa5Ty1DHJbsZwi6nZfJ0RS+OCvod40wSbOpPIlnH9mRbeP3dAXv3Gk5GGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753610587; c=relaxed/simple;
	bh=KIhwRJtcIMjpNyI98zHF+fZcmItsdoqfxZ006fYqAQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bnKTseVIGou+BFKGc98dNQ6mJ8HhozJK99kyNjAB8L4ycV3Pk6ab4V4wFru9GkAVe/SZncHsMjieS9H5I90jt/Oa1DwonVdT+3qpdF4cSYdDMmgWCu0yP9Q5rPGKB7kCsIAakgffJtDCrQpkszEVWoAhBHJ1MmVXMsSPOHnTC40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Atdtr0iS; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-748e81d37a7so2316398b3a.1;
        Sun, 27 Jul 2025 03:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753610584; x=1754215384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vHlsqDRY86QvllziLUeghJaEVPJqcRXSBPZP7GSLZ84=;
        b=Atdtr0iSuXLn4uhKjRcPDeUGZ4yuTQO4ZJ53m20Sf+1qhw6zsvXLf6rkNFw1+hBQEr
         iTVb4uz5t1rQCGWu362LcUlTMn1cQUa/vXWZHar7DjQhpP+2SjZNwgRvgjMnOgxtEZba
         PmLc0qiur6voF0SZwg2QSAsfIHvJ+O3ZSYa3BiuiZCcvfUjYEMevQACgJ7YQIG8vDL49
         JLCdR0CP9tesru+MbnLYdATuVyPgxp7dLrfn0GRg9yKZkxaio88yxdhWiTyvU3JyvhZ3
         0GUiUDnduG2PhWemimEgOyzj4IWRga4qxtluRxsEgnTHKOoxlMIxBssWsGea3JF3g8sV
         sg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753610584; x=1754215384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHlsqDRY86QvllziLUeghJaEVPJqcRXSBPZP7GSLZ84=;
        b=D0tEv+vNh8vFAsdoIHdUPfsjcKn752Iie5H2NXNKqqhgypOcRz1QbV/bbLM/SJ34qm
         rzRR1DQVajH30gpkDeK17cC9YXP+TTikKV5gGqz4UkrPsPTZK4G8kJiD7HBqo00Pwf1B
         6WboJD8Ahr26nBZZEQe70vEM2mMDgevb1IAtvDn/9zmmpfv7Df9joxkAu8UrPjjrvksq
         ISZ2gLvnqBq1ZmtZvAB8/n5c8DvMPk2fTR9jcSfWhQhfTGgwZEqZLMe6cxe/Bm73qLCP
         MW3yP5TTjfMYxLYYCWbCfKgkeJG6Iq/j2hMntjy8opbtqMclfTqBMrgqS+ACpFsCdAKU
         37NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnbd9pqndDbS4esi3Zqv3QegolnLT3S9Z9u6V9ladh9ci89pQbzKFmB4d9zlhetBAjsW7sE6Ff103x4rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuO6r6s0MEQb5y911u317BPtvfr/M5/iCd1kDXpsHnQmj+5Sen
	rDRe9sFDhysOUByEhUOZiljr6IxRIcdWEN/W4WLlTJwhsn8gl4WT3W+iFmYZHIE0
X-Gm-Gg: ASbGncthkzizsSzoKbD1ksfHZmEhTCeptiw3K5d1A4WGdUTQUcySQLTeitH4llk+qXY
	iBAe2ENK1l7Ac0C9LzTmkGEP8NzFu8o/sHx0Khw+/e/Y5aDq69iSRFKPNTK+CNIEHwN32R+vQBl
	2Bw/+4g24yHf5OsetfcP86KWOOaqR03+POjt+mux51bXcwgg1X75wru75em4g57sDgL1L9UIzW1
	RNzxWFNZ8W9OJoAU1491Xa7k8BbFkJTZ/+tR2oc94eHf+OAI4IQzIUnlaoPa5FVt3c538GJ6Ifu
	xtLa0MRdszVzA0qevA1AuWz/l6+CLWBcpmiq6oyExjykB2V7+XUkXbQKnVRDZGOK005IM64jD7B
	8V9Ii2bqukteKkT6J9aq1Fg==
X-Google-Smtp-Source: AGHT+IF53y2cXE+wr8YjMe1pr3KIJpJxPgZRhOla94yShofJwGtYmcImhuG/JqUZaXfeS3Cv0QF+og==
X-Received: by 2002:a05:6a20:9150:b0:231:e3a4:956a with SMTP id adf61e73a8af0-23d70189c20mr12420484637.33.1753610584381;
        Sun, 27 Jul 2025 03:03:04 -0700 (PDT)
Received: from pop-os.. ([49.207.200.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640baa2a28sm2956087b3a.139.2025.07.27.03.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 03:03:04 -0700 (PDT)
From: Aditya Dutt <duttaditya18@gmail.com>
To: stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Dave Kleikamp <shaggy@kernel.org>,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	jfs-discussion@lists.sourceforge.net,
	syzbot+ac2116e48989e84a2893@syzkaller.appspotmail.com,
	Aditya Dutt <duttaditya18@gmail.com>
Subject: [PATCH 6.1.y] jfs: reject on-disk inodes of an unsupported type
Date: Sun, 27 Jul 2025 15:32:55 +0530
Message-Id: <20250727100255.532093-1-duttaditya18@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit 8c3f9a70d2d4dd6c640afe294b05c6a0a45434d9 ]

Syzbot has reported the following BUG:

kernel BUG at fs/inode.c:668!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 3 UID: 0 PID: 139 Comm: jfsCommit Not tainted 6.12.0-rc4-syzkaller-00085-g4e46774408d9 #0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
RIP: 0010:clear_inode+0x168/0x190
Code: 4c 89 f7 e8 ba fe e5 ff e9 61 ff ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 7c c1 4c 89 f7 e8 90 ff e5 ff eb b7
 0b e8 01 5d 7f ff 90 0f 0b e8 f9 5c 7f ff 90 0f 0b e8 f1 5c 7f
RSP: 0018:ffffc900027dfae8 EFLAGS: 00010093
RAX: ffffffff82157a87 RBX: 0000000000000001 RCX: ffff888104d4b980
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900027dfc90 R08: ffffffff82157977 R09: fffff520004fbf38
R10: dffffc0000000000 R11: fffff520004fbf38 R12: dffffc0000000000
R13: ffff88811315bc00 R14: ffff88811315bda8 R15: ffff88811315bb80
FS:  0000000000000000(0000) GS:ffff888135f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005565222e0578 CR3: 0000000026ef0000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 ? __die_body+0x5f/0xb0
 ? die+0x9e/0xc0
 ? do_trap+0x15a/0x3a0
 ? clear_inode+0x168/0x190
 ? do_error_trap+0x1dc/0x2c0
 ? clear_inode+0x168/0x190
 ? __pfx_do_error_trap+0x10/0x10
 ? report_bug+0x3cd/0x500
 ? handle_invalid_op+0x34/0x40
 ? clear_inode+0x168/0x190
 ? exc_invalid_op+0x38/0x50
 ? asm_exc_invalid_op+0x1a/0x20
 ? clear_inode+0x57/0x190
 ? clear_inode+0x167/0x190
 ? clear_inode+0x168/0x190
 ? clear_inode+0x167/0x190
 jfs_evict_inode+0xb5/0x440
 ? __pfx_jfs_evict_inode+0x10/0x10
 evict+0x4ea/0x9b0
 ? __pfx_evict+0x10/0x10
 ? iput+0x713/0xa50
 txUpdateMap+0x931/0xb10
 ? __pfx_txUpdateMap+0x10/0x10
 jfs_lazycommit+0x49a/0xb80
 ? _raw_spin_unlock_irqrestore+0x8f/0x140
 ? lockdep_hardirqs_on+0x99/0x150
 ? __pfx_jfs_lazycommit+0x10/0x10
 ? __pfx_default_wake_function+0x10/0x10
 ? __kthread_parkme+0x169/0x1d0
 ? __pfx_jfs_lazycommit+0x10/0x10
 kthread+0x2f2/0x390
 ? __pfx_jfs_lazycommit+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x4d/0x80
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

This happens when 'clear_inode()' makes an attempt to finalize an underlying
JFS inode of unknown type. According to JFS layout description from
https://jfs.sourceforge.net/project/pub/jfslayout.pdf, inode types from 5 to
15 are reserved for future extensions and should not be encountered on a valid
filesystem. So add an extra check for valid inode type in 'copy_from_dinode()'.

Reported-by: syzbot+ac2116e48989e84a2893@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ac2116e48989e84a2893
Fixes: 79ac5a46c5c1 ("jfs_lookup(): don't bother with . or ..")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Aditya Dutt <duttaditya18@gmail.com>
---

As per: https://lore.kernel.org/all/CAODzB9roW_ObEa8K8kowbfQ4bL3w4R78v2b_yBU4BQL4bpXrWw@mail.gmail.com/
this commit is not backported to any of the stable kernels (other than 6.15.y)
I have already sent an email for:
  6.12.y: https://lore.kernel.org/stable/20250727095111.527745-1-duttaditya18@gmail.com/
  6.6.y: https://lore.kernel.org/stable/20250727095645.530309-1-duttaditya18@gmail.com/
I will be sending separate email for 5.15.y

 fs/jfs/jfs_imap.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 9adb29e7862c..1f2e452a7676 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -3029,14 +3029,23 @@ static void duplicateIXtree(struct super_block *sb, s64 blkno,
  *
  * RETURN VALUES:
  *	0	- success
- *	-ENOMEM	- insufficient memory
+ *	-EINVAL	- unexpected inode type
  */
 static int copy_from_dinode(struct dinode * dip, struct inode *ip)
 {
 	struct jfs_inode_info *jfs_ip = JFS_IP(ip);
 	struct jfs_sb_info *sbi = JFS_SBI(ip->i_sb);
+	int fileset = le32_to_cpu(dip->di_fileset);
+
+	switch (fileset) {
+	case AGGR_RESERVED_I: case AGGREGATE_I: case BMAP_I:
+	case LOG_I: case BADBLOCK_I: case FILESYSTEM_I:
+		break;
+	default:
+		return -EINVAL;
+	}
 
-	jfs_ip->fileset = le32_to_cpu(dip->di_fileset);
+	jfs_ip->fileset = fileset;
 	jfs_ip->mode2 = le32_to_cpu(dip->di_mode);
 	jfs_set_inode_flags(ip);
 
-- 
2.34.1


