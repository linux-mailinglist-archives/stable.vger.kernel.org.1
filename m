Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D467ECB46
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjKOTVc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbjKOTVR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:21:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF1D1995
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:21:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5494C433C9;
        Wed, 15 Nov 2023 19:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076068;
        bh=zS90PhcdHG/kR5Y0JCUgsmJGkAijjbfwa9NKEyijK+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fTYiwtxzZS9faTxVpk8Wc9q9Kp+ilqR4i5BWEXInMgiF88WJVM/M5IzB2urIklskI
         sYbU7uQ5N77XRUrk9/NmuKENsVWCPAohu72tGSWsb0oz2F3fhb6AktBneaJVDaFJDv
         7d/FtuMszdwdPxvF9ocM2+3RZJPwaQ80V99XZZAA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chris Mason <clm@fb.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 029/550] x86/nmi: Fix out-of-order NMI nesting checks & false positive warning
Date:   Wed, 15 Nov 2023 14:10:13 -0500
Message-ID: <20231115191602.754611455@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul E. McKenney <paulmck@kernel.org>

[ Upstream commit f44075ecafb726830e63d33fbca29413149eeeb8 ]

The ->idt_seq and ->recv_jiffies variables added by:

  1a3ea611fc10 ("x86/nmi: Accumulate NMI-progress evidence in exc_nmi()")

... place the exit-time check of the bottom bit of ->idt_seq after the
this_cpu_dec_return() that re-enables NMI nesting.  This can result in
the following sequence of events on a given CPU in kernels built with
CONFIG_NMI_CHECK_CPU=y:

  o   An NMI arrives, and ->idt_seq is incremented to an odd number.
      In addition, nmi_state is set to NMI_EXECUTING==1.

  o   The NMI is processed.

  o   The this_cpu_dec_return(nmi_state) zeroes nmi_state and returns
      NMI_EXECUTING==1, thus opting out of the "goto nmi_restart".

  o   Another NMI arrives and ->idt_seq is incremented to an even
      number, triggering the warning.  But all is just fine, at least
      assuming we don't get so many closely spaced NMIs that the stack
      overflows or some such.

Experience on the fleet indicates that the MTBF of this false positive
is about 70 years.  Or, for those who are not quite that patient, the
MTBF appears to be about one per week per 4,000 systems.

Fix this false-positive warning by moving the "nmi_restart" label before
the initial ->idt_seq increment/check and moving the this_cpu_dec_return()
to follow the final ->idt_seq increment/check.  This way, all nested NMIs
that get past the NMI_NOT_RUNNING check get a clean ->idt_seq slate.
And if they don't get past that check, they will set nmi_state to
NMI_LATCHED, which will cause the this_cpu_dec_return(nmi_state)
to restart.

Fixes: 1a3ea611fc10 ("x86/nmi: Accumulate NMI-progress evidence in exc_nmi()")
Reported-by: Chris Mason <clm@fb.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/0cbff831-6e3d-431c-9830-ee65ee7787ff@paulmck-laptop
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/nmi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index a0c551846b35f..4766b6bed4439 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -507,12 +507,13 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 	}
 	this_cpu_write(nmi_state, NMI_EXECUTING);
 	this_cpu_write(nmi_cr2, read_cr2());
+
+nmi_restart:
 	if (IS_ENABLED(CONFIG_NMI_CHECK_CPU)) {
 		WRITE_ONCE(nsp->idt_seq, nsp->idt_seq + 1);
 		WARN_ON_ONCE(!(nsp->idt_seq & 0x1));
 		WRITE_ONCE(nsp->recv_jiffies, jiffies);
 	}
-nmi_restart:
 
 	/*
 	 * Needs to happen before DR7 is accessed, because the hypervisor can
@@ -548,16 +549,16 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 
 	if (unlikely(this_cpu_read(nmi_cr2) != read_cr2()))
 		write_cr2(this_cpu_read(nmi_cr2));
-	if (this_cpu_dec_return(nmi_state))
-		goto nmi_restart;
-
-	if (user_mode(regs))
-		mds_user_clear_cpu_buffers();
 	if (IS_ENABLED(CONFIG_NMI_CHECK_CPU)) {
 		WRITE_ONCE(nsp->idt_seq, nsp->idt_seq + 1);
 		WARN_ON_ONCE(nsp->idt_seq & 0x1);
 		WRITE_ONCE(nsp->recv_jiffies, jiffies);
 	}
+	if (this_cpu_dec_return(nmi_state))
+		goto nmi_restart;
+
+	if (user_mode(regs))
+		mds_user_clear_cpu_buffers();
 }
 
 #if IS_ENABLED(CONFIG_KVM_INTEL)
-- 
2.42.0



