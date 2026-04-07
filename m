Return-Path: <stable+bounces-233557-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBoXCZjg1GmsyQcAu9opvQ
	(envelope-from <stable+bounces-233557-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 12:46:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2D73AD251
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 12:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F4CA301FCF3
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 10:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B8C3A6EE0;
	Tue,  7 Apr 2026 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PsPBqULr"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35661387375;
	Tue,  7 Apr 2026 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558683; cv=none; b=UDs1MQpH8X3cEPdNiyQk077xqZJvfvgTpo6N68e2Gi6RGqyE2ebDfzk6LBmDOet+LltXLzJyEOY6nZYl4zeM4E7JY+cwzVcV3huFkze1icKUmLopETXr+FhX9tQPNFYZo5HkK1wLYXtz8/BpJTNUrDPUR5MBJguNad8z/NarJwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558683; c=relaxed/simple;
	bh=zlqzWiRDV+i9jeG0EtN+XSQhZf7vKxaMMEStaBafVA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+WP5SznJdBW8snUG2xTIZQdLIgZ7nvBc3svepjWs2uEJv4sEh58CrBsutLZKUKlU4ost1dsH+2OBYesPsor9rmKTw+xcZ7wKZERK3eKRmCOmk0cJY3tMxGcUnhBk4JVU86bOv8TRGd7x0+q5mq8Agw/gK8QZKamM7mKAHjnXd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PsPBqULr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i6yse3h/HGIT1p0OZ+14nS0s+pK4+TarczzM9oXEh3w=; b=PsPBqULr71zLOpPBzDjCqoXBCl
	vPr32cFT91RJcXQaovgJLPXRFR94t9lS2ZkIO9cVUFxaWhRJaEV+9wEZRTX29vzd5NDu3zSEGhEi1
	znAdYcFEj29M7YPsz/hgocu/oo6CMvvP6pgpmYgRerQmlcbODj2bjZZVxQ1GaIl0EKRw26Y0Yo27V
	FVho9x2J/9/cfyhmfftnYOPXRoUnPuUaKbtrabkSf15HOmZblNyu7RoAsTh/C7UEx52YrSs6fERzi
	Ct5JUQJZiIcKYyVjFwSbNlRNeqkALIgWjyzE/koi1AmJ2ubyTD5s9xUEHrFtZF5jZAVtO53gFLW87
	N8K84HmQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33614)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wA3vA-000000000o4-0dBD;
	Tue, 07 Apr 2026 11:44:36 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wA3v5-000000002CV-0AZM;
	Tue, 07 Apr 2026 11:44:31 +0100
Date: Tue, 7 Apr 2026 11:44:30 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: txgbe: fix RTNL assertion warning when
 remove module
Message-ID: <adTgDitn_CrJf113@shell.armlinux.org.uk>
References: <8B47A5872884147D+20260407094041.4646-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8B47A5872884147D+20260407094041.4646-1-jiawenwu@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233557-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.498];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,trustnetic.com:email,armlinux.org.uk:email,armlinux.org.uk:url,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: BA2D73AD251
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 05:40:41PM +0800, Jiawen Wu wrote:
> For the copper NIC with external PHY, the driver called
> phylink_connect_phy() during probe and phylink_disconnect_phy() during
> remove. It caused an RTNL assertion warning in phylink_disconnect_phy()
> upon module remove.
> 
> To fix this, add rtnl_lock() and rtnl_unlock() around the
> phylink_disconnect_phy() in remove function.
> 
>  ------------[ cut here ]------------
>  RTNL: assertion failed at drivers/net/phy/phylink.c (2351)
>  WARNING: drivers/net/phy/phylink.c:2351 at
> phylink_disconnect_phy+0xd8/0xf0 [phylink], CPU#0: rmmod/4464
>  Modules linked in: ...
>  CPU: 0 UID: 0 PID: 4464 Comm: rmmod Kdump: loaded Not tainted 7.0.0-rc4+
>  Hardware name: Micro-Star International Co., Ltd. MS-7E16/X670E GAMING
> PLUS WIFI (MS-7E16), BIOS 1.90 12/31/2024
>  RIP: 0010:phylink_disconnect_phy+0xe4/0xf0 [phylink]
>  Code: 5b 41 5c 41 5d 41 5e 41 5f 5d 31 c0 31 d2 31 f6 31 ff e9 3a 38 8f e7
> 48 8d 3d 48 87 e2 ff ba 2f 09 00 00 48 c7 c6 c1 22 24 c0 <67> 48 0f b9 3a
> e9 34 ff ff ff 66 90 90 90 90 90 90 90 90 90 90 90
>  RSP: 0018:ffffce7288363ac0 EFLAGS: 00010246
>  RAX: 0000000000000000 RBX: ffff89654b2a1a00 RCX: 0000000000000000
>  RDX: 000000000000092f RSI: ffffffffc02422c1 RDI: ffffffffc0239020
>  RBP: ffffce7288363ae8 R08: 0000000000000000 R09: 0000000000000000
>  R10: 0000000000000000 R11: 0000000000000000 R12: ffff8964c4022000
>  R13: ffff89654fce3028 R14: ffff89654ebb4000 R15: ffffffffc0226348
>  FS:  0000795e80d93780(0000) GS:ffff896c52857000(0000)
> knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00005b528b592000 CR3: 0000000170d0f000 CR4: 0000000000f50ef0
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   txgbe_remove_phy+0xbb/0xd0 [txgbe]
>   txgbe_remove+0x4c/0xb0 [txgbe]
>   pci_device_remove+0x41/0xb0
>   device_remove+0x43/0x80
>   device_release_driver_internal+0x206/0x270
>   driver_detach+0x4a/0xa0
>   bus_remove_driver+0x83/0x120
>   driver_unregister+0x2f/0x60
>   pci_unregister_driver+0x40/0x90
>   txgbe_driver_exit+0x10/0x850 [txgbe]
>   __do_sys_delete_module.isra.0+0x1c3/0x2f0
>   __x64_sys_delete_module+0x12/0x20
>   x64_sys_call+0x20c3/0x2390
>   do_syscall_64+0x11c/0x1500
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? do_syscall_64+0x15a/0x1500
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? do_fault+0x312/0x580
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? __handle_mm_fault+0x9d5/0x1040
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? count_memcg_events+0x101/0x1d0
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? handle_mm_fault+0x1e8/0x2f0
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? do_user_addr_fault+0x2f8/0x820
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? irqentry_exit+0xb2/0x600
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? exc_page_fault+0x92/0x1c0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Fixes: 02b2a6f91b90 ("net: txgbe: support copper NIC with external PHY")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

