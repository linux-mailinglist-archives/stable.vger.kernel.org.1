Return-Path: <stable+bounces-178816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4D3B48115
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 00:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64D487AECFA
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEA8224AFB;
	Sun,  7 Sep 2025 22:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csLJ2nsn"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACE61E5714;
	Sun,  7 Sep 2025 22:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757285150; cv=none; b=LMu4/hzakLzidHRsInFbOmlHk/SnK9txB2Kp5SHP6PnoEaQMLHuLpUkGVyA8PFMq5PSH5kBMB4WEXGBlMiftyOZuH5W48l/+TAXzgGUw0Zs++XP2DrKsdoFk2eTOaLHC/if35f3MhZaAIqJW89neGciJPoIf/tZzzDJVYDdaH68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757285150; c=relaxed/simple;
	bh=0jD2nbuzFs3Qz+yuGCHahE6cyz8G4KKtokZFiYbJvPY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=I5G5B6GcnkNOqwaylLWpZJe0gzx+2acfvOInTMSTWhKF+4cFNo+Jg1oGKj5mmOPmDRLDJkeuskWfPbvwDhfbC9Jmm47dyn8Ku/JY4Z/5Y0Pvej/8rj42wb2r44/cO2BShbVR6T+scU661auqE8ss1Rpxl5CeG/H6ml1ymNBhlHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csLJ2nsn; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-60f45afcc50so175583d50.3;
        Sun, 07 Sep 2025 15:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757285148; x=1757889948; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkxliKuOCojf0Z9kc9WPWiu/hCTWPCjjzX+cmq59lLw=;
        b=csLJ2nsnk63nCkAsnYqT1/XiJ3X9xJFQkbiyWwJYF5vDir7ffsdJsu+Vy0JpXEFxqI
         kXbATljITfOMkZWHoszhRdlDOZpgL0z4vGMToDluxb38QiwRIRf4MHepYXcU56ddEWBr
         FwhnBb+J0ii15kcNEJWL3bzE7FJf3872yW9JlmYNoqiJcU5dJoK5Noz5cYVzUBkHJ1Pw
         K5NiY5PHeArNQvZUgyELzW2FI2OAodtQv5sYg8q9CrBI76w4agrSBn3LS4nk2QrifgWL
         IzzaQs927NsdZdIfhaZPLeR/66NKd30ksV3aPctobfWwOAH4+Oor9arg51c4r7RsFZd2
         8eow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757285148; x=1757889948;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TkxliKuOCojf0Z9kc9WPWiu/hCTWPCjjzX+cmq59lLw=;
        b=YNNsDIlkdcXOC8YERJ7j3K5t1WG8sD0wmuoQhyIeShsfA98h03Y+pAFiP2uXbPV/f2
         9si0JuaaeDC2kCkdWOFsAnmf0YxhWp6KuAQYb5QROBdyJs+wMMEwExTjxcnqCMZRaPTK
         pFtCGiu69Kll3PzKT2duFmiPtcbsIikwmZHD4qbfVoHamh/6v9G1wk4BQJ2e6ZKup/J3
         UUBWOPJ7IVfD1nDKfF1yedrKN/6pnltxfWtw1/ZPMBkZJcjuJ2GntHzwUhrKhOcO7m8O
         g9SMLUEDiHPuaRwfsCWOu4/mc7AzSzGZ+BVkGcHKzKxF0dNH2h0IknlpSW4fwJkRqwgw
         wi2g==
X-Forwarded-Encrypted: i=1; AJvYcCV+u3JP/OmGgUpdFSUCIzC/Ldaa5M+YxQLyzelHaKXPs6FoiE/xZGpxGwcWZlP12OJOhr++0FTcb/X0m9lU@vger.kernel.org, AJvYcCVq6jCNB2GZr+IgP0TsvN11zkFkRQ6sqD8yEP+2Q06hlAeonzsJhlwT04oy/ZVi4Rvmx8mo0f/488vaMDI=@vger.kernel.org, AJvYcCXOgzgVyKbHpmotPXNTu496Jizh2mSpRl9wpnbH8ZW8l79mWMDY5Ndbp82qly4Vn0S5JvMlyjEC1Nvt@vger.kernel.org, AJvYcCXSL9rVC/vPJkm7j14cRAidFRY2LWobB+uZvZM04c0yRMcjal3gqX8IXmMtBUzMoZCE0hOF47Y7qzpx@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm/1gZi5825Xr8RfkVV8Gv1y5ZTMBMqZRnTNZO0Uyk2VYHUWrO
	/aH0kKsQpz1zQs7pEc9X/i/E5ytA8wNizuJmL3LW+ADG8dtBKjl09x3n
