Return-Path: <stable+bounces-92938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FC69C78ED
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 17:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41CF1F21EFE
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 16:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5777314AD17;
	Wed, 13 Nov 2024 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KlO6blfZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UD6JcsaI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KlO6blfZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UD6JcsaI"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B189146588
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731515500; cv=none; b=FlqgXGmv3sPfmzRBBYQBWQuekr0gNKCBm0y7eIL+fpn6N9138dlTX104+a/prrYFCo+56JGrkgDd+Da1gIpvgA7MvSAKBrF9UcUV0ImwdqgaZazl4JFT53LNl23yxdyA5Y+FtGPkYuFVwiQXpFM8daHeyYfiqe8lJKyzwvupoiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731515500; c=relaxed/simple;
	bh=w+ZNHFUWmQJYZRGfnNPDiV64hqM9Ffj5DbJM/7DEenw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aPak/rVRwWv1q0hGKdghyasty38tpCwHwabQJY9X6joMnLcmK4hSOSnULYltDMnfKJJlZLDKtqvADd12+V9ylUgoltBPd/gFnd/kCXR5FySQzdWoVr3gX5IAvarK2NS1E5pm66v86XBz2FrbEx+bBWLswVu3Ust6HpKzefWcds0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KlO6blfZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UD6JcsaI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KlO6blfZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UD6JcsaI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6B3131F38C;
	Wed, 13 Nov 2024 16:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731515496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UJ9p2hM3bZfX2o8ZGBOr5efbxsYAS1Sgn1cJzwQSjzs=;
	b=KlO6blfZb21ASHjpfopdKFbePe3nb5C7A7CnLwpegbDbQy4feysezIJlCjFNVCjQimT31C
	bEO3ki0LemWJBNBG8XYWYWQaZtQuzQnyMv7yKkSa6C+vFeJiPK/vZpmbK5v15yim9rCUs7
	vKRhq662Sg5ymI81fHxA0uk849bRtZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731515496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UJ9p2hM3bZfX2o8ZGBOr5efbxsYAS1Sgn1cJzwQSjzs=;
	b=UD6JcsaI7Yv0fHQHq/Ur/M23hBWX7292bkgIjYij5NC+68l1i8jDrnPL32SqsAcFSsBkBN
	bv5UYbRNAfDzRSBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KlO6blfZ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UD6JcsaI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731515496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UJ9p2hM3bZfX2o8ZGBOr5efbxsYAS1Sgn1cJzwQSjzs=;
	b=KlO6blfZb21ASHjpfopdKFbePe3nb5C7A7CnLwpegbDbQy4feysezIJlCjFNVCjQimT31C
	bEO3ki0LemWJBNBG8XYWYWQaZtQuzQnyMv7yKkSa6C+vFeJiPK/vZpmbK5v15yim9rCUs7
	vKRhq662Sg5ymI81fHxA0uk849bRtZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731515496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UJ9p2hM3bZfX2o8ZGBOr5efbxsYAS1Sgn1cJzwQSjzs=;
	b=UD6JcsaI7Yv0fHQHq/Ur/M23hBWX7292bkgIjYij5NC+68l1i8jDrnPL32SqsAcFSsBkBN
	bv5UYbRNAfDzRSBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50CC313A6E;
	Wed, 13 Nov 2024 16:31:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i2FpE2jUNGdfNQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 13 Nov 2024 16:31:36 +0000
From: Vlastimil Babka <vbabka@suse.cz>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	linux-mm@kvack.org,
	Yuanzheng Song <songyuanzheng@huawei.com>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH stable 5.15] mm/memory: add non-anonymous page check in the copy_present_page()
Date: Wed, 13 Nov 2024 17:31:19 +0100
Message-ID: <20241113163118.54834-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6B3131F38C
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

From: Yuanzheng Song <songyuanzheng@huawei.com>

The vma->anon_vma of the child process may be NULL because
the entire vma does not contain anonymous pages. In this
case, a BUG will occur when the copy_present_page() passes
a copy of a non-anonymous page of that vma to the
page_add_new_anon_rmap() to set up new anonymous rmap.

