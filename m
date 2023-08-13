Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D338C77AD13
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjHMVsC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjHMVrj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:47:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB892D54
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:47:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 339DA61468
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2B5C433C8;
        Sun, 13 Aug 2023 21:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691963257;
        bh=IgRO3AVv1LzVnBQitVySX9JsP581lrTof0+biHCgK2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pU7bs+e6Ml+AyosOwWRU6NYw5TO1s/gcBfeUmCBtItbXOtijPDtU8FCyvUp+wD4gj
         zu8zeWQYVd1eJp4tcXEBqu4Gfr4vCwbB6c1uz6iDhY1/gYUXO4t++ervEbGP/YrWgW
         4KIsFr+lMR0QElFXgXzNTmzaSNZ/yijoV/FqMrIY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ido Schimmel <idosch@idosch.org>,
        Ziyang Xuan <william.xuanziyang@huawei.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.4 20/39] bonding: Fix incorrect deletion of ETH_P_8021AD protocol vid from slaves
Date:   Sun, 13 Aug 2023 23:20:11 +0200
Message-ID: <20230813211705.522245328@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211704.796906808@linuxfoundation.org>
References: <20230813211704.796906808@linuxfoundation.org>
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

From: Ziyang Xuan <william.xuanziyang@huawei.com>

commit 01f4fd27087078c90a0e22860d1dfa2cd0510791 upstream.

BUG_ON(!vlan_info) is triggered in unregister_vlan_dev() with
following testcase:

  # ip netns add ns1
  # ip netns exec ns1 ip link add bond0 type bond mode 0
  # ip netns exec ns1 ip link add bond_slave_1 type veth peer veth2
  # ip netns exec ns1 ip link set bond_slave_1 master bond0
  # ip netns exec ns1 ip link add link bond_slave_1 name vlan10 type vlan id 10 protocol 802.1ad
  # ip netns exec ns1 ip link add link bond0 name bond0_vlan10 type vlan id 10 protocol 802.1ad
  # ip netns exec ns1 ip link set bond_slave_1 nomaster
  # ip netns del ns1

The logical analysis of the problem is as follows:

1. create ETH_P_8021AD protocol vlan10 for bond_slave_1:
register_vlan_dev()
  vlan_vid_add()
    vlan_info_alloc()
    __vlan_vid_add() // add [ETH_P_8021AD, 10] vid to bond_slave_1

2. create ETH_P_8021AD protocol bond0_vlan10 for bond0:
register_vlan_dev()
  vlan_vid_add()
    __vlan_vid_add()
      vlan_add_rx_filter_info()
          if (!vlan_hw_filter_capable(dev, proto)) // condition established because bond0 without NETIF_F_HW_VLAN_STAG_FILTER
              return 0;

          if (netif_device_present(dev))
              return dev->netdev_ops->ndo_vlan_rx_add_vid(dev, proto, vid); // will be never called
              // The slaves of bond0 will not refer to the [ETH_P_8021AD, 10] vid.

3. detach bond_slave_1 from bond0:
__bond_release_one()
  vlan_vids_del_by_dev()
    list_for_each_entry(vid_info, &vlan_info->vid_list, list)
        vlan_vid_del(dev, vid_info->proto, vid_info->vid);
        // bond_slave_1 [ETH_P_8021AD, 10] vid will be deleted.
        // bond_slave_1->vlan_info will be assigned NULL.

4. delete vlan10 during delete ns1:
default_device_exit_batch()
  dev->rtnl_link_ops->dellink() // unregister_vlan_dev() for vlan10
    vlan_info = rtnl_dereference(real_dev->vlan_info); // real_dev of vlan10 is bond_slave_1
	BUG_ON(!vlan_info); // bond_slave_1->vlan_info is NULL now, bug is triggered!!!

Add S-VLAN tag related features support to bond driver. So the bond driver
will always propagate the VLAN info to its slaves.

Fixes: 8ad227ff89a7 ("net: vlan: add 802.1ad support")
Suggested-by: Ido Schimmel <idosch@idosch.org>
Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://lore.kernel.org/r/20230802114320.4156068-1-william.xuanziyang@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4451,7 +4451,9 @@ void bond_setup(struct net_device *bond_
 
 	bond_dev->hw_features = BOND_VLAN_FEATURES |
 				NETIF_F_HW_VLAN_CTAG_RX |
-				NETIF_F_HW_VLAN_CTAG_FILTER;
+				NETIF_F_HW_VLAN_CTAG_FILTER |
+				NETIF_F_HW_VLAN_STAG_RX |
+				NETIF_F_HW_VLAN_STAG_FILTER;
 
 	bond_dev->hw_features |= NETIF_F_GSO_ENCAP_ALL | NETIF_F_GSO_UDP_L4;
 	bond_dev->features |= bond_dev->hw_features;


