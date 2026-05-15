Return-Path: <stable+bounces-247650-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBaQDnH7Bmp1qQIAu9opvQ
	(envelope-from <stable+bounces-247650-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:54:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D60254DD23
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 467D231E4818
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91203D16EE;
	Fri, 15 May 2026 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="m41ViD7k"
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B133D0BFF;
	Fri, 15 May 2026 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840840; cv=none; b=e9C4FrUW7bdfhop3bpeiIy5i3qyydZ+L8Ty5sy2EIJSuCFKUxqodwQvJGWUZojw7pASIJD5rWuZxuIq60l1v1fzy7C+RMcIJkWXXIjkE4xnWzQ1B1taSNMh76NmwI8pwXtA67QBFxwqT160J+ny0Z8KcH3rSrPP5lz3qRNLtUeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840840; c=relaxed/simple;
	bh=c468QXYz5itwD5TKpkIk1ARB0vs+NdzRfjROrTmrJsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2h2sTWJTWnFMraXfBWpQ1dtiqErNGj9BttAkhotXcXE7ql+t/qvFIBAwM1e9y3i39/JRZSZDmb+nlivhqQaKc4UsKqBNpLvwxFyw174DMcdVDwH5dyX3Mh6j3aAlgCL4JFqrdkzZaOlF89ELTebk9RCrWT2VSQv8ecmLwHJu/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=m41ViD7k; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=9G1ALRqYKbjNfcTKGMoNtfKv7WmzEN5J93MbDdOhgmw=; 
	b=m41ViD7kr8cluaR9ueZnWAEOxUXBwKRYxMXsLBYLjCenZ5yadDrvmt5jXda4wrXgPCqNkURH7Bj
	oYP9zv/5JRSwr5rKOpBKU5zKgUmyb5d5i3NwmtujeBPi/RgGE6YxRh4Z32YM6S6xfXJjdUEP6eyUs
	WEeq1uN8hhn2HZkbOfC5XpJk3ZfO3JvgkO/TqAoYAsbU0DJyLcKamlg8O+vxk1czZzuAhZuDo93gy
	ol9O/ki29wJRLVjNx7ywDV9DiOHslWtga0d04GPjpI13x7OH/OLugYbHAYQtpIMR5xgC/v+T4m27Y
	JeG13Jn4sVzzga36F01/zVd6q0UbNT8eohWg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wNpl3-00EOev-0G;
	Fri, 15 May 2026 18:27:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 15 May 2026 18:27:05 +0800
Date: Fri, 15 May 2026 18:27:05 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org, Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crypto: krb5 - filter out async aead implementations
 at alloc
Message-ID: <agb0-eaQSBTRu7RB@gondor.apana.org.au>
References: <20260502132506.1936358-1-michael.bommarito@gmail.com>
 <20260510232455.2245650-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510232455.2245650-1-michael.bommarito@gmail.com>
X-Rspamd-Queue-Id: 8D60254DD23
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,vger.kernel.org,kernel.org,auristor.com,lists.infradead.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-247650-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Sun, May 10, 2026 at 07:24:55PM -0400, Michael Bommarito wrote:
> krb5_aead_encrypt(), krb5_aead_decrypt() in rfc3961_simplified.c and
> rfc8009_encrypt(), rfc8009_decrypt() in rfc8009_aes2.c set a NULL
> completion callback and treat any negative return from
> crypto_aead_{encrypt,decrypt}() as terminal, falling through to
> kfree_sensitive(buffer).  When the encrypt_name resolves to an
> async AEAD instance the request returns -EINPROGRESS, the buffer
> is freed while the backend's worker still holds a pointer, and the
> worker dereferences the freed slab on completion.
> 
> KASAN report under UML+SLUB with a synthetic async aead backend
> bound to krb5->encrypt_name:
> 
>   BUG: KASAN: slab-use-after-free in t5_stub_complete+0x7d/0xc7
> 
> The helpers were written synchronously, so filter the async
> instances out at allocation time instead of plumbing
> crypto_wait_req() through every call site.
> 
> Reachable via net/rxrpc/rxgk.c, fs/afs/cm_security.c and
> net/ceph/crypto.c on systems with an async AEAD provider bound to
> the krb5 enctype name.
> 
> Fixes: 00244da40f78 ("crypto/krb5: Implement the Kerberos5 rfc3961 encrypt and decrypt functions")
> Fixes: 6c3c0e86c2ac ("crypto/krb5: Implement the AES enctypes from rfc8009")
> Cc: stable@vger.kernel.org
> Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  crypto/krb5/krb5_api.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

