Return-Path: <stable+bounces-52246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E14C8909520
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 02:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD691C20BBC
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 00:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749101C2E;
	Sat, 15 Jun 2024 00:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CNNawEkw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2A4440C;
	Sat, 15 Jun 2024 00:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718412976; cv=none; b=WJA7KA8vD4RvCSNwLoXLTkj56JhncNrlM1PBsOVgAVlG3xcLqHlj5IOLJZ27kwCvf/U0VvPbGLtWZKS/yv3vzLbdll5igdNyx5/PUo7xHjgg6QP9BnjQF4ugNLxEQuHfWNJbpUobeZSo9OF3p/4GHTLQxEcrCjoNqSZrMpuCQT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718412976; c=relaxed/simple;
	bh=xAOUve96nzRjMjGiUPA98atnzfn+8zSS2djXh7HQyQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxKns7NdGgL3AXYheD7BQaKvuBkSTrUSzFYP0TrGlI9KSfCSKx2a8NyqK4/9XVbZCIs/Fe+cLdeRP4eXxwaDnpeIyIWHY8EhaSpHRl1ttz8IL8kqmqUfFkLSPZQxqr0EWGFFKNuB5xjDK9U0UjeSpctXO9TDfr5t7IB0vKPiPWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=CNNawEkw; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6f177b78dcso367557166b.1;
        Fri, 14 Jun 2024 17:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1718412973; x=1719017773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MhPhQCOOoQnlUOqGQeHnLIf9fsvszQNArbvyi0UDoYs=;
        b=CNNawEkw9Qz2zvCcu6/DkReu7eYidgS4lY96YwWjmiyciCxlnt7NKi7DuXRERx9z6R
         CYbmQ6w0GPIX/CX9IZxqpzBMzg5n3RKp+U9OSSE/3i2jmTPxWDrv7gptcP/ALP33WyKs
         VJjyjhJUAmvyN4rlBm9+yyd2HfNCWcG7zt191Q/43CoY4wZ9DveiXnl4S2eK0vu73EoO
         TsnFQ1sn/k+H9WAfDi9ZXXRIN6hHsLzx6jTPICVsLX1Bh3kfyHnR0N6tjlsX6xRcIk/7
         xwKvwhLv1osSgW3uLGb4bvZ1LujNWwoltnECS3RPWWh7/P7FM5xHgz/ZSLtoa5M9N2dR
         uN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718412973; x=1719017773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MhPhQCOOoQnlUOqGQeHnLIf9fsvszQNArbvyi0UDoYs=;
        b=VSZREMJKK4NbMnjS+qNQxB/IFU6IjZ98AJZXd+lj2h17fhjRlS+hZercBtMfycy79N
         U52007LgGICf3WkSVXFcxXKO1nr7LSL6tayKe+Afff+HaiM8FO/QFOYDATU/mB5bBVI9
         D+PT3uJcWCK+uZLSl0o9/ZY7/x+UAY/VTtZ+jR6aTTTqh3Xp6k2fyPu0WLX2TWQRUgwC
         6eF4+rgWiw9OeOczycFR0x+lfw9UN/0h9/GI14x85bXOB86mFHZtJjA4rZzyAYXivFZ3
         tiUBtK7aBs2WIAESeaxFtFeHrEvjUApOc2ZxIP3AqSEebIjhT307+xzfmROrRJe8kDlG
         SiQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWB14EeolyiOQoIiSNuTC34YYjh5wz+8JkuQqHeUV7Wri2+vJhOUoSoe6RcHz7pdHEwxU0+HYNB3b79MNOltRqAh7fiAd/XUGyI/HeBdQxLxGOo5APCwPAKTpkJQ8UMM14ur4q
X-Gm-Message-State: AOJu0YwvrCjfcHDynD+uAh7BEqJUWt2Vx8x9ANoluhMWNt+yCVGUbuP6
	xXbXtgQBNx4hRNtcMDtKorAuz8TSDbIq+kGG3R/ELWPU2dxfny0=
X-Google-Smtp-Source: AGHT+IG0B5lsBy9jnULieYgLvmnLrftGOgA3ohOsKOLCHMupilq6C/57dHPtGnk4QzxY1gtFlrfz/Q==
X-Received: by 2002:a17:907:1c05:b0:a62:1347:ad40 with SMTP id a640c23a62f3a-a6f60ced4b8mr292509966b.16.1718412972742;
        Fri, 14 Jun 2024 17:56:12 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4225.dip0.t-ipconnect.de. [91.43.66.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da40b7sm239580666b.22.2024.06.14.17.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 17:56:12 -0700 (PDT)
Message-ID: <3dec1820-42d8-4c76-9424-ff73fd7e5643@googlemail.com>
Date: Sat, 15 Jun 2024 02:56:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/137] 6.6.34-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240613113223.281378087@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240613113223.281378087@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.06.2024 um 13:33 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.34 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works w/o regressions on 2-socket Ivy Bridge Xeon E5-2697 v2. I'm 
currently test-building 6.9.5-rc1 under it, also 2 idling VMs running at the same time and 
I don't see any problems; everything running smoothly. Nothing unusual or suspicious in 
the dmesg output.

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

