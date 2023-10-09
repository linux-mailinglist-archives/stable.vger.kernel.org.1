Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843887BDDF3
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376706AbjJINOW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376852AbjJINOU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:14:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8919C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:14:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93674C433CB;
        Mon,  9 Oct 2023 13:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857258;
        bh=nI2UCzpP/AY49womTC0APNsD4vY9oKKJB9Y+nZUZNzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y7TT2EFBtBpMXZc82JnTVCeJepFHiP3JHQzYYvwso96ogGHHaMcRJWffopT3hI4J7
         DzUU11ONguAShn3w94+p7vmSI0fgyI5eFXzlbW5bobzsWll7VjwAjEv/YdUsKB7/0K
         NY0WP7SGtydZ4elpegYY6tPasKOB2z8iprm1XzhA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benjamin Poirier <bpoirier@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Simon Horman <horms@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 123/163] ipv4: Set offload_failed flag in fibmatch results
Date:   Mon,  9 Oct 2023 15:01:27 +0200
Message-ID: <20231009130127.433965781@linuxfoundation.org>
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

From: Benjamin Poirier <bpoirier@nvidia.com>

[ Upstream commit 0add5c597f3253a9c6108a0a81d57f44ab0d9d30 ]

Due to a small omission, the offload_failed flag is missing from ipv4
fibmatch results. Make sure it is set correctly.

The issue can be witnessed using the following commands:
echo "1 1" > /sys/bus/netdevsim/new_device
ip link add dummy1 up type dummy
ip route add 192.0.2.0/24 dev dummy1
echo 1 > /sys/kernel/debug/netdevsim/netdevsim1/fib/fail_route_offload
ip route add 198.51.100.0/24 dev dummy1
ip route
	# 192.168.15.0/24 has rt_trap
	# 198.51.100.0/24 has rt_offload_failed
ip route get 192.168.15.1 fibmatch
	# Result has rt_trap
ip route get 198.51.100.1 fibmatch
	# Result differs from the route shown by `ip route`, it is missing
	# rt_offload_failed
ip link del dev dummy1
echo 1 > /sys/bus/netdevsim/del_device

Fixes: 36c5100e859d ("IPv4: Add "offload failed" indication to routes")
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/20230926182730.231208-1-bpoirier@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/route.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 0a53ca6ebb0d5..14fbc5cd157ef 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3417,6 +3417,8 @@ static int inet_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 				    fa->fa_type == fri.type) {
 					fri.offload = READ_ONCE(fa->offload);
 					fri.trap = READ_ONCE(fa->trap);
+					fri.offload_failed =
+						READ_ONCE(fa->offload_failed);
 					break;
 				}
 			}
-- 
2.40.1



