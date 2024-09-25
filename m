Return-Path: <stable+bounces-77330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE38B985BEB
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA4FCB28827
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70611C7B9B;
	Wed, 25 Sep 2024 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+OfMnKp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C152185938;
	Wed, 25 Sep 2024 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265194; cv=none; b=peCS8YOQaPMXQfNGOnC6YY/8eUWTJRGJXD8MBmiJNR6oiq/qsS+17pu+4lO5HVkovwhF/mVLp7uE9k2tHY585eIOq08evJFq7bb01lN3Cpdpj8pJ8juoKRwTEjDNdm/uxEpFV6soAhQnuMsMLHldJAW7hzgpzehJRQGfVUWl+sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265194; c=relaxed/simple;
	bh=jZgE2349ui6nHf9uGCcxpcTSJ+MRxRy6HpIJzU27m+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eH9mKeSqHXKSvCX7FsJzPwH+U0nS+bO/a4OLcBZOcshnewZQN5QQSkTp8LJ5TENvZSZZ9lleSu8qAL+4hGQJQ5KNdbzlh9UkVxxN8dMyMUId6Un6YrA5t6Xwp/yoEkW0vR85ikLkzvYhxwzKSx6iJW92H3kdzwaBEI6PPo4QlnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+OfMnKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B549C4CECE;
	Wed, 25 Sep 2024 11:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265194;
	bh=jZgE2349ui6nHf9uGCcxpcTSJ+MRxRy6HpIJzU27m+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d+OfMnKpcspqQ6gP2kmol8/yrgWjFxyQ+fCk/mNUqaEbQEgE0gOayg2PyKQe+s9wU
	 HZGQsqhWsVwuYIbmM8i8VH6jcZZrTSvRyN1vHoVPx8oLw2VafLRnuR+PW2wJmWoy4K
	 InIWliIXcijjA8SQ/AJk+3m43uTclDiJSKE3MCWS1KZtvL9D7nMaSOcyjlCAMSASD9
	 w8sVsUTd+kMQalBGJWUHM/NzwJ7w5EYVx8oFDCvRCh/gwcm4wjLK9MexKpKOdeFSiP
	 wpYRX/FVHcfsiC7BGY+E6d+5hGaNRSOSD6R5+KDWycXIZXZkH2ohHVOMIJ3EOQ2Hvy
	 J9pZqXbZgC4dA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Capitulino <luizcap@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	ilpo.jarvinen@linux.intel.com,
	vadimp@nvidia.com,
	jdelvare@suse.com,
	linux@roeck-us.net,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 232/244] platform/mellanox: mlxbf-pmc: fix lockdep warning
Date: Wed, 25 Sep 2024 07:27:33 -0400
Message-ID: <20240925113641.1297102-232-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Luiz Capitulino <luizcap@redhat.com>

[ Upstream commit 305790dd91057a3f7497c9d128614a4f8486b62b ]

It seems the mlxbf-pmc driver is missing initializing sysfs attributes
which causes the warning below when CONFIG_LOCKDEP and
CONFIG_DEBUG_LOCK_ALLOC are enabled. This commit fixes it.