X-Gm-Gg: ASbGncuFw6/KxXgFEvwQ3gRqHdh6CKUdN/0dsiFiBU+h+8CBiLp07Bm9g74MWeBfDl7
	e+alUR2r/HlCpYZsyj63FK0KBWiVEaie8MIQB1LNw701/P2AeEtvMle+oFd3XYESGuJIbSmyZ2v
	oX+93eHQMtpEl5PVWmxao/vdECV0IY7xhi5Q3xV4mt9y4emXI+YVMwdLF/kjv28H/UNlMa1e0L6
	7E6ZLQIVj8I+RPu8aC+F+sOE2C/+T7hAYTdyE1ZIMzZTFHOelrnsy0MkcOLScRvYsKLcWzbbPOw
	KAYJ5/EG/7M2Pd6x99YEYUKTuRV8FQv6+hO/vboOaYpXU2K+0vCCgfH/3d04EaDJAjInHzo6GJ0
	ikWMg5IJu5i8OjTdFJizoisVT1QBneWsEaVpf
X-Google-Smtp-Source: AGHT+IHJZOQyIT+ZmN7dREbp5B5v3uYWcZqENi3lRy84/dY3w16DuqaoAc0P9XuArj7l+DeYtI3fZg==
X-Received: by 2002:a53:8451:0:b0:5fd:8af5:7b86 with SMTP id 956f58d0204a3-61022e31b5fmr4107640d50.14.1757285148151;
        Sun, 07 Sep 2025 15:45:48 -0700 (PDT)
Received: from localhost ([186.65.53.118])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a8503a56sm48080117b3.45.2025.09.07.15.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 15:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Sep 2025 17:45:43 -0500
Message-Id: <DCMXLEBY7Z30.20SQGDLMZPYJS@gmail.com>
Cc: <stable@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/3] hwmon: (sht21) Add support for all sht2x chips
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Guenter Roeck" <linux@roeck-us.net>, "Jean Delvare"
 <jdelvare@suse.com>, "Jonathan Corbet" <corbet@lwn.net>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250907-sht2x-v1-0-fd56843b1b43@gmail.com>
 <20250907-sht2x-v1-1-fd56843b1b43@gmail.com>
 <6d385692-a4be-4fce-9628-274f95fb24ba@roeck-us.net>
In-Reply-To: <6d385692-a4be-4fce-9628-274f95fb24ba@roeck-us.net>

On Sun Sep 7, 2025 at 5:19 PM -05, Guenter Roeck wrote:
> On 9/7/25 15:06, Kurt Borja wrote:
>> All sht2x chips share the same communication protocol so add support for
>> them.
>>=20
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>>   Documentation/hwmon/sht21.rst | 11 +++++++++++
>>   drivers/hwmon/sht21.c         |  3 +++
>>   2 files changed, 14 insertions(+)
>>=20
>> diff --git a/Documentation/hwmon/sht21.rst b/Documentation/hwmon/sht21.r=
st
>> index 1bccc8e8aac8d3532ec17dcdbc6a172102877085..65f85ca68ecac1cba6ad23f7=
83fd648305c40927 100644
>> --- a/Documentation/hwmon/sht21.rst
>> +++ b/Documentation/hwmon/sht21.rst
>> @@ -2,6 +2,17 @@ Kernel driver sht21
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>  =20
>>   Supported chips:
>> +  * Sensirion SHT20
>> +
>> +    Prefix: 'sht20'
>> +
>> +    Addresses scanned: none
>> +
>> +    Datasheet: Publicly available at the Sensirion website
>> +
>> +    https://www.sensirion.com/file/datasheet_sht20
>> +
>> +
>
> Too many empty lines.

The next entries are also separated by 3 lines. I did it like that for
symmetry.

>
> Please add SHT20 to Kconfig as well.

Sure!

>
>>  =20
>>     * Sensirion SHT21
>>  =20
>> diff --git a/drivers/hwmon/sht21.c b/drivers/hwmon/sht21.c
>> index 97327313529b467ed89d8f6b06c2d78efd54efbf..a2748659edc262dac9d87771=
f849a4fc0a29d981 100644
>> --- a/drivers/hwmon/sht21.c
>> +++ b/drivers/hwmon/sht21.c
>> @@ -275,7 +275,10 @@ static int sht21_probe(struct i2c_client *client)
>>  =20
>>   /* Device ID table */
>>   static const struct i2c_device_id sht21_id[] =3D {
>> +	{ "sht20" },
>>   	{ "sht21" },
>> +	{ "sht25" },
>> +	{ "sht2x" },
>
> AFAICS there is no sht2x chip.
>
>
>>   	{ }
>>   };
>>   MODULE_DEVICE_TABLE(i2c, sht21_id);
>>=20


--=20
 ~ Kurt


