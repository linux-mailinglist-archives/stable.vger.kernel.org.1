Return-Path: <stable+bounces-206273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D580D03D09
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4755A3079D61
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECD0348468;
	Thu,  8 Jan 2026 08:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OPve4reT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F7eD2iLG"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C78340D91
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861673; cv=none; b=FdVvQjVYd7z6uHpYZI2HxspEvZlUxbk2Bigm9FPplJaxBR7f0xSjthFtFjW8R5IteCXIaKm0YurrOhKE5onE1v8gtnV+X3T5jwrkidCi6h2L5YQV5ewkjOUkCdNI03Cw/NiV863UCOaXO6BKC5zaldoqDMQNa/2XFzgOW8qrBQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861673; c=relaxed/simple;
	bh=xjHglDM/JW2NmeVeyAr0+dj+UOkaL7HkzdzU4RxRwmk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OZjJXe/ZwJVfhyAs06mpONJkpZHQr5tkcNSUFlxx+Pec2MdCYhbI62Y2R8l4GtCg1XOvRbEOvQwGgMAfql06tdr7334kB7s1vsWV3w56C1B8Xl7Pd4WzMYuyfXW4gRW9s5I3ePWwT+dioeq+ygjh8kqKaEruXAabYWuH/kaVSew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OPve4reT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F7eD2iLG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6084RKX82593336
	for <stable@vger.kernel.org>; Thu, 8 Jan 2026 08:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rJGaMaxcuDZkeMl5qtNbvmW1qLM20Z6W7DUk5Nd+ylo=; b=OPve4reTFeGDugdT
	7nHIJNmjpV1vNAhlkyOidifyNZDah4vhB3qKCbdF/u6nyX7tthRY+adja4iTljJK
	FFAsrQzIOnXyaPaC8CZYS4sj7TwsD+0+ppfWl6/MHbFhLtpCNvzfxOCX9jye8rnb
	nWocUNcr+liTaAen+b+mfcjYa1NBqbaijRHNSSaRhRR8IvA2jbvrB5sOHFIDtkKd
	ao18FdyN1FbZX+HaiJ8QoLy8rqaLAEDXPQz8F/zkwsVgIWmkNy3ev/NKwWmFV6Q9
	6rxrYZTpj6I3G3bQsbqXdy7YVVc6F0egYHMJLfUWvLgNJ4lcD59s3gssMaveVSNL
	t8s5TQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhn293yfy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 08 Jan 2026 08:41:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4f4ab58098eso80481701cf.1
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 00:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767861661; x=1768466461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rJGaMaxcuDZkeMl5qtNbvmW1qLM20Z6W7DUk5Nd+ylo=;
        b=F7eD2iLGUwekbHg5a/0NWXq2ruRw64zVEYhn/43Zu0zY7byjOeUuIaYMUnitQGpWRN
         QSdzZEvr0V3oq+AhfZ7Pc7FJ2rucrbDeDlKG4xm2zMfQTohwPZ7dTMHLwBrd4KnrFUFE
         Ufy1JDKgButOGF1WZKTW1XuUx0tH2/LwNgmqtQ7dIfgP4OIoT0swpGWRfftKuU5EP62+
         Qd+p41pUvdJqIzkJgkGIq0e2t2+4NKWn5LXONfV3vKcOFmJger4HZE/NFgcntkPXdEVA
         z32nOpekxhgOq/okc7BhUNB8RMZ/vHP6DnAuFt56X69FxacGTmGDFCa3cIu7jJniNdiL
         RozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767861661; x=1768466461;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJGaMaxcuDZkeMl5qtNbvmW1qLM20Z6W7DUk5Nd+ylo=;
        b=nWbVZqzTzsyXJZcg4Vyf3IfaSMVnhEbN3rw5TI2AdIay9Ghf0Zev10QRf8AJ38/Oks
         cRHgjtavPr+CSeaKYe+C6Rx9ruRIBKVHENJyiQpkRYwsgcIgST/P99z1cIw0zwH0m1Ej
         Y8XB8kSuD2ElGUfcSgErQSlqwutljEMel9MSJCY22gwAUaSJKp3Fz/U9kYUg4pzas0bo
         8qAzlOEljJ8UUZuFerVFvB49VY0l5ZkJLXAk4fOYrHsbTEy4q+P3z9uJxuRAN3aW8xPa
         x83WOUnbBEJcd/HbgfB2A5rTtN+pd+Dj93wjyMMt02PcM9CkmC0VFMoDTIxQ7hU8s0qh
         lFMw==
