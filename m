Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B6F76C5DE
	for <lists+stable@lfdr.de>; Wed,  2 Aug 2023 08:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjHBGy3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 2 Aug 2023 02:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjHBGyE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 Aug 2023 02:54:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256E7E48
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 23:53:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B843B6146C
        for <stable@vger.kernel.org>; Wed,  2 Aug 2023 06:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C501FC433C7;
        Wed,  2 Aug 2023 06:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690959232;
        bh=fRSx8GX7ueA3owE+Dc/NjcSH2h7YGs+/BDhqUXRetUU=;
        h=Subject:To:Cc:From:Date:From;
        b=hWXfyUc0E0VLWeFqBITarcCxvR5eO8TfPCGlmHEg3FOShQMmVO4hSgxLEeDiZd73G
         W3XiKHuYGZ9XSe1uvo3xQQP2JLShUH90szSNBabACFVcvl1ZefDQXGCVV6amysi3D1
         0RJRq4YFTfrWMZ37fHr6tMDNLz+jWTcuA+7xCnaE=
Subject: FAILED: patch "[PATCH] selftests/rseq: Play nice with binaries statically linked" failed to apply to 6.1-stable tree
To:     seanjc@google.com, aaronlewis@google.com, pbonzini@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 02 Aug 2023 08:53:41 +0200
Message-ID: <2023080241-yearning-swifter-0f9a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3bcbc20942db5d738221cca31a928efc09827069
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080241-yearning-swifter-0f9a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

3bcbc20942db ("selftests/rseq: Play nice with binaries statically linked against glibc 2.35+")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3bcbc20942db5d738221cca31a928efc09827069 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 21 Jul 2023 15:33:52 -0700
Subject: [PATCH] selftests/rseq: Play nice with binaries statically linked
 against glibc 2.35+

To allow running rseq and KVM's rseq selftests as statically linked
binaries, initialize the various "trampoline" pointers to point directly
at the expect glibc symbols, and skip the dlysm() lookups if the rseq
size is non-zero, i.e. the binary is statically linked *and* the libc
registered its own rseq.

Define weak versions of the symbols so as not to break linking against
libc versions that don't support rseq in any capacity.

The KVM selftests in particular are often statically linked so that they
can be run on targets with very limited runtime environments, i.e. test
machines.

Fixes: 233e667e1ae3 ("selftests/rseq: Uplift rseq selftests for compatibility with glibc-2.35")
Cc: Aaron Lewis <aaronlewis@google.com>
Cc: kvm@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20230721223352.2333911-1-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 4e4aa006004c..a723da253244 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -34,9 +34,17 @@
 #include "../kselftest.h"
 #include "rseq.h"
 
-static const ptrdiff_t *libc_rseq_offset_p;
-static const unsigned int *libc_rseq_size_p;
-static const unsigned int *libc_rseq_flags_p;
+/*
+ * Define weak versions to play nice with binaries that are statically linked
+ * against a libc that doesn't support registering its own rseq.
+ */
+__weak ptrdiff_t __rseq_offset;
+__weak unsigned int __rseq_size;
+__weak unsigned int __rseq_flags;
+
+static const ptrdiff_t *libc_rseq_offset_p = &__rseq_offset;
+static const unsigned int *libc_rseq_size_p = &__rseq_size;
+static const unsigned int *libc_rseq_flags_p = &__rseq_flags;
 
 /* Offset from the thread pointer to the rseq area. */
 ptrdiff_t rseq_offset;
@@ -155,9 +163,17 @@ unsigned int get_rseq_feature_size(void)
 static __attribute__((constructor))
 void rseq_init(void)
 {
-	libc_rseq_offset_p = dlsym(RTLD_NEXT, "__rseq_offset");
-	libc_rseq_size_p = dlsym(RTLD_NEXT, "__rseq_size");
-	libc_rseq_flags_p = dlsym(RTLD_NEXT, "__rseq_flags");
+	/*
+	 * If the libc's registered rseq size isn't already valid, it may be
+	 * because the binary is dynamically linked and not necessarily due to
+	 * libc not having registered a restartable sequence.  Try to find the
+	 * symbols if that's the case.
+	 */
+	if (!*libc_rseq_size_p) {
+		libc_rseq_offset_p = dlsym(RTLD_NEXT, "__rseq_offset");
+		libc_rseq_size_p = dlsym(RTLD_NEXT, "__rseq_size");
+		libc_rseq_flags_p = dlsym(RTLD_NEXT, "__rseq_flags");
+	}
 	if (libc_rseq_size_p && libc_rseq_offset_p && libc_rseq_flags_p &&
 			*libc_rseq_size_p != 0) {
 		/* rseq registration owned by glibc */

