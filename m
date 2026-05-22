Return-Path: <stable+bounces-253690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kP9dCIjVD2rIQAYAu9opvQ
	(envelope-from <stable+bounces-253690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 06:03:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C785AE758
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 06:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88D2E300C322
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 04:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89472E889C;
	Fri, 22 May 2026 04:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fzw245aG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6F516132A;
	Fri, 22 May 2026 04:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779422594; cv=none; b=DIgK+Bf3kkeL38palXxyo7lFgyXHOh8DcUGzdoeWNYKIBC2Dvm2ktK06U7v0SkArqv3ZhZmxQzZba9wBrpXqswgv90H7l1ZW4kEPC8pTizJrAxSR5dJ3WEiAcY44mx27MIcM4YGQIY9FW8+7zBMrqfeO/HWq7J8WVPbHUdRTgUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779422594; c=relaxed/simple;
	bh=xiiZRP6hXLWGeaeMP1v9nsAzQsMpG2+cBK9laf0bea8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvCI05j9llsz3wqH6sZsxTcz6GvCWkCAQ+wCtwcm+g2kspIgTcA+bnjJA9IHocb+EGOy4YSdjQkuMx88AgL2w+T7GryaQSb8UR2wBCA3dQlqCWU6W8xh9mOlyXa7SZJNtKxbkvYnNOuHCeMx5ReVdFbQdN1cWpsvelRkBLBL1tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fzw245aG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B11E1F000E9;
	Fri, 22 May 2026 04:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779422593;
	bh=KagJCHZGm97VwO+oJJeo9dDHOSAchsZPpQeqpcu3Xic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Fzw245aGo0UcHxQtfkTOPd5OTFivCE5cZ84c4H7qQ5Rl5tQAOw8aA41hR2/Va7qHE
	 Pksya+Z/TLnwTbmsfWSyfCFPfdUMNSliuWcIXK9QbS5H09ciioxSZ6TWplbpKb/PtM
	 SEwsqKfg0jQGWvEB1Ij7wXZaOOYfQlo1Jzf6bqjYjkfjO0zR2jjgC2b4g0My/dVlgX
	 vnR3DHnWbUTqxf1GPJHS4buJ5T9jRSlEfwDMis82gAW54RmkUzjXs4FUanjklhehkF
	 itF/7Ch2NKeNI9kqtMOvL9KzOleLxo5t2ak9LdqtQs5EFs3mevZcTEWUlPCylN/jLB
	 iz+jVNW7ebkZg==
Date: Thu, 21 May 2026 23:03:10 -0500
From: Eric Biggers <ebiggers@kernel.org>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	Yinggang Gu <guyinggang@loongson.cn>, Lee Jones <lee@kernel.org>,
	kernel test robot <lkp@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] crypto: loongson - Select CRYPTO_RNG
Message-ID: <20260522040310.GF5937@quark>
References: <20260522022525.12976-1-ebiggers@kernel.org>
 <CAAhV-H5cDnWKxBobwRErRyvG8671e6VXsBe6w1RkX9rfn7CVFA@mail.gmail.com>
 <20260522025722.GD5937@quark>
 <d71adfa1-8895-e741-b72f-c5e99d5fb9e6@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d71adfa1-8895-e741-b72f-c5e99d5fb9e6@loongson.cn>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253690-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,loongson.cn:email]
X-Rspamd-Queue-Id: B5C785AE758
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 11:41:15AM +0800, Qunqin Zhao wrote:
> 
> 在 2026/5/22 上午10:57, Eric Biggers 写道:
> > On Fri, May 22, 2026 at 10:52:42AM +0800, Huacai Chen wrote:
> > > On Fri, May 22, 2026 at 10:26 AM Eric Biggers <ebiggers@kernel.org> wrote:
> > > > This driver registers a rng_alg, so it requires CRYPTO_RNG.
> > > > 
> > > > Fixes: 766b2d724c8d ("crypto: loongson - add Loongson RNG driver support")
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes: https://lore.kernel.org/oe-kbuild-all/202605201622.qWOiiZTV-lkp@intel.com/
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > > Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > ---
> > > >   drivers/crypto/loongson/Kconfig | 1 +
> > > >   1 file changed, 1 insertion(+)
> > > > 
> > By the way, do any of the loongson people have any comment on what they
> > think the point of this driver is?  It's not registered with the actual
> 
> To provide an AF_ALG-based random number generation interface for other
> modules and user-space programs.
> 
> Thanks,
> 
> Qunqin

AF_ALG is a userspace interface; it's not available for in-kernel use.
If you mean using crypto_rng directly, note that no kernel code actually
uses it other than the tests, the implementation of AF_ALG, and the
FIPS-specific code which uses drbg.c specifically.

So, the first half of your justification doesn't make any sense.

As far as the second half: why would a userspace program do that instead
of just using the regular Linux RNG (/dev/urandom)?

AFAIK, the only reason to use a HW RNG directly is for certification
reasons.

However, there's also already an interface for that: /dev/hw_random.

So AF_ALG seems completely redundant for this case.

- Eric

