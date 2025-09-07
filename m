Return-Path: <stable+bounces-178817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DB2B4811A
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 00:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 164F57A2704
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E434F2253AB;
	Sun,  7 Sep 2025 22:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kyoba6Qi"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF833597A;
	Sun,  7 Sep 2025 22:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757285315; cv=none; b=DXOyiYwEITJO5/ZHAqkTwHGh7y5/4SiIzZJ/bcoHrnGhF/3ds/T1nsBn1mBnQi7qg2+tm8j+Ncf2bUqc877uRIS4oAJdvpEQlxl2tsWWrjcikvauuOHtudzX8a9ojL6Rzee1yzkvb2Mn1P1yrJ6J14lsXKP7rGQurtrDZ0+dscM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757285315; c=relaxed/simple;
	bh=TqYfXvj90KXhrbbCKTgXDPHHo3VvTStekL+APwRwQpM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SuL42p5RNwU2ILn23TEGNkIZgg5blk9nDP7wmoy8jE1i4CQ2+uqoQt2f2COGWDnFxziZCyelXhNJNP/cIR0LEVxqnrrybEEQSJqndqDU2+7n9qq72gyFaCX1/Wcwbkhm9ov3ugisifgzMdDySlAWxxECl2G3LRM5HpT4ri2RVg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kyoba6Qi; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e9e137d69aaso1383846276.0;
        Sun, 07 Sep 2025 15:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757285313; x=1757890113; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WtoGi3B0zs9r3qRqqZcu48LoyQs2gPIq2RowLVeYzo=;
        b=Kyoba6QiTNlHblN27xQ32iSSbexaADR3XGglMOUuoICMEanuik6WgIdnfM5ojWj3kA
         9jofSJTT8oHvHfYcFwz9o+MjsnbI/1aLxv83gNDxYXfPQzJRjdWwXN+2KrHDN1fkgT/z
         5MCW5bHwUFOpg+rXz/pZqAvMyfJK6MRP29zQdvzmbdAeWKqmMvTh2BzYcvaVejWiK11D
         RT2TQ8WtUt1D+kBPn6PYScpQICYHeK0uMjg7DR4Cey0kvY9qr5+W4TC9YhixymtcWl6K
         QuN9GcqbMw+RqWa/zF3hTsxaaKo2G2XjqaQWFOHcY21/woVr4uZJl5wp/Z6D9i0C7nE+
         ebBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757285313; x=1757890113;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0WtoGi3B0zs9r3qRqqZcu48LoyQs2gPIq2RowLVeYzo=;
        b=HfbPxYGysgriJxJQIGlWAswWhR2iUMgOvHiUdD3aqgLFvtw9TkJntO5xbkjI2GTRLd
         1FyZBht+x+Buua0ABIVc5Z/cRIWQBJkkXIOyfjg/2vY01QaKO9WS6e1W5IvkaO6bLdNX
         yXaKa9YOthpsa37A9QuOfMoWJrU7xOeTBbid7a6Cn3l6TX5KR7IC9Md3usM0Ip+uD0bp
         YVN9xZ6sAVDI/Bbmg0ECx0acNSN0UxETIZ4/h3tH+CbiwRYPD3XsuoT8DDMaxQ5gF6e7
         U5CH+4psSykzB4W6qHIx7psTkr+gd0kcVqxjyb8o0+WaZ6zCCpPOjmaWFqGdbue4UPo6
         64vA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ6LAL1KmM7bVBwAVxg7GebNejshFR2U9QIM3no+antp1imNMKd2cPtW9F5tJ1hQhq4/91z045fEAyo5M=@vger.kernel.org, AJvYcCUrmsoksxp+eCIDqHYm07DVGaGu4Qy+7279+rVdy0HvzKanPO0Ll9A8GV2lrpV+W9Zfns6OCnKReef0Wprl@vger.kernel.org, AJvYcCX6/YRD7ElxgF+xqjEQ0h0Bz8mU95LoXMioyFGfCfjK9RFihtDwcr5vO0FkY3kmWQn2fmbM5MF03b6b@vger.kernel.org, AJvYcCXWJF58V6WNUoJYmViU94uKGKs3F1bma2JmI0FXJ9gjEIO75aTsDIVZqteqpf5TiXgC5JMkgy4tnSEo@vger.kernel.org
