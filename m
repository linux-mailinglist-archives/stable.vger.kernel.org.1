Return-Path: <stable+bounces-262616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xH9mLbNKKmqjmAMAu9opvQ
	(envelope-from <stable+bounces-262616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 07:42:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 536F866EBE8
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 07:42:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=cJBgsHrG;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262616-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262616-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 84BB8300616E
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 05:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EBC2F6577;
	Thu, 11 Jun 2026 05:41:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E483594A;
	Thu, 11 Jun 2026 05:41:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781156505; cv=none; b=B84Tg7hemOmyqz1NF28Vm66+37e69t5K/ljPegopCKHAlg/oKJZw9lNyCtUo9Ep111lE0yx5K/rf1P+JvbyxdRZE807qA+r5G49s/3ajvXoSc0qQi0dVvXXZWybT7mno+euPkUSPgxmPhO6I3qq1LJB+dky+yagDRRTn0gpRIFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781156505; c=relaxed/simple;
	bh=Sj05fN6Qd+zBsHd4CxOr7AU8PN7hOwFCS3QRoUm2ZBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tg2fx8sFf5xL/gL/K117zpXhGfdW/nJ0WTN0fYDG7L+ETkES8UeCJ/flC1m7FIfTBJm1kQAbMSDVLz96Km8q+touFRSJ5fEJ6oQFMpEJ5gtL8HH8JhHvPcDzJYvAjso1tMroiSsOsNCTy9Unsm4kZrg5QRqABScTN460FKUqonw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=cJBgsHrG; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=Khgn0214zjXoqkVcZYcdAVg6PoMLUoe2TmXcopQ7AAk=; 
	b=cJBgsHrG0XS6g+xnbsCjsmk6rRg+VD7/EhPJwREMHj5b0QpbYmsyZ5hNhApiPD28P4jbFajQIQF
	Z1n3W8INUjRKgfCRocL/9EC/GR5aG7GvNZf+qx7A5JCv/dHO2eV4fhjKOy8OpIpPnbYfOEm/TLvgY
	hI3UtiDpf5db8xxp+QImSxDNUUTR4YDUAmlkPrRSVJV+GnQMOHzQbYFMCOn6EjXQUuNmARA0B9isk
	F4hUV3UCVyCSi7yh4H89NpYhx8DZxTBnRptutASp3IXOldxqe1MhEdWzBoChuXXQpkw0HWFqVP+IQ
	CUXyf/u2aAqHK9Lxw/uyDV6zJl4WTHPnCmwQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wXYAe-00000004UPK-1opl;
	Thu, 11 Jun 2026 13:41:41 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 11 Jun 2026 13:41:40 +0800
Date: Thu, 11 Jun 2026 13:41:40 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: ayush.sawal@chelsio.com, davem@davemloft.net,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] crypto: chelsio: fix refcount leaks in ahash request
 functions
Message-ID: <aipKlHVyoJMIzu_F@gondor.apana.org.au>
References: <20260604101308.3785365-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604101308.3785365-1-vulab@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262616-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:ayush.sawal@chelsio.com,m:davem@davemloft.net,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gondor.apana.org.au:dkim,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,iscas.ac.cn:email,apana.org.au:url,apana.org.au:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 536F866EBE8

On Thu, Jun 04, 2026 at 10:13:08AM +0000, Wentao Liang wrote:
> When chcr_send_wr() fails in chcr_ahash_finup(), chcr_ahash_final(),
> chcr_ahash_update(), or chcr_ahash_digest(), the function still returns
> -EINPROGRESS to the crypto layer, claiming the request has been
> submitted.  No completion callback will be triggered because the work
> request was not actually handed over to the hardware, so the
> dev->inflight refcount that was incremented by chcr_inc_wrcount() is
> never decremented.  This permanently prevents device detach and leads
> to a resource leak.
> 
> Check the return value of chcr_send_wr() and jump to the error unmap
> path on failure so that the refcount is properly undone before
> returning an error.
> 
> Cc: stable@vger.kernel.org
> Fixes: 324429d74127 ("chcr: Support for Chelsio's Crypto Hardware")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/crypto/chelsio/chcr_algo.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/chcr_algo.c
> index 14a708defcd4..142eccaf82fe 100644
> --- a/drivers/crypto/chelsio/chcr_algo.c
> +++ b/drivers/crypto/chelsio/chcr_algo.c
> @@ -1877,7 +1877,10 @@ static int chcr_ahash_finup(struct ahash_request *req)
>  	req_ctx->hctx_wr.processed += params.sg_len;
>  	skb->dev = u_ctx->lldi.ports[0];
>  	set_wr_txq(skb, CPL_PRIORITY_DATA, req_ctx->txqidx);
> -	chcr_send_wr(skb);
> +	if (chcr_send_wr(skb)) {
> +		error = -EIO;
> +		goto unmap;
> +	}

This call is made half a dozen times in this file so fixing one
of them is not going to make much of a difference.  Either fix them
all or just mark this driver as broken.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

