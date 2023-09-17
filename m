Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2AE7A3C17
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240895AbjIQU0n (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240937AbjIQU0U (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:26:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2587012F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:26:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B92BC433C9;
        Sun, 17 Sep 2023 20:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982373;
        bh=vBtzceCxDqL14Is2PDLHpeeIcdTByt5hj0qXgrhbJjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iHLjNuVQCumbeaml0jV4w0yrtESOdaLG10pOUCLQR91i7rfF4a5QvcBsMa5EyuGae
         cyb3bKBcGyliNZOsGnZEbVmRw/Tfiw8RnpEYA1qbU1oI3kcvf/FTRXVXjcW9sQDORf
         ntlAeHvpuhtNLNisfe+YydZK3sncJKr46rkAJCts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 214/511] powerpc/perf: Convert fsl_emb notifier to state machine callbacks
Date:   Sun, 17 Sep 2023 21:10:41 +0200
Message-ID: <20230917191118.984984787@linuxfoundation.org>
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

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit 34daf445f82bd3a4df852bb5f1dffd792ac830a0 ]

  CC      arch/powerpc/perf/core-fsl-emb.o
arch/powerpc/perf/core-fsl-emb.c:675:6: error: no previous prototype for 'hw_perf_event_setup' [-Werror=missing-prototypes]
  675 | void hw_perf_event_setup(int cpu)
      |      ^~~~~~~~~~~~~~~~~~~

Looks like fsl_emb was completely missed by commit 3f6da3905398 ("perf:
Rework and fix the arch CPU-hotplug hooks")

So, apply same changes as commit 3f6da3905398 ("perf: Rework and fix
the arch CPU-hotplug hooks") then commit 57ecde42cc74 ("powerpc/perf:
Convert book3s notifier to state machine callbacks")

While at it, also fix following error:

arch/powerpc/perf/core-fsl-emb.c: In function 'perf_event_interrupt':
arch/powerpc/perf/core-fsl-emb.c:648:13: error: variable 'found' set but not used [-Werror=unused-but-set-variable]
  648 |         int found = 0;
      |             ^~~~~

Fixes: 3f6da3905398 ("perf: Rework and fix the arch CPU-hotplug hooks")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/603e1facb32608f88f40b7d7b9094adc50e7b2dc.1692349125.git.christophe.leroy@csgroup.eu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/perf/core-fsl-emb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/perf/core-fsl-emb.c b/arch/powerpc/perf/core-fsl-emb.c
index ee721f420a7ba..1a53ab08447cb 100644
--- a/arch/powerpc/perf/core-fsl-emb.c
+++ b/arch/powerpc/perf/core-fsl-emb.c
@@ -645,7 +645,6 @@ static void perf_event_interrupt(struct pt_regs *regs)
 	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
 	struct perf_event *event;
 	unsigned long val;
-	int found = 0;
 
 	for (i = 0; i < ppmu->n_counter; ++i) {
 		event = cpuhw->event[i];
@@ -654,7 +653,6 @@ static void perf_event_interrupt(struct pt_regs *regs)
 		if ((int)val < 0) {
 			if (event) {
 				/* event has overflowed */
-				found = 1;
 				record_and_restart(event, val, regs);
 			} else {
 				/*
@@ -672,11 +670,13 @@ static void perf_event_interrupt(struct pt_regs *regs)
 	isync();
 }
 
-void hw_perf_event_setup(int cpu)
+static int fsl_emb_pmu_prepare_cpu(unsigned int cpu)
 {
 	struct cpu_hw_events *cpuhw = &per_cpu(cpu_hw_events, cpu);
 
 	memset(cpuhw, 0, sizeof(*cpuhw));
+
+	return 0;
 }
 
 int register_fsl_emb_pmu(struct fsl_emb_pmu *pmu)
@@ -689,6 +689,8 @@ int register_fsl_emb_pmu(struct fsl_emb_pmu *pmu)
 		pmu->name);
 
 	perf_pmu_register(&fsl_emb_pmu, "cpu", PERF_TYPE_RAW);
+	cpuhp_setup_state(CPUHP_PERF_POWER, "perf/powerpc:prepare",
+			  fsl_emb_pmu_prepare_cpu, NULL);
 
 	return 0;
 }
-- 
2.40.1



