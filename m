Return-Path: <stable+bounces-237738-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHTuIybr3WmulAkAu9opvQ
	(envelope-from <stable+bounces-237738-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 09:22:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 063133F68E4
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 09:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 931743020134
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 07:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4AC37CD33;
	Tue, 14 Apr 2026 07:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bChfPImS"
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09951325490
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 07:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776151246; cv=none; b=LtcA7zDya2ect1DqdI5cxlVVwzE1SNcLvlovo8KzNaNVPkWBhTSH6Y2E67T3sl3nYfFZkYtTg0VmOkd2l7X1LxhVmzzAMckx2Dw+KhmxCtpw2hRGhdGdKu0fwiWW0W0zzd8BiNee6exfhhIdCJZUM2UkoFN/dczlvl9qkmEYJRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776151246; c=relaxed/simple;
	bh=TvqoUFtdRQgG8n3xt/GZMJTs4jRmjc77KYgL/IbN+O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IaxvS7HdV2bQ7Gmt4smHi+9WwcUlT2Gsvhn0NIYaw7a0Nycs3oFBPsRwngFwZ2D9tMGj/8lbdDseN+ZTotUc6Od5p72hb25SEiPlEf87gwSf4hhhksLpA060+XOPYrKmXv/6/Mav4GtlmdK1OHLy7Jt5kb/2XFa72dOQS8jbxCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bChfPImS; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 14 Apr 2026 15:20:33 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776151241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JPWYjo9GhqaMpwQ+mEVfK6/tiojaazojzQ0cBIRZ8mo=;
	b=bChfPImSqYu4PwGtucE+CcphBwv4vWnwTUwbVosYoWuncoTp/VY/esGiJ1QDfgKqf7W9Nf
	EFwgQaAFmBf2MXUGOIv8/Cseejsr4ds1ljv4cITBnukmOckSCL/A7KO4D9Lp7sMuKfn1Xg
	OhYTLpr/s1hYd50w32rFUqv54THNMtQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
	stable@vger.kernel.org, chenyichong <chenyichong@uniontech.com>
Subject: Re: [PATCH] mm/vmalloc: Take vmap_purge_lock in shrinker
Message-ID: <ad3qwblVAJ0tUQBF@MiWiFi-R3L-srv>
References: <20260413192646.14683-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413192646.14683-1-urezki@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-237738-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baoquan.he@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,uniontech.com:email]
X-Rspamd-Queue-Id: 063133F68E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/13/26 at 09:26pm, Uladzislau Rezki (Sony) wrote:
> decay_va_pool_node() can be invoked concurrently from two paths:
> __purge_vmap_area_lazy() when pools are being purged, and the
> shrinker via vmap_node_shrink_scan().
> 
> However, decay_va_pool_node() is not safe to run concurrently,
> and the shrinker path currently lacks serialization, leading
> to races and possible leaks.
> 
> Protect decay_va_pool_node() by taking vmap_purge_lock in the
> shrinker path to ensure serialization with purge users.
> 
> Cc: stable@vger.kernel.org
> Cc: chenyichong <chenyichong@uniontech.com>
> Fixes: 7679ba6b36db ("mm: vmalloc: add a shrinker to drain vmap pools")
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 61caa55a4402..676851d5cfe7 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -5416,6 +5416,7 @@ vmap_node_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  {
>  	struct vmap_node *vn;
>  
> +	guard(mutex)(&vmap_purge_lock);
>  	for_each_vmap_node(vn)
>  		decay_va_pool_node(vn, true);

LGTM,

Reviewed-by: Baoquan He <baoquan.he@linux.dev>


