Return-Path: <stable+bounces-61791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD06F93C94A
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 22:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641CF1F21CD9
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 20:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DD47347B;
	Thu, 25 Jul 2024 20:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RK3tr9QL"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2EF5381E;
	Thu, 25 Jul 2024 20:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721937888; cv=none; b=nXLTam3Bl/tN96l9H3O4PC+y+0irXY7GuYQfLLjdYmtgiE7Mqbn+nGy4MhfBmeFzye7bE0eQUL7agRnFqMkq8meLFX6p+l+gGYWegdoHinP2Z6qUjTuHZLSD9/oPmPszaZuWFHmHCH+FY5hNE31FyAIPpWY0gHx69Smmm331WE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721937888; c=relaxed/simple;
	bh=0zB5it7uK49pQC3YTBqbw/wBLjvQ626Ng1xUR2KMEEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Stsx4nraceqWMN7een23LxOz1swbuUdoREQGccUEjYQXYElKdDypfRitLEPI0AFSNhvybQWqyfr/o8FpGCSt3vrWp5wJiewQbGXzvcYwopzHrqW9kqtTkZCYMM9wWVCiDjfaZqqvs5bRDSNxFH2beSdX4wb4qpJ93lfPST2UwjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=RK3tr9QL; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a10bb7b237so1908881a12.0;
        Thu, 25 Jul 2024 13:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1721937885; x=1722542685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJIispQ3EhnPiKSUP/X4tjbEqf9+Q8SqMXAI+5oyRU4=;
        b=RK3tr9QLoY0zOxbRVBfbk0oKIrpCTJKqCJBqZXUW322hDzRd1XNHkzQGmJLtjRmNKB
         nkJVnENgEUBGrq956P2WRWjW/IBqi5Moew0jgwkM14I+J6clJkeNWDBlKts/Sy7OSKWD
         Ui74GmN81RwLo7i53fh+NabZmqB2XbBkBy/vDfH4XgGlcnoH15PridAhyrPzLpo97s5N
         TXZy1XlqUacxzAp+LI6nXB2GcyGKThR3tuW2/gWtAhbHrx2pYiFKtbrs2Ohm1kF6neIh
         Xo5XGcmJ+Zt/114km4D9smLTUHkCI3RUNydjkO3go7/SkgIq8o74tuEQVTujd7a+e1Fg
         JEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721937885; x=1722542685;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJIispQ3EhnPiKSUP/X4tjbEqf9+Q8SqMXAI+5oyRU4=;
        b=cOCprceNlKsnCYFNFb9a007l0REsWp5HisKP3D0GnV2SRNPf1PqMYQrGr1N9BVjFda
         g44fIBfAsAOP6nZclui8kisijDW7TqhE5DzlQ2O59UQONVz+GstJaNM/l3tJ0wRI25NQ
         /YQrqfeiQC2gi/Wlg955FyVtXUqufkk48thL7I05oOxPtHZTQI9cES44uWXbKFYsQeCC
         UPvQSNNl1XcmpctJQRgZImqLfa4b1YT/UMAQKpBF+6IqQEQ5MCACjM/WGh6z5OIo3LOM
         IOUs7IJpi53igpU4VJxMd5gvLWFEHV34/LHUALxI8ettER+2I2pBKo800GwyXo0j8dlh
         FG1g==
X-Forwarded-Encrypted: i=1; AJvYcCUFjse6CErP0OPt03JhBpJbfAFwKr6MBGJYvc5zOYcmL+P8VaOdr+o3v6pXveg2Gd9DZDloyFGd977schxDP6Mjka4B8EP/FMbQcAA28hZwlhRPGBZzrikdrmlPGf/7fM8tWb62
X-Gm-Message-State: AOJu0Yxsbxqq8fpXZLxhzHzh8EiaHNk4GIDp+pkGODnkSKBkqgxPdYKt
	b424pS/+9oL92/Q3tDTEvBieWR74gX1D4go/GZsE/ifBoleFUII=
X-Google-Smtp-Source: AGHT+IHv+JcRw52C81YjbNlPDk230BPZ6wrLJ+DFbuw6XvAOhzZdLdGqm8xx+I9UbYb+HxaG+LizZw==
X-Received: by 2002:a17:907:7296:b0:a7a:952b:95ae with SMTP id a640c23a62f3a-a7ac5075296mr326877666b.47.1721937884882;
        Thu, 25 Jul 2024 13:04:44 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac836.dip0.t-ipconnect.de. [91.42.200.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab50cbfsm103131366b.47.2024.07.25.13.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 13:04:44 -0700 (PDT)
Message-ID: <af0ac6f4-8c6d-4a02-b771-d47347a15a1d@googlemail.com>
Date: Thu, 25 Jul 2024 22:04:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/16] 6.6.43-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240725142728.905379352@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240725142728.905379352@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.07.2024 um 16:37 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.43 release.
> There are 16 patches in this series, all will be posted as a response
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

