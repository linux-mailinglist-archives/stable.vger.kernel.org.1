Return-Path: <stable+bounces-136464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC46A99781
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 20:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA7C4A2DBE
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 18:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C776828CF75;
	Wed, 23 Apr 2025 18:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="f4foq/8A"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18AE28CF77;
	Wed, 23 Apr 2025 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745431737; cv=none; b=HIV6RWCJiNDUACuhjOGUn213zngQn8WhzX3S23YX4aANy5itPuOcmbCxl9b7ekZ3Dfe9E8eldpa5mi/fU268DcBCwdJdq695SBe8CNYO+N0pJxny7+TkynCw7GCml19/Bt/CY0ifICVjsYMhVwHhmHbhFI0HDQz8UCrLbPsqOpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745431737; c=relaxed/simple;
	bh=/a6rlE6WF6SC5/BC0SPA4vfety/OfUOdkiUb0LxSejs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nHL909+gyqQUeTmV9IOlkh+6yhVY3aWastvtnVkCqE/bfmFe26pwoCrvfyG/3R4fhv84HBqH4AUu0itwWPAN040AnMJiryATry/sqbNG7wXRCtrcOjPGS5T2hefESZXpIHkYNZLtuZbiriW++PQgK9IyOWqe/og6Sqfbcj9HD+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=f4foq/8A; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d0782d787so908945e9.0;
        Wed, 23 Apr 2025 11:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1745431734; x=1746036534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/5xauHxSZRZBjL1s6uQdVTJHCQeRvkb+4xCubFVd7n4=;
        b=f4foq/8A0PvfZhhEk/kaNMcMbETbyKqQWbkhKN9WJa8AKa30iQh1z42vqmnokPqX9T
         D3fpQh8b8DpfsfTZJL2oxcjbV2YVJgwGzAv8Ds4jo5kM1s1FhIpAeR9FiTVyeZL7sGfC
         fdA2ePEOnq3uHy2ZV4TGzYtyZsBRHdevFtLEYfnD0gIxEdSS8YMtBb/pMhck2O8o4Eik
         gUc//xmTKb5tx9omHt+8Ls3K3YBQBXdxgT6A6YOmpmo8GeWlZGmiDrNjtHx4E/cGP+g/
         vZ6xPo1qzMu27uRI1sXC6W7GA4hjXkcrAk+B9S881exnNXbKJvwbJ/W7XO5/meTfG0e5
         jaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745431734; x=1746036534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5xauHxSZRZBjL1s6uQdVTJHCQeRvkb+4xCubFVd7n4=;
        b=TKyiEAVgXq3fH8HrncRNHvm+tlMCiYasFbs6tvIxIi9fO6ASGA4BE4e3Wr5ZaQWhnt
         xwyzxxO6FBvxTO2uxVcBghrrlmhbJp2dU+BkWVuo1VkOGjwkLZjpzOtwV1S+YlKEni8v
         b301mEfJX6rkqH8YD1M+060sQqdihZ10Pblq7JIJtQVJOWx7ud97nQLwZ2CQ27dNfGE4
         R7q6+mu9RnpIl7UQ6LGiWjQBOmEn717uyOtN0gNXR6uEAn9lyFnocbzunuBmNMqUkwrI
         VIc2u9BkxxcwuKpddgBdCIymkhnJ44wsG4zwsJqiVUoqBq9MzxPNUKaGpltnuIw4ZGD0
         SGZg==
X-Forwarded-Encrypted: i=1; AJvYcCUmIAexi5nrXDoRLWSZXYKx/Dc2DVxiWK5aQevk3XARjGGLJRlqSoPOHVFooIssMO77ejgXFjla@vger.kernel.org, AJvYcCXUm4xvZNzQaG1FcESUh+enrVy9DS67neFbZolENc556v2GgUPQerZXJa1GDUsh90kyv04pemUQe3Z9s7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlEQKSGcZcQNZQDkVFNP6/d9+NDqt2PYbwiGIqlsyjaG+k4vTb
	qSHpF7XWsTb273hcE4HuNRtuS7EnOOtACkBdaWhvUMfIcRSmWRo=
X-Gm-Gg: ASbGncv7693zo+CQ6WIpJn/g8lqYjKmJU9+Bxs3AOHT2NsolvlSYcaUwgRozpNQng2S
	54pyaU1fGA0bweSnx6Ap7SUPMYk090fgVW7Wx0l4BtcaqjzA1wAx4DISOqV+Hu3uV2rSKDIMyVN
	8nGIlZkEreIshrtic4sJkwqRZoOIAGwXfBJm9uAGqBi6YkYtABnXro118fNUeCCv0heL9MaViBx
	Ou4E/O0LIh6W3L4oj+oxL78BoUOULtxOFk4qkk6tF5a1fLLT9oYaRJq09PFamOOJQQZcYhIFUY1
	3gSQHyCuKBM6EFqi/3maC+ZNFj0V4ABDQJsJhmGpYNowRCiVQtTpP9W+1wu29VMaHX8SaJZUCiR
	IiHunSvRdB+WteRwyJg==
X-Google-Smtp-Source: AGHT+IENifynQvLMfyjbaFmHerjupvosjrvvoV00BFoAAhIPUsf6sZjXUl/Wm/EfEtV8y/3bKy3dfg==
X-Received: by 2002:a05:6000:18a8:b0:391:1218:d5f7 with SMTP id ffacd0b85a97d-39efbad7d6amr16420654f8f.40.1745431733961;
        Wed, 23 Apr 2025 11:08:53 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac758.dip0.t-ipconnect.de. [91.42.199.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4a4cd0sm20036747f8f.90.2025.04.23.11.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 11:08:53 -0700 (PDT)
Message-ID: <14fbae74-0620-4e9c-aebc-5f4337e14089@googlemail.com>
Date: Wed, 23 Apr 2025 20:08:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/393] 6.6.88-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250423142643.246005366@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 23.04.2025 um 16:38 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.88 release.
> There are 393 patches in this series, all will be posted as a response
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

