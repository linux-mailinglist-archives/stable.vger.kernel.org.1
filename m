Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEA879BDBE
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbjIKUum (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239582AbjIKOYJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:24:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A53E40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:24:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE119C433C8;
        Mon, 11 Sep 2023 14:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442243;
        bh=49glwftxkfQ3QQ2/+byNsubl2ppraa53zIt/FqPKCR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=taXUXmEew7hkWtgrL2R9sBPuvnrn9xQ85yiFX7g6FF8lqWB1n7542VxGr791eWXTd
         6uZ5qFgJw3WVL8x0I9quaUAfTEzNLYs9VQbOb1tU42pdxJIQBaFbIcPKE6TfovbkfQ
         BssdHaw8Adk98xMwzjwCX0SoaPi+s7qCv3T8AIGA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.5 670/739] powercap: intel_rapl: Fix invalid setting of Power Limit 4
Date:   Mon, 11 Sep 2023 15:47:49 +0200
Message-ID: <20230911134709.819407026@linuxfoundation.org>
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

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

commit 081690e941188acfad41b8dbde2112029a2aa206 upstream.

System runs at minimum performance, once powercap RAPL package domain
enabled flag is changed from 1 to 0 to 1.

Setting RAPL package domain enabled flag to 0, results in setting of
power limit 4 (PL4) MSR 0x601 to 0. This implies disabling PL4 limit.
The PL4 limit controls the peak power. So setting 0, results in some
undesirable performance, which depends on hardware implementation.

Even worse, when the enabled flag is set to 1 again. This will set PL4
MSR value to 0x01, which means reduce peak power to 0.125W. This will
force system to run at the lowest possible performance on every PL4
supported system.

Setting enabled flag should only affect the "enable" bit, not other
bits. Here it is changing power limit.

This is caused by a change which assumes that there is an enable bit in
the PL4 MSR like other power limits. Although PL4 enable/disable bit is
present with TPMI RAPL interface, it is not present with the MSR
interface.

There is a rapl_primitive_info defined for non existent PL4 enable bit
and then it is used with the commit 9050a9cd5e4c ("powercap: intel_rapl:
Cleanup Power Limits support") to enable PL4. This is wrong, hence remove
this rapl primitive for PL4. Also in the function
rapl_detect_powerlimit(), PL_ENABLE is used to check for the presence of
power limits. Replace PL_ENABLE with PL_LIMIT, as PL_LIMIT must be
present. Without this change, PL4 controls will not be available in the
sysfs once rapl primitive for PL4 is removed.

Fixes: 9050a9cd5e4c ("powercap: intel_rapl: Cleanup Power Limits support")
Suggested-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Tested-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc: 6.5+ <stable@vger.kernel.org> # 6.5+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/powercap/intel_rapl_common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 5c2e6d5eea2a..40a2cc649c79 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -658,8 +658,6 @@ static struct rapl_primitive_info rpi_msr[NR_RAPL_PRIMITIVES] = {
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
 	[PL2_CLAMP] = PRIMITIVE_INFO_INIT(PL2_CLAMP, POWER_LIMIT2_CLAMP, 48,
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	[PL4_ENABLE] = PRIMITIVE_INFO_INIT(PL4_ENABLE, POWER_LIMIT4_MASK, 0,
-				RAPL_DOMAIN_REG_PL4, ARBITRARY_UNIT, 0),
 	[TIME_WINDOW1] = PRIMITIVE_INFO_INIT(TIME_WINDOW1, TIME_WINDOW1_MASK, 17,
 			    RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
 	[TIME_WINDOW2] = PRIMITIVE_INFO_INIT(TIME_WINDOW2, TIME_WINDOW2_MASK, 49,
@@ -1458,7 +1456,7 @@ static void rapl_detect_powerlimit(struct rapl_domain *rd)
 			}
 		}
 
-		if (rapl_read_pl_data(rd, i, PL_ENABLE, false, &val64))
+		if (rapl_read_pl_data(rd, i, PL_LIMIT, false, &val64))
 			rd->rpl[i].name = NULL;
 	}
 }
-- 
2.42.0



