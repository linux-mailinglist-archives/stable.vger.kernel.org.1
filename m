Return-Path: <stable+bounces-25044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C99B869794
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45E87B2C58A
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC58E1420D3;
	Tue, 27 Feb 2024 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H8wAyvAk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A50C13B2B8;
	Tue, 27 Feb 2024 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043699; cv=none; b=ln9ViN1LnkiTnySV8xSBeK+8JabwSiyFUgcThjnN7CnbCQ0Mvq4K/L8GMIJmi2xfn4lFxTrrnVBFAPP86011jzk6iiF8qRYJcqxYeJATCXpTjajOFw/Lou+PW9aeacIJ87GCiznNuhcPIfmJwfDSnulkVqOwer8kAhQlxTobjpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043699; c=relaxed/simple;
	bh=9VHb/aRgjJlJXIEfNJK/srAJuQ3Ci6fzvp2NUvAOr30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEaPPHrM1XvRLUsy2bhQRRE4qZwpUCh7wqaeXGxjGQbZZcJFbzzcv5bbUWsKPQWx03lVRK19+mw3GKv8/gO89EED7KejCXdEx6TmqsQJqZlasbc95dByc7gTXCOQK2ppQGSFAoRnfCXaHdPU/L9VlLlie93c6Ow15KQFEG8ynFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H8wAyvAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14689C433F1;
	Tue, 27 Feb 2024 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709043699;
	bh=9VHb/aRgjJlJXIEfNJK/srAJuQ3Ci6fzvp2NUvAOr30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H8wAyvAkWIguoJbt4f5WRLvKT/mpDvH0Ng6LW1MBDkncweJ3Zf9jdIVcv/DMLSgIE
	 Bp7b+7XP8GlJUrvIAOVmSo/o9JQn7Qgc3V6+dDljeozzOz1glOj5SMflSurrYzBW2z
	 FkcoNQML0ybQditd95KjSHdbhGIP3muC9149kiDU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Edward Lo <edward.lo@ambergroup.io>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	"Doebel, Bjoern" <doebel@amazon.de>
Subject: [PATCH 6.1 195/195] fs/ntfs3: Enhance the attribute size check
Date: Tue, 27 Feb 2024 14:27:36 +0100
Message-ID: <20240227131616.840371189@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131610.391465389@linuxfoundation.org>
References: <20240227131610.391465389@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edward Lo <edward.lo@ambergroup.io>

commit 4f082a7531223a438c757bb20e304f4c941c67a8 upstream.

This combines the overflow and boundary check so that all attribute size
will be properly examined while enumerating them.

