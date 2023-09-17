Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE0D7A3CB6
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241110AbjIQUeL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241150AbjIQUeG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:34:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4415101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:34:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8ABC433C8;
        Sun, 17 Sep 2023 20:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982841;
        bh=tCa2tggzjawlqeBFcS6vMyeVPciMv9S5LQq3fFOblqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o2fN5aFWdijBpBo0nLiL5OdBsoEdcRsPtK0gDyu8Ng9/WKRTDZEQIG6ttFrQeV8zj
         zgK/L5NNkWJdMlts+bxjCDrYY4ins8LA5YPFthuM43n4mr709XE7Rkw8IrqzM12zDO
         lnNl77uuKxLTyD+RcS+DCZv+NEakmBQSSBDMuya4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stephane Eranian <eranian@google.com>,
        Yunying Sun <yunying.sun@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 5.15 367/511] perf/x86/uncore: Correct the number of CHAs on EMR
Date:   Sun, 17 Sep 2023 21:13:14 +0200
Message-ID: <20230917191122.670320767@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kan Liang <kan.liang@linux.intel.com>

commit 6f7f984fa85b305799076a1bcec941b9377587de upstream.

Starting from SPR, the basic uncore PMON information is retrieved from
the discovery table (resides in an MMIO space populated by BIOS). It is
called the discovery method. The existing value of the type->num_boxes
is from the discovery table.

On some SPR variants, there is a firmware bug that makes the value from the
discovery table incorrect. We use the value from the
SPR_MSR_UNC_CBO_CONFIG MSR to replace the one from the discovery table:

   38776cc45eb7 ("perf/x86/uncore: Correct the number of CHAs on SPR")

Unfortunately, the SPR_MSR_UNC_CBO_CONFIG isn't available for the EMR
XCC (Always returns 0), but the above firmware bug doesn't impact the
EMR XCC.

Don't let the value from the MSR replace the existing value from the
discovery table.

Fixes: 38776cc45eb7 ("perf/x86/uncore: Correct the number of CHAs on SPR")
Reported-by: Stephane Eranian <eranian@google.com>
Reported-by: Yunying Sun <yunying.sun@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Yunying Sun <yunying.sun@intel.com>
Link: https://lore.kernel.org/r/20230905134248.496114-1-kan.liang@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/intel/uncore_snbep.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6078,8 +6078,18 @@ void spr_uncore_cpu_init(void)
 
 	type = uncore_find_type_by_id(uncore_msr_uncores, UNCORE_SPR_CHA);
 	if (type) {
+		/*
+		 * The value from the discovery table (stored in the type->num_boxes
+		 * of UNCORE_SPR_CHA) is incorrect on some SPR variants because of a
+		 * firmware bug. Using the value from SPR_MSR_UNC_CBO_CONFIG to replace it.
+		 */
 		rdmsrl(SPR_MSR_UNC_CBO_CONFIG, num_cbo);
-		type->num_boxes = num_cbo;
+		/*
+		 * The MSR doesn't work on the EMR XCC, but the firmware bug doesn't impact
+		 * the EMR XCC. Don't let the value from the MSR replace the existing value.
+		 */
+		if (num_cbo)
+			type->num_boxes = num_cbo;
 	}
 	spr_uncore_iio_free_running.num_boxes = uncore_type_max_boxes(uncore_msr_uncores, UNCORE_SPR_IIO);
 }


