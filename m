Return-Path: <stable+bounces-179270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0209DB534B1
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 15:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AAED1756FF
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 13:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F14334379;
	Thu, 11 Sep 2025 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="M1/pwIJ1"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F2932F760
	for <stable@vger.kernel.org>; Thu, 11 Sep 2025 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599144; cv=none; b=o5QW8E5PdRV4ZZ9WTcY0DlhxcHG8YRftziJyrko/0xqS5CRgZZgOZLjqe6HNs242l/saQX27334r1Ew647uSWzbuO4OX7dQsvhiJaBktKXYRJW/rc3dkzmEtxz826tN4Ouv3GQ9xg46ZcWg5d/E++xot0WbKT72+QjuUvlcBp3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599144; c=relaxed/simple;
	bh=fHBHCQmnDZz6FRpjpKWMXovmU8dVnIIVwcvWahYEhes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Lz4k7PII6ZCB7Q/mNE+pMLPRpC49/SXAlbP7kI//Uqmg+qlOzd6C9en2dls4jnvvowdyBqblQL+c3khy5e+IgkHpn2u7u1cyxx5OSgDnzYRQ9MYLhPr9Q2iCm7fYk+DlxMNSkGjhvHVgNuBVZizMzffIxo+1m1k8OTQ+tgMP+To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=M1/pwIJ1; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250911135853euoutp02fde1dbc47aeea319078aa9bec69783b7~kPxmQjeh62208522085euoutp02B
	for <stable@vger.kernel.org>; Thu, 11 Sep 2025 13:58:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250911135853euoutp02fde1dbc47aeea319078aa9bec69783b7~kPxmQjeh62208522085euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757599133;
	bh=01UFvrYlJ970r9Bcj467+Hwxw2DXN8UdPW70CypFosc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=M1/pwIJ1orJH0+nnFXJdQFgTOKWgBLbQyWXSf9UUP7NWRjXeLQoxyKbyaony9kHhY
	 mDEAy3Vfc9OyPpBS1aMgftDFlmeFdgxAR0QVYvt2KfheZGG595DxJN8uLEN7T+oay3
	 Hg/s9tMr3DZPEDEPBisSx8sepekf7BC3vtlZwnTI=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250911135853eucas1p283b1afd37287b715403cd2cdbfa03a94~kPxltjvy-0341403414eucas1p2Y;
	Thu, 11 Sep 2025 13:58:53 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250911135851eusmtip1c3fabbd783fee7b6f83d8a3c99979aa5~kPxkUDm1p0287802878eusmtip1E;
	Thu, 11 Sep 2025 13:58:51 +0000 (GMT)
Message-ID: <b5ea8296-f981-445d-a09a-2f389d7f6fdd@samsung.com>
Date: Thu, 11 Sep 2025 15:58:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH net v1 1/1] net: usb: asix: ax88772: drop phylink use in
 PM to avoid MDIO runtime PM wakeups
To: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
	Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Cc: =?UTF-8?Q?Hubert_Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>,
	stable@vger.kernel.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, Russell King
	<linux@armlinux.org.uk>, Xu Yang <xu.yang_2@nxp.com>,
	linux-usb@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250908112619.2900723-1-o.rempel@pengutronix.de>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250911135853eucas1p283b1afd37287b715403cd2cdbfa03a94
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250911135853eucas1p283b1afd37287b715403cd2cdbfa03a94
X-EPHeader: CA
X-CMS-RootMailID: 20250911135853eucas1p283b1afd37287b715403cd2cdbfa03a94
References: <20250908112619.2900723-1-o.rempel@pengutronix.de>
	<CGME20250911135853eucas1p283b1afd37287b715403cd2cdbfa03a94@eucas1p2.samsung.com>

On 08.09.2025 13:26, Oleksij Rempel wrote:
> Drop phylink_{suspend,resume}() from ax88772 PM callbacks.
>
> MDIO bus accesses have their own runtime-PM handling and will try to
> wake the device if it is suspended. Such wake attempts must not happen
> from PM callbacks while the device PM lock is held. Since phylink
> {sus|re}sume may trigger MDIO, it must not be called in PM context.
>
> No extra phylink PM handling is required for this driver:
> - .ndo_open/.ndo_stop control the phylink start/stop lifecycle.
> - ethtool/phylib entry points run in process context, not PM.
> - phylink MAC ops program the MAC on link changes after resume.
>
> Fixes: e0bffe3e6894 ("net: asix: ax88772: migrate to phylink")
> Reported-by: Hubert Wiśniewski <hubert.wisniewski.25632@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---

This patch landed in today's linux-next as commit 5537a4679403 ("net: 
usb: asix: ax88772: drop phylink use in PM to avoid MDIO runtime PM 
wakeups"). In my tests I found that it breaks operation of asix ethernet 
usb dongle after system suspend-resume cycle. The ethernet device is 
still present in the system, but it is completely dysfunctional. Here is 
the log:

