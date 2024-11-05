Return-Path: <stable+bounces-89828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFF99BCD2B
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 13:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0CB1C21136
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 12:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF461D8DE8;
	Tue,  5 Nov 2024 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b="cmH8Er1t"
X-Original-To: stable@vger.kernel.org
Received: from gmmr-4.centrum.cz (gmmr-4.centrum.cz [46.255.227.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1662F1D63E1
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.227.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730811417; cv=none; b=VuS0+GmzOa/gMog8tBx8OtvJ5iiVcuTqCp+OxrJLad8/MjnWJtP4tg1R42zRiongZu5+5cqS63+tpCfjwHC+cvKQRaM8RfwNKuybYitev+wMHYW/0iSFasM2FYEt+TiRPzXBHKXbSHjQtOrdfVLnmD2fsPrH1psC21G5PhQG8Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730811417; c=relaxed/simple;
	bh=PaIZG7LKfTXDSBoM9/sIN/f3H/7nWTP+Oc/+6zcMQ7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAlNlJJfVWv2HJ/DPZSku022dmcoZjAxrfXf8z0Un/26Ha3QdZzoIFk5dH6iRSgcuf9XCO1DbbL8AH1T1dmb9F+KiM/WCTAdBUvdtbYJYLwyysyLmuExf30D6qHmpklJB/NB0a/wqhwrhf8kQPsQljVxVuKRwBq/wL0dk0EPRTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz; spf=pass smtp.mailfrom=atlas.cz; dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b=cmH8Er1t; arc=none smtp.client-ip=46.255.227.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlas.cz
Received: from gmmr-4.centrum.cz (localhost [127.0.0.1])
	by gmmr-4.centrum.cz (Postfix) with ESMTP id 1A0DA78D6
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 13:56:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atlas.cz; s=mail;
	t=1730811410; bh=5yjsHLoQKY5oXVtSKUHU3jn2zkoux8pOgHzo1JpTL64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cmH8Er1tifsM68H6mpjcokc3vjE/bSlmMLqxEeHZygAt3qWO+KIpckRov8vlgUWy/
	 VJgmEsKykn2Mm7w359Ro/a+RytAsK3MDkec8MVkG3iqtaks5MEijvTQlParfUvloBg
	 jFFxLXTXJFs51ct0k0OGn3KjiB7IHEd18781Uf5E=
Received: from antispam28.centrum.cz (antispam28.cent [10.30.208.28])
	by gmmr-4.centrum.cz (Postfix) with ESMTP id 1878A200E280
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 13:56:50 +0100 (CET)
X-CSE-ConnectionGUID: jux3GT8ARtOmuqQObrBA/g==
X-CSE-MsgGUID: 7jP+OOwjR66932u48gd2pA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2F9BQDqFCpn/0vj/y5aHgEBCxIMQAmBPwuJe5Fxi3WGN?=
 =?us-ascii?q?YEghG+HWg8BAQEBAQEBAQEJRAQBAYNzgRQCijUnNwYOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQ0BAQYBAQEBAQEGBgECgR2FNVOCYgGEAAEFIwRSEAsNCwICJgICV?=
 =?us-ascii?q?gaDFIIwATSvLX8zGgJl3GsCgSNigSqBGi6ITAGFaYR3QoINhD8+iB6CaQSCR?=
 =?us-ascii?q?45Zl2NSexwDWSABEQFVExcLBwWBKSQsA4JSf4E5gVEBgx9Kgz2BXgU3Cj+CS?=
 =?us-ascii?q?mlNOgINAjaCJH2CUIUdgQsDg2KEbH0dQAMLbT01FBsGo2IBgx2WRa9ugxyBC?=
 =?us-ascii?q?IRNnQwzl2kDkmEuh2SQZakigX2CADMiMIMjURmOaMdngTICBwsBAQMJgjuNS?=
 =?us-ascii?q?4FLAQE?=
IronPort-PHdr: A9a23:i5TNrBPYIhiftC948QMl6nYgCxdPi9zP1u491JMrhvp0f7i5+Ny6Z
 QqDvqwr1AeCBNuTq6odzbaN6+a4AS1IyK3CmU5BWaQEbwUCh8QSkl5oK+++Imq/AdjUKgcXJ
 4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+M
 Ai6oR/eu8QYnIduMLo9xgfGrndVeuld2GdkKU6Okxrm6cq98oJv/z5Mt/498sJLTLn3cbk/Q
 bFEAzsqNHw46tf2vhfZVwuP4XUcUmQSkhVWBgXO8Q/3UJTsvCbkr+RxwCaUM9X5QrwtRzms4
 LplRAfnhykbOTE59nrXitFrg6JAvB2hvR1/zJXKb4yTKfFzY7nSfdIeRWpGQ8ZRSylMCZ6yY
 ocTE+YMO/tTopLjrFUSsxSxGQisBPvuyjBWgH/2wbY62PklHQ3fwQAsA84CvHHSod7oNqkdT
 Pq1wbHGwzvDcf1bxyrz5ovGch8uvf6DQLB/fNHNyUUzDQ7JkkmcpZDnMj6Ty+8Ds3Kb7+1lV
 e+3kWAotR1xoiKyzcgjkIbJgJwQylPZ/ih+2ok1P964R1R+YdG+CptdrDuVN5dyQsw4WGFko
 jo1y7wftJO9YSMFx4gpyQTFZPybb4iH/AjjVOCJLDtlmH9oZL2yihSw/EW91+HxVMa63VhKo
 ydEndfBuH4D2gLd5MaISvZx41ms1SuP2g3T6u9IPUE5m6TfJpI/wrM9kIcYv0fbHiLul0j7j
 bWaelsk9+Wo8ejrfKvqq52GO4J2igzyKroiltGxDOgiLAQCQXSX9f6i2LDs4UH1WrFHg/wwn
 6LEqp7VP94bqbS8AwJN14Yj7AuwACm+3dQDmHkHMEpFeBWaj4j1I13OIO73DfO4g1m0nzdrw
 unKPqbkApXRNnjPjartcaxh5EFCzgoz0cpf549RCr0bPP3yW1f9tN3eDhAnLwy52+nqBdRn2
 o8AWW+CArWVPL3MvVKK/O4iIemBaJcQuDnnKvgl4/DujWU+mV8YZaSmx4EXaHOiEfRjOUqZe
 2Hhjc0dEWcOpAU+V/bmh0GDUDJLfXa9Q7o85i0nCIKhFYrDXICsj6aH3CuhBJ1WYXtJBU6WE
 Xf0bIWJQO0DaDiXIsN7jjMEUr2hR5c71R6yrA/616ZnLu3M9y0YqJLj29h16PDImBE98jx0C
 Mud02WTQG1ugmwIQDo20LhloUNh0leDzbR4g/tAGN1d/fxJVAg6NZ3CwOx0Fd/yXA3Bcs2HS
 Vm8RNWmDio8TtIsw9AUbUdyBdSiggrf0CqtBr8Zj6aLC4As8qLAw3jxIN5wynjH1Kkli1knQ
 tBCNWyghq5x7QjcHZPGnFuDmKm3b6gc2zTN9GibwWqUoE5YSBJwUbnCXX0HfUTWqs755kXeT
 7+0E7soLARBxtCYKqZRbt3pjFNGROrsOdjEYmK+gGKwCQyUybOLaYrmY38d0znFCEgYjwAT+
 m6LNQYkBii7pWLeDz5uGkj0bkPo8Ol+rm67T0AuwwGLdEJh0qC59QIShfyZU/8TxK4LuD89q
 zVoG1awx9PWC9+bqAp7YqpcZ84y701c2GLdtgx9OIGgLq94il4faAt3ulni2AlwCoVFicQqt
 m8lzBJuKaKE11NMbyiX3Z7tOrDMMGn94g2ga67M1VHCytqZ5qAP6PFr42nk6S2gCEsuu1Vm1
 9VY1XGG75PGRF4eWIzwXm4t+hR6rq2caS44sdD6z3ppZJG5riWK5dsvp+htnh+6fN5aObmsH
 RP2GtZcDNr4e79ioESgch9RZLMaz6UzJc7zMqLegMaW
IronPort-Data: A9a23:RwOiiqJu8FZ/W86oFE+RdZQlxSXFcZb7ZxGr2PjKsXjdYENShGYAx
 2ZKX2mEOarfYGSjKdt/PN+xpEwPv8WAyNBlSgMd+CA2RRqmi+KeXIjEcR2gV8+xBpCZEBg3v
 512hv3odp1coqr0/0/1WlTZhSAhk/zOH/ykVbOs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82Ayazt8B56r8ks14K2r4G5A5TTSWNgS1LPgvyhIZH4gDf7pR5fIatE8NvK3Q
 e/F0Ia48gvxlz8xCsmom6rMaUYDRLjfJ2Cm0hK6jID/6vTqjnVaPpcTbJLwW28O49m6t4wZJ
 OF2iHCFYVxB0pvkw71BDkYCQ0mSCoUdkFPPCSDXXcV+VCQqeVO0qxllJBle0YH1Zo+bqIyBn
 BAVAGllU/yNuw656LCmWrJDupQKFtXMOZ4Gg1Zq1xvwSvlzFPgvQ42SjTNZ9Dg1w9tLAe6HP
 owSZDxzdgnFJRZdUrsVIM5g2r312z+lKWIe9w/9SakfugA/yCR4yrvkNdPPUtWWQcxO2E2Kz
 o7D1z6mWE1FaIXFklJp9FrzhNeMugTkWrhMSuzjrOM20FKfnHQ6XUh+uVyT5KPRZlSFc8hOI
 kpS4C0koLIu72SiVNy7VBq9yFaEoxEcV/JfFOo17AzLwa3Riy6GD24LTTNPZdop8tA/QzMC1
 kKAgN7oQzdotdW9VnOZ8qa8rDW8IyEZIGYOIygeQmMt6d75pp0phx/AQ8xLFK+zk82zGDv1h
 TuNqUAWia8ai80J3o2//Fbak3StrJ2PRQkwji3WW2i/4wV1baahZoq1+R7a5/MGJ4GcJnGLs
 mUsgcWS7OkSS5qKkUSlTOwTHb2B/fuJMDTAx1VoGvEJ6zSw536LZ41c4DhiYkxuN64sYiPga
 kvekR1e6YUVP3awa6JzJYWrBKwXIbPISYqjDK2JKIAUPd4uKWdr4R1TWKJZ5Ei1+GBErE31E
 czznRqEZZrCNZla8Q==
IronPort-HdrOrdr: A9a23:+MeQy6ghwuo8o+zDdmm2sEq273BQXs0ji2hC6mlwRA09TyVXra
 +TddAgpHrJYVcqKRMdcL+7UpVoLUmwyXcx2/h0AV7AZniEhILLFuBfBOLZqlWKJ8S9zI5gPM
 xbHZSWZuedMWRH
X-Talos-CUID: =?us-ascii?q?9a23=3AaJlu9GuBLspvQMsGbX328Cv46Isnb22G40uACnW?=
 =?us-ascii?q?kLmN0UYSyQ0W60eRrxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ARyxHHw6tVkOlniuupwky7ZtFxow34ZztL2cSk69?=
 =?us-ascii?q?Y5ZjfbzEsaziR1iyeF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,260,1725314400"; 
   d="scan'208";a="272474123"
Received: from unknown (HELO gm-smtp11.centrum.cz) ([46.255.227.75])
  by antispam28.centrum.cz with ESMTP; 05 Nov 2024 13:56:49 +0100
Received: from arkam (ip-213-220-240-96.bb.vodafone.cz [213.220.240.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gm-smtp11.centrum.cz (Postfix) with ESMTPSA id 93B7C1015BC74;
	Tue,  5 Nov 2024 13:56:49 +0100 (CET)
Date: Tue, 5 Nov 2024 13:56:48 +0100
From: Petr =?utf-8?B?VmFuxJtr?= <arkamar@atlas.cz>
To: David Hildenbrand <david@redhat.com>
Cc: stable@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
	Leo Fu <bfu@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Hugh Dickins <hughd@google.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 6.6.y] mm: huge_memory: add vma_thp_disabled() and
 thp_disabled_by_hw()
Message-ID: <2024115125648-ZyoWEF1F7lBRpXqH-arkamar@atlas.cz>
References: <2024101842-empty-espresso-c8a3@gregkh>
 <20241022090755.4097604-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022090755.4097604-1-david@redhat.com>

Hi David,

On Tue, Oct 22, 2024 at 11:07:55AM +0200, David Hildenbrand wrote:
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9aea11b1477c..dfd6577225d8 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -78,19 +78,8 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
>  	if (!vma->vm_mm)		/* vdso */
>  		return false;
>  
> -	/*
> -	 * Explicitly disabled through madvise or prctl, or some
> -	 * architectures may disable THP for some mappings, for
> -	 * example, s390 kvm.
> -	 * */
> -	if ((vm_flags & VM_NOHUGEPAGE) ||
> -	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> -		return false;
> -	/*
> -	 * If the hardware/firmware marked hugepage support disabled.
> -	 */
> -	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
> -		return false;
> +	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vm_flags))
> +		return 0;

Shouldn't this return false for consistency with the rest of the
function?

>  	/* khugepaged doesn't collapse DAX vma, but page fault is fine. */
>  	if (vma_is_dax(vma))
> -- 
> 2.46.1
> 

Petr

