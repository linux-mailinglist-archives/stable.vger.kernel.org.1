Return-Path: <stable+bounces-241648-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEtnDBip8GltWwEAu9opvQ
	(envelope-from <stable+bounces-241648-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 14:33:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A65A484E2B
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 14:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C986B300558F
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4102641C31E;
	Tue, 28 Apr 2026 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LLgqsbCy"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBD442982F
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 12:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777379599; cv=none; b=b6wwprnvEeYlp4vw2B776va4VWvaKr46MmZ2BllO2afLxHb+79ZVWpgpVEYthdpFnNxWlmJgomNEsTZ2QR6mAmGI8XRVjKSiPV63G+yn01NKw42rleHzC6QBQfMpnWcAcbWCIIJ3wSS3XaDExOULdpE820MknP3ByLMOL+3+exA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777379599; c=relaxed/simple;
	bh=zPFMhT8JWttIp1liGDJ/ifYR9oX4Q/TrRaAfoDm1M4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtrGtWGaJPaPfpZ4HmgETE+jV1t1easVGP1MgXLos/ByOMs0t1NTS177u/4yvnXoc1+jhkuUUYVpnA9uCd2FvVfPqLloY95nvZ1A9BI4unFUmCQmMQCCwoVFkmcTbzydxWfuayGfKiR3dhIzqfUtJS+szoYg9PBoj0Iey3STPi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LLgqsbCy; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 28 Apr 2026 14:32:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777379579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/1ATwxQzv3bF5ExhjGlAkFYLpgrDUAcbjVTMBpGbV2Y=;
	b=LLgqsbCyD6VGWbuT5dDv3ZJJt1w6Dsy36SGj4v1eqG8CNz9mVhT4Z9b7+FBlAcQIAK6shv
	/4TeF5Pze9BNdIEFsVI8x2dvjNlEByTQvl9jduj0s4gb3vQ0pY9A82JP5+m8qrYhP6Se43
	jt3xvAsewskiFyGJoFHu9Ejbux7IzeY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Bill Cox <waywardgeek@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Linus Walleij <linusw@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	stable@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crypto: atmel-sha204a - drop hwrng quality reduction
 for ATSHA204A
Message-ID: <afCo9PbDpTYeqGd4@linux.dev>
References: <20260428101430.514838-3-thorsten.blum@linux.dev>
 <25ntssyy6t5uwxlwfpmrpzpcq6xv62l643hflf26hxi6lv5wqu@6vub6ysczjvd>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25ntssyy6t5uwxlwfpmrpzpcq6xv62l643hflf26hxi6lv5wqu@6vub6ysczjvd>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 1A65A484E2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241648-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,gondor.apana.org.au,davemloft.net,microchip.com,bootlin.com,tuxon.dev,kernel.org,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,metzdowd.com:url,linux.dev:dkim,linux.dev:mid]

Hi Marek,

On Tue, Apr 28, 2026 at 01:18:08PM +0200, Marek Behún wrote:
> Adding Bill Cox (waywardgeek) to the conversation.
> 
> In the meantime Nack from me on this patch.
> 
> From the original messages by Bill, it seems to me the part he was reviewing
> was the ATSHA204A.
> 
> In subsequent reply [1] Bill states
> 
>   While there is some evidence, there is still no convincing proof that there
>   is an entropy source in this device at all.  There is some evidence that
>   Atmel has inserted a back-door.  My advice is to avoid this line of parts
>   from Atmel for cryptographic use.
> 
> In another message Peter Gutmann asks about ATECC108 [2] and Bill replies [3]
> 
>   This part uses the same language to describe the random number generator.
>   It is "high quality".  I think that's pretty funny.
>   I would be interested in seeing if the new part can generate random numbers
>   continuously, or if it fails after it's EEPROM wears out like their other
>   parts.  The use of an EEPROM seed is for PWN-ing your RNG, not making it
>   more secure.
> 
> IMO the comments from the actual reviewer are more relevant than those of the
> engineer working for the company which was accused of creating low quality
> / backdoored TRNG, at least until the Atmel engineer provides some evaluation
> code for the device (which they suggested they might do [4], but never did as
> far as I can find).
> 
> Maybe we can instead change the ATECC quality to something like 32? Does that
> even make sense?
> 
> Marek
> 
> [1] https://www.metzdowd.com/pipermail/cryptography/2014-December/023857.html
> [2] https://www.metzdowd.com/pipermail/cryptography/2014-December/023870.html
> [3] https://www.metzdowd.com/pipermail/cryptography/2014-December/023879.html
> [4] https://www.metzdowd.com/pipermail/cryptography/2014-December/023886.html

Bill wrote in his review:

  "If I made no mistake (and I do make a lot), the "random" data from
   the Atmel ATSHA204A is highly predictable when you disable the seed
   update to EEPROM."

However, the atmel-sha204a driver doesn't operate the device in that
mode. It uses the Random command with seed updates enabled, which is
also what the datasheet recommends for highest security:

  "Microchip recommends that the EEPROM seed always be updated."

So the reported behavior doesn't reflect how the driver uses the device.

Thanks,
Thorsten

