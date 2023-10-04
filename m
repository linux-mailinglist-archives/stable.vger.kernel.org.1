Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7999D7B89A7
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244236AbjJDS1y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244235AbjJDS1x (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:27:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13DCC9
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:27:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CF5C433C8;
        Wed,  4 Oct 2023 18:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444069;
        bh=pQbqH82IjrttBA3sShwG3Xe3kto8wf/YX5WFiuV2Wmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=teObhdmwfcqOW4SB/55sZwRvbDmACHn508GjmPXJCuX1B3S005dlZVcVPcCgGNEPJ
         iImVYfuUEnQwzad+YVyyjicKLLQghZNFBPcaYVzeoOhFop3yN+oKx6zZC1d+w0cwt2
         nOCsk6HiOGoxMhklDCfE4J9C068L1mTFEPpwV/Jc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benjamin Poirier <bpoirier@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Ido Schimmel <idosch@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 091/321] vxlan: Add missing entries to vxlan_get_size()
Date:   Wed,  4 Oct 2023 19:53:56 +0200
Message-ID: <20231004175233.427111651@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Poirier <bpoirier@nvidia.com>

[ Upstream commit 4e4b1798cc90e376b8b61d0098b4093898a32227 ]

There are some attributes added by vxlan_fill_info() which are not
accounted for in vxlan_get_size(). Add them.

I didn't find a way to trigger an actual problem from this miscalculation
since there is usually extra space in netlink size calculations like
if_nlmsg_size(); but maybe I just didn't search long enough.

Fixes: 3511494ce2f3 ("vxlan: Group Policy extension")
Fixes: e1e5314de08b ("vxlan: implement GPE")
Fixes: 0ace2ca89cbd ("vxlan: Use checksum partial with remote checksum offload")
Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vxlan/vxlan_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index c9a9373733c01..4b2db14472e6c 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4296,6 +4296,10 @@ static size_t vxlan_get_size(const struct net_device *dev)
 		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_REMCSUM_TX */
 		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_REMCSUM_RX */
 		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_LOCALBYPASS */
+		nla_total_size(0) + /* IFLA_VXLAN_GBP */
+		nla_total_size(0) + /* IFLA_VXLAN_GPE */
+		nla_total_size(0) + /* IFLA_VXLAN_REMCSUM_NOPARTIAL */
+		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_VNIFILTER */
 		0;
 }
 
-- 
2.40.1