X-Forwarded-Encrypted: i=1; AJvYcCW7ZuLs40ZNFERhnTb8YGMyuhNmEPxAjMbtPgaVX1R6s8Yftl7j1yqnHq+6pg+CqJcRelQ2rac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkimnvVxGT/LgqNsmV3fDkecJv61RN6lQnn04dbVQ/0Q5BL8tD
	dX7IELdM8tLXJa9cx/dFn8yRN4cxDJVlAV06F0p0iSles78wzC+wCqKM2pWfPu7/hoyxREhitCL
	ZJm5S8tYLRKJ4APU9u9yg7Jix0wxIW3QmAFC+S+7KlGpjoPvf4O2Y6aJOrGE=
X-Gm-Gg: AY/fxX790OgPpskhNGIfbIGKTfHUwpXuz2I7f6U2A0TYhqeZpL3cIGqfXo/5D8p0kTC
	cs4XcAQqVorLAYX0ZfcxdJXhMWlMIQaqW5DRc+TK5ZG7VxG2MFHRNLKg+afGSScf6UDg2yPJZnL
	9jP4kKvw8E6dySVZIhH+lhh581woKwOFSkvd3rCnLz5ujxaUJrko67hK7MJsxIcyBNdeoWwvGR3
	8P/7WuwR4nR6UCpQr6sACwYPG0gJVRzBthkhHrHRhWy11R3Dvn9yvyQmRyzFM/OHJbDOIHXsjRO
	IVqOJGaAaA9155DqLmrnRAwQTa4F9QQo75UZLDqFv6qdHQJ5GxlNjk5bk9UliMfwGMDcUj84R5H
	5IANxL05SZ4NnEPBPf+y5QQN777rfqm07P4mHQf6jL3D5j3Pd6RkArHiwoLNEENpHZZW1FxKdWA
	jYFuJjfYjRSbs6Lv3iYRBSgnGwot9FyN6brxD5mHT+w4n86TfWP9QLT0jXzUdrDJChefClOfAS6
	dvy
X-Received: by 2002:a05:622a:229e:b0:4ee:18b8:2ddf with SMTP id d75a77b69052e-4ffb48c7dccmr72101101cf.37.1767861660735;
        Thu, 08 Jan 2026 00:41:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+8iWsWKz3GaphD0sGgOVLN5BUK3qaL4MHY1YyUeBUAd9hOKS8/HEl0W/5EmvI/dSudEq58A==
X-Received: by 2002:a05:622a:229e:b0:4ee:18b8:2ddf with SMTP id d75a77b69052e-4ffb48c7dccmr72100991cf.37.1767861660324;
        Thu, 08 Jan 2026 00:41:00 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf66214sm6946786a12.27.2026.01.08.00.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 00:40:59 -0800 (PST)
Message-ID: <7e96da9f-5e48-436d-8e19-d8bb124ab106@oss.qualcomm.com>
Date: Thu, 8 Jan 2026 09:40:58 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH v2 4/5] media: ipu-bridge: Add DMI quirk for Dell XPS
 laptops with upside down sensors
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: Heimir Thor Sverrisson <heimir.sverrisson@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-media@vger.kernel.org,
        stable@vger.kernel.org
References: <20251210112436.167212-1-johannes.goede@oss.qualcomm.com>
 <20251210112436.167212-5-johannes.goede@oss.qualcomm.com>
 <de0d0f9d-be70-490d-9cc0-53f017c69985@linaro.org>
