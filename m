Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E2E6FAE5E
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbjEHLoS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbjEHLn6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:43:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E0710A2F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:43:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28FD963622
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B27FC433D2;
        Mon,  8 May 2023 11:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546172;
        bh=ENgjwrIbcdGFTLTJRbqsqCqUaoSieHRtHatTB+kAJ5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dEp5po337nwvQVry45bRORr1YavkSvQ/7olK0hkZlMj9zRKBgMvP9xpfKTeazAGdA
         tGj1kRz47s/ch3gGVhSCwthVMaVt6C97JAMQb/c74Azi+nE2L3tCkWg/jvzHPnFQYH
         b/PdFQFyvI1YRB/KAvW6AAUOknzctpAa5L4w09Co=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liang He <windhl@126.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 280/371] macintosh/windfarm_smu_sat: Add missing of_node_put()
Date:   Mon,  8 May 2023 11:48:01 +0200
Message-Id: <20230508094823.108407795@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Liang He <windhl@126.com>

[ Upstream commit 631cf002826007ab7415258ee647dcaf8845ad5a ]

We call of_node_get() in wf_sat_probe() after sat is created,
so we need the of_node_put() before *kfree(sat)*.

Fixes: ac171c46667c ("[PATCH] powerpc: Thermal control for dual core G5s")
Signed-off-by: Liang He <windhl@126.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230330033558.2562778-1-windhl@126.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/macintosh/windfarm_smu_sat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/windfarm_smu_sat.c
index e46e1153a0b43..7d7d6213e32aa 100644
--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -171,6 +171,7 @@ static void wf_sat_release(struct kref *ref)
 
 	if (sat->nr >= 0)
 		sats[sat->nr] = NULL;
+	of_node_put(sat->node);
 	kfree(sat);
 }
 
-- 
2.39.2



