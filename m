Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28D779C0C5
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240680AbjIKVEi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241506AbjIKPKM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:10:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93884FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:10:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB4EC433C9;
        Mon, 11 Sep 2023 15:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445007;
        bh=pdZNWwVYvrY4o4sWKGZRsFDsakrNaSD0OKucaDU2tkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MMlglZhRpswweKUaASm3/NPAtJTCkXRP19OPdJfaW0JBvIsVw3yHeCiwvFVZukBtj
         jRaPqPg9whhgh55jtyeaaEGAKwq75Ik+KxcU4mansd7CCAAQRr70ovmMIAhjMEBDeF
         336NwM5n6V1hJMDcp4TOWqlkg/l3RvF2vQv9x+X4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lin Ma <linma@zju.edu.cn>,
        Simon Horman <horms@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 193/600] wifi: nl80211/cfg80211: add forgotten nla_policy for BSS color attribute
Date:   Mon, 11 Sep 2023 15:43:46 +0200
Message-ID: <20230911134639.315752100@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lin Ma <linma@zju.edu.cn>

[ Upstream commit 218d690c49b7e9c94ad0d317adbdd4af846ea0dc ]

The previous commit dd3e4fc75b4a ("nl80211/cfg80211: add BSS color to
NDP ranging parameters") adds a parameter for NDP ranging by introducing
a new attribute type named NL80211_PMSR_FTM_REQ_ATTR_BSS_COLOR.

However, the author forgot to also describe the nla_policy at
nl80211_pmsr_ftm_req_attr_policy (net/wireless/nl80211.c). Just
complement it to avoid malformed attribute that causes out-of-attribute
access.

Fixes: dd3e4fc75b4a ("nl80211/cfg80211: add BSS color to NDP ranging parameters")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20230809033151.768910-1-linma@zju.edu.cn
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/nl80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index c2363d44a1ffc..12c7c89d5be1d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -323,6 +323,7 @@ nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED] = { .type = NLA_FLAG },
 	[NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED] = { .type = NLA_FLAG },
 	[NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK] = { .type = NLA_FLAG },
+	[NL80211_PMSR_FTM_REQ_ATTR_BSS_COLOR] = { .type = NLA_U8 },
 };
 
 static const struct nla_policy
-- 
2.40.1



