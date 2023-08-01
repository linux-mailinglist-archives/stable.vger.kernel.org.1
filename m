Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBA276AD6A
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbjHAJ3B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjHAJ2k (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:28:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEE31BDB
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:27:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A029461506
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:27:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC568C433CC;
        Tue,  1 Aug 2023 09:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882057;
        bh=XhaGG7N8DcJN6FJftgfKGM9RJ+PgyuebdLrfUWByd+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R0gd6ReuvMfP8UzLxG6NGBGQTqT2ggC7rDhTtn6MeMv85brhwnLdiwfgVXG7ekt4e
         dk4xp0iNIJoJOLOxxgkVk+E6UXoZ1/QMUz1W4BaIf0mVuchmpVBjLwyCBnYIrIZJ0c
         3mzpslz5i0IZCi3HZyDlNJ08g4Bq7KscYS2OtshE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chaoyuan Peng <hedonistsmith@gmail.com>,
        stable <stable@kernel.org>
Subject: [PATCH 5.15 126/155] tty: n_gsm: fix UAF in gsm_cleanup_mux
Date:   Tue,  1 Aug 2023 11:20:38 +0200
Message-ID: <20230801091914.699250029@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chaoyuan Peng <hedonistsmith@gmail.com>

commit 9b9c8195f3f0d74a826077fc1c01b9ee74907239 upstream.

In gsm_cleanup_mux() the 'gsm->dlci' pointer was not cleaned properly,
leaving it a dangling pointer after gsm_dlci_release.
This leads to use-after-free where 'gsm->dlci[0]' are freed and accessed
by the subsequent gsm_cleanup_mux().

Such is the case in the following call trace:

 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 print_address_description+0x63/0x3b0 mm/kasan/report.c:248
 __kasan_report mm/kasan/report.c:434 [inline]
 kasan_report+0x16b/0x1c0 mm/kasan/report.c:451
 gsm_cleanup_mux+0x76a/0x850 drivers/tty/n_gsm.c:2397
 gsm_config drivers/tty/n_gsm.c:2653 [inline]
 gsmld_ioctl+0xaae/0x15b0 drivers/tty/n_gsm.c:2986
 tty_ioctl+0x8ff/0xc50 drivers/tty/tty_io.c:2816
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x61/0xcb
 </TASK>

Allocated by task 3501:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc+0xba/0xf0 mm/kasan/common.c:513
 kasan_kmalloc include/linux/kasan.h:264 [inline]
 kmem_cache_alloc_trace+0x143/0x290 mm/slub.c:3247
 kmalloc include/linux/slab.h:591 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 gsm_dlci_alloc+0x53/0x3a0 drivers/tty/n_gsm.c:1932
 gsm_activate_mux+0x1c/0x330 drivers/tty/n_gsm.c:2438
 gsm_config drivers/tty/n_gsm.c:2677 [inline]
 gsmld_ioctl+0xd46/0x15b0 drivers/tty/n_gsm.c:2986
 tty_ioctl+0x8ff/0xc50 drivers/tty/tty_io.c:2816
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x61/0xcb

Freed by task 3501:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track+0x4b/0x80 mm/kasan/common.c:46
 kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:360
 ____kasan_slab_free+0xd8/0x120 mm/kasan/common.c:366
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:1705 [inline]
 slab_free_freelist_hook+0xdd/0x160 mm/slub.c:1731
 slab_free mm/slub.c:3499 [inline]
 kfree+0xf1/0x270 mm/slub.c:4559
 dlci_put drivers/tty/n_gsm.c:1988 [inline]
 gsm_dlci_release drivers/tty/n_gsm.c:2021 [inline]
 gsm_cleanup_mux+0x574/0x850 drivers/tty/n_gsm.c:2415
 gsm_config drivers/tty/n_gsm.c:2653 [inline]
 gsmld_ioctl+0xaae/0x15b0 drivers/tty/n_gsm.c:2986
 tty_ioctl+0x8ff/0xc50 drivers/tty/tty_io.c:2816
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x61/0xcb

Fixes: aa371e96f05d ("tty: n_gsm: fix restart handling via CLD command")
Signed-off-by: Chaoyuan Peng <hedonistsmith@gmail.com>
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/n_gsm.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2411,8 +2411,10 @@ static void gsm_cleanup_mux(struct gsm_m
 		gsm->has_devices = false;
 	}
 	for (i = NUM_DLCI - 1; i >= 0; i--)
-		if (gsm->dlci[i])
+		if (gsm->dlci[i]) {
 			gsm_dlci_release(gsm->dlci[i]);
+			gsm->dlci[i] = NULL;
+		}
 	mutex_unlock(&gsm->mutex);
 	/* Now wipe the queues */
 	tty_ldisc_flush(gsm->tty);


