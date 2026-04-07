Return-Path: <stable+bounces-233555-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCTqJt7f1GmZyQcAu9opvQ
	(envelope-from <stable+bounces-233555-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 12:43:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F283AD14B
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 12:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7A8D300F12E
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 10:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B926A3A9DAF;
	Tue,  7 Apr 2026 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R2HWbiOe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0A83ACF05;
	Tue,  7 Apr 2026 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558568; cv=none; b=rUO3VBfb09+Yio9g0FjC2i5359XYIONexgHet0kVs7R5x7juPguCx2SAHnlu6jHKgiSDZIDbEr4uovgegmNV9PkL8BvYTEQ6XFGSq6Fz6+R3kv6FmYfk/S95r+31afsUGp68ednceM1SFobG6yaSS4Whxm5AVlOvq43eQ2BLwuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558568; c=relaxed/simple;
	bh=Gbh+L9DmoMziiKxCfay/VTWnCT4itwq3mN59Ml42hA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quSK9pOtUM8QQonSvbmp1uJ8/3xvf3h2MmMPwabuzhK7jbH1LFHfQlgKJGRdKS5E9Kh9bE67+y0/5NDcy8cJZnM7AHLS3/UTjY5GYjCE6Q1m+z1IyC3g8gnv1qNGkt3EQ4Oq/VI6toTwjRhRNDG8bHk6MQQz7v3/+Wi2jlDvBy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R2HWbiOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F26EC19421;
	Tue,  7 Apr 2026 10:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775558567;
	bh=Gbh+L9DmoMziiKxCfay/VTWnCT4itwq3mN59Ml42hA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R2HWbiOepVdv0NY+QeHWExrYKaMCU3S5Ha8Chl3ac1BQQ9WjLf62BWEOb2biapL0P
	 8x0RBvQ1EvkK8kU38d5js0FTCaz2dOf0OnOmOTMM/f+VTvHmJwW5L0Ok6pLrUxNJlT
	 VbBdeuTFIGK+tNhdM0QaBMAdUWQ0FhOEdS/B5gIk=
Date: Tue, 7 Apr 2026 12:42:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kai Zen <kai.aizen.dev@gmail.com>
Cc: netdev@vger.kernel.org, edwin.peer@broadcom.com,
	Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	stable@vger.kernel.org, security@kernel.org
Subject: Re: [PATCH net] net: rtnetlink: zero ifla_vf_broadcast to avoid
 stack infoleak in rtnl_fill_vfinfo
Message-ID: <2026040759-whiny-tinker-c321@gregkh>
References: <CALynFi7k1Z7Vgr4p2=KH2-uWVntBRE5R+8uP=cds9_ihGqzOdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALynFi7k1Z7Vgr4p2=KH2-uWVntBRE5R+8uP=cds9_ihGqzOdQ@mail.gmail.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233555-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 53F283AD14B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 01:21:57PM +0300, Kai Zen wrote:
> rtnl_fill_vfinfo() declares struct ifla_vf_broadcast on the stack
> without initialisation:
> 
>     struct ifla_vf_broadcast vf_broadcast;
> 
> The struct contains a single fixed 32-byte field:
> 
>     /* include/uapi/linux/if_link.h */
>     struct ifla_vf_broadcast {
>             __u8 broadcast[32];
>     };
> 
> The function then copies dev->broadcast into it using dev->addr_len
> as the length:
> 
>     memcpy(vf_broadcast.broadcast, dev->broadcast, dev->addr_len);
> 
> On Ethernet devices (the overwhelming majority of SR-IOV NICs)
> dev->addr_len is 6, so only the first 6 bytes of broadcast[] are
> written. The remaining 26 bytes retain whatever was previously on
> the kernel stack. The full struct is then handed to userspace via:
> 
>     nla_put(skb, IFLA_VF_BROADCAST,
>             sizeof(vf_broadcast), &vf_broadcast)
> 
> leaking up to 26 bytes of uninitialised kernel stack per VF per
> RTM_GETLINK request, repeatable.
> 
> The other vf_* structs in the same function are explicitly zeroed
> for exactly this reason - see the memset() calls for ivi,
> vf_vlan_info, node_guid and port_guid a few lines above.
> vf_broadcast was simply missed when it was added.
> 
> The pattern used elsewhere in this file for the regular IFLA_BROADCAST
> attribute also avoids the issue by sending only dev->addr_len bytes
> rather than a fixed-size struct, but for IFLA_VF_BROADCAST the wire
> format is the fixed 32-byte struct, so the right fix is to zero the
> struct before the partial memcpy.
> 
> Reachability and impact
> -----------------------
> 
> The leak is reachable by any unprivileged local process. AF_NETLINK
> with NETLINK_ROUTE requires no capabilities. The only environmental
> requirement is that the host has at least one SR-IOV-capable
> interface present (a parent device with VFs), which is the common
> case for cloud, datacenter and HPC hosts.
> 
> Trigger: send RTM_GETLINK with an IFLA_EXT_MASK attribute whose
> value has the RTEXT_FILTER_VF bit set. The kernel will then walk
> each VF and emit IFLA_VFINFO_LIST, including IFLA_VF_BROADCAST,
> which carries the 26 bytes of uninitialised stack per VF.
> 
> Stack residue at this call site can include return addresses
> (useful as a KASLR / function-pointer disclosure primitive) and
> transient sensitive data left over by whatever ran on the same
> kernel stack just prior. KASAN with stack instrumentation, or
> KMSAN, will flag the nla_put() when reproduced.
> 
> Reproducer (unprivileged):
> 
>     import socket, struct
>     IFLA_EXT_MASK   = 29
>     RTEXT_FILTER_VF = 1
>     s = socket.socket(socket.AF_NETLINK, socket.SOCK_RAW,
>                       socket.NETLINK_ROUTE)
>     s.bind((0, 0))
>     hdr  = struct.pack('=IHHII', 0, 18, 0x301, 0, 0)
>     ifi  = struct.pack('=BxHiII', 0, 0, 0, 0, 0)
>     attr = (struct.pack('=HH', 8, IFLA_EXT_MASK) +
>             struct.pack('=I', RTEXT_FILTER_VF))
>     msg  = hdr + ifi + attr
>     msg  = struct.pack('=I', len(msg)) + msg[4:]
>     s.send(msg)
>     data = s.recv(65536)
>     # Parse IFLA_VF_BROADCAST from the response. Bytes 7..32 of the
>     # broadcast[] field are uninitialised kernel stack on Ethernet.
> 
> Fix
> ---
> 
> Zero the on-stack struct before the partial memcpy, matching the
> existing pattern used for the other vf_* structs in the same
> function.
> 
> Reported-by: Kai Aizen <kai.aizen.dev@gmail.com>
> Signed-off-by: Kai Aizen <kai.aizen.dev@gmail.com>
> ---
> 
> Note for reviewers: this is v1. I have not yet identified the
> exact introducing commit for the Fixes: tag and would appreciate
> a pointer, or I will resend as v2 once I have run git blame on a
> local checkout. The bug is present at least as far back as the
> introduction of struct ifla_vf_broadcast in net-next.
> 
>  net/core/rtnetlink.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -1572,6 +1572,7 @@ static noinline_for_stack int
> rtnl_fill_vfinfo(struct sk_buff *skb,
>                 port_guid.vf = ivi.vf;
> 
>         memcpy(vf_mac.mac, ivi.mac, sizeof(ivi.mac));
> +       memset(&vf_broadcast, 0, sizeof(vf_broadcast));
>         memcpy(vf_broadcast.broadcast, dev->broadcast, dev->addr_len);
>         vf_vlan.vlan = ivi.vlan;
>         vf_vlan.qos = ivi.qos;

Nice catch, but your patch is corrupted and can't be applied as the tabs
were converted to spaces and the commit is line-wrapped :(

With that fixed, feel free to resubmit and add:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

thanks,

greg k-h

