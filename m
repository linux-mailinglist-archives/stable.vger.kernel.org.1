Return-Path: <stable+bounces-244372-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7GzdFiMt+2npXAMAu9opvQ
	(envelope-from <stable+bounces-244372-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 13:59:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EA24D9E93
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 13:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F31E300CBEC
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 11:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A20425CE0;
	Wed,  6 May 2026 11:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXL7brst"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA86423A63
	for <stable@vger.kernel.org>; Wed,  6 May 2026 11:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778068768; cv=none; b=JLFo4MaKbGalrI0ZLiU/haoVAZBy2LyoTvC3dSCbcLZzIBu6VEec2yxyz2iMoJPbNKNxGhCY2650nCt9OVoNDWIgG9Y8IZeoO5eN7XLAB1TSfoRDYQ5b9wwoMWDk6lyjmBuJEL6mA8eDtXUJ9T6JgLIte9XaKLuZrqlgie1gSMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778068768; c=relaxed/simple;
	bh=xHc7Zk3mmDEHbxM4JKMp/TCJCFrVAIN0Y2hGXlieP3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0rUH2gRM9wv5HxQ8JcvJnuVdgZpeiqmOVc0aGtLwFe6cTWYMuHPKKQ5EV+Q8oHKvgHnhsXLjbYlW0g6NXWRTkUEzRnmEH22em26nge80NJJV9q9kEEIhPneCIu1Keaj05UUCjp+QUIEAFshN5JXl6z5iZ30q7aA2LA9omuMa4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXL7brst; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67c566cb519so7325844a12.3
        for <stable@vger.kernel.org>; Wed, 06 May 2026 04:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778068765; x=1778673565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQQTGBtZyiS4rIIJ3i5+BNSBYcIZsOX/J7USR2xECXE=;
        b=aXL7brstZgk89FihBhGPjZqG12z/LZYTr8ekeHrLnDx369Z7xbGOuKCkBxIaM37tyR
         eWA04xYG27DUbnHt2pTslSHT55y000z4iRKkmR5TSsKjlljeB3D9ZgIVqPOZU0vYIfao
         6Tv5Z8W9ceLeXe/Pljn6WWeykNrvtf1rHLrFhShtMfsh6dGAuKkA0uz9yToi71epDi4M
         faKWG/DrWNJD7J4WEakfCrgFpxr32gYqiQ9YbhUrvwsCmmLdyc8/MnH1R1mUTS2WfmYP
         gkFCcfjyL2TUjUKwe/lsQneqwnhahEFlKKiIGRB4XwvYntJBCr2hSoAnx6T5MLUdUFJX
         T0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778068765; x=1778673565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hQQTGBtZyiS4rIIJ3i5+BNSBYcIZsOX/J7USR2xECXE=;
        b=j1I7VKYkVq3xFIyAWGS8+XohASbIYETINWaoyKSU6X+iSx03dOe30v18W1kiqv/j69
         rJgIgXLycpszqrWQa3/g2j0xI8nKQ1KvjK22HakGSrnDvDFmDLyKOcBY7boMC+NAYfcQ
         NWXk88/TE/+w/DY2aigYWIywLi2VlUKvJNEVbGBtpSpM3f234fnDtKbCNG++VP9OH1e5
         h+FOLYyXqyIMeAmJeiq36vPr1BvYRj3DtDL/X7Z7jlTmnZKv/nq0tLpvYJ7YvxVTIOj2
         vTVSoCFJYGd8ntgXQt6NMTiO70mu2+x7sV3BOQnHqIxCw+qpMhUTg//OamUjnH4ZrBNY
         jdFQ==
X-Gm-Message-State: AOJu0YxTl/EgNQqNEmO7tqRsQcsD4oozDGtAACoPOfblIBfVGllpv267
	vrAVDqq6YPTfTwutxicPkF9iKF+Y4fmIzcNiCa3M5yCW+Hi4rHicW7Zu
X-Gm-Gg: AeBDietNqZv6Rop0YGSh8hiUqKuKmW03oSmGdkhNiP97gk/74+hffc0YzBVSRmRWsYk
	nwpT/Dw8/MITc90GHuaGA1xLuxYKxzrGItBkfBSnDABc4z+AkQkm6iDxaSNIR6O06rSmUeSzP74
	JvTS4tgKrPVA9F0H4UWc2L2nalVuddxkA8ak8hKaxSYGafWgGoduiDaXU1Uicjpp1BQErwZmJ7U
	2ma1Kdxbdooplu0MvWiviSw+xHtPjvrWWKetWaYQPbIr0gF8eBe5XxeCq/Jn+BdfznSrdT+xSuc
	RVnIefD2XAOHm2JtLnP3s2/ucDbeW2S6HxLRGsqjdOBWy7j+vfOhN+4WqkENJ4+Y336YucUHP4Y
	1pL7rzsopbuMyfnx0Fut+EIZM49f7weD87YI98cddAzLH+e+wyWd3cVoKea+vh6XsF7kBBMVNkO
	GT3Qz0Vz0qDH1l3CQ1WBN27Q2NOe0=
X-Received: by 2002:a17:907:e145:10b0:bc1:6ec9:453e with SMTP id a640c23a62f3a-bc56e5fe9ccmr123299466b.42.1778068764735;
        Wed, 06 May 2026 04:59:24 -0700 (PDT)
Received: from eldamar.lan ([2a03:2267:2:0:f6dc:4d65:9edb:6ecf])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67cd91bc5b0sm1360019a12.23.2026.05.06.04.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 04:59:23 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id ACF9ABE2EE7; Wed, 06 May 2026 13:59:22 +0200 (CEST)
Date: Wed, 6 May 2026 13:59:22 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: stable@vger.kernel.org, Dong Chenchen <dongchenchen2@huawei.com>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y] net: Fix icmp host relookup triggering ip_rt_bug
Message-ID: <afstGv1ONT3iKbGZ@eldamar.lan>
References: <20260506012057.285743-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506012057.285743-1-jiayuan.chen@linux.dev>
X-Rspamd-Queue-Id: A8EA24D9E93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[debian.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244372-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carnil@debian.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]