Content-Language: en-US, nl
In-Reply-To: <de0d0f9d-be70-490d-9cc0-53f017c69985@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -4UWr5BgGrzt07LXutO7U-ZO7cNO_aha
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA1OCBTYWx0ZWRfXx83XlnEqhmUR
 w0bpwgjZbBZBVhgT6qnXODeeqgy5DMhR0p1/M7tSWh9C51U4L0oLycaMq/mKG8mCDCCUppBIpwh
 XLyKsvJ4EQNdokH6HLJc6/s7TvI4miag5vjdT0HU7jRik7u2uzpCXnP5hXt/Y1xsM+k+SlhBT0N
 oBJ4YeCPJUYPytcYrXdb9WsKcaPFm0I/StqWtzWZ3YG07ddS/WlgMps+HimeosuBMxVXIzERX1W
 TMOPBs19DcgxFRz8NWwypRmjUCube7KcCes+/dfP4D18aBpeI5BIrRPxCAYKmobQa4ssoNjPqIb
 Ets0wmP01aBTuckxB+5qTjrH6y+EVsBB53/mozgwb8ZiOj+33DTAiLHHv8fd53nTuJtREp7v0e/
 xyg0bpejoNZDT8+P9NYu1l9HTY8sUFaKE9ioYQgaQsCboEe/itUNNi5VQTCq/XN4E6fDOEhJJH9
 nzAiGVnqYhxWPc8yQtA==
X-Authority-Analysis: v=2.4 cv=P7k3RyAu c=1 sm=1 tr=0 ts=695f6d9e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=XBQUi1Y4SS8Vamh7PKcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: -4UWr5BgGrzt07LXutO7U-ZO7cNO_aha
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_01,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601080058

HI,

On 7-Jan-26 22:53, Vladimir Zapolskiy wrote:
> On 12/10/25 13:24, Hans de Goede wrote:
>> The Dell XPS 13 9350 and XPS 16 9640 both have an upside-down mounted
>> OV02C10 sensor. This rotation of 180° is reported in neither the SSDB nor
>> the _PLD for the sensor (both report a rotation of 0°).
>>
>> Add a DMI quirk mechanism for upside-down sensors and add 2 initial entries
>> to the DMI quirk list for these 2 laptops.
>>
>> Note the OV02C10 driver was originally developed on a XPS 16 9640 which
>> resulted in inverted vflip + hflip settings making it look like the sensor
>> was upright on the XPS 16 9640 and upside down elsewhere this has been
>> fixed in commit 69fe27173396 ("media: ov02c10: Fix default vertical flip").
>> This makes this commit a regression fix since now the video is upside down
>> on these Dell XPS models where it was not before.
>>
>> Fixes: d5ebe3f7d13d ("media: ov02c10: Fix default vertical flip")
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Bryan O'Donoghue <bod@kernel.org>
>> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Fix fixes tag to use the correct commit hash
>> - Drop || COMPILE_TEST from Kconfig to fix compile errors when ACPI is disabled
>> ---
>>   drivers/media/pci/intel/Kconfig      |  2 +-
>>   drivers/media/pci/intel/ipu-bridge.c | 29 ++++++++++++++++++++++++++++
>>   2 files changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/pci/intel/Kconfig b/drivers/media/pci/intel/Kconfig
>> index d9fcddce028b..3f14ca110d06 100644
>> --- a/drivers/media/pci/intel/Kconfig
>> +++ b/drivers/media/pci/intel/Kconfig
>> @@ -6,7 +6,7 @@ source "drivers/media/pci/intel/ivsc/Kconfig"
>>     config IPU_BRIDGE
>>       tristate "Intel IPU Bridge"
>> -    depends on ACPI || COMPILE_TEST
>> +    depends on ACPI
> 
> Why this change is done? Apparently there should be a new dependency on DMI.

This patch introduces an acpi_dev_hid_match() call which requires config ACPI
to be set.

And there is very little value in having COMPILE_TEST here since this driver
only makes sense in combination with ACPI, as it works-around short-comings
of the MIPI camera descriptions in ACPI tables.

Regards,

Hans




