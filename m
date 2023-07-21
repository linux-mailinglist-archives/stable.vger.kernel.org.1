Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E8675CF31
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjGUQ2k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjGUQ1p (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:27:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47BB44BE
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:24:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0C1061D53
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A8FC433C9;
        Fri, 21 Jul 2023 16:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956669;
        bh=/3SoltwMI42/XF05RtByg7qawtRF9zbf4jhmkfdSWeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eNFdb/QQ+eZQ1Zk3XGwWMYU4ejCum/BzASKBn613BL/WBTbMyDEllnP9shlYm8bnH
         +alaiEMKb+USrwHB+2AEn0w8JDqQwNcWmfeMdLCptoaSJtAcOsgvblYi3EQuCTaMY3
         q4llwMub2CDF0QdLqsWRpitd+egluS+cWGtXYr24=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Greg Thelen <gthelen@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 6.4 250/292] perf/x86: Fix lockdep warning in for_each_sibling_event() on SPR
Date:   Fri, 21 Jul 2023 18:05:59 +0200
Message-ID: <20230721160539.657762091@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
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

From: Namhyung Kim <namhyung@kernel.org>

commit 27c68c216ee1f1b086e789a64486e6511e380b8a upstream.

On SPR, the load latency event needs an auxiliary event in the same
group to work properly.  There's a check in intel_pmu_hw_config()
for this to iterate sibling events and find a mem-loads-aux event.

The for_each_sibling_event() has a lockdep assert to make sure if it
disabled hardirq or hold leader->ctx->mutex.  This works well if the
given event has a separate leader event since perf_try_init_event()
grabs the leader->ctx->mutex to protect the sibling list.  But it can
cause a problem when the event itself is a leader since the event is
not initialized yet and there's no ctx for the event.

Actually I got a lockdep warning when I run the below command on SPR,
but I guess it could be a NULL pointer dereference.

  $ perf record -d -e cpu/mem-loads/uP true

The code path to the warning is:

  sys_perf_event_open()
    perf_event_alloc()
      perf_init_event()
        perf_try_init_event()
          x86_pmu_event_init()
            hsw_hw_config()
              intel_pmu_hw_config()
                for_each_sibling_event()
                  lockdep_assert_event_ctx()

We don't need for_each_sibling_event() when it's a standalone event.
Let's return the error code directly.

Fixes: f3c0eba28704 ("perf: Add a few assertions")
Reported-by: Greg Thelen <gthelen@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20230704181516.3293665-1-namhyung@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/intel/core.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3993,6 +3993,13 @@ static int intel_pmu_hw_config(struct pe
 		struct perf_event *leader = event->group_leader;
 		struct perf_event *sibling = NULL;
 
+		/*
+		 * When this memload event is also the first event (no group
+		 * exists yet), then there is no aux event before it.
+		 */
+		if (leader == event)
+			return -ENODATA;
+
 		if (!is_mem_loads_aux_event(leader)) {
 			for_each_sibling_event(sibling, leader) {
 				if (is_mem_loads_aux_event(sibling))


