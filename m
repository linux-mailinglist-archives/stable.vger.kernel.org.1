Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E122D75CE28
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjGUQSi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjGUQSG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:18:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6145421B
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:17:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCA1B61D29
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB41C433CA;
        Fri, 21 Jul 2023 16:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956221;
        bh=QKg4sBedqvhdy39FPwOEy1xhGOjxj8ogiro2joN9/Ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CkWWloE8n8MZvIfFLqC/CNScHeMLFc7Ln1DeK9YDCPGmTci4Ari0X37VzqziUACiB
         6TrBhoZ/U9GUOHvbDvqOlytqyDTOFNl09nmO42hct84MmqvX6b1u3q+AoNEavKilw0
         r/9IqemzJEUrQxa69+Sf5dJgtB/mmT9DGvUIlL9E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nageswara R Sastry <rnsastry@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 6.4 143/292] powerpc/security: Fix Speculation_Store_Bypass reporting on Power10
Date:   Fri, 21 Jul 2023 18:04:12 +0200
Message-ID: <20230721160535.032102608@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

commit 5bcedc5931e7bd6928a2d8207078d4cb476b3b55 upstream.

Nageswara reported that /proc/self/status was showing "vulnerable" for
the Speculation_Store_Bypass feature on Power10, eg:

  $ grep Speculation_Store_Bypass: /proc/self/status
  Speculation_Store_Bypass:       vulnerable

But at the same time the sysfs files, and lscpu, were showing "Not
affected".

This turns out to simply be a bug in the reporting of the
Speculation_Store_Bypass, aka. PR_SPEC_STORE_BYPASS, case.

When SEC_FTR_STF_BARRIER was added, so that firmware could communicate
the vulnerability was not present, the code in ssb_prctl_get() was not
updated to check the new flag.

So add the check for SEC_FTR_STF_BARRIER being disabled. Rather than
adding the new check to the existing if block and expanding the comment
to cover both cases, rewrite the three cases to be separate so they can
be commented separately for clarity.

Fixes: 84ed26fd00c5 ("powerpc/security: Add a security feature for STF barrier")
Cc: stable@vger.kernel.org # v5.14+
Reported-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
Reviewed-by: Russell Currey <ruscur@russell.cc>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230517074945.53188-1-mpe@ellerman.id.au
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/security.c |   35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -364,26 +364,27 @@ ssize_t cpu_show_spec_store_bypass(struc
 
 static int ssb_prctl_get(struct task_struct *task)
 {
+	/*
+	 * The STF_BARRIER feature is on by default, so if it's off that means
+	 * firmware has explicitly said the CPU is not vulnerable via either
+	 * the hypercall or device tree.
+	 */
+	if (!security_ftr_enabled(SEC_FTR_STF_BARRIER))
+		return PR_SPEC_NOT_AFFECTED;
+
+	/*
+	 * If the system's CPU has no known barrier (see setup_stf_barrier())
+	 * then assume that the CPU is not vulnerable.
+	 */
 	if (stf_enabled_flush_types == STF_BARRIER_NONE)
-		/*
-		 * We don't have an explicit signal from firmware that we're
-		 * vulnerable or not, we only have certain CPU revisions that
-		 * are known to be vulnerable.
-		 *
-		 * We assume that if we're on another CPU, where the barrier is
-		 * NONE, then we are not vulnerable.
-		 */
 		return PR_SPEC_NOT_AFFECTED;
-	else
-		/*
-		 * If we do have a barrier type then we are vulnerable. The
-		 * barrier is not a global or per-process mitigation, so the
-		 * only value we can report here is PR_SPEC_ENABLE, which
-		 * appears as "vulnerable" in /proc.
-		 */
-		return PR_SPEC_ENABLE;
 
-	return -EINVAL;
+	/*
+	 * Otherwise the CPU is vulnerable. The barrier is not a global or
+	 * per-process mitigation, so the only value that can be reported here
+	 * is PR_SPEC_ENABLE, which appears as "vulnerable" in /proc.
+	 */
+	return PR_SPEC_ENABLE;
 }
 
 int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which)


