Return-Path: <stable+bounces-105133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 534A29F5FC4
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 09:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0725216DB0F
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 08:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2233416F288;
	Wed, 18 Dec 2024 08:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Lh19N3hZ"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F4C15854F;
	Wed, 18 Dec 2024 08:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734508850; cv=none; b=cbeMe8YW6IX7VEA0cbX/cIBlJdufSrES+qXzPa0yeYYn6XjCR+9vk+Ky9HEYvfKB+o0xrNpNIxsFsndptttNVEcHedFgHpWRkdS9RtLUS9Y8SuFP2EIutbyz3jCPEOnKgGDS1hsEEK8UKV3AwszpfOHZ/E5q8U5FAnfYDxisll0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734508850; c=relaxed/simple;
	bh=aA3AumJBium5XUel0RXRniih59Vb8i5HixIYaTqea/I=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ISAIAcy5j6fe0abuDz/HRb238q/ssdhjJgrkIa7vwLfcd3uOSZi9uZTVSdCg+abLki9+/z2qyPaAbA7osYJazz1R3GdipEZ5F1FNrya+vxn7rlmlT1IfIgRpmMRo76cj6cXf66UytLVkQiq1ZPnggEKJLrEhwI16RB31SJyp1r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Lh19N3hZ; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1734508831; x=1735113631; i=markus.elfring@web.de;
	bh=ZiVQ013gzwXq0yefM486yeJ8+UOSpCWb4AaYGr8NYkI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Lh19N3hZV5LMGCLSF5A5AZDtAVQLQDX1fDIizEAAOLUmfDTCNEJDjcUFWJJfTcKi
	 kcxqaOLKliSW0fUyNsrWWlUnKctG0ookeoIMvVu/V4PoPDE0N9AjK0edG04ilaIs3
	 WQflbd6I6+5QAli6x5tcMRjijYhXYsk12atdH50XRg8kDUuaup6kRAIYaxUcpo4ij
	 owXwp7SH0lIGWsFcDBEDPisbZ45APBF9hsPAg60WZ/v+1bmhW+ZSTTT+Uo2kjCBS+
	 SLctJkZexwc3MpLEKTEtjwudKSk6IVDnhpNAMcGzfjyv08fZUiB+2Q/GmrxqU6imY
	 TQfIq55jCpPmVH8ZFg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.70.41]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDMvE-1tFc3F2vYM-00AyMn; Wed, 18
 Dec 2024 09:00:31 +0100
Message-ID: <e8dd155b-c907-4874-bd78-af768dc507a5@web.de>
Date: Wed, 18 Dec 2024 09:00:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: make_ruc2021@163.com, virtualization@lists.linux.dev,
 kernel-janitors@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 weiping zhang <zhangweiping@didichuxing.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241218031201.2968918-1-make_ruc2021@163.com>
Subject: Re: [PATCH v2] virtio: fix reference leak in register_virtio_device()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241218031201.2968918-1-make_ruc2021@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:stnYhqrMZMRL+tYtQPJEMn4nWYPSo7zdnq+q/3qYuHd2ZHDDEWV
 5MRTe4xxAGI4NWXW46k529kR3eldazBCtnQFandRHYl1xxtWZa5uJWlj7io0ZT2nP2KUUCs
 C4IHJIq9481ufLXAjQF45aGS8/kTAQK7EBv9QqvRf6wilIPB5lp38bXgoBrVZaYuJ+hN8/4
 qgteZv2soj9ps1RrHc79A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5TZ/deI83Iw=;4rVdb+42OqUi0V9ghUfTvHJLipo
 1I/Op10dkReva/AIrSaLZ31YzbMZID+I+mjXL5Jnjyya5e663+UCQ4ybxrf+xVeiTVXLhlWLA
 p6XUR/yyr9YuNEstAc5bpVIdD39t88pot8h0DT46rAXelIt1jWeAzfw44N32qT6JCl0yxi3sB
 nabwYOx8ke03MPxQSaVVlXuAGC+rNj8/SxLFsYMey/BMfhLuaZ7DAdXbLkaqQCppCOmObQ4+Y
 FnEqY4LcTQh3vzVgDfdFwP033LD9kBw5u0Hw0SvDksWS0aEu5JTrodEGsBuh5MSKSoEbI41aa
 ha+zLFkRBUcvT5Y8HhuUWjocMJQpExiW0NmOHL8/OvyXxV4MgbvJbn688a2UD9Ip8XTxBBDTq
 OIm0Tjd2ciUF5zqbpBjqJcLWYBOQL2YtomFQ+TD6KtJI4Qxra9mVmbECUEYJVPk0mSEnghqL+
 6AetLw7Ck/OyHDuQAaeBuzN8C3U1Pes0qK2d+yC+rIr4s9zZ34dN4recFI5CCMVh0EU+67CCH
 LYr2VBUD5jehWxXHger1T3daSEo5Khm+Xfo/UZQR/DteluniLpMhT2d40UxtE8sVo3tHG2UzH
 yIemXs8MsirsF5VoaytkSwHR5BG8m4PxRLMnPHTwXjNZ6naxar5s8EKlLa0spVFaCZdyirhPl
 /0TBlRMDCD3AczqXuQ4C0jjje88J/uqxqfgCS9yg5ptRy0SpfQ1fauUqRsKqXI9fQFZwm68qm
 WM1NMBhWVJE3qMx1rBsxB2BnAghvMj7iyUYWeE7Okg//JGMPddHdj08Tpr2YnZXJgD61657HV
 ShKaVIDK3XbATgU+7c//4BTnZhDirBkIrEseCgC2tTGB9MFCC/MNh4U3pESCvId4ROhRAbi64
 YKr4pxql9nz9WYrrLD8g2Z7Buhe2DUNFz/sR2jOLynEz742m/yRFa8wMcS1ha9QoUqAg6aJle
 qR7P6HrpghNlYuB+HkmfVwt8gWGdAsDBI2qT/FHKhEIfa2lMPTJIg0CF9iQ94tPJOKI1bhmya
 aAeCzIi3DdjsxPTS0cjWTdWVLqKvJuCcJAl3OVlUVUxp13Dek9NAkeLX3GoXKftGxbNOZfNIn
 w0mjibJx8=

> Once device_add(&dev->dev) failed, call put_device() to explicitly
> release dev->dev. Or it could cause double free problem.

https://elixir.bootlin.com/linux/v6.13-rc3/source/drivers/base/core.c#L352=
1


=E2=80=A6
> Found by code review.

https://elixir.bootlin.com/linux/v6.13-rc3/source/drivers/virtio/virtio.c#=
L498

Will possibilities become interesting to improve automated source code ana=
lyses accordingly?


=E2=80=A6
> +++ b/drivers/virtio/virtio.c
> @@ -503,6 +503,7 @@ int register_virtio_device(struct virtio_device *dev=
)
>
>  out_of_node_put:
>  	of_node_put(dev->dev.of_node);
> +	put_device(&dev->dev);
>  out_ida_remove:
>  	ida_free(&virtio_index_ida, dev->index);
>  out:

How much can the ordering matter for such resource cleanup calls here?

Regards,
Markus

