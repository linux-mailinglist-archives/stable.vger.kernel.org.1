Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6190D76AE02
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbjHAJfc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjHAJfN (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:35:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7E1448A
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:32:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 213F8614B2
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDB7C433C7;
        Tue,  1 Aug 2023 09:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882374;
        bh=tgKwbgpzRK/KwYyqzWd6IvLXjzSO9eCd/e2rFe+jTkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dQYWxTHyVYJwHi1xr49ABp77ZhLb571Bq2Z19RGlamnUq5Mrl6Ho/nY39Jxv2f3qH
         VP3043yCodj505c6JfT7F491lihozithdJOYv3duI6K/BnLKsPmqQrjmQkaeYb3ASc
         tfybLLPMRbHB/34mtBzsCL8NWVtGMJ6Mool21LK8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Darren Hart <darren@os.amperecomputing.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 054/228] arm64: errata: Mitigate Ampere1 erratum AC03_CPU_38 at stage-2
Date:   Tue,  1 Aug 2023 11:18:32 +0200
Message-ID: <20230801091924.844204675@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
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

From: Oliver Upton <oliver.upton@linux.dev>

[ Upstream commit 6df696cd9bc1ceed0e92e36908f88bbd16d18255 ]

AmpereOne has an erratum in its implementation of FEAT_HAFDBS that
required disabling the feature on the design. This was done by reporting
the feature as not implemented in the ID register, although the
corresponding control bits were not actually RES0. This does not align
well with the requirements of the architecture, which mandates these
bits be RES0 if HAFDBS isn't implemented.

The kernel's use of stage-1 is unaffected, as the HA and HD bits are
only set if HAFDBS is detected in the ID register. KVM, on the other
hand, relies on the RES0 behavior at stage-2 to use the same value for
VTCR_EL2 on any cpu in the system. Mitigate the non-RES0 behavior by
leaving VTCR_EL2.HA clear on affected systems.

Cc: stable@vger.kernel.org
Cc: D Scott Phillips <scott@os.amperecomputing.com>
Cc: Darren Hart <darren@os.amperecomputing.com>
Acked-by: D Scott Phillips <scott@os.amperecomputing.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20230609220104.1836988-2-oliver.upton@linux.dev
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/arm64/silicon-errata.rst |  3 +++
 arch/arm64/Kconfig                     | 19 +++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c         |  7 +++++++
 arch/arm64/kvm/hyp/pgtable.c           | 14 +++++++++++---
 arch/arm64/tools/cpucaps               |  1 +
 5 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 55492fea44276..bbc80eff03f98 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -52,6 +52,9 @@ stable kernels.
 | Allwinner      | A64/R18         | UNKNOWN1        | SUN50I_ERRATUM_UNKNOWN1     |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
+| Ampere         | AmpereOne       | AC03_CPU_38     | AMPERE_ERRATUM_AC03_CPU_38  |
++----------------+-----------------+-----------------+-----------------------------+
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A510     | #2457168        | ARM64_ERRATUM_2457168       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A510     | #2064142        | ARM64_ERRATUM_2064142       |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 20ee745c118ae..d5eb2fbab473e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -376,6 +376,25 @@ menu "Kernel Features"
 
 menu "ARM errata workarounds via the alternatives framework"
 
+config AMPERE_ERRATUM_AC03_CPU_38
+        bool "AmpereOne: AC03_CPU_38: Certain bits in the Virtualization Translation Control Register and Translation Control Registers do not follow RES0 semantics"
+	default y
+	help
+	  This option adds an alternative code sequence to work around Ampere
+	  erratum AC03_CPU_38 on AmpereOne.
+
+	  The affected design reports FEAT_HAFDBS as not implemented in
+	  ID_AA64MMFR1_EL1.HAFDBS, but (V)TCR_ELx.{HA,HD} are not RES0
+	  as required by the architecture. The unadvertised HAFDBS
+	  implementation suffers from an additional erratum where hardware
+	  A/D updates can occur after a PTE has been marked invalid.
+
+	  The workaround forces KVM to explicitly set VTCR_EL2.HA to 0,
+	  which avoids enabling unadvertised hardware Access Flag management
+	  at stage-2.
+
+	  If unsure, say Y.
+
 config ARM64_WORKAROUND_CLEAN_CACHE
 	bool
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 89ac00084f38a..8dbf3c21ea22a 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -722,6 +722,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		MIDR_FIXED(MIDR_CPU_VAR_REV(1,1), BIT(25)),
 		.cpu_enable = cpu_clear_bf16_from_user_emulation,
 	},
+#endif
+#ifdef CONFIG_AMPERE_ERRATUM_AC03_CPU_38
+	{
+		.desc = "AmpereOne erratum AC03_CPU_38",
+		.capability = ARM64_WORKAROUND_AMPERE_AC03_CPU_38,
+		ERRATA_MIDR_ALL_VERSIONS(MIDR_AMPERE1),
+	},
 #endif
 	{
 	}
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 8f37e65c23eea..ae5f6b5ac80fd 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -598,10 +598,18 @@ u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift)
 #ifdef CONFIG_ARM64_HW_AFDBM
 	/*
 	 * Enable the Hardware Access Flag management, unconditionally
-	 * on all CPUs. The features is RES0 on CPUs without the support
-	 * and must be ignored by the CPUs.
+	 * on all CPUs. In systems that have asymmetric support for the feature
+	 * this allows KVM to leverage hardware support on the subset of cores
+	 * that implement the feature.
+	 *
+	 * The architecture requires VTCR_EL2.HA to be RES0 (thus ignored by
+	 * hardware) on implementations that do not advertise support for the
+	 * feature. As such, setting HA unconditionally is safe, unless you
+	 * happen to be running on a design that has unadvertised support for
+	 * HAFDBS. Here be dragons.
 	 */
-	vtcr |= VTCR_EL2_HA;
+	if (!cpus_have_final_cap(ARM64_WORKAROUND_AMPERE_AC03_CPU_38))
+		vtcr |= VTCR_EL2_HA;
 #endif /* CONFIG_ARM64_HW_AFDBM */
 
 	/* Set the vmid bits */
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index f1c0347ec31a8..14d31d1b2ff02 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -71,6 +71,7 @@ WORKAROUND_2064142
 WORKAROUND_2077057
 WORKAROUND_2457168
 WORKAROUND_2658417
+WORKAROUND_AMPERE_AC03_CPU_38
 WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 WORKAROUND_TSB_FLUSH_FAILURE
 WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
-- 
2.39.2



