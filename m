Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA82E7A7E6B
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbjITMRv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbjITMRu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:17:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020C5D7
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:17:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5C7C433C9;
        Wed, 20 Sep 2023 12:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212252;
        bh=dZ1H0+wNliSGr4CH+OAuSlM+d/KocmCJHae/iDjxx78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n4Gn7SmG+HR9EKsxK8p3fQmA4sDJByDTvDDhJp1l5W8I+6nKT9xGCp9R9wdnM7iTd
         u1FaZKLEcokCxVmyPEgGOnYGe+Yj+mVoKlEW57looyWsJd+RAfkPJPkMURKFJcmyKd
         B1LQ9MPx+EUeYfssl7ZBlLxTEf6zqS7vuSU8ssb0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jozsef Kadlecsik <kadlec@netfilter.org>,
        Kyle Zeng <zengyhkyle@gmail.com>,
        Florian Westphal <fw@strlen.de>
Subject: [PATCH 4.19 166/273] netfilter: ipset: add the missing IP_SET_HASH_WITH_NET0 macro for ip_set_hash_netportnet.c
Date:   Wed, 20 Sep 2023 13:30:06 +0200
Message-ID: <20230920112851.654073432@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kyle Zeng <zengyhkyle@gmail.com>

commit 050d91c03b28ca479df13dfb02bcd2c60dd6a878 upstream.

The missing IP_SET_HASH_WITH_NET0 macro in ip_set_hash_netportnet can
lead to the use of wrong `CIDR_POS(c)` for calculating array offsets,
which can lead to integer underflow. As a result, it leads to slab
out-of-bound access.
This patch adds back the IP_SET_HASH_WITH_NET0 macro to
ip_set_hash_netportnet to address the issue.

Fixes: 886503f34d63 ("netfilter: ipset: actually allow allowable CIDR 0 in hash:net,port,net")
Suggested-by: Jozsef Kadlecsik <kadlec@netfilter.org>
Signed-off-by: Kyle Zeng <zengyhkyle@gmail.com>
Acked-by: Jozsef Kadlecsik <kadlec@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/ipset/ip_set_hash_netportnet.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/netfilter/ipset/ip_set_hash_netportnet.c
+++ b/net/netfilter/ipset/ip_set_hash_netportnet.c
@@ -39,6 +39,7 @@ MODULE_ALIAS("ip_set_hash:net,port,net")
 #define IP_SET_HASH_WITH_PROTO
 #define IP_SET_HASH_WITH_NETS
 #define IPSET_NET_COUNT 2
+#define IP_SET_HASH_WITH_NET0
 
 /* IPv4 variant */
 


