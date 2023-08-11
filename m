Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6388F7794F4
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 18:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjHKQo0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 12:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbjHKQoZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 12:44:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85D32D7F;
        Fri, 11 Aug 2023 09:44:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A956676E8;
        Fri, 11 Aug 2023 16:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF529C433C7;
        Fri, 11 Aug 2023 16:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1691772262;
        bh=sqZoNCsSkx93A4IAt9KyW4+TynQGgFAbkbE6S3gbK2o=;
        h=Date:To:From:Subject:From;
        b=W5yqMiWGnDkTQRrC3wwz0JMIXDSmal9sk5JssBdkSgCdEAjASskpXYEMiA3B1S1hf
         EZgDmNfEQGuan7Rnh37nFPU48sIuOoOFLtJgrWDtSdwr0HcHEc6lQdJpnKzPRy4xcR
         dcmJ1snhtxeNpR/yzi1Gguw5pCnH7wAVXUOc0upc=
Date:   Fri, 11 Aug 2023 09:44:22 -0700
To:     mm-commits@vger.kernel.org, stable@vger.kernel.org,
        rppt@kernel.org, deller@gmx.de, akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-add-lockdep-annotation-to-pgdat_init_all_done_comp-completer.patch added to mm-hotfixes-unstable branch
Message-Id: <20230811164422.BF529C433C7@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch titled
     Subject: mm: add lockdep annotation to pgdat_init_all_done_comp completer
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-add-lockdep-annotation-to-pgdat_init_all_done_comp-completer.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-add-lockdep-annotation-to-pgdat_init_all_done_comp-completer.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Helge Deller <deller@gmx.de>
Subject: mm: add lockdep annotation to pgdat_init_all_done_comp completer
Date: Fri, 11 Aug 2023 18:06:19 +0200

Add the missing lockdep annotation to avoid this kernel warning:

 smp: Brought up 1 node, 1 CPU
 INFO: trying to register non-static key.
 The code is fine but needs lockdep annotation, or maybe
 you didn't initialize this object before use?'
 turning off the locking correctness validator.
 CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc5+ #683
 Hardware name: 9000/785/C3700
 Backtrace:
  [<000000004030bcd0>] show_stack+0x74/0xb0
  [<000000004146c63c>] dump_stack_lvl+0x104/0x180
  [<000000004146c6ec>] dump_stack+0x34/0x48
  [<000000004040e5b4>] register_lock_class+0xd24/0xd30
  [<000000004040c21c>] __lock_acquire.isra.0+0xb4/0xac8
  [<000000004040cd60>] lock_acquire+0x130/0x298
  [<000000004147095c>] _raw_spin_lock_irq+0x60/0xb8
  [<0000000041474a4c>] wait_for_completion+0xa0/0x2d0
  [<000000004012bf04>] page_alloc_init_late+0xf8/0x2b0
  [<0000000040102b20>] kernel_init_freeable+0x464/0x7f0
  [<000000004146df68>] kernel_init+0x64/0x3a8
  [<0000000040302020>] ret_from_kernel_thread+0x20/0x28

Link: https://lkml.kernel.org/r/ZNZce1KGxP1dxpTN@p100
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/mm_init.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/mm_init.c~mm-add-lockdep-annotation-to-pgdat_init_all_done_comp-completer
+++ a/mm/mm_init.c
@@ -2377,6 +2377,7 @@ void __init page_alloc_init_late(void)
 	int nid;
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+	init_completion(&pgdat_init_all_done_comp);
 
 	/* There will be num_node_state(N_MEMORY) threads */
 	atomic_set(&pgdat_init_n_undone, num_node_state(N_MEMORY));
_

Patches currently in -mm which might be from deller@gmx.de are

mm-add-lockdep-annotation-to-pgdat_init_all_done_comp-completer.patch
init-add-lockdep-annotation-to-kthreadd_done-completer.patch

