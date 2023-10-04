Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE8C7B88DC
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243893AbjJDSUY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243894AbjJDSUX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:20:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200029E
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:20:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69623C433C7;
        Wed,  4 Oct 2023 18:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443619;
        bh=oJEanKGjWN08NLnvjAOKnKUF13SC9HEUogjLRsJ3Gc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R6VwoUBbTO1cnT+9h97MKfSsLh9hVmfzqJlt5KjNvqIqRJOqMFeLisAWLGFYbhAah
         sTHNW7PMuxiQ2ZE4SVrQ1sSq0HjqvvTI0BdwmeQTh9HXiPqDrw54y+a/xYZB+c1lUq
         +jjNzBSOtg4eMPM1MOCIwqbGdtYOuVNqZq2NNuMs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benjamin Gray <bgray@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 192/259] powerpc/watchpoints: Annotate atomic context in more places
Date:   Wed,  4 Oct 2023 19:56:05 +0200
Message-ID: <20231004175226.103913637@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index a72f86c130488..02436f80e60e2 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -637,6 +637,11 @@ static void handle_p10dd1_spurious_exception(struct arch_hw_breakpoint **info,
 	}
 }
 
+/*
+ * Handle a DABR or DAWR exception.
+ *
+ * Called in atomic context.
+ */
 int hw_breakpoint_handler(struct die_args *args)
 {
 	bool err = false;
@@ -763,6 +768,8 @@ NOKPROBE_SYMBOL(hw_breakpoint_handler);
 
 /*
  * Handle single-step exceptions following a DABR hit.
+ *
+ * Called in atomic context.
  */
 static int single_step_dabr_instruction(struct die_args *args)
 {
@@ -820,6 +827,8 @@ NOKPROBE_SYMBOL(single_step_dabr_instruction);
 
 /*
  * Handle debug exception notifications.
+ *
+ * Called in atomic context.
  */
 int hw_breakpoint_exceptions_notify(
 		struct notifier_block *unused, unsigned long val, void *data)
-- 
2.40.1



