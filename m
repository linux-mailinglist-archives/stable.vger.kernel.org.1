Return-Path: <stable+bounces-192069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E536C29238
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 17:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0B23A7DD3
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 16:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669411B78F3;
	Sun,  2 Nov 2025 16:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="KbydT9GU"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18882146A66
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762101129; cv=none; b=mPJI8O+Fx5+QOfBjQSsTrLoETDHT9BNyvaRv3Pa9WE+4v7QnD3fv3kxRFTL6WbvbDlNHiQXtjL4Rxenrtd97c8qFLXDgs2QC10XeUjbXio1eGzL44ez/Ik429YpBPEsAWUCNWgqcLAi+amUxeDRuIkZgGgrqtVoTcB1aJp/z9N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762101129; c=relaxed/simple;
	bh=p2uI0vmRGweokY2nzO+bjYQi7HrLyqPTbiuEWJMUHZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NXN8AHBXmJGQhN8bFXjdtp3UJDPCAcj14BTYyOV7EGDYkPwxkvLBrJOFryG8cefl2zB9xTsZ6eXQcaIDi/MR/Pcx5jvKqCLZ24c0F4CjTz4jxwjiXf5vku8Cu6x18siEDkmYGkQ3E6dR6uR/KMTQP+Fvjewr1U+rJMaI+cztOyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=KbydT9GU; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762101121; x=1762705921; i=w_armin@gmx.de;
	bh=N/RZipWpEY3bV57NOxudkchHnL2hKmhs6vzChjIzR5s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KbydT9GUy7m9gS4uu24Dz/7QMwJocOET26Xzob1PazoTS2eR5R7hahRENwDNSF6x
	 tq26ztxl93cGFQKCsWRtUy7LVwHXbXxZDRMnjyCDzeZHKeiYkNb4v1in5LbGJKdx6
	 0UN/ZgatEkk6+Kj8a8L+g/q72M9EwdiTSK4Dpi5t8IqUoBGCNleJ/QgSgH0s3fk8s
	 5eFOdOSGNlx8MPYxlUMzoxJSWKBaYdOa3qE/vlwXJxlzNIVLMGhvGOzQYRPsb/HIW
	 68VgcdRdTEHpEdUvlqv1qHTd2QXlBGq+ZMgxw9QyDpMX1FDf4edHSwyltXAjJfRtm
	 ns9ugY28N8XS7hHwnQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mv2xU-1w6K6i3foO-00zBXg; Sun, 02
 Nov 2025 17:32:01 +0100
Message-ID: <894e49ea-33ba-42c5-8b7b-d4ccd6ffd1bb@gmx.de>
Date: Sun, 2 Nov 2025 17:31:59 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y 2/2] ACPI: fan: Use platform device for
 devres-related actions
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <2025110248-reflex-facebook-1ab2@gregkh>
 <20251102143514.3449278-1-sashal@kernel.org>
 <20251102143514.3449278-2-sashal@kernel.org>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20251102143514.3449278-2-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bCPBuIc6blj+MUazVSlGEE8o7jIoa/kaY4SkUzIIxNHsswjdwen
 AML7AgK5etEG4afM56ljhMPjlamW8+B91soDaFDMNdi8lJmrms+T6fHB/zltV9GrPaOclHR
 FEvjHgIdQH55mJ07J97m/YuwzeAIlsqCozJYj44l0+GQtxSz41q9YlsOIPaA9fzL40WW9uk
 52RY+AwgtH1wAdrKRdmfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rxyXbPy9/kk=;0QD8QQWOZ8mv0wO4CDJUPQJrXIS
 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

Am 02.11.25 um 15:35 schrieb Sasha Levin:

> From: Armin Wolf <W_Armin@gmx.de>
>
> [ Upstream commit d91a1d129b63614fa4c2e45e60918409ce36db7e ]
>
> Device-managed resources are cleaned up when the driver unbinds from
> the underlying device. In our case this is the platform device as this
> driver is a platform driver. Registering device-managed resources on
> the associated ACPI device will thus result in a resource leak when
> this driver unbinds.
>
> Ensure that any device-managed resources are only registered on the
> platform device to ensure that they are cleaned up during removal.

Please note that this patch depends on "ACPI: fan: Use ACPI handle when re=
trieving _FST",
otherwise the ACPI fan driver will panic when probing.

Thanks,
Armin Wolf

> Fixes: 35c50d853adc ("ACPI: fan: Add hwmon support")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> Cc: 6.11+ <stable@vger.kernel.org> # 6.11+
> Link: https://patch.msgid.link/20251007234149.2769-4-W_Armin@gmx.de
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   drivers/acpi/fan.h       | 4 ++--
>   drivers/acpi/fan_core.c  | 2 +-
>   drivers/acpi/fan_hwmon.c | 8 ++++----
>   3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
> index a7e39a29d4c89..c022b16d90647 100644
> --- a/drivers/acpi/fan.h
> +++ b/drivers/acpi/fan.h
> @@ -62,9 +62,9 @@ int acpi_fan_create_attributes(struct acpi_device *dev=
ice);
>   void acpi_fan_delete_attributes(struct acpi_device *device);
>  =20
>   #if IS_REACHABLE(CONFIG_HWMON)
> -int devm_acpi_fan_create_hwmon(struct acpi_device *device);
> +int devm_acpi_fan_create_hwmon(struct device *dev);
>   #else
> -static inline int devm_acpi_fan_create_hwmon(struct acpi_device *device=
) { return 0; };
> +static inline int devm_acpi_fan_create_hwmon(struct device *dev) { retu=
rn 0; };
>   #endif
>  =20
>   #endif
> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> index f5f3091d5ca84..fd2563362142c 100644
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -347,7 +347,7 @@ static int acpi_fan_probe(struct platform_device *pd=
ev)
>   	}
>  =20
>   	if (fan->has_fst) {
> -		result =3D devm_acpi_fan_create_hwmon(device);
> +		result =3D devm_acpi_fan_create_hwmon(&pdev->dev);
>   		if (result)
>   			return result;
>  =20
> diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
> index e8d90605106ef..cba1f096d9717 100644
> --- a/drivers/acpi/fan_hwmon.c
> +++ b/drivers/acpi/fan_hwmon.c
> @@ -167,12 +167,12 @@ static const struct hwmon_chip_info acpi_fan_hwmon=
_chip_info =3D {
>   	.info =3D acpi_fan_hwmon_info,
>   };
>  =20
> -int devm_acpi_fan_create_hwmon(struct acpi_device *device)
> +int devm_acpi_fan_create_hwmon(struct device *dev)
>   {
> -	struct acpi_fan *fan =3D acpi_driver_data(device);
> +	struct acpi_fan *fan =3D dev_get_drvdata(dev);
>   	struct device *hdev;
>  =20
> -	hdev =3D devm_hwmon_device_register_with_info(&device->dev, "acpi_fan"=
, fan,
> -						    &acpi_fan_hwmon_chip_info, NULL);
> +	hdev =3D devm_hwmon_device_register_with_info(dev, "acpi_fan", fan, &a=
cpi_fan_hwmon_chip_info,
> +						    NULL);
>   	return PTR_ERR_OR_ZERO(hdev);
>   }

