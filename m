Return-Path: <stable+bounces-223253-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BjSHFqvqWn/CQEAu9opvQ
	(envelope-from <stable+bounces-223253-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 17:29:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B532156C2
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 17:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CA5F3039085
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 16:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6633D3484;
	Thu,  5 Mar 2026 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZFtWMKES"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D143D3CFD
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772728134; cv=none; b=RgITYUGSXnABCOLNZHOcS0fGyKBT9sHH4Wdv2+8epqk6+k79pXdEQST17eCLEHdMbSWFWavzGm6ZGTmEasKJMfGRvE+mE4UUzDnNRhxt/d2MQBvkUqQvA9T0uHFYLRR7UfWQUYFeex77NP9dYZi1mOVU1a0OqzKY/vOfG6uzofU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772728134; c=relaxed/simple;
	bh=UJMMueYGnDPFysL0784GHRpRLCeFirY/pdilXRWklJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ue+JmTwdpJrPCLM0FPI+l2/3w6HZXgq/u5/KRXiqf6fQ660eTSLSyDQEm5ytP/stKKVD0kczsU9SUUnbzlHsL7eIfZFLnBMoAwHCoCmyFXZdT3DipzpeNUxOzzo7fCiaTTrP+1Akzm0xT0S+iGV9nuVyiBtTbP5FkMuWTBbiqSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZFtWMKES; arc=none smtp.client-ip=209.85.161.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-66ee7b9af94so3498272eaf.0
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 08:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772728132; x=1773332932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tlPMcv6N3Y/+mWnEMF2Wqs2gvjIQxxbuY5gzr6wMqo0=;
        b=ZFtWMKES8WGY9JO0S57zavAwnKZuQcZV8iQNyA+6conQmNulNB37T8OM8Y0WKGJogf
         0gSd6grmkXdad2HhmNbW+oO3CVpsEi3EnDMfzf60pawyzzpbXz76sMmcSoZ6ixw+Nxrb
         irg27qWGbryHE88tNgstWC2SDBn//lcwP+CaEUbMiRhuoflwOouG3e3ku5gGJ8b7mybK
         aySWe1fGDcV/XwbSkM08TEOOwRYo7MDHmq0rObC2TSoHu45I/r8fsivLdZOeMclewBT1
         X1lqAKbjv7wYO9bIn39PbPlvD4sNBnMns6KWyClPsJf5XCC46Tu4bjY27QarVLSv5S6R
         RMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772728132; x=1773332932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlPMcv6N3Y/+mWnEMF2Wqs2gvjIQxxbuY5gzr6wMqo0=;
        b=KflgVZ0tzxwte2ysL3g+lUPXGbxDZqTuZYnOznNkafLX/kPHjvHq0TnHOM5iQOOzVs
         IFYDY0yCuKPbTWvcsnz7l0kBw7laUvAHqsLUS2qi5I8IXyg3cty3p4oM3VVgl92ujlHo
         2Pvydm5NGxAHZAnk/GXU9yecyDybDx/1bwAXXOaDyBrzXMrtPL2GbEgPK2Qo1lfL/rOW
         FBYytH+KJfnbVjy5hOgmrHpNwleNLuQZfwcUQnA3s52OyEx4PyJZi2ebCDBupROLGppG
         6hMuGLJR4s4NZw68DhDc3UPeSXxswY+IKth52XYIKCkykeeRbm0j6U71kchybSxxIQ8X
         U0DA==
X-Forwarded-Encrypted: i=1; AJvYcCWkJJwIZw4qE1z//7Yc3MB0NeR6+JEVMufApKUci8E7XpNrVpP60RWwIPN5m2xxhYloWBr4U6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN0aen+nbwOH1HtUCFdG0c+uuVAUZwIFyRzvQq8vnRXe/np/AH
	P0WDOgKHE+adlz+4A3YCKyZgXSrjoh8oh4TbH/qNy1wtjbe5d2zkrzTLcrFsrSmx22A=
X-Gm-Gg: ATEYQzze8e8TwHzJlSlvueN0tShFP3HAvEWlTvsD7pt0EkaJRdv/tFfkP1koXLUYB+d
	zI+WlzuZUraIet61Ffq22CkhKpqt1n9FJMkLqDBjXK4rpKRc64NeUUi2tlTqkyi+rnPKWywgC5f
	scnMkXDkL069N2rvB0WlUyNFn+SNwCR1KWBH87jfoWIIhO+hjXSZhEd7D5N1F9wN7sZ8d0fY2yL
	Y8OHMUtuIXua6ThbhSlxAqPejSb4/p+hmxSMHB3wCCYqbUNXbqqSUydGfIS6VUCzOBmQvt2VD8o
	mOjzR5f/4QbgQjul5Bw8KIrFLtPke9sHlm7fhL93W4sVDILjYKP9wsbW54UWyxILWtxIeLIo2o9
	wx/arjuxVgS+hHPzetO7xCmNcZ2hiKIDufeXiMJUw9QKgypMSmHzy6fGaRvYdDJaO25uPBhfDPg
	kTaPfHuw==
X-Received: by 2002:a05:6820:4cc7:b0:678:1970:b69e with SMTP id 006d021491bc7-67b1e9252d7mr3400958eaf.69.1772728132078;
        Thu, 05 Mar 2026 08:28:52 -0800 (PST)
Received: from 20HS2G4 ([2a09:bac1:76c0:540::3ce:23])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67a201e1fa4sm5438444eaf.4.2026.03.05.08.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 08:28:51 -0800 (PST)
Date: Thu, 5 Mar 2026 10:28:49 -0600
From: Chris Arges <carges@cloudflare.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lwn@lwn.net,
	jslaby@suse.cz, kernel-team@cloudflare.com,
	netfilter-devel@vger.kernel.org
Subject: Re: [REGRESSION] 6.18.14 netfilter/nftables consumes way more memory
Message-ID: <aamvQTTZu4-chpsS@20HS2G4>
References: <aahw_h5DdmYZeeqw@20HS2G4>
 <aaijcrM5Ke5-Zabx@chamomile>
 <aaij0XAgYRN40QdD@chamomile>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaij0XAgYRN40QdD@chamomile>
X-Rspamd-Queue-Id: 17B532156C2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-8.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	TAGGED_FROM(0.00)[bounces-223253-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,cloudflare.com:dkim]
X-Rspamd-Action: no action

On 2026-03-04 22:27:45, Pablo Neira Ayuso wrote:
> Resending, your Reply-To: is botched.
> 
> -o-
> 

I noticed after I sent, thanks for fixing.
> Hi,
> 
> On Wed, Mar 04, 2026 at 11:50:54AM -0600, Chris Arges wrote:
> > Hello,
> > 
> > We've noticed significant slab unreclaimable memory increase after upgrading
> > from 6.18.12 to 6.18.15. Other memory values look fairly close, but in my
> > testing slab unreclaimable goes from 1.7 GB to 4.9 GB on machines.
> 
> From where are you collecting these memory consumption numbers?
> 

These numbers come from the cgroup's memory.stat:
```
$ cat /sys/fs/cgroup/path/to/service/memory.stat | grep slab
slab_reclaimable 35874232
slab_unreclaimable 5343553056
slab 5379427288
```

> > Our use case is having nft rules like below, but adding them to 1000s of
> > network namespaces. This is essentially running `nft -f` for all these
> > namespaces every minute.
> 
> Those numbers for only 1000? That is too little number of entries for
> such increase in memory usage that you report.
> 

For this workload that I suspect (since its in the cgroup) it has the following
characteristics:
- 1000s of namespaces
- 1000s of CIDRs in ip list per namespace
- Updating everything frequently (<1m)

> > ```
> > table inet service_1234567 {
> > }
> > delete table inet service_1234567
> > table inet service_1234567 {
> > 	chain input {
> > 		type filter hook prerouting priority filter; policy accept;
> > 		ip saddr @account.ip_list drop
> > 	}
> > 	set account.ip_list {
> > 		type ipv4_addr
> > 		flags interval
> > 		auto-merge
> > 	}
> > }
> > add element inet service_1234567 account.ip_list { /* add 1000s of CIDRs here */ }
> > ```
> > 
> > I suspect this is related to:
> > - 36ed9b6e3961 (upstream 7e43e0a1141deec651a60109dab3690854107298)
> > - netfilter: nft_set_rbtree: translate rbtree to array for binary search
> 
> More memory consumption is expected indeed, but not so much as you are
> reporting.
> 
> > I'm still digging into this, and plan on reverting commits and seeing if memory
> > usage goes back to nominal in production. I don't have a trivial
> > reproducer unfortunately.
> 
> The extra memory comes from the array allocation, the relevant code
> is here:
> 
> #define NFT_ARRAY_EXTRA_SIZE    10240 
>  
> /* Similar to nft_rbtree_{u,k}size to hide details to userspace, but consider
>  * packed representation coming from userspace for anonymous sets too.
>  */     
> static u32 nft_array_elems(const struct nft_set *set)
> 
> > Happy to run some additional tests, and I can easily apply patches on top of
> > linux-6.18.y to run in a test environment.
> 
> I would need need more info to propose a patch, I don't know where you
> are pulling such numbers. You also mention you have no reproducer.
> 
To clarify this issue _is_ happening in our production environments, so I can
reproduce this issue there. It only happened when going from 6.18.12 to
6.18.15, and with a service inside a cgroup that is mostly applying large sets
of IPs via nft. I do not have a simple reproducer script or something I can
easily share yet, but am working on that.

I'm going to try and revert rbtree patch series locally and see if it still
happens. I can also play with NFT_ARRAY_EXTRA_SIZE and see if that is a factor
here as well.

> > We are using userspace nftables 1.1.3, but had to apply the patch mentioned
> > in this thread: https://lore.kernel.org/all/e6b43861cda6953cc7f8c259e663b890e53d7785.camel@sapience.com/
> > In order to solve the other regression we encountered.
> 
> Yes, there are plans to revert a kernel patch that went in -stable to
> address this.

Thanks.
--chris

