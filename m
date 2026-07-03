Return-Path: <stable+bounces-271703-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J90YCYiDR2qfZwAAu9opvQ
	(envelope-from <stable+bounces-271703-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 11:40:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC47F700BAE
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 11:40:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=KwiUzH5b;
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271703-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271703-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 908F5302A2D8
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 09:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C453B3886;
	Fri,  3 Jul 2026 09:30:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D610D3B1EFB;
	Fri,  3 Jul 2026 09:30:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783071022; cv=none; b=uTIsSfybHHnsbmlMxwh9MI6eI2huVzK7xYnUTfN23T77tLyGkswJdEEZiByUcp9k51E2JrdpHvQhnW/Rrq9lIvi4k66CL1Wj4l91ktKprhtOcmaQajpPK268hN0ygwq03TlVrsxxUb1mmwJgzXOjTp8IibOo/iiA4DpgowIsUcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783071022; c=relaxed/simple;
	bh=S1IoBIHZUdKDEguos6xItwJ+mP/O3bM5hh2hub7XSw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lph6ZvHn/848CX9qvMgP7T0qfzD7WjNN4wPKQT7bkioNYLPCieaqvoJwsDxbuDX2oE5W1Khkv3Mn3EVbYRQlZ1zTCDCF9cXt3U4vlXVLEMmb0qbZEvzuZdOW2NcomXCtkx0k7H5RPkzF5JSNTMUOWZKftfVDxAW9YA7aMF9y3II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=KwiUzH5b; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=bMqWeaK7hx8ilXvf9UXlHNx3exT0cjWw/skeWOS9d0I=; 
	b=KwiUzH5b6Oj1wAV1vl2plhMHZA4GCujKD/16me5uZ9q2exGptX/3H9+bzJkAZ4Wy4owULNH4B7q
	HoeO4/4D8mc3L5vRXThM0O5+YdtZr6lQZ9+AqYi+3YeAHbDydgavoRTuNwqMzfic9Tf0luKQq1UFY
	Y7iOqyXfpG1fST5qliKT5VHgbUUZLm2CDV5ftVUU3XhfZB66S18KAuA5YZfrI+Dr08oQolUO1XgZR
	kpjt5Xe0ZF5532WO1R4oLFHvuKv9jdQAaWpRQvyOwwweHukUOre941o+WyQBeRFfIIa8z5Jf+NPF1
	Gthi0CBQxrnrTqPdN9uDJc3rJqnkrOC7olVw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wfaDv-0000000AKHj-0T0E;
	Fri, 03 Jul 2026 17:30:16 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 03 Jul 2026 17:30:15 +0800
Date: Fri, 3 Jul 2026 17:30:15 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Ayush Sawal <ayush.sawal@chelsio.com>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] Fix multiple issues in chcr driver:
Message-ID: <akeBJx_1I1yiRva0@gondor.apana.org.au>
References: <20260622151910.49402-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622151910.49402-1-vulab@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271703-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:ayush.sawal@chelsio.com,m:davem@davemloft.net,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:url,apana.org.au:email,vger.kernel.org:from_smtp,iscas.ac.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,gondor.apana.org.au:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC47F700BAE

On Mon, Jun 22, 2026 at 11:19:10PM +0800, Wentao Liang wrote:
> 1. In chcr_ahash_final() and chcr_ahash_digest(), chcr_send_wr()
>    return value is not checked. If it fails, DMA buffers are not
>    unmapped, causing leaks.
> 
> 2. In chcr_aead_op(), the inflight counter is not decremented when
>    assoclen validation fails.
> 
> Fix by:
> - Adding error handling for chcr_send_wr() with goto unmap
> - Adding chcr_dec_wrcount() on the assoclen error path
> 
> Fix the following functions with missing decrement on error paths:
> - chcr_aes_encrypt()
> - chcr_aes_decrypt()
> - chcr_aead_op()
> 
> For chcr_aes_encrypt() and chcr_aes_decrypt(), use a common error
> label to decrement the counter. For chcr_aead_op(), use the existing
> chcr_dec_wrcount() helper on the invalid assoclen error path.
> 
> Cc: stable@vger.kernel.org
> Fixes: b8fd1f4170e7 ("crypto: chcr - Add ctr mode and process large sg entries for cipher")
> Fixes: d91a3159e8d9 ("Crypto/chcr: fix gcm-aes and rfc4106-gcm failed tests")
> Fixes: 324429d74127 ("chcr: Support for Chelsio's Crypto Hardware")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/crypto/chelsio/chcr_algo.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)

Please take a look at

https://sashiko.dev/#/patchset/20260622151910.49402-1-vulab%40iscas.ac.cn

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

