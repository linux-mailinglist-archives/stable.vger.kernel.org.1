Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DB37D337C
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbjJWLav (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbjJWLat (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:30:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B18AF9
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:30:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB60AC433C7;
        Mon, 23 Oct 2023 11:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060647;
        bh=tt8kn+p7dPolhVRgn3LN2gxLlBtqHsrGlNkuY/f42H4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DA6SXqG3bY1asiNU7PAOddUXKVFScDG4yVRuSktzl8CO3jHNn6aSlwkESnKUruwzt
         F4Vtpt5+Cw9tO1um1HnwP4Zo5l4OpytlAeYiOQIT7W2L/uzrCEUh2pMsLol3gZKdoV
         h5Q0qu0OG0sUxKG1pq9xfwKsJzVzh4F3T03qpb6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactcode.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, stable@kernel.org
Subject: [PATCH 5.4 038/123] x86/cpu: Fix AMD erratum #1485 on Zen4-based CPUs
Date:   Mon, 23 Oct 2023 12:56:36 +0200
Message-ID: <20231023104819.005303582@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104817.691299567@linuxfoundation.org>
References: <20231023104817.691299567@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Borislav Petkov (AMD) <bp@alien8.de>

commit f454b18e07f518bcd0c05af17a2239138bff52de upstream.

Fix erratum #1485 on Zen4 parts where running with STIBP disabled can
cause an #UD exception. The performance impact of the fix is negligible.

Reported-by: René Rebe <rene@exactcode.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: René Rebe <rene@exactcode.de>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/D99589F4-BC5D-430B-87B2-72C20370CF57@exactcode.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/msr-index.h |    4 ++++
 arch/x86/kernel/cpu/amd.c        |    8 ++++++++
 2 files changed, 12 insertions(+)

--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -502,6 +502,10 @@
 
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
+/* Zen4 */
+#define MSR_ZEN4_BP_CFG			0xc001102e
+#define MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT 5
+
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
 
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -75,6 +75,10 @@ static const int amd_zenbleed[] =
 			   AMD_MODEL_RANGE(0x17, 0x90, 0x0, 0x91, 0xf),
 			   AMD_MODEL_RANGE(0x17, 0xa0, 0x0, 0xaf, 0xf));
 
+static const int amd_erratum_1485[] =
+	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x19, 0x10, 0x0, 0x1f, 0xf),
+			   AMD_MODEL_RANGE(0x19, 0x60, 0x0, 0xaf, 0xf));
+
 static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum)
 {
 	int osvw_id = *erratum++;
@@ -1117,6 +1121,10 @@ static void init_amd(struct cpuinfo_x86
 	check_null_seg_clears_base(c);
 
 	zenbleed_check(c);
+
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
+	     cpu_has_amd_erratum(c, amd_erratum_1485))
+		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT);
 }
 
 #ifdef CONFIG_X86_32


