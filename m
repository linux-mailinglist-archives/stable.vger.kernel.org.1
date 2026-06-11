Return-Path: <stable+bounces-262642-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2PeSHk95KmopqQMAu9opvQ
	(envelope-from <stable+bounces-262642-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 11:01:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0EB670211
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 11:01:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=VM6jG7hf;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262642-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262642-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B2E231AB674
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 08:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2623BADB7;
	Thu, 11 Jun 2026 08:55:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18D33BAD9B;
	Thu, 11 Jun 2026 08:55:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168132; cv=none; b=Ud9wvGLzYUq1drAQsf/zUbyTGRvOGJQ3z29AoOyveIoYJ1tYIztmJxNgZakttmqiPLkRxIIeoVtoax3QqetANtuM8Nlpk1X9OYxoNGlthiIud92gLokwZPWgAqwgaABNmfNShKGTNnwQAcq0xso9GqZpiTBbCe6zX615074jwhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168132; c=relaxed/simple;
	bh=EjysZ4q466U4CjRorId75exWpK2cykdobnNWz32Ax38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGxoYqqzSulcHHi6MHBhSwjH70GqW+jQV+7xLa5rSkoBtECrkHllXh0xPuFejFRVqHvgfKbjS0M17n9/0s0Ld9DKkJJ5NUksAIoqCliRiX8pzbgRCZhaM3KC5Xh9rNVdW2LwL+IOhJ+nq4Law5trhOYfk/gwkVUI4JvyHDIpTgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=VM6jG7hf; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=CR3A2dDva0uLF2AhHsEv/ds0RRniV9rJ8VnU5N4/N1o=; 
	b=VM6jG7hf2hRxhDD2tyVtiMngdCVqX3/4rCveWnnwvm0CRGyTeVkVz1wuhwj7F+f7RXrbeCNI8oS
	ugJ/Jvt82gGbMxOSYCZbOo6A9VBgs6/SQck/ErM4M2nqD9rm+mlR7xn58IPo08gAENtpDednML+8q
	n/jS3dv+tlJI0xKjI66pGjHW7xFggbGgBS0xpueGi/OaCZQIb43ddu7pcFqxx99m8IECZgdPWDETA
	ApobPeI0zvdt3+ShBs+98Hyu7eLMlPp00KjWipGwuGQRuWY1TMaCK8jlrkGkFwWaTINYmWc9uV5R0
	5aGmOoQy4+Su4K2vmPKKHqJQnFSyFXLazubQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wXbC8-00000004Xdu-3g5Y;
	Thu, 11 Jun 2026 16:55:25 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 11 Jun 2026 16:55:24 +0800
Date: Thu, 11 Jun 2026 16:55:24 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: akhilrajeev@nvidia.com, davem@davemloft.net, thierry.reding@kernel.org,
	jonathanh@nvidia.com, linux-crypto@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] crypto: tegra: fix refcount leak in
 tegra_se_host1x_submit()
Message-ID: <aip3_Hqk876NZFHf@gondor.apana.org.au>
References: <20260604102706.3787771-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604102706.3787771-1-vulab@iscas.ac.cn>
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
	TAGGED_FROM(0.00)[bounces-262642-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:akhilrajeev@nvidia.com,m:davem@davemloft.net,m:thierry.reding@kernel.org,m:jonathanh@nvidia.com,m:linux-crypto@vger.kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gondor.apana.org.au:dkim,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime,iscas.ac.cn:email,apana.org.au:url,apana.org.au:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E0EB670211

On Thu, Jun 04, 2026 at 10:27:06AM +0000, Wentao Liang wrote:
> The timeout error path in tegra_se_host1x_submit() returns without
> calling host1x_job_put(), while all other paths (success, submit
> error, pin error) properly release the job reference through the
> job_put label.  Since host1x_job_alloc() initializes the reference
> count and host1x_job_put() is required to drop it, omitting it on
> timeout causes a permanent refcount leak.
> 
> Fix this by redirecting the timeout return to the existing job_put
> label, ensuring the job reference and any associated syncpt
> references are consistently released.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0880bb3b00c8 ("crypto: tegra - Add Tegra Security Engine driver")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/crypto/tegra/tegra-se-main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

