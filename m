Return-Path: <stable+bounces-192500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6A0C358BF
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 12:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C84924EFCCA
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 11:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B537231283A;
	Wed,  5 Nov 2025 11:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gydHe1az"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10C8312800
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 11:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762343913; cv=none; b=RRn5FZ44Ri7otRUalJpKcxdj1BgA03I4X7JPyXSHms5YHhobMsR0L+gzsmMSF/XjmfMJoRoJV7R5xdjaWdB7Nd35QizfEmqS1KJrafS+xPlAvO/QdOmBamLhtZJUTHbL0f5tvLnHcIXw9oJxIPRpFopCZEtkahSLFOBZySfRb1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762343913; c=relaxed/simple;
	bh=eIENOMVlvTgUtIsFQ/3obVK+KyypwShHtyRs/gUjiDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CCSoLIWVf3C9gpsp6PAm4IXNduk/GeL8NuEIRvCTweFc8z6G6VbWoBKJYThIjMstKRldfulJjWzgRBy17MtmEMiTHlNEch/0i3gTHtGF/LuRGhC3zwmA23q04J13tlEe8Ccckd50/QrJ4i0Vh/Uux8m2AB5zL8d8XBysvAx8Py4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gydHe1az; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-294fc62d7f4so63903435ad.2
        for <stable@vger.kernel.org>; Wed, 05 Nov 2025 03:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762343911; x=1762948711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9/RiNKBRmnkSJkzhhg8RJuuCLAED/PQy6gI5C9KpT30=;
        b=gydHe1az50+GWb8EE76fA3sA0QyFxJjB/omqfJSkcu1xaYMf1DcTM9Pb3pttFlq7Pl
         FLRps5s9Or8CX5EW1G5NC5fZsO+j+jB7QgcZJbhIVb7fTB9bQqWm7yVvFEF+98cWwtyS
         CMBr39b+ad7hzF8SmqVLSKeQXvt38eKIE0xT3HbyoIPTuAX6uj1SxpXrHVygqoiloNqf
         OEXBsUK5mnzNaBXskzbhWnbcgpIg+ZwHMvXbqfyQp3M0dDDVMBZZaiLPQtbO8mtDtddr
         xtgwBqI6nu7b6hfLiQeZ9lNlSWTm8kMGqvED+zx6zONdr+SedEkazdaCSF3DF+n55EFw
         XmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762343911; x=1762948711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/RiNKBRmnkSJkzhhg8RJuuCLAED/PQy6gI5C9KpT30=;
        b=r1FHUFltX7TV5wESsFtT5YkFl02FkPc9L25SfIYJfwptayNu0V9Z9ljPEAH/KZzUuS
         Z4tykOhRIAR2Tq/dzw4ngtGzAxDKridtfoIR1t94F+DwuRR6Sgs3insGZrqC2zdRqiZn
         2nOzWw8DmpCjZ/Q6/e8tnESidswleS7x8Yo3htpStB0a6N6nUNgKzRuYmN0NImD4MwWQ
         neOQ2dWAcf38x9hdml+hFLWKO3u4xj17E7jUJ5lFS5MFsEIyAZD+r5+cArrd0wPvX64r
         YHY0xSbk+Y604SRbXmYdeE7X44I74gsxVNg/YihrUZl+i+SuYI77SExEvsb2QYYIvPZd
         KSiw==
X-Forwarded-Encrypted: i=1; AJvYcCUDf5OgXiZ+Hm9uBRem1nyjkydDm20ynk7oLujsmnEJqJpd9duioaDScxVBvXZmKB9woxBuYu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+x3JkF8cu3AgwXst2JCa2jIdaecFHyPx/ndk9k7kPH5ijIFoN
	cJKJ1cMBsCOcXFHYJg2KgNEMtyjz9rFHXVqqCscxm9xF9AyW5ddzF4a0
X-Gm-Gg: ASbGncvC+uTID0zgeJYfeV8r5gfxyLWNrouLPYba2O3edu/3XZzC6qAo0r+yLTklvf0
	h0lugd2BORkeVoK7+qdBj/GmQ3p3DScHNiuno9lrGn9IcU/nIvYCUxUnxBF8vMjSowuKTm66xkR
	k9cul54yxpsFmWo1E0KhAvN2z/US8qmgclNcgb5ji2DGtotyA28S8hlU8IVr5eTXs36x2QAnT1N
	I0xWS9huUcVnupEv10XXaR7suyMOXu8tuVpxYtr/RZF+YGz8WX0UWol4mAqlUK00kCseB8xNrDH
	A4wvyCDjBwJhQPpRNWU6h5kddk/oCnA3RHESnCa8MBaJivjclCpauOi4TMIKYHTmMb4emuWJCXe
	wzNzsB8DqGe0Zzp+78FO+pB4G2TFoIxXt8RKWAJi/4TQQIGWWiScbCX7z+YZqnmAYEkUG/EjFW8
	B7qQ==
X-Google-Smtp-Source: AGHT+IGZ2HWIY2B6TdrBgHFBIW+Q/qnLcYpDWz/gdPqE3sljXu8cOFt0VQuunzihT+evp6YD/wP+RA==
X-Received: by 2002:a17:903:2c0f:b0:295:a1a5:bb0f with SMTP id d9443c01a7336-2962add9f39mr39434405ad.18.1762343911172;
        Wed, 05 Nov 2025 03:58:31 -0800 (PST)
