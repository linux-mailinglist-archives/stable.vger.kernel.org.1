Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103527B8973
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244191AbjJDS0E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244194AbjJDS0D (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:26:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E7DA6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:25:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6996C433C7;
        Wed,  4 Oct 2023 18:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443959;
        bh=TVeUQFkAPVB0P+3S5YGj7S6U2ieDypu1ekAkOogjDhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pLl3XgQAEIEkNrbS6DpPmRGeaovLnkiZFJAgDH7DXBqUI45bkaKD86cfwAVE7l620
         rXfMRPJ/pYc7Rg/pDZ7c/L62aYVdrkkQBoajfs/A+lEJ1LeNSsIEQvBSNO9COlPWXU
         VPq5ZUW5rp8CqT+WgQiB294fK/SV4/FOj4ETbRyw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrew Cooper <andrew.cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 080/321] x86/srso: Dont probe microcode in a guest
Date:   Wed,  4 Oct 2023 19:53:45 +0200
Message-ID: <20231004175232.926394075@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit 02428d0366a27c2f33bc4361eb10467777804f29 ]

To support live migration, the hypervisor sets the "lowest common
denominator" of features.  Probing the microcode isn't allowed because
any detected features might go away after a migration.

As Andy Cooper states:

  "Linux must not probe microcode when virtualised.  What it may see
  instantaneously on boot (owing to MSR_PRED_CMD being fully passed
  through) is not accurate for the lifetime of the VM."

Rely on the hypervisor to set the needed IBPB_BRTYPE and SBPB bits.

Fixes: 1b5277c0ea0b ("x86/srso: Add SRSO_NO support")
Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/3938a7209606c045a3f50305d201d840e8c834c7.1693889988.git.jpoimboe@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index b08af929135d9..28e77c5d6484a 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -767,7 +767,7 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 	if (cpu_has(c, X86_FEATURE_TOPOEXT))
 		smp_num_siblings = ((cpuid_ebx(0x8000001e) >> 8) & 0xff) + 1;
 
-	if (!cpu_has(c, X86_FEATURE_IBPB_BRTYPE)) {
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) && !cpu_has(c, X86_FEATURE_IBPB_BRTYPE)) {
 		if (c->x86 == 0x17 && boot_cpu_has(X86_FEATURE_AMD_IBPB))
 			setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
 		else if (c->x86 >= 0x19 && !wrmsrl_safe(MSR_IA32_PRED_CMD, PRED_CMD_SBPB)) {
-- 
2.40.1



