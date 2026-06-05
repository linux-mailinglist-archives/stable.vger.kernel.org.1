Return-Path: <stable+bounces-260671-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mI68NT+oImp1bgEAu9opvQ
	(envelope-from <stable+bounces-260671-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 12:43:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA0B64771D
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 12:43:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=ZvR7Opl8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260671-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260671-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13FE6306DDD2
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 10:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E81C413624;
	Fri,  5 Jun 2026 10:32:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA564183D5;
	Fri,  5 Jun 2026 10:32:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780655544; cv=none; b=NizeckKf0aqzYsLtH4S/7meWQLa3CdhuWVEu+c/fztUO91iqfBe2q/ghNt140rCmkDU23A7c23MMduN7wuFrbAJyz/Hko2i2kgL5x+kTkolVjV27GIoJf4LnAyZq+SdSlSSjA9rFIwsZlYbNhUAiAxvNVdFWorEHaGrwDh4qhbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780655544; c=relaxed/simple;
	bh=BbjK/2QigkTOms2k/oYPbsW8B3hZYOgI7MJ/cpsjFHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoVb6dpog9qTgHqGUTLOasYXTXjqZBzEU/7M9GD24a599wvPm3N6+Al35DV4RL0NPvM6Y0w2NAErbaWdf6Bed7/nk/2C+uMWDq2GhTiuYi1/zuTxHXX5IuL4PDs35uluWJJNs+7COJfKyZHQse2ay7nDaCaDEVJ7L/Q3vnxqzjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=ZvR7Opl8; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=WXe7Ct4+XNpzH/EC6qkLPStSGUHKUoWOcXQbLurzEG8=; 
	b=ZvR7Opl8OoqDs/yxmqeM1WMup9/9/JTa3It7ZWBsKXB5bHqwRw8ZSe9HCpUXUaexIhoL8Vxt8Ha
	nVBIskULGAX71ZvqJ/hxvb7dnzbn7q1l3xchSlmqxYm/exbBwOhmXoqCDWyf0dmwYIlU+depB5iiw
	nw7wIOVPzPwfVTkSmk04BCH46G4CAARpV6DQBPjQDH1zfj8bjWsFDOK5iCWUdddyqRrq5zEVKmHaE
	hW3bsNSO+pKBtVOocwWmCNgxCTNmdiUrTVOfK1OW/H0edGaLmlNbhN+3DT0wADRTpgbxqTD/JNHJZ
	QntTlqCeRb5bNiZc6ndz9f86ISXiy2hNBF/A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wVRqQ-002nYy-2I;
	Fri, 05 Jun 2026 18:32:07 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Jun 2026 18:32:06 +0800
Date: Fri, 5 Jun 2026 18:32:06 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Ayush Sawal <ayush.sawal@chelsio.com>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] crypto: chelsio: fix inflight counter leak in
 chcr_aes_encrypt()
Message-ID: <aiKlpvKfVhEYpBj8@gondor.apana.org.au>
References: <20260526155736.2297383-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526155736.2297383-1-vulab@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260671-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:ayush.sawal@chelsio.com,m:davem@davemloft.net,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,apana.org.au:url,apana.org.au:email,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AAA0B64771D

On Tue, May 26, 2026 at 03:57:36PM +0000, Wentao Liang wrote:
> chcr_aes_encrypt() increments dev->inflight via atomic_inc() before
> submitting the cipher operation. If chcr_start_cipher() subsequently
> fails, the function returns an error without decrementing dev->inflight,
> causing the counter to drift and potentially stalling future operations
> that rely on the counter reaching zero.
> 
> Add atomic_dec(&dev->inflight) on the chcr_start_cipher() failure path
> to restore the counter.
> 
> Fixes: b8fd1f4170e7 ("crypto: chcr - Add ctr mode and process large sg entries for cipher")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/crypto/chelsio/chcr_algo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/chcr_algo.c
> index 6dec42282768..eece1ac1085a 100644
> --- a/drivers/crypto/chelsio/chcr_algo.c
> +++ b/drivers/crypto/chelsio/chcr_algo.c
> @@ -1359,7 +1359,7 @@ static int chcr_aes_encrypt(struct skcipher_request *req)
>  	err = process_cipher(req, u_ctx->lldi.rxq_ids[reqctx->rxqidx],
>  			     &skb, CHCR_ENCRYPT_OP);
>  	if (err || !skb)
> -		return  err;
> +		goto error;
>  	skb->dev = u_ctx->lldi.ports[0];
>  	set_wr_txq(skb, CPL_PRIORITY_DATA, reqctx->txqidx);
>  	chcr_send_wr(skb);

Doesn't the same problem exist in chcr_aes_decrypt?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

