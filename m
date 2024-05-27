Return-Path: <stable+bounces-47135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EC58D0CBD
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD6B1F22C25
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63311607A4;
	Mon, 27 May 2024 19:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sAugZYUe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73964160796;
	Mon, 27 May 2024 19:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716837760; cv=none; b=ci8Gb+bInpWvlb+jluHvU9qoGzGmpL+cwQYDO12iWFQruxywZsoA/xdS1jZD+/vkkxII/DAMiqT1II3ipZ63I7gKJqXHWSVSTNn8JOfp2l3HE/6U2+QpiA47hVDizH1dtoBRM6EA8iA95uxFYkwDDJ+zs+36M2VIatFlSbleKMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716837760; c=relaxed/simple;
	bh=LQp0iTyONFdMBRlTd2srQ6rjg8sCeDEFN3tcKoNz/6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=he0Ylbo5VVCMDYAFJdTVH1Eufm6K8rTITMdCvP835PS9RWMxLdAyivRRXHQ+5DXg9xPvSlqCQivxH6gq0go0nGKYDvVvCZXcesdhiTwCf/vRfWzMfIWA79dmF+umpbp3x6GGteruRtc/cCIxwVIkt3ldbl7Yq7U8WJkacUriKSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sAugZYUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E16CC2BBFC;
	Mon, 27 May 2024 19:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716837760;
	bh=LQp0iTyONFdMBRlTd2srQ6rjg8sCeDEFN3tcKoNz/6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sAugZYUeofBbMIb1vW/bZSxKpY6kJylhkh1zi7v0rFFg6S9qgmlRMd7E5z+MTcHUG
	 NxOnO1MIFK7HIUXWnbU9Owsdkh2JVRB3RsG63z52cj8qUEV7t03+yYkjUDA9ZAe+gf
	 TZee/FEEdpioGY3xLo18uLMO3bXfJp2NbZVkPd7g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilya Denisyev <dev@elkcl.ru>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 127/493] jffs2: prevent xattr node from overflowing the eraseblock
Date: Mon, 27 May 2024 20:52:09 +0200
Message-ID: <20240527185634.647168080@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
References: <20240527185626.546110716@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Denisyev <dev@elkcl.ru>

[ Upstream commit c6854e5a267c28300ff045480b5a7ee7f6f1d913 ]

Add a check to make sure that the requested xattr node size is no larger
than the eraseblock minus the cleanmarker.

Unlike the usual inode nodes, the xattr nodes aren't split into parts
and spread across multiple eraseblocks, which means that a xattr node
must not occupy more than one eraseblock. If the requested xattr value is
too large, the xattr node can spill onto the next eraseblock, overwriting
the nodes and causing errors such as:

jffs2: argh. node added in wrong place at 0x0000b050(2)
jffs2: nextblock 0x0000a000, expected at 0000b00c
jffs2: error: (823) do_verify_xattr_datum: node CRC failed at 0x01e050,
read=0xfc892c93, calc=0x000000
jffs2: notice: (823) jffs2_get_inode_nodes: Node header CRC failed
at 0x01e00c. {848f,2fc4,0fef511f,59a3d171}
jffs2: Node at 0x0000000c with length 0x00001044 would run over the
end of the erase block
jffs2: Perhaps the file system was created with the wrong erase size?
jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found
at 0x00000010: 0x1044 instead

This breaks the filesystem and can lead to KASAN crashes such as:

BUG: KASAN: slab-out-of-bounds in jffs2_sum_add_kvec+0x125e/0x15d0
Read of size 4 at addr ffff88802c31e914 by task repro/830
CPU: 0 PID: 830 Comm: repro Not tainted 6.9.0-rc3+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Arch Linux 1.16.3-1-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xc6/0x120
 print_report+0xc4/0x620
 ? __virt_addr_valid+0x308/0x5b0
 kasan_report+0xc1/0xf0
 ? jffs2_sum_add_kvec+0x125e/0x15d0
 ? jffs2_sum_add_kvec+0x125e/0x15d0
 jffs2_sum_add_kvec+0x125e/0x15d0
 jffs2_flash_direct_writev+0xa8/0xd0
 jffs2_flash_writev+0x9c9/0xef0
 ? __x64_sys_setxattr+0xc4/0x160
 ? do_syscall_64+0x69/0x140
 ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
 [...]

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: aa98d7cf59b5 ("[JFFS2][XATTR] XATTR support on JFFS2 (version. 5)")
Signed-off-by: Ilya Denisyev <dev@elkcl.ru>
Link: https://lore.kernel.org/r/20240412155357.237803-1-dev@elkcl.ru
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jffs2/xattr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
index 00224f3a8d6e7..defb4162c3d5b 100644
--- a/fs/jffs2/xattr.c
+++ b/fs/jffs2/xattr.c
@@ -1110,6 +1110,9 @@ int do_jffs2_setxattr(struct inode *inode, int xprefix, const char *xname,
 		return rc;
 
 	request = PAD(sizeof(struct jffs2_raw_xattr) + strlen(xname) + 1 + size);
+	if (request > c->sector_size - c->cleanmarker_size)
+		return -ERANGE;
+
 	rc = jffs2_reserve_space(c, request, &length,
 				 ALLOC_NORMAL, JFFS2_SUMMARY_XATTR_SIZE);
 	if (rc) {
-- 
2.43.0




