Return-Path: <stable+bounces-226983-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wB23BptYumnFUgIAu9opvQ
	(envelope-from <stable+bounces-226983-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:47:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 053FD2B72AE
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F7653024B03
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 07:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B7E36829E;
	Wed, 18 Mar 2026 07:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="b73Y5B1H"
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE6F36C0BC;
	Wed, 18 Mar 2026 07:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820032; cv=none; b=ox30qGxLDmuWRCbUeoY43gpOr98qgBQlTq5Vy46wShWwzWS+eyfUXRvnDv+kPMhqhlyHd+rhy0pOy1aa6y8vFdz9wUhNl0VwX73hrSQD2Ut6T5GWUN0ESZeO19kaPg5SXVdeUVF6KdMBqi0k8/IRHVgniHZ9msLEkLXImaTljqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820032; c=relaxed/simple;
	bh=T3QbSpCvAmJuC6q7XUzs1vLPmnaFL51lUVEUyf/YqHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQs0nP83Fanp9HvUGsClowIjG1CcvfuKUGRFIF4rmtqNjRVtGFZXlj/3bfPXUcKscFGv1TlqBiBovpRNuApJ7Td3lGmEFw8RyjyR0t6Fc8Da8MLS4PmZ2rg+207pTHkRyr/WazuIGBECREv6WSNaiKEki5BoEF2HZNpEh8XkJkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=b73Y5B1H; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=/sSz2iuMzmeiie9cePxSe9KQ1urOHv0hHVTFDqxwKEI=; 
	b=b73Y5B1Hn56XgUxEorg1OPus1w/ERpvthYvI6fD7Bev6bm8Nm8Q//el7Z+qP5pok8xDmHNY1fLF
	Mhkt2lBbnZlwDC0lXvNzDlp7M8L5vo5q/Zay/1gQjJ5ngmgYs4lyhyEwGCQ1ancQIaiWCzKy5G+qu
	YPMeMrNc7pb97DvF2tzMtS+Fby4rHxoJGiRTgXivD7MdCXWoJ4gm1FKFrbfKJPuChET8wUww+K4iu
	XSGOF2eNgXT8BxAxaY3IY6NPxnKoi7SO+FWBv1jkdPahoTZ9B7faGF4QuouayhqDcxzAkXtlMSnEv
	0l2pOrXSH1FyIM9oAxtoKDsee0FwJYdu19pQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w2lbu-00FMVe-0V;
	Wed, 18 Mar 2026 15:46:35 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 18 Mar 2026 16:46:34 +0900
Date: Wed, 18 Mar 2026 16:46:34 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Gaurav Jain <gaurav.jain@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Kim Phillips <kim.phillips@freescale.com>,
	Yuan Kang <Yuan.Kang@freescale.com>, stable@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: caam - remove HMAC key hex dumps from
 hash_digest_key
Message-ID: <abpYWkDzofozlOWp@gondor.apana.org.au>
References: <20260306111204.302544-1-thorsten.blum@linux.dev>
 <abTqefme_iApfHZi@gondor.apana.org.au>
 <abk4_r-KUYIhvyNL@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abk4_r-KUYIhvyNL@linux.dev>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.957];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:?];
	TAGGED_FROM(0.00)[bounces-226983-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_DKIM_TEMPFAIL(0.00)[gondor.apana.org.au:s=h01];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DMARC_DNSFAIL(0.00)[apana.org.au : SPF/DKIM temp error,quarantine];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 053FD2B72AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 12:20:30PM +0100, Thorsten Blum wrote:
>
> This is not specifically about caam, but (debug) logging of potentially
> sensitive key material should generally be avoided, imho. Some other
> recent examples:
> 
> https://lore.kernel.org/lkml/20260227230008.858641-2-thorsten.blum@linux.dev/
> https://lore.kernel.org/lkml/20260303132552.65235-2-thorsten.blum@linux.dev/
> https://lore.kernel.org/lkml/20260303190350.78705-2-thorsten.blum@linux.dev/
> 
> > Is there a scenario where production systems will run with debugging
> > enabled in caam?
> 
> I don't know - possibly.

I think a better solution is to turn these sensitive printk's to
pr_devel.  That way you can still get them by recompiling the kernel
but they won't be enabled in any distro kernels.

What do you think?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

