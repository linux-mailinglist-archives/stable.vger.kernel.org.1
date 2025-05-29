Return-Path: <stable+bounces-148107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1ABAAC8114
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 18:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0535D3AE05F
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 16:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AA722DA07;
	Thu, 29 May 2025 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="VT68uo7O"
X-Original-To: stable@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A2119F10A;
	Thu, 29 May 2025 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748536900; cv=none; b=lD6IJaNw7jehr1wHRCm/hyk/1ye0qVdMd6c0/9FuNNaXGZfLeZ5ob42dBJ93UfKJhyVsTqFAXYKcVXxNT6nv1tkn2oc04Z5C1nbZGrszY9iWqn1oZOZdFJqwshva5Bnhtp3zBfeFxLF94SG0ksE0ryBfDqrE5EDElwyiV/nny/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748536900; c=relaxed/simple;
	bh=XbHt1o9qz+QPaqIKZZnKujp7chpjrPOWYuczmhp3iVA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hH+fqRQSllL0CR30qqH39L1Y6d4DqubGoA2D2LpQDPpTnPgdFmH9L4XpawjTCtxWwWpbivZOluyXm06S5yNh7RvXpXoY45WBi4nLk9PNvXl2QbYahVk1Ze9dFj0Aqsr7L9vdaMzcX3v4IgUZoXYmXXcOhEfL/Momka4I3ILWH88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=VT68uo7O; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XbHt1o9qz+QPaqIKZZnKujp7chpjrPOWYuczmhp3iVA=; b=VT68uo7OxcpBG5Rb0DbofuRIFm
	HAcqrM3YPY9m6JIVfoKOmbK9XFYTpD1IKdHKZUHCK98Qa6nbXHILfXVN9hQ6Vot1J3YRaQDX1JYCx
	ze5P105NN+MAq1dlElyV4pplH6ap96s8g+gDeGj+vqxisJAKn6a9SNx8j996AygpEhLb6JjD/XYK5
	sTWjmk+AHr02MHVvxdUebmFgAKrbI1J81cjZDgCzyuzNZ5Umr+bNib7cb89x8lO1brg9bTiKDOvJC
	Xavkd0Fz7lnZjrZ3uMVNOry3gBL/yDR9vdiTo4msJEW/qOIQGwVftQNBhbv6gClKTxiHwo6CRsJBZ
	Rt6VGBCQ==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1uKgDz-000000003XO-2Ja4;
	Thu, 29 May 2025 12:35:23 -0400
Message-ID: <aa5f8dbbb5865e7eeb64628beef24fe05d161855.camel@surriel.com>
Subject: Re: [PATCH] x86/mm: Fix paging-structure cache flush on kernel
 table freeing
From: Rik van Riel <riel@surriel.com>
To: Jann Horn <jannh@google.com>, Dave Hansen <dave.hansen@linux.intel.com>,
  Andy Lutomirski	 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Toshi Kani <toshi.kani@hpe.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Thu, 29 May 2025 12:35:23 -0400
In-Reply-To: <20250528-x86-fix-vmap-pt-del-flush-v1-1-e250899ed160@google.com>
References: 
	<20250528-x86-fix-vmap-pt-del-flush-v1-1-e250899ed160@google.com>
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

On Wed, 2025-05-28 at 22:30 +0200, Jann Horn wrote:
>=20
> Note that since I'm not touching invlpgb_kernel_range_flush() or
> invlpgb_flush_addr_nosync() in this patch, the flush on PMD table
> deletion
> with INVLPGB might be a bit slow due to using PTE_STRIDE instead of
> PMD_STRIDE. I don't think that matters.
>=20
Agreed that this is probably fine.

The performance sensitive kernel flushes mostly seem
to be small, related to static key toggling, etc

> Cc: stable@vger.kernel.org
> Fixes: 28ee90fe6048 ("x86/mm: implement free pmd/pte page
> interfaces")
> Signed-off-by: Jann Horn <jannh@google.com>

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

