Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751F37749D9
	for <lists+stable@lfdr.de>; Tue,  8 Aug 2023 22:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbjHHUFg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 16:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjHHUFY (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 16:05:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A653212B;
        Tue,  8 Aug 2023 11:42:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64F3B62A40;
        Tue,  8 Aug 2023 18:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC970C433C8;
        Tue,  8 Aug 2023 18:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1691520175;
        bh=wP7BF3ab+wRsak0cwDNYSE8HETdhjCxPII2/mnSMp8c=;
        h=Date:To:From:Subject:From;
        b=xG2sDntcYUuGLEDKctVEmvFTkVSDjLTPcbvJ05MeXT1kOo6dSanaeYk7BDygmUle/
         MpVPLTz2K6x5hnllhXTizwz69wEwH2v8WEV8EAKY79LTKd809fo5Wv12D54QdzWk3B
         bEmU7yJ594+CZvWfg88/Zq2MH5A2Om97iNE3utD8=
Date:   Tue, 08 Aug 2023 11:42:54 -0700
To:     mm-commits@vger.kernel.org, stable@vger.kernel.org,
        raghavendra.kt@amd.com, jhubbard@nvidia.com, jgg@nvidia.com,
        david@redhat.com, ayush.jain3@amd.com, akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: + selftests-mm-foll_longterm-need-to-be-updated-to-0x100.patch added to mm-hotfixes-unstable branch
Message-Id: <20230808184255.BC970C433C8@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch titled
     Subject: selftests/mm: FOLL_LONGTERM need to be updated to 0x100
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     selftests-mm-foll_longterm-need-to-be-updated-to-0x100.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/selftests-mm-foll_longterm-need-to-be-updated-to-0x100.patch

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
From: Ayush Jain <ayush.jain3@amd.com>
Subject: selftests/mm: FOLL_LONGTERM need to be updated to 0x100
Date: Tue, 8 Aug 2023 07:43:47 -0500

After commit 2c2241081f7d ("mm/gup: move private gup FOLL_ flags to
internal.h") FOLL_LONGTERM flag value got updated from 0x10000 to 0x100 at
include/linux/mm_types.h.

As hmm.hmm_device_private.hmm_gup_test uses FOLL_LONGTERM Updating same
here as well.

Before this change test goes in an infinite assert loop in
hmm.hmm_device_private.hmm_gup_test
==========================================================
 RUN           hmm.hmm_device_private.hmm_gup_test ...
hmm-tests.c:1962:hmm_gup_test:Expected HMM_DMIRROR_PROT_WRITE..
..(2) == m[2] (34)
hmm-tests.c:157:hmm_gup_test:Expected ret (-1) == 0 (0)
hmm-tests.c:157:hmm_gup_test:Expected ret (-1) == 0 (0)
...
==========================================================

 Call Trace:
 <TASK>
 ? sched_clock+0xd/0x20
 ? __lock_acquire.constprop.0+0x120/0x6c0
 ? ktime_get+0x2c/0xd0
 ? sched_clock+0xd/0x20
 ? local_clock+0x12/0xd0
 ? lock_release+0x26e/0x3b0
 pin_user_pages_fast+0x4c/0x70
 gup_test_ioctl+0x4ff/0xbb0
 ? gup_test_ioctl+0x68c/0xbb0
 __x64_sys_ioctl+0x99/0xd0
 do_syscall_64+0x60/0x90
 ? syscall_exit_to_user_mode+0x2a/0x50
 ? do_syscall_64+0x6d/0x90
 ? syscall_exit_to_user_mode+0x2a/0x50
 ? do_syscall_64+0x6d/0x90
 ? irqentry_exit_to_user_mode+0xd/0x20
 ? irqentry_exit+0x3f/0x50
 ? exc_page_fault+0x96/0x200
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
 RIP: 0033:0x7f6aaa31aaff

After this change test is able to pass successfully.

Link: https://lkml.kernel.org/r/20230808124347.79163-1-ayush.jain3@amd.com
Fixes: 2c2241081f7d ("mm/gup: move private gup FOLL_ flags to internal.h")
Signed-off-by: Ayush Jain <ayush.jain3@amd.com>
Reviewed-by: Raghavendra K T <raghavendra.kt@amd.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 tools/testing/selftests/mm/hmm-tests.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/mm/hmm-tests.c~selftests-mm-foll_longterm-need-to-be-updated-to-0x100
+++ a/tools/testing/selftests/mm/hmm-tests.c
@@ -57,9 +57,14 @@ enum {
 
 #define ALIGN(x, a) (((x) + (a - 1)) & (~((a) - 1)))
 /* Just the flags we need, copied from mm.h: */
+
+#ifndef FOLL_WRITE
 #define FOLL_WRITE	0x01	/* check pte is writable */
-#define FOLL_LONGTERM   0x10000 /* mapping lifetime is indefinite */
+#endif
 
+#ifndef FOLL_LONGTERM
+#define FOLL_LONGTERM   0x100 /* mapping lifetime is indefinite */
+#endif
 FIXTURE(hmm)
 {
 	int		fd;
_

Patches currently in -mm which might be from ayush.jain3@amd.com are

selftests-mm-foll_longterm-need-to-be-updated-to-0x100.patch
selftests-mm-add-ksm_merge_time-tests.patch

