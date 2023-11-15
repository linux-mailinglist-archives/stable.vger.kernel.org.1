Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1CA7ECB1A
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjKOTUI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjKOTUI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:20:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B49A4
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:20:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35B6C433C9;
        Wed, 15 Nov 2023 19:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076004;
        bh=WtkCpZS6y3c5vT4jdItF84H9hM2x5j33WCSCBYcObKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n1Ozh9PGT7tq6qlWug6sCypwHHr7NA7ruVtfNx1ydnyQpZJnCPo7yJyPAyQ8Xyag6
         aOOia3oWSYCOudzCakP6TwuzPX7fEG/TKLdmtlipgheGWIBqg/CQKGbvLZ3JSD2qcs
         BpCh9xuNlkdYkKPnb0VvX5+fOZyGhsU/SOydG2b0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 015/550] x86/srso: Print mitigation for retbleed IBPB case
Date:   Wed, 15 Nov 2023 14:09:59 -0500
Message-ID: <20231115191601.779767302@linuxfoundation.org>
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

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit de9f5f7b06a5b7adbfdd8016f011120a4e928add ]

When overriding the requested mitigation with IBPB due to retbleed=ibpb,
print the mitigation in the usual format instead of a custom error
message.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/ec3af919e267773d896c240faf30bfc6a1fd6304.1693889988.git.jpoimboe@kernel.org
Stable-dep-of: dc6306ad5b0d ("x86/srso: Fix vulnerability reporting for missing microcode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 2859a54660a28..d5db0baca2f14 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2425,9 +2425,8 @@ static void __init srso_select_mitigation(void)
 
 	if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
 		if (has_microcode) {
-			pr_err("Retbleed IBPB mitigation enabled, using same for SRSO\n");
 			srso_mitigation = SRSO_MITIGATION_IBPB;
-			goto pred_cmd;
+			goto out;
 		}
 	}
 
@@ -2493,7 +2492,8 @@ static void __init srso_select_mitigation(void)
 		break;
 	}
 
-	pr_info("%s%s\n", srso_strings[srso_mitigation], (has_microcode ? "" : ", no microcode"));
+out:
+	pr_info("%s%s\n", srso_strings[srso_mitigation], has_microcode ? "" : ", no microcode");
 
 pred_cmd:
 	if ((!boot_cpu_has_bug(X86_BUG_SRSO) || srso_cmd == SRSO_CMD_OFF) &&
-- 
2.42.0



