Return-Path: <stable+bounces-118247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18274A3BC94
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 12:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABE50188A14A
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 11:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2A41DEFF9;
	Wed, 19 Feb 2025 11:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JHIKDTi8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71BD1C54A5;
	Wed, 19 Feb 2025 11:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739963910; cv=none; b=MLXhWrC1dgPlz1Jde+Ussnl2EQWUTwwz2xBbUrOImx7qqlo+FQoVpFCNWAwothsv6gIF6g4s+AUZLn6tZtH3cSHokuzvmicWZiWPBPjIjtLRwuL70HdMD5EO1GCWU4i6MOCdAl+yg46eHJoxcHQlCputAlARdrOqmQ+AJrK5tfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739963910; c=relaxed/simple;
	bh=40mCJlvF8cko1+OgcezwWGuKpQJ0u8WrathRhG8tZPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WApSEx1rPyj34izQUr5DXT9CasjGvs0Oj9t1YZCDQDFBG3dWppys7WrYOWLV/ry0puUwDbXJMq9ihgnJJCKB2Ke/OSe9pJBOIiN11ERBoZ/yxrFR4vpXME4gvKoGwDFr0BQ0ZZXM5AQmq6Zx9nyzfEXMm1yGNEqR6t2YwTReef0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=JHIKDTi8; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f325ddbc2so3391381f8f.1;
        Wed, 19 Feb 2025 03:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1739963907; x=1740568707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7nAXyqLiQShxXdHExWOGFHNht5Zg/ZSArUtFxZtpy/s=;
        b=JHIKDTi8NSwT1M1VZ65GdCS5w7XSXPFyxzV+7PPmNScwcxy7FI3GgTh43+S3WwSOaK
         5thI3LBc7SrSViIsHFbBjXkH6WMNiL2pkJNCELtYd5HNK37UJxgFcJbPPI4vb/XsX6d3
         SW7lihlR3UPta8B87YITEQC2vvTEE9kkHWCKS7pN7hf8Vf3CCnKIPU5FwfVetzaxC0Tg
         7lE975ztprfse5A2/N0FqK9eqGbpjqcyZrAiwauew6mhtJcEpt/rWkr4KFJERJTgZumR
         +7mXR0QyI3QLnrl/Ns4gM5lszc7WabxTvuaMUJ9AScQ0+l0Mxerlo2UowkOp+slGOByi
         rFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739963907; x=1740568707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7nAXyqLiQShxXdHExWOGFHNht5Zg/ZSArUtFxZtpy/s=;
        b=up60SwH+5cCvgLFuebwNgwJ6hvDntmfCEr1FfZNGqsa5WWkUqDYU+nwiKqvpfIEkJl
         nSSAIpg32WbXtwSmtX/zdjrl8HAVtKsXzkttdVq4ztuY1VMHpHIoLHkoKFRrFMtzPOo1
         EFtZGvLu/BS6LsM2q193NWJgl1kWUSLkvhETgMHAcXvfb6MM30dMtWIE7OVJQVms/Wda
         dfVy40idChMXhOvzTArZ0IAZKMDL29g5zy9xaIfWfTDJnV7iN6Y97NE/yTXqnpnNTwe1
         v6G6GkP73ja9KFD4ASFl4jhlHlrwK2moGRW//jilR6iDiYzGiwpaa8yb5jyNL5FbS1/L
         +K/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvdY1DDf6Gw8KPMzi7dR6sjuEbMwxIQnQjILXbSyRdwXtTW/drxSuMozo2N8xrdylGMwF86LiTWe3rvCM=@vger.kernel.org, AJvYcCVjTgTKa3vIm+3IdF6Oh1AMUMk11AQGcbskaBjnOgKJ4dzPOmJXu/zeaerF5aUL8/PITgBPod17@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl2QD1F7o90YdGiQAi5xfm1/OyB94GfA/LhSUX0BLOIkBrDwgo
	jcW5oOFdVkFFZfLkwSCzj7V+Bdz91JnAn3hnHnaenxcE7DeSD7I=
X-Gm-Gg: ASbGncviSmp4BsAsryTfAvCst+BAoFHanaZ3aiEDJqxWFw+Fi6W7+VAih6p50uTHGsp
	ssYGj/G6FtqRySzrAlrOpyzyAJIZVgf3boZ3r9wleAtXlXWl9WIwx2VlIxtx+gBoUgF7gzeFxnH
	JLPMgh4NwVMeQmRdBE+jQT+2EvKsqIU8HgHHyinY1U12uZXmLoovwRHCofX7t16wbmqBBfVlqKi
	qT+ZQeU9s7HKu8X7UJ+gHF0wzsyBsoCphEdIRgbB7v8px/jWJfVVra5VMJ2Rd2Zn8NWTRlMuKi8
	1UTIT2njRq1GpyrgmHMVaC3k1DnYbYSZl0FKUdcRnen3N79+vdBsdREr3w1nKu8V8pr9
X-Google-Smtp-Source: AGHT+IHqSbU/mySv08zQ+ZnfmJkUguL9G8ebWxSbh5QnTnV41gOwaEKyh41mQEtSGCtKswwMTupuug==
X-Received: by 2002:a5d:6c66:0:b0:388:c61d:43e0 with SMTP id ffacd0b85a97d-38f34167d68mr19545175f8f.48.1739963906782;
        Wed, 19 Feb 2025 03:18:26 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4e7c.dip0.t-ipconnect.de. [91.43.78.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b434fsm17819691f8f.16.2025.02.19.03.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 03:18:26 -0800 (PST)
Message-ID: <7a077c71-e325-41d6-8cf4-d3fa8827e51b@googlemail.com>
Date: Wed, 19 Feb 2025 12:18:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/578] 6.1.129-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250219082652.891560343@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 19.02.2025 um 09:20 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.129 release.
> There are 578 patches in this series, all will be posted as a response
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

