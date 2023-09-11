Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26BD79C100
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346207AbjIKVXJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239370AbjIKOTI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:19:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E79CDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:19:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5ECDC433C7;
        Mon, 11 Sep 2023 14:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441943;
        bh=TUNCiIS3Y67o6ADmMdFY/qGm8e8fcEmdLYIwztmH0z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=onOM3VgYy2BgYfjthqZp9QFJNmRopVBkaiiro5SE31W9OZ611BeVttmq7SrK1TlRo
         gAWX9ck8ir9kHuWWtW+3nWpW5wS/ulM+yXItyvt9oxsWK+BoKWDDot2EshCG6FTIVy
         3ImaQ0Xbt/QCnZjCZHQhWiVSQ77q8QLCCt5CJwkQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Zhivich <mzhivich@akamai.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 591/739] x86/speculation: Mark all Skylake CPUs as vulnerable to GDS
Date:   Mon, 11 Sep 2023 15:46:30 +0200
Message-ID: <20230911134707.608823687@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

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
index e3a65e9fc750d..00f043a094fcd 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1265,11 +1265,11 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
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



