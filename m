Return-Path: <stable+bounces-58919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B4392C1A1
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 19:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F9C1F23746
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 17:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DBF1B3742;
	Tue,  9 Jul 2024 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="R3lD7J3C"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC4D1A00E2;
	Tue,  9 Jul 2024 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542921; cv=none; b=IRteZWZom4GJpOOE8g8d2cvE5TsifCgnJLNK0y9gs16oZhvnfY1niKVZULeK3Q3N8jYVuDCXcd03S7w30UZxdvPfXRRtxY/5de+ztGa08q/EEm/cYWva3MSAoI5a2FGAOX1gMk2G4/Rw+AT1aaMEV2hAQbmKx/AF8k8qFgKE9D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542921; c=relaxed/simple;
	bh=ap5HE843/KOrmGwHubHXvqWl9bGU+5uI3swe5SV3T2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EwGSnwfdvsiUfbU+OKL5QOgfuIWYcPyvCkN7YRHaEDLq5eWyZCuRRZZKd0Lf2lRdlDAVDhxfnOH8b/3AEArxWD01BSSZDHzzfCT1sdDcKAOoW/q+2qZw7vqHRs5BrYMJtDOEItsUzG3ZGlnncYzxOT7LoYXVvkrexnvY6tMsIQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=R3lD7J3C; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1720542908; x=1721147708; i=w_armin@gmx.de;
	bh=Zo22gEwXUQIKViObf1R8K7ujmazhPr/0Wifp99s+uaY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=R3lD7J3CC8gqvRQZGIGnvouWiGZCXUDYJ3RP40EVw7Oq8bBdCBPmNvoqJJYWN4Ol
	 pyXNotbEpNlOIGPE/jHK1PLCFi7z3ZqNSaxWFhq/xtC7RvHIrW43/1AYoKOaVAPT5
	 saHprvUrFC2XYvl5S1dfSSaF6YC8fvDPrV1Qml4l/AJfFvy+4s4NUYm8twkb205IT
	 4glJ7iNdvMHfLMPO+2UWlxDdXlTSU2f8s1u5pIhx0fRQpDsZ7OjnpCZaiwNzAB5Uy
	 wOM5Or9PBHI8e+LfNErV97rygEaCXf89hKhCpCbM9blQznnccT55x7fmDHp3YU1Gy
	 ifhEe+7Sj+Hkm/jPWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsU6-1sZzER3byS-007A00; Tue, 09
 Jul 2024 18:35:07 +0200
Message-ID: <034787ad-ff0f-47da-8b8c-aef334734c17@gmx.de>
Date: Tue, 9 Jul 2024 18:35:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 5.10 10/14] platform/x86: lg-laptop: Change ACPI
 device id
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Agathe Boutmy <agathe@boutmy.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, matan@svgalib.org,
 platform-driver-x86@vger.kernel.org
References: <20240709162612.32988-1-sashal@kernel.org>
 <20240709162612.32988-10-sashal@kernel.org>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240709162612.32988-10-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7WUuJzmLiKulEv0xGxG+UMo17kvwW757xOoQpbZFsrV+JOcStov
 ftakaWRJ1ZunCmUpafFEwkPam8Tdhj1ZvClNSWoRzLBcrrEKYEVY62H8aWXtMnmIl09UyBd
 7OrXVt4dajBCzflwTxFo3dIVHoqcYzvBRs1laiMX9kf4vXzLEiZ00TIp8yNZLCKYvlhxse9
 8sC9AIWAjCCoLYp2FitJw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9apz0sTBGZU=;2IwWa0BhyxYOLi3h5mSTj9q1w90
 6GlkcqreGw3SIFEpOobM/SBFiLJeuAeKUjuB3UR1IOPty3RxknYQR429o5B3AvrhhdKTvSz5S
 p0K3wj6QzzXj9ryrtx2R22tg5c+ZeJr1WO5VoXR04+UOBLNlSo6mElpcxo2WFVucen3588CXb
 AvzgYXLQgh94cB6UUodTsRxZMJ5E9oNGDfk3/sdHygrKPa83fbEgKNzYGk98imMx7E3+1PTxk
 DB85baA9mLQ62eFr7k5ZSwUeYbjdc6tSAtZEXL/mt/xP8PQ6eHFJv6vGCYgwi975hR+gI+7bJ
 1mL4Ji22FOBgtq8ieBFPStOB6IEqztWNQVX+9uyRIkDU5ik2eJF7zDP1XU6RA3oxcxhm7iS9Y
 7OTl/mYMU/HpCI8L6gUJZ+KUJIwDsSA9eRmw4XfDffmESVNugDxWVGeY453lJ2qjPeZHMCI1+
 2qt5yD1Ov/ibyMM+DF9EkZqsG4mXwLt7YpOM4/KfXov5ljNK16EA6L/mxMaPnQXAORwXLCWuD
 1MpPV2xN0Qj5kwHRYhHFtBSJPTM1ruAplZsV084cjTdh8Ki0uqYK5R0Hqs4MBxY0MGvxJiG3V
 QmPBnMXLivYZTghgLAb2eT6u/s9E7jssdifxztr0OSExaunz+ML+bWIZZd5On6eZTRjW/uF8X
 jsllcy+5t8MlWS5wxjJ+sJlVyI7HRu04U2i7ZFEcwBoy0AcVZ/5hejnFrTJ95NttvGndn/H/X
 ut7mlNdwmJV4OmawD7olB9i8jANctDINzQ3OpUBaMBD2IQzIuxj/BUCS+YvH9mem5Rk3j5GCU
 0CkKKnewCUsyn7FZVRZpGyhiYmjcxeH79ihvpNxfROb9s=

Am 09.07.24 um 18:25 schrieb Sasha Levin:

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

this depends on other patches not in kernel 5.10, please do not use this
patch for kernel 5.10.

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
> index 6b48e545775c0..e3cf567470c8b 100644
> --- a/drivers/platform/x86/lg-laptop.c
> +++ b/drivers/platform/x86/lg-laptop.c
> @@ -647,7 +647,7 @@ static int acpi_remove(struct acpi_device *device)
>   }
>
>   static const struct acpi_device_id device_ids[] =3D {
> -	{"LGEX0815", 0},
> +	{"LGEX0820", 0},
>   	{"", 0}
>   };
>   MODULE_DEVICE_TABLE(acpi, device_ids);

