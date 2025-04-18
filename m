Return-Path: <stable+bounces-134510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C713FA92E90
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 02:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B5B1B62C80
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 00:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A022C9A;
	Fri, 18 Apr 2025 00:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UllDNg1T"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89112173;
	Fri, 18 Apr 2025 00:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744934583; cv=none; b=ahXKH5K7FbA9T5jv8A5sqCNOukLq0oLrqR0bMZzbmFSK+TuY2LKxqmjm7e+KGfSah+PUthnmhipiRcQrwkwi26eF7drI1N28KbL4hAQ8Lnvj4/vIzZLig/iOoeC8VU421SgRCITmY1L8xgpDt3nvsEvQeVhzLWSpc2KfI/U05r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744934583; c=relaxed/simple;
	bh=I3vPHwz7YXNw7jyMDxMuM19c5WPgpDwBVDtkHVjJSdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q229EGCqpMSwzPK34tbfA2yncmrzMUwo5ePjN/pRXHeQgjfqA86tBfjw+446Wd00tJO1QMbzGQ/nPwK59qK1PkQGUWjfLIS7OyaRMWwbBCaBPu75Om3WJVckXwhq21wtfVluluETSjOTWdvJaYB6KfIBFkoyFrIKXPgiFXhQlR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=UllDNg1T; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so10690285e9.3;
        Thu, 17 Apr 2025 17:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1744934580; x=1745539380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gNSwumT6dkwZXP93FOE/yTTGvtGUnL3MKS6N1HOJCjw=;
        b=UllDNg1T942cmNK+59nxiYZ8pTI15oQRLnpakxkswfRgVfZ6IFlbVHmpgCfsTpn//9
         1Mqnh9KUa43ofAPX0gezjE3ggi2JbL+QZpHOhQos2qJv3/rUmFDHRoF7SYY/6jwCgAJx
         CPdrOKordBifQmYUb+3/sWii1Rur1PdJcXrsnnytyxbBnz6FDi1FTcFAxK8Zu6Vi/s++
         +UFPGYD4z+v7grFupS27lDAsohQV4u/7wQkR7/MK/iqHMTbCkO+xSt1pG37Usx+A19uu
         uiE+HSzeZbD+YnZF5BiUluz6QnrPdIr+lFzkFoNw6V6z2CFYkR2VV4geTh1uld7j3sEk
         7x2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744934580; x=1745539380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gNSwumT6dkwZXP93FOE/yTTGvtGUnL3MKS6N1HOJCjw=;
        b=vhOT5zWyS3chfoMmjSEFnDJ8QpZR71EQxjf9fI4IZ9cSSKmx5844SxKe/bu+YiSUrO
         nJcIsplS3Rvfoi6wy5CSoqqo+tUW/hUjepkUvJXYKV4kZEfdgJ0obeXSo08zVxclgBch
         YrjtiE92+clJPslJ4w/wJMiTi3nBXbYm8cB7Rr11dhxR3y6EePyPyvbD0B1aimKzmotW
         5An5/ogisI32pwenymE+Kl7KKbFa7eEcP/CgRUsUYMXN/9DcflUvnhqkP5iSi69ANsOS
         KbXbjTEH5u7PskE9dHxuaj8vgRVts9VrDmkwhkrp3cf/A2EbcWV+RsYvw3ovo2bNnLJN
         w2EA==
X-Forwarded-Encrypted: i=1; AJvYcCU+Cr2fiHQikOo/A7wEOnC3L4YsZxKCInWVke4f7uNSBVog3ZfJ213r7C6DZXhNqXxbKFLRSxnNwTP6/ck=@vger.kernel.org, AJvYcCUlO9tXfv/+RgyvubAGL4JIsBZ+w2/x33373wRdMfK4khmRznRrLZyDwwvPyPzF/zowAmkXRqGv@vger.kernel.org
X-Gm-Message-State: AOJu0YxTx/e+zO9X0YkiFPAvSQIi3tuNVzmOzxcArdlr4XFLnNkODl2S
	ZgCu2mIgiY3BZTkG/rZTGz3mqRdA65Xgq4VN1YvkKkuAaj0ZQdg=
X-Gm-Gg: ASbGncsqWYcVSbkmRYQHJo5w/572ySpwkuIz8SUgnXJ/jz9X5q9EKwqwsicOHhb076A
	7uIhQrqyv91kdaeusF0xaL6lgLs926WlUbOSQB1dtpCa43x35Orfz3kU670nq4vHd12Ut9SEbh/
	pkU+ZkDpNlG4AoQ0BAWVAsYoBnmgxb29Vl9rrVZjC6ul3wzPHSl58uYK2Dojug+aGqC3ruDgyV8
	JhqQtx36+lR83Ks7Am727Z1O6psuTa1YT4cE+Ve/jxJnXIXYZjQDwkySmPWJb5Q5PvYJRg5F6lJ
	n2FeEYStgEK6j7qYBWVsbPlg09pT9AtaG7r38B4WC2fzeLBfDLaVRtgPzkGoRc/CgsUHs7tqVMi
	6E8hh9dsqsCTyhngF7Q==
X-Google-Smtp-Source: AGHT+IGx1X35CurvpNYAt4nira3OE4YKiydirlWlHKZoymkoqhWg4da61wRCoaw+BGEmyiTvjY7DTw==
X-Received: by 2002:a05:600c:3c85:b0:43c:f81d:34 with SMTP id 5b1f17b1804b1-4406ab976cdmr6076825e9.9.1744934579739;
        Thu, 17 Apr 2025 17:02:59 -0700 (PDT)
Received: from [192.168.1.3] (p5b057cb5.dip0.t-ipconnect.de. [91.5.124.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa43d071sm1096071f8f.60.2025.04.17.17.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 17:02:58 -0700 (PDT)
Message-ID: <d7a9a1c5-30bf-4ae5-9e3a-c36823645e4c@googlemail.com>
Date: Fri, 18 Apr 2025 02:02:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.14 000/449] 6.14.3-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250417175117.964400335@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.04.2025 um 19:44 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.14.3 release.
> There are 449 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

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

