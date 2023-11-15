Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851677ED3A1
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbjKOUxt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbjKOUxr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:53:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C5BB0
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:53:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBBCC4E778;
        Wed, 15 Nov 2023 20:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081623;
        bh=lpbxC0je8mgGW0TEE0nggfCfZQcGtzgNokEfkCBp08c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YPirlAerXu4dTbzo5M/wlyIl4pK0H+fYdcjuBgORtgo0yJMRut2pA+vm0pay/jlhm
         5Pr0uRk2A/6bCazIIEiI7FMgvF9yZBwhtOEaI2zW46o6aY66THPKPyOszTQ0mSSpPf
         Npfonrp1M9kADp7HthlvqW4VcaGfH3sQ6VGfoz3M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 004/191] x86/srso: Fix SBPB enablement for (possible) future fixed HW
Date:   Wed, 15 Nov 2023 15:44:39 -0500
Message-ID: <20231115204644.787336332@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit 1d1142ac51307145dbb256ac3535a1d43a1c9800 ]

Make the SBPB check more robust against the (possible) case where future
HW has SRSO fixed but doesn't have the SRSO_NO bit set.

Fixes: 1b5277c0ea0b ("x86/srso: Add SRSO_NO support")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/cee5050db750b391c9f35f5334f8ff40e66c01b9.1693889988.git.jpoimboe@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ec3ddb9a456ba..d9fda0b6eb19e 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2407,7 +2407,7 @@ static void __init srso_select_mitigation(void)
 	pr_info("%s%s\n", srso_strings[srso_mitigation], (has_microcode ? "" : ", no microcode"));
 
 pred_cmd:
-	if ((boot_cpu_has(X86_FEATURE_SRSO_NO) || srso_cmd == SRSO_CMD_OFF) &&
+	if ((!boot_cpu_has_bug(X86_BUG_SRSO) || srso_cmd == SRSO_CMD_OFF) &&
 	     boot_cpu_has(X86_FEATURE_SBPB))
 		x86_pred_cmd = PRED_CMD_SBPB;
 }
-- 
2.42.0



