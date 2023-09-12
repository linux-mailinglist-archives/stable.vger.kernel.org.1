Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B42079ACED
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350370AbjIKVhN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239986AbjIKOdU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:33:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A914CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:33:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDC9C433C8;
        Mon, 11 Sep 2023 14:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442795;
        bh=JNldJyYDfYvXgOcvddxt6LB07NfE+1hVP2uj0o2nk+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mUG76dcECLsnPMRwEOUFXdr3PSWmrDIXjPK4qABFaCsvXC01YHW9q+8h1v0bbvx4J
         l3dXMNDrJ1Idqp5dfo6eXcj9kjeLRK/5eePyDa+0hnfQebQj/N3VyBL0RYEX59fJBA
         6cEnuTq3xP4Ba8JnBiTG9vW1fhbwhSniv8/dn4zg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Cyril Hrubis <chrubis@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Petr Vorel <pvorel@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 123/737] sched/rt: Fix sysctl_sched_rr_timeslice intial value
Date:   Mon, 11 Sep 2023 15:39:42 +0200
Message-ID: <20230911134653.940715698@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cyril Hrubis <chrubis@suse.cz>

[ Upstream commit c7fcb99877f9f542c918509b2801065adcaf46fa ]

There is a 10% rounding error in the intial value of the
sysctl_sched_rr_timeslice with CONFIG_HZ_300=y.

This was found with LTP test sched_rr_get_interval01:

sched_rr_get_interval01.c:57: TPASS: sched_rr_get_interval() passed
sched_rr_get_interval01.c:64: TPASS: Time quantum 0s 99999990ns
sched_rr_get_interval01.c:72: TFAIL: /proc/sys/kernel/sched_rr_timeslice_ms != 100 got 90
sched_rr_get_interval01.c:57: TPASS: sched_rr_get_interval() passed
sched_rr_get_interval01.c:64: TPASS: Time quantum 0s 99999990ns
sched_rr_get_interval01.c:72: TFAIL: /proc/sys/kernel/sched_rr_timeslice_ms != 100 got 90

What this test does is to compare the return value from the
sched_rr_get_interval() and the sched_rr_timeslice_ms sysctl file and
fails if they do not match.

The problem it found is the intial sysctl file value which was computed as:

static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;

which works fine as long as MSEC_PER_SEC is multiple of HZ, however it
introduces 10% rounding error for CONFIG_HZ_300:

(MSEC_PER_SEC / HZ) * (100 * HZ / 1000)

(1000 / 300) * (100 * 300 / 1000)

3 * 30 = 90

This can be easily fixed by reversing the order of the multiplication
and division. After this fix we get:

(MSEC_PER_SEC * (100 * HZ / 1000)) / HZ

(1000 * (100 * 300 / 1000)) / 300

(1000 * 30) / 300 = 100

Fixes: 975e155ed873 ("sched/rt: Show the 'sched_rr_timeslice' SCHED_RR timeslice tuning knob in milliseconds")
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Acked-by: Mel Gorman <mgorman@suse.de>
Tested-by: Petr Vorel <pvorel@suse.cz>
Link: https://lore.kernel.org/r/20230802151906.25258-2-chrubis@suse.cz
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/rt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 00e0e50741153..185d3d749f6b6 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -25,7 +25,7 @@ unsigned int sysctl_sched_rt_period = 1000000;
 int sysctl_sched_rt_runtime = 950000;
 
 #ifdef CONFIG_SYSCTL
-static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
+static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC * RR_TIMESLICE) / HZ;
 static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
-- 
2.40.1



