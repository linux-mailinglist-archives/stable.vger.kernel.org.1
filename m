Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF49578AD04
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjH1KpQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjH1Kou (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:44:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867B7CF2
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:44:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AB66641FE
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2A0C433C9;
        Mon, 28 Aug 2023 10:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219451;
        bh=AYSRjdpxkbzCzXG/yu73sYyUTDi9sHmm29/TB2y0Hns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jW0krv3uW68VxfW+yuRAo0XCLgAj7+lLqiR3yZm16ItYAs3c+3Ui/VtvqdxGDw1no
         bxe/5t9W70e+/O9ACsiW7lYtj5kevpps3SIAVBY8jWaLklnyp+/8HqYQpbfElphawG
         pvFX2WK0XtGhXn7dVxfNk2qjbsauiPE9amrBp4V4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Florent Fourcot <florent.fourcot@wifirst.fr>,
        Brian Baboch <brian.baboch@wifirst.fr>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 40/89] rtnetlink: return ENODEV when ifname does not exist and group is given
Date:   Mon, 28 Aug 2023 12:13:41 +0200
Message-ID: <20230828101151.534277291@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101150.163430842@linuxfoundation.org>
References: <20230828101150.163430842@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florent Fourcot <florent.fourcot@wifirst.fr>

[ Upstream commit ef2a7c9065cea4e3fbc0390e82d05141abbccd7f ]

When the interface does not exist, and a group is given, the given
parameters are being set to all interfaces of the given group. The given
IFNAME/ALT_IF_NAME are being ignored in that case.

That can be dangerous since a typo (or a deleted interface) can produce
weird side effects for caller:

Case 1:

 IFLA_IFNAME=valid_interface
 IFLA_GROUP=1
 MTU=1234

Case 1 will update MTU and group of the given interface "valid_interface".

Case 2:

 IFLA_IFNAME=doesnotexist
 IFLA_GROUP=1
 MTU=1234

Case 2 will update MTU of all interfaces in group 1. IFLA_IFNAME is
ignored in this case

This behaviour is not consistent and dangerous. In order to fix this issue,
we now return ENODEV when the given IFNAME does not exist.

Signed-off-by: Florent Fourcot <florent.fourcot@wifirst.fr>
Signed-off-by: Brian Baboch <brian.baboch@wifirst.fr>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 30188bd7838c ("rtnetlink: Reject negative ifindexes in RTM_NEWLINK")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/rtnetlink.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 03dd8dc9e1425..7c1a2fd7d9532 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3294,6 +3294,7 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct ifinfomsg *ifm;
 	char ifname[IFNAMSIZ];
 	struct nlattr **data;
+	bool link_specified;
 	int err;
 
 #ifdef CONFIG_MODULES
@@ -3314,12 +3315,16 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		ifname[0] = '\0';
 
 	ifm = nlmsg_data(nlh);
-	if (ifm->ifi_index > 0)
+	if (ifm->ifi_index > 0) {
+		link_specified = true;
 		dev = __dev_get_by_index(net, ifm->ifi_index);
-	else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME])
+	} else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME]) {
+		link_specified = true;
 		dev = rtnl_dev_get(net, NULL, tb[IFLA_ALT_IFNAME], ifname);
-	else
+	} else {
+		link_specified = false;
 		dev = NULL;
+	}
 
 	master_dev = NULL;
 	m_ops = NULL;
@@ -3422,7 +3427,12 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	if (!(nlh->nlmsg_flags & NLM_F_CREATE)) {
-		if (ifm->ifi_index == 0 && tb[IFLA_GROUP])
+		/* No dev found and NLM_F_CREATE not set. Requested dev does not exist,
+		 * or it's for a group
+		*/
+		if (link_specified)
+			return -ENODEV;
+		if (tb[IFLA_GROUP])
 			return rtnl_group_changelink(skb, net,
 						nla_get_u32(tb[IFLA_GROUP]),
 						ifm, extack, tb);
-- 
2.40.1



