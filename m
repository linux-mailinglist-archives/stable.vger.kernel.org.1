Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445A87ED428
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344576AbjKOU5J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344566AbjKOU5E (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4822611F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADABFC4E777;
        Wed, 15 Nov 2023 20:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081820;
        bh=bcy/HHwuZasMBB5CT24rlcJRKUNZs7qY9b55o+d5LmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zhJL4GGPnevh+FxbWmbXum4r1HuzOxhuQEXok2Bxd7SkCAMHM5pQNkHQNqTahvbpq
         xHkDAJ4hOG737Kw8RyXuw/F/pObj4flqu+eDJTSO3gmoRfiwYBh7FAsfS9XnYxswc3
         4Sj6M72DukKWTwczXzsIsWIXi6iWWP6SCQxCbwCQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Rogers <irogers@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Nick Terrell <terrelln@fb.com>,
        Sean Christopherson <seanjc@google.com>,
        Changbin Du <changbin.du@huawei.com>,
        liuwenyu <liuwenyu7@huawei.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, Song Liu <song@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 147/191] perf hist: Add missing puts to hist__account_cycles
Date:   Wed, 15 Nov 2023 15:47:02 -0500
Message-ID: <20231115204653.330906401@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit c1149037f65bcf0334886180ebe3d5efcf214912 ]

Caught using reference count checking on perf top with
"--call-graph=lbr". After this no memory leaks were detected.

Fixes: 57849998e2cd ("perf report: Add processing for cycle histograms")
Signed-off-by: Ian Rogers <irogers@google.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Sandipan Das <sandipan.das@amd.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: German Gomez <german.gomez@arm.com>
Cc: James Clark <james.clark@arm.com>
Cc: Nick Terrell <terrelln@fb.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Changbin Du <changbin.du@huawei.com>
Cc: liuwenyu <liuwenyu7@huawei.com>
Cc: Yang Jihong <yangjihong1@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Song Liu <song@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Yanteng Si <siyanteng@loongson.cn>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20231024222353.3024098-6-irogers@google.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/hist.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 8a793e4c9400a..c78d8813811cc 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2624,8 +2624,6 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 
 	/* If we have branch cycles always annotate them. */
 	if (bs && bs->nr && entries[0].flags.cycles) {
-		int i;
-
 		bi = sample__resolve_bstack(sample, al);
 		if (bi) {
 			struct addr_map_symbol *prev = NULL;
@@ -2640,7 +2638,7 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 			 * Note that perf stores branches reversed from
 			 * program order!
 			 */
-			for (i = bs->nr - 1; i >= 0; i--) {
+			for (int i = bs->nr - 1; i >= 0; i--) {
 				addr_map_symbol__account_cycles(&bi[i].from,
 					nonany_branch_mode ? NULL : prev,
 					bi[i].flags.cycles);
@@ -2649,6 +2647,12 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 				if (total_cycles)
 					*total_cycles += bi[i].flags.cycles;
 			}
+			for (unsigned int i = 0; i < bs->nr; i++) {
+				map__put(bi[i].to.ms.map);
+				maps__put(bi[i].to.ms.maps);
+				map__put(bi[i].from.ms.map);
+				maps__put(bi[i].from.ms.maps);
+			}
 			free(bi);
 		}
 	}
-- 
2.42.0



