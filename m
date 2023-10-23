Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57CA7D3439
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjJWLhr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbjJWLhq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:37:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60531A4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:37:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9ECC433C9;
        Mon, 23 Oct 2023 11:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061064;
        bh=RUwJPIeRYgIsMDYe7YbskXxfaItez8hekDprhtGT6P4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l/SZuWvEEU/DEeBZ/sOD4RbKhcOFJ/YePjQgA7txc1NSR2IB6w3Aj33q6sie3mevS
         sXi4ELxZsrKJQwrEzPI0ZveNxCyvARH0RFejUZPMOLluTXZpQH3uKV6++xAc9dNXPB
         m8KLpZ+wOjkwjDXuxtjuYa4oUbu4p2vYw9xH8wR4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 061/137] powerpc/32s: Remove capability to disable KUEP at boottime
Date:   Mon, 23 Oct 2023 12:56:58 +0200
Message-ID: <20231023104823.027059168@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
References: <20231023104820.849461819@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit df415cd758261bceff27f34a145dd8328bbfb018 ]

Disabling KUEP at boottime makes things unnecessarily complex.

Still allow disabling KUEP at build time, but when it's built-in
it is always there.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/96f583f82423a29a4205c60b9721079111b35567.1634627931.git.christophe.leroy@csgroup.eu
Stable-dep-of: f0eee815babe ("powerpc/47x: Fix 47x syscall return crash")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/book3s/32/kup.h |  3 +--
 arch/powerpc/mm/book3s32/kuep.c          | 10 ++--------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index 9f38040f0641d..fb6c39225dd19 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -12,7 +12,6 @@
 #include <linux/jump_label.h>
 
 extern struct static_key_false disable_kuap_key;
-extern struct static_key_false disable_kuep_key;
 
 static __always_inline bool kuap_is_disabled(void)
 {
@@ -21,7 +20,7 @@ static __always_inline bool kuap_is_disabled(void)
 
 static __always_inline bool kuep_is_disabled(void)
 {
-	return !IS_ENABLED(CONFIG_PPC_KUEP) || static_branch_unlikely(&disable_kuep_key);
+	return !IS_ENABLED(CONFIG_PPC_KUEP);
 }
 
 static inline void kuep_lock(void)
diff --git a/arch/powerpc/mm/book3s32/kuep.c b/arch/powerpc/mm/book3s32/kuep.c
index c20733d6e02cb..8474edce3df9a 100644
--- a/arch/powerpc/mm/book3s32/kuep.c
+++ b/arch/powerpc/mm/book3s32/kuep.c
@@ -3,18 +3,12 @@
 #include <asm/kup.h>
 #include <asm/smp.h>
 
-struct static_key_false disable_kuep_key;
-
 void setup_kuep(bool disabled)
 {
-	if (!disabled)
-		kuep_lock();
+	kuep_lock();
 
 	if (smp_processor_id() != boot_cpuid)
 		return;
 
-	if (disabled)
-		static_branch_enable(&disable_kuep_key);
-	else
-		pr_info("Activating Kernel Userspace Execution Prevention\n");
+	pr_info("Activating Kernel Userspace Execution Prevention\n");
 }
-- 
2.40.1



