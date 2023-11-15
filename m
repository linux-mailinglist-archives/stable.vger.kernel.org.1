Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DC67ECDB7
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbjKOTiA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbjKOTh6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:37:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317EA12C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:37:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9354EC433C7;
        Wed, 15 Nov 2023 19:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077074;
        bh=gLx4kcQTzC2iRHGyNEVQaU5C70CVsBdLd49xPZlaEwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=REzTVtgTd7gjveAZiFzVxnTPB4Fa0ie/7G2jiizDAAZA7MsfDTAAR+f8rolyQ8B82
         1CE8Au/HNx/brc8cXIngORrIaAyu5QJgCRHF8JlEepli+JxRRhHLgSL+7Y/MYPhw2o
         sLL3uuVjUjh/IC92NFLhZevuWOv1SftzrEc93nUk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 116/603] netfilter: nf_tables: Drop pointless memset when dumping rules
Date:   Wed, 15 Nov 2023 14:11:01 -0500
Message-ID: <20231115191621.272692735@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Phil Sutter <phil@nwl.cc>

[ Upstream commit 30fa41a0f6df4c85790cc6499ddc4a926a113bfa ]

None of the dump callbacks uses netlink_callback::args beyond the first
element, no need to zero the data.

Fixes: 96518518cc41 ("netfilter: add nftables")
Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 29c651804cb22..3bf428a188ccf 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3465,10 +3465,6 @@ static int __nf_tables_dump_rules(struct sk_buff *skb,
 			goto cont_skip;
 		if (*idx < s_idx)
 			goto cont;
-		if (*idx > s_idx) {
-			memset(&cb->args[1], 0,
-					sizeof(cb->args) - sizeof(cb->args[0]));
-		}
 		if (prule)
 			handle = prule->handle;
 		else
-- 
2.42.0



