Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD95775CDC
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjHILbW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbjHILbU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:31:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8131BFA
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:31:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54DEC633B5
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63393C433C8;
        Wed,  9 Aug 2023 11:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580678;
        bh=/elxbnBDUqVhJTxLil6bn6cOiPcNgV0kGbBiJ3Rr4oQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZitzMuDlW1jIp4zvllZA6rQyB4cL2rqABpxVdeTdQQeFAmRUk1XKQMKKw5meCIRFn
         MruYKvx6K29KsxHbEgWD3A50PMLIw5++e15Sd8QRWtxFlJP62XIPm3Z8gaIYwC0dIa
         iOlqHnBJMq0Y0om/nYl9VyZnhch4UZLV0GT97qlQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, valis <sec@valis.email>,
        Bing-Jhong Billy Jheng <billy@starlabs.sg>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Victor Nogueira <victor@mojatatu.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        M A Ramdhan <ramdhan@starlabs.sg>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 109/154] net/sched: cls_route: No longer copy tcf_result on update to avoid use-after-free
Date:   Wed,  9 Aug 2023 12:42:20 +0200
Message-ID: <20230809103640.556271500@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: valis <sec@valis.email>

[ Upstream commit b80b829e9e2c1b3f7aae34855e04d8f6ecaf13c8 ]

When route4_change() is called on an existing filter, the whole
tcf_result struct is always copied into the new instance of the filter.

This causes a problem when updating a filter bound to a class,
as tcf_unbind_filter() is always called on the old instance in the
success path, decreasing filter_cnt of the still referenced class
and allowing it to be deleted, leading to a use-after-free.

Fix this by no longer copying the tcf_result struct from the old filter.

Fixes: 1109c00547fc ("net: sched: RCU cls_route")
Reported-by: valis <sec@valis.email>
Reported-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
Signed-off-by: valis <sec@valis.email>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Reviewed-by: M A Ramdhan <ramdhan@starlabs.sg>
Link: https://lore.kernel.org/r/20230729123202.72406-4-jhs@mojatatu.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/cls_route.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index b775e681cb56e..1ad4b3e60eb3b 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -511,7 +511,6 @@ static int route4_change(struct net *net, struct sk_buff *in_skb,
 	if (fold) {
 		f->id = fold->id;
 		f->iif = fold->iif;
-		f->res = fold->res;
 		f->handle = fold->handle;
 
 		f->tp = fold->tp;
-- 
2.40.1



