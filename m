Return-Path: <stable+bounces-227013-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONQWN8x3ummTWwIAu9opvQ
	(envelope-from <stable+bounces-227013-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 11:00:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4265B2B994C
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 11:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA04F30574A6
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 09:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4823B7B8F;
	Wed, 18 Mar 2026 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FlZGXL6I"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4CF3AEF33
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773827885; cv=none; b=Io/y2c1frP0MrRZnEKwZ91KBCIuHS1RTaX/OtWKinUF97adhrT5C6Iy9YGfRckob7JDxM6PpFn0gV9nYsZEXgTcUsFZOzJgitiNEyBhSJaAKLfXkrepq5KUzS0+vHRwzplSUoi8RnZU/VwIe/fVuDa/w3TK2BYGUqWCst5WXBVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773827885; c=relaxed/simple;
	bh=8f61Dvd547lBCEPkiyGx+VSTIYZEcR3CAi0vMU+SH2Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=rd9mSehaiLfek9d9GlOfa207m/fcN85LLRcPiO4XOqu7TMUwsMI1zHwrQbW7Yz3v1g0OrwXXFk5xMnsZDjb9Dg9X6ZPdFI7f6kBa0YhY1NQPXInOtcubXTKOBlkj4Srbblw+ySIl9fBgt4+MBy6DXdOzIUg7/DlhBgYsNWaCKgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FlZGXL6I; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E6D4F1A2EA5;
	Wed, 18 Mar 2026 09:57:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BCE6C6004F;
	Wed, 18 Mar 2026 09:57:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7B82C10450764;
	Wed, 18 Mar 2026 10:57:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773827873; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hQlGO5381gcN8e1TNWADijNQqR2nZ9j4a7yL3qJ2fqk=;
	b=FlZGXL6IksWn28P6inum4kpC7pX8J7G4WqWy2FFe3ybQqoAHnO1QbVr2DRzZo2idRbPIwo
	6UIXQ8TVvGBrnYsKH+Q9QDn+WFqqNT6pIpsm7SdFOY6bEcnSjqa8WouhXKzEN7gZiXT+H7
	3gh4gEIJ1A2FY7BMxktp8GKmdtztFSpo1SQ1vmisDKF6FIK5Y8xx3yWRFpfXwBOZ2tclBS
	4nfzOCmv91WFhV1AjIaQKGiTzqZz3PV9KBW+59MVLN+GXJio8USpBZTVMx6GVBvTvhXCnO
	E8zAothQCZQi11WXua/egPCYCi/IL448BY62XogA/F4XXuAO3Js0XH7MHrCH0w==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Mar 2026 10:57:51 +0100
Message-Id: <DH5TI2EOIWTC.3TJ6GASDIV232@bootlin.com>
Subject: Re: [PATCH net v2 2/2] net: macb: Protect access to
 net_device::ip_ptr with RCU lock
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Vineeth Karumanchi" <vineeth.karumanchi@amd.com>, "Harini Katakam"
 <harini.katakam@amd.com>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, <stable@vger.kernel.org>
To: "Kevin Hao" <haokexin@gmail.com>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260318-macb-irq-v2-0-f1179768ab24@gmail.com>
 <20260318-macb-irq-v2-2-f1179768ab24@gmail.com>
In-Reply-To: <20260318-macb-irq-v2-2-f1179768ab24@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227013-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,bootlin.com:email,bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4265B2B994C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Kevin,

On Wed Mar 18, 2026 at 7:36 AM CET, Kevin Hao wrote:
> Access to net_device::ip_ptr and its associated members must be
> protected by an RCU lock. Since we are modifying this piece of code,
> let's also move it to execute only when WAKE_ARP is enabled.
>
> To minimize the duration of the RCU lock, a local variable is used to
> temporarily store the IP address. This change resolves the following
> RCU check warning:
>   WARNING: suspicious RCU usage
>   7.0.0-rc3-next-20260310-yocto-standard+ #122 Not tainted
>   -----------------------------
>   drivers/net/ethernet/cadence/macb_main.c:5944 suspicious rcu_dereferenc=
e_check() usage!
>
>   other info that might help us debug this:
>
>   rcu_scheduler_active =3D 2, debug_locks =3D 1
>   5 locks held by rtcwake/518:
>    #0: ffff000803ab1408 (sb_writers#5){.+.+}-{0:0}, at: vfs_write+0xf8/0x=
368
>    #1: ffff0008090bf088 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_=
iter+0xbc/0x1c8
>    #2: ffff00080098d588 (kn->active#70){.+.+}-{0:0}, at: kernfs_fop_write=
_iter+0xcc/0x1c8
>    #3: ffff800081c84888 (system_transition_mutex){+.+.}-{4:4}, at: pm_sus=
pend+0x1ec/0x290
>    #4: ffff0008009ba0f8 (&dev->mutex){....}-{4:4}, at: device_suspend+0x1=
18/0x4f0
>
>   stack backtrace:
>   CPU: 3 UID: 0 PID: 518 Comm: rtcwake Not tainted 7.0.0-rc3-next-2026031=
0-yocto-standard+ #122 PREEMPT
>   Hardware name: ZynqMP ZCU102 Rev1.1 (DT)
>   Call trace:
>    show_stack+0x24/0x38 (C)
>    __dump_stack+0x28/0x38
>    dump_stack_lvl+0x64/0x88
>    dump_stack+0x18/0x24
>    lockdep_rcu_suspicious+0x134/0x1d8
>    macb_suspend+0xd8/0x4c0
>    device_suspend+0x218/0x4f0
>    dpm_suspend+0x244/0x3a0
>    dpm_suspend_start+0x50/0x78
>    suspend_devices_and_enter+0xec/0x560
>    pm_suspend+0x194/0x290
>    state_store+0x110/0x158
>    kobj_attr_store+0x1c/0x30
>    sysfs_kf_write+0xa8/0xd0
>    kernfs_fop_write_iter+0x11c/0x1c8
>    vfs_write+0x248/0x368
>    ksys_write+0x7c/0xf8
>    __arm64_sys_write+0x28/0x40
>    invoke_syscall+0x4c/0xe8
>    el0_svc_common+0x98/0xf0
>    do_el0_svc+0x28/0x40
>    el0_svc+0x54/0x1e0
>    el0t_64_sync_handler+0x84/0x130
>    el0t_64_sync+0x198/0x1a0
>
> Fixes: 0cb8de39a776 ("net: macb: Add ARP support to WOL")
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index 2d4304331e297accd91ab48813a9bd4722ce72dc..9856764402b17397928d0a61d=
a61865a3b10484f 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -5909,9 +5909,9 @@ static int __maybe_unused macb_suspend(struct devic=
e *dev)
>  	struct macb_queue *queue;
>  	struct in_device *idev;
>  	unsigned long flags;
> +	u32 tmp, ifa_local;
>  	unsigned int q;
>  	int err;
> -	u32 tmp;
> =20
>  	if (!device_may_wakeup(&bp->dev->dev))
>  		phy_exit(bp->phy);
> @@ -5920,14 +5920,21 @@ static int __maybe_unused macb_suspend(struct dev=
ice *dev)
>  		return 0;
> =20
>  	if (bp->wol & MACB_WOL_ENABLED) {
> -		/* Check for IP address in WOL ARP mode */
> -		idev =3D __in_dev_get_rcu(bp->dev);
> -		if (idev)
> -			ifa =3D rcu_dereference(idev->ifa_list);
> -		if ((bp->wolopts & WAKE_ARP) && !ifa) {
> -			netdev_err(netdev, "IP address not assigned as required by WoL walk A=
RP\n");
> -			return -EOPNOTSUPP;
> +		if (bp->wolopts & WAKE_ARP) {
> +			/* Check for IP address in WOL ARP mode */
> +			rcu_read_lock();
> +			idev =3D __in_dev_get_rcu(bp->dev);
> +			if (idev)
> +				ifa =3D rcu_dereference(idev->ifa_list);
> +			if (!ifa) {
> +				rcu_read_unlock();
> +				netdev_err(netdev, "IP address not assigned as required by WoL walk =
ARP\n");
> +				return -EOPNOTSUPP;
> +			}
> +			ifa_local =3D be32_to_cpu(ifa->ifa_local);
> +			rcu_read_unlock();
>  		}
> +
>  		spin_lock_irqsave(&bp->lock, flags);
> =20
>  		/* Disable Tx and Rx engines before  disabling the queues,
> @@ -5966,7 +5973,7 @@ static int __maybe_unused macb_suspend(struct devic=
e *dev)
>  		if (bp->wolopts & WAKE_ARP) {
>  			tmp |=3D MACB_BIT(ARP);
>  			/* write IP address into register */
> -			tmp |=3D MACB_BFEXT(IP, be32_to_cpu(ifa->ifa_local));
> +			tmp |=3D MACB_BFEXT(IP, ifa_local);
>  		}
>  		spin_unlock_irqrestore(&bp->lock, flags);
> =20

Even better to guard the RCU critical section inside a
`if (bp->wolopts & WAKE_ARP)` block.

Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