Hi,

On Wed, May 06, 2026 at 09:20:57AM +0800, Jiayuan Chen wrote:
> From: Dong Chenchen <dongchenchen2@huawei.com>
> 
> [ Upstream commit c44daa7e3c73229f7ac74985acb8c7fb909c4e0a ]
> 
> arp link failure may trigger ip_rt_bug while xfrm enabled, call trace is:
> 
> WARNING: CPU: 0 PID: 0 at net/ipv4/route.c:1241 ip_rt_bug+0x14/0x20
> Modules linked in:
> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc6-00077-g2e1b3cc9d7f7
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> RIP: 0010:ip_rt_bug+0x14/0x20
> Call Trace:
>  <IRQ>
>  ip_send_skb+0x14/0x40
>  __icmp_send+0x42d/0x6a0
>  ipv4_link_failure+0xe2/0x1d0
>  arp_error_report+0x3c/0x50
>  neigh_invalidate+0x8d/0x100
>  neigh_timer_handler+0x2e1/0x330
>  call_timer_fn+0x21/0x120
>  __run_timer_base.part.0+0x1c9/0x270
>  run_timer_softirq+0x4c/0x80
>  handle_softirqs+0xac/0x280
>  irq_exit_rcu+0x62/0x80
>  sysvec_apic_timer_interrupt+0x77/0x90
> 
> The script below reproduces this scenario:
> ip xfrm policy add src 0.0.0.0/0 dst 0.0.0.0/0 \
> 	dir out priority 0 ptype main flag localok icmp
> ip l a veth1 type veth
> ip a a 192.168.141.111/24 dev veth0
> ip l s veth0 up
> ping 192.168.141.155 -c 1
> 
> icmp_route_lookup() create input routes for locally generated packets
> while xfrm relookup ICMP traffic.Then it will set input route
> (dst->out = ip_rt_bug) to skb for DESTUNREACH.
> 
> For ICMP err triggered by locally generated packets, dst->dev of output
> route is loopback. Generally, xfrm relookup verification is not required
> on loopback interfaces (net.ipv4.conf.lo.disable_xfrm = 1).
> 
> Skip icmp relookup for locally generated packets to fix it.
> 
> Fixes: 8b7817f3a959 ("[IPSEC]: Add ICMP host relookup support")
> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Link: https://patch.msgid.link/20241127040850.1513135-1-dongchenchen2@huawei.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> 
> ---
> failed backport
> https://lore.kernel.org/stable/20250207161555-b1a8749027831a1a@stable.kernel.org/T/#m0c880c1f04f7211aea9b7f6b4de0b64aa1726417
> ---
>  net/ipv4/icmp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index d5d745c3e345..737e6caad716 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -509,6 +509,9 @@ static struct rtable *icmp_route_lookup(struct net *net,
>  	if (!IS_ERR(rt)) {
>  		if (rt != rt2)
>  			return rt;
> +		if (inet_addr_type_dev_table(net, route_lookup_dev,
> +					     fl4->daddr) == RTN_LOCAL)
> +			return rt;
>  	} else if (PTR_ERR(rt) == -EPERM) {
>  		rt = NULL;
>  	} else
> -- 
> 2.43.0

This fixes the problem reported in Debian as
https://bugs.debian.org/1135514

Tested-by: Salvatore Bonaccorso <carnil@debian.org>

Regards,
Salvatore

