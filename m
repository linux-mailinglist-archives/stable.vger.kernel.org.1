Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5191479BE4B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbjIKVu2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242350AbjIKP2k (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:28:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068DEF2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:28:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E505C433C8;
        Mon, 11 Sep 2023 15:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694446115;
        bh=uAXtMSwxH9zAt5N18gKBCuhI7dMLe/sKGdjq7ZVjXgk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PcYOSp2ycFZkdS5sneWpzTCowmqu+B4Kh6cbLNU07YKiPkAmmy25KB/SYk60JvB9D
         8mUNBhmoqrc7GE4NBbGb5tVACGUrLuvcZMMEkrNjJ3W3T3WkB+Eih6iCieSOJ2wVlj
         7GntcZiuet9pEPRMt2TjSj72BEX4ZhwX8gMNnY3U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stephane Eranian <eranian@google.com>,
        Yunying Sun <yunying.sun@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 6.1 588/600] perf/x86/uncore: Correct the number of CHAs on EMR
Date:   Mon, 11 Sep 2023 15:50:21 +0200
Message-ID: <20230911134650.983131592@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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


