Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26B7713FBE
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjE1Tsc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjE1Tsc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:48:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6971A8
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:48:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8474A60FE5
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F1FC433EF;
        Sun, 28 May 2023 19:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303310;
        bh=gZFETnFHl7/ZN+F/cEAiMCBw5P7IPLetL1193hYjaaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n74AOCpIdTPfvOpaCCf9LBXYVUFVWMblAvsN8e2kNvGvcS0v9b5tcdmnDj4ZA66ea
         aU9cv0hj1bmYeoiRlb1v4dQElWSmJ7r6kDYW5W1JAiZkWTKulVCG9HsvXVt8DfzAm9
         sdYw2tfZZZwI5bu08plruYsa3FIfh1IYzLDfVoz8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 5.15 26/69] perf/x86/uncore: Correct the number of CHAs on SPR
Date:   Sun, 28 May 2023 20:11:46 +0100
Message-Id: <20230528190829.350199238@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190828.358612414@linuxfoundation.org>
References: <20230528190828.358612414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

commit 38776cc45eb7603df4735a0410f42cffff8e71a1 upstream.

The number of CHAs from the discovery table on some SPR variants is
incorrect, because of a firmware issue. An accurate number can be read
from the MSR UNC_CBO_CONFIG.

Fixes: 949b11381f81 ("perf/x86/intel/uncore: Add Sapphire Rapids server CHA support")
Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Stephane Eranian <eranian@google.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230508140206.283708-1-kan.liang@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/intel/uncore_snbep.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5822,6 +5822,7 @@ static struct intel_uncore_type spr_unco
 };
 
 #define UNCORE_SPR_NUM_UNCORE_TYPES		12
+#define UNCORE_SPR_CHA				0
 #define UNCORE_SPR_IIO				1
 #define UNCORE_SPR_IMC				6
 
@@ -6064,12 +6065,22 @@ static int uncore_type_max_boxes(struct
 	return max + 1;
 }
 
+#define SPR_MSR_UNC_CBO_CONFIG		0x2FFE
+
 void spr_uncore_cpu_init(void)
 {
+	struct intel_uncore_type *type;
+	u64 num_cbo;
+
 	uncore_msr_uncores = uncore_get_uncores(UNCORE_ACCESS_MSR,
 						UNCORE_SPR_MSR_EXTRA_UNCORES,
 						spr_msr_uncores);
 
+	type = uncore_find_type_by_id(uncore_msr_uncores, UNCORE_SPR_CHA);
+	if (type) {
+		rdmsrl(SPR_MSR_UNC_CBO_CONFIG, num_cbo);
+		type->num_boxes = num_cbo;
+	}
 	spr_uncore_iio_free_running.num_boxes = uncore_type_max_boxes(uncore_msr_uncores, UNCORE_SPR_IIO);
 }
 


