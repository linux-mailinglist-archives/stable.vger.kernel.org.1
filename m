Return-Path: <stable+bounces-256460-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCgMGVfyGGoMpQgAu9opvQ
	(envelope-from <stable+bounces-256460-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 03:56:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F555FC357
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 03:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC0A83008D29
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 01:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1A43612F8;
	Fri, 29 May 2026 01:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="3l1ccd/s"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942417A2FC;
	Fri, 29 May 2026 01:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019484; cv=none; b=kkhEVUPa419beXZ+rx921z0rQfyCjLeoOZ6vQiY4b7s+jlB68Ni/RxvlGhk1wixsGUx5K6tdFqZJEY2NzBQsUjWkaalYmoOZuulc4PAOyZIXObFkQuTJYWoNNvW8+R2UU5W92HJW385Jgz+nLl4xToFHKwdeaMRUAfMBYuukGzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019484; c=relaxed/simple;
	bh=fqq21v15RPx1Rh84bVvFeMQ9Bl5lBwGOOcLH5C32L08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwUtgEmCgZnnSMm6voNhrItW5FylJgJX5fPT19kBUlDbOKLGzP44ZZsX5oIXaq19AN+gsX4nrSaC9V1Z6mDmcX6Oyuse/vyhEzHqvUeuAFKm8sI6FZnD1t9y/wMs1c6XIAGpZ2ON4KhVl6UMgwD7cVoan1kmoLqGtE358iLtzAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=3l1ccd/s; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 1CCE214C2DE;
	Fri, 29 May 2026 03:51:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1780019479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kZxdwFMzc6brX3cLB9sUc8WNeZOIPdhM8Hcj9v1X2TI=;
	b=3l1ccd/suhuJaUEEnBVwNc0ku1zS0kePM/evo1sgCSC82YxXSvg0ya/50+jrUzq80PvqKU
	esu6GruCKBSsvxITCAxWI3e85bkXbhQ2wYLZiX6V5pdKXJJiALD6Pje/qJkZvPR2gNyyym
	V/sVQOZc2vj6C8ft+hAfMw7hpeStIga/trltLirvjlKNF/MKPqXFl/+LyqCRHXnQI/iIvi
	yFkvTtVr8dNQ7I9jAeNfwYZwTN9tUiHfFGQMgI6DYQGuWXStc+ecjRReRMzIkRqRVjkmFk
	x8/nclytoZcbHh5sHjNu0uRNjZgCXeGfllIB2rJORC7lfo/2JxKyl1UEDe8h1w==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 9d59e7a5;
	Fri, 29 May 2026 01:51:14 +0000 (UTC)
Date: Fri, 29 May 2026 10:50:59 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: v9fs@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>
Subject: Re: [PATCH] 9p: avoid putting oldfid in p9_client_walk() error path
Message-ID: <ahjxA57V3QkISzR2@codewreck.org>
References: <20260528053918.53550-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260528053918.53550-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codewreck.org,none];
	R_DKIM_ALLOW(-0.20)[codewreck.org:s=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,ionkov.net,crudebyte.com,vger.kernel.org,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	TAGGED_FROM(0.00)[bounces-256460-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[codewreck.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmadeus@codewreck.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tsinghua.edu.cn:email]
X-Rspamd-Queue-Id: B3F555FC357
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Yizhou Zhao wrote on Thu, May 28, 2026 at 01:39:16PM +0800:
> When p9_client_walk() is called with clone set to false, fid aliases
> oldfid. If the walk subsequently fails after the request has been sent,
> the error path jumps to clunk_fid, which currently calls p9_fid_put(fid)
> unconditionally.
> 
> This drops a reference to oldfid even though ownership of oldfid remains
> with the caller. If this is the last reference, oldfid can be clunked and
> destroyed while the caller still expects it to be valid. A later use or
> put of oldfid can then trigger a use-after-free or refcount underflow.
> 
> Fix this by only putting fid in the clunk_fid error path when it does not
> alias oldfid, matching the existing guard in the error path below.
> 
> This can be triggered when a multi-component walk is split into multiple
> p9_client_walk() calls and a later non-cloning walk fails. A reproducer
> and refcount warning logs are available on request.
> 
> Fixes: b48dbb998d70 ("9p fid refcount: add p9_fid_get/put wrappers")
> Cc: stable@vger.kernel.org
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: GLM 5.1
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>

This makes sense, thanks.
Queueing the patch.

> ---
>  net/9p/client.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index f0dcf25..4b942d0 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -1092,7 +1092,8 @@ struct p9_fid *p9_client_walk(struct p9_fid *oldfid, uint16_t nwname,
>  
>  clunk_fid:
>  	kfree(wqids);
> -	p9_fid_put(fid);
> +	if (fid != oldfid)
> +		p9_fid_put(fid);
>  	fid = NULL;
>  
>  error:

-- 
Dominique Martinet | Asmadeus

