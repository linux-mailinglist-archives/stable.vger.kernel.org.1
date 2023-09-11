Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2996A79B663
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379465AbjIKWoT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239980AbjIKOdL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:33:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16593CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:33:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59318C433C7;
        Mon, 11 Sep 2023 14:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442786;
        bh=eAjSyou25ZECBQpYusBfdlokW1rteJlsg56UnTF3rXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jzYEI2RFvpGoMTFDhe+poFQU7Lx9ASxbmZy/F20/nG6OglXI3jZNLFtCwES/SYoY8
         1g2+X8b0hs49EoWFotpZoyV6nbORkuqdclIbsNljWDTkE5bsnwt7pq2Xzsa0IIhfFm
         Mb3aCB2Zg3UZD6w59SOyXfupjeALuC5pvEC8gJ2A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>
Subject: [PATCH 6.4 120/737] cpuidle: teo: Update idle duration estimate when choosing shallower state
Date:   Mon, 11 Sep 2023 15:39:39 +0200
Message-ID: <20230911134653.856543164@linuxfoundation.org>
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

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit 3f0b0966b30982e843950b170b7a9ddfd8094428 ]

The TEO governor takes CPU utilization into account by refining idle state
selection when the utilization is above a certain threshold.  This is done by
choosing an idle state shallower than the previously selected one.

However, when doing this, the idle duration estimate needs to be
adjusted so as to prevent the scheduler tick from being stopped when the
candidate idle state is shallow, which may lead to excessive energy
usage if the CPU is not woken up quickly enough going forward.
Moreover, if the scheduler tick has been stopped already and the new
idle duration estimate is too small, the replacement candidate state
cannot be used.

Modify the relevant code to take the above observations into account.

Fixes: 9ce0f7c4bc64 ("cpuidle: teo: Introduce util-awareness")
Link: https://lore.kernel.org/linux-pm/CAJZ5v0jJxHj65r2HXBTd3wfbZtsg=_StzwO1kA5STDnaPe_dWA@mail.gmail.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-and-tested-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpuidle/governors/teo.c | 40 ++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index 987fc5f3997dc..2cdc711679a5f 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -397,13 +397,23 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	 * the shallowest non-polling state and exit.
 	 */
 	if (drv->state_count < 3 && cpu_data->utilized) {
-		for (i = 0; i < drv->state_count; ++i) {
-			if (!dev->states_usage[i].disable &&
-			    !(drv->states[i].flags & CPUIDLE_FLAG_POLLING)) {
-				idx = i;
-				goto end;
-			}
-		}
+		/* The CPU is utilized, so assume a short idle duration. */
+		duration_ns = teo_middle_of_bin(0, drv);
+		/*
+		 * If state 0 is enabled and it is not a polling one, select it
+		 * right away unless the scheduler tick has been stopped, in
+		 * which case care needs to be taken to leave the CPU in a deep
+		 * enough state in case it is not woken up any time soon after
+		 * all.  If state 1 is disabled, though, state 0 must be used
+		 * anyway.
+		 */
+		if ((!idx && !(drv->states[0].flags & CPUIDLE_FLAG_POLLING) &&
+		    teo_time_ok(duration_ns)) || dev->states_usage[1].disable)
+			idx = 0;
+		else /* Assume that state 1 is not a polling one and use it. */
+			idx = 1;
+
+		goto end;
 	}
 
 	/*
@@ -539,10 +549,20 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 
 	/*
 	 * If the CPU is being utilized over the threshold, choose a shallower
-	 * non-polling state to improve latency
+	 * non-polling state to improve latency, unless the scheduler tick has
+	 * been stopped already and the shallower state's target residency is
+	 * not sufficiently large.
 	 */
-	if (cpu_data->utilized)
-		idx = teo_find_shallower_state(drv, dev, idx, duration_ns, true);
+	if (cpu_data->utilized) {
+		s64 span_ns;
+
+		i = teo_find_shallower_state(drv, dev, idx, duration_ns, true);
+		span_ns = teo_middle_of_bin(i, drv);
+		if (teo_time_ok(span_ns)) {
+			idx = i;
+			duration_ns = span_ns;
+		}
+	}
 
 end:
 	/*
-- 
2.40.1



