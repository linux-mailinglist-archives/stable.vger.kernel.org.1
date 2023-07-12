Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF10750C56
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 17:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjGLPXS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 12 Jul 2023 11:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjGLPXH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 12 Jul 2023 11:23:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FAD11B
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689175387; x=1720711387;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=qlaYw38sS/gI4Ccw/QxCVJ7EotWvG+pc6UOoByNGJao=;
  b=A5QOWBcP8bT99SAswnWvcRcnEuXPipEe9FixFSGIyg4lzajNdIaf6kPY
   +fb59gviSAfAC6QEOY7T/Ms7CSSXI5sw+zwX5ZZZUsf3c29dmGdKQJpE4
   e99eRX2il7mqNxxao4THeJlkXQhEKTgogJOIrENk2u9Cc6zM9MRM87ut5
   DUJG3LrsMorI/0xbJdRLZmZj8gfU7BI/eD8k36sU5wSorVaD/abdIaMJO
   1/sU+RyDjrQWLKRr+qjlcBFNnXgNUluQPTF70y+rHk/k21FNGKIo+0y0t
   7TTgy9VdSt+Ds2L+HPPplS6NDDQED+ZyqQfQu/BWeF8sK/DTlVlar8Tj4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="451281478"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="451281478"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 08:23:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="895669597"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="895669597"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.42.166])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 08:23:05 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     stable@vger.kernel.org
Subject: [PATCH 4.14] perf intel-pt: Fix CYC timestamps after standalone CBR
Date:   Wed, 12 Jul 2023 18:22:54 +0300
Message-Id: <20230712152254.19468-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023050813-twiddling-olive-0fd5@gregkh>
References: <2023050813-twiddling-olive-0fd5@gregkh>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 430635a0ef1ce958b7b4311f172694ece2c692b8 upstream

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
(cherry picked from commit 430635a0ef1ce958b7b4311f172694ece2c692b8)
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index e2a6c22959f2..aabd42378552 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1499,6 +1499,8 @@ static void intel_pt_calc_cbr(struct intel_pt_decoder *decoder)
 
 	decoder->cbr = cbr;
 	decoder->cbr_cyc_to_tsc = decoder->max_non_turbo_ratio_fp / cbr;
+	decoder->cyc_ref_timestamp = decoder->timestamp;
+	decoder->cycle_cnt = 0;
 }
 
 static void intel_pt_calc_cyc_timestamp(struct intel_pt_decoder *decoder)
-- 
2.34.1

