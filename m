Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1A779B7FD
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239518AbjIKWjU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240880AbjIKO4T (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:56:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED54DC
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:56:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32C2C433C7;
        Mon, 11 Sep 2023 14:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444175;
        bh=2mJeSsA24BRslvpdi2mToUVRmDy3E7jBf6HqIrLRRW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=be42FQT0gNvN2I8sJtGsOivJ8F0fLt9SL2p17eZ999PEjHDPyNbS3zMs18ewHHMwC
         RJjvvRIESF+gViwpduZfnzbMSv2Ye1CWFkv0iR2XQkFGsI9snntjmgOJUcMgAuHLTY
         IjSGe4SD4wAcdor2CzTp/vGyngBRpEeKvmI5RTmU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jozsef Kadlecsik <kadlec@netfilter.org>,
        Kyle Zeng <zengyhkyle@gmail.com>,
        Florian Westphal <fw@strlen.de>
Subject: [PATCH 6.4 636/737] netfilter: ipset: add the missing IP_SET_HASH_WITH_NET0 macro for ip_set_hash_netportnet.c
Date:   Mon, 11 Sep 2023 15:48:15 +0200
Message-ID: <20230911134708.297167920@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -36,6 +36,7 @@ MODULE_ALIAS("ip_set_hash:net,port,net")
 #define IP_SET_HASH_WITH_PROTO
 #define IP_SET_HASH_WITH_NETS
 #define IPSET_NET_COUNT 2
+#define IP_SET_HASH_WITH_NET0
 
 /* IPv4 variant */
 


