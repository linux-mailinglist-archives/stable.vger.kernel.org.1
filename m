Return-Path: <stable+bounces-260240-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d4V9I6/dIGqE8gAAu9opvQ
	(envelope-from <stable+bounces-260240-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 04:06:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8ED63C5B4
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 04:06:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=XjyLTSSX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260240-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-260240-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45AEE304F401
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 02:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C89288C0E;
	Thu,  4 Jun 2026 02:01:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C384D1A6822;
	Thu,  4 Jun 2026 02:01:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538508; cv=none; b=qfqPxoGuokTjdUWzfUQLCVoCNQqxRDBCTxyvhOofn/+laVYEo9M+cke9ep8L6iUr6DwtlFaEWgK1O2a/JvjoHLcF9aEqgCPwrlYuOWZHWH+vloBlvwMiJCM9UGEVumhQipS+g3UhhVSZ0yl0DWPdn82a6lTAkO4PrJtJ1xy/WQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538508; c=relaxed/simple;
	bh=e5mkK9PoC3Bvz4+z3gJ98WPOxTQQkV5l42WCSMAbTdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqUw7B5Ew8HZEqBL10wiMNg8oRGb85tnpLUl20mxbQQqYeQjj7fgClY/zQ4P0q0pdM4dks4DZ8heoj6VoQ8X1HggpoYNLQ6vihOZ9zWH5uo7IHFpf5TJaByZ+WWVOESJyTjCNicOAvK6D6mk1eLMHonhn/pIrUgsL/ZwIGvndPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=XjyLTSSX; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=MI3brEEaTAwdgrtrzuIzMmSJFaeGXyuOqsGFkQ7a85k=; 
	b=XjyLTSSXKXoBn1vcFIGtTBTIR5kY/WCwFl8Gdoh6gSb8yZweIMnv2M7BOYuVegOT/syGObSdV+S
	0IVKzh5Cgyh0C4gZfeU5hBdTNht08GUVoNs7mJ+9Z7MKQ44ZowzAHot2VogJFq9jkfSvnMmAkyxYO
	BTvbJxgNMlKP37yX314w/3O9qSmSxYAqj4eh1FP6AjcDmOMUpaOYDWqsh+rRnKMPglnbGciy0Sb2A
	M72OTXnOmDsnK0w4URoMlRlh5koreiCpJzhk5otfqc1m2pqagstYLI8M+ZQC0ZMS4yDvWNFtD8W6+
	2F+eTTrTYh8Y4RuG/Fsu4MqeQ+IvU13q7x9A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wUxOt-002DLW-0U;
	Thu, 04 Jun 2026 10:01:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 04 Jun 2026 10:01:39 +0800
Date: Thu, 4 Jun 2026 10:01:39 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] crypto/algapi: fix refcount leak in
 crypto_register_alg()
Message-ID: <aiDcg4CL92mdFqfA@gondor.apana.org.au>
References: <20260603082140.3719314-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603082140.3719314-1-vulab@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260240-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:davem@davemloft.net,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,apana.org.au:url,apana.org.au:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB8ED63C5B4

On Wed, Jun 03, 2026 at 08:21:40AM +0000, Wentao Liang wrote:
> When crypto_register_alg() calls crypto_check_alg() successfully,
> the algorithm's refcount is set to one.  If the subsequent handling

The algorithm wasn't registered anywhere and the refcount isn't used.

I fail to see the point of your patch.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

