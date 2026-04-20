Return-Path: <stable+bounces-238758-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGMAKEYk5ml1sgEAu9opvQ
	(envelope-from <stable+bounces-238758-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:04:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AF642B31B
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 976B7300B465
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A400D39FCDB;
	Mon, 20 Apr 2026 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TENHAvJl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B4B399019;
	Mon, 20 Apr 2026 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690243; cv=none; b=d0ChDkqQL6WSyRRSebFzlQDPsL8Ia54XoNAltW2NeQMWRDxRa9nTd4bLY4j04PRqjHD3Q/4v3zkCI7dHCaXv7Bu1fyNr9CX5ein2dQJHSpD5fCAAIho9sHlA65yTG+efhhWqYXd7k3dyZ+1PtwGP1AL9GSATP55MUZev/2+uFUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690243; c=relaxed/simple;
	bh=6l/uKiHJ2TRLu8+eUqPvROgTVTLN+Kie5LYERHfBn3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTcHcbR5MDlZXJVjsRNZXi3RrbXFgLf49QdRjcCMDZkangk04FeLYBDJRSOsQOTlr51IQc9tmY4t684pHBRirMuhYw6zCwGzRtf7obRpC1Htx3iFfpjA1QTVzWB/y9t1KLzboeqqQeiNf2X9RgXW42OHggce747muulUqJvvydg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TENHAvJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68B2C19425;
	Mon, 20 Apr 2026 13:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776690243;
	bh=6l/uKiHJ2TRLu8+eUqPvROgTVTLN+Kie5LYERHfBn3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TENHAvJlSR5HWZdXlH+qS8mibevUTztLgJ316ztE2xRMjxHu53WL+v7VEYffTzC2F
	 7jVF51Gb+oxB2RKPT+juxNZ7OXlqp1psb8A9VE1XB+NmSUf1B7ZWRymG2B29NXkEtd
	 jBt94Z4aRfDUu3pGSbNrZ3ei6HYUxqHv/U4H2Xx7LKuXKfxbogdOAjX11YaYGKikhg
	 QmE5bRgUgkqsYONQ/aqy6nt8kKHCYeptNSopGUZkrAl96+WPQgp77Qq8SBUdETKhBS
	 91pZ9YlSpIblGFnw+sorFkeZsffdpqTI+vD9Kvhfjbppm50N1JIxaxJEgcKAtDf0LZ
	 Boj/1q6sqtuRw==
Date: Mon, 20 Apr 2026 22:04:01 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	Vitaly Wool <vitaly.wool@konsulko.se>, stable@vger.kernel.org
Subject: Re: [PATCH] vmalloc: fix buffer overflow in vrealloc_node_align()
Message-ID: <aeYkQZHY7Vln0M5L@hyeyoo>
References: <20260420114805.3572606-2-elver@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420114805.3572606-2-elver@google.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,gmail.com,kvack.org,vger.kernel.org,googlegroups.com,konsulko.se];
	TAGGED_FROM(0.00)[bounces-238758-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34AF642B31B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 01:47:26PM +0200, Marco Elver wrote:
> Commit 4c5d3365882d ("mm/vmalloc: allow to set node and align in
> vrealloc") added the ability to force a new allocation if the current
> pointer is on the wrong NUMA node, or if an alignment constraint is not
> met, even if the user is shrinking the allocation.
> 
> On this path (need_realloc), the code allocates a new object of 'size'
> bytes and then memcpy()s 'old_size' bytes into it. If the request is to
> shrink the object (size < old_size), this results in an out-of-bounds
> write on the new buffer.
> 
> Fix this by bounding the copy length by the new allocation size.
> 
> Fixes: 4c5d3365882d ("mm/vmalloc: allow to set node and align in vrealloc")
> Cc: <stable@vger.kernel.org>
> Reported-by: Harry Yoo (Oracle) <harry@kernel.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---

Looks good to me,
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

Thanks a lot for fixing it!

>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 61caa55a4402..8b1124158f54 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4361,7 +4361,7 @@ void *vrealloc_node_align_noprof(const void *p, size_t size, unsigned long align
>  		return NULL;
>  
>  	if (p) {
> -		memcpy(n, p, old_size);
> +		memcpy(n, p, min(size, old_size));
>  		vfree(p);
>  	}
>  
> -- 
> 2.54.0.rc1.513.gad8abe7a5a-goog

-- 
Cheers,
Harry / Hyeonggon

