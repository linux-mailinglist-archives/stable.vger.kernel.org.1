Return-Path: <stable+bounces-169689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD12B27562
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 04:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B617188A3F9
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345C1294A0C;
	Fri, 15 Aug 2025 02:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="UPw4PWwR"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B776628A1F9;
	Fri, 15 Aug 2025 02:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755223283; cv=none; b=ZH1euObdae+lsf7STLwl9XCGyR45gOCRTGbk4ooudBUedUWyRs21vz+K6kpnB6oi9gl9VWSTfgNViqftWzsRHd2j2rUXBcU9kBKOs5ddAmnI5R5l9jFYbcrHzMbxoSjzSxgHMPs2O5fRVaxiUbPOUe/2EK2UEM0cSg7de2/T+bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755223283; c=relaxed/simple;
	bh=jdxcyUe5l4oRk+B3RKLN5jSCzycW/bTs8X0cLOYpjNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4OztlhS/b0cA87V7NkKiVDjMlp2Nxdd9TWR+qvJZvEepzLnPzli5+/NB2Kxy5BJGeI558LzwsANfTaU1sDIcukKlkcNsfD7IC8sctG0OQeEYAwZ94BL2rWGHdioeEJZbpAziS3vnMWxHohAPoKeCe+KuGtDvXYG1sGMN24zL/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=UPw4PWwR; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 4EF1A14C2D3;
	Fri, 15 Aug 2025 04:01:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1755223279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3to1JoTI7YxcKW36ucsrZ8J9JD5dqSy+UMJOKOKBxv0=;
	b=UPw4PWwRqxf1H5wm6Xxz+bk+TNXbRFnTYziuff+8i7C6OO8Se8RC09eI8Fcum+oBQS9poC
	b1Zoo0jfmSbXHuT8QZfYyItZad4X2x2SJEP2AyxwceCrfT0puraxxFHTdihNOAiuZIWika
	nkpROOMoLZMoWnLxAuyzug8AotDS8bUzWWCnMYaO7Os7sjgSgTvJqci7KJfKUFXI2o7I/o
	HiFDGcNMqo1c+f/cQNpTAtz91AHQIuefT07IyHLbCDN+RvdDuWnkmw+e9bnhXikd1BDVos
	qCNiWlLkUAvs72tRqhAaogpJj2VqOiPG8mKpRUvOf1Ko9YUdsrEoqV/4IAmbnA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 831f3cb7;
	Fri, 15 Aug 2025 02:01:15 +0000 (UTC)
Date: Fri, 15 Aug 2025 11:01:00 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Nalivayko Sergey <Sergey.Nalivayko@kaspersky.com>
Cc: v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
	Eric Van Hensbergen <ericvh@gmail.com>,
	Wang Hai <wanghai38@huawei.com>,
	Latchesar Ionkov <lucho@ionkov.net>, lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: 9p: fix double req put in p9_fd_cancelled
Message-ID: <aJ6U3DQn876wGS4C@codewreck.org>
References: <20250715154815.3501030-1-Sergey.Nalivayko@kaspersky.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250715154815.3501030-1-Sergey.Nalivayko@kaspersky.com>

Nalivayko Sergey wrote on Tue, Jul 15, 2025 at 06:48:15PM +0300:
> This happens because of a race condition between:
> 
> - The 9p client sending an invalid flush request and later cleaning it up;
> - The 9p client in p9_read_work() canceled all pending requests.
> 
>       Thread 1                              Thread 2
>     ...
>     p9_client_create()
>     ...
>     p9_fd_create()
>     ...
>     p9_conn_create()
>     ...
>     // start Thread 2
>     INIT_WORK(&m->rq, p9_read_work);
>                                         p9_read_work()
>     ...
>     p9_client_rpc()
>     ...
>                                         ...
>                                         p9_conn_cancel()
>                                         ...
>                                         spin_lock(&m->req_lock);
>     ...
>     p9_fd_cancelled()
>     ...
>                                         ...
>                                         spin_unlock(&m->req_lock);
>                                         // status rewrite
>                                         p9_client_cb(m->client, req, REQ_STATUS_ERROR)
>                                         // first remove
>                                         list_del(&req->req_list);
>                                         ...
> 
>     spin_lock(&m->req_lock)
>     ...
>     // second remove
>     list_del(&req->req_list);
>     spin_unlock(&m->req_lock)
>   ...
> 
> Commit 74d6a5d56629 ("9p/trans_fd: Fix concurrency del of req_list in
> p9_fd_cancelled/p9_read_work") fixes a concurrency issue in the 9p filesystem
> client where the req_list could be deleted simultaneously by both
> p9_read_work and p9_fd_cancelled functions, but for the case where req->status
> equals REQ_STATUS_RCVD.

Sorry for the delay,
Thanks for the investigation, this makes sense and deserves fixing.

> Add an explicit check for REQ_STATUS_ERROR in p9_fd_cancelled before
> processing the request. Skip processing if the request is already in the error
> state, as it has been removed and its resources cleaned up.

Looking at the other status, it's quite unlikely but if other thread
would make it FLSHD we should also skip these -- and I don't think it's
possible as far as the logic goes but if it's not sent yet we would have
nothing to flush either, so it's probably better to invert the check,
and make it `if (req != SENT) return` ?

client.c already checks `READ_ONCE(oldreq->status) == REQ_STATUS_SENT`
before calling cancelled but that's without lock, so basically we're
checking nothing raced since that check, and it's not limited to RCVD
and ERROR.

If you can send a v2 with that I'll pick it up.

Thanks,
-- 
Dominique Martinet | Asmadeus

