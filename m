Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91677BDDCE
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376840AbjJINNa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377010AbjJINNS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:13:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041B1109
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:12:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A66C433C8;
        Mon,  9 Oct 2023 13:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857145;
        bh=o5aMP1GZMBlUE1/5MHBmY6ysB1cmnze47eUg4X8jfso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I6hRXDVQYx3RDOZ4JSMJrkVjZTweNOCUI9rY9wBqmy+AxY6ngkTYogCDyEEVj5zVw
         gRYA9JPJD1H0WTlMLBselgEwCFQZmNrxzjsOA30V7Nhe4FPnq0AbF/XmhFBDNue0C/
         0sVlpYKQ0y2vVXWlF468pzrE3dLGrkfAwQlpwr2w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 111/163] ethtool: plca: fix plca enable data type while parsing the value
Date:   Mon,  9 Oct 2023 15:01:15 +0200
Message-ID: <20231009130127.089096435@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>

[ Upstream commit 8957261cd8149ed9d0738c01c0320bcbff989407 ]

The ETHTOOL_A_PLCA_ENABLED data type is u8. But while parsing the
value from the attribute, nla_get_u32() is used in the plca_update_sint()
function instead of nla_get_u8(). So plca_cfg.enabled variable is updated
with some garbage value instead of 0 or 1 and always enables plca even
though plca is disabled through ethtool application. This bug has been
fixed by parsing the values based on the attributes type in the policy.

Fixes: 8580e16c28f3 ("net/ethtool: add netlink interface for the PLCA RS")
Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/20230908044548.5878-1-Parthiban.Veerasooran@microchip.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ethtool/plca.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/net/ethtool/plca.c b/net/ethtool/plca.c
index 5a8cab4df0c9c..a9334937ace26 100644
--- a/net/ethtool/plca.c
+++ b/net/ethtool/plca.c
@@ -21,16 +21,6 @@ struct plca_reply_data {
 #define PLCA_REPDATA(__reply_base) \
 	container_of(__reply_base, struct plca_reply_data, base)
 
-static void plca_update_sint(int *dst, const struct nlattr *attr,
-			     bool *mod)
-{
-	if (!attr)
-		return;
-
-	*dst = nla_get_u32(attr);
-	*mod = true;
-}
-
 // PLCA get configuration message ------------------------------------------- //
 
 const struct nla_policy ethnl_plca_get_cfg_policy[] = {
@@ -38,6 +28,29 @@ const struct nla_policy ethnl_plca_get_cfg_policy[] = {
 		NLA_POLICY_NESTED(ethnl_header_policy),
 };
 
+static void plca_update_sint(int *dst, struct nlattr **tb, u32 attrid,
+			     bool *mod)
+{
+	const struct nlattr *attr = tb[attrid];
+
+	if (!attr ||
+	    WARN_ON_ONCE(attrid >= ARRAY_SIZE(ethnl_plca_set_cfg_policy)))
+		return;
+
+	switch (ethnl_plca_set_cfg_policy[attrid].type) {
+	case NLA_U8:
+		*dst = nla_get_u8(attr);
+		break;
+	case NLA_U32:
+		*dst = nla_get_u32(attr);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
+
+	*mod = true;
+}
+
 static int plca_get_cfg_prepare_data(const struct ethnl_req_info *req_base,
 				     struct ethnl_reply_data *reply_base,
 				     struct genl_info *info)
@@ -144,13 +157,13 @@ ethnl_set_plca(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -EOPNOTSUPP;
 
 	memset(&plca_cfg, 0xff, sizeof(plca_cfg));
-	plca_update_sint(&plca_cfg.enabled, tb[ETHTOOL_A_PLCA_ENABLED], &mod);
-	plca_update_sint(&plca_cfg.node_id, tb[ETHTOOL_A_PLCA_NODE_ID], &mod);
-	plca_update_sint(&plca_cfg.node_cnt, tb[ETHTOOL_A_PLCA_NODE_CNT], &mod);
-	plca_update_sint(&plca_cfg.to_tmr, tb[ETHTOOL_A_PLCA_TO_TMR], &mod);
-	plca_update_sint(&plca_cfg.burst_cnt, tb[ETHTOOL_A_PLCA_BURST_CNT],
+	plca_update_sint(&plca_cfg.enabled, tb, ETHTOOL_A_PLCA_ENABLED, &mod);
+	plca_update_sint(&plca_cfg.node_id, tb, ETHTOOL_A_PLCA_NODE_ID, &mod);
+	plca_update_sint(&plca_cfg.node_cnt, tb, ETHTOOL_A_PLCA_NODE_CNT, &mod);
+	plca_update_sint(&plca_cfg.to_tmr, tb, ETHTOOL_A_PLCA_TO_TMR, &mod);
+	plca_update_sint(&plca_cfg.burst_cnt, tb, ETHTOOL_A_PLCA_BURST_CNT,
 			 &mod);
-	plca_update_sint(&plca_cfg.burst_tmr, tb[ETHTOOL_A_PLCA_BURST_TMR],
+	plca_update_sint(&plca_cfg.burst_tmr, tb, ETHTOOL_A_PLCA_BURST_TMR,
 			 &mod);
 	if (!mod)
 		return 0;
-- 
2.40.1



