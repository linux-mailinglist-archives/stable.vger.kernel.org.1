Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D066FAAA0
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjEHLEf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjEHLET (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:04:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316153557A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:03:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B958762A80
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:03:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D02C433EF;
        Mon,  8 May 2023 11:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543800;
        bh=qKezEy9+p1z9kpvOiygYbm9YI+ys8KzcjSp+7e2Y+GQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lMhN6t6TtG2u7+CNIZReZh/x7m8BYC8Gzz9l07f7T+gDEDuj2yG9Eqce+QXtIS+Pl
         ytABzGBuKq5dRA4x2fODUdnA3pgbqwqBi6R6aM9ov1KvackdBUrdKuzDYp1m/f0Zcy
         gjVN5DGuW61/JU8TQ5nxmbPcCV8EN5p8uPo7Y2Io=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Muralidhara M K <muralimk@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 205/694] x86/MCE/AMD: Use an u64 for bank_map
Date:   Mon,  8 May 2023 11:40:40 +0200
Message-Id: <20230508094439.035288446@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

[ Upstream commit 4c1cdec319b9aadb65737c3eb1f5cb74bd6aa156 ]

Thee maximum number of MCA banks is 64 (MAX_NR_BANKS), see

  a0bc32b3cacf ("x86/mce: Increase maximum number of banks to 64").

However, the bank_map which contains a bitfield of which banks to
initialize is of type unsigned int and that overflows when those bit
numbers are >= 32, leading to UBSAN complaining correctly:

  UBSAN: shift-out-of-bounds in arch/x86/kernel/cpu/mce/amd.c:1365:38
  shift exponent 32 is too large for 32-bit type 'int'

Change the bank_map to a u64 and use the proper BIT_ULL() macro when
modifying bits in there.

  [ bp: Rewrite commit message. ]

Fixes: a0bc32b3cacf ("x86/mce: Increase maximum number of banks to 64")
Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230127151601.1068324-1-muralimk@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/mce/amd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 23c5072fbbb76..06cd3bef62e90 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -235,10 +235,10 @@ static DEFINE_PER_CPU(struct threshold_bank **, threshold_banks);
  * A list of the banks enabled on each logical CPU. Controls which respective
  * descriptors to initialize later in mce_threshold_create_device().
  */
-static DEFINE_PER_CPU(unsigned int, bank_map);
+static DEFINE_PER_CPU(u64, bank_map);
 
 /* Map of banks that have more than MCA_MISC0 available. */
-static DEFINE_PER_CPU(u32, smca_misc_banks_map);
+static DEFINE_PER_CPU(u64, smca_misc_banks_map);
 
 static void amd_threshold_interrupt(void);
 static void amd_deferred_error_interrupt(void);
@@ -267,7 +267,7 @@ static void smca_set_misc_banks_map(unsigned int bank, unsigned int cpu)
 		return;
 
 	if (low & MASK_BLKPTR_LO)
-		per_cpu(smca_misc_banks_map, cpu) |= BIT(bank);
+		per_cpu(smca_misc_banks_map, cpu) |= BIT_ULL(bank);
 
 }
 
@@ -530,7 +530,7 @@ static u32 smca_get_block_address(unsigned int bank, unsigned int block,
 	if (!block)
 		return MSR_AMD64_SMCA_MCx_MISC(bank);
 
-	if (!(per_cpu(smca_misc_banks_map, cpu) & BIT(bank)))
+	if (!(per_cpu(smca_misc_banks_map, cpu) & BIT_ULL(bank)))
 		return 0;
 
 	return MSR_AMD64_SMCA_MCx_MISCy(bank, block - 1);
@@ -574,7 +574,7 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 	int new;
 
 	if (!block)
-		per_cpu(bank_map, cpu) |= (1 << bank);
+		per_cpu(bank_map, cpu) |= BIT_ULL(bank);
 
 	memset(&b, 0, sizeof(b));
 	b.cpu			= cpu;
@@ -878,7 +878,7 @@ static void amd_threshold_interrupt(void)
 		return;
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
-		if (!(per_cpu(bank_map, cpu) & (1 << bank)))
+		if (!(per_cpu(bank_map, cpu) & BIT_ULL(bank)))
 			continue;
 
 		first_block = bp[bank]->blocks;
@@ -1356,7 +1356,7 @@ int mce_threshold_create_device(unsigned int cpu)
 		return -ENOMEM;
 
 	for (bank = 0; bank < numbanks; ++bank) {
-		if (!(this_cpu_read(bank_map) & (1 << bank)))
+		if (!(this_cpu_read(bank_map) & BIT_ULL(bank)))
 			continue;
 		err = threshold_create_bank(bp, cpu, bank);
 		if (err) {
-- 
2.39.2



