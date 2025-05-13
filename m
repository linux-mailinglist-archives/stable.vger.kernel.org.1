Return-Path: <stable+bounces-144274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F481AB5FDB
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 01:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125641B4480E
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 23:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD96B20C472;
	Tue, 13 May 2025 23:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="F5omOgEg"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5B61A3BD8
	for <stable@vger.kernel.org>; Tue, 13 May 2025 23:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747178592; cv=none; b=PECu9OZElITmyZOLPMypf6TY3sLLx6SUQeQm5VLOc2RWCtlk4YP2u6nG8VfSmeh/9998yM7RiCvJClh7hzV9LOQxJDhS2hwUphNOB5I13xgRPYXkuaqoU4Tkd6JJ9ESMH5r9kXdvjDplTqUd7rCpzJ2gidU9UqjZrrqcAZYkTQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747178592; c=relaxed/simple;
	bh=H4kauTX7cSTC+Kt7yhb7tPt/lgdjKxMwnSz3aE+V3Uk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b1vWd12syqyvIV4SbL+wdmUX6ZHYgIAA2ahwA3cCdUT9EUEfJNmF3W9xCl9/6uFwqGU6ywqlWam7eZEAWL2yZNjfghov2NCNvnFS8xOAqeczFkWaehIVTs7gN7NWf3y34vay01Dq9lL3KfjVxlZ0J70sEDOWfn36npfyiQ1HUbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=F5omOgEg; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747178591; x=1778714591;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DAyvtdGUjYMnXTXN1ToRJXaHVz1p4DUG6CtNw07SBVk=;
  b=F5omOgEgXtD9AKQaY5y2thJSo1rmgH6j26ffidly9T5HF1CqKaxQpmMa
   8zsYHE1vmM2ls4xyZoLjKu697d3mvPxEenjhE6lqpdpl1DSY17ZIkzbJd
   MYahRyKG7E+cXf0jhyhIetmwFn5uXwlM83VaOWmz4yDlSHFYKkm2VAxvM
   HVRM88Wphl5tsgwU1g8MDYuMMJ3rSeWnIng5nWdfQp6Ac8AkyNYJAUNja
   qIVYq5LhNAtEeEZe8OUg0Af5ashMP8W88NaQWqXuaOCBSn4eeTm1TrqHL
   9v8qOC3iGDBwSp39TQoovBy8il6Q5hRVSIPHsXLnwX+gUs0ZmhZ6mGrze
   w==;
X-IronPort-AV: E=Sophos;i="6.15,286,1739836800"; 
   d="scan'208";a="196596189"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 23:23:09 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:41322]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.166:2525] with esmtp (Farcaster)
 id c5584d03-636b-46a1-90b5-ddfebec4aa2e; Tue, 13 May 2025 23:23:09 +0000 (UTC)
X-Farcaster-Flow-ID: c5584d03-636b-46a1-90b5-ddfebec4aa2e
Received: from EX19D015UWC003.ant.amazon.com (10.13.138.179) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 13 May 2025 23:23:09 +0000
Received: from u1e958862c3245e.ant.amazon.com (10.187.170.35) by
 EX19D015UWC003.ant.amazon.com (10.13.138.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 13 May 2025 23:23:08 +0000
From: Suraj Jitindar Singh <surajjs@amazon.com>
To: <stable@vger.kernel.org>
CC: Alexander Lobakin <alexandr.lobakin@intel.com>, Ivan Vecera
	<ivecera@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Suraj
 Jitindar Singh" <surajjs@amazon.com>
Subject: [STABLE 5.10 5.15] ice: arfs: fix use-after-free when freeing @rx_cpu_rmap
Date: Tue, 13 May 2025 16:22:47 -0700
Message-ID: <20250513232247.219394-1-surajjs@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D015UWC003.ant.amazon.com (10.13.138.179)

From: Alexander Lobakin <alexandr.lobakin@intel.com>

[ Upstream commit d7442f512b71fc63a99c8a801422dde4fbbf9f93 ]

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
Cc: <stable@vger.kernel.org> # 5.10.x
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
---
 drivers/net/ethernet/intel/ice/ice_arfs.c |  9 ++-------
 drivers/net/ethernet/intel/ice/ice_lib.c  |  5 ++++-
 drivers/net/ethernet/intel/ice/ice_main.c | 20 ++++++++------------
 3 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_arfs.c b/drivers/net/ethernet/intel/ice/ice_arfs.c
index 632f16ffee40..085b1a0d67c5 100644
--- a/drivers/net/ethernet/intel/ice/ice_arfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_arfs.c
@@ -577,7 +577,7 @@ void ice_free_cpu_rx_rmap(struct ice_vsi *vsi)
 {
 	struct net_device *netdev;
 
-	if (!vsi || vsi->type != ICE_VSI_PF || !vsi->arfs_fltr_list)
+	if (!vsi || vsi->type != ICE_VSI_PF)
 		return;
 
 	netdev = vsi->netdev;
@@ -600,7 +600,7 @@ int ice_set_cpu_rx_rmap(struct ice_vsi *vsi)
 	int base_idx, i;
 
 	if (!vsi || vsi->type != ICE_VSI_PF)
-		return -EINVAL;
+		return 0;
 
 	pf = vsi->back;
 	netdev = vsi->netdev;
@@ -638,7 +638,6 @@ void ice_remove_arfs(struct ice_pf *pf)
 	if (!pf_vsi)
 		return;
 
-	ice_free_cpu_rx_rmap(pf_vsi);
 	ice_clear_arfs(pf_vsi);
 }
 
@@ -655,9 +654,5 @@ void ice_rebuild_arfs(struct ice_pf *pf)
 		return;
 
 	ice_remove_arfs(pf);
-	if (ice_set_cpu_rx_rmap(pf_vsi)) {
-		dev_err(ice_pf_to_dev(pf), "Failed to rebuild aRFS\n");
-		return;
-	}
 	ice_init_arfs(pf_vsi);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index e99c8c10bc61..d3e5bf180c37 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2411,6 +2411,8 @@ void ice_vsi_free_irq(struct ice_vsi *vsi)
 		return;
 
 	vsi->irqs_ready = false;
+	ice_free_cpu_rx_rmap(vsi);
+
 	ice_for_each_q_vector(vsi, i) {
 		u16 vector = i + base;
 		int irq_num;
@@ -2424,7 +2426,8 @@ void ice_vsi_free_irq(struct ice_vsi *vsi)
 			continue;
 
 		/* clear the affinity notifier in the IRQ descriptor */
-		irq_set_affinity_notifier(irq_num, NULL);
+		if (!IS_ENABLED(CONFIG_RFS_ACCEL))
+			irq_set_affinity_notifier(irq_num, NULL);
 
 		/* clear the affinity_mask in the IRQ descriptor */
 		irq_set_affinity_hint(irq_num, NULL);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 035bc90c8124..a337a6826a84 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2247,6 +2247,13 @@ static int ice_vsi_req_irq_msix(struct ice_vsi *vsi, char *basename)
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
 
@@ -3242,22 +3249,12 @@ static int ice_setup_pf_sw(struct ice_pf *pf)
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
@@ -4598,7 +4595,6 @@ static int __maybe_unused ice_suspend(struct device *dev)
 			continue;
 		ice_vsi_free_q_vectors(pf->vsi[v]);
 	}
-	ice_free_cpu_rx_rmap(ice_get_main_vsi(pf));
 	ice_clear_interrupt_scheme(pf);
 
 	pci_save_state(pdev);
-- 
2.47.1


