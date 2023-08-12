Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92FD77A1C5
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 20:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjHLSck (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 14:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjHLSck (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 14:32:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C580BE77
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 11:32:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4794361DD8
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 18:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C234C433C7;
        Sat, 12 Aug 2023 18:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691865161;
        bh=A/RJk7OHHf04NpmkpaOS0Rg1PQ7CnYYeIakIIWpT4Aw=;
        h=Subject:To:Cc:From:Date:From;
        b=gj6MHJUgRT2I0gvVI3yTpiFEr/yP/rtZonQQ49YD7+W3PzEQYhsJRWxsXVujc0R8Z
         T4ptE0LSBQjdhG7DZq+2HY+1wWztgrEwsyjemSgJX6qawVok12RxBj1bijE1H+4jwB
         vk8zsJFFikKIWbUPzkRBilfGRTV2DvupXuurZb+U=
Subject: FAILED: patch "[PATCH] net: dsa: ocelot: call dsa_tag_8021q_unregister() under" failed to apply to 5.15-stable tree
To:     vladimir.oltean@nxp.com, kuba@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 20:32:39 +0200
Message-ID: <2023081238-boasting-willing-c15b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a94c16a2fda010866b8858a386a8bfbeba4f72c5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081238-boasting-willing-c15b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

a94c16a2fda0 ("net: dsa: ocelot: call dsa_tag_8021q_unregister() under rtnl_lock() on driver remove")
7a29d220f4c0 ("net: dsa: felix: reimplement tagging protocol change with function pointers")
bacf93b05619 ("net: dsa: remove port argument from ->change_tag_protocol()")
72c3b0c7359a ("net: dsa: felix: manage host flooding using a specific driver callback")
28de0f9fec5a ("net: dsa: felix: perform MDB migration based on ocelot->multicast list")
a51c1c3f3218 ("net: dsa: felix: stop migrating FDBs back and forth on tag proto change")
2c110abc4616 ("net: dsa: felix: use PGID_CPU for FDB entry migration on NPI port")
7c762e70c50b ("net: dsa: flood multicast to CPU when slave has IFF_PROMISC")
00fa91bc9cc2 ("net: dsa: felix: fix tagging protocol changes with multiple CPU ports")
8e6598a7b0fa ("net: dsa: Pass VLAN MSTI migration notifications to driver")
332afc4c8c0d ("net: dsa: Validate hardware support for MST")
978777d0fb06 ("net: dsa: felix: configure default-prio and dscp priorities")
f2e2662ccf48 ("net: dsa: felix: actually disable flooding towards NPI port")
c69f40ac6006 ("net: dsa: felix: drop "bool change" from felix_set_tag_protocol")
59dc7b4f7f45 ("net: dsa: realtek: rtl8365mb: add support for rtl8_4t")
0cc369800e5f ("net: dsa: felix: stop clearing CPU flooding in felix_setup_tag_8021q")
90897569beb1 ("net: dsa: felix: start off with flooding disabled on the CPU port")
b903a6bd2e19 ("net: dsa: felix: migrate flood settings from NPI to tag_8021q CPU port")
f9cef64fa23f ("net: dsa: felix: migrate host FDB and MDB entries when changing tag proto")
7569459a52c9 ("net: dsa: manage flooding on the CPU ports")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a94c16a2fda010866b8858a386a8bfbeba4f72c5 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 3 Aug 2023 16:42:53 +0300
Subject: [PATCH] net: dsa: ocelot: call dsa_tag_8021q_unregister() under
 rtnl_lock() on driver remove

When the tagging protocol in current use is "ocelot-8021q" and we unbind
the driver, we see this splat:

$ echo '0000:00:00.2' > /sys/bus/pci/drivers/fsl_enetc/unbind
mscc_felix 0000:00:00.5 swp0: left promiscuous mode
sja1105 spi2.0: Link is Down
DSA: tree 1 torn down
mscc_felix 0000:00:00.5 swp2: left promiscuous mode
sja1105 spi2.2: Link is Down
DSA: tree 3 torn down
fsl_enetc 0000:00:00.2 eno2: left promiscuous mode
mscc_felix 0000:00:00.5: Link is Down
------------[ cut here ]------------
RTNL: assertion failed at net/dsa/tag_8021q.c (409)
WARNING: CPU: 1 PID: 329 at net/dsa/tag_8021q.c:409 dsa_tag_8021q_unregister+0x12c/0x1a0
Modules linked in:
CPU: 1 PID: 329 Comm: bash Not tainted 6.5.0-rc3+ #771
pc : dsa_tag_8021q_unregister+0x12c/0x1a0
lr : dsa_tag_8021q_unregister+0x12c/0x1a0
Call trace:
 dsa_tag_8021q_unregister+0x12c/0x1a0
 felix_tag_8021q_teardown+0x130/0x150
 felix_teardown+0x3c/0xd8
 dsa_tree_teardown_switches+0xbc/0xe0
 dsa_unregister_switch+0x168/0x260
 felix_pci_remove+0x30/0x60
 pci_device_remove+0x4c/0x100
 device_release_driver_internal+0x188/0x288
 device_links_unbind_consumers+0xfc/0x138
 device_release_driver_internal+0xe0/0x288
 device_driver_detach+0x24/0x38
 unbind_store+0xd8/0x108
 drv_attr_store+0x30/0x50
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
RTNL: assertion failed at net/8021q/vlan_core.c (376)
WARNING: CPU: 1 PID: 329 at net/8021q/vlan_core.c:376 vlan_vid_del+0x1b8/0x1f0
CPU: 1 PID: 329 Comm: bash Tainted: G        W          6.5.0-rc3+ #771
pc : vlan_vid_del+0x1b8/0x1f0
lr : vlan_vid_del+0x1b8/0x1f0
 dsa_tag_8021q_unregister+0x8c/0x1a0
 felix_tag_8021q_teardown+0x130/0x150
 felix_teardown+0x3c/0xd8
 dsa_tree_teardown_switches+0xbc/0xe0
 dsa_unregister_switch+0x168/0x260
 felix_pci_remove+0x30/0x60
 pci_device_remove+0x4c/0x100
 device_release_driver_internal+0x188/0x288
 device_links_unbind_consumers+0xfc/0x138
 device_release_driver_internal+0xe0/0x288
 device_driver_detach+0x24/0x38
 unbind_store+0xd8/0x108
 drv_attr_store+0x30/0x50
DSA: tree 0 torn down

This was somewhat not so easy to spot, because "ocelot-8021q" is not the
default tagging protocol, and thus, not everyone who tests the unbinding
path may have switched to it beforehand. The default
felix_tag_npi_teardown() does not require rtnl_lock() to be held.

Fixes: 7c83a7c539ab ("net: dsa: add a second tagger for Ocelot switches based on tag_8021q")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://lore.kernel.org/r/20230803134253.2711124-1-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 8da46d284e35..bef879c6d500 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -1625,8 +1625,10 @@ static void felix_teardown(struct dsa_switch *ds)
 	struct felix *felix = ocelot_to_felix(ocelot);
 	struct dsa_port *dp;
 
+	rtnl_lock();
 	if (felix->tag_proto_ops)
 		felix->tag_proto_ops->teardown(ds);
+	rtnl_unlock();
 
 	dsa_switch_for_each_available_port(dp, ds)
 		ocelot_deinit_port(ocelot, dp->index);

