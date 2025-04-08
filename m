Return-Path: <stable+bounces-130165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86171A8031A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38192188B1CE
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00322690EC;
	Tue,  8 Apr 2025 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XgS7vynZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584142690CC;
	Tue,  8 Apr 2025 11:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112991; cv=none; b=brltYzAg42sTidn68CWzo4S7FZyvwTVLCU9Du3EljURLw8C2ES93unIqyYAcUx45vve5AoyBqGkonTKQ9/6JRO/xxegTOck1/AuK2VO7KaICXCjC4dkmGLDIfyLkhbsT7d9PqLf6jtpQqQOXQxVDn9BItyjCMbfCH9lkqNLVkGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112991; c=relaxed/simple;
	bh=TQiBCRnilEAahdx3q+6rWHzBXxPiVB/mHNHRGjVWVb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSxHFnwZik8fukIu+J1tkL8GyVoVWao6jiUoKI4ktrLMZGN5Kx+iZAGJtYlsR4IbnNAF2q1MyCV8sQttPbeO7lbqUT4D3JwxrRsu9QKmxI7l+2mTccnV1ZvqDEzcYPJTQ76zFo0/2yDG4fJwQU7KSgA+bjvp2py1GtZNTM2YnEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XgS7vynZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63452C4CEEA;
	Tue,  8 Apr 2025 11:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744112990;
	bh=TQiBCRnilEAahdx3q+6rWHzBXxPiVB/mHNHRGjVWVb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XgS7vynZ16ebAvIYkYh918T2DroRtSLeDfhHwu40W9rCIFdo63Ohnv7/XT86KTapw
	 y/BA6J21Ml5AGM2deRReAdPGCCgGfFoJCMRoYBIN7kJA/RrOSS11zahfkMR/GCfcne
	 uzJC1Z9riIrGRk0GwCOwlPB2aJ24ABiNyLTAyeOk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Acs <acsjakub@amazon.de>,
	Theodore Tso <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mahmoud Adam <mngyadam@amazon.com>,
	security@kernel.org
Subject: [PATCH 5.15 273/279] ext4: fix OOB read when checking dotdot dir
Date: Tue,  8 Apr 2025 12:50:56 +0200
Message-ID: <20250408104833.762857969@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104826.319283234@linuxfoundation.org>
References: <20250408104826.319283234@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Acs, Jakub <acsjakub@amazon.de>

commit d5e206778e96e8667d3bde695ad372c296dc9353 upstream.

Mounting a corrupted filesystem with directory which contains '.' dir
entry with rec_len == block size results in out-of-bounds read (later
on, when the corrupted directory is removed).

ext4_empty_dir() assumes every ext4 directory contains at least '.'
and '..' as directory entries in the first data block. It first loads
the '.' dir entry, performs sanity checks by calling ext4_check_dir_entry()
and then uses its rec_len member to compute the location of '..' dir
entry (in ext4_next_entry). It assumes the '..' dir entry fits into the
same data block.

If the rec_len of '.' is precisely one block (4KB), it slips through the
sanity checks (it is considered the last directory entry in the data
block) and leaves "struct ext4_dir_entry_2 *de" point exactly past the
memory slot allocated to the data block. The following call to
ext4_check_dir_entry() on new value of de then dereferences this pointer
which results in out-of-bounds mem access.

Fix this by extending __ext4_check_dir_entry() to check for '.' dir
entries that reach the end of data block. Make sure to ignore the phony
dir entries for checksum (by checking name_len for non-zero).

Note: This is reported by KASAN as use-after-free in case another
structure was recently freed from the slot past the bound, but it is
really an OOB read.

This issue was found by syzkaller tool.

Call Trace:
[   38.594108] BUG: KASAN: slab-use-after-free in __ext4_check_dir_entry+0x67e/0x710
[   38.594649] Read of size 2 at addr ffff88802b41a004 by task syz-executor/5375
[   38.595158]
[   38.595288] CPU: 0 UID: 0 PID: 5375 Comm: syz-executor Not tainted 6.14.0-rc7 #1
[   38.595298] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   38.595304] Call Trace:
[   38.595308]  <TASK>
[   38.595311]  dump_stack_lvl+0xa7/0xd0
[   38.595325]  print_address_description.constprop.0+0x2c/0x3f0
[   38.595339]  ? __ext4_check_dir_entry+0x67e/0x710
[   38.595349]  print_report+0xaa/0x250
[   38.595359]  ? __ext4_check_dir_entry+0x67e/0x710
[   38.595368]  ? kasan_addr_to_slab+0x9/0x90
[   38.595378]  kasan_report+0xab/0xe0
[   38.595389]  ? __ext4_check_dir_entry+0x67e/0x710
[   38.595400]  __ext4_check_dir_entry+0x67e/0x710
[   38.595410]  ext4_empty_dir+0x465/0x990
[   38.595421]  ? __pfx_ext4_empty_dir+0x10/0x10
[   38.595432]  ext4_rmdir.part.0+0x29a/0xd10
[   38.595441]  ? __dquot_initialize+0x2a7/0xbf0
[   38.595455]  ? __pfx_ext4_rmdir.part.0+0x10/0x10
[   38.595464]  ? __pfx___dquot_initialize+0x10/0x10
[   38.595478]  ? down_write+0xdb/0x140
[   38.595487]  ? __pfx_down_write+0x10/0x10
[   38.595497]  ext4_rmdir+0xee/0x140
[   38.595506]  vfs_rmdir+0x209/0x670
[   38.595517]  ? lookup_one_qstr_excl+0x3b/0x190
[   38.595529]  do_rmdir+0x363/0x3c0
[   38.595537]  ? __pfx_do_rmdir+0x10/0x10
[   38.595544]  ? strncpy_from_user+0x1ff/0x2e0
[   38.595561]  __x64_sys_unlinkat+0xf0/0x130
[   38.595570]  do_syscall_64+0x5b/0x180
[   38.595583]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: ac27a0ec112a0 ("[PATCH] ext4: initial copy of files from ext3")
Signed-off-by: Jakub Acs <acsjakub@amazon.de>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Mahmoud Adam <mngyadam@amazon.com>
Cc: stable@vger.kernel.org
Cc: security@kernel.org
Link: https://patch.msgid.link/b3ae36a6794c4a01944c7d70b403db5b@amazon.de
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/dir.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -104,6 +104,9 @@ int __ext4_check_dir_entry(const char *f
 	else if (unlikely(le32_to_cpu(de->inode) >
 			le32_to_cpu(EXT4_SB(dir->i_sb)->s_es->s_inodes_count)))
 		error_msg = "inode out of bounds";
+	else if (unlikely(next_offset == size && de->name_len == 1 &&
+			  de->name[0] == '.'))
+		error_msg = "'.' directory cannot be the last in data block";
 	else
 		return 0;
 