[  155.380843] BUG: key ffff470f45dfa6d8 has not been registered!
[  155.386749] ------------[ cut here ]------------
[  155.391361] DEBUG_LOCKS_WARN_ON(1)
[  155.391381] WARNING: CPU: 4 PID: 1828 at kernel/locking/lockdep.c:4894 lockdep_init_map_type+0x1d0/0x288
[  155.404254] Modules linked in: mlxbf_pmc(+) xfs libcrc32c mmc_block mlx5_core crct10dif_ce mlxfw ghash_ce virtio_net tls net_failover sha2
_ce failover psample sha256_arm64 dw_mmc_bluefield pci_hyperv_intf sha1_ce dw_mmc_pltfm sbsa_gwdt dw_mmc micrel mmc_core nfit i2c_mlxbf pwr_m
lxbf gpio_generic libnvdimm mlxbf_tmfifo mlxbf_gige dm_mirror dm_region_hash dm_log dm_mod
[  155.436786] CPU: 4 UID: 0 PID: 1828 Comm: modprobe Kdump: loaded Not tainted 6.11.0-rc7-rep1+ #1
[  155.445562] Hardware name: https://www.mellanox.com BlueField SoC/BlueField SoC, BIOS 4.8.0.13249 Aug  7 2024
[  155.455463] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  155.462413] pc : lockdep_init_map_type+0x1d0/0x288
[  155.467196] lr : lockdep_init_map_type+0x1d0/0x288
[  155.471976] sp : ffff80008a1734e0
[  155.475279] x29: ffff80008a1734e0 x28: ffff470f45df0240 x27: 00000000ffffee4b
[  155.482406] x26: 00000000000011b4 x25: 0000000000000000 x24: 0000000000000000
[  155.489532] x23: ffff470f45dfa6d8 x22: 0000000000000000 x21: ffffd54ef6bea000
[  155.496659] x20: ffff470f45dfa6d8 x19: ffff470f49cdc638 x18: ffffffffffffffff
[  155.503784] x17: 2f30303a31444642 x16: ffffd54ef48a65e8 x15: ffff80010a172fe7
[  155.510911] x14: 0000000000000000 x13: 284e4f5f4e524157 x12: 5f534b434f4c5f47
[  155.518037] x11: 0000000000000001 x10: 0000000000000001 x9 : ffffd54ef3f48a14
[  155.525163] x8 : 00000000000bffe8 x7 : c0000000ffff7fff x6 : 00000000002bffa8
[  155.532289] x5 : ffff4712bdcb6088 x4 : 0000000000000000 x3 : 0000000000000027
[  155.539416] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff470f43e5be00
[  155.546542] Call trace:
[  155.548976]  lockdep_init_map_type+0x1d0/0x288
[  155.553410]  __kernfs_create_file+0x80/0x138
[  155.557673]  sysfs_add_file_mode_ns+0x94/0x150
[  155.562106]  create_files+0xb0/0x248
[  155.565672]  internal_create_group+0x10c/0x328
[  155.570105]  internal_create_groups.part.0+0x50/0xc8
[  155.575060]  sysfs_create_groups+0x20/0x38
[  155.579146]  device_add_attrs+0x1b8/0x228
[  155.583146]  device_add+0x2a4/0x690
[  155.586625]  device_register+0x24/0x38
[  155.590362]  __hwmon_device_register+0x1e0/0x3c8
[  155.594969]  devm_hwmon_device_register_with_groups+0x78/0xe0
[  155.600703]  mlxbf_pmc_probe+0x224/0x3a0 [mlxbf_pmc]
[  155.605669]  platform_probe+0x6c/0xe0
[  155.609320]  really_probe+0xc4/0x398
[  155.612887]  __driver_probe_device+0x80/0x168
[  155.617233]  driver_probe_device+0x44/0x120
[  155.621405]  __driver_attach+0xf4/0x200
[  155.625230]  bus_for_each_dev+0x7c/0xe8
[  155.629055]  driver_attach+0x28/0x38
[  155.632619]  bus_add_driver+0x110/0x238
[  155.636445]  driver_register+0x64/0x128
[  155.640270]  __platform_driver_register+0x2c/0x40
[  155.644965]  pmc_driver_init+0x24/0xff8 [mlxbf_pmc]
[  155.649833]  do_one_initcall+0x70/0x3d0
[  155.653660]  do_init_module+0x64/0x220
[  155.657400]  load_module+0x628/0x6a8
[  155.660964]  init_module_from_file+0x8c/0xd8
[  155.665222]  idempotent_init_module+0x194/0x290
[  155.669742]  __arm64_sys_finit_module+0x6c/0xd8
[  155.674261]  invoke_syscall.constprop.0+0x74/0xd0
[  155.678957]  do_el0_svc+0xb4/0xd0
[  155.682262]  el0_svc+0x5c/0x248
[  155.685394]  el0t_64_sync_handler+0x134/0x150
[  155.689739]  el0t_64_sync+0x17c/0x180
[  155.693390] irq event stamp: 6407
[  155.696693] hardirqs last  enabled at (6407): [<ffffd54ef3f48564>] console_unlock+0x154/0x1b8
[  155.705207] hardirqs last disabled at (6406): [<ffffd54ef3f485ac>] console_unlock+0x19c/0x1b8
[  155.713719] softirqs last  enabled at (6404): [<ffffd54ef3e9740c>] handle_softirqs+0x4f4/0x518
[  155.722320] softirqs last disabled at (6395): [<ffffd54ef3df0160>] __do_softirq+0x18/0x20
[  155.730484] ---[ end trace 0000000000000000 ]---

Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
Link: https://lore.kernel.org/r/20240912190532.377097-1-luizcap@redhat.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/mellanox/mlxbf-pmc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index 4ed9c7fd2b62a..9d18dfca6a673 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -1774,6 +1774,7 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, unsigned int blk_
 
 	/* "event_list" sysfs to list events supported by the block */
 	attr = &pmc->block[blk_num].attr_event_list;
+	sysfs_attr_init(&attr->dev_attr.attr);
 	attr->dev_attr.attr.mode = 0444;
 	attr->dev_attr.show = mlxbf_pmc_event_list_show;
 	attr->nr = blk_num;
@@ -1787,6 +1788,7 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, unsigned int blk_
 	if (strstr(pmc->block_name[blk_num], "l3cache") ||
 	    ((pmc->block[blk_num].type == MLXBF_PMC_TYPE_CRSPACE))) {
 		attr = &pmc->block[blk_num].attr_enable;
+		sysfs_attr_init(&attr->dev_attr.attr);
 		attr->dev_attr.attr.mode = 0644;
 		attr->dev_attr.show = mlxbf_pmc_enable_show;
 		attr->dev_attr.store = mlxbf_pmc_enable_store;
@@ -1814,6 +1816,7 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, unsigned int blk_
 	/* "eventX" and "counterX" sysfs to program and read counter values */
 	for (j = 0; j < pmc->block[blk_num].counters; ++j) {
 		attr = &pmc->block[blk_num].attr_counter[j];
+		sysfs_attr_init(&attr->dev_attr.attr);
 		attr->dev_attr.attr.mode = 0644;
 		attr->dev_attr.show = mlxbf_pmc_counter_show;
 		attr->dev_attr.store = mlxbf_pmc_counter_store;
@@ -1826,6 +1829,7 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, unsigned int blk_
 		attr = NULL;
 
 		attr = &pmc->block[blk_num].attr_event[j];
+		sysfs_attr_init(&attr->dev_attr.attr);
 		attr->dev_attr.attr.mode = 0644;
 		attr->dev_attr.show = mlxbf_pmc_event_show;
 		attr->dev_attr.store = mlxbf_pmc_event_store;
@@ -1861,6 +1865,7 @@ static int mlxbf_pmc_init_perftype_reg(struct device *dev, unsigned int blk_num)
 	while (count > 0) {
 		--count;
 		attr = &pmc->block[blk_num].attr_event[count];
+		sysfs_attr_init(&attr->dev_attr.attr);
 		attr->dev_attr.attr.mode = 0644;
 		attr->dev_attr.show = mlxbf_pmc_counter_show;
 		attr->dev_attr.store = mlxbf_pmc_counter_store;
-- 
2.43.0


