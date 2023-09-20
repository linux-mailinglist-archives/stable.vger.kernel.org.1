Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15A57A7B47
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbjITLux (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbjITLuw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:50:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02878A3
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:50:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51892C433C8;
        Wed, 20 Sep 2023 11:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210646;
        bh=gMOYELr0Yw9JtSJmQcY7P4V0uPegjpU1czjBLhVqXB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H3znkCrJ9fB4XScWQFtf7RoK7wZBSxpmCcRnTvw26tRkz+0aPQE0alfNT0A1EZWNt
         ZNNpJGHsulHymfFtx9SqRYSH0nfgtVtrdHaBP7zFVvszXupJh/dF9b7pJ0R5uwRCK+
         EQT9zA6/dlxww45+5TA28fTnQdk1PTRy9Gzy+aBQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Kaplan <David.Kaplan@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 152/211] x86/ibt: Avoid duplicate ENDBR in __put_user_nocheck*()
Date:   Wed, 20 Sep 2023 13:29:56 +0200
Message-ID: <20230920112850.584691164@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 7575e5a35267983dcbeb1e0d3a49d21ae3cf0b82 ]

Commit cb855971d717 ("x86/putuser: Provide room for padding") changed
__put_user_nocheck_*() into proper functions but failed to note that
SYM_FUNC_START() already provides ENDBR, rendering the explicit ENDBR
superfluous.

Fixes: cb855971d717 ("x86/putuser: Provide room for padding")
Reported-by: David Kaplan <David.Kaplan@amd.com>
Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230802110323.086971726@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/lib/putuser.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 1451e0c4ae22a..235bbda6fc823 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -56,7 +56,6 @@ SYM_FUNC_END(__put_user_1)
 EXPORT_SYMBOL(__put_user_1)
 
 SYM_FUNC_START(__put_user_nocheck_1)
-	ENDBR
 	ASM_STAC
 2:	movb %al,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -76,7 +75,6 @@ SYM_FUNC_END(__put_user_2)
 EXPORT_SYMBOL(__put_user_2)
 
 SYM_FUNC_START(__put_user_nocheck_2)
-	ENDBR
 	ASM_STAC
 4:	movw %ax,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -96,7 +94,6 @@ SYM_FUNC_END(__put_user_4)
 EXPORT_SYMBOL(__put_user_4)
 
 SYM_FUNC_START(__put_user_nocheck_4)
-	ENDBR
 	ASM_STAC
 6:	movl %eax,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -119,7 +116,6 @@ SYM_FUNC_END(__put_user_8)
 EXPORT_SYMBOL(__put_user_8)
 
 SYM_FUNC_START(__put_user_nocheck_8)
-	ENDBR
 	ASM_STAC
 9:	mov %_ASM_AX,(%_ASM_CX)
 #ifdef CONFIG_X86_32
-- 
2.40.1



