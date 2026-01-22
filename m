Return-Path: <stable+bounces-211220-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFLtMpwHcmmOagAAu9opvQ
	(envelope-from <stable+bounces-211220-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 12:18:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB9865E0A
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 12:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5271C78B743
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 11:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C8743D517;
	Thu, 22 Jan 2026 11:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrYERpjE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F2E43D516
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 11:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079822; cv=none; b=akNoIJVjBupZdScx8XgDBzrTm1ihZiWIYTSPAMXzKf1GnBLdNioZWx25rfgdaBuHZmMaeyiQSnHkUTrKssOgTzd+112qAurK1APALe3QOCjxh0P4/dK9A7vd3DqrW/uwdWblW9VhRaCuQm4FAAbolCm0LQBAyJ6wLjOnpsRIiZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079822; c=relaxed/simple;
	bh=WqHrSxYELgs13viFv0HHP2AYReCcWzShT8jf5s/+Ido=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMz22Qe9GoFbnnrrEbo5EFX/qj363b0drG8MtsVMDP2U5GXbl8csEmJopNP0XhJlMQdwtV6FxePEeLXbj2hJWm+AAqzxtp8l5Zp5TmvYvzXZga8EEpYwzgThL+rqO6ROG/bNmVoEgPXP9skoS33EzIYMxVh5RAUiYeeWPFONhPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrYERpjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62C0C116C6;
	Thu, 22 Jan 2026 11:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769079821;
	bh=WqHrSxYELgs13viFv0HHP2AYReCcWzShT8jf5s/+Ido=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=CrYERpjE+LvQpUPyp5Eiw+PSUyhmVwIPoVItsBa3nSxptcklVNkY6CEfnGSZebPKw
	 hNrRHM5mKOnWWI1hTHWMlLp+mzOkiN4kvNHUJHiWEbpvREmfgsx3kA7L2HLY5AoUAF
	 pSaE9hBVD5x9PBi4IKwexu9T0UjX2xwf+8+y6a/dhwna1P0mvhMYuUNbMTiwMwYuCm
	 VOKwcbUz9yQ7DXdapqTyDgzoKAySwDFAdTXriZeL9sdhgouDQn79Ks3lhw0a49bbY+
	 TdUmRvS1pxd8NOn/6WP0ve141xE96YLC3801dhLgj2B21q40xvBTgjmxKyg5oVph85
	 +Emucu8SzutCg==
Date: Thu, 22 Jan 2026 11:03:37 +0000
From: Lee Jones <lee@kernel.org>
To: stable@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	syzbot+7bfa4b72c6a5da128d32@syzkaller.appspotmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.6 1/1] bridge: mcast: Fix use-after-free during router
 port configuration
Message-ID: <20260122110337.GA3831112@google.com>
References: <20260119121726.1376464-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260119121726.1376464-1-lee@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211220-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable,7bfa4b72c6a5da128d32];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,nvidia.com:email,msgid.link:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 1AB9865E0A
X-Rspamd-Action: no action

Intentional top-post - quoting everything!

I see that the v6.12 version was applied and is now queued, however this
one still remains.  Was that intentional or was this missed?

