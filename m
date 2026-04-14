Return-Path: <stable+bounces-237715-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEq+GGS73WmCiQkAu9opvQ
	(envelope-from <stable+bounces-237715-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 05:58:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAA03F560E
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 05:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DAB530364DF
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 03:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD4A18872A;
	Tue, 14 Apr 2026 03:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCujGT8B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C03B336885;
	Tue, 14 Apr 2026 03:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776139102; cv=none; b=QWi0nX7ZwqquLU7+gA/QlnRIiMivyAi2sA+Us7pWnSHciKpefvIAcK7JVvoNnnKWz3er6WwQgPQbHbDQu48LmvkSCDL8g8KOwTcZ1AebLGswyXzhoRHz1VfGy4j9U1habKduJ9Lw/EwFTRUKlOvC+1IF0+zXMM+qvTTSNABBLrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776139102; c=relaxed/simple;
	bh=nNZlM537Hyqn1nvCUsqy8cIcEYWT3hOhE1T39DrFlDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KavuWCn1M/nRVHcwdZ9hGpcKharwaxuB05ITJfllg99SwAmLD86DMtpLGQF0eeF/7LqOBZBAeWTLv5BdugSgkSX9DGI+KuH7GZdjmPqI3TqJMELIqO0HE7OwiTJ2Czgush0kMrc42lO0ngFs/7KUrVd581hS93qbxQ77mZU5nBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCujGT8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35020C19425;
	Tue, 14 Apr 2026 03:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776139101;
	bh=nNZlM537Hyqn1nvCUsqy8cIcEYWT3hOhE1T39DrFlDI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gCujGT8BELYxRQ1GiZP1wdlJc7qqw3YvGS+PNy+/tOgHM33L0wu7O+JrYB3U5xkKb
	 +gpy67r6CTJtll+VCj6EQFZoTTGXxBL3kq8u83Q+U5ShDegleq06be7JU1hWXilss/
	 27DIJTfpYlmKv5/p5kI4ePz4kV596f6g4Mdba+snwoG15FeMgJY40WqOq2CwBr1JFM
	 b+NZrl7h01ia+AXL5j5Z0rdYnfYvKhafSnB7WLB6NLthUGdB8eXRNOwZvT/BwJ710A
	 HtrRxJVKXoCi6BX5H6+2oPbxNOvZwesCpvIV3XfPSNhM1Ufy/5zPPV5w5T/S3mmvAJ
	 Y+XvKiXm+k/3Q==
Message-ID: <91a63739-e905-4e45-aff0-53480de74e50@kernel.org>
Date: Tue, 14 Apr 2026 05:58:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xfs: fix memory leak on error in xfs_alloc_zone_info()
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Carlos Maiolino <cem@kernel.org>, Hans Holmberg <hans.holmberg@wdc.com>,
 "Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, stable@vger.kernel.org
References: <20260414034149.1116281-3-wilfred.opensource@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260414034149.1116281-3-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237715-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CBAA03F560E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026/04/14 5:41, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> Currently, the 0th index of the zi_used_bucket_bitmap array is not freed on
> error due to the pre-decrement then evaluate semantic of this while loop used

s/this/the

> in xfs_alloc_zone_info(). Fix it by allowing for the i == 0 case to be covered.

Please limit your commit message text to 74 chars per line.
(See Documentation/process/submitting-patches.rst, "The canonical patch format"
section).

> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

I think that the usual order here is to have the Fixes and CC tag before your
signed-off-by.

> Fixes: 080d01c41d44 ("xfs: implement zoned garbage collection")
> Cc: stable@vger.kernel.org

Other than this, looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  fs/xfs/xfs_zone_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_zone_alloc.c b/fs/xfs/xfs_zone_alloc.c
> index a851b98143c0..c64f9ab743a6 100644
> --- a/fs/xfs/xfs_zone_alloc.c
> +++ b/fs/xfs/xfs_zone_alloc.c
> @@ -1217,7 +1217,7 @@ xfs_alloc_zone_info(
>  	return zi;
>  
>  out_free_bitmaps:
> -	while (--i > 0)
> +	while (--i >= 0)
>  		kvfree(zi->zi_used_bucket_bitmap[i]);
>  	kfree(zi);
>  	return NULL;


-- 
Damien Le Moal
Western Digital Research

