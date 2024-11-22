Return-Path: <stable+bounces-94608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC83E9D6010
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 14:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8808DB23930
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 13:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FB07080E;
	Fri, 22 Nov 2024 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="arreEGHV"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F5712C484
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732283809; cv=none; b=q71sy2DMqp7s4UGPqxOrkZk71NCprkhNsJwUE5+4QeeWNHzjNTYoODHQ5BGIF5vSYPGTCZ4IcZwFmNnS762uoHh1x9xl+mGRE8fbDu8fzRGgIx2o7ut4HrYFoFx42fBj8KCmS7NalWz+T743RHmkDzOAVdvCRduyg1lyyb/JzFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732283809; c=relaxed/simple;
	bh=F5aya4RZtGN+Ky+B6lErkwIwz2AG1ztgw649Q5PMHqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=INWa4oXiNTPYv6phh9VbfD5pGmK8wCNT2plYHCR2z8CtBeUPA5ehHTQwsyNn7gVFjlLfNiV5JdYgUpT+aRBeyPmiiGENkRrfnuDkwbnqfc1lVbt4s/8Ak3udjUeiwWIb068M+jBBmkRyHzgzZiacTck7Lb9KUHDbbHwIHvnV3rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=arreEGHV; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id DAC84A0788;
	Fri, 22 Nov 2024 14:56:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:content-transfer-encoding:content-type:content-type:date:from
	:from:in-reply-to:message-id:mime-version:references:reply-to
	:subject:subject:to:to; s=mail; bh=JR4asJb1GMWwoUXaXOmTFULL1czCV
	sxfxN1S3Jaxm0Q=; b=arreEGHVF8Q5qMymSwDWIxbe5kZxO3rbhWmS0pXiwiuIn
	tcVN2XC/kST7gg4ein2WlmoP2ZEOHnK3jRzIXcRu6b6L36uKTBu86h7iW1wNgyg8
	7MxlRGQosWkHPPuzwg5yoQpJ261hE/qofUE85XH0bxPItOR33f2O3EgQHpX6dE0u
	GN27plE8lGF4aBGDZzui2n9PenDPtNbAr5Lz9PHlpZ8qsmqlfXCGlGROD/hiZMFa
	lCkFEAh0MchdZWq7eYSPCukNlmLKlfxlUe4EL54SkC8gV0eX1nerf7+TAUf1CaFm
	s22NDLS2eRx0uebqEiXG7yqnj8a0zj888UGx1lbkqyfprEX8YLfm0d1qDJlDG3AY
	B9Mid356zzsnqOccW51UVcFpS53SHJhZF6tU/UN+FJoGWDc6d2ugxfD6fJaGAI/h
	AVgpqZdZDj4sx7NrkSBPle1yZs1Tai6NjR8P/VrOAnKSn/N2plivZiRJxgpZAxUr
	CklQsdIgtQicqWs/UPiXW791lVQpbe+WU7OYegu3sIPC6XDUPXYmPaUR7H1cygjX
	OCL9vH7a8AyWhSDoeC8NCDKUOvO8Y7f5Z6eiM3uTCxYnfwXyQyr+2HqLuTeymq4Q
	kGz/lTQ3Z2fX7MAtlfuHeb3HGeMfUzosVn6qybJlOeNHk3mLmxXjwpb7xw8Na8=
Message-ID: <30b031c5-b3f4-44e4-9217-c364651ab28e@prolan.hu>
Date: Fri, 22 Nov 2024 14:56:40 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 1/3] net: fec: Move `fec_ptp_read()` to the top of the
 file
To: Sasha Levin <sashal@kernel.org>, <stable@vger.kernel.org>
References: <20241122083920-54de22158a92c75d@stable.kernel.org>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20241122083920-54de22158a92c75d@stable.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D9485560736B

Hi,

On 2024. 11. 22. 14:51, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
> 
> Hi,
> 
> Found matching upstream commit: 4374a1fe580a14f6152752390c678d90311df247
> 
> WARNING: Author mismatch between patch and found commit:
> Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
> Commit author: Csókás, Bence <csokas.bence@prolan.hu>
> 
> 
> Status in newer kernel trees:
> 6.12.y | Present (exact SHA1)
> 6.11.y | Present (different SHA1: 97f35652e0e8)
> 6.6.y | Present (different SHA1: 1e1eb62c40e1)

1/3 and 2/3 of this series was already applied by Greg, only 3/3 was not.

commit: bf8ca67e2167 ("net: fec: refactor PPS channel configuration")

Bence