> From: Ido Schimmel <idosch@nvidia.com>
> 
> The bridge maintains a global list of ports behind which a multicast
> router resides. The list is consulted during forwarding to ensure
> multicast packets are forwarded to these ports even if the ports are not
> member in the matching MDB entry.
> 
> When per-VLAN multicast snooping is enabled, the per-port multicast
> context is disabled on each port and the port is removed from the global
> router port list:
> 
>  # ip link add name br1 up type bridge vlan_filtering 1 mcast_snooping 1
>  # ip link add name dummy1 up master br1 type dummy
>  # ip link set dev dummy1 type bridge_slave mcast_router 2
>  $ bridge -d mdb show | grep router
>  router ports on br1: dummy1
>  # ip link set dev br1 type bridge mcast_vlan_snooping 1
>  $ bridge -d mdb show | grep router
> 
> However, the port can be re-added to the global list even when per-VLAN
> multicast snooping is enabled:
> 
>  # ip link set dev dummy1 type bridge_slave mcast_router 0
>  # ip link set dev dummy1 type bridge_slave mcast_router 2
>  $ bridge -d mdb show | grep router
>  router ports on br1: dummy1
> 
> Since commit 4b30ae9adb04 ("net: bridge: mcast: re-implement
> br_multicast_{enable, disable}_port functions"), when per-VLAN multicast
> snooping is enabled, multicast disablement on a port will disable the
> per-{port, VLAN} multicast contexts and not the per-port one. As a
> result, a port will remain in the global router port list even after it
> is deleted. This will lead to a use-after-free [1] when the list is
> traversed (when adding a new port to the list, for example):
> 
>  # ip link del dev dummy1
>  # ip link add name dummy2 up master br1 type dummy
>  # ip link set dev dummy2 type bridge_slave mcast_router 2
> 
> Similarly, stale entries can also be found in the per-VLAN router port
> list. When per-VLAN multicast snooping is disabled, the per-{port, VLAN}
> contexts are disabled on each port and the port is removed from the
> per-VLAN router port list:
> 
>  # ip link add name br1 up type bridge vlan_filtering 1 mcast_snooping 1 mcast_vlan_snooping 1
>  # ip link add name dummy1 up master br1 type dummy
>  # bridge vlan add vid 2 dev dummy1
>  # bridge vlan global set vid 2 dev br1 mcast_snooping 1
>  # bridge vlan set vid 2 dev dummy1 mcast_router 2
>  $ bridge vlan global show dev br1 vid 2 | grep router
>        router ports: dummy1
>  # ip link set dev br1 type bridge mcast_vlan_snooping 0
>  $ bridge vlan global show dev br1 vid 2 | grep router
> 
> However, the port can be re-added to the per-VLAN list even when
> per-VLAN multicast snooping is disabled:
> 
>  # bridge vlan set vid 2 dev dummy1 mcast_router 0
>  # bridge vlan set vid 2 dev dummy1 mcast_router 2
>  $ bridge vlan global show dev br1 vid 2 | grep router
>        router ports: dummy1
> 
> When the VLAN is deleted from the port, the per-{port, VLAN} multicast
> context will not be disabled since multicast snooping is not enabled
> on the VLAN. As a result, the port will remain in the per-VLAN router
> port list even after it is no longer member in the VLAN. This will lead
> to a use-after-free [2] when the list is traversed (when adding a new
> port to the list, for example):
> 
>  # ip link add name dummy2 up master br1 type dummy
>  # bridge vlan add vid 2 dev dummy2
>  # bridge vlan del vid 2 dev dummy1
>  # bridge vlan set vid 2 dev dummy2 mcast_router 2
> 
> Fix these issues by removing the port from the relevant (global or
> per-VLAN) router port list in br_multicast_port_ctx_deinit(). The
> function is invoked during port deletion with the per-port multicast
> context and during VLAN deletion with the per-{port, VLAN} multicast
> context.
> 
> Note that deleting the multicast router timer is not enough as it only
> takes care of the temporary multicast router states (1 or 3) and not the
> permanent one (2).
> 
> [1]
> BUG: KASAN: slab-out-of-bounds in br_multicast_add_router.part.0+0x3f1/0x560
> Write of size 8 at addr ffff888004a67328 by task ip/384
> [...]
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x6f/0xa0
>  print_address_description.constprop.0+0x6f/0x350
>  print_report+0x108/0x205
>  kasan_report+0xdf/0x110
>  br_multicast_add_router.part.0+0x3f1/0x560
>  br_multicast_set_port_router+0x74e/0xac0
>  br_setport+0xa55/0x1870
>  br_port_slave_changelink+0x95/0x120
>  __rtnl_newlink+0x5e8/0xa40
>  rtnl_newlink+0x627/0xb00
>  rtnetlink_rcv_msg+0x6fb/0xb70
>  netlink_rcv_skb+0x11f/0x350
>  netlink_unicast+0x426/0x710
>  netlink_sendmsg+0x75a/0xc20
>  __sock_sendmsg+0xc1/0x150
>  ____sys_sendmsg+0x5aa/0x7b0
>  ___sys_sendmsg+0xfc/0x180
>  __sys_sendmsg+0x124/0x1c0
>  do_syscall_64+0xbb/0x360
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> [2]
> BUG: KASAN: slab-use-after-free in br_multicast_add_router.part.0+0x378/0x560
> Read of size 8 at addr ffff888009f00840 by task bridge/391
> [...]
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x6f/0xa0
>  print_address_description.constprop.0+0x6f/0x350
>  print_report+0x108/0x205
>  kasan_report+0xdf/0x110
>  br_multicast_add_router.part.0+0x378/0x560
>  br_multicast_set_port_router+0x6f9/0xac0
>  br_vlan_process_options+0x8b6/0x1430
>  br_vlan_rtm_process_one+0x605/0xa30
>  br_vlan_rtm_process+0x396/0x4c0
>  rtnetlink_rcv_msg+0x2f7/0xb70
>  netlink_rcv_skb+0x11f/0x350
>  netlink_unicast+0x426/0x710
>  netlink_sendmsg+0x75a/0xc20
>  __sock_sendmsg+0xc1/0x150
>  ____sys_sendmsg+0x5aa/0x7b0
>  ___sys_sendmsg+0xfc/0x180
>  __sys_sendmsg+0x124/0x1c0
>  do_syscall_64+0xbb/0x360
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> Fixes: 2796d846d74a ("net: bridge: vlan: convert mcast router global option to per-vlan entry")
> Fixes: 4b30ae9adb04 ("net: bridge: mcast: re-implement br_multicast_{enable, disable}_port functions")
> Reported-by: syzbot+7bfa4b72c6a5da128d32@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/684c18bd.a00a0220.279073.000b.GAE@google.com/T/
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Link: https://patch.msgid.link/20250619182228.1656906-1-idosch@nvidia.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> (cherry picked from commit 7544f3f5b0b58c396f374d060898b5939da31709)
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  net/bridge/br_multicast.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index f42805d9b38f..4a2d94e8717e 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -2013,10 +2013,19 @@ void br_multicast_port_ctx_init(struct net_bridge_port *port,
>  
>  void br_multicast_port_ctx_deinit(struct net_bridge_mcast_port *pmctx)
>  {
> +	struct net_bridge *br = pmctx->port->br;
> +	bool del = false;
> +
>  #if IS_ENABLED(CONFIG_IPV6)
>  	del_timer_sync(&pmctx->ip6_mc_router_timer);
>  #endif
>  	del_timer_sync(&pmctx->ip4_mc_router_timer);
> +
> +	spin_lock_bh(&br->multicast_lock);
> +	del |= br_ip6_multicast_rport_del(pmctx);
> +	del |= br_ip4_multicast_rport_del(pmctx);
> +	br_multicast_rport_del_notify(pmctx, del);
> +	spin_unlock_bh(&br->multicast_lock);
>  }
>  
>  int br_multicast_add_port(struct net_bridge_port *port)
> -- 
> 2.52.0.457.g6b5491de43-goog
> 

-- 
Lee Jones [李琼斯]

