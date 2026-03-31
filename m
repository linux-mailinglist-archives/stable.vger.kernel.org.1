Return-Path: <stable+bounces-231420-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCNJCPbGy2mnLgYAu9opvQ
	(envelope-from <stable+bounces-231420-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:07:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D64AB369F01
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0231B30ABC95
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42073E3D87;
	Tue, 31 Mar 2026 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZZeccucj"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2BF3E3C7E;
	Tue, 31 Mar 2026 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774962033; cv=none; b=sKfvGIQJNCEX0MHx83GxfFf1qNGnA+RqjV0KuoMRsQExraYKanT9+yRhH+w2M1QHXzAyoYJntcflygbSGthlCmDHvlK0acMzMuEXRFKUatg1NvT3Z9D1uq5uicAzarzHcxehpG3m+cPlTwY8BZRfyUvga56fSWh1nJiFVip1vAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774962033; c=relaxed/simple;
	bh=Prx95567J6vzfyKVo56x6e9/hbD35R8iDrHSkAFtEUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhNMjcT6lCZ+BIvW4wy6g0aJLGiUhNdgNTat0N8rGvhpfRY+87cD/mt8kRJZUXhBkokI/XDpKA9/nL1CFVQWpOgC26+1b6booUCOPufPv/BDCktm/F61k1ZzN2CJaFx642YPIdrIJazpkWBZ+DitlLpF/zqLn9SceaY/xL1kWHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZZeccucj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=x17+fCZEiea6rkhwqYIBLlsTRs919T9DlcGeN53lTHA=; b=ZZeccucjd5ldAJfs08c+KQjUyp
	WutXtC30t1z5C1EwkOVmg+ALb0JYTmsdf6eDlXQsuMn5gtt573mPJt0Hz9uWEjfFxZFGnHi4IEk56
	DyacgvFKDJagFIwYB2NXSzoUj2ssxJJLauWtnlVXKrgu1bdeOX+7YlU07Z7PEBk3hOOg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w7Yhd-00ECKF-96; Tue, 31 Mar 2026 15:00:17 +0200
Date: Tue, 31 Mar 2026 15:00:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] net: txgbe: fix RTNL assertion warning when remove
 module
Message-ID: <cc91b8ab-bbc3-46c9-91bd-05c7456eaaf2@lunn.ch>
References: <D56A7C3379B4DA62+20260331071107.5414-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D56A7C3379B4DA62+20260331071107.5414-1-jiawenwu@trustnetic.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231420-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,intel.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustnetic.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D64AB369F01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 03:11:07PM +0800, Jiawen Wu wrote:
> For the copper NIC with external PHY, the driver called
> phylink_connect_phy() during probe and phylink_disconnect_phy() during
> remove. It caused an RTNL assertion warning in phylink_disconnect_phy()
> upon module remove.
> 
> To fix this, move the phylink connect/disconnect PHY to ndo_open/close.
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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

