Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C9A7B87A7
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243838AbjJDSHv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243840AbjJDSHu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:07:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E86C1
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:07:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A743FC433C8;
        Wed,  4 Oct 2023 18:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442866;
        bh=OqmGTUmvoJXI8DoyVbZJ+cgKU+Kfk2sb644XFJrT5W4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WZox91ytYfMxes21VgrhqqaWDHD8lcEj9o27XsmYu4cSM33DZqSDIzQcxgC4DNTUf
         fZJSVLtt4zFqvBk1aGdo57vhoOjJQaepfckc7k5G03yWgD4hNfkzqo5elEAMjVsc5j
         RMmqnwyac3yxv+Z5BflOVaqisiTMSSD2VAhsOhfc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benjamin Gray <bgray@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 137/183] powerpc/watchpoints: Disable preemption in thread_change_pc()
Date:   Wed,  4 Oct 2023 19:56:08 +0200
Message-ID: <20231004175209.702314952@linuxfoundation.org>
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

[ Upstream commit cc879ab3ce39bc39f9b1d238b283f43a5f6f957d ]

thread_change_pc() uses CPU local data, so must be protected from
swapping CPUs while it is reading the breakpoint struct.

The error is more noticeable after 1e60f3564bad ("powerpc/watchpoints:
Track perf single step directly on the breakpoint"), which added an
unconditional __this_cpu_read() call in thread_change_pc(). However the
existing __this_cpu_read() that runs if a breakpoint does need to be
re-inserted has the same issue.

Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230829063457.54157-2-bgray@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/hw_breakpoint.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 91a3be14808b1..63fec0602af22 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -478,11 +478,13 @@ void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs)
 	struct arch_hw_breakpoint *info;
 	int i;
 
+	preempt_disable();
+
 	for (i = 0; i < nr_wp_slots(); i++) {
 		if (unlikely(tsk->thread.last_hit_ubp[i]))
 			goto reset;
 	}
-	return;
+	goto out;
 
 reset:
 	regs_set_return_msr(regs, regs->msr & ~MSR_SE);
@@ -491,6 +493,9 @@ void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs)
 		__set_breakpoint(i, info);
 		tsk->thread.last_hit_ubp[i] = NULL;
 	}
+
+out:
+	preempt_enable();
 }
 
 static bool is_larx_stcx_instr(int type)
-- 
2.40.1



