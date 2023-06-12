Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019A272C190
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbjFLK7C (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236462AbjFLKyp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:54:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A23121
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:41:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C59D614F0
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF8AC433D2;
        Mon, 12 Jun 2023 10:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566477;
        bh=QeV/Gn4pE6zfHkntn6BCF9T64o7+D0V5udD/hHyJ5uI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U607oFTJQ5vGI1GaMZxrz8C3HjFGPl4gezBCaieulIYea/JKrwJ7ipq581o8CcMaE
         U5/jfiC8PcSOj8IqEJvHZlgAboUqH9XNIgF4qPMJxvXhSCR0MUqpPcfcnL9hMmeAVE
         3OJj7yWepMvpKGcBmF/BZLRD3lCJRZWE3Z20Qdmw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 046/132] net: sched: move rtm_tca_policy declaration to include file
Date:   Mon, 12 Jun 2023 12:26:20 +0200
Message-ID: <20230612101712.361578254@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 886bc7d6ed3357975c5f1d3c784da96000d4bbb4 ]

rtm_tca_policy is used from net/sched/sch_api.c and net/sched/cls_api.c,
thus should be declared in an include file.

This fixes the following sparse warning:
net/sched/sch_api.c:1434:25: warning: symbol 'rtm_tca_policy' was not declared. Should it be static?

Fixes: e331473fee3d ("net/sched: cls_api: add missing validation of netlink attributes")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/pkt_sched.h | 2 ++
 net/sched/cls_api.c     | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 38207873eda69..8ab75128512ab 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -128,6 +128,8 @@ static inline void qdisc_run(struct Qdisc *q)
 	}
 }
 
+extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
+
 /* Calculate maximal size of packet seen by hard_start_xmit
    routine of this device.
  */
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 7b2aa04a7cdfd..b51d80a2fece3 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -41,8 +41,6 @@
 #include <net/tc_act/tc_gate.h>
 #include <net/flow_offload.h>
 
-extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
-
 /* The list of all installed classifier types */
 static LIST_HEAD(tcf_proto_base);
 
-- 
2.39.2



