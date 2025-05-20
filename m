Return-Path: <stable+bounces-145147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83E2ABDA5C
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8F5F7B15D7
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DAB2459D6;
	Tue, 20 May 2025 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OLj/1v+w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C9E22D78C;
	Tue, 20 May 2025 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749304; cv=none; b=GmLfZbs+saqBfv5UKPIsl0520akoOWHI+Ayxrg73rqor0Vmmu9TCFkrZDdfnSspAryd2cb1DyocxBfODeC5PdHQiR6EAD/4PQtWXNF0AEh4upE4tDyNzot8tyKOUVjcRnXxQ4+AoUKtqpmmafBlgO4KR4zaqPjx+85yYK+n927k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749304; c=relaxed/simple;
	bh=of278VsLck/QbSLb9tGNPd2RkCI6hlh5OMNimWaMRTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmYuOdRLVEDWhpiH8oBTEY0SNm/MiPTBOm+qw1+k1IVHs/geYnlCQnGB25BxIJpbbkm6U5dnRtZwCu8g2OhPjvtzSOxs9caoh9zluXLPD7AilVGJgRsHkpCJ1pHC9Ga+gA5r6XQjcihPFVY6RbFjAD+nuQgZjXy+lVhjq2W7pG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OLj/1v+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE77C4CEEA;
	Tue, 20 May 2025 13:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747749303;
	bh=of278VsLck/QbSLb9tGNPd2RkCI6hlh5OMNimWaMRTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OLj/1v+wffwLKq33x6niJCd0XE5MVGRecAunOVRtD1rfeHDdiIZJoiD+e/ZXxLoo9
	 IbIEAZwaJzkoNigxLtlznLDOvMIuvzm8bk7zt8P3v+UqOi3Q5xowfN9SRUcb7MSqTF
	 +e3cNzBbH6MGskvU/HaxjjluDhLrj2xaCKTuQnXc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ivan Vecera <ivecera@redhat.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Suraj Jitindar Singh <surajjs@amazon.com>
Subject: [PATCH 5.15 59/59] ice: arfs: fix use-after-free when freeing @rx_cpu_rmap
Date: Tue, 20 May 2025 15:50:50 +0200
Message-ID: <20250520125756.181916930@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125753.836407405@linuxfoundation.org>
References: <20250520125753.836407405@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Lobakin <alexandr.lobakin@intel.com>

commit d7442f512b71fc63a99c8a801422dde4fbbf9f93 upstream.

The CI testing bots triggered the following splat:

[  718.203054] BUG: KASAN: use-after-free in free_irq_cpu_rmap+0x53/0x80
[  718.206349] Read of size 4 at addr ffff8881bd127e00 by task sh/20834
[  718.212852] CPU: 28 PID: 20834 Comm: sh Kdump: loaded Tainted: G S      W IOE     5.17.0-rc8_nextqueue-devqueue-02643-g23f3121aca93 #1
[  718.219695] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0012.070720200218 07/07/2020
[  718.223418] Call Trace:
[  718.227139]
[  718.230783]  dump_stack_lvl+0x33/0x42
[  718.234431]  print_address_description.constprop.9+0x21/0x170
[  718.238177]  ? free_irq_cpu_rmap+0x53/0x80
[  718.241885]  ? free_irq_cpu_rmap+0x53/0x80
[  718.245539]  kasan_report.cold.18+0x7f/0x11b
[  718.249197]  ? free_irq_cpu_rmap+0x53/0x80
[  718.252852]  free_irq_cpu_rmap+0x53/0x80
[  718.256471]  ice_free_cpu_rx_rmap.part.11+0x37/0x50 [ice]
[  718.260174]  ice_remove_arfs+0x5f/0x70 [ice]
[  718.263810]  ice_rebuild_arfs+0x3b/0x70 [ice]
[  718.267419]  ice_rebuild+0x39c/0xb60 [ice]
[  718.270974]  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
[  718.274472]  ? ice_init_phy_user_cfg+0x360/0x360 [ice]
[  718.278033]  ? delay_tsc+0x4a/0xb0
[  718.281513]  ? preempt_count_sub+0x14/0xc0
[  718.284984]  ? delay_tsc+0x8f/0xb0
[  718.288463]  ice_do_reset+0x92/0xf0 [ice]
[  718.292014]  ice_pci_err_resume+0x91/0xf0 [ice]
[  718.295561]  pci_reset_function+0x53/0x80
<...>
[  718.393035] Allocated by task 690:
[  718.433497] Freed by task 20834:
[  718.495688] Last potentially related work creation:
[  718.568966] The buggy address belongs to the object at ffff8881bd127e00
                which belongs to the cache kmalloc-96 of size 96
[  718.574085] The buggy address is located 0 bytes inside of
                96-byte region [ffff8881bd127e00, ffff8881bd127e60)
[  718.579265] The buggy address belongs to the page:
[  718.598905] Memory state around the buggy address:
[  718.601809]  ffff8881bd127d00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[  718.604796]  ffff8881bd127d80: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
[  718.607794] >ffff8881bd127e00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
[  718.610811]                    ^
[  718.613819]  ffff8881bd127e80: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
[  718.617107]  ffff8881bd127f00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc

