Return-Path: <stable+bounces-86650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6669A2AA7
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 19:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2B8282D82
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 17:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9691DF99F;
	Thu, 17 Oct 2024 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qeQFnmPo"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68D91DFD9D
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185573; cv=none; b=axkYx8U+n25z0oFkhn7RfunQhDers10OAeQONhU2iRSAkYb1pt5q/drJtJX1I8/NtWNRmcD3yFArbJl4sfQmuwBasl8Dj7VEpfe8KADpJGNG8NY1tgAOa14yJ9jz+UtxdVoyz/KJL3yj/9piHPt1nburt37JmlyakLwLdNSQ7wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185573; c=relaxed/simple;
	bh=60yfYtKugCRlh0OHVPrmi5MVVT1Ma+QPnC7Vylc8lL0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AQSPfkNK3gpx5Sr/USgD+oBURzrhiBYl6T4MRN+pr/P06X0n5B+mcsN1PFcF2HQ7V1SC7GQ63ukye4//zZuRo76/fibgbrWhBRACPPlycizwK+nunkjn+6F7XpLmjqxKRk2u469k87KPWwD6ksOxQDbPeYYup3slVUP9/HW7bcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=qeQFnmPo; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=LG9BIIqLcW0ZLmlBWHnDVy3ilvP/X1z4TCg1AQ3NP9s=; b=qeQFnmPojWl2wlBfgeiGVKq+K7
	FgmVhgH/s0UfHrxOTGZifZK7L8wdzhzSiadbw336DM+ssWgwGTwQwVwfKEEjsAKUj7MpjVkbOu1PV
	a7nJ+gPocMsPnoOYV/6jK2O0SrZ6b0VZKSYhxBkOq3YbBdLgD557pagEmEq+6YpptkXNhNd5nC/vT
	nFznjgr+K6+zRShLEJFRx7scfiQxiAF8n4FtQ+e0lNJEDYJRxUPkZPmSFCEvD+8aTStfw3GSBaOfH
	HeFNNbRGoQRQzjYwQqwiB4IvXatIHFzHHx3MOfVVVy39pcPlqqhkooFL6CKMqmnRPt0Q03YI3E6Ml
	p6BEgMaw==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1U9m-00Biqr-El; Thu, 17 Oct 2024 19:19:27 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 6.1 00/19] Fix NULL pointer dereference for corrupted UDF filesystems
Date: Thu, 17 Oct 2024 14:18:56 -0300
Message-Id: <20241017171915.311132-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UDF filesystems which have relocated blocks past the end of the device may
lead to a dcache without an inode that would lead to a NULL pointer
dereference, like this:

