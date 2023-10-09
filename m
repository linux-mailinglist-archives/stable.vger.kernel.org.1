Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4F57BDF82
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377014AbjJINaq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377081AbjJINao (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:30:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E96AB
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:30:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A37C433C9;
        Mon,  9 Oct 2023 13:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858242;
        bh=GscjUeA1zKvjvIgdu1p+deo/WjWx48emjxQwX4GPT8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=reZ3/jkmeJyg7ZSvXfuwEkmnhuBDixyKnTchMoNqw+txVZtOiVXr+2pni+1qn0+Z7
         yDgxyI879Pxyue5jl14zWEqRLqIKoYMsTYOKcjz2gzr4NRuKQ2CfefRbc8HlgKDXh8
         DfgAMYlGMwUepZMR+g/NYFLl8wclk7UAV0iyZOCk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benjamin Gray <bgray@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 061/131] powerpc/watchpoints: Annotate atomic context in more places
Date:   Mon,  9 Oct 2023 15:01:41 +0200
Message-ID: <20231009130118.160793244@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Gray <bgray@linux.ibm.com>

[ Upstream commit 27646b2e02b096a6936b3e3b6ba334ae20763eab ]

It can be easy to miss that the notifier mechanism invokes the callbacks
in an atomic context, so add some comments to that effect on the two
handlers we register here.

Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230829063457.54157-4-bgray@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/hw_breakpoint.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 1007ec36b4cb9..fb736fdb4193f 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -247,6 +247,11 @@ static bool stepping_handler(struct pt_regs *regs, struct perf_event *bp,
 	return false;
 }
 
+/*
+ * Handle a DABR or DAWR exception.
+ *
+ * Called in atomic context.
+ */
 int hw_breakpoint_handler(struct die_args *args)
 {
 	int rc = NOTIFY_STOP;
@@ -315,6 +320,8 @@ NOKPROBE_SYMBOL(hw_breakpoint_handler);
 
 /*
  * Handle single-step exceptions following a DABR hit.
+ *
+ * Called in atomic context.
  */
 static int single_step_dabr_instruction(struct die_args *args)
 {
@@ -355,6 +362,8 @@ NOKPROBE_SYMBOL(single_step_dabr_instruction);
 
 /*
  * Handle debug exception notifications.
+ *
+ * Called in atomic context.
  */
 int hw_breakpoint_exceptions_notify(
 		struct notifier_block *unused, unsigned long val, void *data)
-- 
2.40.1



