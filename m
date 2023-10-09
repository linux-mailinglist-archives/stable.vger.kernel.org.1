Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0697BDF70
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376690AbjJINaG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377008AbjJINaG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:30:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3067B9C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:30:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7548CC433C9;
        Mon,  9 Oct 2023 13:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858204;
        bh=Bo1uPFywplij641puhC70npzL8o8r+2tsUeKFmK2PGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uC6s+KTHNKVnS3arQjVLrYP/dLYEAI8PAn6ajbTGvepaHSDeHjFROsvI2fvsi3r63
         TkvmOEEJEzcPbhrGCc/Rlg1yVVHv+0HUdU7FtMtjvHjlMzKPx6cXzdFjRaGPeRikGs
         0ZvQ2QFlpqGqo3uBC9eG1VQ02eANp2HeNE71HQ3g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ivan Vecera <ivecera@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Rafal Romanowski <rafal.romanowski@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 022/131] i40e: Fix VF VLAN offloading when port VLAN is configured
Date:   Mon,  9 Oct 2023 15:01:02 +0200
Message-ID: <20231009130116.990560061@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Vecera <ivecera@redhat.com>

[ Upstream commit d0d362ffa33da4acdcf7aee2116ceef8c8fef658 ]

If port VLAN is configured on a VF then any other VLANs on top of this VF
are broken.

During i40e_ndo_set_vf_port_vlan() call the i40e driver reset the VF and
iavf driver asks PF (using VIRTCHNL_OP_GET_VF_RESOURCES) for VF capabilities
but this reset occurs too early, prior setting of vf->info.pvid field
and because this field can be zero during i40e_vc_get_vf_resources_msg()
then VIRTCHNL_VF_OFFLOAD_VLAN capability is reported to iavf driver.

This is wrong because iavf driver should not report VLAN offloading
capability when port VLAN is configured as i40e does not support QinQ
offloading.

Fix the issue by moving VF reset after setting of vf->port_vlan_id
field.

Without this patch:
$ echo 1 > /sys/class/net/enp2s0f0/device/sriov_numvfs
$ ip link set enp2s0f0 vf 0 vlan 3
$ ip link set enp2s0f0v0 up
$ ip link add link enp2s0f0v0 name vlan4 type vlan id 4
$ ip link set vlan4 up
...
$ ethtool -k enp2s0f0v0 | grep vlan-offload
rx-vlan-offload: on
tx-vlan-offload: on
$ dmesg -l err | grep iavf
[1292500.742914] iavf 0000:02:02.0: Failed to add VLAN filter, error IAVF_ERR_INVALID_QP_ID

With this patch:
$ echo 1 > /sys/class/net/enp2s0f0/device/sriov_numvfs
$ ip link set enp2s0f0 vf 0 vlan 3
$ ip link set enp2s0f0v0 up
$ ip link add link enp2s0f0v0 name vlan4 type vlan id 4
$ ip link set vlan4 up
...
$ ethtool -k enp2s0f0v0 | grep vlan-offload
rx-vlan-offload: off [requested on]
tx-vlan-offload: off [requested on]
$ dmesg -l err | grep iavf

Fixes: f9b4b6278d51 ("i40e: Reset the VF upon conflicting VLAN configuration")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 7a52be82d05a2..1a3017e5f44c1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -4268,9 +4268,6 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev, int vf_id,
 		/* duplicate request, so just return success */
 		goto error_pvid;
 
-	i40e_vc_reset_vf(vf, true);
-	/* During reset the VF got a new VSI, so refresh a pointer. */
-	vsi = pf->vsi[vf->lan_vsi_idx];
 	/* Locked once because multiple functions below iterate list */
 	spin_lock_bh(&vsi->mac_filter_hash_lock);
 
@@ -4356,6 +4353,10 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev, int vf_id,
 	 */
 	vf->port_vlan_id = le16_to_cpu(vsi->info.pvid);
 
+	i40e_vc_reset_vf(vf, true);
+	/* During reset the VF got a new VSI, so refresh a pointer. */
+	vsi = pf->vsi[vf->lan_vsi_idx];
+
 	ret = i40e_config_vf_promiscuous_mode(vf, vsi->id, allmulti, alluni);
 	if (ret) {
 		dev_err(&pf->pdev->dev, "Unable to config vf promiscuous mode\n");
-- 
2.40.1



