Return-Path: <stable+bounces-26412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30624870E7B
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45803B284D1
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198EF7BB00;
	Mon,  4 Mar 2024 21:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PE33Poip"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0FA7992D;
	Mon,  4 Mar 2024 21:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588651; cv=none; b=Bz4XmLTLc6juVDno/tj3H0x0daRCYHx5KY8u0xJaky3/ecgVdviGbYajGpcevee8GsYFa2HzLgIPwxZzj97rk1tgp6l2t6pVeD1bYCF+uVfuP5i/RtKpjS0nHMXHgc0vilUS4HkjM66rno6+s4OIEg0LZmNElJFVCEFiXEMz5aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588651; c=relaxed/simple;
	bh=Ie5uOXasturKgJC02Rm7w91CL5BFRGgclKu9SBoCkM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRBgv4+96oUbATa1m1ga8Tfkewk7u2JLmalUQu+bylCiN/hbHKawlTRqNM23muI66GLocv3rZw3mEPZqp2PAMuhYYaqpeaIGvIJ2vwpKhjFW1jcN3ebQrF1uk/2qq9NmNAJVDBX4S9ojn8BoR+1gouOd5p8zAXmiLIgIYu52GeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PE33Poip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8D0C433C7;
	Mon,  4 Mar 2024 21:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588651;
	bh=Ie5uOXasturKgJC02Rm7w91CL5BFRGgclKu9SBoCkM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PE33Poipirx3Oc1pOut9Qqo7g2le6i2XSSIsavXKTogx+eqSw1nFJVTMDtMp8L71E
	 bZu0fVyHA4jUrzyfdmHhUsUYaFC0CvCjVa2AafRib91qBQ6ySVjaxJgpCIBKzuEFQ2
	 dA8rYdGYAsNVJ7dI5B166AMhsz9o9zU6YMKT2/L0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Edward Lo <edward.lo@ambergroup.io>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 021/215] fs/ntfs3: Add length check in indx_get_root
Date: Mon,  4 Mar 2024 21:21:24 +0000
Message-ID: <20240304211557.673541387@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211556.993132804@linuxfoundation.org>
References: <20240304211556.993132804@linuxfoundation.org>
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

[ Upstream commit 08e8cf5f2d9ec383a2e339a2711b62a54ff3fba0 ]

This adds a length check to guarantee the retrieved index root is legit.

