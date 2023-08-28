Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E021E78ADAB
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjH1KuN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjH1Ktq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:49:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B205CCA
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:49:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68C6E643C9
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF6DC433CA;
        Mon, 28 Aug 2023 10:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219761;
        bh=vnm6pKBjxKVM/sm1c5TW9aghuTwrbPt1okEutJT9eco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BibeAJDgNQNjM4yFEVpp0zOIR5UgKtSJgA24uuS6umGs7tMZ1fPgWh6rTqJDCZ+hp
         bgFArQ0vYRAEQnifR5k+YzRbv2YAYgBq5MXz/0D4Tpd9V4samqV8m1aSAGCR4RyFkH
         oQCn5GY5QjM6TxWoHEASFB0AX5suB/vX3F8ORfG8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <oliver.sang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5.10 62/84] x86/fpu: Set X86_FEATURE_OSXSAVE feature after enabling OSXSAVE in CR4
Date:   Mon, 28 Aug 2023 12:14:19 +0200
Message-ID: <20230828101151.362291771@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101149.146126827@linuxfoundation.org>
References: <20230828101149.146126827@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Feng Tang <feng.tang@intel.com>

commit 2c66ca3949dc701da7f4c9407f2140ae425683a5 upstream.

0-Day found a 34.6% regression in stress-ng's 'af-alg' test case, and
bisected it to commit b81fac906a8f ("x86/fpu: Move FPU initialization into
arch_cpu_finalize_init()"), which optimizes the FPU init order, and moves
the CR4_OSXSAVE enabling into a later place:

   arch_cpu_finalize_init
       identify_boot_cpu
	   identify_cpu
	       generic_identify
                   get_cpu_cap --> setup cpu capability
       ...
       fpu__init_cpu
           fpu__init_cpu_xstate
               cr4_set_bits(X86_CR4_OSXSAVE);

As the FPU is not yet initialized the CPU capability setup fails to set
X86_FEATURE_OSXSAVE. Many security module like 'camellia_aesni_avx_x86_64'
depend on this feature and therefore fail to load, causing the regression.

Cure this by setting X86_FEATURE_OSXSAVE feature right after OSXSAVE
enabling.

[ tglx: Moved it into the actual BSP FPU initialization code and added a comment ]

Fixes: b81fac906a8f ("x86/fpu: Move FPU initialization into arch_cpu_finalize_init()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/lkml/202307192135.203ac24e-oliver.sang@intel.com
Link: https://lore.kernel.org/lkml/20230823065747.92257-1-feng.tang@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/fpu/xstate.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -892,6 +892,14 @@ void __init fpu__init_system_xstate(void
 	setup_init_fpu_buf();
 	setup_xstate_comp_offsets();
 	setup_supervisor_only_offsets();
+
+	/*
+	 * CPU capabilities initialization runs before FPU init. So
+	 * X86_FEATURE_OSXSAVE is not set. Now that XSAVE is completely
+	 * functional, set the feature bit so depending code works.
+	 */
+	setup_force_cpu_cap(X86_FEATURE_OSXSAVE);
+
 	print_xstate_offset_size();
 
 	pr_info("x86/fpu: Enabled xstate features 0x%llx, context size is %d bytes, using '%s' format.\n",


