Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02527A3871
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239754AbjIQTgC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239769AbjIQTfe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:35:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E04119
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:35:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA1AC433C7;
        Sun, 17 Sep 2023 19:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979329;
        bh=u9LmL/WkoefVI7VgOteQGKMTIDI6iX8bcN/9mSwTI6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ULdSK+rbzErgygZl2k4j+yuw370293FMP0VIc2CAngrU5N86C4ZoDy6amLoVoeWlu
         UFyt1mQdNQO4QuIY2rbj6Wz9UeMj3zgY950jdnZgQqqzVoTgFNK2tXlOYlZFxMAG2z
         rfgjjyB+OujJXaQUr68wbM64I+P4oDLLMbRDx9zQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Zhivich <mzhivich@akamai.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 254/406] x86/speculation: Mark all Skylake CPUs as vulnerable to GDS
Date:   Sun, 17 Sep 2023 21:11:48 +0200
Message-ID: <20230917191107.881643860@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Hansen <dave.hansen@linux.intel.com>

[ Upstream commit c9f4c45c8ec3f07f4f083f9750032a1ec3eab6b2 ]

The Gather Data Sampling (GDS) vulnerability is common to all Skylake
processors.  However, the "client" Skylakes* are now in this list:

	https://www.intel.com/content/www/us/en/support/articles/000022396/processors.html

which means they are no longer included for new vulnerabilities here:

	https://www.intel.com/content/www/us/en/developer/topic-technology/software-security-guidance/processors-affected-consolidated-product-cpu-model.html

or in other GDS documentation.  Thus, they were not included in the
original GDS mitigation patches.

Mark SKYLAKE and SKYLAKE_L as vulnerable to GDS to match all the
other Skylake CPUs (which include Kaby Lake).  Also group the CPUs
so that the ones that share the exact same vulnerabilities are next
to each other.

Last, move SRBDS to the end of each line.  This makes it clear at a
glance that SKYLAKE_X is unique.  Of the five Skylakes, it is the
only "server" CPU and has a different implementation from the
clients of the "special register" hardware, making it immune to SRBDS.

This makes the diff much harder to read, but the resulting table is
worth it.

I very much appreciate the report from Michael Zhivich about this
issue.  Despite what level of support a hardware vendor is providing,
the kernel very much needs an accurate and up-to-date list of
vulnerable CPUs.  More reports like this are very welcome.

* Client Skylakes are CPUID 406E3/506E3 which is family 6, models
  0x4E and 0x5E, aka INTEL_FAM6_SKYLAKE and INTEL_FAM6_SKYLAKE_L.

Reported-by: Michael Zhivich <mzhivich@akamai.com>
Fixes: 8974eb588283 ("x86/speculation: Add Gather Data Sampling mitigation")
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c1ff75ad11358..4ecc6072e9a48 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1145,11 +1145,11 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPPINGS(BROADWELL_G,	X86_STEPPING_ANY,		SRBDS),
 	VULNBL_INTEL_STEPPINGS(BROADWELL_X,	X86_STEPPING_ANY,		MMIO),
 	VULNBL_INTEL_STEPPINGS(BROADWELL,	X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(SKYLAKE_L,	X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED),
 	VULNBL_INTEL_STEPPINGS(SKYLAKE_X,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(SKYLAKE,		X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(KABYLAKE_L,	X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(KABYLAKE,	X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED | GDS),
+	VULNBL_INTEL_STEPPINGS(SKYLAKE_L,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPPINGS(SKYLAKE,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPPINGS(KABYLAKE_L,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPPINGS(KABYLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
 	VULNBL_INTEL_STEPPINGS(CANNONLAKE_L,	X86_STEPPING_ANY,		RETBLEED),
 	VULNBL_INTEL_STEPPINGS(ICELAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
 	VULNBL_INTEL_STEPPINGS(ICELAKE_D,	X86_STEPPING_ANY,		MMIO | GDS),
-- 
2.40.1



