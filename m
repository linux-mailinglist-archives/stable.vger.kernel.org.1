Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185927B8E2D
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 22:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbjJDUi1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 16:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbjJDUi0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 16:38:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9E1E4
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 13:38:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8FAC433CD;
        Wed,  4 Oct 2023 20:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696451902;
        bh=7IsvQZm94ACVEELdVb0zhCa5ptfJqE0xG7ACha379Qg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=KaxzsuLvLrkVf8rTUJ7meAERSenH/kiAEf1fX7UKrSoSn6PhEo6+1jBjFqSij1FbP
         wOFLvsSDiU0kPqCYrUi7a3vlLa1hfGfSHFRLrRE9TAW1Irn2L6xSdUHuZ70R+Sbndx
         Y8FIrOFv2/p9KCaIi7cWWSM3Og5GWub9k5jjtA07ZbwsjOrFAKtM+vZSMwBdbRhQdQ
         +3dPNUYsMcMDZlrk6RgTVy7uUqDzL5tIPKn1s9208qtTcnXo4DHHWVyn+E0s6LWRLg
         USR6m3tX7fEZ7p+RFkQD+ZZy4d0Uk+VnGR0Xc4uqH1bEyxTwM9wtmxu6docAPuAvN1
         KMdFqSUsVEbdg==
From:   Mat Martineau <martineau@kernel.org>
Date:   Wed, 04 Oct 2023 13:38:12 -0700
Subject: [PATCH net 2/3] mptcp: userspace pm allow creating id 0 subflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-send-net-20231004-v1-2-28de4ac663ae@kernel.org>
References: <20231004-send-net-20231004-v1-0-28de4ac663ae@kernel.org>
In-Reply-To: <20231004-send-net-20231004-v1-0-28de4ac663ae@kernel.org>
To:     Matthieu Baerts <matttbe@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matttbe@kernel.org>
Cc:     netdev@vger.kernel.org, mptcp@lists.linux.dev,
        Kishen Maloor <kishen.maloor@intel.com>,
        Florian Westphal <fw@strlen.de>,
        Mat Martineau <martineau@kernel.org>,
        Geliang Tang <geliang.tang@suse.com>, stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Geliang Tang <geliang.tang@suse.com>

This patch drops id 0 limitation in mptcp_nl_cmd_sf_create() to allow
creating additional subflows with the local addr ID 0.

There is no reason not to allow additional subflows from this local
address: we should be able to create new subflows from the initial
endpoint. This limitation was breaking fullmesh support from userspace.

Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/391
Cc: stable@vger.kernel.org
Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/pm_userspace.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b5a8aa4c1ebd..d042d32beb4d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -307,12 +307,6 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	if (addr_l.id == 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "missing local addr id");
-		err = -EINVAL;
-		goto create_err;
-	}
-
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");

-- 
2.41.0