root@target:~# time rtcwake -s10 -mmem
rtcwake: wakeup from "mem" using /dev/rtc0 at Thu Sep 11 13:02:23 2025
PM: suspend entry (deep)
Filesystems sync: 0.002 seconds
Freezing user space processes
Freezing user space processes completed (elapsed 0.003 seconds)
OOM killer disabled.
Freezing remaining freezable tasks
Freezing remaining freezable tasks completed (elapsed 0.024 seconds)
...
usb usb1: root hub lost power or was reset
...
usb usb2: root hub lost power or was reset
xhci-hcd xhci-hcd.7.auto: xHC error in resume, USBSTS 0x401, Reinit
usb usb3: root hub lost power or was reset
usb usb4: root hub lost power or was reset
asix 2-1:1.0 eth0: Failed to write reg index 0x0000: -113
asix 2-1:1.0 eth0: Failed to enable software MII access
asix 2-1:1.0 eth0: Failed to read reg index 0x0000: -113
asix 2-1:1.0 eth0: Failed to write reg index 0x0000: -113
asix 2-1:1.0 eth0: Failed to enable software MII access
... (the above error repeated many times)
------------[ cut here ]------------
WARNING: CPU: 0 PID: 9 at drivers/net/phy/phy.c:1346 
_phy_state_machine+0x158/0x2d0
phy_check_link_status+0x0/0x140: returned: -110
Modules linked in: cmac bnep mwifiex_sdio mwifiex btmrvl_sdio btmrvl 
sha256 bluetooth cfg80211 s5p_mfc exynos_gsc v4l2_mem2mem 
videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 videobuf2_common 
videodev ecdh_generic ecc mc s5p_cec
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 
6.17.0-rc4-00221-g5537a4679403 #11106 PREEMPT
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events_power_efficient phy_state_machine
Call trace:
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x68/0x88
  dump_stack_lvl from __warn+0x80/0x1d0
  __warn from warn_slowpath_fmt+0x124/0x1bc
  warn_slowpath_fmt from _phy_state_machine+0x158/0x2d0
  _phy_state_machine from phy_state_machine+0x24/0x44
  phy_state_machine from process_one_work+0x24c/0x70c
  process_one_work from worker_thread+0x1b8/0x3bc
  worker_thread from kthread+0x13c/0x264
  kthread from ret_from_fork+0x14/0x28
Exception stack(0xf0879fb0 to 0xf0879ff8)
...
irq event stamp: 221553
hardirqs last  enabled at (221559): [<c01bae94>] __up_console_sem+0x50/0x60
hardirqs last disabled at (221564): [<c01bae80>] __up_console_sem+0x3c/0x60
softirqs last  enabled at (219346): [<c013b93c>] handle_softirqs+0x328/0x520
softirqs last disabled at (219327): [<c013bce0>] __irq_exit_rcu+0x144/0x1f0
---[ end trace 0000000000000000 ]---
asix 2-1:1.0 eth0: Failed to write reg index 0x0000: -113
asix 2-1:1.0 eth0: Failed to enable software MII access
asix 2-1:1.0 eth0: Failed to write reg index 0x0000: -113
asix 2-1:1.0 eth0: Failed to write Medium Mode mode to 0x0000: ffffff8f
asix 2-1:1.0 eth0: Link is Down
asix 2-1:1.0 eth0: Failed to read reg index 0x0000: -113
asix 2-1:1.0 eth0: Failed to write reg index 0x0000: -113
asix 2-1:1.0 eth0: Failed to enable software MII access
asix 2-1:1.0 eth0: Failed to read reg index 0x0000: -113
asix 2-1:1.0 eth0: Failed to write reg index 0x0000: -113
asix 2-1:1.0 eth0: Failed to enable software MII access
... (the above error repeated many times)
usb 2-1: reset high-speed USB device number 2 using exynos-ehci
OOM killer enabled.
Restarting tasks: Starting
Restarting tasks: Done
PM: suspend exit

real    0m14.105s
user    0m0.002s
sys     0m2.025s
root@target:~#
root@target:~# ifconfig -a
eth0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 192.168.100.17  netmask 255.255.255.0  broadcast 
192.168.100.255
        inet6 fe80::250:b6ff:fe18:92ee  prefixlen 64  scopeid 0x20<link>
        ether 00:50:b6:18:92:ee  txqueuelen 1000  (Ethernet)
        RX packets 242  bytes 18250 (17.8 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 258  bytes 22474 (21.9 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

root@target:~# ping host
PING host (192.168.100.1) 56(84) bytes of data.
^C
--- host ping statistics ---
2 packets transmitted, 0 received, 100% packet loss, time 1053ms


Reverting $subject on top of today's linux-next restores ethernet 
operation after system suspend-resume cycle.


>   drivers/net/usb/asix_devices.c | 13 -------------
>   1 file changed, 13 deletions(-)
>
> diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
> index 792ddda1ad49..1e8f7089f5e8 100644
> --- a/drivers/net/usb/asix_devices.c
> +++ b/drivers/net/usb/asix_devices.c
> @@ -607,15 +607,8 @@ static const struct net_device_ops ax88772_netdev_ops = {
>
>   static void ax88772_suspend(struct usbnet *dev)
>   {
> -	struct asix_common_private *priv = dev->driver_priv;
>   	u16 medium;
>
> -	if (netif_running(dev->net)) {
> -		rtnl_lock();
> -		phylink_suspend(priv->phylink, false);
> -		rtnl_unlock();
> -	}
> -
>   	/* Stop MAC operation */
>   	medium = asix_read_medium_status(dev, 1);
>   	medium &= ~AX_MEDIUM_RE;
> @@ -644,12 +637,6 @@ static void ax88772_resume(struct usbnet *dev)
>   	for (i = 0; i < 3; i++)
>   		if (!priv->reset(dev, 1))
>   			break;
> -
> -	if (netif_running(dev->net)) {
> -		rtnl_lock();
> -		phylink_resume(priv->phylink);
> -		rtnl_unlock();
> -	}
>   }
>
>   static int asix_resume(struct usb_interface *intf)
> --
> 2.47.3
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


