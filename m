Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F409A7BDE7F
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376318AbjJINT7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346568AbjJINT5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:19:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DEAD8
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:19:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2F6C433C8;
        Mon,  9 Oct 2023 13:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857595;
        bh=YqVAxk9zR8aKFjotHD+cbMwpx7tcg7bp8jT66VgufUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OIWl24JACpC4fLicmdEm2X1vFZ7w5Nc92sLb/u+S4I29RPRIAzPRJSUVs5txmeX6M
         mHA37S/vutfAFxowW7Ug8V89XNT+0hjcKB3g5Ca6mrowpCtTUEA0Fn7R3WzhaMFe9W
         dIEm8y9c94mKX3vZ952e2fI+4ahGggEpwl1BpRXY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jirka Hladky <jhladky@redhat.com>,
        Breno Leitao <leitao@debian.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 095/162] perf/x86/amd: Do not WARN() on every IRQ
Date:   Mon,  9 Oct 2023 15:01:16 +0200
Message-ID: <20231009130125.545854002@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 599522d9d2e19d6240e4312577f1c5f3ffca22f6 ]

Zen 4 systems running buggy microcode can hit a WARN_ON() in the PMI
handler, as shown below, several times while perf runs. A simple
`perf top` run is enough to render the system unusable:

  WARNING: CPU: 18 PID: 20608 at arch/x86/events/amd/core.c:944 amd_pmu_v2_handle_irq+0x1be/0x2b0

This happens because the Performance Counter Global Status Register
(PerfCntGlobalStatus) has one or more bits set which are considered
reserved according to the "AMD64 Architecture Programmer’s Manual,
Volume 2: System Programming, 24593":

  https://www.amd.com/system/files/TechDocs/24593.pdf

To make this less intrusive, warn just once if any reserved bit is set
and prompt the user to update the microcode. Also sanitize the value to
what the code is handling, so that the overflow events continue to be
handled for the number of counters that are known to be sane.

Going forward, the following microcode patch levels are recommended
for Zen 4 processors in order to avoid such issues with reserved bits:

  Family=0x19 Model=0x11 Stepping=0x01: Patch=0x0a10113e
  Family=0x19 Model=0x11 Stepping=0x02: Patch=0x0a10123e
  Family=0x19 Model=0xa0 Stepping=0x01: Patch=0x0aa00116
  Family=0x19 Model=0xa0 Stepping=0x02: Patch=0x0aa00212

Commit f2eb058afc57 ("linux-firmware: Update AMD cpu microcode") from
the linux-firmware tree has binaries that meet the minimum required
patch levels.

  [ sandipan: - add message to prompt users to update microcode
              - rework commit message and call out required microcode levels ]

Fixes: 7685665c390d ("perf/x86/amd/core: Add PerfMonV2 overflow handling")
Reported-by: Jirka Hladky <jhladky@redhat.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/all/3540f985652f41041e54ee82aa53e7dbd55739ae.1694696888.git.sandipan.das@amd.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/amd/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index bb9d99b45a459..04f4b96dec6df 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -886,7 +886,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 	struct hw_perf_event *hwc;
 	struct perf_event *event;
 	int handled = 0, idx;
-	u64 status, mask;
+	u64 reserved, status, mask;
 	bool pmu_enabled;
 
 	/*
@@ -911,6 +911,14 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 		status &= ~GLOBAL_STATUS_LBRS_FROZEN;
 	}
 
+	reserved = status & ~amd_pmu_global_cntr_mask;
+	if (reserved)
+		pr_warn_once("Reserved PerfCntrGlobalStatus bits are set (0x%llx), please consider updating microcode\n",
+			     reserved);
+
+	/* Clear any reserved bits set by buggy microcode */
+	status &= amd_pmu_global_cntr_mask;
+
 	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
 		if (!test_bit(idx, cpuc->active_mask))
 			continue;
-- 
2.40.1



