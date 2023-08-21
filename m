Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FB7783267
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjHUUDm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjHUUDm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:03:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FB3A8
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:03:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 020C364870
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFCFC433C8;
        Mon, 21 Aug 2023 20:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648219;
        bh=oREmuIuI13b0Hj1mHhpR552dmVgYRvPA7FE/bdg014w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JPbq07ss8oI5ZlSo4aFyyoa7paF3VPKtYE3rzyJI+iho1pe4tIzo5n2fFeLKoESTc
         q+aY8Ze7qTlcmVrKbCbRBL8lS0Vficnh8P8Uownn3XQUe0YEIUY10tQiq2l759L6mP
         lh4t0QEtAnBzqtUwyivNXaQRXaZ+uEu3RZuO17N8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Edward Lo <loyuantsung@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 069/234] fs/ntfs3: Return error for inconsistent extended attributes
Date:   Mon, 21 Aug 2023 21:40:32 +0200
Message-ID: <20230821194131.813929875@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Edward Lo <loyuantsung@gmail.com>

[ Upstream commit c9db0ff04649aa0b45f497183c957fe260f229f6 ]

ntfs_read_ea is called when we want to read extended attributes. There
are some sanity checks for the validity of the EAs. However, it fails to
return a proper error code for the inconsistent attributes, which might
lead to unpredicted memory accesses after return.

[  138.916927] BUG: KASAN: use-after-free in ntfs_set_ea+0x453/0xbf0
[  138.923876] Write of size 4 at addr ffff88800205cfac by task poc/199
[  138.931132]
[  138.933016] CPU: 0 PID: 199 Comm: poc Not tainted 6.2.0-rc1+ #4
[  138.938070] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[  138.947327] Call Trace:
[  138.949557]  <TASK>
[  138.951539]  dump_stack_lvl+0x4d/0x67
[  138.956834]  print_report+0x16f/0x4a6
[  138.960798]  ? ntfs_set_ea+0x453/0xbf0
[  138.964437]  ? kasan_complete_mode_report_info+0x7d/0x200
[  138.969793]  ? ntfs_set_ea+0x453/0xbf0
[  138.973523]  kasan_report+0xb8/0x140
[  138.976740]  ? ntfs_set_ea+0x453/0xbf0
[  138.980578]  __asan_store4+0x76/0xa0
[  138.984669]  ntfs_set_ea+0x453/0xbf0
[  138.988115]  ? __pfx_ntfs_set_ea+0x10/0x10
[  138.993390]  ? kernel_text_address+0xd3/0xe0
[  138.998270]  ? __kernel_text_address+0x16/0x50
[  139.002121]  ? unwind_get_return_address+0x3e/0x60
[  139.005659]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[  139.010177]  ? arch_stack_walk+0xa2/0x100
[  139.013657]  ? filter_irq_stacks+0x27/0x80
[  139.017018]  ntfs_setxattr+0x405/0x440
[  139.022151]  ? __pfx_ntfs_setxattr+0x10/0x10
[  139.026569]  ? kvmalloc_node+0x2d/0x120
[  139.030329]  ? kasan_save_stack+0x41/0x60
[  139.033883]  ? kasan_save_stack+0x2a/0x60
[  139.037338]  ? kasan_set_track+0x29/0x40
[  139.040163]  ? kasan_save_alloc_info+0x1f/0x30
[  139.043588]  ? __kasan_kmalloc+0x8b/0xa0
[  139.047255]  ? __kmalloc_node+0x68/0x150
[  139.051264]  ? kvmalloc_node+0x2d/0x120
[  139.055301]  ? vmemdup_user+0x2b/0xa0
[  139.058584]  __vfs_setxattr+0x121/0x170
[  139.062617]  ? __pfx___vfs_setxattr+0x10/0x10
[  139.066282]  __vfs_setxattr_noperm+0x97/0x300
[  139.070061]  __vfs_setxattr_locked+0x145/0x170
[  139.073580]  vfs_setxattr+0x137/0x2a0
[  139.076641]  ? __pfx_vfs_setxattr+0x10/0x10
[  139.080223]  ? __kasan_check_write+0x18/0x20
[  139.084234]  do_setxattr+0xce/0x150
[  139.087768]  setxattr+0x126/0x140
[  139.091250]  ? __pfx_setxattr+0x10/0x10
[  139.094948]  ? __virt_addr_valid+0xcb/0x140
[  139.097838]  ? __call_rcu_common.constprop.0+0x1c7/0x330
[  139.102688]  ? debug_smp_processor_id+0x1b/0x30
[  139.105985]  ? kasan_quarantine_put+0x5b/0x190
[  139.109980]  ? putname+0x84/0xa0
[  139.113886]  ? __kasan_slab_free+0x11e/0x1b0
[  139.117961]  ? putname+0x84/0xa0
[  139.121316]  ? preempt_count_sub+0x1c/0xd0
[  139.124427]  ? __mnt_want_write+0xae/0x100
[  139.127836]  ? mnt_want_write+0x8f/0x150
[  139.130954]  path_setxattr+0x164/0x180
[  139.133998]  ? __pfx_path_setxattr+0x10/0x10
[  139.137853]  ? __pfx_ksys_pwrite64+0x10/0x10
[  139.141299]  ? debug_smp_processor_id+0x1b/0x30
[  139.145714]  ? fpregs_assert_state_consistent+0x6b/0x80
[  139.150796]  __x64_sys_setxattr+0x71/0x90
[  139.155407]  do_syscall_64+0x3f/0x90
[  139.159035]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  139.163843] RIP: 0033:0x7f108cae4469
[  139.166481] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 088
[  139.183764] RSP: 002b:00007fff87588388 EFLAGS: 00000286 ORIG_RAX: 00000000000000bc
[  139.190657] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f108cae4469
[  139.196586] RDX: 00007fff875883b0 RSI: 00007fff875883d1 RDI: 00007fff875883b6
[  139.201716] RBP: 00007fff8758c530 R08: 0000000000000001 R09: 00007fff8758c618
[  139.207940] R10: 0000000000000006 R11: 0000000000000286 R12: 00000000004004c0
[  139.214007] R13: 00007fff8758c610 R14: 0000000000000000 R15: 0000000000000000

Signed-off-by: Edward Lo <loyuantsung@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/xattr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index fd02fcf4d4091..26787c2bbf758 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -141,6 +141,7 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
 
 	memset(Add2Ptr(ea_p, size), 0, add_bytes);
 
+	err = -EINVAL;
 	/* Check all attributes for consistency. */
 	for (off = 0; off < size; off += ea_size) {
 		const struct EA_FULL *ef = Add2Ptr(ea_p, off);
-- 
2.40.1



