Return-Path: <stable+bounces-83654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B63FD99BBAE
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 22:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762FC281743
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 20:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F2A14D2A0;
	Sun, 13 Oct 2024 20:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="efblilPo"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A701494DC;
	Sun, 13 Oct 2024 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728851370; cv=none; b=UBudumjK1vEOyzNtn1j1etiCXl6GaOHgFvmLJdCobD5I3zFVfmnIVFW+yPreEKJ8W285gBt4bue3z1lbpJNPbMh7i4CGZ7X5CuFbcgfdZeBZITF7/PbhfiltaXJhE143jNvajyCNnDEz0Y9V279M9+B2J8DCvciRp+HznGTFyRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728851370; c=relaxed/simple;
	bh=0gMXlYpnIPAuJgx2PAz1Y+xtbMNK0rxJnrXsXAV5+O4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/fJ4tY7/W7c13Hk/z/5jWZbWffqxpGUAaE+arSLtgyhSTGVhoepM17Qmk4eso8qJ/dn/u1Evj1rfRe6CHbOAXhsgma1FS+xF+QbEQSRq2dD5/KfP/V3U8HNdY7xcchCFeWcD+mDkKYamv3SLTtFLcmytyxY+dcgkn5fhuhGsz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=efblilPo; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1728851357; x=1729456157; i=wahrenst@gmx.net;
	bh=kZp4oZNcSAAVej1Qag41DuMe8LJUyQ0UO62YYClJjt0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=efblilPoRYsJRMDDke5Z6vgo/bilWLUr31qX8t8oydM3hPrtgh5hHjqzgl+0Hu7a
	 BWMdv+1xrSaXL3Tsg5wov2cewpuA8HvAB3gPIrl4iwXNIMfqR2kOoDHGwX14j5uz1
	 jfQvcbqyLZVUUXER1M/oNKMaiUZZQy56lI2eNlpB7ZubATj6wRqR2OWovcGHu8v+j
	 Jl+OiyFqPO18RHD0IntC0xklIu0VIhARuKPamZIBAGew7CgbLlkaUgLcwCnkfV2MF
	 kBdKDiNFKAGra6nri87OgRDbfg0I/mgXmgaVeqTd6vObiAVTxip3nsCRwjQ65bOT3
	 0/+ky+k7qGbR6T7Oxg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.104] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVeMA-1tPPbN2l2y-00Wg3p; Sun, 13
 Oct 2024 22:29:17 +0200
Message-ID: <b176520b-5578-40b0-9d68-b1051810c5bb@gmx.net>
Date: Sun, 13 Oct 2024 22:29:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: vchiq_arm: Utilize devm_kzalloc in the probe()
 function
To: Umang Jain <umang.jain@ideasonboard.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 kernel-list@raspberrypi.com, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
References: <20241013171613.457070-1-umang.jain@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241013171613.457070-1-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o9jjF+w3KoP0/0RAbm/FdeAV+qPWlYVd+WBzsUBqMhM20aPAXUW
 8ZUHnI5ZJHAaxIe9OcysTndkA/+gOET7NDvG8cmFOD6KbrqMcJh9pku6/AMWudq3YeQvWps
 H6MtYX+ba4gEf3PPY3k/T7Rjt5nWD3DyAoRkjmwycX8JDR4Z0FQLZkLgQM1IXhb9WXccODK
 l0KW+lhKu58dOgnoUXKKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1+62h/DBdPI=;XwHz3UcBoVhQo7w2bYTTKyAEfYW
 vru6Tp/68/ilNsSAHZyBY1RK/vkCIHmenl8+zaWXepCQsyP0/sXKDOEqLOMh0GURo8Y4tfAO7
 gVxcE6KP2van52uYN4dF4MWMR43nl3D1ct7mExZWDV4ExTbJZyrcvXOefYnwaLOpRDLJ8KvOk
 +/WuONwQ0GjNt9ZEYqSuL+xxFTRalTE6RcJU9e1nyuPqeJxT+wbQlIPyZhA2U07Qsmel2jEEb
 z58wZfcicmgi20BWuhkngJDf1YM4cGuL3BC1sgfDh/cGEBtXMMsdA1TcJkEAk9EYzNGpMZ/H7
 gaky6T7EB2dGwn93siFLE+Gu/Ed6nWAalbv18WNSvZM3GIQ+ffHDf+BUePgcQnbzt3hPwIZDh
 nSIog7FVmjTisY8PfZsB40plmcBMxzT9mT6cVj+0LCYfZx4pQPKtu0oE8y6rfVDUDxTzHQSY1
 z5DNh/jrStKoXuqo9CO55y23fe4gumr8kQx3GtasAIixMHdU6KYTwOQY4gQ8AAHZqdzNxn3zc
 4qUjSndmqYRXgvtbogubboX8EvEpgIispZ56xqEfKD0gfhu1zk5u/ojVt2tbkhVgBa01ooNcK
 ZmWHsvlvPz0sE2wbcbk6Mfyk33NxZZB7svi1GoCUVq+J7hsWL8LUVx28F/s+uPcvdZj4InhVb
 ZoFFfGR4KerLg44odVSRvrWIVy3CNjZ6MdWWOqm2HnWcKRSO+p2QvkNgRmmejlg4HFc3OCXYs
 BSjuKGLJQmYM9F7NDMgmht8b8A6Kp3rdUOmaEs1BZPc4DZlEXuWLRkY8yy0hdS2E1WCxXAgAH
 NJIVCOm2uV1SJA2Yiwvb5Q+Q==

Hi Umang,

Am 13.10.24 um 19:16 schrieb Umang Jain:
> The two resources, 'mgmt' and 'platform_state' are currently allocated
> dynamically using kzalloc(). Unfortunately, both are subject to memory
> leaks in the error handling paths of the probe() function.
>
> To address this issue, use device resource management helper devm_kzallo=
c()
> for proper cleanup during allocation.
>
> Cc: stable@vger.kernel.org
> Fixes: 1c9e16b73166 ("staging: vc04_services: vchiq_arm: Split driver st=
atic and runtime data")
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>   .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c   | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm=
.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index 29e78700463f..373cfdd5b020 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -285,7 +285,7 @@ vchiq_platform_init_state(struct vchiq_state *state)
>   {
>   	struct vchiq_arm_state *platform_state;
>
> -	platform_state =3D kzalloc(sizeof(*platform_state), GFP_KERNEL);
> +	platform_state =3D devm_kzalloc(state->dev, sizeof(*platform_state), G=
FP_KERNEL);
 From my understand this leak has been there from the beginning and
platform_state is never freed. So I think this patch should be splitted,
because the Fixes applies only to the rest of the patch.

Regards
>   	if (!platform_state)
>   		return -ENOMEM;
>
> @@ -1344,7 +1344,7 @@ static int vchiq_probe(struct platform_device *pde=
v)
>   		return -ENOENT;
>   	}
>
> -	mgmt =3D kzalloc(sizeof(*mgmt), GFP_KERNEL);
> +	mgmt =3D devm_kzalloc(&pdev->dev, sizeof(*mgmt), GFP_KERNEL);
>   	if (!mgmt)
>   		return -ENOMEM;
>
> @@ -1402,8 +1402,6 @@ static void vchiq_remove(struct platform_device *p=
dev)
>
>   	arm_state =3D vchiq_platform_get_arm_state(&mgmt->state);
>   	kthread_stop(arm_state->ka_thread);
> -
> -	kfree(mgmt);
>   }
>
>   static struct platform_driver vchiq_driver =3D {


