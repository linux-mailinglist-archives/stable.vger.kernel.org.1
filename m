Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82D875D1C0
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjGUSwf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjGUSwe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:52:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2EB3A8F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:52:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BBB861D6D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:52:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9078CC433C7;
        Fri, 21 Jul 2023 18:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965541;
        bh=jd8BxuKarec2pYLRUjqZ6gLTrC9okgJGLprYDIjxBxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zgFFCFXitvMglyZpAXvgj9FnN9fl+u6R/t/gMYhsPheFz96/hPxWOgDJi35o25STU
         AF03+wu6uzTbr07xC74XL3EwVFLe5qcA6+UNvDg0PmkxippH0smTKuJnGfMN9hF1Ku
         1EqDGe3I/ILFWUgyg1IBCdzWgt4FygM48C1F8dKs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 027/532] perf/ibs: Fix interface via core pmu events
Date:   Fri, 21 Jul 2023 17:58:51 +0200
Message-ID: <20230721160616.135390751@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@amd.com>

[ Upstream commit 2fad201fe38ff9a692acedb1990ece2c52a29f95 ]

Although, IBS pmus can be invoked via their own interface, indirect
IBS invocation via core pmu events is also supported with fixed set
of events: cpu-cycles:p, r076:p (same as cpu-cycles:p) and r0C1:p
(micro-ops) for user convenience.

This indirect IBS invocation is broken since commit 66d258c5b048
("perf/core: Optimize perf_init_event()"), which added RAW pmu under
'pmu_idr' list and thus if event_init() fails with RAW pmu, it started
returning error instead of trying other pmus.

Forward precise events from core pmu to IBS by overwriting 'type' and
'config' in the kernel copy of perf_event_attr. Overwriting will cause
perf_init_event() to retry with updated 'type' and 'config', which will
automatically forward event to IBS pmu.

Without patch:
  $ sudo ./perf record -C 0 -e r076:p -- sleep 1
  Error:
  The r076:p event is not supported.

With patch:
  $ sudo ./perf record -C 0 -e r076:p -- sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.341 MB perf.data (37 samples) ]

Fixes: 66d258c5b048 ("perf/core: Optimize perf_init_event()")
Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230504110003.2548-3-ravi.bangoria@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/amd/core.c        |  2 +-
 arch/x86/events/amd/ibs.c         | 53 +++++++++++++++----------------
 arch/x86/include/asm/perf_event.h |  2 ++
 3 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index d93d098dea99d..4ebedc7e1188b 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -364,7 +364,7 @@ static int amd_pmu_hw_config(struct perf_event *event)
 
 	/* pass precise event sampling to ibs: */
 	if (event->attr.precise_ip && get_ibs_caps())
-		return -ENOENT;
+		return forward_event_to_ibs(event);
 
 	if (has_branch_stack(event))
 		return -EOPNOTSUPP;
diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 2704ec1e42a30..b605e08f9a8ef 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -194,7 +194,7 @@ static struct perf_ibs *get_ibs_pmu(int type)
 }
 
 /*
- * Use IBS for precise event sampling:
+ * core pmu config -> IBS config
  *
  *  perf record -a -e cpu-cycles:p ...    # use ibs op counting cycle count
  *  perf record -a -e r076:p ...          # same as -e cpu-cycles:p
@@ -203,25 +203,9 @@ static struct perf_ibs *get_ibs_pmu(int type)
  * IbsOpCntCtl (bit 19) of IBS Execution Control Register (IbsOpCtl,
  * MSRC001_1033) is used to select either cycle or micro-ops counting
  * mode.
- *
- * The rip of IBS samples has skid 0. Thus, IBS supports precise
- * levels 1 and 2 and the PERF_EFLAGS_EXACT is set. In rare cases the
- * rip is invalid when IBS was not able to record the rip correctly.
- * We clear PERF_EFLAGS_EXACT and take the rip from pt_regs then.
- *
  */
-static int perf_ibs_precise_event(struct perf_event *event, u64 *config)
+static int core_pmu_ibs_config(struct perf_event *event, u64 *config)
 {
-	switch (event->attr.precise_ip) {
-	case 0:
-		return -ENOENT;
-	case 1:
-	case 2:
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
 	switch (event->attr.type) {
 	case PERF_TYPE_HARDWARE:
 		switch (event->attr.config) {
@@ -247,22 +231,37 @@ static int perf_ibs_precise_event(struct perf_event *event, u64 *config)
 	return -EOPNOTSUPP;
 }
 
+/*
+ * The rip of IBS samples has skid 0. Thus, IBS supports precise
+ * levels 1 and 2 and the PERF_EFLAGS_EXACT is set. In rare cases the
+ * rip is invalid when IBS was not able to record the rip correctly.
+ * We clear PERF_EFLAGS_EXACT and take the rip from pt_regs then.
+ */
+int forward_event_to_ibs(struct perf_event *event)
+{
+	u64 config = 0;
+
+	if (!event->attr.precise_ip || event->attr.precise_ip > 2)
+		return -EOPNOTSUPP;
+
+	if (!core_pmu_ibs_config(event, &config)) {
+		event->attr.type = perf_ibs_op.pmu.type;
+		event->attr.config = config;
+	}
+	return -ENOENT;
+}
+
 static int perf_ibs_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	struct perf_ibs *perf_ibs;
 	u64 max_cnt, config;
-	int ret;
 
 	perf_ibs = get_ibs_pmu(event->attr.type);
-	if (perf_ibs) {
-		config = event->attr.config;
-	} else {
-		perf_ibs = &perf_ibs_op;
-		ret = perf_ibs_precise_event(event, &config);
-		if (ret)
-			return ret;
-	}
+	if (!perf_ibs)
+		return -ENOENT;
+
+	config = event->attr.config;
 
 	if (event->pmu != &perf_ibs->pmu)
 		return -ENOENT;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index a2b6626c681f5..0e4efcde07831 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -427,8 +427,10 @@ struct pebs_xmm {
 
 #ifdef CONFIG_X86_LOCAL_APIC
 extern u32 get_ibs_caps(void);
+extern int forward_event_to_ibs(struct perf_event *event);
 #else
 static inline u32 get_ibs_caps(void) { return 0; }
+static inline int forward_event_to_ibs(struct perf_event *event) { return -ENOENT; }
 #endif
 
 #ifdef CONFIG_PERF_EVENTS
-- 
2.39.2



