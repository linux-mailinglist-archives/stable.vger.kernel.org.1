Return-Path: <stable+bounces-106139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34DB9FCA76
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 12:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D83162E74
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 11:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80CE1D222B;
	Thu, 26 Dec 2024 11:16:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EF479CD;
	Thu, 26 Dec 2024 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735211815; cv=none; b=lGGrqTkmN/gkAF/lPjrUBr6DhrrQn7ZedQfy1Wo6SjepmGynBqpG9gzXAiVX611kPLj/hhsNMH4ZGhUCtL9dUE7UgE2Fjrh1MfZaQj1UaWVax5UMIS5nJtIHtBXBfUo802StIvGuKdt3/evcTtvyqFv4J/T3Q7OiENSfHAh0kMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735211815; c=relaxed/simple;
	bh=VSZ70DPzOrnME7a/vnumVDpaKk2n7CiOZnBxCL3RX5o=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=oHlyxSraDFbBMdSRM0so336GPH9JgbFbH9KiXS3dvDYX8k1He/ocWptA/PfIWUj3jggGap5ClctyEEeeT9BAqqaldiXsxoNXYfNFk4xZjbNJkg+RdKeM3KZ6/y0SVl1p3HWsEcnmp9SpBWEJhesCfbu8SvSj0pLVoXw93AwID/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4YJmKj2fzjz8R041;
	Thu, 26 Dec 2024 19:16:41 +0800 (CST)
Received: from njy2app04.zte.com.cn ([10.40.12.64])
	by mse-fl2.zte.com.cn with SMTP id 4BQBGewD069598;
	Thu, 26 Dec 2024 19:16:40 +0800 (+08)
	(envelope-from jiang.kun2@zte.com.cn)
Received: from mapi (njy2app04[null])
	by mapi (Zmail) with MAPI id mid204;
	Thu, 26 Dec 2024 19:16:43 +0800 (CST)
Date: Thu, 26 Dec 2024 19:16:43 +0800 (CST)
X-Zmail-TransId: 2afc676d3b1b66f-aacfa
X-Mailer: Zmail v1.0
Message-ID: <202412261916435469rfyTVNfO8PtKWbw6X51-@zte.com.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.kun2@zte.com.cn>
To: <andrew@lunn.ch>, <vivien.didelot@gmail.com>, <f.fainelli@gmail.com>,
        <olteanv@gmail.com>, <davem@davemloft.net>, <kuba@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
Cc: <he.peilin@zte.com.cn>, <xu.xin16@zte.com.cn>, <fan.yu9@zte.com.cn>,
        <qiu.yutan@zte.com.cn>, <wang.yaxin@zte.com.cn>,
        <tu.qiang35@zte.com.cn>, <yang.yang29@zte.com.cn>,
        <ye.xingchen@zte.com.cn>, <zhang.yunkai@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHN0YWJsZSA1LjE1XSBuZXQ6ZHNhOmZpeCB0aGUgZHNhX3B0ciBudWxsIHBvaW50ZXIgZGVyZWZlcmVuY2U=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 4BQBGewD069598
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 676D3B19.000/4YJmKj2fzjz8R041

From: Peilin He<he.peilin@zte.com.cn>

Upstream commit 6c24a03a61a2 ("net: dsa: improve shutdown sequence")

Issue
=====
Repeatedly accessing the DSA Ethernet controller via the ethtool command,
followed by a system reboot, may trigger a DSA null pointer dereference,
causing a kernel panic and preventing the system from rebooting properly.
This can lead to data loss or denial-of-service, resulting in serious
consequences.

