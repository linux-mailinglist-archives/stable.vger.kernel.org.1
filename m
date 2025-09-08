Return-Path: <stable+bounces-178905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06444B48E41
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 14:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C653AC51B
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 12:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51765305073;
	Mon,  8 Sep 2025 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jXhDBkmE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701242FB99D;
	Mon,  8 Sep 2025 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336119; cv=none; b=c3JWm1KsjtobNe+FsrmwBMIrg8E/+uKSEZrCVJ1MXwiWT0BL/7oim88XwDye9ik+Y5Hhf9HCMRh8OM2S8NdcgyMPLWka8FxloXlwfRs5mlHllOEKZqO8STwsreFpMAbOZ5NsBelBMUTbQVENmAWjFYAFEuyX45IiOyJBbQGjHrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336119; c=relaxed/simple;
	bh=MAcek040G/5x9LOSDJ+31zeQSYRjenT45JicrjCIKWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNE6vZ60gJzbSP0OOxJMINPWPvyRWcAGcuGz63BQ1EhsRFroprz2H5/BVuQ3el3z7L7pJXqaakP/KIjj+KeMdN3QWcjKOVO+kxhunlfru2T0u3tju/m2+7BIkKuLAmfP54uh+c2fBdGOJK57hbJc+ga2cSswOsTEC9/bJyihMlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=jXhDBkmE; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3da9ad0c1f4so3025118f8f.3;
        Mon, 08 Sep 2025 05:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1757336115; x=1757940915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LyW+2yoEnntkZHje1Z8lDdANIZzachCy6cNhZUPnZvw=;
        b=jXhDBkmEa2eKSs4JSvxF/AQFjbHEFWcvxADBhevPW68m3jfx4tmN8LrReiWO1DrJWN
         sj0142D6XMhF3FWQyi8+ad8xxsS/Wb3ZlEOSr+wd43ONGnhIL2CP8OO14xvpmZfORNzD
         vxolh6vBvjOW2ALgALX13jHT4bZNINEPqRGCiiY4KHJzveoWSe/+24qroDX7a5/7+l0P
         tHzzrn9nSujT7VKrN8/fMnNNWLtiPRxP2Ttk+258t/5kxkMsDUzBFDlJSwZq2JljPb/6
         HFaPg49oTT7HXQwCc3UMlwSqc+a7sFxrdDNfJwzjW4yirtdL2oNk5U4AtQvdMCtSX+qg
         vNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757336115; x=1757940915;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LyW+2yoEnntkZHje1Z8lDdANIZzachCy6cNhZUPnZvw=;
        b=auIW3AowOTq/m1/euOcYegQSS6QmY3ROmetZT6s3croDaNWhNfe+VWjMYd5p+ODtEM
         lYUTac+4jaopov8/5zixZy1r4WqVvYHEWDmHfsdqh3fDPXL23yTlRYHlxOd9ijVsHf3P
         K+V5a5xuB9VRUlvUhf69IcD+PKhfZVReluFAkjdgF6FlmE3CvdmTikTZfVR2Ytq1Ds04
         J0zicvIbWV80SSAOJ6sLniq/yuyN9XuOV+eL0S16p4H/oGVpqDwrMWhuzUd6G3U640kH
         bmEqUm1vz707YMsIQtXi2OFYhoJ9zHmlrlxL/6LAe1zYvkPIzaElAk5Q0MBbwPIwlr+K
         EijQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0nAbnlg42k0f674oaS0JlFPAGe2zWLNw6Oa4LvhKVC3utyKiSkUs11HCwT2uSFjZQWBv9f8vs@vger.kernel.org, AJvYcCU8UCOwLNIr2USxBOl26iO0XZZFJJg9RkHLppfz2LBZbacRs1n8zMZozSqaKsr0/oOdUOatbkVSzzizECQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3whTJht1KldOWf8Er3K6AeOhlfmVdpg6/vyztl89GUo+IfKFl
	bayCEy6FdMiRcO7D0+CnSK1p6icGlJzn/GOPCwJiwF+VnRcajb6e9OU=
X-Gm-Gg: ASbGncu9wh/P2xeqr2Rg1vrxxDpaMxq4ExSbnydsyJnYM6I6xNwDtsf0XlqlFHMuw1X
	+BxfIbQ9huA4zTi20yUyshZ63im+/4pax6EBF1VbatB/YcxGF7+PhbJTAmr1eWZslYtgsYpeuLQ
	vzhpTD51FV3FG2ruhHFMwYa1hVbgACJ8Ou+MB/qZvd4gYA8hCVZHmceBnKYYSwvXBUT0T3XrP5y
	FmPrBy4oLsSFVpRC6QMiiIutBMddftB8UCs/f3TBtWEMca3RACtS4BqUBcSTAHTvWutQn/WBZh6
	Ehs/L9JW6kZsP/tOGq1ZVxU6VoBqNCZY/4Eg/tdMq4OPB0Ntdfed4xPr1hjfCAhUSmPJdgbuiyQ
	GMnqOuwrIorSM8ChzyTyJXCxK8ZHetx2Jg8JPvIVaLXgoQh9QD11UR2SR3BQnsd4qC5wlCSfD6H
	2I2qneKP1epw==
X-Google-Smtp-Source: AGHT+IHw612VntHLG6+SHw45Tkejmg5TARGhZc01Yst5I4D1XaNFWSX+I377HjdCB5+HUQsWwtquHg==
X-Received: by 2002:adf:8b9b:0:b0:3e6:fc80:edec with SMTP id ffacd0b85a97d-3e6fc80f155mr4033188f8f.6.1757336114388;
        Mon, 08 Sep 2025 05:55:14 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac262.dip0.t-ipconnect.de. [91.42.194.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e2f6af9791sm13622647f8f.26.2025.09.08.05.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 05:55:12 -0700 (PDT)
Message-ID: <a3f6afd6-c9ad-4f0a-b18d-99a4ed3c6f57@googlemail.com>
Date: Mon, 8 Sep 2025 14:55:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/175] 6.12.46-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250907195614.892725141@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250907195614.892725141@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 07.09.2025 um 21:56 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.46 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


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

