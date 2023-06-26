Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FAF73E84B
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjFZSYI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjFZSXx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:23:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E132137
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:23:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 301B160F6D
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3799CC433CA;
        Mon, 26 Jun 2023 18:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803800;
        bh=7GvhKF1iSDbHO+OCyxzAUWOgKaaTaZ+MHS1+Pk9HtO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Al4xpExS0lMuDW8VM7wUZoGrAZyR1Wp3EwerqKwujQsJV+3x6KTLuvh2EqGGx2Jxq
         7JmLMpvVEbuZNCGpR5a8C+VUuSUQxB6K+JHMXgGnnOHSfhp14ACslr0xGaHjH+pbbS
         9lbjQrg5h0yNzmgIm0lSUpJCKaM2g/rc9SXB6tXE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Min-Hua Chen <minhuadotchen@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 180/199] net: sched: wrap tc_skip_wrapper with CONFIG_RETPOLINE
Date:   Mon, 26 Jun 2023 20:11:26 +0200
Message-ID: <20230626180813.655617170@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
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

From: Min-Hua Chen <minhuadotchen@gmail.com>

[ Upstream commit 8cde87b007dad2e461015ff70352af56ceb02c75 ]

This patch fixes the following sparse warning:

net/sched/sch_api.c:2305:1: sparse: warning: symbol 'tc_skip_wrapper' was not declared. Should it be static?

No functional change intended.

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
Acked-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_api.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 3f7311529cc00..34c90c9c2fcad 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -2324,7 +2324,9 @@ static struct pernet_operations psched_net_ops = {
 	.exit = psched_net_exit,
 };
 
+#if IS_ENABLED(CONFIG_RETPOLINE)
 DEFINE_STATIC_KEY_FALSE(tc_skip_wrapper);
+#endif
 
 static int __init pktsched_init(void)
 {
-- 
2.39.2



