Return-Path: <stable+bounces-160567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8740FAFD0CE
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75A3A562CAB
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A713D2DAFC1;
	Tue,  8 Jul 2025 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z1bhwU7E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6571521B199;
	Tue,  8 Jul 2025 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992023; cv=none; b=PUlIfgOGgUaPuI9p5+PlFxL/0i4zmkdWDkka+AlAU1lafBujh6DF/xExRL0kTr17tj0LFlEk2vxpoADOiM/vubkIfcDMMpCax5L+5XOguvtMzEMwmxUzB/0n7a4ZekttvLoyOl+zDlio3SMITmy0GI64uifBCBoMs4y+IAxKjfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992023; c=relaxed/simple;
	bh=F4XouhNbhjEbGgpw3uGew/EZIL10nWQBnMFHk6Kh678=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLi5RT9PvjIMPr/7kNNEupfaN9gTqX70Udy/WfTMowWl3+PCD4FN6/bkoN+vHA98pB8ib6kgwqZFQbtTccCUkmhnCC57RlCtaeIccQO6tp+zkXsv0EXavvz+rc7ZvQStZ58s+7yKufG7h9poIynf/3MEx3yFW+pQZZPnGUYhEL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z1bhwU7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05E9C4CEED;
	Tue,  8 Jul 2025 16:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992023;
	bh=F4XouhNbhjEbGgpw3uGew/EZIL10nWQBnMFHk6Kh678=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z1bhwU7Eb352cgTdxW71BdqqxkNF8Gljr9KFt/489n7KWiqld7o0ovaMww/1bk7/E
	 klyZ9/s1FqOJP1DC9/29AOQJwsJ1tO8bJHUMtN87DNnkqlK+CRvUjDaL1cnKmFguoP
	 TjmffsBIiixYy0HLiPyQ7jfFNaHo2XaI0RaMuu7A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Zhang <markzhang@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 17/81] RDMA/mlx5: Initialize obj_event->obj_sub_list before xa_insert
Date: Tue,  8 Jul 2025 18:23:09 +0200
Message-ID: <20250708162225.460340313@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162224.795155912@linuxfoundation.org>
References: <20250708162224.795155912@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Zhang <markzhang@nvidia.com>

[ Upstream commit 8edab8a72d67742f87e9dc2e2b0cdfddda5dc29a ]

