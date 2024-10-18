Return-Path: <stable+bounces-86864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF279A43B5
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 18:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F36C2864F5
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 16:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1CB2022F5;
	Fri, 18 Oct 2024 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOgy0wkg"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1752036F0;
	Fri, 18 Oct 2024 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729268635; cv=none; b=H7J1vu0MmTRnYVrXftIHg5aebwvU4nLzHXRmdo4M0/1Mx5UQ2FNdfJgoze7biFfteJYw5FXvK+lttD/IxcBnOduHyxbd95+hrPONW03s+UZf9hTOEz1Eg0It/9ceTNr8ufo3/HJp60V0dGbIODuVDUMaDGLK/v3bpKSahoNYLMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729268635; c=relaxed/simple;
	bh=pWimw8+n3PEcgW15vEgVc2cnL3PmMcgL4ZGdUChfg/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bydVua4HAtapQmh+LEaVZEhrKrznvOlZQ1geVd0RHvnLRYcblUBo9rGdMr+ih0r7quDmjNgSLJP/BhFfvO1Yh+7FjuW4eLxetSCg36H8Xj0zGtK5YV6otCZMmWLX4852EsoIGoTytiBdzZbXqeK5inWpkkm684GMtPSTj1F3Vzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOgy0wkg; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a991fedbd04so145614766b.3;
        Fri, 18 Oct 2024 09:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729268632; x=1729873432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yQjaH4CcnCrDPA3bF5cyFOmtMzegnmxnth1Xz2ETgnA=;
        b=BOgy0wkgwcIp5JafLdJM4ENrMsI/wdeMjFqvc7j46cA3l4LI5WHzknJgRuo06NhNX2
         kRFCBt6tvr8HaH+yR+FqiTt3SdBlEOpTECsPJCC2XXl1WMdPwUM9/u6iEUNoiO/DRTLA
         boy440ax40zTlpQN/abA097Qg893ABQza7BVQToel5gDbcN5S8nf8qFuy1bafZnG6kto
         OlOcvXtanLXlCLgzblXppSn3R4hlyWy6evr+iIEXH6ZPkJ/RrIg0O57xnlaTxcEzxiIK
         0e6Efx/hebAdONPz1I7wyvxBgG4qOjjWOuKRN9Q47NgaGVM9ISSqqe1g81Asq8aOWfUg
         2T4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729268632; x=1729873432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQjaH4CcnCrDPA3bF5cyFOmtMzegnmxnth1Xz2ETgnA=;
        b=vQgVnxbNkj0Xocz2rDd+pA6wwxMhqx4nCl8adNnlbF0hXpf07oDKd4WYknAxPQ8lyX
         gmpZ58naOQQ1Kva7TCd7+tL3VD+uEd1/W+qPzaD+wx1afDsgl2/NwkJxgfDxVEhxW38Z
         0OekxT+ajO/nwN20ZT8QkfJ6IavQWBW4SUtOtCvpgifyVzcBOgRPS7xsOeZK3rLqut49
         92jOKWMB2/aJaaMOQk7p1wWZl8Hfyc3Rv1BghNqSWulkJtjfM5ffCWnDnhW+G+UkOOLe
         P0BnLy/nRsjnlVePwuWHZ5jfTil1WFs9yTFn0RYy7CN/CBpa+KkC9C1WKAnIrJwQ+0pv
         4nHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV05cEAWsdPjOdvpUWLN93b3LWMAhcwrV7jfx6e0OkgE//e2W5JSOGU+v8xrmbOSl8DfNwu4lc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6jAewrfK3PxdZREZPM+8y4XRhJzIeAEh9byi3TTQyhZqrGbOP
	ynZG/SNxjrRYjnvw6W9iWQCQ25RPRjXFFimws4P90XGmHAnTjTxl3f31Ol4GDyE=
X-Google-Smtp-Source: AGHT+IHTNxAwXPIYFYyZX2ozVqRAkBIV4UoKsn4WIqXqtBRXUm1w4WgyRgG0p6DgzFW2ILAsOIi4rg==
X-Received: by 2002:a05:6402:5201:b0:5c9:40f5:1518 with SMTP id 4fb4d7f45d1cf-5ca0af863e0mr3629656a12.35.1729268631548;
        Fri, 18 Oct 2024 09:23:51 -0700 (PDT)
