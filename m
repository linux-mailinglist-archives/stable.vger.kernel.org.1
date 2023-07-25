Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE9976121E
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbjGYK7q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbjGYK7U (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:59:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2602698
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:56:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A53761648
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CA9C433C9;
        Tue, 25 Jul 2023 10:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282569;
        bh=Sjc9UxWydO+NkrZ0UswrUbP4BMHqTyw9lfy+arIzYr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k1SgUyMVd9Bf8m8aBLFXzB+k4fIoEFa8i6hkefT+BeWryf8SFWwkS3+4Bt3/ULrSq
         rhNVzG/WK43vevzGaR2shTaXOSPypB2H9SP1ziy3qvHPeb2GuNOAJCi4vA879GxD0Y
         4W637KOYld82QQj6bv+ZS07C8T0tsJzjFN1PCQB8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Petr Oros <poros@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH 6.4 159/227] ice: Unregister netdev and devlink_port only once
Date:   Tue, 25 Jul 2023 12:45:26 +0200
Message-ID: <20230725104521.515444823@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Petr Oros <poros@redhat.com>

[ Upstream commit 24a3298ac9e6bd8de838ab79f7868207170d556d ]

Since commit 6624e780a577fc ("ice: split ice_vsi_setup into smaller
functions") ice_vsi_release does things twice. There is unregister
netdev which is unregistered in ice_deinit_eth also.

It also unregisters the devlink_port twice which is also unregistered
in ice_deinit_eth(). This double deregistration is hidden because
devl_port_unregister ignores the return value of xa_erase.

[   68.642167] Call Trace:
[   68.650385]  ice_devlink_destroy_pf_port+0xe/0x20 [ice]
[   68.655656]  ice_vsi_release+0x445/0x690 [ice]
[   68.660147]  ice_deinit+0x99/0x280 [ice]
[   68.664117]  ice_remove+0x1b6/0x5c0 [ice]

[  171.103841] Call Trace:
[  171.109607]  ice_devlink_destroy_pf_port+0xf/0x20 [ice]
[  171.114841]  ice_remove+0x158/0x270 [ice]
[  171.118854]  pci_device_remove+0x3b/0xc0
[  171.122779]  device_release_driver_internal+0xc7/0x170
[  171.127912]  driver_detach+0x54/0x8c
[  171.131491]  bus_remove_driver+0x77/0xd1
[  171.135406]  pci_unregister_driver+0x2d/0xb0
[  171.139670]  ice_module_exit+0xc/0x55f [ice]

Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 27 ------------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 11ae0e41f518a..284a1f0bfdb54 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3272,39 +3272,12 @@ int ice_vsi_release(struct ice_vsi *vsi)
 		return -ENODEV;
 	pf = vsi->back;
 
-	/* do not unregister while driver is in the reset recovery pending
-	 * state. Since reset/rebuild happens through PF service task workqueue,
-	 * it's not a good idea to unregister netdev that is associated to the
-	 * PF that is running the work queue items currently. This is done to
-	 * avoid check_flush_dependency() warning on this wq
-	 */
-	if (vsi->netdev && !ice_is_reset_in_progress(pf->state) &&
-	    (test_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state))) {
-		unregister_netdev(vsi->netdev);
-		clear_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state);
-	}
-
-	if (vsi->type == ICE_VSI_PF)
-		ice_devlink_destroy_pf_port(pf);
-
 	if (test_bit(ICE_FLAG_RSS_ENA, pf->flags))
 		ice_rss_clean(vsi);
 
 	ice_vsi_close(vsi);
 	ice_vsi_decfg(vsi);
 
-	if (vsi->netdev) {
-		if (test_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state)) {
-			unregister_netdev(vsi->netdev);
-			clear_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state);
-		}
-		if (test_bit(ICE_VSI_NETDEV_ALLOCD, vsi->state)) {
-			free_netdev(vsi->netdev);
-			vsi->netdev = NULL;
-			clear_bit(ICE_VSI_NETDEV_ALLOCD, vsi->state);
-		}
-	}
-
 	/* retain SW VSI data structure since it is needed to unregister and
 	 * free VSI netdev when PF is not in reset recovery pending state,\
 	 * for ex: during rmmod.
-- 
2.39.2



