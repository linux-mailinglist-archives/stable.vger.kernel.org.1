Return-Path: <stable+bounces-131964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC6DA827E5
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 16:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD751B8628A
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 14:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F007E265CDD;
	Wed,  9 Apr 2025 14:31:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8D32AE8C;
	Wed,  9 Apr 2025 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209064; cv=none; b=nFTGjtIgUXjQy177NvLaxGNHVLZml4k59DWdaJVVJRq8r1fVMB0dgRNIIzCcDcc6DZHjmZh/FTjbCj67dlXZeyjMzfviTjqBurwGPACKRb2lHTtWMqfO5infy43KL06Hwj+Da0D0khdV+00w/MzXLLKMkwsvUBRiP7Fo1I3gMfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209064; c=relaxed/simple;
	bh=s0NzUKVb7lb9yEmHu5yIFqmjEb9Je27PNTYazyFZHXE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f/zljqDbNQx+XPhgY99qrybGuCoOn+tom1TWisJSN4gWnZ9MUoxFTXnsjSDZH0BNuxAYxxImGLau4rZ/Jf3YXVwrItvEUYcWtp+sf83hy3zU8LJOK1kwSb35c1+xxFOar0DxtiMMroPr6fPe8Ijym4L2UTLw9ABqeyIR+DP31wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1u2WQx-000000001hz-2Yjl;
	Wed, 09 Apr 2025 10:29:43 -0400
Message-ID: <b40f830845f1f97aa4b686c5c1333ff1bf5d59b3.camel@surriel.com>
Subject: Re: [PATCH] sched/fair: Add null pointer check to pick_next_entity()
From: Rik van Riel <riel@surriel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Pat Cody <pat@patcody.io>, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, patcody@meta.com, kernel-team@meta.com, 
	stable@vger.kernel.org, Breno Leitao <leitao@debian.org>
Date: Wed, 09 Apr 2025 10:29:43 -0400
In-Reply-To: <20250402180734.GX5880@noisy.programming.kicks-ass.net>
References: <20250320205310.779888-1-pat@patcody.io>
	 <20250324115613.GD14944@noisy.programming.kicks-ass.net>
	 <9d38c61098b426777c1a748cf1baf8e57c41c334.camel@surriel.com>
	 <20250402180734.GX5880@noisy.programming.kicks-ass.net>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Wed, 2025-04-02 at 20:07 +0200, Peter Zijlstra wrote:
>=20
> Anyway, seeing how your min_vruntime is weird, let me ask you to try
> the
> below; it removes the old min_vruntime and instead tracks zero
> vruntime
> as the 'current' avg_vruntime. We don't need the monotinicity filter,
> all we really need is something 'near' all the other vruntimes in
> order
> to compute this relative key so we can preserve order across the
> wrap.
>=20
> This *should* get us near minimal sized keys. If you can still
> reproduce, you should probably add something like that patch I send
> you
> privately earlier, that checks the overflows.

Our trouble workload still makes the scheduler crash
with this patch.

I'll go put the debugging patch on our kernel.

Should I try to get debugging data with this patch
part of the mix, or with the debugging patch just
on top of what's in 6.13 already?

Digging through our kernel crash history, this
particular crash seems to go back at least to
6.11. They just happen much more frequently on
6.13 for some (as of yet unknown) reason.

--=20
All Rights Reversed.

