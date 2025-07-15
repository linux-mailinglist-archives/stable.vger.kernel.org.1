Return-Path: <stable+bounces-162590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E4CB05E8A
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B336E4A147F
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6872EAD05;
	Tue, 15 Jul 2025 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jITSNOO8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D12C2E339A;
	Tue, 15 Jul 2025 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586957; cv=none; b=m425M162XETruRQuMw1Wb4D4/EdzwzBj7I7M3EOQ6dmaqka6cxZpj9TUJOHZVuULt+TujD0t/J+rVnb8FGoJeTaetsF1v1FAWiBRDW1bEmz3GoEobTTCD+OOjPgLKlASjU/clDkaOhzF2Yms4HwNhXBrjo1JDOpuXSaNuuux3yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586957; c=relaxed/simple;
	bh=gcnrZw7F0Enpr/gFJSVTYAKUhDGtHcoasBBaKqsulmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DO22L6r4axZs5Te03Vo0jlI0JNPfMcs57wshmPfCFYI1tzkbiO2BdKwJzhGzW/L1UFEtlSRfYBO8T9F5hznSMNZBCUokaAWLElotWR74+OWEIcVXyMZzK0rJp3kNDCb20auWNV7biUsCXjz5XtahLW2vkW3WJooU0wUAJwK3P7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jITSNOO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5697C4CEE3;
	Tue, 15 Jul 2025 13:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752586957;
	bh=gcnrZw7F0Enpr/gFJSVTYAKUhDGtHcoasBBaKqsulmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jITSNOO8ogc9+OQSP19/TcgXSHoCtog7zX3P/zHDRy3VblUcaz/sg2nVK9mz8+oKo
	 0RaQkfm80Ip4e0EeaOztwhvd9fBaVnOkdhiFO3DuM3LbAj+Mi40pASnTyEntNEZogR
	 tKSHezn06RsFNZAZaOukqQx09rfxzA7PECT88X/c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Harry Yoo <harry.yoo@oracle.com>,
	kernel test robot <oliver.sang@intel.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Raghavendra K T <raghavendra.kt@amd.com>,
	Casey Chen <cachen@purestorage.com>,
	David Wang <00107082@163.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.15 112/192] lib/alloc_tag: do not acquire non-existent lock in alloc_tag_top_users()
Date: Tue, 15 Jul 2025 15:13:27 +0200
Message-ID: <20250715130819.383929497@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>
References: <20250715130814.854109770@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harry Yoo <harry.yoo@oracle.com>

commit 99af22cd34688cc0d535a1919e0bea4cbc6c1ea1 upstream.

alloc_tag_top_users() attempts to lock alloc_tag_cttype->mod_lock even
when the alloc_tag_cttype is not allocated because:

  1) alloc tagging is disabled because mem profiling is disabled
     (!alloc_tag_cttype)
  2) alloc tagging is enabled, but not yet initialized (!alloc_tag_cttype)
  3) alloc tagging is enabled, but failed initialization
     (!alloc_tag_cttype or IS_ERR(alloc_tag_cttype))

In all cases, alloc_tag_cttype is not allocated, and therefore
alloc_tag_top_users() should not attempt to acquire the semaphore.

This leads to a crash on memory allocation failure by attempting to
acquire a non-existent semaphore:

  Oops: general protection fault, probably for non-canonical address 0xdffffc000000001b: 0000 [#3] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
  CPU: 2 UID: 0 PID: 1 Comm: systemd Tainted: G      D             6.16.0-rc2 #1 VOLUNTARY
  Tainted: [D]=DIE
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
  RIP: 0010:down_read_trylock+0xaa/0x3b0
  Code: d0 7c 08 84 d2 0f 85 a0 02 00 00 8b 0d df 31 dd 04 85 c9 75 29 48 b8 00 00 00 00 00 fc ff df 48 8d 6b 68 48 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 88 02 00 00 48 3b 5b 68 0f 85 53 01 00 00 65 ff
  RSP: 0000:ffff8881002ce9b8 EFLAGS: 00010016
  RAX: dffffc0000000000 RBX: 0000000000000070 RCX: 0000000000000000
  RDX: 000000000000001b RSI: 000000000000000a RDI: 0000000000000070
  RBP: 00000000000000d8 R08: 0000000000000001 R09: ffffed107dde49d1
  R10: ffff8883eef24e8b R11: ffff8881002cec20 R12: 1ffff11020059d37
  R13: 00000000003fff7b R14: ffff8881002cec20 R15: dffffc0000000000
  FS:  00007f963f21d940(0000) GS:ffff888458ca6000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f963f5edf71 CR3: 000000010672c000 CR4: 0000000000350ef0
  Call Trace:
   <TASK>
   codetag_trylock_module_list+0xd/0x20
   alloc_tag_top_users+0x369/0x4b0
   __show_mem+0x1cd/0x6e0
   warn_alloc+0x2b1/0x390
   __alloc_frozen_pages_noprof+0x12b9/0x21a0
   alloc_pages_mpol+0x135/0x3e0
   alloc_slab_page+0x82/0xe0
   new_slab+0x212/0x240
   ___slab_alloc+0x82a/0xe00
   </TASK>

As David Wang points out, this issue became easier to trigger after commit
780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag_init").

Before the commit, the issue occurred only when it failed to allocate and
initialize alloc_tag_cttype or if a memory allocation fails before
alloc_tag_init() is called.  After the commit, it can be easily triggered
when memory profiling is compiled but disabled at boot.

To properly determine whether alloc_tag_init() has been called and its
data structures initialized, verify that alloc_tag_cttype is a valid
pointer before acquiring the semaphore.  If the variable is NULL or an
error value, it has not been properly initialized.  In such a case, just
skip and do not attempt to acquire the semaphore.

[harry.yoo@oracle.com: v3]
  Link: https://lkml.kernel.org/r/20250624072513.84219-1-harry.yoo@oracle.com
Link: https://lkml.kernel.org/r/20250620195305.1115151-1-harry.yoo@oracle.com
Fixes: 780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag_init")
Fixes: 1438d349d16b ("lib: add memory allocations report in show_mem()")
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202506181351.bba867dd-lkp@intel.com
Acked-by: Suren Baghdasaryan <surenb@google.com>
Tested-by: Raghavendra K T <raghavendra.kt@amd.com>
Cc: Casey Chen <cachen@purestorage.com>
Cc: David Wang <00107082@163.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Yuanyuan Zhong <yzhong@purestorage.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/alloc_tag.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -134,6 +134,9 @@ size_t alloc_tag_top_users(struct codeta
 	struct codetag_bytes n;
 	unsigned int i, nr = 0;
 
+	if (IS_ERR_OR_NULL(alloc_tag_cttype))
+		return 0;
+
 	if (can_sleep)
 		codetag_lock_module_list(alloc_tag_cttype, true);
 	else if (!codetag_trylock_module_list(alloc_tag_cttype))



