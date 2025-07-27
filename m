Return-Path: <stable+bounces-164854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049D8B12EE4
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 11:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F06A17313D
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 09:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2522171C9;
	Sun, 27 Jul 2025 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbBrsIae"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6459202F70;
	Sun, 27 Jul 2025 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753609907; cv=none; b=XvEiuQfjIaddkfs2EW4RftyfO8jPm5bwziOiIKsxXUx5KT3FYgg37q8yPNgYBpm5lhpQ7/eUWTZk0Sutr5h4Qzsutcj6ar/fnF+rqvauZXrj8JcaF0TH3OVoqmIg6Qvj2ZAeK5iDKdp4HXYWTRvYTGNZFBWuFMVJ+Iy4U/46qgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753609907; c=relaxed/simple;
	bh=D5ppVq3QqCe7Zf1Zc+MyTGFktyD9Tu0/kwUllmqLIxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TV61aVnFcIff6lbUv4suBdCOdjOi4N8xykIZh5l2h3YwHWz1mzQHReo9t0EJisnUMDSrDlba8cwvyN6ndXXIx/rNHKd13yMiOD85Ej8kRUpbq8Vvz6UUXrHcw9RVnlavH/PvFtiYzPlos72t5+s48wpNnl0I5sH/MhKSY6oKIlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbBrsIae; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24009eeb2a7so1543415ad.0;
        Sun, 27 Jul 2025 02:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753609904; x=1754214704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dskf1rATUBFmCQprzjusof8q2SMFT1316UEra5Cd0Z8=;
        b=hbBrsIaeaPoyEdN3IeAM1kUSD2qfzXwQgTl1YxbfmCuERlKja802VA0EiqFhXuPr+h
         kN+OSsDAgfEsiC2fKqP87RdoshViX8LZ9QOAKtUEL7qOwl4MYHBwDSQsEuRhO2FzWZIo
         y3gU4rYQM3F6Mcbv1eu9B/scbaS7M9gZ1bfWLs2blIy3ZbSxh+oC1SvjN14zGXqZF3/A
         y5RTMWFeK54L7nebTovm6RNCrJBJzhWbiA7zD8dRVZcS2/q/FujArzoLz3Fx/bmqRokW
         arfwMxtYBXIo1eEsRhSmAZgrxphslKl/to6mnATh/KmyvAjTZlKF1wOeYPjuvN63yqSw
         QcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753609904; x=1754214704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dskf1rATUBFmCQprzjusof8q2SMFT1316UEra5Cd0Z8=;
        b=YjwL/Bp22t7EcPxXTauWpCjUZTB8PQFZp0p+hga8DojjlnvXNpjO1G4mti9g7yLMx8
         Vfaixk87bA/4NtZzMsfq8trKX/+Tbj9raywE8Dt8AAAeXVf7XyyeoSMoqEan/8LtKSTF
         vZFymJ+djWFe8TAFNDlrNOriEeud+bREEcyrJIQsbYBcUfYQ+Yja3laR2hYlNUBccPcv
         4MldnU0p/g6B/aXUehppOx5R+g9uErQn4Od6515UTSAdXEixl+2K2K9ybi/pSHa53aAh
         dhK0XBRkyxFxvmSRfOWTiyUtib23XeIX1kWHP3G/RZSekYKdzxBvMkHnMY5TVHl7qsRQ
         18Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWUSQ7WPtj/bfj+oW1Yt23fFxoM6WaOmuKY/Asfr8hSp2du090rlmCAoDiO4r0juECYHOHhXDxMPmsi9aU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzreqtWimA1G6cvpkdg5K8WkisZ7ugSE7spyxTrwxL93swByBV4
	Nd4yUIfd++SHZBEwgj14UQOZqObkcxOZYwMladcSZrVvIKb8wi3eyL7LmFmHH/V7
X-Gm-Gg: ASbGncvweZJl46VIv8kF3YMDleAeRtB4LrvlGjyh0cb8YbFD79jG/rLz/fmGitSduqN
	7ykF6WfmHgEMDSs5tNGB344y9TCPamqRviS7a97Ci+Grbx8lPWG8Amihg43+MHz/U8bda0Mr1BO
	csj6Avvz+fmBG7SF+aW5Jc2ULXqgYkt6bfsXebey22ljfZHYA143peGvmMXIQcWoWIZ5Ivp7XBw
	7fFXoeAKigamCiYox5Ok3xcY6WweAyvKGazmh51C/8ALVXBk1PrRnYIvK8tfBXdIzNaSi71JbYL
	w2fXxblTb4bxlWTKDS6t+0eW9BbSYxnl5yBt/ovM8SNLvtNZKifJl6d3UbeSVYl3J3tarydmlV5
	O1oLfvQvEzVj/WFkUtdYA5A==
X-Google-Smtp-Source: AGHT+IGpALJ699LdfAv3Y17ZVtcuGR1LM7zGC1tgkOCExgcr3JVyKpBWA7LQwWxspNNgwhzprbznWA==
X-Received: by 2002:a17:902:cf03:b0:236:6f5f:caaf with SMTP id d9443c01a7336-23fb3031402mr119651315ad.15.1753609903645;
        Sun, 27 Jul 2025 02:51:43 -0700 (PDT)
Received: from pop-os.. ([49.207.200.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fc5a9d25bsm27910545ad.83.2025.07.27.02.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 02:51:43 -0700 (PDT)
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
Subject: [PATCH 6.12.y] jfs: reject on-disk inodes of an unsupported type
Date: Sun, 27 Jul 2025 15:21:11 +0530
Message-Id: <20250727095111.527745-1-duttaditya18@gmail.com>
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
this commit is not backported to any of the stable kernels (other than
6.15.y)
I will be sending separate emails for 6.6.y, 6.1.y and 5.15.y

 fs/jfs/jfs_imap.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 8ddc14c56501..ecb8e05b8b84 100644
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


