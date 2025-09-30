Return-Path: <stable+bounces-182877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17137BAE7B8
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 21:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A253A4A5A85
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 19:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9179028640D;
	Tue, 30 Sep 2025 19:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="W5FMTXYt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF5D2581
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 19:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759262197; cv=none; b=Ft6F8pW7wX17RFsO3K4CGfoCE9EAJ9zVx8ncx/sj5KEv6ie4Daj3VhLSNcjsto3zgdOCT3dSO3cGAMylOQMKgBGvvPATpbDLZBBtmLeP4an0jN5M2PHLA+btzX3Fg3bnjuwTLVuHozwclBrRC8bGclHIxO4GBQDVOHATvhhEUtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759262197; c=relaxed/simple;
	bh=pZsEy4BlzjnbApYdtY98hgFcJKx+/xKyksynw+ju+JU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQDtd1yKTui22RsuaFTFwkEtfEsJG5eb1rlYceJQ4Jt3ANRSdl7O4/1peYa97k4Oi2C81YOR0Wv9rGcgnhDlEgEQyM009/kd6GxP/CDkKnuyuEdcMD3Md0Kn6vdKd8p/4EF/78PdqOdFolvNpG1ilYEv6ht1DHESS4VqCaJdwfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=W5FMTXYt; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e326e4e99so1278755e9.1
        for <stable@vger.kernel.org>; Tue, 30 Sep 2025 12:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1759262194; x=1759866994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wr3gBhu+Jtq0RAUdwZRnS8EkF8mlUADBYcr5EwXyQJs=;
        b=W5FMTXYtgirQcApbHrt4DhcX7e/arIgqAIb962vwiipD3TVF4D3O9xvZCRXud9GFDT
         FzEmInuoVyl181NHb1HhJK7zjR+qHTbfTrFdfa6oOmnv1mJOtX6hBULWZXSQ7GMvUZhB
         0Qm0vC7Cz9JaikP60XLWzg6/45SUIVmmzT6BqySmwGEUVk4nhmy6DscSEfumRn72EpLb
         3ufioGVgzZlY/V3vzPaDse1CeWgJyXs9cvaSh6dJxuuY0foTA/VSOM4MmLayWOZkH+1B
         f/Zsu+wtMGTG4YlsQBXPQGRfwYKoekX3KgHzFpF4EyU0nnVbMSYi33yiQ9eUanNLkemj
         p4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759262194; x=1759866994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wr3gBhu+Jtq0RAUdwZRnS8EkF8mlUADBYcr5EwXyQJs=;
        b=tmWyPff8wv4gkzaBpnffgQqi450XGzhFfNY9AxnigygoOur+tryPQHBx/ymj8czANz
         ooQ4EZ/WHfpEtmVqpgyy4CwDLEUYIyaS25xjaxJAhUNaN13e/qb2lS3PW3/A0J84iIwW
         qn5pq2paH6gI+kIMvC3W9oAauEvTXCjG9OWXWn5k5pahc/0T28t6s/SGPEBDs2Nqbxxr
         o1J2SFwO5leOjHfAV/6T63e/AoJQ2vwiTyGh3S1qXjFs7o58cTlnwctkYQn+0yJaSW0s
         nFxos+jELE4CbR/yz5OYukR7WFw+cZ4BZy7AL1YSr9YYHc6mPGnfNctxeclzqat7xsKO
         RQ+w==
X-Forwarded-Encrypted: i=1; AJvYcCU4jpVurmDQtqgnYt9VEG6o8wiNf4jl3hohajym09BmpkfiSq4SBNd37hTJBYbXJDDl8ZKmBCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVE+kCJabPYT/WOGQhVAfFxo/5YNSfw36KtQjAVaCZftyhyXW/
	EKMebfdDdqvSzxap6zbjGYOWsb8AditvntitBHh6V7Lvg6bb5VLrlKk=
X-Gm-Gg: ASbGnctU6ea1QayBaiYtVJk6SnCwJrvIh7KDBN/nFJKCMK9B+6CE9+UUL2K8gDxbGhP
	qEATUSwr3z3aRZHeIB5cAGYdggfu0LKjLmgRAt5+Niwxw6p1QKaHwm3M9U1e7s5gPy0Uvml8TnN
	uVSHsdQqzFxvNH/YVPkUawbx2VqR2qOc1sgoQeewnbooKWJ7Ax7Msm4A0E78Ti1MDiqHdRg76zM
	fttS2i539Qq1gTRN965oTAODODRginiZKKXoIClWy/QCJ5Xm0Lnr8eeLTlaTVu1WenvxAKUZPh6
	A5wnNyeExK8RAY+/dxfcQiFo4Dt5sV2RvYGImSQBL5kSPQlfIz2jrzZBkiOlrsNVa7Z+xX7kqUl
	AV/Bm0oNy0FNNyHg+PK6Nty9zq+Lnc+wmejkRL5ol3PlB0i4zlmH0XNt2cTho8KUAUbbDy/OWh3
	ZxIstCj1WeFPINaARmCuXslNaId2Uu5K6X4w==
X-Google-Smtp-Source: AGHT+IF0sFwvuRgPGE+exYeJzMFswBI4i3P7jw3i8w/j6W2Np5WRLVu1oilbh2amI4bAMDKJaEAy4g==
X-Received: by 2002:a05:6000:4387:b0:3e9:b208:f2f1 with SMTP id ffacd0b85a97d-425577b39fcmr862831f8f.29.1759262193723;
        Tue, 30 Sep 2025 12:56:33 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4965.dip0.t-ipconnect.de. [91.43.73.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb985e080sm23858507f8f.24.2025.09.30.12.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 12:56:33 -0700 (PDT)
Message-ID: <8947d35f-9e9d-42a3-9ed2-69c6f6a8bd97@googlemail.com>
Date: Tue, 30 Sep 2025 21:56:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/91] 6.6.109-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250930143821.118938523@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250930143821.118938523@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.09.2025 um 16:46 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.109 release.
> There are 91 patches in this series, all will be posted as a response
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