[   65.938826] repro: attempt to access beyond end of device
[   65.938826] loop0: rw=2049, sector=2052, nr_sectors = 2 limit=2048
[   65.939476] Buffer I/O error on dev loop0, logical block 1026, lost async page write
[   65.940426] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   65.940894] #PF: supervisor read access in kernel mode
[   65.941280] #PF: error_code(0x0000) - not-present page
[   65.941552] PGD 8691067 P4D 8691067 PUD 84cb067 PMD 0
[   65.941830] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   65.942069] CPU: 0 PID: 460 Comm: repro Not tainted 6.1.113-rc2-00792-g7e3aa874350e #618
[   65.942490] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
[   65.942906] RIP: 0010:path_openat+0x3ae/0x5db
[   65.943136] Code: 89 c0 b8 eb ff ff ff 45 84 c0 0f 85 50 ff ff ff 83 3d da 24 3d 01 00 48 8b 4a 70 44 8b ad e4 00 00 00 8b 95 e0 00 00 00 75 0c <8b> 01 66 25 00 f0 66 3d 00 10 74 95 83 3d b0 24 3d 01 00 75 0c 8b
[   65.944078] RSP: 0018:ffffc900001c7d50 EFLAGS: 00010246
[   65.944387] RAX: 00000000ffffffeb RBX: ffffc900001c7edc RCX: 0000000000000000
[   65.945072] RDX: 0000000000000000 RSI: 0000000000000132 RDI: 0000000000000000
[   65.945948] RBP: ffffc900001c7dc0 R08: 000000000622c100 R09: 0000000000000000
[   65.946412] R10: ffffc900001c7b30 R11: 0000000000000002 R12: ffff888009533a00
[   65.946833] R13: 00000000000041ed R14: 0000000000008241 R15: ffffffff82450ca0
[   65.947257] FS:  00007c48054c4740(0000) GS:ffff88803ea00000(0000) knlGS:0000000000000000
[   65.947702] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   65.947997] CR2: 0000000000000000 CR3: 0000000008c40000 CR4: 0000000000750ef0
[   65.948361] PKRU: 55555554
[   65.948503] Call Trace:
[   65.948631]  <TASK>
[   65.948799]  ? __die_body+0x1a/0x5d
[   65.949079]  ? page_fault_oops+0x2ca/0x358
[   65.949370]  ? exc_page_fault+0x15f/0x18b
[   65.949654]  ? asm_exc_page_fault+0x26/0x30
[   65.949953]  ? path_openat+0x3ae/0x5db
[   65.950228]  do_filp_open+0x52/0xb3
[   65.950480]  ? lock_release+0x17a/0x25f
[   65.950759]  ? _raw_spin_unlock+0x1e/0x32
[   65.951044]  do_sys_openat2+0x6d/0xe0
[   65.951305]  do_sys_open+0x39/0x57
[   65.951479]  do_syscall_64+0x71/0x88
[   65.951660]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   65.951913] RIP: 0033:0x7c48055ecc7d
[   65.952100] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 81 0d 00 f7 d8 64 89 01 48
[   65.953002] RSP: 002b:00007fff38c48918 EFLAGS: 00000202 ORIG_RAX: 0000000000000055
[   65.953378] RAX: ffffffffffffffda RBX: 00007fff38c48a48 RCX: 00007c48055ecc7d
[   65.953733] RDX: 00007c48055ecc7d RSI: 0000000000000000 RDI: 0000000020000d00
[   65.954128] RBP: 00007fff38c48930 R08: 0000000000000000 R09: 0000000000000000
[   65.954492] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[   65.955122] R13: 00007fff38c48a58 R14: 00005661cd1ccd10 R15: 00007c480572d000
[   65.955666]  </TASK>
[   65.955843] Modules linked in:
[   65.956054] CR2: 0000000000000000
[   65.956285] ---[ end trace 0000000000000000 ]---
[   65.956610] RIP: 0010:path_openat+0x3ae/0x5db
[   65.956886] Code: 89 c0 b8 eb ff ff ff 45 84 c0 0f 85 50 ff ff ff 83 3d da 24 3d 01 00 48 8b 4a 70 44 8b ad e4 00 00 00 8b 95 e0 00 00 00 75 0c <8b> 01 66 25 00 f0 66 3d 00 10 74 95 83 3d b0 24 3d 01 00 75 0c 8b
[   65.957973] RSP: 0018:ffffc900001c7d50 EFLAGS: 00010246
[   65.958255] RAX: 00000000ffffffeb RBX: ffffc900001c7edc RCX: 0000000000000000
[   65.958636] RDX: 0000000000000000 RSI: 0000000000000132 RDI: 0000000000000000
[   65.959111] RBP: ffffc900001c7dc0 R08: 000000000622c100 R09: 0000000000000000
[   65.959601] R10: ffffc900001c7b30 R11: 0000000000000002 R12: ffff888009533a00
[   65.960095] R13: 00000000000041ed R14: 0000000000008241 R15: ffffffff82450ca0
[   65.960539] FS:  00007c48054c4740(0000) GS:ffff88803ea00000(0000) knlGS:0000000000000000
[   65.960971] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   65.961283] CR2: 0000000000000000 CR3: 0000000008c40000 CR4: 0000000000750ef0
[   65.961664] PKRU: 55555554
[   65.961820] Kernel panic - not syncing: Fatal exception


Jan Kara (19):
  udf: New directory iteration code
  udf: Convert udf_expand_dir_adinicb() to new directory iteration
  udf: Move udf_expand_dir_adinicb() to its callsite
  udf: Implement searching for directory entry using new iteration code
  udf: Provide function to mark entry as deleted using new directory
    iteration code
  udf: Convert udf_rename() to new directory iteration code
  udf: Convert udf_readdir() to new directory iteration
  udf: Convert udf_lookup() to use new directory iteration code
  udf: Convert udf_get_parent() to new directory iteration code
  udf: Convert empty_dir() to new directory iteration code
  udf: Convert udf_rmdir() to new directory iteration code
  udf: Convert udf_unlink() to new directory iteration code
  udf: Implement adding of dir entries using new iteration code
  udf: Convert udf_add_nondir() to new directory iteration
  udf: Convert udf_mkdir() to new directory iteration code
  udf: Convert udf_link() to new directory iteration code
  udf: Remove old directory iteration code
  udf: Handle error when expanding directory
  udf: Don't return bh from udf_expand_dir_adinicb()

 fs/udf/dir.c       |  148 ++-----
 fs/udf/directory.c |  564 ++++++++++++++++++------
 fs/udf/inode.c     |   90 ----
 fs/udf/namei.c     | 1049 +++++++++++++++-----------------------------
 fs/udf/udfdecl.h   |   45 +-
 5 files changed, 823 insertions(+), 1073 deletions(-)

-- 
2.34.1


