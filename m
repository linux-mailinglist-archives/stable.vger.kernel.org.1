Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAF2775CBA
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjHILaT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbjHILaS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:30:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0FD10D4
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:30:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AFD66314C
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A67C433C8;
        Wed,  9 Aug 2023 11:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580617;
        bh=AVeDOUDWGSLu12toBHYtubFriRDGhczyHiMbxxOFsZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OV9opa6DEfrNDoNu1itJo4mJwP41OqizZh+oq/F+WItFFhQgK4N6xXaChujWBYk5R
         /xl8gyhio4gvFFZ+K57m2eXepuGunHkj51CeChi0ku39grPWruQg6ljn5lhjBSEIzG
         By8iymYx+HYppBmJMNVAJ79ecj+dn5ucQz8s/dWQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        D Scott Phillips <scott@os.amperecomputing.com>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ovidiu Panait <ovidiu.panait@windriver.com>
Subject: [PATCH 5.4 089/154] arm64: Add AMPERE1 to the Spectre-BHB affected list
Date:   Wed,  9 Aug 2023 12:42:00 +0200
Message-ID: <20230809103639.934666719@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: D Scott Phillips <scott@os.amperecomputing.com>

commit 0e5d5ae837c8ce04d2ddb874ec5f920118bd9d31 upstream.

Per AmpereOne erratum AC03_CPU_12, "Branch history may allow control of
speculative execution across software contexts," the AMPERE1 core needs the
bhb clearing loop to mitigate Spectre-BHB, with a loop iteration count of
11.

Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
Link: https://lore.kernel.org/r/20221011022140.432370-1-scott@os.amperecomputing.com
Reviewed-by: James Morse <james.morse@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/cputype.h |    4 ++++
 arch/arm64/kernel/cpu_errata.c   |    6 ++++++
 2 files changed, 10 insertions(+)

--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -59,6 +59,7 @@
 #define ARM_CPU_IMP_NVIDIA		0x4E
 #define ARM_CPU_IMP_FUJITSU		0x46
 #define ARM_CPU_IMP_HISI		0x48
+#define ARM_CPU_IMP_AMPERE		0xC0
 
 #define ARM_CPU_PART_AEM_V8		0xD0F
 #define ARM_CPU_PART_FOUNDATION		0xD00
@@ -101,6 +102,8 @@
 
 #define HISI_CPU_PART_TSV110		0xD01
 
+#define AMPERE_CPU_PART_AMPERE1		0xAC3
+
 #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
 #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
 #define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
@@ -131,6 +134,7 @@
 #define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
 #define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
 #define MIDR_HISI_TSV110 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV110)
+#define MIDR_AMPERE1 MIDR_CPU_MODEL(ARM_CPU_IMP_AMPERE, AMPERE_CPU_PART_AMPERE1)
 
 /* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and v1r0) */
 #define MIDR_FUJITSU_ERRATUM_010001		MIDR_FUJITSU_A64FX
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -1145,6 +1145,10 @@ u8 spectre_bhb_loop_affected(int scope)
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
 			{},
 		};
+		static const struct midr_range spectre_bhb_k11_list[] = {
+			MIDR_ALL_VERSIONS(MIDR_AMPERE1),
+			{},
+		};
 		static const struct midr_range spectre_bhb_k8_list[] = {
 			MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
 			MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
@@ -1155,6 +1159,8 @@ u8 spectre_bhb_loop_affected(int scope)
 			k = 32;
 		else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k24_list))
 			k = 24;
+		else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k11_list))
+			k = 11;
 		else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k8_list))
 			k =  8;
 


