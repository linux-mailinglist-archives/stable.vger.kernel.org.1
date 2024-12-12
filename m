Return-Path: <stable+bounces-103598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D22E9EF88E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C711D189A92E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B96222D68;
	Thu, 12 Dec 2024 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uNJOkpsC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3532E216E2D;
	Thu, 12 Dec 2024 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025048; cv=none; b=uQu4biKBdWNbY2ze418dK7YnRE4HKLYrahn7BTI8+OxGYrWkRPAe/SF+Ora2XpXCxJOefqD8tSWyDXIttW/WTrwO8BI2JnMw176PeyTcrdzgF+MhCOz0A/sW3mOjZLi5qfc+1Bh/agXab7x2dwnjvswQxnXuEI3UPnmxyBmX86c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025048; c=relaxed/simple;
	bh=hAPjrmjvEt3NaN1IVFdXuon2QG6sO8sWyiK7YgODmIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzBOm8lgIThHIRt5J256Tewz9xSboKtuCRi2vhpMpfboD0Oym4wCd5k8SxGrZ3dZXizBbMnFxrTTKwOIQTqvd/baQNb1OlFZw61Cy+yz8GJ+RIWrxQyswWr7p8gXHebewj8xxszXJigNze9p30nUZxNlnL63TEnxUTy9CLgmDHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uNJOkpsC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C44C4CECE;
	Thu, 12 Dec 2024 17:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734025048;
	bh=hAPjrmjvEt3NaN1IVFdXuon2QG6sO8sWyiK7YgODmIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uNJOkpsCaVCOgM2OL+O+PNgfsV5oWF25kOJpy3KycqoOP9iO/iIBW6vBfZtUN1zDT
	 Vz3S4FxL4JZPy35M8byMH+fBlQNutaR2G6uyEATtAnSEfAqXJSBIsodK3F3NGTS6CR
	 LffcQPc2m2+nVUWFrftnBAXwIaJHc1k42q3VOBrk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 037/321] hfsplus: dont query the device logical block size multiple times
Date: Thu, 12 Dec 2024 15:59:15 +0100
Message-ID: <20241212144231.466633956@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144229.291682835@linuxfoundation.org>
References: <20241212144229.291682835@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

[ Upstream commit 1c82587cb57687de3f18ab4b98a8850c789bedcf ]

Devices block sizes may change. One of these cases is a loop device by
using ioctl LOOP_SET_BLOCK_SIZE.

While this may cause other issues like IO being rejected, in the case of
hfsplus, it will allocate a block by using that size and potentially write
out-of-bounds when hfsplus_read_wrapper calls hfsplus_submit_bio and the
latter function reads a different io_size.

Using a new min_io_size initally set to sb_min_blocksize works for the
purposes of the original fix, since it will be set to the max between
HFSPLUS_SECTOR_SIZE and the first seen logical block size. We still use the
max between HFSPLUS_SECTOR_SIZE and min_io_size in case the latter is not
initialized.

Tested by mounting an hfsplus filesystem with loop block sizes 512, 1024
and 4096.

The produced KASAN report before the fix looks like this:

