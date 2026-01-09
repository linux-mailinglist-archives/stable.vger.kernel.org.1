Return-Path: <stable+bounces-207886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F14E1D0B3F4
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 17:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AB2C30A53D7
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 16:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848A726ED28;
	Fri,  9 Jan 2026 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="hq7k9Re5"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2831DE3B7;
	Fri,  9 Jan 2026 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975845; cv=none; b=jnkOH5Mv2iVZMqLCOnd/B9jZ0UBc9kI8XYXQilwMHG1PM4pozstskILi02tsaiJVdug5zs6MpxaoBk7PLPoRSroycqIpihDoh1aOF2KBpQSnHc6513VrXWlTaNOoyICCPFWK6rVIrjwpElTkvk2SpAl9Mo4ayJfp5H+8neU/zH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975845; c=relaxed/simple;
	bh=37zr5RRbbEKcNkyVzkRzSu1P2O5x7R5KL+ffW0XVfTs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=G+1pU3SCTAsJA5Pv45sHU6hESvqL2j9/iX8mNFkMEspTPnc0/1MkZJHiqBY70tmkWfz6tUv8CaXTFKvt00SrssbjshLCBWfBYbk/aYsgYoyfJPkvHhz+emPIe4B7jS8KFCHVW4i9oINLHIAwlgyX3NTwucAHijoJ59o21yYnZik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=hq7k9Re5; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767975837; x=1768580637; i=markus.elfring@web.de;
	bh=2AcLpacMqxNiFXbwGlQLWsYnf0jSdTj8J0/TS+C/VFI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hq7k9Re5no0nMYwev+30ZA7ZaakPh3RUJTXoZKqrAOiw7ZOvSDriLTjiS7Kk+/j5
	 Rfi61sr98Q0k3ag/1WlQ/E2QhfnJnNoM1utS+071Mm4/D2LvBFAaXoIoNkr+uz/4H
	 AeN8CsOB78kJt/tZePdAA+wE6p0teoUBGXzOc41coNk2SJBBdtiU5oFrskMgYS6Bc
	 rLHTgjRV7YWUFiHsDPDbo7PQepUeK+DwZhrp8TJtyJM3JWX/MVpPS/phbfBDEBEsq
	 M8Hu0+T7UYa7fJQCfnkQuZtTm6ZKQJsGL4F1dLsABjLNF2lUKGmDxISMfQfp/ABy0
	 FWgyC/lB5hjdICpheg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.182]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MxpmW-1w4JIx1a1O-016EMW; Fri, 09
 Jan 2026 17:23:57 +0100
Message-ID: <12cd71cb-4139-413e-918c-6245d5d4f10a@web.de>
Date: Fri, 9 Jan 2026 17:23:54 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, =?UTF-8?Q?Felix_K=C3=BChling?=
 <felix.kuehling@amd.com>, Oak Zeng <ozeng@amd.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20260108071822.297364-1-lihaoxiang@isrc.iscas.ac.cn>
Subject: Re: [PATCH v3] drm/amdkfd: fix a memory leak in
 device_queue_manager_init()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260108071822.297364-1-lihaoxiang@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zq4yS7x360MSLhrC6qvVg7Q4jPN26r5yrSUVshzSqQHnIH1QDXZ
 eOZhOp20DgxDYYkuB68isJ06qsb0MZ7SFug4sGfkMYd8r+nTCTT9+2U5P+yOaWmqBB7CJyA
 rSXI3z5jmoN9TbTFUnMShEqo8mE3nuq1yIO8mJGK27rMsqGtaNCP54QsEU5SnjP+y49Vc+J
 G1AY38JFOVDOwxNxPwhbQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0zUXLsYhz/k=;n7Nj1FIXzkvjBPimbPpZptfqFFa
 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
 Zz82EcLbHoc76vETu0TEWXfYT9HX+uelwIemxH

=E2=80=A6
> Move deallocate_hiq_sdma_mqd() up to ensure proper function
> visibility at the point of use.
=E2=80=A6
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2919,6 +2919,14 @@ static int allocate_hiq_sdma_mqd(struct device_qu=
eue_manager *dqm)
>  	return retval;
>  }
> =20
> +static void deallocate_hiq_sdma_mqd(struct kfd_node *dev,
> +				    struct kfd_mem_obj *mqd)
> +{
> +	WARN(!mqd, "No hiq sdma mqd trunk to free");

Can this macro call be omitted here?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.19-rc4#n1242


> +
> +	amdgpu_amdkfd_free_gtt_mem(dev->adev, &mqd->gtt_mem);
> +}
=E2=80=A6

Regards,
Markus

