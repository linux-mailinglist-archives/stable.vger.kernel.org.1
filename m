Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8755074C391
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjGILds (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjGILdo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:33:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A931118F
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:33:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EF1C60BC0
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501B2C433C7;
        Sun,  9 Jul 2023 11:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902422;
        bh=B32SVhQMe+FpiMbO6keH5Pk5eWOnQv6AS1MyQdnAyUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UUkM6SbyHt8FZE0Hb6VF5QGNDxw+JPoH0lYkO8e2jndRvqXtVlWvDpd6pRuqJQFLb
         kwhTag8YXWMwgRHPwTIu8efbUf47SyDeU9Hjg0xLcgKqQcPyq18eJEyUYAuJ6w68qO
         swIPwJ2CYRrV4vq8UUKwGR7W7PwPZd2v2/GkIqP8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 371/431] powerpc/signal32: Force inlining of __unsafe_save_user_regs() and save_tm_user_regs_unsafe()
Date:   Sun,  9 Jul 2023 13:15:19 +0200
Message-ID: <20230709111459.860958592@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit a03b1a0b19398a47489fdcef02ec19c2ba05a15d ]

Looking at generated code for handle_signal32() shows calls to a
function called __unsafe_save_user_regs.constprop.0 while user access
is open.

And that __unsafe_save_user_regs.constprop.0 function has two nops at
the begining, allowing it to be traced, which is unexpected during
user access open window.

The solution could be to mark __unsafe_save_user_regs() no trace, but
to be on the safe side the most efficient is to flag it __always_inline
as already done for function __unsafe_restore_general_regs(). The
function is relatively small and only called twice, so the size
increase will remain in the noise.

Do the same with save_tm_user_regs_unsafe() as it may suffer the
same issue.

Fixes: ef75e7318294 ("powerpc/signal32: Transform save_user_regs() and save_tm_user_regs() in 'unsafe' version")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/7e469c8f01860a69c1ada3ca6a5e2aa65f0f74b2.1685955220.git.christophe.leroy@csgroup.eu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/signal_32.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index c114c7f25645c..7a718ed32b277 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -264,8 +264,9 @@ static void prepare_save_user_regs(int ctx_has_vsx_region)
 #endif
 }
 
-static int __unsafe_save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
-				   struct mcontext __user *tm_frame, int ctx_has_vsx_region)
+static __always_inline int
+__unsafe_save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
+			struct mcontext __user *tm_frame, int ctx_has_vsx_region)
 {
 	unsigned long msr = regs->msr;
 
@@ -364,8 +365,9 @@ static void prepare_save_tm_user_regs(void)
 		current->thread.ckvrsave = mfspr(SPRN_VRSAVE);
 }
 
-static int save_tm_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user *frame,
-				    struct mcontext __user *tm_frame, unsigned long msr)
+static __always_inline int
+save_tm_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user *frame,
+			 struct mcontext __user *tm_frame, unsigned long msr)
 {
 	/* Save both sets of general registers */
 	unsafe_save_general_regs(&current->thread.ckpt_regs, frame, failed);
@@ -444,8 +446,9 @@ static int save_tm_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user
 #else
 static void prepare_save_tm_user_regs(void) { }
 
-static int save_tm_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user *frame,
-				    struct mcontext __user *tm_frame, unsigned long msr)
+static __always_inline int
+save_tm_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user *frame,
+			 struct mcontext __user *tm_frame, unsigned long msr)
 {
 	return 0;
 }
-- 
2.39.2



