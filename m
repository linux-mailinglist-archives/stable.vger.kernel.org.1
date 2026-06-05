Return-Path: <stable+bounces-260674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ec29JUWoImp4bgEAu9opvQ
	(envelope-from <stable+bounces-260674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 12:43:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 230AA64772A
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 12:43:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=Lrz46RsD;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260674-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260674-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 757C430684D0
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 10:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10044413631;
	Fri,  5 Jun 2026 10:34:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D86541360A;
	Fri,  5 Jun 2026 10:34:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780655646; cv=none; b=hFMFPsd8HQPmK/RAsKZNm49bhh9AvKTbg2NHK8mxRDykXIhaVb8xx/A7u+JzVveVLinuq6TBSxekz0nVuW/RJJsBqE3P0aygjk4D7hvRti6iF13ycm3bMYRy+9iJIrVsJGlEaFmyXTt+lKAvy6PW1hr3tHsggo6xCsQSf3V5Zts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780655646; c=relaxed/simple;
	bh=xvA5wf3Ao8VsduA7NUa2F/R5NnI3LTcY1sZ0Vu2ubOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kiiyp9ung53cbjClyBEP4pWcop29fSH/2DRgoIPbtbmNaHZap83lD5xO7VS6CwLAn+8tmeIig2H1nz+87ODL15qL5KqHftMnJ6opawOXp6Inus5wxozkyGCsC3vmaRJdU7eVn6HK6ZAIlAphsXHibyqFtoWPliplZ4vgZKke/FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=Lrz46RsD; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=Y6gLP44YQ8qK+b97Xm/sd4qK53h4THZq96IJSOYwjfU=; 
	b=Lrz46RsDIgWR1A8xVowh9kCT0EFfLW1O/daSP5c/JkWlFe7MmCCpLXcT73QMmEWAurDvdQ5U5od
	gmNfk/caiKoXjCfWPBGPx5SiVVfLAg0wq0EUYnEPoRsEZ65FgvfKR4k3A/1LbgDsKt8MqxFbIQWW6
	FvON/jaewHujrxVVD4cTIXJPdvXU9EhaC4FDGSDw6wn5/0Pclb2CrDD55CVqgTRquil6Oj4u+YCzM
	chObxsa1xHEDSXzNY7aLkOkBbjz2lxgEJlf+B4vDzP7WlcLJXG1JllP5iqN0SjXq6OijZlMQndi22
	SDsCgygRBTCunQ5D1d8LAegKuiCJH+umis9Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wVRsC-002nae-30;
	Fri, 05 Jun 2026 18:33:57 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Jun 2026 18:33:56 +0800
Date: Fri, 5 Jun 2026 18:33:56 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Ayush Sawal <ayush.sawal@chelsio.com>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] crypto: chelsio: fix inflight counter leak in
 chcr_aes_encrypt()
Message-ID: <aiKmFF23AbPRzHzw@gondor.apana.org.au>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260674-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:ayush.sawal@chelsio.com,m:davem@davemloft.net,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,apana.org.au:url,apana.org.au:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 230AA64772A

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

I think it should be 

fef4912b66d6 ("crypto: chelsio - Handle PCI shutdown event")

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