The obj_event may be loaded immediately after inserted, then if the
list_head is not initialized then we may get a poisonous pointer.  This
fixes the crash below:

 mlx5_core 0000:03:00.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0 enhanced)
 mlx5_core.sf mlx5_core.sf.4: firmware version: 32.38.3056
 mlx5_core 0000:03:00.0 en3f0pf0sf2002: renamed from eth0
 mlx5_core.sf mlx5_core.sf.4: Rate limit: 127 rates are supported, range: 0Mbps to 195312Mbps
 IPv6: ADDRCONF(NETDEV_CHANGE): en3f0pf0sf2002: link becomes ready
 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000060
 Mem abort info:
   ESR = 0x96000006
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
 Data abort info:
   ISV = 0, ISS = 0x00000006
   CM = 0, WnR = 0
 user pgtable: 4k pages, 48-bit VAs, pgdp=00000007760fb000
 [0000000000000060] pgd=000000076f6d7003, p4d=000000076f6d7003, pud=0000000777841003, pmd=0000000000000000
 Internal error: Oops: 96000006 [#1] SMP
 Modules linked in: ipmb_host(OE) act_mirred(E) cls_flower(E) sch_ingress(E) mptcp_diag(E) udp_diag(E) raw_diag(E) unix_diag(E) tcp_diag(E) inet_diag(E) binfmt_misc(E) bonding(OE) rdma_ucm(OE) rdma_cm(OE) iw_cm(OE) ib_ipoib(OE) ib_cm(OE) isofs(E) cdrom(E) mst_pciconf(OE) ib_umad(OE) mlx5_ib(OE) ipmb_dev_int(OE) mlx5_core(OE) kpatch_15237886(OEK) mlxdevm(OE) auxiliary(OE) ib_uverbs(OE) ib_core(OE) psample(E) mlxfw(OE) tls(E) sunrpc(E) vfat(E) fat(E) crct10dif_ce(E) ghash_ce(E) sha1_ce(E) sbsa_gwdt(E) virtio_console(E) ext4(E) mbcache(E) jbd2(E) xfs(E) libcrc32c(E) mmc_block(E) virtio_net(E) net_failover(E) failover(E) sha2_ce(E) sha256_arm64(E) nvme(OE) nvme_core(OE) gpio_mlxbf3(OE) mlx_compat(OE) mlxbf_pmc(OE) i2c_mlxbf(OE) sdhci_of_dwcmshc(OE) pinctrl_mlxbf3(OE) mlxbf_pka(OE) gpio_generic(E) i2c_core(E) mmc_core(E) mlxbf_gige(OE) vitesse(E) pwr_mlxbf(OE) mlxbf_tmfifo(OE) micrel(E) mlxbf_bootctl(OE) virtio_ring(E) virtio(E) ipmi_devintf(E) ipmi_msghandler(E)
  [last unloaded: mst_pci]
 CPU: 11 PID: 20913 Comm: rte-worker-11 Kdump: loaded Tainted: G           OE K   5.10.134-13.1.an8.aarch64 #1
 Hardware name: https://www.mellanox.com BlueField-3 SmartNIC Main Card/BlueField-3 SmartNIC Main Card, BIOS 4.2.2.12968 Oct 26 2023
 pstate: a0400089 (NzCv daIf +PAN -UAO -TCO BTYPE=--)
 pc : dispatch_event_fd+0x68/0x300 [mlx5_ib]
 lr : devx_event_notifier+0xcc/0x228 [mlx5_ib]
 sp : ffff80001005bcf0
 x29: ffff80001005bcf0 x28: 0000000000000001
 x27: ffff244e0740a1d8 x26: ffff244e0740a1d0
 x25: ffffda56beff5ae0 x24: ffffda56bf911618
 x23: ffff244e0596a480 x22: ffff244e0596a480
 x21: ffff244d8312ad90 x20: ffff244e0596a480
 x19: fffffffffffffff0 x18: 0000000000000000
 x17: 0000000000000000 x16: ffffda56be66d620
 x15: 0000000000000000 x14: 0000000000000000
 x13: 0000000000000000 x12: 0000000000000000
 x11: 0000000000000040 x10: ffffda56bfcafb50
 x9 : ffffda5655c25f2c x8 : 0000000000000010
 x7 : 0000000000000000 x6 : ffff24545a2e24b8
 x5 : 0000000000000003 x4 : ffff80001005bd28
 x3 : 0000000000000000 x2 : 0000000000000000
 x1 : ffff244e0596a480 x0 : ffff244d8312ad90
 Call trace:
  dispatch_event_fd+0x68/0x300 [mlx5_ib]
  devx_event_notifier+0xcc/0x228 [mlx5_ib]
  atomic_notifier_call_chain+0x58/0x80
  mlx5_eq_async_int+0x148/0x2b0 [mlx5_core]
  atomic_notifier_call_chain+0x58/0x80
  irq_int_handler+0x20/0x30 [mlx5_core]
  __handle_irq_event_percpu+0x60/0x220
  handle_irq_event_percpu+0x3c/0x90
  handle_irq_event+0x58/0x158
  handle_fasteoi_irq+0xfc/0x188
  generic_handle_irq+0x34/0x48
  ...

Fixes: 759738537142 ("IB/mlx5: Enable subscription for device events over DEVX")
Link: https://patch.msgid.link/r/3ce7f20e0d1a03dc7de6e57494ec4b8eaf1f05c2.1750147949.git.leon@kernel.org
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/devx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 7013ce20549bd..cc126e62643a0 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -1914,6 +1914,7 @@ subscribe_event_xa_alloc(struct mlx5_devx_event_table *devx_event_table,
 			/* Level1 is valid for future use, no need to free */
 			return -ENOMEM;
 
+		INIT_LIST_HEAD(&obj_event->obj_sub_list);
 		err = xa_insert(&event->object_ids,
 				key_level2,
 				obj_event,
@@ -1922,7 +1923,6 @@ subscribe_event_xa_alloc(struct mlx5_devx_event_table *devx_event_table,
 			kfree(obj_event);
 			return err;
 		}
-		INIT_LIST_HEAD(&obj_event->obj_sub_list);
 	}
 
 	return 0;
-- 
2.39.5