Received: from lgs.. ([103.86.77.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a5070fsm60041855ad.75.2025.11.05.03.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 03:58:30 -0800 (PST)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>,
	linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] firewire: nosy: break circular locking with misc_mtx in ->open()
Date: Wed,  5 Nov 2025 19:58:18 +0800
Message-ID: <20251105115819.1083201-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Lockdep reports a circular dependency between card_mutex and misc_mtx:

  misc_open() holds misc_mtx and calls ->open():
    misc_mtx -> nosy_open()

  add_card()/remove_card() hold card_mutex and (de)register the miscdev:
    card_mutex -> misc_register()/misc_deregister() -> misc_mtx

nosy_open() only used card_mutex to map the minor to the pcilynx instance
by scanning card_list. However, misc_open() already sets file->private_data
to the struct miscdevice of the opened minor, so we can obtain the pcilynx
pointer via container_of() and take a kref, without taking card_mutex in
the open path.

This removes the misc_mtx -> card_mutex edge and breaks the cycle.

The crash info is below：
======================================================
WARNING: possible circular locking dependency detected
5.18.0-rc1 #1 Not tainted
------------------------------------------------------
syz-executor.1/1374 is trying to acquire lock:
ffffffff8f8bb4e8 (card_mutex#2){+.+.}-{3:3}, at: nosy_open+0x55/0x480

but task is already holding lock:
ffffffff8ef78a88 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5a/0x3f0

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:
-> #1 (misc_mtx){+.+.}-{3:3}:
       __mutex_lock_common+0x138/0x2450
       mutex_lock_nested+0x17/0x20
       misc_register+0x95/0x490
       foo_misc_register+0x3a/0x50
       add_card+0xd38/0x1250
       local_pci_probe+0x140/0x200
       pci_device_probe+0x345/0x770
       really_probe+0x2d1/0x990
       __driver_probe_device+0x1a7/0x270
       driver_probe_device+0x54/0x370
       __driver_attach+0x430/0x590
       bus_for_each_dev+0x125/0x190
       bus_add_driver+0x32c/0x530
       driver_register+0x309/0x410
       do_one_initcall+0x104/0x250
       do_initcall_level+0x102/0x132
       do_initcalls+0x46/0x74
       kernel_init_freeable+0x28f/0x393
       kernel_init+0x14/0x1a0
       ret_from_fork+0x22/0x30
-> #0 (card_mutex#2){+.+.}-{3:3}:
       __lock_acquire+0x3607/0x7930
       lock_acquire+0xff/0x2d0
       __mutex_lock_common+0x138/0x2450
       mutex_lock_nested+0x17/0x20
       nosy_open+0x55/0x480
       misc_open+0x363/0x3f0
       chrdev_open+0x407/0x490
       do_dentry_open+0x5b4/0xc20
       path_openat+0x1d7a/0x2300
       do_filp_open+0x1cb/0x3e0
       do_sys_openat2+0x96/0x350
       __x64_sys_openat+0x186/0x1b0
       do_syscall_64+0x43/0x90
       entry_SYSCALL_64_after_hwframe+0x44/0xae
other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(misc_mtx);
                               lock(card_mutex#2);
                               lock(misc_mtx);
  lock(card_mutex#2);

 *** DEADLOCK ***

1 lock held by syz-executor.1/1374:
 #0: ffffffff8ef78a88 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5a/0x3f0

stack backtrace:
CPU: 0 PID: 1374 Comm: syz-executor.1 Not tainted 5.18.0-rc1 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x5a/0x74
 check_noncircular+0x223/0x2d0
 __lock_acquire+0x3607/0x7930
 lock_acquire+0xff/0x2d0
 __mutex_lock_common+0x138/0x2450
 mutex_lock_nested+0x17/0x20
 nosy_open+0x55/0x480
 misc_open+0x363/0x3f0
 chrdev_open+0x407/0x490
 do_dentry_open+0x5b4/0xc20
 path_openat+0x1d7a/0x2300
 do_filp_open+0x1cb/0x3e0
 do_sys_openat2+0x96/0x350
 __x64_sys_openat+0x186/0x1b0
 do_syscall_64+0x43/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fbaab4abbcd
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbaaac1cbe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fbaab5c9f80 RCX: 00007fbaab4abbcd
RDX: 0000000000062803 RSI: 0000000020003080 RDI: ffffffffffffff9c
RBP: 00007fbaab519edb R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe62540a6f R14: 00007ffe62540c10 R15: 00007fbaaac1cd80
 </TASK>
======================================================
Fixes: 424d66cedae8 ("firewire: nosy: fix device shutdown with active client")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/firewire/nosy.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/firewire/nosy.c b/drivers/firewire/nosy.c
index b0d671db178a..726d5f15ff08 100644
--- a/drivers/firewire/nosy.c
+++ b/drivers/firewire/nosy.c
@@ -263,19 +263,13 @@ set_phy_reg(struct pcilynx *lynx, int addr, int val)
 static int
 nosy_open(struct inode *inode, struct file *file)
 {
-	int minor = iminor(inode);
+	struct miscdevice *misc = file->private_data;
 	struct client *client;
-	struct pcilynx *tmp, *lynx = NULL;
+	struct pcilynx *lynx;
 
-	mutex_lock(&card_mutex);
-	list_for_each_entry(tmp, &card_list, link)
-		if (tmp->misc.minor == minor) {
-			lynx = lynx_get(tmp);
-			break;
-		}
-	mutex_unlock(&card_mutex);
-	if (lynx == NULL)
-		return -ENODEV;
+	/* misc_open() set file->private_data to the miscdevice already. */
+	lynx = container_of(misc, struct pcilynx, misc);
+	lynx_get(lynx);
 
 	client = kmalloc(sizeof *client, GFP_KERNEL);
 	if (client == NULL)
-- 
2.43.0


