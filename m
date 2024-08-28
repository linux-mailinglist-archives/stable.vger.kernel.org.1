Return-Path: <stable+bounces-71363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4646D961D3A
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 05:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C0DAB213AF
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 03:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E387213E3EF;
	Wed, 28 Aug 2024 03:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PpkSO0R/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207F37D3F1;
	Wed, 28 Aug 2024 03:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724817428; cv=none; b=ktgx3Hmw+Fhmrt7Npg8S0K/qixJtDlznBb8xO8q4w+9DJq/AA+g0BoB0GILnpMJLPXB+0uqy9qw2wKvtdB9fuyb8zSGbRYjzGChNHwzFIyYXXLgquTVAiB6ldHRywMBNt70qSr3BZ9SpincguBSelk1iemRYKbeIpotWzfKrve4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724817428; c=relaxed/simple;
	bh=UwKLTJKJ+kvJnkgK0z8V8LkPDYfPPx+BpyLniTHKNNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KgJbpJkfRUuygXOptFgxZsevuyeHS/ZdBzLeLpxe6/u6r1CqnJ5pNlDr1nwB/1T/9zYx2qFyHMnBmAql//aOpmC5oArWmEZw7O9relGJAHyNnAlMAlYxrpN2jBd9k2u3dUQhWzrkwGkFN7J9Cesn0hpm5h1kFgDnmD+rX7PRV4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=PpkSO0R/; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c0ba8c7c17so1366853a12.3;
        Tue, 27 Aug 2024 20:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1724817425; x=1725422225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EzclbIVCSpcGzGI1KzyxQuU4nkWQH7mpAqwKSO79IDI=;
        b=PpkSO0R/bHuUJqe9lqjnbnZG6ZHwiNUXyNkDVhHIDwsD5fJgofMUV3ugI2JW0UA0oD
         o93jJxcQ47ClZLxKNn5yGVwfgaatDnF8+K0MTOv0dk7prm/ulf+dJ3Juk3p4N7WAZmm9
         yubEIptvUZwgZYNHwbvWsH+pc6m0tmv7yYw8AVH3EU7TvpKUdbTPJYG+1CRqtOIUXlN8
         2yiQDdJuBnfxRS07x3Z1Og0jJ/VNNeoki7h0RL1h5TRN2tQrIW41eq0RuzaITp4gNxMx
         WW6mSDXeAPh7tdb2bLpp/TZyDFe2JNMV9o2GTLn36SH+MN4tz1uDiP6+RTMb3TnBv/BK
         hsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724817425; x=1725422225;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EzclbIVCSpcGzGI1KzyxQuU4nkWQH7mpAqwKSO79IDI=;
        b=Ue6B/Qf6FxCKAmebA2KehSn9bK+vsdpojOa4wa9GJ8eNccpnWd2u6tIkBGqHVxZWdD
         jVR+zoXzOUkm5PFI6LA9FrlbLVUfkOBkn2+hdb0ijcFZp3EaB6QD4fiyET9YFFqMS2jy
         CNK9TB9GFqzjgNkhLAcAS1W0LWX0KOK8gzMX6y0cgCqrKYD6Ug/oOlpVBZUEDqhBbJW2
         Mvcyjk6Y0MPHRnAAyCYEBBW//WsbNjggPD3+T8yaUshUunDwfjsx3hRAGBGPl7vRYafG
         oHpjFpghRXfds5M6RzrlOxMP4U25xSNcs5mZ8ZjW2BFKOyHdUc+r9137xd7asqNddLhD
         QBhA==
X-Forwarded-Encrypted: i=1; AJvYcCVc6j83UJkoLVUMHE+VC6N0/jZWKLxiaTa+L3kaIZKz+ZTIE3AKGqmeXrpGd7oVBsccT7KVI8v808iFIto=@vger.kernel.org, AJvYcCW5sMxRvaDMHAEPL62qRe37/GjcptkPJt8UxMRyCXru1d2o4UCnBDzDW0tFdq9LucI491ReAsK0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7n97dikLIklJpGVV4e7OJNA8irgHY3qNig75yvVmujfe824sp
	QFrYVvf1aLH74TPDHf4YVAPQd1daIyH+ulya1xFcb40aCWCxpCA=
X-Google-Smtp-Source: AGHT+IFxlKbX+LbRWV7aZbftCGATpRO1TTetpgg1VZJDWcdu87qXuw3Xb0aL/yr2urLN/YdGSrE40Q==
X-Received: by 2002:a05:6402:3489:b0:5be:fe26:dac1 with SMTP id 4fb4d7f45d1cf-5c08915b2d5mr15319508a12.3.1724817425200;
        Tue, 27 Aug 2024 20:57:05 -0700 (PDT)
Received: from [192.168.1.3] (p5b057ded.dip0.t-ipconnect.de. [91.5.125.237])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb482286sm1680674a12.94.2024.08.27.20.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 20:57:04 -0700 (PDT)
Message-ID: <2a6ffb76-d72f-4fae-a2a5-3fe79081254c@googlemail.com>
Date: Wed, 28 Aug 2024 05:57:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/341] 6.6.48-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240827143843.399359062@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 27.08.2024 um 16:33 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.48 release.
> There are 341 patches in this series, all will be posted as a response
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