The following is the panic log:
[  172.523467] Unable to handle kernel NULL pointer dereference at virtual
address 0000000000000020
[  172.706923] Call trace:
[  172.709371]  dsa_master_get_sset_count+0x24/0xa4
[  172.714000]  ethtool_get_drvinfo+0x8c/0x210
[  172.718193]  dev_ethtool+0x780/0x2120
[  172.721863]  dev_ioctl+0x1b0/0x580
[  172.725273]  sock_do_ioctl+0xc0/0x100
[  172.728944]  sock_ioctl+0x130/0x3c0
[  172.732440]  __arm64_sys_ioctl+0xb4/0x100
[  172.736460]  invoke_syscall+0x50/0x120
[  172.740219]  el0_svc_common.constprop.0+0x4c/0xf4
[  172.744936]  do_el0_svc+0x2c/0xa0
[  172.748257]  el0_svc+0x20/0x60
[  172.751318]  el0t_64_sync_handler+0xe8/0x114
[  172.755599]  el0t_64_sync+0x180/0x184
[  172.759271] Code: a90153f3 2a0103f4 a9025bf5 f9418015 (f94012b6)
[  172.765383] ---[ end trace 0000000000000002 ]---

Root Cause
==========
Based on analysis of the Linux 5.15 stable version, the function
dsa_master_get_sset_count() accesses members of the structure pointed
to by cpu_dp without checking for a null pointer.  If cpu_dp is a
null pointer, this will cause a kernel panic.

	static int dsa_master_get_sset_count(struct net_device *dev, int sset)
	{
		struct dsa_port *cpu_dp = dev->dsa_ptr;
		const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
		struct dsa_switch *ds = cpu_dp->ds;
		...
	}

dev->dsa_ptr is set to NULL in the dsa_switch_shutdown() or
dsa_master_teardown() functions. When the DSA module unloads,
dsa_master_ethtool_teardown(dev) restores the original copy of
the DSA device's ethtool_ops using "dev->ethtool_ops =
cpu_dp->orig_ethtool_ops;" before setting dev->dsa_ptr to NULL.
This ensures that ethtool_ops remains accessible after DSA unloads.
However, dsa_switch_shutdown does not restore the original copy of
the DSA device's ethtool_ops, potentially leading to a null pointer
dereference of dsa_ptr and causing a system panic.  Essentially,
when we set master->dsa_ptr to NULL, we need to ensure that
no user ports are making requests to the DSA driver.

Solution
========
The addition of the netif_device_detach() function is to ensure that
ioctls, rtnetlinks and ethtool requests on the user ports no longer
propagate down to the driver - we're no longer prepared to handle them.

Fixes: ee534378f005 ("net: dsa: fix panic when DSA master device unbinds on shutdown")
Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Peilin He <he.peilin@zte.com.cn>
Reviewed-by: xu xin <xu.xin16@zte.com.cn>
Signed-off-by: Kun Jiang <jiang.kun2@zte.com.cn>
Cc: Fan Yu <fan.yu9@zte.com.cn>
Cc: Yutan Qiu <qiu.yutan@zte.com.cn>
Cc: Yaxin Wang <wang.yaxin@zte.com.cn>
Cc: tuqiang <tu.qiang35@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Cc: ye xingchen <ye.xingchen@zte.com.cn>
Cc: Yunkai Zhang <zhang.yunkai@zte.com.cn>
---
 net/dsa/dsa2.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index 543834e31298..bf384b30ec0a 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -1656,6 +1656,7 @@ EXPORT_SYMBOL_GPL(dsa_unregister_switch);
 void dsa_switch_shutdown(struct dsa_switch *ds)
 {
 	struct net_device *master, *slave_dev;
+	LIST_HEAD(close_list);
 	struct dsa_port *dp;

 	mutex_lock(&dsa2_mutex);
@@ -1665,6 +1666,11 @@ void dsa_switch_shutdown(struct dsa_switch *ds)

 	rtnl_lock();

+	dsa_switch_for_each_cpu_port(dp, ds)
+		list_add(&dp->master->close_list, &close_list);
+
+	dev_close_many(&close_list, true);
+
 	list_for_each_entry(dp, &ds->dst->ports, list) {
 		if (dp->ds != ds)
 			continue;
@@ -1675,6 +1681,7 @@ void dsa_switch_shutdown(struct dsa_switch *ds)
 		master = dp->cpu_dp->master;
 		slave_dev = dp->slave;

+		netif_device_detach(slave_dev);
 		netdev_upper_dev_unlink(master, slave_dev);
 	}

-- 
2.25.1

