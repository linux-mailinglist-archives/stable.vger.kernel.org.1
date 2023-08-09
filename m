Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952227757AE
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjHIKsy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjHIKsx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:48:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64DC1BFE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:48:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95A8C6283F
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:48:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C60C433C8;
        Wed,  9 Aug 2023 10:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578131;
        bh=z7oZgN4W5OQsSVx+1AW/vrQO+wsiT8Yp/xbeilDoZSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x5I4IhKZ9n3xBu67/64xnejcH3CoQridL5B4mAIAouO4E7pV1Wlex3MQwAq/UBGeS
         QjfsfpJdP7s7Yf7OKyBSYtKcHU5m8Wz8VBeMhNZJ1+cJaCwCH6ASDmnEx7AeR+KL2W
         43uWXKlRyCvIW+s7DFhnYfDpL2nUx5uH+cqvqjgY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: [PATCH 6.4 116/165] x86/hyperv: Disable IBT when hypercall page lacks ENDBR instruction
Date:   Wed,  9 Aug 2023 12:40:47 +0200
Message-ID: <20230809103646.589643174@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

commit d5ace2a776442d80674eff9ed42e737f7dd95056 upstream.

On hardware that supports Indirect Branch Tracking (IBT), Hyper-V VMs
with ConfigVersion 9.3 or later support IBT in the guest. However,
current versions of Hyper-V have a bug in that there's not an ENDBR64
instruction at the beginning of the hypercall page. Since hypercalls are
made with an indirect call to the hypercall page, all hypercall attempts
fail with an exception and Linux panics.

A Hyper-V fix is in progress to add ENDBR64. But guard against the Linux
panic by clearing X86_FEATURE_IBT if the hypercall page doesn't start
with ENDBR. The VM will boot and run without IBT.

If future Linux 32-bit kernels were to support IBT, additional hypercall
page hackery would be needed to make IBT work for such kernels in a
Hyper-V VM.

Cc: stable@vger.kernel.org
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/1690001476-98594-1-git-send-email-mikelley@microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/hyperv/hv_init.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -14,6 +14,7 @@
 #include <asm/apic.h>
 #include <asm/desc.h>
 #include <asm/sev.h>
+#include <asm/ibt.h>
 #include <asm/hypervisor.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
@@ -472,6 +473,26 @@ void __init hyperv_init(void)
 	}
 
 	/*
+	 * Some versions of Hyper-V that provide IBT in guest VMs have a bug
+	 * in that there's no ENDBR64 instruction at the entry to the
+	 * hypercall page. Because hypercalls are invoked via an indirect call
+	 * to the hypercall page, all hypercall attempts fail when IBT is
+	 * enabled, and Linux panics. For such buggy versions, disable IBT.
+	 *
+	 * Fixed versions of Hyper-V always provide ENDBR64 on the hypercall
+	 * page, so if future Linux kernel versions enable IBT for 32-bit
+	 * builds, additional hypercall page hackery will be required here
+	 * to provide an ENDBR32.
+	 */
+#ifdef CONFIG_X86_KERNEL_IBT
+	if (cpu_feature_enabled(X86_FEATURE_IBT) &&
+	    *(u32 *)hv_hypercall_pg != gen_endbr()) {
+		setup_clear_cpu_cap(X86_FEATURE_IBT);
+		pr_warn("Hyper-V: Disabling IBT because of Hyper-V bug\n");
+	}
+#endif
+
+	/*
 	 * hyperv_init() is called before LAPIC is initialized: see
 	 * apic_intr_mode_init() -> x86_platform.apic_post_init() and
 	 * apic_bsp_setup() -> setup_local_APIC(). The direct-mode STIMER