This is due to that free_irq_cpu_rmap() is always being called
*after* (devm_)free_irq() and thus it tries to work with IRQ descs
already freed. For example, on device reset the driver frees the
rmap right before allocating a new one (the splat above).
Make rmap creation and freeing function symmetrical with
{request,free}_irq() calls i.e. do that on ifup/ifdown instead
of device probe/remove/resume. These operations can be performed
independently from the actual device aRFS configuration.
Also, make sure ice_vsi_free_irq() clears IRQ affinity notifiers
only when aRFS is disabled -- otherwise, CPU rmap sets and clears
its own and they must not be touched manually.

Fixes: 28bf26724fdb0 ("ice: Implement aRFS")
Co-developed-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Tested-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ice/ice_arfs.c |    9 ++-------
 drivers/net/ethernet/intel/ice/ice_lib.c  |    5 ++++-
 drivers/net/ethernet/intel/ice/ice_main.c |   20 ++++++++------------
 3 files changed, 14 insertions(+), 20 deletions(-)

--- a/drivers/net/ethernet/intel/ice/ice_arfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_arfs.c
@@ -577,7 +577,7 @@ void ice_free_cpu_rx_rmap(struct ice_vsi
 {
 	struct net_device *netdev;
 
-	if (!vsi || vsi->type != ICE_VSI_PF || !vsi->arfs_fltr_list)
+	if (!vsi || vsi->type != ICE_VSI_PF)
 		return;
 
 	netdev = vsi->netdev;
@@ -599,7 +599,7 @@ int ice_set_cpu_rx_rmap(struct ice_vsi *
 	int base_idx, i;
 
 	if (!vsi || vsi->type != ICE_VSI_PF)
-		return -EINVAL;
+		return 0;
 
 	pf = vsi->back;
 	netdev = vsi->netdev;
@@ -636,7 +636,6 @@ void ice_remove_arfs(struct ice_pf *pf)
 	if (!pf_vsi)
 		return;
 
-	ice_free_cpu_rx_rmap(pf_vsi);
 	ice_clear_arfs(pf_vsi);
 }
 
@@ -653,9 +652,5 @@ void ice_rebuild_arfs(struct ice_pf *pf)
 		return;
 
 	ice_remove_arfs(pf);
-	if (ice_set_cpu_rx_rmap(pf_vsi)) {
-		dev_err(ice_pf_to_dev(pf), "Failed to rebuild aRFS\n");
-		return;
-	}
 	ice_init_arfs(pf_vsi);
 }
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2645,6 +2645,8 @@ void ice_vsi_free_irq(struct ice_vsi *vs
 		return;
 
 	vsi->irqs_ready = false;
+	ice_free_cpu_rx_rmap(vsi);
+
 	ice_for_each_q_vector(vsi, i) {
 		u16 vector = i + base;
 		int irq_num;
@@ -2658,7 +2660,8 @@ void ice_vsi_free_irq(struct ice_vsi *vs
 			continue;
 
 		/* clear the affinity notifier in the IRQ descriptor */
-		irq_set_affinity_notifier(irq_num, NULL);
+		if (!IS_ENABLED(CONFIG_RFS_ACCEL))
+			irq_set_affinity_notifier(irq_num, NULL);
 
 		/* clear the affinity_mask in the IRQ descriptor */
 		irq_set_affinity_hint(irq_num, NULL);
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2393,6 +2393,13 @@ static int ice_vsi_req_irq_msix(struct i
 		irq_set_affinity_hint(irq_num, &q_vector->affinity_mask);
 	}
 
+	err = ice_set_cpu_rx_rmap(vsi);
+	if (err) {
+		netdev_err(vsi->netdev, "Failed to setup CPU RMAP on VSI %u: %pe\n",
+			   vsi->vsi_num, ERR_PTR(err));
+		goto free_q_irqs;
+	}
+
 	vsi->irqs_ready = true;
 	return 0;
 
@@ -3380,22 +3387,12 @@ static int ice_setup_pf_sw(struct ice_pf
 	 */
 	ice_napi_add(vsi);
 
-	status = ice_set_cpu_rx_rmap(vsi);
-	if (status) {
-		dev_err(ice_pf_to_dev(pf), "Failed to set CPU Rx map VSI %d error %d\n",
-			vsi->vsi_num, status);
-		status = -EINVAL;
-		goto unroll_napi_add;
-	}
 	status = ice_init_mac_fltr(pf);
 	if (status)
-		goto free_cpu_rx_map;
+		goto unroll_napi_add;
 
 	return status;
 
-free_cpu_rx_map:
-	ice_free_cpu_rx_rmap(vsi);
-
 unroll_napi_add:
 	if (vsi) {
 		ice_napi_del(vsi);
@@ -4886,7 +4883,6 @@ static int __maybe_unused ice_suspend(st
 			continue;
 		ice_vsi_free_q_vectors(pf->vsi[v]);
 	}
-	ice_free_cpu_rx_rmap(ice_get_main_vsi(pf));
 	ice_clear_interrupt_scheme(pf);
 
 	pci_save_state(pdev);



