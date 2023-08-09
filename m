Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78183775781
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjHIKqv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjHIKqu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:46:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F7B1BCF
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:46:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D340630D2
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F215C433C7;
        Wed,  9 Aug 2023 10:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578006;
        bh=Sq70zDpA9bUaqA8q/43orJPsjhYX4lbqEdOc+1lX/WA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aA0PL4NLfTre+DhSFyr5O8l5ckH04psfU3B8qzL4ozDW6IR80Zm+zt0CYzGojFGNG
         7n3lA8ts1ewomhVe4OzZUKiFSdoQUoh/gHOvRmjRgY4C7rB3Z8I+sbuESfxGEZLQEC
         94F49eaz74IbdXbixUsR+uPROwyx1uz0LSO9OOfA=
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
Subject: [PATCH 6.4 073/165] net/sched: cls_route: No longer copy tcf_result on update to avoid use-after-free
Date:   Wed,  9 Aug 2023 12:40:04 +0200
Message-ID: <20230809103645.191283349@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
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
index d0c53724d3e86..1e20bbd687f1d 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -513,7 +513,6 @@ static int route4_change(struct net *net, struct sk_buff *in_skb,
 	if (fold) {
 		f->id = fold->id;
 		f->iif = fold->iif;
-		f->res = fold->res;
 		f->handle = fold->handle;
 
 		f->tp = fold->tp;
-- 
2.40.1



