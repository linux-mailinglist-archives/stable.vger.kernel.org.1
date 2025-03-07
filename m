Return-Path: <stable+bounces-121340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F8CA55DFB
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 04:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46C83B305B
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 03:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1FA140E3C;
	Fri,  7 Mar 2025 03:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SKNhsUbl"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8A112C544;
	Fri,  7 Mar 2025 03:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741316649; cv=none; b=GkN2it3KnmE0wwUKgN2zNCKS5qozWCnqDKA8xwtPoTeoovs95twvJ8mXMomv8Yx0lMppD1MNFPRM/MVp8rDjPVt6aSncx46r1CLNtiNOV6REAkOP+NOjKKqe6Gc4QcDWk2fL2XrnXLZjbnW03ik7AUqU7ZQsKMlyXkoTaiYIT4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741316649; c=relaxed/simple;
	bh=RrGIqDKJpweFekER5cwId0zxUbU+xJB2sSI2/oZpsic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=apN/UEDpJc7SmBt7yNWy2GcijoqcXFGrYxmJenbkG4flQc2aSwPturL6vahZTKru5F7y2ayY+FdawVB6w8AERicxyekYtA0FJe8TZWN6bInAeR9qP2a3jo/6tLMDVIKQULeS2nk+idLO1NzNsI+pvS00Jq0Pft72T/iJExCVEUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=SKNhsUbl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4394a823036so11393605e9.0;
        Thu, 06 Mar 2025 19:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1741316645; x=1741921445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c2YeDBLZhycUkLIElBwE/LDiA0l9Sd6Qk1PyFyKMMLc=;
        b=SKNhsUblVN7dNnJTPrE6JAIWEgTwlySNLBkvBN5OwkH691wnhNqFn2haiup4vcYgXv
         IJNORY8vw+GCTtBgsXV7VTiF2kQMdVqpeuRnMpNJd06DmlRrzVqeY0TkooUJg4Wy9LI5
         sG7wzo0xw1ga/PIk7SuZ8/kd7Llnd8zoq89sps0QeEzz295djorNRZcWurboNEzPSauK
         IufUuF/gBTd0hmfpTwSzBG3PsTlYKRs/t5qP2L8fabUe0xL1OMLWla9fWl7FeVvQMBXL
         CO55IYLNZIJPN2dBpaK7C2b/5blhsSJsSox5xQOMaLKoPT5ptj5llA1a085x+b6eyKZE
         krHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741316645; x=1741921445;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2YeDBLZhycUkLIElBwE/LDiA0l9Sd6Qk1PyFyKMMLc=;
        b=ja8BJ6Z7gTW7+QgbqMunmJPUts+euqvrA3diotQ724MiVbeAIvF7EcobJYW+d0aw9R
         JbY0d4ATxhZMdjskGXqFlE1nQO3p/ZMNx2mwQmooXOF/1JuzM/nX2o3dx3MhUvvo6fqH
         FT9kSG2OPBb4Dtuco6axd1AN1AGcwcFSO3UPYf8p7enFPUZO62oa/kzSbOhJ5bOeV4oa
         0RrizHjY4oSeUAcJ6P1P01LYAMrAJpfjXGlYiaqYj/GXvDLPn8LeR/LAkdid2JOZA0OE
         qQomC7/2Y07IW519kGzhR6hs+rKwmDvUwrFDZLEQW3ob8vUVb6SoWHD5vLsxj2SJHM/J
         U5uA==
X-Forwarded-Encrypted: i=1; AJvYcCUR3MwywEDGc7iMF/wTvr+GDd45gAmMOF4lFYqxEbot/d38YWXcv7h4tVc7/MespuETwrcBAMvg@vger.kernel.org, AJvYcCUVLy90G+iN0aVkh+70Ggsq0aGeChDHib7TQl9H7OHMUYWWmWQ91qbwovJhD6sNHVegHWWu9N1xHBpv6vM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1DiaWmmfv0kriuubmWB8yBIo3AqZU8MMlovoN9QyrzR2QBRvB
	Ih0v87oxT2so/aVqRIyx31OaZHqszMt09cByx0zhsdwNceCWfSQ=
X-Gm-Gg: ASbGncu8i+bZavLlTSKsM8c0Yy/VaJvAuQ4XX9sIsQGyU0k7G7r6ziEJoKy0kEW2Ld6
	imeVkM7ls+gA9y4pBtkFFHPsURtb08g8FF9SFixdRTIxFFOD7k1Fw479qxh9ktplHxgtAgmnZ4p
	PJe1Lk7VLkADYcHb2ZzrrgAhy7sZNXGVuIiH/EWYsf4EEY7+/SLb+oYnjF4QvGsuJlVUw2bOj7R
	BBlsWICdDJw0lRpApjxIG6A1Yk/q+WEl0UFhHzdk8gIxjXBFRwFzhmIBe2RPKwWJORg2WOQTLXV
	HMpDvHM2io2HXnxC7E1FWxG2RQvP43lDcEQVLQApkd8etg1Ca+8hQUiVHJ7lEYNnXmPp1+AEu+F
	cMit2sfvWpUHs+l3h+888
X-Google-Smtp-Source: AGHT+IFnoTfPxZauB89u+A0kCbx1VpCBXD0PQOH83mMRjFQyAk6aF0yuRjJc++LTonJwBCpdrSasMg==
X-Received: by 2002:a05:600c:1c92:b0:43b:c284:5bc2 with SMTP id 5b1f17b1804b1-43c54a13899mr13483225e9.0.1741316645312;
        Thu, 06 Mar 2025 19:04:05 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4f54.dip0.t-ipconnect.de. [91.43.79.84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd93ca93sm36616155e9.32.2025.03.06.19.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 19:04:04 -0800 (PST)
Message-ID: <902f139c-d821-4ef2-ba38-cdca7c53d521@googlemail.com>
Date: Fri, 7 Mar 2025 04:04:03 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/148] 6.12.18-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250306151415.047855127@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250306151415.047855127@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.03.2025 um 16:20 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.18 release.
> There are 148 patches in this series, all will be posted as a response
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

