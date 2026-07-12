Return-Path: <stable+bounces-273502-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X7yqHmO/U2pregMAu9opvQ
	(envelope-from <stable+bounces-273502-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 18:22:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA8074553C
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 18:22:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LPujuT0L;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273502-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-273502-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48632300334B
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 16:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8462D3563E1;
	Sun, 12 Jul 2026 16:22:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB5B25B092;
	Sun, 12 Jul 2026 16:22:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783873374; cv=none; b=TWOulielt+jRCzNGR4zQhETQbDBwcr99WGTBY0fjFgCt0UuNWT85fs9iop5jEeVBgjnO/R2Et1x6Z6YYxAh5aQpzOiy88c0kIl0LedYA8wqt6XLi7ZWPDwOtdIqMQJDbC5/S2I9Oc8ZV7Skf1K6OpsDhy9guXgMbK5tMehsIAO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783873374; c=relaxed/simple;
	bh=RSiIR1z2mpzASDxjHuQkD2I0bpgzQ/FS832oGCKKcCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJFWw6j4gexTRPwT4do9Qm/I6zZ4X0Lg+li9+vmx40ydV84gbDmkYa2Vr/3y4tbJkBqIJQwTooZ1pR7won5NwhwP41rySZv/c7WV+QWQvFRVxNWZ40s7bYbmiSXY30yFQ3K/I2aU4YJI6Mi+TvUiJLyXSfMnQo92nSt82OsOHmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPujuT0L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E1C781F000E9;
	Sun, 12 Jul 2026 16:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783873373;
	bh=FZTvFXX2MudrX92TEaij+xL5i/6YlKbl9UJuuydy7zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LPujuT0LV11yb+bgnE6+BzngTwJ0EpEgrQcNoUiCS+wbhMBFQGaQOQxsgk40seesV
	 x55VVByjtTTmY0gGIHWMY1VqzuWZfr+/y/ImdS7uS/GGAhNcmsLhGH6nE0LLd2RJSb
	 M+SjBuuoJuID4BOMCWh/5YrBow0KjrwbfXyx63hla1THhXE9Q37yQMs2dIKgUMaEGk
	 +TF68L7/9VTwFxNSqNer4TNpXe5/wh9nLlw+wCUBjiHtOpzNFNqREIKBMcY3lHQ8r/
	 BFJeIstxrQ/+bskIRyPnUdGOgVIyevE0XfSQhtJJmin+LyGVoUtq8tZqM858RoCm3w
	 VZsGmHj6rutHA==
Date: Sun, 12 Jul 2026 09:22:52 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Guanghui Yang <3497809730@qq.com>
Cc: linux-xfs@vger.kernel.org, Carlos Maiolino <cem@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] xfs: propagate errors from xfs_rtginode_load
Message-ID: <20260712162252.GA7233@frogsfrogsfrogs>
References: <tencent_542687AA9C474951C4132E84DAED17622105@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_542687AA9C474951C4132E84DAED17622105@qq.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[qq.com];
	FORGED_RECIPIENTS(0.00)[m:3497809730@qq.com,m:linux-xfs@vger.kernel.org,m:cem@kernel.org,m:hch@lst.de,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-273502-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ECA8074553C

On Sun, Jul 12, 2026 at 03:42:56AM +0000, Guanghui Yang wrote:
> xfs_rtginode_ensure() treats every xfs_rtginode_load() error other than
> -ENOENT as success.  This can leave the realtime group inode unset after an
> I/O, allocation, or corruption error.  Growfs then continues as though the
> inode had been loaded.
> 
> Only -ENOENT means that the inode needs to be created.  Return all other
> errors to the growfs caller.
> 
> Fixes: ae897e0bed0f ("xfs: support creating per-RTG files in growfs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanghui Yang <3497809730@qq.com>

Yeah, that's correct
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_rtalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
> index 7a3f97686989..84efe5a8fb11 100644
> --- a/fs/xfs/xfs_rtalloc.c
> +++ b/fs/xfs/xfs_rtalloc.c
> @@ -737,7 +737,7 @@ xfs_rtginode_ensure(
>  	xfs_trans_cancel(tp);
>  
>  	if (error != -ENOENT)
> -		return 0;
> +		return error;
>  	return xfs_rtginode_create(rtg, type, true);
>  }
>  
> -- 
> 2.34.1
> 

