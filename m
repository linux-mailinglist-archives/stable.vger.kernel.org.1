Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B0D726B55
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjFGUYe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjFGUYR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:24:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841572719
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:23:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6389A60BB8
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76342C433D2;
        Wed,  7 Jun 2023 20:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169423;
        bh=bC9R4MfTU9FG5fZ+ZQP+ngeLWkTkxmiis72bO/CRo70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sTzF+JOQxlCquwgnLB3wvCiidykT/+gVkxH3Gwey+JRoK6oDqUSkZHMVdwHvg6nXz
         4CndCiYsbWBGjA9lsTGCx2jsjJ+BDR4M1wJeeTaQ1XqZz9de32XGI93eGedvpp+9ed
         Z2oDjlNIDxnalooJMM8IeEFDMFVzaxnPFRIUA9MM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xin Long <lucien.xin@gmail.com>,
        Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 076/286] rtnetlink: move IFLA_GSO_ tb check to validate_linkmsg
Date:   Wed,  7 Jun 2023 22:12:55 +0200
Message-ID: <20230607200925.562457146@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit fef5b228dd38378148bc850f7e69a7783f3b95a4 ]

These IFLA_GSO_* tb check should also be done for the new created link,
otherwise, they can be set to a huge value when creating links:

  # ip link add dummy1 gso_max_size 4294967295 type dummy
  # ip -d link show dummy1
    dummy addrgenmode eui64 ... gso_max_size 4294967295

Fixes: 46e6b992c250 ("rtnetlink: allow GSO maximums to be set on device creation")
Fixes: 9eefedd58ae1 ("net: add gso_ipv4_max_size and gro_ipv4_max_size per device")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/rtnetlink.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f37deb18dd02e..7094569009b14 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2382,6 +2382,25 @@ static int validate_linkmsg(struct net_device *dev, struct nlattr *tb[],
 		if (tb[IFLA_BROADCAST] &&
 		    nla_len(tb[IFLA_BROADCAST]) < dev->addr_len)
 			return -EINVAL;
+
+		if (tb[IFLA_GSO_MAX_SIZE] &&
+		    nla_get_u32(tb[IFLA_GSO_MAX_SIZE]) > dev->tso_max_size) {
+			NL_SET_ERR_MSG(extack, "too big gso_max_size");
+			return -EINVAL;
+		}
+
+		if (tb[IFLA_GSO_MAX_SEGS] &&
+		    (nla_get_u32(tb[IFLA_GSO_MAX_SEGS]) > GSO_MAX_SEGS ||
+		     nla_get_u32(tb[IFLA_GSO_MAX_SEGS]) > dev->tso_max_segs)) {
+			NL_SET_ERR_MSG(extack, "too big gso_max_segs");
+			return -EINVAL;
+		}
+
+		if (tb[IFLA_GSO_IPV4_MAX_SIZE] &&
+		    nla_get_u32(tb[IFLA_GSO_IPV4_MAX_SIZE]) > dev->tso_max_size) {
+			NL_SET_ERR_MSG(extack, "too big gso_ipv4_max_size");
+			return -EINVAL;
+		}
 	}
 
 	if (tb[IFLA_AF_SPEC]) {
@@ -2855,11 +2874,6 @@ static int do_setlink(const struct sk_buff *skb,
 	if (tb[IFLA_GSO_MAX_SIZE]) {
 		u32 max_size = nla_get_u32(tb[IFLA_GSO_MAX_SIZE]);
 
-		if (max_size > dev->tso_max_size) {
-			err = -EINVAL;
-			goto errout;
-		}
-
 		if (dev->gso_max_size ^ max_size) {
 			netif_set_gso_max_size(dev, max_size);
 			status |= DO_SETLINK_MODIFIED;
@@ -2869,11 +2883,6 @@ static int do_setlink(const struct sk_buff *skb,
 	if (tb[IFLA_GSO_MAX_SEGS]) {
 		u32 max_segs = nla_get_u32(tb[IFLA_GSO_MAX_SEGS]);
 
-		if (max_segs > GSO_MAX_SEGS || max_segs > dev->tso_max_segs) {
-			err = -EINVAL;
-			goto errout;
-		}
-
 		if (dev->gso_max_segs ^ max_segs) {
 			netif_set_gso_max_segs(dev, max_segs);
 			status |= DO_SETLINK_MODIFIED;
@@ -2892,11 +2901,6 @@ static int do_setlink(const struct sk_buff *skb,
 	if (tb[IFLA_GSO_IPV4_MAX_SIZE]) {
 		u32 max_size = nla_get_u32(tb[IFLA_GSO_IPV4_MAX_SIZE]);
 
-		if (max_size > dev->tso_max_size) {
-			err = -EINVAL;
-			goto errout;
-		}
-
 		if (dev->gso_ipv4_max_size ^ max_size) {
 			netif_set_gso_ipv4_max_size(dev, max_size);
 			status |= DO_SETLINK_MODIFIED;
-- 
2.39.2



