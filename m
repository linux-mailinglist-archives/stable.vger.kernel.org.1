Return-Path: <stable+bounces-251346-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCUvOWjxDWp+4wUAu9opvQ
	(envelope-from <stable+bounces-251346-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:37:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4321159423A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEE01307C41F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083F93A4526;
	Wed, 20 May 2026 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXzhd3CI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07163BE165;
	Wed, 20 May 2026 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297740; cv=none; b=tm8sglFEXHHvL9SDwKSwWmkUrL/xUZudqd9BXqMjoVxqWmIzTagPH8LHuwSuNATLzqiPR2RVZaju7Ra85EGRVoGwfeo4GtJr4d9TVJ3vxSwC5SiuXEFWkvUZTbkB1zA022bvBDOVIX50jn2FrCF+XxwXX1UNKKBe9sGQOYO/tvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297740; c=relaxed/simple;
	bh=NpQ1Jyg7vQ40tYZ953aeKX2p4s1lJ7cTxR+DCUnBrKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiIGXcyBIhjT5EgPwR+MsW72GAeMWdIxqonlKZhmaY4O8G+Y5CtI+2rSbuApmz47h/MGWGh3jVmYXN/4plYQuPZyvvAcY86iXu+6AUFZ/8AvjNVIX//Szr8vwkpQSQMv/zVOn/kimZMqeaND1KLtGiUCWJOjp0hy+NI434WTffw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXzhd3CI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D511F000E9;
	Wed, 20 May 2026 17:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779297739;
	bh=8Qj1mjLbItHB2o4CA0jRbYV85vRMUukkoslRkxoKqcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aXzhd3CIl3n8mxw8zVQsYD/y/3w8pJd8lONm8C4SKcU4VfstAur+IXFFn4h7QXxbg
	 smsaLMNcovh3wfqTnIn5wXv6+h3zRv9or603vlaxnC0qqDfpsgTiOr34sYbvXZhgS2
	 G1ZXnDPL8KxQ7LAbgxzD4SOj5GanFeWeKouLDe9rHQPstxMRXLT0e6yOp+o+b3NNzu
	 G1/sh0lkBIYzAa0EqwMsAPqvN5Yd1LOMHjeQhiI8fRHI6+zKFueqa6uwyCL78VYHtN
	 q12q3g9Dfwk6z7vAt3VJSUsq9IcwQcgbL5OGa7hWKH27g9CdXU+v4kFUexI4niyv3T
	 OwaXn7PPkBQOw==
Date: Thu, 21 May 2026 01:22:14 +0800
From: Gao Xiang <xiang@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>,
	Chunhai Guo <guochunhai@vivo.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.18 010/957] erofs: verify metadata accesses for
 file-backed mounts
Message-ID: <ag3txj1lJNTGZQjp@debian>
References: <20260520162134.554764788@linuxfoundation.org>
 <20260520162134.785057461@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260520162134.785057461@linuxfoundation.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com,vivo.com,linux.alibaba.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-251346-lists,stable=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[xiang@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,alibaba.com:email,vivo.com:email]
X-Rspamd-Queue-Id: 4321159423A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

On Wed, May 20, 2026 at 06:08:13PM +0200, Greg Kroah-Hartman wrote:
> 6.18-stable review patch.  If anyone has any objections, please let me know.
> 

Could you please help drop this too, the same reason as:
https://lore.kernel.org/r/ag3qlMOcTYM2FBUQ@debian

I will address this backport manually later.

Thanks,
Gao Xiang

> ------------------
> 
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> [ Upstream commit 307210c262a29f41d7177851295ea1703bd04175 ]
> 
> For file-backed mounts, metadata is fetched via the page cache of
> backing inodes to avoid double caching and redundant copy ops out
> of RO uptodate folios, which is used by Android APEXes, ComposeFS,
> containerd.  However, rw_verify_area() was missing prior to
> metadata accesses.
> 
> Similar to vfs_iocb_iter_read(), fix this by:
>  - Enabling fanotify pre-content hooks on metadata accesses;
>  - security_file_permission() for security modules.
> 
> Verified that fanotify pre-content hooks now works correctly.
> 
> Fixes: fb176750266a ("erofs: add file-backed mount support")
> Acked-by: Amir Goldstein <amir73il@gmail.com>
> Reviewed-by: Chunhai Guo <guochunhai@vivo.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/erofs/data.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 8ca29962a3dde..58aea2b48580c 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -29,6 +29,20 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
>  {
>  	pgoff_t index = (buf->off + offset) >> PAGE_SHIFT;
>  	struct folio *folio = NULL;
> +	loff_t fpos;
> +	int err;
> +
> +	/*
> +	 * Metadata access for file-backed mounts reuses page cache of backing
> +	 * fs inodes (only folio data will be needed) to prevent double caching.
> +	 * However, the data access range must be verified here in advance.
> +	 */
> +	if (buf->file) {
> +		fpos = index << PAGE_SHIFT;
> +		err = rw_verify_area(READ, buf->file, &fpos, PAGE_SIZE);
> +		if (err < 0)
> +			return ERR_PTR(err);
> +	}
>  
>  	if (buf->page) {
>  		folio = page_folio(buf->page);
> -- 
> 2.53.0
> 
> 
> 

