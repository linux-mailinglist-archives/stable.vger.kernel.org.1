Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF97783164
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 21:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjHUTvA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjHUTu7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:50:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF1018F
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:50:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 436C264401
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51969C433C8;
        Mon, 21 Aug 2023 19:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647454;
        bh=J2x+K3tuP85tZhJOouF4o1oCfodGS6jjxGqv6KArtHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wyCDYMw3US/qXvQ4scOBiJqxsSaZ3zYtnjkBMlIPzWsnvniyQf/1PwbbA1jKomJfb
         itnzfPFYu7Qyyto9ifBPyzRUtHXiUzd5lRNeD8WaPbEPbJlXPyqKYSZ4ENjzCfoVOa
         XeAni1chfvjQZap7QGrya/ZEXqo91oRHt8iugSQ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ulf Hansson <ulf.hansson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 002/194] cpuidle: psci: Extend information in log about OSI/PC mode
Date:   Mon, 21 Aug 2023 21:39:41 +0200
Message-ID: <20230821194122.799274711@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

[ Upstream commit 668057b07db069daac3ca4e4978f8373db9cb71c ]

It's useful to understand whether we are using OS-initiated (OSI) mode or
Platform Coordinated (PC) mode, when initializing the CPU PM domains.
Therefore, let's extend the print in the log after a successful probe with
this information.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Sudeep Holla <sudeep.holla@arm.com
Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 12acb348fa45 ("cpuidle: psci: Move enabling OSI mode after power domains creation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpuidle/cpuidle-psci-domain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index fe06644725203..1fca250d5dece 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -182,7 +182,8 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 	if (ret)
 		goto remove_pd;
 
-	pr_info("Initialized CPU PM domain topology\n");
+	pr_info("Initialized CPU PM domain topology using %s mode\n",
+		use_osi ? "OSI" : "PC");
 	return 0;
 
 put_node:
-- 
2.40.1



