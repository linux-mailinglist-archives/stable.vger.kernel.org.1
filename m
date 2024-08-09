Return-Path: <stable+bounces-66112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6B594C9CB
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 07:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E391F21642
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 05:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BAB16C6A4;
	Fri,  9 Aug 2024 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WRv/UDn2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CC02564;
	Fri,  9 Aug 2024 05:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723182418; cv=none; b=lFgRRRqheXUJXw9wzHdlT2LoajMGrz1oK2XRTH4gYkKXWiRlCefI19vc+X9/fHM0HngNflWFL+SP0PpPrXsyEDSMbMCMaRHvFPT+z4VO0Jr+s7YCXnP6ZnhbPDiUibuoyB2h3/ytWFF22mfi8naNYpteIGbM6U3x4FadQwfaXL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723182418; c=relaxed/simple;
	bh=0E0LWRTGx2617hGp31o7gUJtB2TmoGqYJk5qN3qe7ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEmYM2HlWrgXQ3Ze/cRRnTDYax60sq9mIh8zgAvH/ixzHGQExPi1qXCXMf5kCf01sdCb2DJY1RjvA064j8XGqX9f8q4PRN5x3TpzSRJxM9eBDcbZfAbITgUZcid10ZIzmHrPn2liDs+BiRTYz98ohsyyHvCOQ1GnyBWsBz8rvNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WRv/UDn2; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a156556fb4so2022584a12.3;
        Thu, 08 Aug 2024 22:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1723182415; x=1723787215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c/lpeCLNhSG0sHQuHLswm/MdyizAAuRsLhhJ2tP51MM=;
        b=WRv/UDn2qIIgnBwFAZFliAI3QUSm2lnWR37Fe7zuz1qrg9arpod70IinkLfwcolNOv
         EMqa6mDzK9SMv0gSJFSDp23zj6qCKWfS3pEH12g69y0CZKDTn4/DdFwZRG5StZSI8nAd
         yNbumozUyQQMgfW51n79J1IA3B1y93NEeBNnZsZRudTjyCl5FCS96375MI20FCMDBd4d
         2nN9f9+Ydz8jA7BYMWkRHtSAVUsuL8mqk3H3F970BYOp9b0TcZ+ZMiPP4+ButHqZ7wa8
         QGKHKQjVxLz1x6QwqjNaNTKjWwKETq7LhZgGmK5VuDq0KzdmWCxEr+jAcBPhGSxRa+Hz
         f/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723182415; x=1723787215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c/lpeCLNhSG0sHQuHLswm/MdyizAAuRsLhhJ2tP51MM=;
        b=WSZuWRreeyrFOaHOFayADEyl4U5CdGw4N0TTp+5srRk2IDe8gKiLNQpCn1uIe8y5lF
         IkpmL7pqdgoxBJ1qjNhp7Qa+p7TC4cDplqORXHrwP+8vTp17lqrSW3Wg0T9GKdiVudcN
         aFkYNZj+bgThih1yGVX89S6yS+59S8bJULTKG3O2QclOsels/12FkRNVU3XoiLZt5imr
         0y8R/DgcUvtziU3eM8K2Do2XBmAfevOvRi7EAtNRDJ9ZqggJN9hQsbyCNeV/3kyDsv8N
         mySjaxKk2edWbuaFrMmb16xZpE7ecqt6XuxaOmc/knkGezAdV8bA257fLsG03F4oeIFY
         Mnug==
X-Forwarded-Encrypted: i=1; AJvYcCUUZoTET+WhR9S0jc2aLRzuXB6BzTwdk+LTFeCb8W2IKGfU1neam2tsjRT95Eik5Lm6xrnRqtWUWE/ZVJg=@vger.kernel.org, AJvYcCXB0ljdefb4n9i9RGVXwH8E1+gSCQGtAaC1cAHMuno+sPjuD6YCoRtCz0E3O4i9HzN2EoY4hzW0@vger.kernel.org
X-Gm-Message-State: AOJu0YzD6v8F3GKsunb8v2GqId02d1jseF2/HVkvd7T5VZhjNiHf9X98
	aOLuPT0V2GRf68fYXNYloXHdjHv0YyXnvbpKgt0L613refEe6eo=
X-Google-Smtp-Source: AGHT+IEQDUWeO9IyesyvpxutFL1b+2BTg1/F6pcdSzEJWMH8VCDcqZq/Eap5yurEGbPb3qaOPrNPFQ==
X-Received: by 2002:a17:907:c7ea:b0:a7a:bece:6223 with SMTP id a640c23a62f3a-a80aa556854mr38555166b.6.1723182414749;
        Thu, 08 Aug 2024 22:46:54 -0700 (PDT)
Received: from [192.168.1.3] (p5b05740f.dip0.t-ipconnect.de. [91.5.116.15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bcaf7esm824725966b.12.2024.08.08.22.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 22:46:54 -0700 (PDT)
Message-ID: <3bb19eed-0ad8-48d2-ac57-9663e932e6c2@googlemail.com>
Date: Fri, 9 Aug 2024 07:46:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/86] 6.1.104-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240808091131.014292134@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240808091131.014292134@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 08.08.2024 um 11:11 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.104 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

