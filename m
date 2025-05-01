Return-Path: <stable+bounces-139337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0D4AA628F
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84583179E84
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 17:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACF0219A91;
	Thu,  1 May 2025 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bk6HoXDi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE401D54C0;
	Thu,  1 May 2025 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746122394; cv=none; b=KRAhG+Y51EDWT2+2CyM2+1z38JBPWg0M8KS6FiSI/2bUg2ZjZ+bN3uHaGCBUWgUt70pqC/UnD5ruISjcqbIbh5Via4Vg8mZarJVAPOl6/rIUow7M9HT/Fd58Gs0wBACwst7MDVyuUVGGPN0P/aCJ0PSe8nrTQbi7SDgKD13IgkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746122394; c=relaxed/simple;
	bh=dIQUCShLwBXTXsE4l2kw65IKT1lNhQ1EI4HfKNwEE2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ViuUMcLl55AEbQZDmBPmqxYpXe0Yn29pGlwGGZQZ+xxj0kithEsmnZRp83p7yP7YJIVNFmbieEWU4rhjkFQyXo7U5hKthGpJ9Yzdnmez2Js4us6an+DkqCxPbxvAi/DnWvx96BWqt7NUWESbbH5r6SGwCwoOGBXRhpe9zJnlNUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=bk6HoXDi; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso8930775e9.2;
        Thu, 01 May 2025 10:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1746122391; x=1746727191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aHMG1aA2Sk1zdDZxkb/FxZQE43WXPupzxbeonOi1fI8=;
        b=bk6HoXDi3zgnaBx37tbD34p1wNgtrvWhDbqh0C6yUb2mAXONWjmRE1SU2sOy6IV1ko
         bImLQ6Ljr9OyDwwqKp8oiz6AcYJbaR3Kh+RrHcEh6683DlNMjchSKMQu29JYLaA2XuHT
         zxFZh/fVLLm+D8Ouo0guiVuuj7LiV+rfZ2X34gCcfQJrFqz/Stb91hKBjBekfAR0fQo2
         Omp8RsKLk5m9MsulTGP3eD0mJC0Kddj5vgDWB89sRwCU839EcDkhvRsUlt09bXsAdu9t
         uff2epJluqlsnHRbFxRtebfiVOJTDeRvcluetk6VBsC+GSDUvYmIg968KtNcb4/kCpeL
         Ow8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746122391; x=1746727191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHMG1aA2Sk1zdDZxkb/FxZQE43WXPupzxbeonOi1fI8=;
        b=K5UnrUqI8vx0F2q2RFPgyejcrXyRwP3PkJUmB9APxkLcrv2zq3jgwlVyjV7M2eI/D3
         2A4jv7sUfujnco9jRpqvLzkB2YYUyETPTFGepLm2gu7+sBXkmK7WBIPvKP/FHGSCPQFr
         T0MTvvAOAv+x/XR1rHAtzKDs0M++kpfJZILMI7HojlYYOCCfkrP4NMMgTDlQFunATnP4
         KG8mXtMQ+815m+U8G0Rshy54by/PMSc1NPLhRo6sEABk2Aga/DE4nYkUBdu2BozvzNWw
         U+47Ho+tDNTTkGSJRTR+q++CQgaEtuHaQVVFB4O3WKp7KUBQ9Kvy9r04EjuM5kmIDrrR
         50Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXVser1uNPrWTDyFO7owzosmW/9jsfYj8lwI4NeLHIgRGsrhJOKSz0Iq+TauIlcF8xV552idQCg0LhznuM=@vger.kernel.org, AJvYcCXf0yUg5FO5bceLb82sjKEgqSBewE1vs5JJoOpeScYWyCn13uChRKELIpHAZS1X3g/6e25h4skg@vger.kernel.org
X-Gm-Message-State: AOJu0YwiS+iuQS68VOr3rnCzZU3N8FAcbWHi+XIr6bW9OMlbaoh9Xcoa
	Gmk085/HzGkvaZJdpDI0ZNWJzYLT9TfF0aJGvTmurErDcrp0cHM=
X-Gm-Gg: ASbGncukTzekn+X6/WACqTj7ZkVQ+E4GlQWag50zdpUHfKd67lQaQjnT8dr8FcN0L2c
	e1Jsinxybxe4RVAn8K72UZp4u3zpn7TBddY/e0vVPrcz2F/HhVX99k+/Un8O/QQslSGKPbdaXGL
	ps/R6yuc2vsbfeFsw3Xu71AUhWRErxStm9lDjwZydkuUh22ogG5TORGwp2PGHP59SuMBGT8qbil
	gxNKHzWMm1vp81QeyLSLhvquxe3DFi79/gTeTYvyHbffJDLymxssyOH+LEtpYkawWfywfIReeCh
	4gS7RbJ0wmylc4SYj2RLk+SUFnh3I2cweTlMv0EdTBPLgD5kDLddiid0KCVvm+11v83knlUaFy/
	YxyGrfLP9p+0XdVjnxQ==
X-Google-Smtp-Source: AGHT+IEQ7jXNXCkRAOOEYI68QrE+ebjWWr7a0UoGjImdQBADHX3NYO36ZjZwbQaapURvR9UApzsPJA==
X-Received: by 2002:a05:600c:c3c8:b0:43d:fa59:be39 with SMTP id 5b1f17b1804b1-441b2b61eefmr41419385e9.33.1746122390366;
        Thu, 01 May 2025 10:59:50 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4589.dip0.t-ipconnect.de. [91.43.69.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441ae3f5949sm67754985e9.1.2025.05.01.10.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 10:59:49 -0700 (PDT)
Message-ID: <a8cdbd62-c7bb-4f73-a411-fd3f05c9c569@googlemail.com>
Date: Thu, 1 May 2025 19:59:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/157] 6.1.136-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250501080849.930068482@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250501080849.930068482@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 01.05.2025 um 10:14 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.136 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Just like rc1, rc2 builds, boots and works fine on my 2-socket Ivy Bridge Xeon E5-2697 v2 
server. No dmesg oddities or regressions found.

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

