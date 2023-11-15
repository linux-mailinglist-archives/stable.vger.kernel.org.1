Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469C27ECCF1
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbjKOTd2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbjKOTd1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:33:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C782919F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:33:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE33C433C8;
        Wed, 15 Nov 2023 19:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076804;
        bh=kBM8S+hkiOR6ufgsbqaZIiSa0YfSTtYvMteNrxXrc9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xHFRhvvKZ929/TPuWBXfnv9BonI3ZtKIzu6FhMMeEyqXRh63H5rs0KayaRa9Qdi6J
         1LjkigSRmPLxTsLoeQUF8zU578KQ9FvYVxSuxn6OgZznnbEpj5wdevlKD8tVRU53/W
         6GGVlsWfUK0brkVOScmvLhz6kSiBoWlSixtOCg5Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 014/603] x86/srso: Fix SBPB enablement for (possible) future fixed HW
Date:   Wed, 15 Nov 2023 14:09:19 -0500
Message-ID: <20231115191614.146451947@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index 10499bcd4e396..2859a54660a28 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2496,7 +2496,7 @@ static void __init srso_select_mitigation(void)
 	pr_info("%s%s\n", srso_strings[srso_mitigation], (has_microcode ? "" : ", no microcode"));
 
 pred_cmd:
-	if ((boot_cpu_has(X86_FEATURE_SRSO_NO) || srso_cmd == SRSO_CMD_OFF) &&
+	if ((!boot_cpu_has_bug(X86_BUG_SRSO) || srso_cmd == SRSO_CMD_OFF) &&
 	     boot_cpu_has(X86_FEATURE_SBPB))
 		x86_pred_cmd = PRED_CMD_SBPB;
 }
-- 
2.42.0



