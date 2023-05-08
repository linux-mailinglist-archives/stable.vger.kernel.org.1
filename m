Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD946FAE9F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbjEHLqZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236176AbjEHLqH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:46:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2FD10A0D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:45:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1B33636C6
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7821C433EF;
        Mon,  8 May 2023 11:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546349;
        bh=F753jiFqFfVCKZ9Q9CF9z7+WQn9M5M9lyQOMkbb8O9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P9I0d46B+nJwbdiLJu7kgc1pz9Vf8Bs/cPiAX73dUR2LJkH1UA9NuWCaWtHq4WBN2
         66s1sj9HoKhP0X43MXCMWVjhP+0QnnGDhiInK5A2xM4aXOQOMEOkXGkjhAQ787GXUL
         bilKy+w/DTs3FbzEwkH/L2ik4tBcu/IgCPiHllbo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stafford Horne <shorne@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 321/371] openrisc: Properly store r31 to pt_regs on unhandled exceptions
Date:   Mon,  8 May 2023 11:48:42 +0200
Message-Id: <20230508094824.817424383@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Stafford Horne <shorne@gmail.com>

[ Upstream commit 812489ac4dd91144a74ce65ecf232252a2e406fb ]

In commit 91993c8c2ed5 ("openrisc: use shadow registers to save regs on
exception") the unhandled exception path was changed to do an early
store of r30 instead of r31.  The entry code was not updated and r31 is
not getting stored to pt_regs.

This patch updates the entry handler to store r31 instead of r30.  We
also remove some misleading commented out store r30 and r31
instructrions.

I noticed this while working on adding floating point exception
handling,  This issue probably would never impact anything since we kill
the process or Oops right away on unhandled exceptions.

Fixes: 91993c8c2ed5 ("openrisc: use shadow registers to save regs on exception")
Signed-off-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/openrisc/kernel/entry.S | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index c68f3349c1741..d32906e89aafd 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -173,7 +173,6 @@ handler:							;\
 	l.sw    PT_GPR28(r1),r28					;\
 	l.sw    PT_GPR29(r1),r29					;\
 	/* r30 already save */					;\
-/*        l.sw    PT_GPR30(r1),r30*/					;\
 	l.sw    PT_GPR31(r1),r31					;\
 	TRACE_IRQS_OFF_ENTRY						;\
 	/* Store -1 in orig_gpr11 for non-syscall exceptions */	;\
@@ -211,9 +210,8 @@ handler:							;\
 	l.sw    PT_GPR27(r1),r27					;\
 	l.sw    PT_GPR28(r1),r28					;\
 	l.sw    PT_GPR29(r1),r29					;\
-	/* r31 already saved */					;\
-	l.sw    PT_GPR30(r1),r30					;\
-/*        l.sw    PT_GPR31(r1),r31	*/				;\
+	/* r30 already saved */						;\
+	l.sw    PT_GPR31(r1),r31					;\
 	/* Store -1 in orig_gpr11 for non-syscall exceptions */	;\
 	l.addi	r30,r0,-1					;\
 	l.sw	PT_ORIG_GPR11(r1),r30				;\
-- 
2.39.2



