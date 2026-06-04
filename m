Return-Path: <stable+bounces-260522-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LQplOHOUIWoYJQEAu9opvQ
	(envelope-from <stable+bounces-260522-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 17:06:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F18641360
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 17:06:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=evxtNGcr;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260522-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260522-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA4163086916
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 14:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD0F2F7F0E;
	Thu,  4 Jun 2026 14:53:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6970E2FFDFC;
	Thu,  4 Jun 2026 14:53:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584800; cv=none; b=OJ8L2E3EEsk8ANjg3aPf81aJzmkLJpea8hlXbC/kFPPmhqNYQn0/8lVcyDzXEdZ2FdyDJycZY7vPZEdE50bb5/aqHXVRVLCowiER0Bvr5U2ejKosGqM2e5AJ204X0foH6otGG58m3TVmigZVYyrKbzsTS+JKNorhw+Ne5BGX+jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584800; c=relaxed/simple;
	bh=bYe4HmE5H615cthAjeHmIlmbair1QiZ3ZvGqA8YW13g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bykpT2gB7rEtGIs1+AUEVvFvvarAtvkML3ALakgzXgwZr7mZfJjzia7+b0L7UOOMKHGcu2xQbZi4nnrnUfJqobvddtRcUivbNYVy9d6sgB7/E6jAghVw6QeSN4eAgN452yaj3eqEkvNvCcqLKya0uu5kalmOLtgxRxkLvrNqjnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evxtNGcr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id EAB111F00893;
	Thu,  4 Jun 2026 14:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780584799;
	bh=b+xFkY4vkE+eV91AOFhATehRInnQqRWH7emWjxhRhu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=evxtNGcrRkbiCqEzeGstAjsw+fTdlkacTWFyVdDerg4QBzScAc0BXo+xgImHXJLOs
	 vm+bHXW/P9ePkAt/JH6biJ7y/BkWCSUemm2B41gE36isB/PVODK7DygpsR+hfbjA/I
	 Ui7IxT5Zw6zd3hZxaXGUoQJhQPL5P7Z8CrQ1IaCaSoAmOS/b6cqdGY6DXzjrj8lcNN
	 2umb//PIsRixn5bXaUXWSxt0SBkkNZNJ9vOFSJsqs4Xf2OfU3LWCLbilA7e8bmh/DI
	 V7d4Z3IP1YJDZVI/PGFapq2U6y9Xu5RUgNmLSFp1FtXZ1fudQkorzbIIdiPVEs8svA
	 gWpDOEoQzLerQ==
Date: Thu, 4 Jun 2026 07:53:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Yingjie Gao <gaoyingjie@uniontech.com>
Cc: linux-xfs@vger.kernel.org, cem@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] xfs: fix exchmaps reservation limit check
Message-ID: <20260604145318.GF6095@frogsfrogsfrogs>
References: <20260604120317.930273-1-gaoyingjie@uniontech.com>
 <20260604120317.930273-2-gaoyingjie@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604120317.930273-2-gaoyingjie@uniontech.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260522-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gaoyingjie@uniontech.com,m:linux-xfs@vger.kernel.org,m:cem@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,frogsfrogsfrogs:mid,vger.kernel.org:from_smtp,uniontech.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44F18641360

On Thu, Jun 04, 2026 at 08:03:17PM +0800, Yingjie Gao wrote:
> xfs_exchmaps_estimate_overhead() adds the bmbt and rmapbt
> overhead to a local resblks variable, but the final UINT_MAX
> check still tests req->resblks.  That is the reservation value
> from before the overhead was added.
> 
> The computed value is stored back in req->resblks and later passed
> to xfs_trans_alloc(), whose block reservation argument is unsigned
> int.  Check the computed reservation so the existing limit applies
> to the value that will be used.
> 
> Fixes: 966ceafc7a43 ("xfs: create deferred log items for file mapping exchanges")
> Cc: <stable@vger.kernel.org> # v6.10
> Signed-off-by: Yingjie Gao <gaoyingjie@uniontech.com>

Oops.  That's a good catch!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/libxfs/xfs_exchmaps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_exchmaps.c b/fs/xfs/libxfs/xfs_exchmaps.c
> index 5d28f4eac527..541e33f33167 100644
> --- a/fs/xfs/libxfs/xfs_exchmaps.c
> +++ b/fs/xfs/libxfs/xfs_exchmaps.c
> @@ -711,7 +711,7 @@ xfs_exchmaps_estimate_overhead(
>  		return -ENOSPC;
>  
>  	/* Can't actually reserve more than UINT_MAX blocks. */
> -	if (req->resblks > UINT_MAX)
> +	if (resblks > UINT_MAX)
>  		return -ENOSPC;
>  
>  	req->resblks = resblks;
> -- 
> 2.20.1
> 

