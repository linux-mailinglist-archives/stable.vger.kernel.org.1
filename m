Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E47577AC43
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjHMVbG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbjHMVbG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:31:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F5D10DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:31:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2B2762B49
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B54C433C8;
        Sun, 13 Aug 2023 21:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962264;
        bh=8r1u8JCMglhmS+8CJpmUQgFY7i9RMqtpCcGFeQtAs/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sCScwg5VyzBOpda13vIYoz8M/qveYr91xuEjWsK8Ou8SpndeCaL/Dwl96RXNYHIhJ
         TlKMmPjZx5FGY6+7IhJSLIF0tHJdI21JhDSczMCNeCV1OCi+kQlY6iP18rV9SrKrTH
         R7VtppERkgy2I1gR+ZcA7GNfkfW2feTZUs+v77r4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.4 155/206] net: dsa: ocelot: call dsa_tag_8021q_unregister() under rtnl_lock() on driver remove
Date:   Sun, 13 Aug 2023 23:18:45 +0200
Message-ID: <20230813211729.467054107@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

commit a94c16a2fda010866b8858a386a8bfbeba4f72c5 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/ocelot/felix.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -1625,8 +1625,10 @@ static void felix_teardown(struct dsa_sw
 	struct felix *felix = ocelot_to_felix(ocelot);
 	struct dsa_port *dp;
 
+	rtnl_lock();
 	if (felix->tag_proto_ops)
 		felix->tag_proto_ops->teardown(ds);
+	rtnl_unlock();
 
 	dsa_switch_for_each_available_port(dp, ds)
 		ocelot_deinit_port(ocelot, dp->index);


