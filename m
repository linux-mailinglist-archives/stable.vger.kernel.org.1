Return-Path: <stable+bounces-154559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC749ADDABB
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973F517E5F1
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38590285053;
	Tue, 17 Jun 2025 17:32:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CD521B908;
	Tue, 17 Jun 2025 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750181539; cv=none; b=H+alw4fxX/xB7mR5uqffOjj+k64JqGn5SDF66vmxfhrFG6+MqPrPHVsL1ILXmEVYWyML+MA3rZuBJDQMuoyXEJDu7wsugWruA5K70zjpE7/75ikFP2+6U/+vGNzZJzUnhokwt8AKmkSPppl84n5hWJYIDt6oWYRcO1MsSZAAifY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750181539; c=relaxed/simple;
	bh=nOZFmNg/zam/ue9ID6LjAg/a2m3VPHr+sptwqmLXb28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/LjlYUVJsREZcQ3y/2x0t3x4rZBppyTNF87GGjWwCXGjYdr3zADhN9Ga/u+9/zdoiYJEIXSgEV/Bo8QSY89VuI7pqz5mnU+z/D4c57/MsyRMpKuc+pvWWWwRU3T533bN+c/HxECT3vI13svmsyC7LeiNQz6US8bvuu6RjUY8Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=gladserv.com; arc=none smtp.client-ip=185.128.210.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gladserv.com
Received: from [2a0c:e303:0:7000:1adb:f2ff:fe4f:84eb] (port=35194 helo=localhost)
	by bregans-0.gladserv.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(envelope-from <brett@gladserv.com>)
	id 1uRa7p-00875S-2Y;
	Tue, 17 Jun 2025 17:29:33 +0000
Date: Tue, 17 Jun 2025 19:29:30 +0200
From: Brett Sheffield <brett@librecast.net>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Brett Sheffield <bacs@librecast.net>, stable@vger.kernel.org,
	regressions@lists.linux.dev, Willem de Bruijn <willemb@google.com>
Subject: Re: 6.12.y longterm regression - IPv6 UDP packet fragmentation
Message-ID: <aFGl-mb--GOMY8ZQ@karahi.gladserv.com>
References: <aElivdUXqd1OqgMY@karahi.gladserv.com>
 <2025061745-calamari-voyage-d27a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ObJCLKYiRzFilIKD"
Content-Disposition: inline
In-Reply-To: <2025061745-calamari-voyage-d27a@gregkh>
Organisation: Gladserv Limited.  Registered in Scotland with company number SC318051. Registered Office 272 Bath Street, Glasgow, G2 4JR, Scotland. VAT Registration Number 902 6097 39.


--ObJCLKYiRzFilIKD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg,

On 2025-06-17 15:47, Greg KH wrote:
> On Wed, Jun 11, 2025 at 01:04:29PM +0200, Brett Sheffield wrote:
> > Longterm kernel 6.12.y backports commit:
> > 
> > - a18dfa9925b9ef6107ea3aa5814ca3c704d34a8a "ipv6: save dontfrag in cork"
> 
> It's also in older kernels:
> 	5.10.238
> 	5.15.185
> 	6.1.141
> 	6.6.93
> 
> > but does not backport these related commits:
> > 
> > - 54580ccdd8a9c6821fd6f72171d435480867e4c3 "ipv6: remove leftover ip6 cookie initializer"
> > - 096208592b09c2f5fc0c1a174694efa41c04209d "ipv6: replace ipcm6_init calls with ipcm6_init_sk"
> > 
> > This causes a regression when sending IPv6 UDP packets by preventing
> > fragmentation and instead returning EMSGSIZE. I have attached a program which
> > demonstrates the issue.
> 
> Should we backport thse two to all of the other branches as well?

I have confirmed the regression is present in all of those older kernels (except
5.15.185 as that didn't boot on my test hardware - will look at that later).

The patch appears to have been autoselected for applying to the stable tree:

https://lore.kernel.org/all/?q=a18dfa9925b9ef6107ea3aa5814ca3c704d34a8a

The patch follows on from a whole series of patches by Willem de Bruijn (CC), the
rest of which were not applied.

Unless there is a good reason for applying this patch in isolation, the quickest
fix is simply to revert that commit in stable and this fixes the regression.

Alternatives are:

1) apply a small fix for the regression (patch attached). This leaves a footgun
if you later decide to backport more of the series.

2) to backport and test the whole series of patches. See merge commit
aefd232de5eb2e77e3fc58c56486c7fe7426a228

3) In the case of 6.12.33, the two patches I referenced apply cleanly and are enough
to fix the problem.  There are conflicts on the other branches.

Unless there is a specific reason to have backported
a18dfa9925b9ef6107ea3aa5814ca3c704d34a8a to stable I'd suggest just reverting
it.

Cheers,


Brett
-- 
Brett Sheffield (he/him)
Librecast - Decentralising the Internet with Multicast
https://librecast.net/
https://blog.brettsheffield.com/

--ObJCLKYiRzFilIKD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-ipv6-fix-udp-fragmentation.patch"

From e5f970aa0e14471f0a8e6225705033219b63e4da Mon Sep 17 00:00:00 2001
From: Brett A C Sheffield <bacs@librecast.net>
Date: Tue, 17 Jun 2025 16:53:08 +0000
Subject: [PATCH] ipv6: fix udp fragmentation

A regression was introduced when backporting commit
a18dfa9925b9ef6107ea3aa5814ca3c704d34a8a to the stable kernels without
applying previous commits in this series.

When sending IPv6 UDP packets larger than MTU, EMSGSIZE was returned
instead of fragmenting the packets as expected.

Fixes: c1502fc84d1c65e17ba25fcde1c52cbe52f79157
---
 net/ipv6/ip6_output.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 89a61e040e6a..82786e957f72 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1386,7 +1386,6 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	}
 	v6_cork->hop_limit = ipc6->hlimit;
 	v6_cork->tclass = ipc6->tclass;
-	v6_cork->dontfrag = ipc6->dontfrag;
 	if (rt->dst.flags & DST_XFRM_TUNNEL)
 		mtu = READ_ONCE(np->pmtudisc) >= IPV6_PMTUDISC_PROBE ?
 		      READ_ONCE(rt->dst.dev->mtu) : dst_mtu(&rt->dst);

base-commit: e03ced99c437f4a7992b8fa3d97d598f55453fd0
-- 
2.49.0


--ObJCLKYiRzFilIKD--

