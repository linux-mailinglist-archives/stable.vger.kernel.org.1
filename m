Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2316D7ECF7C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbjKOTsr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbjKOTsq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:48:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9D819F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:48:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E12C433C9;
        Wed, 15 Nov 2023 19:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077722;
        bh=eSV5cUpXIqcLG0TwO9IE/IWJvbj2DyeE4gVF2uk9SuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tVrhU9U8quXq16uo3f0E9lcIgDJwS8SaS+b71i1zhzFeIDNyA6RFWjakFXFE6hU0z
         mgBXQXZ1+84ca8WDhrPxjcieoLM1b4O9FjOEnfglKtx91B1R+WcBVa34PA1GqTmBP1
         w8fWTbh8cxFauy29njWBadX+tqdgi+4/CHGTrKYs=
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
Subject: [PATCH 6.6 479/603] perf machine: Avoid out of bounds LBR memory read
Date:   Wed, 15 Nov 2023 14:17:04 -0500
Message-ID: <20231115191645.564480003@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit ab8ce150781d326c6bfbe1e09f175ffde1186f80 ]

Running perf top with address sanitizer and "--call-graph=lbr" fails
due to reading sample 0 when no samples exist. Add a guard to prevent
this.

Fixes: e2b23483eb1d ("perf machine: Factor out lbr_callchain_add_lbr_ip()")
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
Link: https://lore.kernel.org/r/20231024222353.3024098-3-irogers@google.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/machine.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 88f31b3a63acb..e6a8d758f6fe4 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2624,16 +2624,18 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 		save_lbr_cursor_node(thread, cursor, i);
 	}
 
-	/* Add LBR ip from first entries.to */
-	ip = entries[0].to;
-	flags = &entries[0].flags;
-	*branch_from = entries[0].from;
-	err = add_callchain_ip(thread, cursor, parent,
-			       root_al, &cpumode, ip,
-			       true, flags, NULL,
-			       *branch_from);
-	if (err)
-		return err;
+	if (lbr_nr > 0) {
+		/* Add LBR ip from first entries.to */
+		ip = entries[0].to;
+		flags = &entries[0].flags;
+		*branch_from = entries[0].from;
+		err = add_callchain_ip(thread, cursor, parent,
+				root_al, &cpumode, ip,
+				true, flags, NULL,
+				*branch_from);
+		if (err)
+			return err;
+	}
 
 	return 0;
 }
-- 
2.42.0



