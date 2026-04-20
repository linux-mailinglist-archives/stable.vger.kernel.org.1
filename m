Return-Path: <stable+bounces-238744-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDMoJ2Qa5mkprgEAu9opvQ
	(envelope-from <stable+bounces-238744-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:21:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1668742A9A5
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9B9C302E7FE
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 12:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824E839EF24;
	Mon, 20 Apr 2026 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jh7qhv4G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303B939EF1B;
	Mon, 20 Apr 2026 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776687710; cv=none; b=lhvj47xeUuOmQ/m5fMPDJz0F1Xtk0urkuxJARdUvK4xBI47FBbEAIEXvQxKetVFvkPkjNJtlRDkz4B8/ecN6bJxOtG1uOl3xrdi0jQ/vtvo6yj65wgYanafQHwXKtJISkD5C3FzJmawaMoG9j268ngLEuP8PE8zyPzydBq+v2qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776687710; c=relaxed/simple;
	bh=L9LDa8lva8DgET9ePF+xNKbKYxtkERL5knvaO3eD5ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZPYrwMFcXTfDoz9bnsBvetKf2RvvkQ+T2Yr7FF0hHpu70nnVpSpkUrlbtvl4osLAlBvqJTU9+I76ZgxRoUn+pfFBRVFQcndXEKLd8fuy91CgaDN6My4J32HM1Ngds9UN5ltBHSOPYZ7FxqCpITW9r184Ma2hfnerKu2ilVGqxcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jh7qhv4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F210C19425;
	Mon, 20 Apr 2026 12:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776687709;
	bh=L9LDa8lva8DgET9ePF+xNKbKYxtkERL5knvaO3eD5ow=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jh7qhv4G9ma5b299TRCbRaf/U2VwkpsUFEASRJy8uTasa1Ucnz/iiEOWzpNCxm1S2
	 cngaXjod2Dl5o3xyzEp1AoTOzlfzbZ24otCFDkPHm4pS/YkwrRdp2nemgNYk89dEn2
	 o0mtRwcpHxBvtdlGPscE9dLHEWwSUgvQL5R+yNdBVcKTcYbt7H+BRbvJd7MCKPZgcL
	 6AiyfYluWuGLhWzJAg4WBmRaUjzYLy4VTaguXgVJxiYkGi6aRc5TNohGq/WnR8AFjX
	 uq05qdMTAOnm2HAOV7IFPqW+iCijNiC+EBG4ehhlPBsp8rX25qvnOqF9krzJZtFd3N
	 Wk/JHNo9NE2Xw==
Message-ID: <759ccf04-345b-4264-a222-3049a20b0263@kernel.org>
Date: Mon, 20 Apr 2026 14:21:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vmalloc: fix buffer overflow in vrealloc_node_align()
Content-Language: en-US
To: Marco Elver <elver@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 Vitaly Wool <vitaly.wool@konsulko.se>, stable@vger.kernel.org,
 "Harry Yoo (Oracle)" <harry@kernel.org>
References: <20260420114805.3572606-2-elver@google.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260420114805.3572606-2-elver@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kvack.org,vger.kernel.org,googlegroups.com,konsulko.se,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238744-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1668742A9A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/26 13:47, Marco Elver wrote:
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

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
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


