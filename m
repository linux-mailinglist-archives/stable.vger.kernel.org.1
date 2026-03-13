Return-Path: <stable+bounces-225294-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KDSHdD2s2nYdgAAu9opvQ
	(envelope-from <stable+bounces-225294-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 12:36:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE65D2824D5
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 12:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9288A3237DC7
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 11:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC65F325727;
	Fri, 13 Mar 2026 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Nmp1sZYB"
X-Original-To: stable@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD99028BA95;
	Fri, 13 Mar 2026 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773401663; cv=none; b=J5pw7VhKDoaWBHWvjGp7j9c6b7jU9FiLK+ZEqv71aClH8Swr240rVvIovBaqDDozkRjqSMLSdebjTgYjZUCVC8+seWL5ao0dM3l87sZ7t0wWkewwquIE06PjVk40BusodJxi1RclefQkrYS+5WLC+EGm9RTf6/nt3pSbDdTJwR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773401663; c=relaxed/simple;
	bh=Is90Lbq1TqckLWjdloG7Ms2MmpgjtHfLDupPvwdQTI0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWsdpn2BJXqgMhtszbeOdfwjpubpqj7uNcsvQmR/tt6BmT9D5auXxT3qFTOp4feAW2iN4/G0+KH3z23OwcbHFnZs5yO2HHmNAWNRjvn5F9hZcUd9Lzm7+xzC4q1aQ49uOwICh46wtPmkriCkpt42ChzzqcRzh1rf4xk13Bp2Mkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Nmp1sZYB; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 01D2B201A7;
	Fri, 13 Mar 2026 12:34:19 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r30F7oMHMAnP; Fri, 13 Mar 2026 12:34:18 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 62A3920184;
	Fri, 13 Mar 2026 12:34:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 62A3920184
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1773401658;
	bh=auH0wLDZVzJv1DswK/GkLmTiWQz/vTXAvedisJlEgZI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Nmp1sZYBTcuKTpJMYdRslINLBiB3OPQYPxQMwMHCeASoHMa+F28une8jSRejkLhJp
	 /Iu7rNtSEdILxz/CPFn9Q5vKA0WZcaqfydRM3LniQf/oeF1qPJGaZwdNPKlikFvoeg
	 9lbqpVt1MG7Ac6ynXlTPWkjATm/qSGFAss0lYbXh/GOLV3sKt0CUPjdBDVUnYP5yYo
	 lJSJ53ZCVjBdcSWOfUjFgEHspwgdonCdUQh55UJ0mcgtlDHG0Ih/tUGae4KfEMPHPy
	 kFj0E59iyEIbi4gk4wluDZHM6UkvrTA6Kj+gG0a4JLxf0BfspHrXHA1KZg1gMw0jrJ
	 8nVIerN4Md3/Q==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 13 Mar
 2026 12:34:17 +0100
Received: (nullmailer pid 3889090 invoked by uid 1000);
	Fri, 13 Mar 2026 11:34:16 -0000
Date: Fri, 13 Mar 2026 12:34:16 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paul Moses <p@1g4.org>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <chopps@labn.net>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v2] xfrm: iptfs: only publish mode_data after clone
 setup
Message-ID: <abP2OKsk9wbCH892@secunet.com>
References: <20260312113843.2883169-1-p@1g4.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260312113843.2883169-1-p@1g4.org>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225294-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1g4.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:dkim,secunet.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EE65D2824D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 11:39:09AM +0000, Paul Moses wrote:
> iptfs_clone_state() stores x->mode_data before allocating the reorder
> window. If that allocation fails, the code frees the cloned state and
> returns -ENOMEM, leaving x->mode_data pointing at freed memory.
> 
> The xfrm clone unwind later runs destroy_state() through x->mode_data,
> so the failed clone path tears down IPTFS state that clone_state()
> already freed.
> 
> Keep the cloned IPTFS state private until all allocations succeed so
> failed clones leave x->mode_data unset. The destroy path already
> handles a NULL mode_data pointer.
> 
> Fixes: 6be02e3e4f37 ("xfrm: iptfs: handle reordering of received packets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moses <p@1g4.org>
> ---
> Changes in v2:
> - Fix Fixes tag to point to 6be02e3e4f37
> 
>  net/xfrm/xfrm_iptfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 050a82101ca51..4d7a925f59b7c 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -2653,9 +2653,6 @@ static int iptfs_clone_state(struct xfrm_state *x, struct xfrm_state *orig)
>  	if (!xtfs)
>  		return -ENOMEM;
>  
> -	x->mode_data = xtfs;
> -	xtfs->x = x;
> -
>  	xtfs->ra_newskb = NULL;
>  	if (xtfs->cfg.reorder_win_size) {
>  		xtfs->w_saved = kzalloc_objs(*xtfs->w_saved,
> @@ -2666,6 +2663,9 @@ static int iptfs_clone_state(struct xfrm_state *x, struct xfrm_state *orig)
>  		}
>  	}
>  
> +	x->mode_data = xtfs;
> +	xtfs->x = x;
> +
>  	return 0;
>  }

This does not apply to the ipsec tree. Can you rebase on top of the
current ipsec tree?

Thanks!

