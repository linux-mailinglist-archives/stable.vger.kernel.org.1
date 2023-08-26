Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAD07898FE
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 22:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjHZUXc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 16:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjHZUXA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 16:23:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A385102
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 13:22:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93F4C60C7D
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 20:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2359C433C8;
        Sat, 26 Aug 2023 20:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693081377;
        bh=731xHbB8SKHJWwoZOFDZs/qmxx7hzp1759BTKBDwqqQ=;
        h=Subject:To:Cc:From:Date:From;
        b=i/RBZ3eAmm0dFP8DkiRhRb9QxYyinRcoqTS/QMaXdV3syCCOaRxAyvjqwyuinckNg
         W+PerjceCXJL0ZIdWAr5swaem+1v0RyEXD/dybJLoEt7a3xtrlTVR2rF45KySuXSAO
         ad0qOfFPVIXO24pKVCCyuxPXf0yOnonbwDFIw3vc=
Subject: FAILED: patch "[PATCH] batman-adv: Hold rtnl lock during MTU update via netlink" failed to apply to 4.14-stable tree
To:     sven@narfation.org, horms@kernel.org, kuba@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 26 Aug 2023 22:22:46 +0200
Message-ID: <2023082645-unicycle-diaphragm-272c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 987aae75fc1041072941ffb622b45ce2359a99b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082645-unicycle-diaphragm-272c@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

987aae75fc10 ("batman-adv: Hold rtnl lock during MTU update via netlink")
3e15b06eb7e4 ("batman-adv: Add fragmentation mesh genl configuration")
a1c8de803296 ("batman-adv: Add distributed_arp_table mesh genl configuration")
43ff6105a527 ("batman-adv: Add bridge_loop_avoidance mesh genl configuration")
d7e52506b680 ("batman-adv: Add bonding mesh genl configuration")
e43d16b87dc2 ("batman-adv: Add ap_isolation mesh/vlan genl configuration")
9ab4cee5ced9 ("batman-adv: Add aggregated_ogms mesh genl configuration")
49e7e37cd981 ("batman-adv: Prepare framework for vlan genl config")
5c55a40fa801 ("batman-adv: Prepare framework for hardif genl config")
600405135360 ("batman-adv: Prepare framework for mesh genl config")
c4a7a8d9bb8f ("batman-adv: Move common genl doit code pre/post hooks")
fb69be697916 ("batman-adv: Add inconsistent hardif netlink dump detection")
53dd9a68ba68 ("batman-adv: add multicast flags netlink support")
41aeefcc38a2 ("batman-adv: add DAT cache netlink support")
fec149f5d323 ("batman-adv: Convert packet.h to uapi header")
7e9a8c2ce7c5 ("batman-adv: Use parentheses in function kernel-doc")
7db7d9f369a4 ("batman-adv: Add SPDX license identifier above copyright header")
40b16b9be577 ("batman-adv: use inline kernel-doc for uapi constants")
706cc9f51d9a ("batman-adv: Add argument names for function ptr definitions")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 987aae75fc1041072941ffb622b45ce2359a99b9 Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 21 Aug 2023 21:48:48 +0200
Subject: [PATCH] batman-adv: Hold rtnl lock during MTU update via netlink

The automatic recalculation of the maximum allowed MTU is usually triggered
by code sections which are already rtnl lock protected by callers outside
of batman-adv. But when the fragmentation setting is changed via
batman-adv's own batadv genl family, then the rtnl lock is not yet taken.

But dev_set_mtu requires that the caller holds the rtnl lock because it
uses netdevice notifiers. And this code will then fail the check for this
lock:

  RTNL: assertion failed at net/core/dev.c (1953)

Cc: stable@vger.kernel.org
Reported-by: syzbot+f8812454d9b3ac00d282@syzkaller.appspotmail.com
Fixes: c6a953cce8d0 ("batman-adv: Trigger events for auto adjusted MTU")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20230821-batadv-missing-mtu-rtnl-lock-v1-1-1c5a7bfe861e@narfation.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index ad5714f737be..6efbc9275aec 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -495,7 +495,10 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 		attr = info->attrs[BATADV_ATTR_FRAGMENTATION_ENABLED];
 
 		atomic_set(&bat_priv->fragmentation, !!nla_get_u8(attr));
+
+		rtnl_lock();
 		batadv_update_min_mtu(bat_priv->soft_iface);
+		rtnl_unlock();
 	}
 
 	if (info->attrs[BATADV_ATTR_GW_BANDWIDTH_DOWN]) {

