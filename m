Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5406F9F0A
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 07:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjEHF32 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 01:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjEHF31 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 01:29:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193EF15EC9
        for <stable@vger.kernel.org>; Sun,  7 May 2023 22:29:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F68B61E84
        for <stable@vger.kernel.org>; Mon,  8 May 2023 05:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C82C4339B;
        Mon,  8 May 2023 05:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683523765;
        bh=UnQSAuheeGvc76ugQ0MlsBe3h8BXZDOElAr3yHjQZug=;
        h=Subject:To:Cc:From:Date:From;
        b=xo2eTGJFgUH7MrzNo6KRVw0kpO3pfW8D04onsgFurV6Lf+ccuEMmbiuBPvYcNlVl/
         EnwvdS9Lt/Iu81VKmp4qoByFytKeu39MQrWY/ES+DIhUCfRNca4SBSEv1NND6D9QL1
         IodYY2ZYMehHVf/IeP9ZDrDcWRq2ZlBqOu4OwiZk=
Subject: FAILED: patch "[PATCH] perf intel-pt: Fix CYC timestamps after standalone CBR" failed to apply to 4.14-stable tree
To:     adrian.hunter@intel.com, acme@redhat.com, irogers@google.com,
        jolsa@kernel.org, namhyung@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 08 May 2023 07:29:13 +0200
Message-ID: <2023050813-twiddling-olive-0fd5@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 430635a0ef1ce958b7b4311f172694ece2c692b8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050813-twiddling-olive-0fd5@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

430635a0ef1c ("perf intel-pt: Fix CYC timestamps after standalone CBR")
3f05516758be ("perf intel-pt: Accumulate cycle count from TSC/TMA/MTC packets")
f3c98c4b5ac8 ("perf intel-pt: Re-factor TIP cases in intel_pt_walk_to_ip")
7b4b4f83881e ("perf intel-pt: Accumulate cycle count from CYC packets")
948e9dc8bb26 ("perf intel-pt: Factor out intel_pt_update_sample_time")
1b6599a9d8e6 ("perf intel-pt: Fix sample timestamp wrt non-taken branches")
bea6385789b8 ("perf intel-pt: Implement decoder flags for trace begin / end")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 430635a0ef1ce958b7b4311f172694ece2c692b8 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Mon, 3 Apr 2023 18:48:31 +0300
Subject: [PATCH] perf intel-pt: Fix CYC timestamps after standalone CBR

After a standalone CBR (not associated with TSC), update the cycles
reference timestamp and reset the cycle count, so that CYC timestamps
are calculated relative to that point with the new frequency.

Fixes: cc33618619cefc6d ("perf tools: Add Intel PT support for decoding CYC packets")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230403154831.8651-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 0ac860c8dd2b..7145c5890de0 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1998,6 +1998,8 @@ static void intel_pt_calc_cbr(struct intel_pt_decoder *decoder)
 
 	decoder->cbr = cbr;
 	decoder->cbr_cyc_to_tsc = decoder->max_non_turbo_ratio_fp / cbr;
+	decoder->cyc_ref_timestamp = decoder->timestamp;
+	decoder->cycle_cnt = 0;
 
 	intel_pt_mtc_cyc_cnt_cbr(decoder);
 }

