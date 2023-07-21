Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8420775D1B6
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjGUSwQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjGUSwL (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:52:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3533A85
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:51:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59F3F619FD
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F66C433C8;
        Fri, 21 Jul 2023 18:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965516;
        bh=PKo4pleZ/+fuPwjFjex+7m+LBAXYEIFc6LzHHJhjZh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tKPW2C3i9lUSwY36IcXwqxpN+zTpybt/y+8tHYr14ZPH/TiNeMJgwrRQ2+49BDvqX
         u8rnjI5SoWVODJ2xaixZx8JllrFlXByZYRRAGTU9TRO5l3cJl66+0TqhCcKZkfNfhu
         mO5RkDS+a1RqRlMMbz0bqevUC8n0ZNOCBUX8QA8o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Niklas Neronin <niklas.neronin@intel.com>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 019/532] cpufreq: intel_pstate: Fix energy_performance_preference for passive
Date:   Fri, 21 Jul 2023 17:58:43 +0200
Message-ID: <20230721160615.713308634@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tero Kristo <tero.kristo@linux.intel.com>

[ Upstream commit 03f44ffb3d5be2fceda375d92c70ab6de4df7081 ]

If the intel_pstate driver is set to passive mode, then writing the
same value to the energy_performance_preference sysfs twice will fail.
This is caused by the wrong return value used (index of the matched
energy_perf_string), instead of the length of the passed in parameter.
Fix by forcing the internal return value to zero when the same
preference is passed in by user. This same issue is not present when
active mode is used for the driver.

Fixes: f6ebbcf08f37 ("cpufreq: intel_pstate: Implement passive mode with HWP enabled")
Reported-by: Niklas Neronin <niklas.neronin@intel.com>
Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/intel_pstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index eee74a2fe3174..2f5063db2f1fc 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -824,6 +824,8 @@ static ssize_t store_energy_performance_preference(
 			err = cpufreq_start_governor(policy);
 			if (!ret)
 				ret = err;
+		} else {
+			ret = 0;
 		}
 	}
 
-- 
2.39.2



