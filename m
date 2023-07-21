Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE3075D365
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjGUTKK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjGUTKJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:10:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153DF1BF4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:10:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9423661D70
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F5FC433C9;
        Fri, 21 Jul 2023 19:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966607;
        bh=4setY29dJyaeY5Cjv54HMM97ueew3VwNDUVAWJX/wy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o/q6Z+SqiIGWdAE/bFWwRCYQkDqm7tWwSj5dnaHVB6t3Z/6s2AzRSxxBtokq8+Pt4
         Fhvwnb2MEXZZcvzAhMvSmCIhU+8zwcx2H+r6u6bx4oVWZpNCU9WRH1gI8xvwF7Bfb/
         yG/cwW+Sv/MxY2shR/gxpNXtMHbNBttD1l3o+HoQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Aravindhan Gunasekaran <aravindhan.gunasekaran@intel.com>,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Naama Meir <naamax.meir@linux.intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 403/532] igc: Handle PPS start time programming for past time values
Date:   Fri, 21 Jul 2023 18:05:07 +0200
Message-ID: <20230721160636.321054984@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Aravindhan Gunasekaran <aravindhan.gunasekaran@intel.com>

[ Upstream commit 84a192e46106355de1a314d709e657231d4b1026 ]

I225/6 hardware can be programmed to start PPS output once
the time in Target Time registers is reached. The time
programmed in these registers should always be into future.
Only then PPS output is triggered when SYSTIM register
reaches the programmed value. There are two modes in i225/6
hardware to program PPS, pulse and clock mode.

There were issues reported where PPS is not generated when
start time is in past.

Example 1, "echo 0 0 0 2 0 > /sys/class/ptp/ptp0/period"

In the current implementation, a value of '0' is programmed
into Target time registers and PPS output is in pulse mode.
Eventually an interrupt which is triggered upon SYSTIM
register reaching Target time is not fired. Thus no PPS
output is generated.

Example 2, "echo 0 0 0 1 0 > /sys/class/ptp/ptp0/period"

Above case, a value of '0' is programmed into Target time
registers and PPS output is in clock mode. Here, HW tries to
catch-up the current time by incrementing Target Time
register. This catch-up time seem to vary according to
programmed PPS period time as per the HW design. In my
experiments, the delay ranged between few tens of seconds to
few minutes. The PPS output is only generated after the
Target time register reaches current time.

In my experiments, I also observed PPS stopped working with
below test and could not recover until module is removed and
loaded again.

1) echo 0 <future time> 0 1 0 > /sys/class/ptp/ptp1/period
2) echo 0 0 0 1 0 > /sys/class/ptp/ptp1/period
3) echo 0 0 0 1 0 > /sys/class/ptp/ptp1/period

After this PPS did not work even if i re-program with proper
values. I could only get this back working by reloading the
driver.

This patch takes care of calculating and programming
appropriate future time value into Target Time registers.

Fixes: 5e91c72e560c ("igc: Fix PPS delta between two synchronized end-points")
Signed-off-by: Aravindhan Gunasekaran <aravindhan.gunasekaran@intel.com>
Reviewed-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 25 +++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 6803d91cf71cd..556750b61c98f 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -357,16 +357,35 @@ static int igc_ptp_feature_enable_i225(struct ptp_clock_info *ptp,
 			tsim &= ~IGC_TSICR_TT0;
 		}
 		if (on) {
+			struct timespec64 safe_start;
 			int i = rq->perout.index;
 
 			igc_pin_perout(igc, i, pin, use_freq);
-			igc->perout[i].start.tv_sec = rq->perout.start.sec;
+			igc_ptp_read(igc, &safe_start);
+
+			/* PPS output start time is triggered by Target time(TT)
+			 * register. Programming any past time value into TT
+			 * register will cause PPS to never start. Need to make
+			 * sure we program the TT register a time ahead in
+			 * future. There isn't a stringent need to fire PPS out
+			 * right away. Adding +2 seconds should take care of
+			 * corner cases. Let's say if the SYSTIML is close to
+			 * wrap up and the timer keeps ticking as we program the
+			 * register, adding +2seconds is safe bet.
+			 */
+			safe_start.tv_sec += 2;
+
+			if (rq->perout.start.sec < safe_start.tv_sec)
+				igc->perout[i].start.tv_sec = safe_start.tv_sec;
+			else
+				igc->perout[i].start.tv_sec = rq->perout.start.sec;
 			igc->perout[i].start.tv_nsec = rq->perout.start.nsec;
 			igc->perout[i].period.tv_sec = ts.tv_sec;
 			igc->perout[i].period.tv_nsec = ts.tv_nsec;
-			wr32(trgttimh, rq->perout.start.sec);
+			wr32(trgttimh, (u32)igc->perout[i].start.tv_sec);
 			/* For now, always select timer 0 as source. */
-			wr32(trgttiml, rq->perout.start.nsec | IGC_TT_IO_TIMER_SEL_SYSTIM0);
+			wr32(trgttiml, (u32)(igc->perout[i].start.tv_nsec |
+					     IGC_TT_IO_TIMER_SEL_SYSTIM0));
 			if (use_freq)
 				wr32(freqout, ns);
 			tsauxc |= tsauxc_mask;
-- 
2.39.2



