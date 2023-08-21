Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F1478327A
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjHUUIn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjHUUIm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:08:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC062E4
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:08:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82E1264A37
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:08:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CCCC433C7;
        Mon, 21 Aug 2023 20:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648519;
        bh=1s+T4O6btMWMuitz2HmEYp/IGnRxfm+4Mxk1n7+MNMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xooiVgJ6TDxxIbiA/CXMW11TuyskeT3HS6T6J2o8nZTgBMNVRyQQQaiRf8Zy+Cu2r
         K9m8oF6y8vCrE/v1Ok4Qa7P6ZvqxMCUfQaMjJjlRfBDvvi1bOgxgdQAxsOCM0OA3/+
         7Hf4bCioSheZhcHccR4ptP9g9DQpRrXRuoahmTz0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>,
        Sam James <sam@gentoo.org>
Subject: [PATCH 6.4 204/234] parisc: Fix CONFIG_TLB_PTLOCK to work with lightweight spinlock checks
Date:   Mon, 21 Aug 2023 21:42:47 +0200
Message-ID: <20230821194137.884034072@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Helge Deller <deller@gmx.de>

commit 7a894c87374771f3cfb1b8e5453fbe03f1fb8135 upstream.

For the TLB_PTLOCK checks we used an optimization to store the spc
register into the spinlock to unlock it. This optimization works as
long as the lightweight spinlock checks (CONFIG_LIGHTWEIGHT_SPINLOCK_CHECK)
aren't enabled, because they really check if the lock word is zero or
__ARCH_SPIN_LOCK_UNLOCKED_VAL and abort with a kernel crash
("Spinlock was trashed") otherwise.

Drop that optimization to make it possible to activate both checks
at the same time.

Noticed-by: Sam James <sam@gentoo.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Tested-by: Sam James <sam@gentoo.org>
Cc: stable@vger.kernel.org # v6.4+
Fixes: 15e64ef6520e ("parisc: Add lightweight spinlock checks")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/kernel/entry.S | 47 +++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
index 0e5ebfe8d9d2..ae03b8679696 100644
--- a/arch/parisc/kernel/entry.S
+++ b/arch/parisc/kernel/entry.S
@@ -25,6 +25,7 @@
 #include <asm/traps.h>
 #include <asm/thread_info.h>
 #include <asm/alternative.h>
+#include <asm/spinlock_types.h>
 
 #include <linux/linkage.h>
 #include <linux/pgtable.h>
@@ -406,7 +407,7 @@
 	LDREG		0(\ptp),\pte
 	bb,<,n		\pte,_PAGE_PRESENT_BIT,3f
 	b		\fault
-	stw		\spc,0(\tmp)
+	stw		\tmp1,0(\tmp)
 99:	ALTERNATIVE(98b, 99b, ALT_COND_NO_SMP, INSN_NOP)
 #endif
 2:	LDREG		0(\ptp),\pte
@@ -415,24 +416,22 @@
 	.endm
 
 	/* Release page_table_lock without reloading lock address.
-	   Note that the values in the register spc are limited to
-	   NR_SPACE_IDS (262144). Thus, the stw instruction always
-	   stores a nonzero value even when register spc is 64 bits.
 	   We use an ordered store to ensure all prior accesses are
 	   performed prior to releasing the lock. */
-	.macro		ptl_unlock0	spc,tmp
+	.macro		ptl_unlock0	spc,tmp,tmp2
 #ifdef CONFIG_TLB_PTLOCK
-98:	or,COND(=)	%r0,\spc,%r0
-	stw,ma		\spc,0(\tmp)
+98:	ldi		__ARCH_SPIN_LOCK_UNLOCKED_VAL, \tmp2
+	or,COND(=)	%r0,\spc,%r0
+	stw,ma		\tmp2,0(\tmp)
 99:	ALTERNATIVE(98b, 99b, ALT_COND_NO_SMP, INSN_NOP)
 #endif
 	.endm
 
 	/* Release page_table_lock. */
-	.macro		ptl_unlock1	spc,tmp
+	.macro		ptl_unlock1	spc,tmp,tmp2
 #ifdef CONFIG_TLB_PTLOCK
 98:	get_ptl		\tmp
