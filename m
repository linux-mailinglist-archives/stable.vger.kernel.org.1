Return-Path: <stable+bounces-58921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4DE92C1AC
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 19:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056D5284F75
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 17:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53771B4C29;
	Tue,  9 Jul 2024 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="FxL1ChYQ"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593CC1A00FB;
	Tue,  9 Jul 2024 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542969; cv=none; b=Y+T3Kn19bxaQDYmk9qHY/2vfhTU62k7DJ2nQylCXYQT78sVY28p147anuL0kWg+0qvCdZ4p47bXoMEuQtUXHPLjgeGpF5JMFSxyc95uJRYNXOZZamIMKdRswol/i1K6yrsUn3F1nlGssooHphTFmRnttIEPagJV/rrXkKC1nW1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542969; c=relaxed/simple;
	bh=k3zBwtbLJ9hY5BBMbz1smXEp4I8217xTp4I3ha5Mv5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u97bY8tBHVt0Q0CnXnYC0nqBUm4WBxnWwWHbWU8IJACx3DEj3f7DgBI2bm0SqB78UxzNnXkayAe8sr2fGLaEdld0f5aogSbk8Gbk/UcfqFkztTfxZrkUmq6gcopnDuR8YRc5rD4JKOTemJ0dUMTxfaa/RV0hnmXi16mhBCAXxjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=FxL1ChYQ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1720542952; x=1721147752; i=w_armin@gmx.de;
	bh=OOKOIpWhQxnQYbfkIYw8x0Tz+jDtP8c3HvQIOJBcTwA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FxL1ChYQoAS7YK1ssNqqG7sqbJhYZcFg10wBxJ868vKpqjeEDpcVlNze7ApL58Sv
	 nsYcV2loDNULKuk+1HBwKMoadycdvesdF7CMxtl4+LVzBErgU44GpiX1wWlhSKBy6
	 5x8Y7DjD55H+01v2x7yoMtSHHcFdBrznguifcwKGoK+w5xfpz8UXBSPtYXm5LLCMK
	 ANtFMeliwd3QvzjWQlGPq8xXmO4r7QlTYQbTFHvZZKyb9BsKKmuiNB3/JbB+K01bY
	 DZ0f64T1y/dvW10mke08ILRuNoig1C4HaeJyJIW69pYXVJhr65C1271RIN3QQAUF5
	 UYDPhefu5Y+PxvD5bA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mk0Ne-1ryjc82qrI-00eIfK; Tue, 09
 Jul 2024 18:35:52 +0200
Message-ID: <7cb80962-c1c5-4971-9283-d822a054cfc3@gmx.de>
Date: Tue, 9 Jul 2024 18:35:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 5.4 09/11] platform/x86: lg-laptop: Change ACPI
 device id
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Agathe Boutmy <agathe@boutmy.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, matan@svgalib.org,
 platform-driver-x86@vger.kernel.org
References: <20240709162654.33343-1-sashal@kernel.org>
 <20240709162654.33343-9-sashal@kernel.org>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240709162654.33343-9-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M4snPnEylnQexQn+fCwbKkg/S1qfCsZgG9j609yUM1bNgaOTFY1
 kDE2t55tIxwoGhIe/30cxNJ+iOZ2WHTQqnv+11NIwsFFimgLYBeCsoPUY48JHCOhCpCjSHi
 uDBCHzHF890yWkxV8G1abt3AT7gII9OrSdZgyRr4WmLqpob8f/JjpZehMGpWjy1sd70FxF9
 KZLNc5MCWWFzuihWHkOWg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UzAaiWb9quM=;fvE1nYvNh5R3KL+WbRqP39HsxO5
 4H0UcfMs9Wv2LymgfPx00/Rx2YVIDxFK/SXWRDY7panxpFv/Q6+Cqq9T1+gAnFYuXskkBga6S
 /HHYj0ITyM+ytrKDo0+HxHzz2f8LjcJYyiFsQJTLHz9tQL4Y1KiE2auTvmR5j9Tyyba9Ix7Bn
 hKgvhgLMKx4D4gLrKxq0S8UarD8H7Jdt9FD43R0J1q47Q2GKcVjl4JrpeV5EuO8NNdPvObwIK
 v5bDG4AM79EkUeHx0qvIqye4DR0Xh6swT1RQY/dPloe2/x7GXODjUnyo2V0IrBFNyyb+/LQla
 PFeVU8HV6kbFXoJ94RxmpJhrkJ/TEoZ2Duk+ylqcZIton2xohmWDOsU8JvpxQGZO26htvGCwN
 45WHoLpU2BCE8+QnvD7YYCDcsqH68JhmUHGoBTvWmArG3+4zDMcQCFBCungCY2z+NyPlHeOdw
 MCf26Az8j4MemrhjbvmOa4SOYQ1TFTSbU7o0ol3JkBWV6jnhjZURW6Psn01xopJv8KCd0GPFN
 GztMqzE6FJ+6NhtQfYxMhsunIvnF3cmquAKQRD9oafcemVnrzi3iPSSz31+Mb0Rnr8XDsIolT
 R7oz36UThc26f+vMaWURopBhrV0PvC+hKHT4MO0uFHYgmh2Z+n84udNRZxLWBDzVShxuxivW6
 sGXdDrPEe0exV0evHOmAGbORPeVGRurXFTUmX4D0pZt0mp0T7Bp9Y96/M7c+nVIsp9TfXvk60
 gV8L2V8D7gLlnzNg5dV/P4aQxQiNzsiBxSVgnUNMNGoDlIjml2Fw5KZPHkjaA4FLkgWQybrG7
 Wv9/VUziHRdgfbY0L7veDSbmXQr/GMTbJhtQBZH18BCcI=

Am 09.07.24 um 18:26 schrieb Sasha Levin:

> From: Armin Wolf <W_Armin@gmx.de>
>
> [ Upstream commit 58a54f27a0dac81f7fd3514be01012635219a53c ]
>
> The LGEX0815 ACPI device id is used for handling hotkey events, but
> this functionality is already handled by the wireless-hotkey driver.
>
> The LGEX0820 ACPI device id however is used to manage various
> platform features using the WMAB/WMBB ACPI methods. Use this ACPI
> device id to avoid blocking the wireless-hotkey driver from probing.

Hi,

this depends on other patches not in kernel 5.4, please do not use this
patch for kernel 5.4.

Thanks,
Armin Wolf

>
> Tested-by: Agathe Boutmy <agathe@boutmy.com>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Link: https://lore.kernel.org/r/20240606233540.9774-4-W_Armin@gmx.de
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   drivers/platform/x86/lg-laptop.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-=
laptop.c
> index 27c456b517850..ff7ed8882aacb 100644
> --- a/drivers/platform/x86/lg-laptop.c
> +++ b/drivers/platform/x86/lg-laptop.c
> @@ -653,7 +653,7 @@ static int acpi_remove(struct acpi_device *device)
>   }
>
>   static const struct acpi_device_id device_ids[] =3D {
> -	{"LGEX0815", 0},
> +	{"LGEX0820", 0},
>   	{"", 0}
>   };
>   MODULE_DEVICE_TABLE(acpi, device_ids);

