Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1A97B87A8
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243843AbjJDSHw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243840AbjJDSHw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:07:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E4CA7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:07:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEB1C433C8;
        Wed,  4 Oct 2023 18:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442868;
        bh=VDqd4mRNO7qPVQL0tnXoJuX3Exc6XpL5eI/9JmGzjtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YKgCaF70FoYTSHPumM5RNWqBhPkXFol6HLdjXsy/mXiAhbuO/B2kHTboXUly37wJy
         sSbKnvKXyWA34XsH0r+l8FasEI32fuUPz/ClIcDG3VqN6mESsQt9L3QYYodjTnK3dP
         7N3/6R0Gw+gBogYcQCBroAuwHV8hJ75XYTmdvzpk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benjamin Gray <bgray@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 138/183] powerpc/watchpoint: Disable pagefaults when getting user instruction
Date:   Wed,  4 Oct 2023 19:56:09 +0200
Message-ID: <20231004175209.749471131@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Gray <bgray@linux.ibm.com>

[ Upstream commit 3241f260eb830d27d09cc604690ec24533fdb433 ]

This is called in an atomic context, so is not allowed to sleep if a
user page needs to be faulted in and has nowhere it can be deferred to.
The pagefault_disabled() function is documented as preventing user
access methods from sleeping.

In practice the page will be mapped in nearly always because we are
reading the instruction that just triggered the watchpoint trap.

Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230829063457.54157-3-bgray@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/hw_breakpoint_constraints.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint_constraints.c b/arch/powerpc/kernel/hw_breakpoint_constraints.c
index 675d1f66ab728..a541e3b755479 100644
--- a/arch/powerpc/kernel/hw_breakpoint_constraints.c
+++ b/arch/powerpc/kernel/hw_breakpoint_constraints.c
@@ -140,8 +140,13 @@ void wp_get_instr_detail(struct pt_regs *regs, struct ppc_inst *instr,
 			 int *type, int *size, unsigned long *ea)
 {
 	struct instruction_op op;
+	int err;
 
-	if (__get_user_instr(*instr, (void __user *)regs->nip))
+	pagefault_disable();
+	err = __get_user_instr(*instr, (void __user *)regs->nip);
+	pagefault_enable();
+
+	if (err)
 		return;
 
 	analyse_instr(&op, regs, *instr);
-- 
2.40.1



