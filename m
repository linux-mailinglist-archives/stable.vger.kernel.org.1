Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10FD7DD544
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376489AbjJaRsr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376495AbjJaRsq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:48:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE99A2
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:48:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFF7C433C7;
        Tue, 31 Oct 2023 17:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774524;
        bh=hqYHP5Pj1VbE5fa8DN5sv0wzbDvlZjyg4iJlO4bMxZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z/PZJ6ii6UqgqD0Q5i7GL/1/reR8apJuRtGG1xvxVIa4dXFTx9N4kwubC7EIMk+Ag
         NoInOxioPLF2C6Nrl5vBa02mgTLPMpGs3HcZUliywYjIMy2CQH+VvgidaAiGPLbwED
         KyqQP1/zIXKoiyuXIXVGkUPbuNSSFC1mwnSvOMzM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paul Blakey <paulb@nvidia.com>,
        Vlad Buslov <vladbu@nvidia.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 076/112] net/sched: act_ct: additional checks for outdated flows
Date:   Tue, 31 Oct 2023 18:01:17 +0100
Message-ID: <20231031165903.717364465@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vlad Buslov <vladbu@nvidia.com>

[ Upstream commit a63b6622120cd03a304796dbccb80655b3a21798 ]

Current nf_flow_is_outdated() implementation considers any flow table flow
which state diverged from its underlying CT connection status for teardown
which can be problematic in the following cases:

- Flow has never been offloaded to hardware in the first place either
because flow table has hardware offload disabled (flag
NF_FLOWTABLE_HW_OFFLOAD is not set) or because it is still pending on 'add'
workqueue to be offloaded for the first time. The former is incorrect, the
later generates excessive deletions and additions of flows.

- Flow is already pending to be updated on the workqueue. Tearing down such
flows will also generate excessive removals from the flow table, especially
on highly loaded system where the latency to re-offload a flow via 'add'
workqueue can be quite high.

When considering a flow for teardown as outdated verify that it is both
offloaded to hardware and doesn't have any pending updates.

Fixes: 41f2c7c342d3 ("net/sched: act_ct: Fix promotion of offloaded unreplied tuple")
Reviewed-by: Paul Blakey <paulb@nvidia.com>
Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_ct.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 2b5ef83e44243..ad7c955453782 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -281,6 +281,8 @@ static int tcf_ct_flow_table_fill_actions(struct net *net,
 static bool tcf_ct_flow_is_outdated(const struct flow_offload *flow)
 {
 	return test_bit(IPS_SEEN_REPLY_BIT, &flow->ct->status) &&
+	       test_bit(IPS_HW_OFFLOAD_BIT, &flow->ct->status) &&
+	       !test_bit(NF_FLOW_HW_PENDING, &flow->flags) &&
 	       !test_bit(NF_FLOW_HW_ESTABLISHED, &flow->flags);
 }
 
-- 
2.42.0



