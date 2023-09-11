Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4692179BB3A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237112AbjIKWqa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241945AbjIKPSl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:18:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EB6FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:18:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C930C433C7;
        Mon, 11 Sep 2023 15:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445517;
        bh=WlZKDQ0+mLIwmn97LCJ4uYMk3WqWbDNuT23VWblz2kU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mNhQrJwDl/2wIjnDj9WYfXdUXbxCk2OAi7zmekOoRQ5gVtsu0XSRArBtKNO1bAhPe
         1TPbupggFN2GeJyRL5SxhNnM1xv9srHP/XcLZ0KUkBOKhOxfz1/+Rjc6yVN6eRvOzK
         SpbG/r60lCbG10ge/rEAN5vw9Pdx3i7iGhyl9WB8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 376/600] powerpc: Dont include lppaca.h in paca.h
Date:   Mon, 11 Sep 2023 15:46:49 +0200
Message-ID: <20230911134644.774775469@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 1aa000667669fa855853decbb1c69e974d8ff716 ]

By adding a forward declaration for struct lppaca we can untangle paca.h
and lppaca.h. Also move get_lppaca() into lppaca.h for consistency.

Add includes of lppaca.h to some files that need it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230823055317.751786-3-mpe@ellerman.id.au
Stable-dep-of: eac030b22ea1 ("powerpc/pseries: Rework lppaca_shared_proc() to avoid DEBUG_PREEMPT")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/lppaca.h         | 4 ++++
 arch/powerpc/include/asm/paca.h           | 6 +-----
 arch/powerpc/include/asm/paravirt.h       | 1 +
 arch/powerpc/include/asm/plpar_wrappers.h | 1 +
 arch/powerpc/kvm/book3s_hv_ras.c          | 1 +
 arch/powerpc/mm/book3s64/slb.c            | 1 +
 arch/powerpc/xmon/xmon.c                  | 1 +
 7 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index 34d44cb17c874..fe278172e9d42 100644
--- a/arch/powerpc/include/asm/lppaca.h
+++ b/arch/powerpc/include/asm/lppaca.h
@@ -134,6 +134,10 @@ static inline bool lppaca_shared_proc(struct lppaca *l)
 	return !!(l->__old_status & LPPACA_OLD_SHARED_PROC);
 }
 
+#ifdef CONFIG_PPC_PSERIES
+#define get_lppaca()	(get_paca()->lppaca_ptr)
+#endif
+
 /*
  * SLB shadow buffer structure as defined in the PAPR.  The save_area
  * contains adjacent ESID and VSID pairs for each shadowed SLB.  The
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 0ab3511a47d77..183b5a251804c 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -15,7 +15,6 @@
 #include <linux/cache.h>
 #include <linux/string.h>
 #include <asm/types.h>
-#include <asm/lppaca.h>
 #include <asm/mmu.h>
 #include <asm/page.h>
 #ifdef CONFIG_PPC_BOOK3E_64
@@ -47,14 +46,11 @@ extern unsigned int debug_smp_processor_id(void); /* from linux/smp.h */
 #define get_paca()	local_paca
 #endif
 
-#ifdef CONFIG_PPC_PSERIES
-#define get_lppaca()	(get_paca()->lppaca_ptr)
-#endif
-
 #define get_slb_shadow()	(get_paca()->slb_shadow_ptr)
 
 struct task_struct;
 struct rtas_args;
+struct lppaca;
 
 /*
  * Defines the layout of the paca.
diff --git a/arch/powerpc/include/asm/paravirt.h b/arch/powerpc/include/asm/paravirt.h
index f5ba1a3c41f8e..e08513d731193 100644
--- a/arch/powerpc/include/asm/paravirt.h
+++ b/arch/powerpc/include/asm/paravirt.h
@@ -6,6 +6,7 @@
 #include <asm/smp.h>
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
+#include <asm/lppaca.h>
 #include <asm/hvcall.h>
 #endif
 
diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
index 8239c0af5eb2b..fe3d0ea0058ac 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -9,6 +9,7 @@
 
 #include <asm/hvcall.h>
 #include <asm/paca.h>
+#include <asm/lppaca.h>
 #include <asm/page.h>
 
 static inline long poll_pending(void)
diff --git a/arch/powerpc/kvm/book3s_hv_ras.c b/arch/powerpc/kvm/book3s_hv_ras.c
index ccfd969656306..82be6d87514b7 100644
--- a/arch/powerpc/kvm/book3s_hv_ras.c
+++ b/arch/powerpc/kvm/book3s_hv_ras.c
@@ -9,6 +9,7 @@
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
 #include <linux/kernel.h>
+#include <asm/lppaca.h>
 #include <asm/opal.h>
 #include <asm/mce.h>
 #include <asm/machdep.h>
diff --git a/arch/powerpc/mm/book3s64/slb.c b/arch/powerpc/mm/book3s64/slb.c
index 6956f637a38c1..f2708c8629a52 100644
--- a/arch/powerpc/mm/book3s64/slb.c
+++ b/arch/powerpc/mm/book3s64/slb.c
@@ -13,6 +13,7 @@
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
 #include <asm/paca.h>
+#include <asm/lppaca.h>
 #include <asm/ppc-opcode.h>
 #include <asm/cputable.h>
 #include <asm/cacheflush.h>
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index bd8e80936f44d..cd692f399cd18 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -58,6 +58,7 @@
 #ifdef CONFIG_PPC64
 #include <asm/hvcall.h>
 #include <asm/paca.h>
+#include <asm/lppaca.h>
 #endif
 
 #include "nonstdio.h"
-- 
2.40.1



