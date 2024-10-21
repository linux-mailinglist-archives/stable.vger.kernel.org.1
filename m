Return-Path: <stable+bounces-87592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1F89A6F2F
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 18:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C0E3B2199B
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 16:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D513178395;
	Mon, 21 Oct 2024 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="m6+i9IFO"
X-Original-To: stable@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D58C405FB
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729527427; cv=none; b=li9a+Tr3vO0YcXuJBzmI2+Myzp52ymhuKWRXkNK9fQ9ZI5ca4kdpElWtTub9cg+UcMK23tmG+Z+jOhLB+GcrTZMDNQNQ8GykiCOhluC1OMTs5QlxADnPemA1ALu1Yox2ZLcvSWa27Sw50/P+VRQVwJeh+/p3CAgC6D62Axonqcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729527427; c=relaxed/simple;
	bh=WgoboZvhZ6u1huV9+RG2MfL4m/H0UopAC5srv0brp5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNGY7SaM4ZbEtka0AJR5+7+YfFlb3CUo9ul7ojJVRlP+4/xJ9Wpl2porVO9KUYGWBeVQ7+bg1XEBkV1GepyO5HbPyVQJRgLQvczGIuM9ziIFph06GKKwG4D8IAi+uyTmFrufIc6DNPa42mTnIDMtfTXnMI7qgldD6r493GANeqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=m6+i9IFO; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id EACAE2C24DD
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 16:16:53 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 90654B8008F;
	Mon, 21 Oct 2024 16:16:44 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 05E8F13C2B0;
	Mon, 21 Oct 2024 09:16:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 05E8F13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1729527404;
	bh=WgoboZvhZ6u1huV9+RG2MfL4m/H0UopAC5srv0brp5U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m6+i9IFOjDfTk0ueOjvusZELdzapGfrbpCJq5g1WKTy36MLjC0I71tmWoFWbCIQqH
	 MLu7pSAb27lZa284fbcLq7jVmOfWqvEONnkG/oWeRBeFba9x/CRxT1OdBaVAdWFrGl
	 dDxizky4Iht8EeKmRPB1jDjWRXMs5VWWTwFkJMb0=
Message-ID: <a4163f51-cc1a-0848-d0fd-e9b94dafc306@candelatech.com>
Date: Mon, 21 Oct 2024 09:16:43 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6.11 024/135] lib: alloc_tag_module_unload must wait for
 pending kfree_rcu calls
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Florian Westphal <fw@strlen.de>,
 Uladzislau Rezki <urezki@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20241021102259.324175287@linuxfoundation.org>
 <20241021102300.282974151@linuxfoundation.org>
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20241021102300.282974151@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1729527406-z74ek1Q30KBM
X-MDID-O:
 us5;ut7;1729527406;z74ek1Q30KBM;<greearb@candelatech.com>;60288392067775ecebc71e116bf8ca95
X-PPE-TRUSTED: V=1;DIR=OUT;

On 10/21/24 03:23, Greg Kroah-Hartman wrote:
> 6.11-stable review patch.  If anyone has any objections, please let me know.

This won't compile in my 6.11 tree (as of last week), I think it needs more
upstream patches and/or a different work-around.

Possibly that has already been backported into 6.11 stable and I just haven't
seen it yet.

Thanks,
Ben

> 
> ------------------
> 
> From: Florian Westphal <fw@strlen.de>
> 
> commit dc783ba4b9df3fb3e76e968b2cbeb9960069263c upstream.
> 
> Ben Greear reports following splat:
>   ------------[ cut here ]------------
>   net/netfilter/nf_nat_core.c:1114 module nf_nat func:nf_nat_register_fn has 256 allocated at module unload
>   WARNING: CPU: 1 PID: 10421 at lib/alloc_tag.c:168 alloc_tag_module_unload+0x22b/0x3f0
>   Modules linked in: nf_nat(-) btrfs ufs qnx4 hfsplus hfs minix vfat msdos fat
> ...
>   Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
>   RIP: 0010:alloc_tag_module_unload+0x22b/0x3f0
>    codetag_unload_module+0x19b/0x2a0
>    ? codetag_load_module+0x80/0x80
> 
> nf_nat module exit calls kfree_rcu on those addresses, but the free
> operation is likely still pending by the time alloc_tag checks for leaks.
> 
> Wait for outstanding kfree_rcu operations to complete before checking
> resolves this warning.
> 
> Reproducer:
> unshare -n iptables-nft -t nat -A PREROUTING -p tcp
> grep nf_nat /proc/allocinfo # will list 4 allocations
> rmmod nft_chain_nat
> rmmod nf_nat                # will WARN.
> 
> [akpm@linux-foundation.org: add comment]
> Link: https://lkml.kernel.org/r/20241007205236.11847-1-fw@strlen.de
> Fixes: a473573964e5 ("lib: code tagging module support")
> Signed-off-by: Florian Westphal <fw@strlen.de>
> Reported-by: Ben Greear <greearb@candelatech.com>
> Closes: https://lore.kernel.org/netdev/bdaaef9d-4364-4171-b82b-bcfc12e207eb@candelatech.com/
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   lib/codetag.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/lib/codetag.c b/lib/codetag.c
> index afa8a2d4f317..d1fbbb7c2ec3 100644
> --- a/lib/codetag.c
> +++ b/lib/codetag.c
> @@ -228,6 +228,9 @@ bool codetag_unload_module(struct module *mod)
>   	if (!mod)
>   		return true;
>   
> +	/* await any module's kfree_rcu() operations to complete */
> +	kvfree_rcu_barrier();
> +
>   	mutex_lock(&codetag_lock);
>   	list_for_each_entry(cttype, &codetag_types, link) {
>   		struct codetag_module *found = NULL;

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



