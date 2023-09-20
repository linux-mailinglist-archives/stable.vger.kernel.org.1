Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9749A7A7C80
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbjITMBy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbjITMBv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:01:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE351123
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:01:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BEEC433C8;
        Wed, 20 Sep 2023 12:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211304;
        bh=LCFbo/3k2gYohKs20YIKnqIE6xPAj2K9tNsoj6CI1JU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j81JUgJRuwK6Y/padpnrALl490ghmNl5OAUbQ4lE7nH6zQs1M3gCmHGW+yDVfYOT/
         uNQ1YUSVfsaaNBSdhlALWK4v3n1HsNdhkni4adudFvF+YcZmOsA7MdWlrBIV6MQmau
         Ez5HFi44ZSx6hFNGbEaVi5QBtUsV8kaTMnoqCpe0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ben Hutchings <benh@debian.org>,
        Jan-Benedict Glaw <jbglaw@lug-owl.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 017/186] m68k: Fix invalid .section syntax
Date:   Wed, 20 Sep 2023 13:28:40 +0200
Message-ID: <20230920112837.491021451@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <benh@debian.org>

[ Upstream commit 922a9bd138101e3e5718f0f4d40dba68ef89bb43 ]

gas supports several different forms for .section for ELF targets,
including:
    .section NAME [, "FLAGS"[, @TYPE[,FLAG_SPECIFIC_ARGUMENTS]]]
and:
    .section "NAME"[, #FLAGS...]

In several places we use a mix of these two forms:
    .section NAME, #FLAGS...

A current development snapshot of binutils (2.40.50.20230611) treats
this mixed syntax as an error.

Change to consistently use:
    .section NAME, "FLAGS"
as is used elsewhere in the kernel.

Link: https://buildd.debian.org/status/fetch.php?pkg=linux&arch=m68k&ver=6.4%7Erc6-1%7Eexp1&stamp=1686907300&raw=1
Signed-off-by: Ben Hutchings <benh@debian.org>
Tested-by: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Link: https://lore.kernel.org/r/ZIyBaueWT9jnTwRC@decadent.org.uk
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/m68k/fpsp040/skeleton.S       | 4 ++--
 arch/m68k/ifpsp060/os.S            | 4 ++--
 arch/m68k/kernel/relocate_kernel.S | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
index a8f41615d94a7..31a9c634c81ed 100644
--- a/arch/m68k/fpsp040/skeleton.S
+++ b/arch/m68k/fpsp040/skeleton.S
@@ -499,12 +499,12 @@ in_ea:
 	dbf	%d0,morein
 	rts
 
-	.section .fixup,#alloc,#execinstr
+	.section .fixup,"ax"
 	.even
 1:
 	jbra	fpsp040_die
 
-	.section __ex_table,#alloc
+	.section __ex_table,"a"
 	.align	4
 
 	.long	in_ea,1b
diff --git a/arch/m68k/ifpsp060/os.S b/arch/m68k/ifpsp060/os.S
index 7a0d6e4280665..89e2ec224ab6c 100644
--- a/arch/m68k/ifpsp060/os.S
+++ b/arch/m68k/ifpsp060/os.S
@@ -379,11 +379,11 @@ _060_real_access:
 
 
 | Execption handling for movs access to illegal memory
-	.section .fixup,#alloc,#execinstr
+	.section .fixup,"ax"
 	.even
 1:	moveq		#-1,%d1
 	rts
-.section __ex_table,#alloc
+.section __ex_table,"a"
 	.align 4
 	.long	dmrbuae,1b
 	.long	dmrwuae,1b
diff --git a/arch/m68k/kernel/relocate_kernel.S b/arch/m68k/kernel/relocate_kernel.S
index ab0f1e7d46535..f7667079e08e9 100644
--- a/arch/m68k/kernel/relocate_kernel.S
+++ b/arch/m68k/kernel/relocate_kernel.S
@@ -26,7 +26,7 @@ ENTRY(relocate_new_kernel)
 	lea %pc@(.Lcopy),%a4
 2:	addl #0x00000000,%a4		/* virt_to_phys() */
 
-	.section ".m68k_fixup","aw"
+	.section .m68k_fixup,"aw"
 	.long M68K_FIXUP_MEMOFFSET, 2b+2
 	.previous
 
@@ -49,7 +49,7 @@ ENTRY(relocate_new_kernel)
 	lea %pc@(.Lcont040),%a4
 5:	addl #0x00000000,%a4		/* virt_to_phys() */
 
-	.section ".m68k_fixup","aw"
+	.section .m68k_fixup,"aw"
 	.long M68K_FIXUP_MEMOFFSET, 5b+2
 	.previous
 
-- 
2.40.1



