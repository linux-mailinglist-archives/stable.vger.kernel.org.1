Return-Path: <stable+bounces-71504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 302899648A5
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 16:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BA3FB23821
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 14:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD531B0105;
	Thu, 29 Aug 2024 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8Px54WX"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7C51917C6;
	Thu, 29 Aug 2024 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942173; cv=none; b=Go3nWEmOfPpiRHvYwIYoeipsPLuu3hAZVN4mA5CHhr+fM7x1UZ5FPJSv+W3RoUIB7ZwG2J9snbCK7dYX1XXxIERxNSow5idXqWQL6ttXlukPfTMNpbbnc570shdQj41BqavAT8ulhKA1B/313aYkzVZKGfEkRPL6N5E4HBsMG5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942173; c=relaxed/simple;
	bh=wV0rifWc8jE+4EGTDiSp+mP9G35CHOjfcfgESSVB6tI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LdFnw6FqIbWqHhoT8MiPlQMQ4XBgqU3LuSz2JwDuKKGB2MrgpA3iLz/zSK0WhDRNDTlO+6ddKN7F7M4CzF6Rx5a18X8MresHsq1AO2v5FYsHvmItavPdj7ywoiVltmTxyoLon3lu/uNvhoMHPFWb5LNrZy9INWoakZ1BsiUp+D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8Px54WX; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5334c4d6829so929604e87.2;
        Thu, 29 Aug 2024 07:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724942170; x=1725546970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Tpn6XxxAZKYHTvQzarmmwqTcZabjzJtLck2ubfsUQQ=;
        b=X8Px54WXRFSM+N0Tr8TC8hi4Aqv8CsmD/ZhBpQSyAtQzJu+GRUqLtaYFgGqxCq3AU7
         8SjNNVr+uS7eySexR70oeIfmtrGW0QWaUSqboV5mBEucHQgl/qtE4XE87ZEnolbmgfVE
         z3c6q+3aGGL1FEU1fcOX6/gJuMCrCtiv74neHWY3awRTLDKvK89fUKYUkj6qAEeJxgSJ
         QAbbOylz/7WDQlM4FJFQbdP4eO3jRkpcD3VDBbIJ+nhhIpBfi6gWF3jfnK+5zuZylHj3
         uqitdWCVkfaH1ie11wzqLoo7E1W8vx2muyDs6oiPOUJleXPry1JHacrl1H0Rermjjs5+
         NwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724942170; x=1725546970;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Tpn6XxxAZKYHTvQzarmmwqTcZabjzJtLck2ubfsUQQ=;
        b=SjfS2pJkaVdXDp10uzFdeEVzqZyk1a7EJl+RlDY/rTjC/HoTULAQmNtfIGTeuSr7S2
         mpB5LQkJ6FfcqIrs36HeYoWaU4TbnfRYqyaQoQDqpozpRSiY1hARtmJYDsfnji9s/+br
         n4vDkZTG8DYthA7AL28L3izMdUDEqoC5BXEy4vNLs1L2KoPNIJ5dfyr63xZ8KjIN6HmS
         D+snWbp04e63g5ubSySDGju0S9IiXKzdpMM6q18QexSJmDgCPbIPBWofmXz3By/m6uwZ
         E8p9HRBRYTMIDzPljL3ALch40pzlTu+3afLBTzv8Ak9uLTx7Dqk646VemSkLNraZwfDw
         2J+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnix6iW16xH/MUgICKffaABejm804wUQ1v32wv1g3UcecvfmtlKHQNzL6g3vzXy3GaGHBxEcHk@vger.kernel.org, AJvYcCXvloH2Qp6ALI/yQ7ryqYSQMhMQHcGqIMCbpLplcHAEamvrTdh7xdPhg1ogu1GpPuy8ihNyJlxgn9ugng==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZlcALf0MNDQCwivzSDBDJSviAiHGw7w4ZWkGmdUrZrkI6RNND
	vj/LGRjfUYZKgJzCQLWKURgYuwNIeKGukTLyQyjTS1WcdO0wWYhW
X-Google-Smtp-Source: AGHT+IFFrR6c6rfAhDZwyZyXw2wwbpeRiCwezQccKpnskZqEE6IZgd28D9XJ9nNdJrr8fvPGcXXADA==
X-Received: by 2002:a05:6512:6cf:b0:533:3219:7755 with SMTP id 2adb3069b0e04-5353e5b7532mr1829405e87.58.1724942169326;
        Thu, 29 Aug 2024 07:36:09 -0700 (PDT)
Received: from [192.168.31.111] ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-535407ac185sm167328e87.105.2024.08.29.07.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 07:36:08 -0700 (PDT)
Message-ID: <adff0886-1fb8-44ac-a86d-855e4e6dc8de@gmail.com>
Date: Thu, 29 Aug 2024 17:36:06 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: amd: yc: Add a quirk for MSI Bravo 17 (D7VEK)
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org,
 stable@vger.kernel.org
References: <20240829130313.338508-1-markuss.broks@gmail.com>
 <2024082917-jockstrap-armored-6a14@gregkh>
Content-Language: en-US
From: Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <2024082917-jockstrap-armored-6a14@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Sorry, misread it, so I need to include it in the mail body? Do I resend 
this patch with that change?

On 8/29/24 4:49 PM, Greg KH wrote:
> On Thu, Aug 29, 2024 at 04:03:05PM +0300, Markuss Broks wrote:
>> MSI Bravo 17 (D7VEK), like other laptops from the family,
>> has broken ACPI tables and needs a quirk for internal mic
>> to work.
>>
>> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
>> ---
>>   sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
>> index 0523c16305db..843abc378b28 100644
>> --- a/sound/soc/amd/yc/acp6x-mach.c
>> +++ b/sound/soc/amd/yc/acp6x-mach.c
>> @@ -353,6 +353,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
>>   			DMI_MATCH(DMI_PRODUCT_NAME, "Bravo 15 C7VF"),
>>   		}
>>   	},
>> +	{
>> +		.driver_data = &acp6x_card,
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "Bravo 17 D7VEK"),
>> +		}
>> +	},
>>   	{
>>   		.driver_data = &acp6x_card,
>>   		.matches = {
>> -- 
>> 2.46.0
>>
>>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
>
> </formletter>

- Markuss


