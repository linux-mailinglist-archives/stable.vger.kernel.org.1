Return-Path: <stable+bounces-127418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F754A7919C
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 17:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E53E3B242A
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 15:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D1523BD0C;
	Wed,  2 Apr 2025 15:00:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0CF23BD09;
	Wed,  2 Apr 2025 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743606011; cv=none; b=Ljte44PsB67URQMiyGjpfUfCwyghn2djW88uUvqorKmTyiPajSh5lMwtRO9+wjReMTQIM69yVY4OloDr1XzpOY9LteOl5AZgWHqMGNmkaqn53/u4DdquhvSWkdTgbLgtHFSEtKhYiA+7Nq69sECfGqr/Pc5VNHYiuQ8QYirHFI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743606011; c=relaxed/simple;
	bh=QDR3wL0XPBW/EDcrWr7RCbY09c1dPTtj1ZoruraubdI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CAyUx/6Ug6kOtpIwDTRl/2uyck/tDVNqS9N6rIiwoJiI2oVXCV6wS8cJ2VYtfeRMQYkBYp0MWKHZjsOV3/9Aaprrmz0DSvCyExte181e3p1vU98HuUSGsitDto0DREXSd+x9L2Ui9nzjgf+TR9MTbUfGW5l14gSOCvyFRrG87CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tzzYb-000000007Vk-0UjT;
	Wed, 02 Apr 2025 10:59:09 -0400
Message-ID: <9d38c61098b426777c1a748cf1baf8e57c41c334.camel@surriel.com>
Subject: Re: [PATCH] sched/fair: Add null pointer check to pick_next_entity()
From: Rik van Riel <riel@surriel.com>
To: Peter Zijlstra <peterz@infradead.org>, Pat Cody <pat@patcody.io>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, 	vschneid@redhat.com, linux-kernel@vger.kernel.org,
 patcody@meta.com, 	kernel-team@meta.com, stable@vger.kernel.org, Breno
 Leitao <leitao@debian.org>
Date: Wed, 02 Apr 2025 10:59:09 -0400
In-Reply-To: <20250324115613.GD14944@noisy.programming.kicks-ass.net>
References: <20250320205310.779888-1-pat@patcody.io>
	 <20250324115613.GD14944@noisy.programming.kicks-ass.net>
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

On Mon, 2025-03-24 at 12:56 +0100, Peter Zijlstra wrote:
> On Thu, Mar 20, 2025 at 01:53:10PM -0700, Pat Cody wrote:
> > pick_eevdf() can return null, resulting in a null pointer
> > dereference
> > crash in pick_next_entity()
>=20
> If it returns NULL while nr_queued, something is really badly wrong.
>=20
> Your check will hide this badness.

Looking at the numbers, I suspect vruntime_eligible()
is simply not allowing us to run the left-most entity
in the rb tree.

At the root level we are seeing these numbers:

*(struct cfs_rq *)0xffff8882b3b80000 =3D {
	.load =3D (struct load_weight){
		.weight =3D (unsigned long)4750106,
		.inv_weight =3D (u32)0,
	},
	.nr_running =3D (unsigned int)3,
	.h_nr_running =3D (unsigned int)3,
	.idle_nr_running =3D (unsigned int)0,
	.idle_h_nr_running =3D (unsigned int)0,
	.h_nr_delayed =3D (unsigned int)0,
	.avg_vruntime =3D (s64)-2206158374744070955,
	.avg_load =3D (u64)4637,
	.min_vruntime =3D (u64)12547674988423219,

Meanwhile, the cfs_rq->curr entity has a weight of=20
4699124, a vruntime of 12071905127234526, and a
vlag of -2826239998

The left node entity in the cfs_rq has a weight
of 107666, a vruntime of 16048555717648580,
and a vlag of -1338888

I cannot for the life of me figure out how the
avg_vruntime number is so out of whack from what
the vruntime numbers of the sched entities on the
runqueue look like.

The avg_vruntime code is confusing me. On the
one hand the vruntime number is multiplied by
the sched entity weight when adding to or
subtracting to avg_vruntime, but on the other
hand vruntime_eligible scales the comparison
by the cfs_rq->avg_load number.

What even protects the load number in vruntime_eligible
from going negative in certain cases, when the current
entity's entity_key is a negative value?

The latter is probably not the bug we're seeing now, but
I don't understand how that is supposed to behave.


--=20
All Rights Reversed.

