Return-Path: <stable+bounces-172525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4F7B32569
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 01:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7314F7AD707
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 23:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6594D2C11CA;
	Fri, 22 Aug 2025 23:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Xkf6imxC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB4A2D3A9E;
	Fri, 22 Aug 2025 23:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755905279; cv=none; b=c8N6wDagH5LsygfNm5pOoVEAbDG5hjz38cXkJC56t9UnJW3AbXJEXkDqFRSaLWPqu0ixvdUHfXdIsfyW88z/NmxS5e9kBI9B3y54NMkZzIjYtegj0WEJwf/HIHpmA8RGWxdTV6O3XcytITqDYhvPbeUb4oSz8GTUUAr5q8L0kKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755905279; c=relaxed/simple;
	bh=Dtbshtfd59+ACburoBjaQs73/LoWpyMIikfBId5SyFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGW4mvs/gMJoepFwqUDaZgtgRqoW5+5FSkLH9JdpJbNxh2MCjwDdF6I5bEdiOMKGXcmHdjtukgDljsPSrpGZbSVNWMZP/npLqQjvZ0XXdzclLmjgOUfG4ghWiwvtq/VsuXkPNv2lopSpcpa9Uiecd81MoVV/MLLwqBn81DSNprQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Xkf6imxC; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3c68ac7e238so452471f8f.1;
        Fri, 22 Aug 2025 16:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1755905275; x=1756510075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k1gpNFvn5HCFRwIuldpjghpNbvpOxRC8cn9/8F0Qqgs=;
        b=Xkf6imxCYYsqSySZ7kenoXJcCSBsbNOXRNstNrojSUYMJY2CPYgLaQmtxLApbhFfly
         qHXXX6VP+7OruXrcnaPEPW8a4pbE7A8Ut1tiIhnFYRksfFZJsifj6MHSzrAfST8sGI8k
         4R1HJ9Ev5Avia7sZtQ+IIGGjETYV+XGZjm1EjqevZUuErv42UhyCSskbC+edSNOMsL1C
         dYU1uWbux3HIueFItAaLys1zxeGdw/jwbhAqqpYLTxin/h5b8KsxmmFSIKxX3M19CSsY
         b05Rc48NcxyoOqcWgBpluEsmaROycfb6YS+s1CDwSW+6iTFyl/xMGM0fkn/S2vOnvhTJ
         IAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755905275; x=1756510075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k1gpNFvn5HCFRwIuldpjghpNbvpOxRC8cn9/8F0Qqgs=;
        b=WKV3DBLSDtcIeGC4CpY0Fj31f2sZfmMSqFb8zydt2t5Z7N4Uv6fjxhiELe0VfolBqy
         b9sTWIcLUHdYue6zZ93ifEwn2RBbCHEvJMECI/mNk5hpQE+s1jy/TXxcemn8xyybkFUD
         6Hqgm+6ej+6VOTEwNU1VP/DKxu2IT2aMbPjd8Zect3hPCCO6YqwKpsUSKsvm0Ltwfobn
         NzizLYKW5GxAtl1DjPyCpBx8F6UNg/hpOTVpZpNBtyytOD+KeQEwWrm9sin6XWBNgWnE
         llA6+h8jPSobmeZEU9SlV59Ji0ztLwpSOYLPZXx8oYgk9bD6BK0UMgtMQz6LID7g388e
         YyNw==
X-Forwarded-Encrypted: i=1; AJvYcCUvdNx2bGjMOK/i3KvMrTiDrZp/3fOkjZN4pTTNxjjLHMF+NoOoXs+mfeBmiFYjs99Q5adfWNNCm29LwWo=@vger.kernel.org, AJvYcCWVZXADFY3iY6r3rhZt+AeNdIQTLZybVfvqenzpqRaQ3Sotie2zUEAKoV/nKESsx6tQOvPDwYHC@vger.kernel.org
X-Gm-Message-State: AOJu0YxAHM7oPbc4W0Pmz4zyTfEbxIgFdS5iOyQFuTmhXMhkUBzECm+y
	Lh2tn8SwvMyVI9sttTUJ/+Ei1X+kv+S5TzaD5gfNj3v7dmAQMnqIiPw=
X-Gm-Gg: ASbGncte2ncAHWKKHSc/IxeQ9mjMD0hZREi+YB4lBrpuAergbCOkEu+SZmL9atcHebh
	ujFXRf95RkCXJiwEkCciv3uSs7Vb3Tk0TRozyP1EHjlCtoqnFx+zqC23zuCQnhda/ubrKMt7RTj
	EU83741w4FcxuraRqcwTGC1Iu0xbVrLcE70fvJ72aR/AUaz6lonUCSW8AIpfS6vSQgt6a7dHM9i
	ItZT01992rZx4vROVpR//Xj/BGHrGXT1Ms03LzO2Er5dAINwRVATb5sEQNPYXqNxOH3CSSMb4XJ
	fL0VFnq9h2L5SD/TNfsNLtUtT8u5scb51rmfYWumH0kstXy1cA1JW1k4CBxIGV4YRKMzq9fXk6l
	3txEylzbWlpj+DAZ+pYpdlPfiag0Ndz1xO63WaRnG0se7QnntFBRph7AcBEfWg+qgJpbFCzOT34
	FEzJv3mch/
X-Google-Smtp-Source: AGHT+IForz6W8J+AT6PAiCEWl7L36/ArwT8KQw87Xw+3heLnbXHk0yiBNL84FscOsiQA1vM902L9tQ==
X-Received: by 2002:a05:6000:4387:b0:3bb:bd05:7bef with SMTP id ffacd0b85a97d-3c5dbf69bfbmr3843292f8f.24.1755905275241;
        Fri, 22 Aug 2025 16:27:55 -0700 (PDT)
Received: from [192.168.1.3] (p5b057523.dip0.t-ipconnect.de. [91.5.117.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711211cbcsm1171217f8f.31.2025.08.22.16.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 16:27:54 -0700 (PDT)
Message-ID: <9f68aadd-b0dc-403e-90d8-eedc018267bd@googlemail.com>
Date: Sat, 23 Aug 2025 01:27:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.16 0/9] 6.16.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250822123516.780248736@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250822123516.780248736@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.08.2025 um 14:37 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.16.3 release.
> There are 9 patches in this series, all will be posted as a response
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

