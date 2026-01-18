Return-Path: <stable+bounces-210197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 266B7D3944E
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 11:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B60A2300D434
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 10:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C983328632;
	Sun, 18 Jan 2026 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="AtAUNEJT"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF1D3271EB;
	Sun, 18 Jan 2026 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768733531; cv=none; b=p+UkDooTJ7IcR3RIqPrAKaHcxRIDgFbH/2ZXll9yxHwCvcXBTjWVFVjVYBgyXMS6XUY/Hu7qbxqRHumYSk0evcek6i3QXutA0knkL7iesUgZodVg+FXH7lZ2v7FQU9n1DAsdbkNKMz7SHPo4fHifr5smj57t/6AUVPjTT4xOW4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768733531; c=relaxed/simple;
	bh=NzZQNPzMMpK7VL8gq0SXJ4iGZhTKmg6PE7aBm5NT5r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Er6ChbCZnPC8uJdtR8BHBIfRptlF05EJQrEl6c4kuTq8FvFNagxgxzeIDS8y2HTn9yoddYI1mUjWEdy8Vf6J1v82sk2kN/t8BDUMBfnfhgDm/7WXw8BZbi2v6yCinETl673c9dYkpixeAxL+6KeQcLZ/qJt+2dj8A7yICuzCYeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=AtAUNEJT; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1768733512; x=1769338312; i=w_armin@gmx.de;
	bh=n3GOEolXchCCdKJfVId+u+VSjq/pBBaJQYpNEAcs9yk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AtAUNEJTZtEEQfQMNCDobJvbMz3sPG11e6O56UpnBo+CZ8/HmvnDYU6WoVU7fkL1
	 jKCEZGXsUR0Jh+VN41WBMSJ0yZHtHhNysMs1Vci7oLFmUIw+OMkFHLcNdNOKbeaKq
	 GTiuavAqZSBGdJ/mDnCBIjlJXntD3r0T6D0+jovztRbHrDTnVd/jP1t+5vF8vcj+u
	 zjjPV1btuiLyy6OC0EK2lDHPd99OREv9uJm0EYz4ZonKhwp5jP2c7VgadmgVFYtW7
	 YW2El+5fJFEuGFydIe4LpFaZXyx5eMspEOAa4esQuW6AadAp820MpjHwDyEiC5rtG
	 G3+Nl8o+1MOs+jirog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([93.202.247.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3KPq-1vqfXu2RV4-015BEa; Sun, 18
 Jan 2026 11:51:52 +0100
Message-ID: <dce90eeb-d7e4-4063-b99c-1e4a894a8409@gmx.de>
Date: Sun, 18 Jan 2026 11:51:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] platform/x86: hp-bioscfg: Fix automatic module
 loading
To: Mario Limonciello <mario.limonciello@amd.com>, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, jorge.lopez2@hp.com, linux@weissschuh.net
Cc: stable@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20260115203725.828434-1-mario.limonciello@amd.com>
 <20260115203725.828434-4-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20260115203725.828434-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QbIjtfZP1/wiYCjad/YHZ1YjQ19XFSuPaF2ryh4ZN0Cel5oUQos
 ydfccs4HqgJJtMq+KwGh5gZT0CpzoYntAUN44Cx8GrSFWl5MK42xSnGI2EIMNfO2fSTyQJl
 3fNqYl3fQvjcaRDY6HeDPtQqc8VaPI3nqrymxfnz+Hrutczl0QvltuI+JPH0zbe/dKWyf25
 /2Fl1FQkWznvHei9LSJHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vMUr3jZPsEk=;ANQjwgm5CtnzQFr56H12WuJ2jpx
 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

Am 15.01.26 um 21:31 schrieb Mario Limonciello:

> hp-bioscfg has a MODULE_DEVICE_TABLE with a GUID in it that looks
> plausible, but the module doesn't automatically load on applicable
> systems.
>
> This is because the GUID has some lower case characters and so it
> doesn't match the modalias during boot. Update the GUIDs to be all
> uppercase.

Hi,

this is the second time that such a error has prevented a WMI driver from
being loaded manually. I am planning to replace the usage of GUID strings
with the guid_t data type in the future, but for now i think modifying
file2alias.c to fixup any lowercase letters inside a GUID string will
prevent such errors.

I will send the necessary patch once the WMI marshalling series has landed
upstream. Thanks for finding this hard to spot error.

Thanks,
Armin Wolf

> Cc: stable@vger.kernel.org
> Fixes: 5f94f181ca25 ("platform/x86: hp-bioscfg: bioscfg-h")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/platform/x86/hp/hp-bioscfg/bioscfg.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h b/drivers/plat=
form/x86/hp/hp-bioscfg/bioscfg.h
> index 6b6748e4be21..f1eec0e4ba07 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
> +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
> @@ -57,14 +57,14 @@ enum mechanism_values {
>  =20
>   #define PASSWD_MECHANISM_TYPES "password"
>  =20
> -#define HP_WMI_BIOS_GUID		"5FB7F034-2C63-45e9-BE91-3D44E2C707E4"
> +#define HP_WMI_BIOS_GUID		"5FB7F034-2C63-45E9-BE91-3D44E2C707E4"
>  =20
> -#define HP_WMI_BIOS_STRING_GUID		"988D08E3-68F4-4c35-AF3E-6A1B8106F83C"
> +#define HP_WMI_BIOS_STRING_GUID		"988D08E3-68F4-4C35-AF3E-6A1B8106F83C"
>   #define HP_WMI_BIOS_INTEGER_GUID	"8232DE3D-663D-4327-A8F4-E293ADB9BF05=
"
>   #define HP_WMI_BIOS_ENUMERATION_GUID	"2D114B49-2DFB-4130-B8FE-4A3C09E7=
5133"
>   #define HP_WMI_BIOS_ORDERED_LIST_GUID	"14EA9746-CE1F-4098-A0E0-7045CB4=
DA745"
>   #define HP_WMI_BIOS_PASSWORD_GUID	"322F2028-0F84-4901-988E-015176049E2=
D"
> -#define HP_WMI_SET_BIOS_SETTING_GUID	"1F4C91EB-DC5C-460b-951D-C7CB9B4B8=
D5E"
> +#define HP_WMI_SET_BIOS_SETTING_GUID	"1F4C91EB-DC5C-460B-951D-C7CB9B4B8=
D5E"
>  =20
>   enum hp_wmi_spm_commandtype {
>   	HPWMI_SECUREPLATFORM_GET_STATE  =3D 0x10,

