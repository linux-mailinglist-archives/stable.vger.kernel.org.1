Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D79A775928
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjHIK6N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjHIK6M (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:58:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BA9210A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:58:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E9CF62BD5
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:58:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4DAC433C8;
        Wed,  9 Aug 2023 10:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578689;
        bh=MGM05ryeBXBML/xTQj71jPIQV/L91/hUBZ38Uhsy2Sk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0UOR75zii+IVhT1ng4i7PrTZCb8csjEKoxQMuPVGbtTgbf+5xqXNxX+9rrh3KcvLb
         +t1TIQvYn1Rn3gc40cZLWUnVANbbvO9PciXzwn0+DAJ0VI6KNFlhu8x5Ax240UYHC/
         MrbnLXy7KIluryNHNhizr33N38Kgq7ijPBuVekXM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: [PATCH 5.15 05/92] arm64: errata: Add detection for TRBE write to out-of-range
Date:   Wed,  9 Aug 2023 12:40:41 +0200
Message-ID: <20230809103633.707137288@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103633.485906560@linuxfoundation.org>
References: <20230809103633.485906560@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Suzuki K Poulose <suzuki.poulose@arm.com>

commit 8d81b2a38ddfc4b03662d2359765648c8b4cc73c upstream

Arm Neoverse-N2 and Cortex-A710 cores are affected by an erratum where
the trbe, under some circumstances, might write upto 64bytes to an
address after the Limit as programmed by the TRBLIMITR_EL1.LIMIT.
This might -
  - Corrupt a page in the ring buffer, which may corrupt trace from a
    previous session, consumed by userspace.
  - Hit the guard page at the end of the vmalloc area and raise a fault.

To keep the handling simpler, we always leave the last page from the
range, which TRBE is allowed to write. This can be achieved by ensuring
that we always have more than a PAGE worth space in the range, while
calculating the LIMIT for TRBE. And then the LIMIT pointer can be
adjusted to leave the PAGE (TRBLIMITR.LIMIT -= PAGE_SIZE), out of the
TRBE range while enabling it. This makes sure that the TRBE will only
write to an area within its allowed limit (i.e, [head-head+size]) and
we do not have to handle address faults within the driver.

Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20211019163153.3692640-5-suzuki.poulose@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/arm64/silicon-errata.rst |    4 +++
 arch/arm64/Kconfig                     |   41 +++++++++++++++++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c         |   20 ++++++++++++++++
 arch/arm64/tools/cpucaps               |    1 
 4 files changed, 66 insertions(+)

--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -106,6 +106,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A710     | #2054223        | ARM64_ERRATUM_2054223       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A710     | #2224489        | ARM64_ERRATUM_2224489       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1188873,1418040| ARM64_ERRATUM_1418040       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1349291        | N/A                         |
@@ -116,6 +118,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #2067961        | ARM64_ERRATUM_2067961       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-N2     | #2253138        | ARM64_ERRATUM_2253138       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -807,6 +807,47 @@ config ARM64_ERRATUM_2067961
 
 	  If unsure, say Y.
 
+config ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
+	bool
+
+config ARM64_ERRATUM_2253138
+	bool "Neoverse-N2: 2253138: workaround TRBE writing to address out-of-range"
+	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
+	depends on CORESIGHT_TRBE
+	default y
+	select ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
+	help
+	  This option adds the workaround for ARM Neoverse-N2 erratum 2253138.
+
+	  Affected Neoverse-N2 cores might write to an out-of-range address, not reserved
+	  for TRBE. Under some conditions, the TRBE might generate a write to the next
+	  virtually addressed page following the last page of the TRBE address space
+	  (i.e., the TRBLIMITR_EL1.LIMIT), instead of wrapping around to the base.
+
+	  Work around this in the driver by always making sure that there is a
+	  page beyond the TRBLIMITR_EL1.LIMIT, within the space allowed for the TRBE.
+
+	  If unsure, say Y.
+
+config ARM64_ERRATUM_2224489
+	bool "Cortex-A710: 2224489: workaround TRBE writing to address out-of-range"
+	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
+	depends on CORESIGHT_TRBE
+	default y
+	select ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
+	help
+	  This option adds the workaround for ARM Cortex-A710 erratum 2224489.
+
+	  Affected Cortex-A710 cores might write to an out-of-range address, not reserved
+	  for TRBE. Under some conditions, the TRBE might generate a write to the next
+	  virtually addressed page following the last page of the TRBE address space
+	  (i.e., the TRBLIMITR_EL1.LIMIT), instead of wrapping around to the base.
+
+	  Work around this in the driver by always making sure that there is a
+	  page beyond the TRBLIMITR_EL1.LIMIT, within the space allowed for the TRBE.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -387,6 +387,18 @@ static const struct midr_range tsb_flush
 };
 #endif	/* CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILURE */
 
+#ifdef CONFIG_ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
+static struct midr_range trbe_write_out_of_range_cpus[] = {
+#ifdef CONFIG_ARM64_ERRATUM_2253138
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+#endif
+#ifdef CONFIG_ARM64_ERRATUM_2224489
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
+#endif
+	{},
+};
+#endif /* CONFIG_ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE */
+
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
 	{
@@ -626,6 +638,14 @@ const struct arm64_cpu_capabilities arm6
 		ERRATA_MIDR_RANGE_LIST(tsb_flush_fail_cpus),
 	},
 #endif
+#ifdef CONFIG_ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
+	{
+		.desc = "ARM erratum 2253138 or 2224489",
+		.capability = ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE,
+		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
+		CAP_MIDR_RANGE_LIST(trbe_write_out_of_range_cpus),
+	},
+#endif
 	{
 	}
 };
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -58,6 +58,7 @@ WORKAROUND_1742098
 WORKAROUND_2457168
 WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 WORKAROUND_TSB_FLUSH_FAILURE
+WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
 WORKAROUND_CAVIUM_23154
 WORKAROUND_CAVIUM_27456
 WORKAROUND_CAVIUM_30115


