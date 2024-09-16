Return-Path: <stable+bounces-76528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AD997A7AA
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 21:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B57191C231EE
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 19:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A346C15ADAF;
	Mon, 16 Sep 2024 19:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mpNl55JQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF92D14BFA3;
	Mon, 16 Sep 2024 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726513918; cv=none; b=CvDOsiTRV/CqXJwNU+vwv/WVxTobLbTGlxn119gvqpiZe39HOkXblMnoRZXUMgZZUCKU5YgptRlwKb9OCyQ/+Nbq48KZMzUryCOTCmNcWiyvsqP2aZeKHB5kJcr5H3f/XozarKt3MBtERrbyhrfA/9nc5ljdZRge7++kd5GtsSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726513918; c=relaxed/simple;
	bh=ntZqH3KwhY+j5nLIrPx2YIHMJOlvf/n6FnAxLSeAjk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mE4KsyxPPq8fOMMQk3U1itEUU+/VbqWYJ8+AizO3Du7lbppw3tOSvTM1ZWsKZUgjEN2HUhvAPT8X6e3ayNclV+PUR/DqiQ1jvkp4BR13GeaTD9lQ3ui3OYwly+CYF/RARzxCcFSfC1fcK0mJk9qa0/qbcPZYNo5BbG8QHfaEX7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=mpNl55JQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so40003815e9.1;
        Mon, 16 Sep 2024 12:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1726513915; x=1727118715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QJIs3HP84IMTP+ri2+xfE5tCgMh3aa3QvScDUaw4ots=;
        b=mpNl55JQqesHMyM5dSIlzPWWvrY89/cck5ddizSFNIxMCGf+bxPQ9cA7aO11J+MHSq
         dlxq41k92HRWnLe13v99t7wsopPIu4B8Nff/CtJIbbnb1YRFa0knTS4ArStcz8cimgS7
         HkPUu0wD59QQJL0D0tJT/evhkopq6enjjtqOYCbXtmjShof+Qun9ImVxPvEuK0t/g9DT
         LtdDHLOEduotRfRm6N5+R4xi1Pcl2YCmOyESA4Rn1B88gkoXKgWwi/4TyUD7mP53vfpK
         fN/xWxM5q8jXPiw9HgEQaB8TkSxVHjTu0souzWoCPeXVo/PPiErasYQ/dfCGwwKS40Kp
         S1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726513915; x=1727118715;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJIs3HP84IMTP+ri2+xfE5tCgMh3aa3QvScDUaw4ots=;
        b=KnE1xZ/LNSt1EYZ41tGQVljw714mTLmUgcb54bFCKFUTAQ5PNJuxTS0MB7yApAZc0X
         wfaEp0U08z89Jy66rQsAKNqmq5kyWctvM9MS3Vz97zfYcytkVNsGxjdeg035cSjzmM5n
         OYFsS3K4H4aVL06GX3xsOlGsnb1v5q89gp8+XQ1cFTd5zS1l0wjrm2m6fjwxXi6m7jyA
         R/fu2OaGrWE/t1321orA1SuEHD46hff1w+0mF5N22Mn/yAbys1sLj7siS7FR7XpyNwle
         QnVdPevrnNaKrJsMI/4QzCz1rJd7v1AcVZ913T3mSpBvSKv19vRjmTxV4y3OWmHy2svu
         yCiA==
X-Forwarded-Encrypted: i=1; AJvYcCUlo3OIx/js7U5x3T6sUJ7xcL3H/hEIuNmw0CBdX6FuXff02VSs19HSza16guuN+SMVfE6VoeCN@vger.kernel.org, AJvYcCXEXdakbr/ZKzjsgTjPa7yxW+Yh48vNFOEXg7rx4NZhZUT9jcQ3bVGS5cHSM8IB4DrPIBsQ5PZv2EZHZuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzERjPYQvK2RF3GwYXJ0tkAsmJNPa6xwIbJpOfKST7v+srAb4rI
	7D36pbs92zkVyHA6iq4lvozLIZ4ImK3WA9rUQji1AbwpCGGxd2g=
X-Google-Smtp-Source: AGHT+IFdYcBW6EPk+DbILysc95+8WJFez75+bt2ej20zZKnpVDqb0UJKQNwn5Kjgw8+foBDfR8wf/g==
X-Received: by 2002:a05:600c:154d:b0:428:e866:3933 with SMTP id 5b1f17b1804b1-42cdb57c45fmr126658755e9.22.1726513914786;
        Mon, 16 Sep 2024 12:11:54 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acc3a.dip0.t-ipconnect.de. [91.42.204.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e78052e4sm7770871f8f.102.2024.09.16.12.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 12:11:54 -0700 (PDT)
Message-ID: <302bb85a-27cc-43a7-bca8-a05748a3b216@googlemail.com>
Date: Mon, 16 Sep 2024 21:11:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.10 000/121] 6.10.11-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240916114228.914815055@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240916114228.914815055@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 16.09.2024 um 13:42 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.10.11 release.
> There are 121 patches in this series, all will be posted as a response
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

