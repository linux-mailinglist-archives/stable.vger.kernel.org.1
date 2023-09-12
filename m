Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF3679BD65
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379444AbjIKWoI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238302AbjIKNxl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:53:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45037CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:53:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E5AC433C7;
        Mon, 11 Sep 2023 13:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440416;
        bh=5V48RBXN2ptguGI4x/4Ja50iDIs27PgkQRgtyRtg+K0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MLS9016Nieneo+rVELnQOLBFi7iY5FW4NwgvtFjdZnFzsTeOTBMRaEpzgsFCPN/Oe
         sUBQc8T1otMukxnhebkKd9YzT/Usuq765bu9DhD4HxjWz5zG4O/Iq97ZGzr3S2ldRm
         M/dCOc7aIqEMvDGkbXpjgusAIOk8oCtMsikA+g/A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Chris Bainbridge <chris.bainbridge@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 027/739] clocksource: Handle negative skews in "skew is too large" messages
Date:   Mon, 11 Sep 2023 15:37:06 +0200
Message-ID: <20230911134651.821495178@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul E. McKenney <paulmck@kernel.org>

[ Upstream commit e40806e9bcf8aaa86dbf0d484e7cf3cfa09cb86c ]

The nanosecond-to-millisecond skew computation uses unsigned arithmetic,
which produces user-unfriendly large positive numbers for negative skews.
Therefore, use signed arithmetic for this computation in order to preserve
the negativity.

Reported-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Reported-by: Feng Tang <feng.tang@intel.com>
Fixes: dd029269947a ("clocksource: Improve "skew is too large" messages")
Reviewed-by: Feng Tang <feng.tang@intel.com>
Tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/clocksource.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 88cbc1181b239..c108ed8a9804a 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -473,8 +473,8 @@ static void clocksource_watchdog(struct timer_list *unused)
 		/* Check the deviation from the watchdog clocksource. */
 		md = cs->uncertainty_margin + watchdog->uncertainty_margin;
 		if (abs(cs_nsec - wd_nsec) > md) {
-			u64 cs_wd_msec;
-			u64 wd_msec;
+			s64 cs_wd_msec;
+			s64 wd_msec;
 			u32 wd_rem;
 
 			pr_warn("timekeeping watchdog on CPU%d: Marking clocksource '%s' as unstable because the skew is too large:\n",
@@ -483,8 +483,8 @@ static void clocksource_watchdog(struct timer_list *unused)
 				watchdog->name, wd_nsec, wdnow, wdlast, watchdog->mask);
 			pr_warn("                      '%s' cs_nsec: %lld cs_now: %llx cs_last: %llx mask: %llx\n",
 				cs->name, cs_nsec, csnow, cslast, cs->mask);
-			cs_wd_msec = div_u64_rem(cs_nsec - wd_nsec, 1000U * 1000U, &wd_rem);
-			wd_msec = div_u64_rem(wd_nsec, 1000U * 1000U, &wd_rem);
+			cs_wd_msec = div_s64_rem(cs_nsec - wd_nsec, 1000 * 1000, &wd_rem);
+			wd_msec = div_s64_rem(wd_nsec, 1000 * 1000, &wd_rem);
 			pr_warn("                      Clocksource '%s' skewed %lld ns (%lld ms) over watchdog '%s' interval of %lld ns (%lld ms)\n",
 				cs->name, cs_nsec - wd_nsec, cs_wd_msec, watchdog->name, wd_nsec, wd_msec);
 			if (curr_clocksource == cs)
-- 
2.40.1



