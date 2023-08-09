Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6FD7758C0
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbjHIKzO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbjHIKzC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:55:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4916B30CB
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:53:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ECA06312C
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2B6C433CB;
        Wed,  9 Aug 2023 10:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578387;
        bh=Sw/llUOb9mYICqypP9MOg/n7HwrSCiawYlYdmdYQdeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zbplwxFAz85BdXacAplegAYyMh+zqnIkouYfCDRyp2vlhaOX3hl2ruhgFjZ+FOyX1
         OYm3Lu+8/BU+nGjsBHliHQgUoBa53RfWWOLlmG+hJKkwabLEWMoIucBeqSRFiRfsFV
         lM2h3fHc3H8Ta7lWaM2EJCbqRLUoBLj4DLRt4XMw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Cixi Geng <cixi.geng1@unisoc.com>
Subject: [PATCH 6.1 002/127] perf: Fix function pointer case
Date:   Wed,  9 Aug 2023 12:39:49 +0200
Message-ID: <20230809103636.699171662@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Peter Zijlstra <peterz@infradead.org>

commit 1af6239d1d3e61d33fd2f0ba53d3d1a67cc50574 upstream.

With the advent of CFI it is no longer acceptible to cast function
pointers.

The robot complains thusly:

  kernel-events-core.c:warning:cast-from-int-(-)(struct-perf_cpu_pmu_context-)-to-remote_function_f-(aka-int-(-)(void-)-)-converts-to-incompatible-function-type

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/events/core.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1133,6 +1133,11 @@ static int perf_mux_hrtimer_restart(stru
 	return 0;
 }
 
+static int perf_mux_hrtimer_restart_ipi(void *arg)
+{
+	return perf_mux_hrtimer_restart(arg);
+}
+
 void perf_pmu_disable(struct pmu *pmu)
 {
 	int *count = this_cpu_ptr(pmu->pmu_disable_count);
@@ -11155,8 +11160,7 @@ perf_event_mux_interval_ms_store(struct
 		cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
 		cpuctx->hrtimer_interval = ns_to_ktime(NSEC_PER_MSEC * timer);
 
-		cpu_function_call(cpu,
-			(remote_function_f)perf_mux_hrtimer_restart, cpuctx);
+		cpu_function_call(cpu, perf_mux_hrtimer_restart_ipi, cpuctx);
 	}
 	cpus_read_unlock();
 	mutex_unlock(&mux_interval_mutex);