X-Gm-Message-State: AOJu0YzsZrw4cVJ4FS1EQrdAvzreCX9SW5S+oQYf6IPEYRQLiqMMfApW
	ue+0XxecQVJUe7oibcJ6DIDW4swGTIA7kFSuI4FArSXoiORnLvbOhtrr
X-Gm-Gg: ASbGncvHCDB6JfkcY7jTai8+HRMYXlC7yP3hDdzdnNot2DTbDBG9wdRBRH12H85kzkd
	HmcZqLbdbLuoHDHfmpJTz4YLstTadgIwNJ9V+OCh8Zv59QUoEA8AxSjccsgD56/g2FVkgkSoeBa
	C+egbSgB8GcG1Qa+zv6r4fa/SGOe10vArBuK4JxdwjPSXqlpqbRVtCPeRZQJyP+qvmKVb+P/UL/
	JZd2E1j0qCkxCXemU6g4EdyFUCjm9S4AwIBtPu7ejYBY1+0UskhtKh21epr5K90Je+FUm1sAfIu
	yj3YRAKej4k28S/irzh3nhbQ9HUgtN3XxPHamxOtNuFot45ss3r092wVrWFfFNxwhYsQKx5FaS4
	zLrjneEm33pH2eQpmzbjWbxcmKg==
X-Google-Smtp-Source: AGHT+IGdrMfJ7toqSBXyRtY6+W+dUg3qtromyBT1OX82JyErk/tkK88ARYscetrW8kfYbyKHm2zdSw==
X-Received: by 2002:a05:690e:4286:10b0:5fc:5017:8cee with SMTP id 956f58d0204a3-61034cd0addmr4672567d50.31.1757285312966;
        Sun, 07 Sep 2025 15:48:32 -0700 (PDT)
Received: from localhost ([186.65.53.118])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a82d58b8sm48097067b3.9.2025.09.07.15.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 15:48:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Sep 2025 17:48:28 -0500
Message-Id: <DCMXNI2IG3BW.1O8848AF6CUOA@gmail.com>
Cc: <stable@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/3] hwmon: (sht21) Add devicetree support
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Guenter Roeck" <linux@roeck-us.net>, "Jean Delvare"
 <jdelvare@suse.com>, "Jonathan Corbet" <corbet@lwn.net>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250907-sht2x-v1-0-fd56843b1b43@gmail.com>
 <20250907-sht2x-v1-2-fd56843b1b43@gmail.com>
 <502a7a9d-3b5d-4bf9-9cd3-fc3d387ebe62@roeck-us.net>
In-Reply-To: <502a7a9d-3b5d-4bf9-9cd3-fc3d387ebe62@roeck-us.net>

On Sun Sep 7, 2025 at 5:19 PM -05, Guenter Roeck wrote:
> On 9/7/25 15:06, Kurt Borja wrote:
>> Add DT support for sht2x chips.
>>=20
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>>   drivers/hwmon/sht21.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/hwmon/sht21.c b/drivers/hwmon/sht21.c
>> index a2748659edc262dac9d87771f849a4fc0a29d981..9813e04f60430f8e60f614d9=
c68785428978c4a4 100644
>> --- a/drivers/hwmon/sht21.c
>> +++ b/drivers/hwmon/sht21.c
>> @@ -283,8 +283,16 @@ static const struct i2c_device_id sht21_id[] =3D {
>>   };
>>   MODULE_DEVICE_TABLE(i2c, sht21_id);
>>  =20
>> +static const struct of_device_id sht21_of_match[] =3D {
>> +	{ .compatible =3D "sensirion,sht2x" },
>
> This should be individual entries, not a placeholder for multiple chips.

Sure! I'll add an entry for each chip.

FWIW sensirion also uses sht2x as a placeholder in datasheets.

Thanks for your review!

>
>> +	{ }
>> +};
>> +
>>   static struct i2c_driver sht21_driver =3D {
>> -	.driver.name =3D "sht21",
>> +	.driver =3D {
>> +		.name =3D "sht21",
>> +		.of_match_table =3D sht21_of_match,
>> +	},
>>   	.probe       =3D sht21_probe,
>>   	.id_table    =3D sht21_id,
>>   };
>>=20


--=20
 ~ Kurt