-	ptl_unlock0	\spc,\tmp
+	ptl_unlock0	\spc,\tmp,\tmp2
 99:	ALTERNATIVE(98b, 99b, ALT_COND_NO_SMP, INSN_NOP)
 #endif
 	.endm
@@ -1125,7 +1124,7 @@ dtlb_miss_20w:
 	
 	idtlbt          pte,prot
 
-	ptl_unlock1	spc,t0
+	ptl_unlock1	spc,t0,t1
 	rfir
 	nop
 
@@ -1151,7 +1150,7 @@ nadtlb_miss_20w:
 
 	idtlbt          pte,prot
 
-	ptl_unlock1	spc,t0
+	ptl_unlock1	spc,t0,t1
 	rfir
 	nop
 
@@ -1185,7 +1184,7 @@ dtlb_miss_11:
 
 	mtsp		t1, %sr1	/* Restore sr1 */
 
-	ptl_unlock1	spc,t0
+	ptl_unlock1	spc,t0,t1
 	rfir
 	nop
 
@@ -1218,7 +1217,7 @@ nadtlb_miss_11:
 
 	mtsp		t1, %sr1	/* Restore sr1 */
 
-	ptl_unlock1	spc,t0
+	ptl_unlock1	spc,t0,t1
 	rfir
 	nop
 
@@ -1247,7 +1246,7 @@ dtlb_miss_20:
 
 	idtlbt          pte,prot
 
-	ptl_unlock1	spc,t0
+	ptl_unlock1	spc,t0,t1
 	rfir
 	nop
 
@@ -1275,7 +1274,7 @@ nadtlb_miss_20:
 	
 	idtlbt		pte,prot
 
-	ptl_unlock1	spc,t0
+	ptl_unlock1	spc,t0,t1
 	rfir
 	nop
 
@@ -1320,7 +1319,7 @@ itlb_miss_20w:
 	
 	iitlbt          pte,prot
 
-	ptl_unlock1	spc,t0
+	ptl_unlock1	spc,t0,t1
 	rfir
 	nop
 
@@ -1344,7 +1343,7 @@ naitlb_miss_20w:
 
 	iitlbt          pte,prot
 
-	ptl_unlock1	spc,t0
+	ptl_unlock1	spc,t0,t1
 	rfir
 	nop
 
@@ -1378,7 +1377,7 @@ itlb_miss_11:
 
 	mtsp		t1, %sr1	/* Restore sr1 */
 
-	ptl_unlock1	spc,t0
+	ptl_unlock1	spc,t0,t1
 	rfir
 	nop
 
@@ -1402,7 +1401,7 @@ naitlb_miss_11:
 
 	mtsp		t1, %sr1	/* Restore sr1 */
 
-	ptl_unlock1	spc,t0
+	ptl_unlock1	spc,t0,t1
 	rfir
 	nop
 
@@ -1432,7 +1431,7 @@ itlb_miss_20:
 
 	iitlbt          pte,prot
 
-	ptl_unlock1	spc,t0
+	ptl_unlock1	spc,t0,t1
 	rfir
 	nop
 
@@ -1452,7 +1451,7 @@ naitlb_miss_20:
 
 	iitlbt          pte,prot
 
-	ptl_unlock1	spc,t0
+	ptl_unlock1	spc,t0,t1
 	rfir
 	nop
 
@@ -1482,7 +1481,7 @@ dbit_trap_20w:
 		
 	idtlbt          pte,prot
 
-	ptl_unlock0	spc,t0
+	ptl_unlock0	spc,t0,t1
 	rfir
 	nop
 #else
@@ -1508,7 +1507,7 @@ dbit_trap_11:
 
 	mtsp            t1, %sr1     /* Restore sr1 */
 
-	ptl_unlock0	spc,t0
+	ptl_unlock0	spc,t0,t1
 	rfir
 	nop
 
@@ -1528,7 +1527,7 @@ dbit_trap_20:
 	
 	idtlbt		pte,prot
 
-	ptl_unlock0	spc,t0
+	ptl_unlock0	spc,t0,t1
 	rfir
 	nop
 #endif
-- 
2.41.0