[  162.459513] BUG: KASAN: use-after-free in hdr_find_e.isra.0+0x10c/0x320
[  162.460176] Read of size 2 at addr ffff8880037bca99 by task mount/243
[  162.460851]
[  162.461252] CPU: 0 PID: 243 Comm: mount Not tainted 6.0.0-rc7 #42
[  162.461744] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[  162.462609] Call Trace:
[  162.462954]  <TASK>
[  162.463276]  dump_stack_lvl+0x49/0x63
[  162.463822]  print_report.cold+0xf5/0x689
[  162.464608]  ? unwind_get_return_address+0x3a/0x60
[  162.465766]  ? hdr_find_e.isra.0+0x10c/0x320
[  162.466975]  kasan_report+0xa7/0x130
[  162.467506]  ? _raw_spin_lock_irq+0xc0/0xf0
[  162.467998]  ? hdr_find_e.isra.0+0x10c/0x320
[  162.468536]  __asan_load2+0x68/0x90
[  162.468923]  hdr_find_e.isra.0+0x10c/0x320
[  162.469282]  ? cmp_uints+0xe0/0xe0
[  162.469557]  ? cmp_sdh+0x90/0x90
[  162.469864]  ? ni_find_attr+0x214/0x300
[  162.470217]  ? ni_load_mi+0x80/0x80
[  162.470479]  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  162.470931]  ? ntfs_bread_run+0x190/0x190
[  162.471307]  ? indx_get_root+0xe4/0x190
[  162.471556]  ? indx_get_root+0x140/0x190
[  162.471833]  ? indx_init+0x1e0/0x1e0
[  162.472069]  ? fnd_clear+0x115/0x140
[  162.472363]  ? _raw_spin_lock_irqsave+0x100/0x100
[  162.472731]  indx_find+0x184/0x470
[  162.473461]  ? sysvec_apic_timer_interrupt+0x57/0xc0
[  162.474429]  ? indx_find_buffer+0x2d0/0x2d0
[  162.474704]  ? do_syscall_64+0x3b/0x90
[  162.474962]  dir_search_u+0x196/0x2f0
[  162.475381]  ? ntfs_nls_to_utf16+0x450/0x450
[  162.475661]  ? ntfs_security_init+0x3d6/0x440
[  162.475906]  ? is_sd_valid+0x180/0x180
[  162.476191]  ntfs_extend_init+0x13f/0x2c0
[  162.476496]  ? ntfs_fix_post_read+0x130/0x130
[  162.476861]  ? iput.part.0+0x286/0x320
[  162.477325]  ntfs_fill_super+0x11e0/0x1b50
[  162.477709]  ? put_ntfs+0x1d0/0x1d0
[  162.477970]  ? vsprintf+0x20/0x20
[  162.478258]  ? set_blocksize+0x95/0x150
[  162.478538]  get_tree_bdev+0x232/0x370
[  162.478789]  ? put_ntfs+0x1d0/0x1d0
[  162.479038]  ntfs_fs_get_tree+0x15/0x20
[  162.479374]  vfs_get_tree+0x4c/0x130
[  162.479729]  path_mount+0x654/0xfe0
[  162.480124]  ? putname+0x80/0xa0
[  162.480484]  ? finish_automount+0x2e0/0x2e0
[  162.480894]  ? putname+0x80/0xa0
[  162.481467]  ? kmem_cache_free+0x1c4/0x440
[  162.482280]  ? putname+0x80/0xa0
[  162.482714]  do_mount+0xd6/0xf0
[  162.483264]  ? path_mount+0xfe0/0xfe0
[  162.484782]  ? __kasan_check_write+0x14/0x20
[  162.485593]  __x64_sys_mount+0xca/0x110
[  162.486024]  do_syscall_64+0x3b/0x90
[  162.486543]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  162.487141] RIP: 0033:0x7f9d374e948a
[  162.488324] Code: 48 8b 0d 11 fa 2a 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 008
[  162.489728] RSP: 002b:00007ffe30e73d18 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
[  162.490971] RAX: ffffffffffffffda RBX: 0000561cdb43a060 RCX: 00007f9d374e948a
[  162.491669] RDX: 0000561cdb43a260 RSI: 0000561cdb43a2e0 RDI: 0000561cdb442af0
[  162.492050] RBP: 0000000000000000 R08: 0000561cdb43a280 R09: 0000000000000020
[  162.492459] R10: 00000000c0ed0000 R11: 0000000000000206 R12: 0000561cdb442af0
[  162.493183] R13: 0000561cdb43a260 R14: 0000000000000000 R15: 00000000ffffffff
[  162.493644]  </TASK>
[  162.493908]
[  162.494214] The buggy address belongs to the physical page:
[  162.494761] page:000000003e38a3d5 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x37bc
[  162.496064] flags: 0xfffffc0000000(node=0|zone=1|lastcpupid=0x1fffff)
[  162.497278] raw: 000fffffc0000000 ffffea00000df1c8 ffffea00000df008 0000000000000000
[  162.498928] raw: 0000000000000000 0000000000240000 00000000ffffffff 0000000000000000
[  162.500542] page dumped because: kasan: bad access detected
[  162.501057]
[  162.501242] Memory state around the buggy address:
[  162.502230]  ffff8880037bc980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  162.502977]  ffff8880037bca00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  162.503522] >ffff8880037bca80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  162.503963]                             ^
[  162.504370]  ffff8880037bcb00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  162.504766]  ffff8880037bcb80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Signed-off-by: Edward Lo <edward.lo@ambergroup.io>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/index.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 7371f7855e4c4..eee01db6e0cc5 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -998,6 +998,7 @@ struct INDEX_ROOT *indx_get_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 	struct ATTR_LIST_ENTRY *le = NULL;
 	struct ATTRIB *a;
 	const struct INDEX_NAMES *in = &s_index_names[indx->type];
+	struct INDEX_ROOT *root = NULL;
 
 	a = ni_find_attr(ni, NULL, &le, ATTR_ROOT, in->name, in->name_len, NULL,
 			 mi);
@@ -1007,7 +1008,15 @@ struct INDEX_ROOT *indx_get_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 	if (attr)
 		*attr = a;
 
-	return resident_data_ex(a, sizeof(struct INDEX_ROOT));
+	root = resident_data_ex(a, sizeof(struct INDEX_ROOT));
+
+	/* length check */
+	if (root && offsetof(struct INDEX_ROOT, ihdr) + le32_to_cpu(root->ihdr.used) >
+			le32_to_cpu(a->res.data_size)) {
+		return NULL;
+	}
+
+	return root;
 }
 
 static int indx_write(struct ntfs_index *indx, struct ntfs_inode *ni,
-- 
2.43.0




