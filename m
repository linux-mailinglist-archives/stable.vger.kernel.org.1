Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AB96FAB3E
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjEHLKt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjEHLKs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:10:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC24732368
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:10:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32F4762B63
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF5EC433EF;
        Mon,  8 May 2023 11:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544246;
        bh=OuNjMXmlzqQiPYImBTWREOcHDDwi3oGzydEbu2VEC+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IG0e+M0v1mvx47Fwg0MOhdHqIbOAvhtOykGABAKp6EFaIfTzA0vNhZ++qIGvnzYuq
         VMymP94twtmDJ4eI+fY7eQvI77MaC3+PRY/U9xoavBxsdbGWtP9r6CZlFGZMFEcegD
         7SmKvRMu5tjnrGhEv+7sZODZu6tVLq0liD6/izpo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Sanjay Chandrashekara <sanjayc@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 317/694] cpufreq: use correct unit when verify cur freq
Date:   Mon,  8 May 2023 11:42:32 +0200
Message-Id: <20230508094442.592021639@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sanjay Chandrashekara <sanjayc@nvidia.com>

[ Upstream commit 44295af5019f1997d038ad2611086a2d1e2af167 ]

cpufreq_verify_current_freq checks() if the frequency returned by
the hardware has a slight delta with the valid frequency value
last set and returns "policy->cur" if the delta is within "1 MHz".
In the comparison, "policy->cur" is in "kHz" but it's compared
against HZ_PER_MHZ. So, the comparison range becomes "1 GHz".

Fix this by comparing against KHZ_PER_MHZ instead of HZ_PER_MHZ.

Fixes: f55ae08c8987 ("cpufreq: Avoid unnecessary frequency updates due to mismatch")
Signed-off-by: Sanjay Chandrashekara <sanjayc@nvidia.com>
[ sumit gupta: Commit message update ]
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 6d8fd3b8dcb52..a0742c787014d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1727,7 +1727,7 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
 		 * MHz. In such cases it is better to avoid getting into
 		 * unnecessary frequency updates.
 		 */
-		if (abs(policy->cur - new_freq) < HZ_PER_MHZ)
+		if (abs(policy->cur - new_freq) < KHZ_PER_MHZ)
 			return policy->cur;
 
 		cpufreq_out_of_sync(policy, new_freq);
-- 
2.39.2



