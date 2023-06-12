Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B53772BFE3
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbjFLKrq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbjFLKr0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:47:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1869DFBA5
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:32:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ED14615BF
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B358DC433D2;
        Mon, 12 Jun 2023 10:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686565931;
        bh=Heh1QZZ2wgfsQaNm1hhECnUwnLL9OXxI1vZ3LmjW2gM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IMvU9UnZf58BDGrbLNQDc3pByX/xy1x3NX87qV8C4XedpLhRKNXf5bNa91sAiFupd
         X97Qae5cb7t9nXx5SwLSIvv8E4aMoxnclNm9QaiLb45NDGx0GoQRSQIutyJG6AkvFr
         XN6H0rwTfqSolLaq3Zb4gmpH5CbsLuYB4cO3TQSQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hangyu Hua <hbh25y@gmail.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 16/45] net: sched: fix possible refcount leak in tc_chain_tmplt_add()
Date:   Mon, 12 Jun 2023 12:26:10 +0200
Message-ID: <20230612101655.307654433@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101654.644983109@linuxfoundation.org>
References: <20230612101654.644983109@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hangyu Hua <hbh25y@gmail.com>

[ Upstream commit 44f8baaf230c655c249467ca415b570deca8df77 ]

try_module_get will be called in tcf_proto_lookup_ops. So module_put needs
to be called to drop the refcount if ops don't implement the required
function.

Fixes: 9f407f1768d3 ("net: sched: introduce chain templates")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/cls_api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 3e5b10bec0cf7..a4cf718bdb8a0 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2732,6 +2732,7 @@ static int tc_chain_tmplt_add(struct tcf_chain *chain, struct net *net,
 		return PTR_ERR(ops);
 	if (!ops->tmplt_create || !ops->tmplt_destroy || !ops->tmplt_dump) {
 		NL_SET_ERR_MSG(extack, "Chain templates are not supported with specified classifier");
+		module_put(ops->owner);
 		return -EOPNOTSUPP;
 	}
 
-- 
2.39.2



