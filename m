Return-Path: <stable+bounces-21498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB9F85C92A
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA344B207E9
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AD4151CDC;
	Tue, 20 Feb 2024 21:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zyknLD1P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E574B14A4E6;
	Tue, 20 Feb 2024 21:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708464607; cv=none; b=QAO8qmnXsahJgir3SyBet8vw4kZ4t0OiD1bXw1N98e3m58uPIc3+ihOJffcxo2dY8LbtIkjRR7bP/VYaRjVSKht1muvW5S25fEXAudoRFpwdbUaN9dxtRfPLteBLxYl4KBj5j8tcYdEkUO7LCzyVDmdns6LeP1cSpX6np0tpFXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708464607; c=relaxed/simple;
	bh=TcOBekpbv7Hx10T/xgOj7TE2ESDwQfsiodjgVEGVG+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXnpaqoXmvSIv4icKXO6ttTKf4S819Keu75q0Lhn0U5hbfyBMbGrNHLAz0sSZVzGodNKGOrdXF6SvTswD4YQC2mHEob+P3oeq+CCLdMWVw44GL8zVozOMnNFjy5BN7U3tRHN6rY1Rwk8HR2tnTAN5ej17amcitSYV+suGQ2VYFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zyknLD1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A38C433C7;
	Tue, 20 Feb 2024 21:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708464606;
	bh=TcOBekpbv7Hx10T/xgOj7TE2ESDwQfsiodjgVEGVG+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zyknLD1P9UX6WuehhQ3msAiDujs1sZ9V2YVvyTLw/TR7dtwlmI4Z1cJ99TAv7vxGi
	 /AKr/M1I1QKU44aHW19874doSjEYrvjZgKtE1g9iNxqPRJXc20rNeLlQ3ZiR2NrBxY
	 H9HkTDL5zY44oQLh52hHOq51w4xAX+Ey8+zSxS28=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ivan Vecera <ivecera@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 061/309] i40e: Do not allow untrusted VF to remove administratively set MAC
Date: Tue, 20 Feb 2024 21:53:40 +0100
Message-ID: <20240220205635.132012442@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220205633.096363225@linuxfoundation.org>
References: <20240220205633.096363225@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Vecera <ivecera@redhat.com>

[ Upstream commit 73d9629e1c8c1982f13688c4d1019c3994647ccc ]

Currently when PF administratively sets VF's MAC address and the VF
is put down (VF tries to delete all MACs) then the MAC is removed
from MAC filters and primary VF MAC is zeroed.

Do not allow untrusted VF to remove primary MAC when it was set
administratively by PF.

Reproducer:
1) Create VF
2) Set VF interface up
3) Administratively set the VF's MAC
4) Put VF interface down

[root@host ~]# echo 1 > /sys/class/net/enp2s0f0/device/sriov_numvfs
[root@host ~]# ip link set enp2s0f0v0 up
[root@host ~]# ip link set enp2s0f0 vf 0 mac fe:6c:b5:da:c7:7d
[root@host ~]# ip link show enp2s0f0
23: enp2s0f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 3c:ec:ef:b7:dd:04 brd ff:ff:ff:ff:ff:ff
    vf 0     link/ether fe:6c:b5:da:c7:7d brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state auto, trust off
[root@host ~]# ip link set enp2s0f0v0 down
[root@host ~]# ip link show enp2s0f0
23: enp2s0f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 3c:ec:ef:b7:dd:04 brd ff:ff:ff:ff:ff:ff
    vf 0     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state auto, trust off

Fixes: 700bbf6c1f9e ("i40e: allow VF to remove any MAC filter")
Fixes: ceb29474bbbc ("i40e: Add support for VF to specify its primary MAC address")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Link: https://lore.kernel.org/r/20240208180335.1844996-1-anthony.l.nguyen@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 38 ++++++++++++++++---
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 7db89b294510..3d8a23d3352e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2850,6 +2850,24 @@ static int i40e_vc_get_stats_msg(struct i40e_vf *vf, u8 *msg)
 				      (u8 *)&stats, sizeof(stats));
 }
 
+/**
+ * i40e_can_vf_change_mac
+ * @vf: pointer to the VF info
+ *
+ * Return true if the VF is allowed to change its MAC filters, false otherwise
+ */
+static bool i40e_can_vf_change_mac(struct i40e_vf *vf)
+{
+	/* If the VF MAC address has been set administratively (via the
+	 * ndo_set_vf_mac command), then deny permission to the VF to
+	 * add/delete unicast MAC addresses, unless the VF is trusted
+	 */
+	if (vf->pf_set_mac && !vf->trusted)
+		return false;
+
+	return true;
+}
+
 #define I40E_MAX_MACVLAN_PER_HW 3072
 #define I40E_MAX_MACVLAN_PER_PF(num_ports) (I40E_MAX_MACVLAN_PER_HW /	\
 	(num_ports))
@@ -2909,8 +2927,8 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 		 * The VF may request to set the MAC address filter already
 		 * assigned to it so do not return an error in that case.
 		 */
-		if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps) &&
-		    !is_multicast_ether_addr(addr) && vf->pf_set_mac &&
+		if (!i40e_can_vf_change_mac(vf) &&
+		    !is_multicast_ether_addr(addr) &&
 		    !ether_addr_equal(addr, vf->default_lan_addr.addr)) {
 			dev_err(&pf->pdev->dev,
 				"VF attempting to override administratively set MAC address, bring down and up the VF interface to resume normal operation\n");
@@ -3116,19 +3134,29 @@ static int i40e_vc_del_mac_addr_msg(struct i40e_vf *vf, u8 *msg)
 			ret = -EINVAL;
 			goto error_param;
 		}
-		if (ether_addr_equal(al->list[i].addr, vf->default_lan_addr.addr))
-			was_unimac_deleted = true;
 	}
 	vsi = pf->vsi[vf->lan_vsi_idx];
 
 	spin_lock_bh(&vsi->mac_filter_hash_lock);
 	/* delete addresses from the list */
-	for (i = 0; i < al->num_elements; i++)
+	for (i = 0; i < al->num_elements; i++) {
+		const u8 *addr = al->list[i].addr;
+
+		/* Allow to delete VF primary MAC only if it was not set
+		 * administratively by PF or if VF is trusted.
+		 */
+		if (ether_addr_equal(addr, vf->default_lan_addr.addr) &&
+		    i40e_can_vf_change_mac(vf))
+			was_unimac_deleted = true;
+		else
+			continue;
+
 		if (i40e_del_mac_filter(vsi, al->list[i].addr)) {
 			ret = -EINVAL;
 			spin_unlock_bh(&vsi->mac_filter_hash_lock);
 			goto error_param;
 		}
+	}
 
 	spin_unlock_bh(&vsi->mac_filter_hash_lock);
 
-- 
2.43.0