[  419.944641] ==================================================================
[  419.945655] BUG: KASAN: slab-use-after-free in hfsplus_read_wrapper+0x659/0xa0a
[  419.946703] Read of size 2 at addr ffff88800721fc00 by task repro/10678
[  419.947612]
[  419.947846] CPU: 0 UID: 0 PID: 10678 Comm: repro Not tainted 6.12.0-rc5-00008-gdf56e0f2f3ca #84
[  419.949007] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
[  419.950035] Call Trace:
[  419.950384]  <TASK>
[  419.950676]  dump_stack_lvl+0x57/0x78
[  419.951212]  ? hfsplus_read_wrapper+0x659/0xa0a
[  419.951830]  print_report+0x14c/0x49e
[  419.952361]  ? __virt_addr_valid+0x267/0x278
[  419.952979]  ? kmem_cache_debug_flags+0xc/0x1d
[  419.953561]  ? hfsplus_read_wrapper+0x659/0xa0a
[  419.954231]  kasan_report+0x89/0xb0
[  419.954748]  ? hfsplus_read_wrapper+0x659/0xa0a
[  419.955367]  hfsplus_read_wrapper+0x659/0xa0a
[  419.955948]  ? __pfx_hfsplus_read_wrapper+0x10/0x10
[  419.956618]  ? do_raw_spin_unlock+0x59/0x1a9
[  419.957214]  ? _raw_spin_unlock+0x1a/0x2e
[  419.957772]  hfsplus_fill_super+0x348/0x1590
[  419.958355]  ? hlock_class+0x4c/0x109
[  419.958867]  ? __pfx_hfsplus_fill_super+0x10/0x10
[  419.959499]  ? __pfx_string+0x10/0x10
[  419.960006]  ? lock_acquire+0x3e2/0x454
[  419.960532]  ? bdev_name.constprop.0+0xce/0x243
[  419.961129]  ? __pfx_bdev_name.constprop.0+0x10/0x10
[  419.961799]  ? pointer+0x3f0/0x62f
[  419.962277]  ? __pfx_pointer+0x10/0x10
[  419.962761]  ? vsnprintf+0x6c4/0xfba
[  419.963178]  ? __pfx_vsnprintf+0x10/0x10
[  419.963621]  ? setup_bdev_super+0x376/0x3b3
[  419.964029]  ? snprintf+0x9d/0xd2
[  419.964344]  ? __pfx_snprintf+0x10/0x10
[  419.964675]  ? lock_acquired+0x45c/0x5e9
[  419.965016]  ? set_blocksize+0x139/0x1c1
[  419.965381]  ? sb_set_blocksize+0x6d/0xae
[  419.965742]  ? __pfx_hfsplus_fill_super+0x10/0x10
[  419.966179]  mount_bdev+0x12f/0x1bf
[  419.966512]  ? __pfx_mount_bdev+0x10/0x10
[  419.966886]  ? vfs_parse_fs_string+0xce/0x111
[  419.967293]  ? __pfx_vfs_parse_fs_string+0x10/0x10
[  419.967702]  ? __pfx_hfsplus_mount+0x10/0x10
[  419.968073]  legacy_get_tree+0x104/0x178
[  419.968414]  vfs_get_tree+0x86/0x296
[  419.968751]  path_mount+0xba3/0xd0b
[  419.969157]  ? __pfx_path_mount+0x10/0x10
[  419.969594]  ? kmem_cache_free+0x1e2/0x260
[  419.970311]  do_mount+0x99/0xe0
[  419.970630]  ? __pfx_do_mount+0x10/0x10
[  419.971008]  __do_sys_mount+0x199/0x1c9
[  419.971397]  do_syscall_64+0xd0/0x135
[  419.971761]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  419.972233] RIP: 0033:0x7c3cb812972e
[  419.972564] Code: 48 8b 0d f5 46 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c2 46 0d 00 f7 d8 64 89 01 48
[  419.974371] RSP: 002b:00007ffe30632548 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
[  419.975048] RAX: ffffffffffffffda RBX: 00007ffe306328d8 RCX: 00007c3cb812972e
[  419.975701] RDX: 0000000020000000 RSI: 0000000020000c80 RDI: 00007ffe306325d0
[  419.976363] RBP: 00007ffe30632720 R08: 00007ffe30632610 R09: 0000000000000000
[  419.977034] R10: 0000000000200008 R11: 0000000000000286 R12: 0000000000000000
[  419.977713] R13: 00007ffe306328e8 R14: 00005a0eb298bc68 R15: 00007c3cb8356000
[  419.978375]  </TASK>
[  419.978589]

Fixes: 6596528e391a ("hfsplus: ensure bio requests are not smaller than the hardware sectors")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Link: https://lore.kernel.org/r/20241107114109.839253-1-cascardo@igalia.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfsplus/hfsplus_fs.h | 3 ++-
 fs/hfsplus/wrapper.c    | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 909e03956c3f2..86cfc147bf3d1 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -156,6 +156,7 @@ struct hfsplus_sb_info {
 
 	/* Runtime variables */
 	u32 blockoffset;
+	u32 min_io_size;
 	sector_t part_start;
 	sector_t sect_count;
 	int fs_shift;
@@ -306,7 +307,7 @@ struct hfsplus_readdir_data {
  */
 static inline unsigned short hfsplus_min_io_size(struct super_block *sb)
 {
-	return max_t(unsigned short, bdev_logical_block_size(sb->s_bdev),
+	return max_t(unsigned short, HFSPLUS_SB(sb)->min_io_size,
 		     HFSPLUS_SECTOR_SIZE);
 }
 
diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
index 08c1580bdf7ad..eb76ba8e8fec0 100644
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -170,6 +170,8 @@ int hfsplus_read_wrapper(struct super_block *sb)
 	if (!blocksize)
 		goto out;
 
+	sbi->min_io_size = blocksize;
+
 	if (hfsplus_get_last_session(sb, &part_start, &part_size))
 		goto out;
 
-- 
2.43.0