Received: from akanner-r14.netis.cc ([62.4.55.159])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ca0b0809dfsm927010a12.36.2024.10.18.09.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 09:23:51 -0700 (PDT)
From: Andrew Kanner <andrew.kanner@gmail.com>
To: aivazian.tigran@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Andrew Kanner <andrew.kanner@gmail.com>,
	syzbot+94891a5155abdf6821b7@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH RESEND] fs/bfs: fix possible NULL pointer dereference caused by empty i_op/i_fop
Date: Fri, 18 Oct 2024 18:22:36 +0200
Message-Id: <20241018162236.1553-1-andrew.kanner@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzkaller reported and reproduced the following issue:

loop0: detected capacity change from 0 to 64
overlayfs: fs on './file0' does not support file handles, \
           falling back to index=off,nfs_export=off.
BUG: kernel NULL pointer dereference, address: 0000000000000000
[...]
Comm: syz-executor169 Not tainted 6.11.0-rc5-syzkaller-00176-g20371ba12063 #0
[...]
Call Trace:
 <TASK>
 __lookup_slow+0x28c/0x3f0 fs/namei.c:1718
 lookup_slow fs/namei.c:1735 [inline]
 lookup_one_unlocked+0x1a4/0x290 fs/namei.c:2898
 ovl_lookup_positive_unlocked fs/overlayfs/namei.c:210 [inline]
 ovl_lookup_single+0x200/0xbd0 fs/overlayfs/namei.c:240
 ovl_lookup_layer+0x417/0x510 fs/overlayfs/namei.c:333
 ovl_lookup+0xcf7/0x2a60 fs/overlayfs/namei.c:1124
 lookup_one_qstr_excl+0x11f/0x260 fs/namei.c:1633
 filename_create+0x297/0x540 fs/namei.c:3980
 do_mknodat+0x18b/0x5b0 fs/namei.c:4125
 __do_sys_mknod fs/namei.c:4171 [inline]
 __se_sys_mknod fs/namei.c:4169 [inline]
 __x64_sys_mknod+0x8c/0xa0 fs/namei.c:4169
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc4b42b2839

However, the actual root cause is not related to overlayfs:
  (gdb) p lower.dentry->d_inode->i_op
  $6 = (const struct inode_operations *) 0xffffffff8242fcc0 <empty_iops>
  (gdb) p lower.dentry->d_inode->i_op->lookup
  $7 = (struct dentry *(*) \
       (struct inode *, struct dentry *, unsigned int)) 0x0

The inode, which is passed to ovl_lookup(), has an empty i_op,
so the following __lookup_slow() hit NULL doing it's job:
  old = inode->i_op->lookup(inode, dentry, flags);

bfs_fill_super()->bfs_iget() are skipping i_op/i_fop initialization
if vnode type is not BFS_VDIR or BFS_VREG (e.g. corrupted fs).
Adding extra error handling fixes the issue and syzkaller repro
doesn't trigger anything bad anymore.

Issue affects kernel builds with CONFIG_BFS_FS=y or =m only.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+94891a5155abdf6821b7@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/0000000000003d5bc30617238b6d@google.com/T/
Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
Cc: stable@vger.kernel.org
---
 fs/bfs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index db81570c9637..e590b231ad20 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -70,6 +70,10 @@ struct inode *bfs_iget(struct super_block *sb, unsigned long ino)
 		inode->i_op = &bfs_file_inops;
 		inode->i_fop = &bfs_file_operations;
 		inode->i_mapping->a_ops = &bfs_aops;
+	} else {
+		pr_err("Bad i_vtype for inode %s:%08lx\n", inode->i_sb->s_id, ino);
+		brelse(bh);
+		goto error;
 	}
 
 	BFS_I(inode)->i_sblock =  le32_to_cpu(di->i_sblock);
-- 
2.39.3


