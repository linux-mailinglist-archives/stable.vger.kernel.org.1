Return-Path: <stable+bounces-106288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6003A9FE712
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 15:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE071188278B
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 14:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE0A1AA1D9;
	Mon, 30 Dec 2024 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JnxELWNa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3593E1A38E1;
	Mon, 30 Dec 2024 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735569008; cv=none; b=b1vFBcqY1UNkj9lLJ6LlDkSuDelZpmTLUj6thvGKpLSFULe9q4ANwY6KxcDfkO9SJyIVyYUtKjoLBfHmlCJPy6NxCyZS8gFH+7oNcVNoXXss218bEfoCUy07jBtebx9KUhf+7suX6Y/7FfRRQeSC6hI+MjIczP5DVTTojULRObk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735569008; c=relaxed/simple;
	bh=AnT1KVJBfqYTVHmxRL7iPnwJYQrJXaEiBQ9mnWV6kDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YS7Yni1lQZmcoxMq3IOQ8IDSh7H77MnyBC2Rg1THae7loTDJQlBcaRD8oaInzeoKA7qZKZDnjMoEBdueCGBKgaF/m9+1/3ry4sDs6Z1Citd/ag4L08yVhrLL/Wub1I+Bugl0bhY06WOFPA8e0GTSUzoR6rGPlw1uvSl4Tz39eWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JnxELWNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4F9C4CED0;
	Mon, 30 Dec 2024 14:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735569007;
	bh=AnT1KVJBfqYTVHmxRL7iPnwJYQrJXaEiBQ9mnWV6kDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JnxELWNaJom0miyHT4j0orYbD+v+uujWD4w49k422AlVaQirRuvrb/luY/N8n6C0p
	 xkDQonUFzTqF3bnwJDqB3II+RxCsFmFefquWvHj3BPlYV8u6zAo45ZSecuf+XdD8nD
	 7kDrHEqpQMyE/fE+1NwYwONqB/lSqy3+EESiiG+k=
Date: Mon, 30 Dec 2024 15:30:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: jiang.kun2@zte.com.cn
Cc: andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
	olteanv@gmail.com, davem@davemloft.net, kuba@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, he.peilin@zte.com.cn, xu.xin16@zte.com.cn,
	fan.yu9@zte.com.cn, qiu.yutan@zte.com.cn, wang.yaxin@zte.com.cn,
	tu.qiang35@zte.com.cn, yang.yang29@zte.com.cn,
	ye.xingchen@zte.com.cn, zhang.yunkai@zte.com.cn
Subject: Re: [PATCH stable 5.15] net:dsa:fix the dsa_ptr null pointer
 dereference
Message-ID: <2024123054-matrix-surprise-f5c1@gregkh>
References: <202412261916435469rfyTVNfO8PtKWbw6X51-@zte.com.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202412261916435469rfyTVNfO8PtKWbw6X51-@zte.com.cn>

On Thu, Dec 26, 2024 at 07:16:43PM +0800, jiang.kun2@zte.com.cn wrote:
> From: Peilin He<he.peilin@zte.com.cn>
> 
> Upstream commit 6c24a03a61a2 ("net: dsa: improve shutdown sequence")
> 
> Issue
> =====
> Repeatedly accessing the DSA Ethernet controller via the ethtool command,
> followed by a system reboot, may trigger a DSA null pointer dereference,
> causing a kernel panic and preventing the system from rebooting properly.
> This can lead to data loss or denial-of-service, resulting in serious
> consequences.
> 
> The following is the panic log:
> [  172.523467] Unable to handle kernel NULL pointer dereference at virtual
> address 0000000000000020
> [  172.706923] Call trace:
> [  172.709371]  dsa_master_get_sset_count+0x24/0xa4
> [  172.714000]  ethtool_get_drvinfo+0x8c/0x210
> [  172.718193]  dev_ethtool+0x780/0x2120
> [  172.721863]  dev_ioctl+0x1b0/0x580
> [  172.725273]  sock_do_ioctl+0xc0/0x100
> [  172.728944]  sock_ioctl+0x130/0x3c0
> [  172.732440]  __arm64_sys_ioctl+0xb4/0x100
> [  172.736460]  invoke_syscall+0x50/0x120
> [  172.740219]  el0_svc_common.constprop.0+0x4c/0xf4
> [  172.744936]  do_el0_svc+0x2c/0xa0
> [  172.748257]  el0_svc+0x20/0x60
> [  172.751318]  el0t_64_sync_handler+0xe8/0x114
> [  172.755599]  el0t_64_sync+0x180/0x184
> [  172.759271] Code: a90153f3 2a0103f4 a9025bf5 f9418015 (f94012b6)
> [  172.765383] ---[ end trace 0000000000000002 ]---
> 
> Root Cause
> ==========
> Based on analysis of the Linux 5.15 stable version, the function
> dsa_master_get_sset_count() accesses members of the structure pointed
> to by cpu_dp without checking for a null pointer.  If cpu_dp is a
> null pointer, this will cause a kernel panic.
> 
> 	static int dsa_master_get_sset_count(struct net_device *dev, int sset)
> 	{
> 		struct dsa_port *cpu_dp = dev->dsa_ptr;
> 		const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
> 		struct dsa_switch *ds = cpu_dp->ds;
> 		...
> 	}
> 
> dev->dsa_ptr is set to NULL in the dsa_switch_shutdown() or
> dsa_master_teardown() functions. When the DSA module unloads,
> dsa_master_ethtool_teardown(dev) restores the original copy of
> the DSA device's ethtool_ops using "dev->ethtool_ops =
> cpu_dp->orig_ethtool_ops;" before setting dev->dsa_ptr to NULL.
> This ensures that ethtool_ops remains accessible after DSA unloads.
> However, dsa_switch_shutdown does not restore the original copy of
> the DSA device's ethtool_ops, potentially leading to a null pointer
> dereference of dsa_ptr and causing a system panic.  Essentially,
> when we set master->dsa_ptr to NULL, we need to ensure that
> no user ports are making requests to the DSA driver.
> 
> Solution
> ========
> The addition of the netif_device_detach() function is to ensure that
> ioctls, rtnetlinks and ethtool requests on the user ports no longer
> propagate down to the driver - we're no longer prepared to handle them.
> 
> Fixes: ee534378f005 ("net: dsa: fix panic when DSA master device unbinds on shutdown")
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Peilin He <he.peilin@zte.com.cn>
> Reviewed-by: xu xin <xu.xin16@zte.com.cn>
> Signed-off-by: Kun Jiang <jiang.kun2@zte.com.cn>
> Cc: Fan Yu <fan.yu9@zte.com.cn>
> Cc: Yutan Qiu <qiu.yutan@zte.com.cn>
> Cc: Yaxin Wang <wang.yaxin@zte.com.cn>
> Cc: tuqiang <tu.qiang35@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> Cc: ye xingchen <ye.xingchen@zte.com.cn>
> Cc: Yunkai Zhang <zhang.yunkai@zte.com.cn>

You dropped all the original signed-off-by lines :(

