Return-Path: <stable+bounces-178813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A457B48101
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 00:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF341676C6
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766341E51FB;
	Sun,  7 Sep 2025 22:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVMT9Til"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FAD11187;
	Sun,  7 Sep 2025 22:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757283642; cv=none; b=D+fBUML0unDoNunxH3VaH2dfEWvdMoXhBn76hl09s4GLvSQva84cc8b4Oi/Xg1fSWdu3fvcZtlWs0ZScGvin2yRgyEap5uI5Lj0LA+m9zdXXconx+T9Uxp3FQrVdBnPWrACayho256pRchGUykiAR1rodCnfkFhHedY8L1yK80U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757283642; c=relaxed/simple;
	bh=kcvUFSrJv+jkpfKb7L8QHdcJV9eVN+MhuAwAcboBabI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dV9KRUIJ7u2vygGSdwW2L9YQzTyWDrcOcX9kl9hGPc4cOV+IsiCwGJ6dP2UQbWLrRo8fISBViAwnQrqYQNAdJCMVtf6FvDWLd5AlHcwdSzwfbfugKQbx5tJGiCQ0PAddF//6Kvxl7IDlxC9XUXMH8Pq+Lj1iuU/k9B13NcAK6SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVMT9Til; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-772627dd50aso5183761b3a.1;
        Sun, 07 Sep 2025 15:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757283640; x=1757888440; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=slhL5gALLAb5HLPloJnYUoGrHds7XWTQt9kurpt8JMM=;
        b=VVMT9TilSXxvBwd/t7RYjuuskB24PdhTI4igpT7C6KPIoR7UwkTygcxX96U+e1nGbq
         aeg94/KGL1l0/I6QzjqbYhoAa1bmn5RAj2Zj//nWlzRdEOT6Q60ugfmYxRtF2uuQHv98
         6e0u/yqDK9iAJhiPKmFEnZ5ui295KL90J1vbPnHdXbeUh+UGL5apSW7rgO4Spr/US1ce
         5Xp5YkEdc3vMX7ssE7P/sarQzBidwEb4Lvgi9iyCgL+gSZ/eqT2sM+kqeZvNrDteY5PU
         7meEhjsnx2X+qCnswOcKkIeU7sT9X3QAalszcUCb/GN24LTHfE71rao8LNghN/0RV8Jt
         TUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757283640; x=1757888440;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slhL5gALLAb5HLPloJnYUoGrHds7XWTQt9kurpt8JMM=;
        b=FzZ9gPHHTfkjiGgoprjxkQ3/yQvCBjMEfSTQmYaMA8WzB9s4dkEwd13Wiu8l/BzBxy
         dgXr+1iPfbSixfklhLiEaTWJjugH24OhOzKsu+FrX0oAVjLsJSMpGz4e20FaAKJOPu87
         R3hZbwQE9MfBIrhYUTbvdCqHYIlpOla9Y62eGVJAgmxfIxGaJh3pdJnEJjoqwJBZlLlr
         jReG/wMruZ22fZXSbADJ9bjrRnQEk615sAu+p8mcVGz7ThFQu1J9NYd9hCiEeHYW3zJy
         Ym23w2ZBC0tLY2jAQ2qk+2gi/E4WIiFQ4B9J2KBxlWpAw78nzc+xaDsCBpg3v4WZR5A8
         eFTg==
X-Forwarded-Encrypted: i=1; AJvYcCVOM7nb8c+CCEjsLvPYFDqtweXEXqzqEer+v9pJ745YvCmXcdbnbgWKFyLK5plcdVGDeolBOB93y7oe@vger.kernel.org, AJvYcCWF8hi6Hm7xQxZuTCfJibymToMQL9zQSkQUdiuZnACMK+mFK9Ai59WgGkzGRXYgzKcaZqhMTHBUbaN9ZIgB@vger.kernel.org, AJvYcCWqKIgh0GOLI9sLYMNOFQu+wCUkji5BS3gqWHh36gl1556N+0W/JILyPC5woOaJhsRW8E0hzu5PXUQy@vger.kernel.org, AJvYcCXKM9Kqi2YYAQ0nUvHgH2/43zRQ2T4n8i5M1muyVU8wdej/f1CaIYSo6Uy8mo2mcY6KcIM065mBfZ+erjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWT5c/UveBfNulbONXdmlnZHVJHA9VxPh8tTxwulTvMUkIxr4Y
	MAL1RvOntU9zNx0ADarMTsjE3iSbhj3lUXHlW3BGjwVv+jQPmrMY8w7V
X-Gm-Gg: ASbGncu+yj09RJqWds9jIda+V3jPIdPQ0glNFZEEJjI6s6ZRIEi/7KU1BV6xR9/sj0R
	gdjKiF6mj8sW4K6BSZOAHIg5knuM3NpTfd6qrpy+k7APL59ptl1PR3wtU2hQ38NSfeB0vJwtOWk
	mtrEWd0nwlk3ByNrzG9knjujqMiR9YEHZZk2XdTpxqbbZ9qKroBCJu6rHtVKJm7aHQrGDQpgVOd
	83CuYQXgADEtFGpp63nPaGS/IenmH3pMhsCN+I9PaXGnknYPsQgfGvriCpEnPFAnaOj3mED0sFy
	m8hlPpTCmviEekDnSipx8yMGNXtBeOaI7Y4xvPR1sVPynbDM0aIELE/Exdz6fhcG0GFx+BKAm1a
	OtzjkOcyg04bqQckh5+NI5aSy/gGuQK1MEvHaGw8HvJHD0cd8L7UhMrZxEaMsSE6mafOgAw8=
X-Google-Smtp-Source: AGHT+IFK1nOTVndi5cmVnLwerb7HT45x5TTE76Lt95SA+/ZDiLNqL2EVoJ5psJLW2EIQthdMgRcurA==
X-Received: by 2002:a05:6a20:6a0a:b0:23d:c7aa:a6f0 with SMTP id adf61e73a8af0-2537cebbcffmr7749782637.22.1757283639887;
        Sun, 07 Sep 2025 15:20:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b5238e43c48sm122110a12.52.2025.09.07.15.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 15:20:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <abe17127-ea61-4ef5-b5ab-664eefaef6ca@roeck-us.net>
Date: Sun, 7 Sep 2025 15:20:38 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dt-bindings: trivial-devices: Add sht2x sensors
To: Kurt Borja <kuurtb@gmail.com>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: stable@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250907-sht2x-v1-0-fd56843b1b43@gmail.com>
 <20250907-sht2x-v1-3-fd56843b1b43@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250907-sht2x-v1-3-fd56843b1b43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/25 15:06, Kurt Borja wrote:
> Add sensirion,sht2x trivial sensors.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   Documentation/devicetree/bindings/trivial-devices.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index f3dd18681aa6f81255141bdda6daf8e45369a2c2..736b8b6819036a183f26f84dc489ce27ec7d8bc4 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -362,6 +362,7 @@ properties:
>               # Sensirion low power multi-pixel gas sensor with I2C interface
>             - sensirion,sgpc3
>               # Sensirion temperature & humidity sensor with I2C interface
> +          - sensirion,sht2x

I think this should list the individual chips, not a "x" placeholder.

>             - sensirion,sht4x
>               # Sensortek 3 axis accelerometer
>             - sensortek,stk8312
> 