------------[ cut here ]------------
kernel BUG at mm/rmap.c:1052!
Internal error: Oops - BUG: 0 [#1] SMP
Modules linked in:
CPU: 4 PID: 4652 Comm: test Not tainted 5.15.75 #1
Hardware name: linux,dummy-virt (DT)
pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __page_set_anon_rmap+0xc0/0xe8
lr : __page_set_anon_rmap+0xc0/0xe8
sp : ffff80000e773860
x29: ffff80000e773860 x28: fffffc13cf006ec0 x27: ffff04f3ccd68000
x26: ffff04f3c5c33248 x25: 0000000010100073 x24: ffff04f3c53c0a80
x23: 0000000020000000 x22: 0000000000000001 x21: 0000000020000000
x20: fffffc13cf006ec0 x19: 0000000000000000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : ffffdddc5581377c
x8 : 0000000000000000 x7 : 0000000000000011 x6 : ffff2717a8433000
x5 : ffff80000e773810 x4 : ffffdddc55400000 x3 : 0000000000000000
x2 : ffffdddc56b20000 x1 : ffff04f3c9a48040 x0 : 0000000000000000
Call trace:
 __page_set_anon_rmap+0xc0/0xe8
 page_add_new_anon_rmap+0x13c/0x200
 copy_pte_range+0x6b8/0x1018
 copy_page_range+0x3a8/0x5e0
 dup_mmap+0x3a0/0x6e8
 dup_mm+0x78/0x140
 copy_process+0x1528/0x1b08
 kernel_clone+0xac/0x610
 __do_sys_clone+0x78/0xb0
 __arm64_sys_clone+0x30/0x40
 invoke_syscall+0x68/0x170
 el0_svc_common.constprop.0+0x80/0x250
 do_el0_svc+0x48/0xb8
 el0_svc+0x48/0x1a8
 el0t_64_sync_handler+0xb0/0xb8
 el0t_64_sync+0x1a0/0x1a4
Code: 97f899f4 f9400273 17ffffeb 97f899f1 (d4210000)
---[ end trace dc65e5edd0f362fa ]---
Kernel panic - not syncing: Oops - BUG: Fatal exception
SMP: stopping secondary CPUs
Kernel Offset: 0x5ddc4d400000 from 0xffff800008000000
PHYS_OFFSET: 0xfffffb0c80000000
CPU features: 0x44000cf1,00000806
Memory Limit: none
---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]---

This problem has been fixed by the commit <fb3d824d1a46>
("mm/rmap: split page_dup_rmap() into page_dup_file_rmap()
and page_try_dup_anon_rmap()"), but still exists in the
linux-5.15.y branch.

This patch is not applicable to this version because
of the large version differences. Therefore, fix it by
adding non-anonymous page check in the copy_present_page().

Cc: stable@vger.kernel.org
Fixes: 70e806e4e645 ("mm: Do early cow for pinned pages during fork() for ptes")
Signed-off-by: Yuanzheng Song <songyuanzheng@huawei.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Hi, this was posted in [1] but seems stable@ was not actually included
in the recipients.
The 5.10 version [2] was applied as 935a8b62021 but 5.15 is missing.

[1] https://lore.kernel.org/all/20221028075244.3112566-1-songyuanzheng@huawei.com/T/#u
[2] https://lore.kernel.org/all/20221028030705.2840539-1-songyuanzheng@huawei.com/


 mm/memory.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 6d058973a97e..4785aecca9a8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -903,6 +903,17 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	if (likely(!page_needs_cow_for_dma(src_vma, page)))
 		return 1;
 
+	/*
+	 * The vma->anon_vma of the child process may be NULL
+	 * because the entire vma does not contain anonymous pages.
+	 * A BUG will occur when the copy_present_page() passes
+	 * a copy of a non-anonymous page of that vma to the
+	 * page_add_new_anon_rmap() to set up new anonymous rmap.
+	 * Return 1 if the page is not an anonymous page.
+	 */
+	if (!PageAnon(page))
+		return 1;
+
 	new_page = *prealloc;
 	if (!new_page)
 		return -EAGAIN;
-- 
2.47.0


