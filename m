Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130E7775CD7
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjHILbS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbjHILbR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:31:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41E910DC
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:31:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82E72633A0
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F936C433CA;
        Wed,  9 Aug 2023 11:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580675;
        bh=C26m9QNtAk5c1ikrIGckr4mcgTLN0m3srO6IIB2+MX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mkcPsYMxXGvRurIiaMDbpiBHuug13EByKXxdxj21tkcqXPe1SmgqCZ5yzbuV45hjq
         mJvSBeDSaFaggNAdJwgzlKZ1EOe6M3oHLC3iPYHou02Tjn+fAK76bUsw5TUpULtwXR
         X5P7IDEbAoJDZbEr1gvxeOH3hB1F7V3uq8tBdDr8=
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
Subject: [PATCH 5.4 108/154] net/sched: cls_fw: No longer copy tcf_result on update to avoid use-after-free
Date:   Wed,  9 Aug 2023 12:42:19 +0200
Message-ID: <20230809103640.526968022@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: valis <sec@valis.email>

[ Upstream commit 76e42ae831991c828cffa8c37736ebfb831ad5ec ]

When fw_change() is called on an existing filter, the whole
tcf_result struct is always copied into the new instance of the filter.

This causes a problem when updating a filter bound to a class,
as tcf_unbind_filter() is always called on the old instance in the
success path, decreasing filter_cnt of the still referenced class
and allowing it to be deleted, leading to a use-after-free.

Fix this by no longer copying the tcf_result struct from the old filter.

Fixes: e35a8ee5993b ("net: sched: fw use RCU")
Reported-by: valis <sec@valis.email>
Reported-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
Signed-off-by: valis <sec@valis.email>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Reviewed-by: M A Ramdhan <ramdhan@starlabs.sg>
Link: https://lore.kernel.org/r/20230729123202.72406-3-jhs@mojatatu.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/cls_fw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index 41f0898a5a565..08c41f1976c47 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -266,7 +266,6 @@ static int fw_change(struct net *net, struct sk_buff *in_skb,
 			return -ENOBUFS;
 
 		fnew->id = f->id;
-		fnew->res = f->res;
 		fnew->ifindex = f->ifindex;
 		fnew->tp = f->tp;
 
-- 
2.40.1