[  169.181521] BUG: KASAN: slab-out-of-bounds in run_unpack+0x2e3/0x570
[  169.183161] Read of size 1 at addr ffff8880094b6240 by task mount/247
[  169.184046]
[  169.184925] CPU: 0 PID: 247 Comm: mount Not tainted 6.0.0-rc7+ #3
[  169.185908] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[  169.187066] Call Trace:
[  169.187492]  <TASK>
[  169.188049]  dump_stack_lvl+0x49/0x63
[  169.188495]  print_report.cold+0xf5/0x689
[  169.188964]  ? run_unpack+0x2e3/0x570
[  169.189331]  kasan_report+0xa7/0x130
[  169.189714]  ? run_unpack+0x2e3/0x570
[  169.190079]  __asan_load1+0x51/0x60
[  169.190634]  run_unpack+0x2e3/0x570
[  169.191290]  ? run_pack+0x840/0x840
[  169.191569]  ? run_lookup_entry+0xb3/0x1f0
[  169.192443]  ? mi_enum_attr+0x20a/0x230
[  169.192886]  run_unpack_ex+0xad/0x3e0
[  169.193276]  ? run_unpack+0x570/0x570
[  169.193557]  ? ni_load_mi+0x80/0x80
[  169.193889]  ? debug_smp_processor_id+0x17/0x20
[  169.194236]  ? mi_init+0x4a/0x70
[  169.194496]  attr_load_runs_vcn+0x166/0x1c0
[  169.194851]  ? attr_data_write_resident+0x250/0x250
[  169.195188]  mi_read+0x133/0x2c0
[  169.195481]  ntfs_iget5+0x277/0x1780
[  169.196017]  ? call_rcu+0x1c7/0x330
[  169.196392]  ? ntfs_get_block_bmap+0x70/0x70
[  169.196708]  ? evict+0x223/0x280
[  169.197014]  ? __kmalloc+0x33/0x540
[  169.197305]  ? wnd_init+0x15b/0x1b0
[  169.197599]  ntfs_fill_super+0x1026/0x1ba0
[  169.197994]  ? put_ntfs+0x1d0/0x1d0
[  169.198299]  ? vsprintf+0x20/0x20
[  169.198583]  ? mutex_unlock+0x81/0xd0
[  169.198930]  ? set_blocksize+0x95/0x150
[  169.199269]  get_tree_bdev+0x232/0x370
[  169.199750]  ? put_ntfs+0x1d0/0x1d0
[  169.200094]  ntfs_fs_get_tree+0x15/0x20
[  169.200431]  vfs_get_tree+0x4c/0x130
[  169.200714]  path_mount+0x654/0xfe0
[  169.201067]  ? putname+0x80/0xa0
[  169.201358]  ? finish_automount+0x2e0/0x2e0
[  169.201965]  ? putname+0x80/0xa0
[  169.202445]  ? kmem_cache_free+0x1c4/0x440
[  169.203075]  ? putname+0x80/0xa0
[  169.203414]  do_mount+0xd6/0xf0
[  169.203719]  ? path_mount+0xfe0/0xfe0
[  169.203977]  ? __kasan_check_write+0x14/0x20
[  169.204382]  __x64_sys_mount+0xca/0x110
[  169.204711]  do_syscall_64+0x3b/0x90
[  169.205059]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  169.205571] RIP: 0033:0x7f67a80e948a
[  169.206327] Code: 48 8b 0d 11 fa 2a 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 008
[  169.208296] RSP: 002b:00007ffddf020f58 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
[  169.209253] RAX: ffffffffffffffda RBX: 000055e2547a6060 RCX: 00007f67a80e948a
[  169.209777] RDX: 000055e2547a6260 RSI: 000055e2547a62e0 RDI: 000055e2547aeaf0
[  169.210342] RBP: 0000000000000000 R08: 000055e2547a6280 R09: 0000000000000020
[  169.210843] R10: 00000000c0ed0000 R11: 0000000000000202 R12: 000055e2547aeaf0
[  169.211307] R13: 000055e2547a6260 R14: 0000000000000000 R15: 00000000ffffffff
[  169.211913]  </TASK>
[  169.212304]
[  169.212680] Allocated by task 0:
[  169.212963] (stack is not available)
[  169.213200]
[  169.213472] The buggy address belongs to the object at ffff8880094b5e00
[  169.213472]  which belongs to the cache UDP of size 1152
[  169.214095] The buggy address is located 1088 bytes inside of
[  169.214095]  1152-byte region [ffff8880094b5e00, ffff8880094b6280)
[  169.214639]
[  169.215004] The buggy address belongs to the physical page:
[  169.215766] page:000000002e324c8c refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x94b4
[  169.218412] head:000000002e324c8c order:2 compound_mapcount:0 compound_pincount:0
[  169.219078] flags: 0xfffffc0010200(slab|head|node=0|zone=1|lastcpupid=0x1fffff)
[  169.220272] raw: 000fffffc0010200 0000000000000000 dead000000000122 ffff888002409b40
[  169.221006] raw: 0000000000000000 00000000800c000c 00000001ffffffff 0000000000000000
[  169.222320] page dumped because: kasan: bad access detected
[  169.222922]
[  169.223119] Memory state around the buggy address:
[  169.224056]  ffff8880094b6100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  169.224908]  ffff8880094b6180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  169.225677] >ffff8880094b6200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  169.226445]                                            ^
[  169.227055]  ffff8880094b6280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  169.227638]  ffff8880094b6300: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

Signed-off-by: Edward Lo <edward.lo@ambergroup.io>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Doebel, Bjoern" <doebel@amazon.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ntfs3/record.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -226,11 +226,6 @@ struct ATTRIB *mi_enum_attr(struct mft_i
 			return NULL;
 		}
 
-		if (off + asize < off) {
-			/* overflow check */
-			return NULL;
-		}
-
 		attr = Add2Ptr(attr, asize);
 		off += asize;
 	}
@@ -253,8 +248,8 @@ struct ATTRIB *mi_enum_attr(struct mft_i
 	if ((t32 & 0xf) || (t32 > 0x100))
 		return NULL;
 
-	/* Check boundary. */
-	if (off + asize > used)
+	/* Check overflow and boundary. */
+	if (off + asize < off || off + asize > used)
 		return NULL;
 
 	/* Check size of attribute. */



