Return-Path: <stable+bounces-185540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E80BD6AF0
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 01:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84CA4015E7
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 23:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F6E238C3B;
	Mon, 13 Oct 2025 23:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FCJ0ph6z"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72D921CC55
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 23:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760396570; cv=none; b=E3lHu1/4fzypE96NkLhZgiUazYjZPCsyitRrp/5qxKna3Z/tKuD9M/FaF+Pj1EEBuA2C0Cj23sUNMvDxGPo+rUMrfNufa+4tYc7lJFJbJK43FYkKJ8vNrw3F6qf2k+B7z7+YP/3HnyS6MJx/CBP1Q9yUH3+H9ClOqP8/0Cjgb/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760396570; c=relaxed/simple;
	bh=NN5Uhc/H7ql22G1CZ8MYhKGMzprQGvu13nPfy/soR6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9QvXke3d9sMrDQ41AuLHy+FwMceOIw02yidBHWpQnue8OmfmSvuXPYnXRKc16uz1ollUk6YDT2fw7HhQvTjjWcFpnxH9O47CwJaAAkXXom77Hrf6kG2qpueOwabn6HlTo0+wfRkXRqbqVK4XiQOMOEIat5KPfszrKO+GLL2zQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=FCJ0ph6z; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e42deffa8so44338475e9.0
        for <stable@vger.kernel.org>; Mon, 13 Oct 2025 16:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760396566; x=1761001366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I/couXEdkLhLPr9L+MDSsns4M5kv4pWx10gdCua1dck=;
        b=FCJ0ph6zFKw2tMgxMGEk59T9vozg9Buy6fz0vnm1QGS70l3brt6jGR+76LLT5/upGd
         m3OIF5d3GM6xjhsRJ5VVIjMerT0QX5YJNNV9mem25vc36Pz5m1kxqFmQtnYXqA5TMNxp
         xzTwBHWyblPHujZzbCw3+oR+WB/Wm3UcQKRDF6D+6FCZPZ4QPKDtQDLU2ccWudzuh4su
         I4oc3f3fxgIKi3tJD5fwwLkbpNRl5BpEGnEZXx5PCKiYEZ7TXHB3wQIJIDnj2MXEK4M5
         9xA7zle05Wxrp2GLKHs86rcFI9VoxAsTVo3gTmkjpN4I9cSKxPSaYhwcV0xrw7umoSfm
         gl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760396566; x=1761001366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/couXEdkLhLPr9L+MDSsns4M5kv4pWx10gdCua1dck=;
        b=hyBy7TKIrk/am+yu2/K0Rg2yR0+/I1k0jUDXgZ66O/nYryqG/0kUw+7dv7mpLzjkyc
         6PdshbkZkr5hTOFRV4F/dfHFzES39KE05PETP0wm8vCa/F9N7ZdW3LzQIUSRbi6MHCNp
         D23DOT/g1Rwz6S2Rsjq8hP7TW1gZshRbMLUbH1YjYJ6Yvj7rG5s9UtkB5M2S1g81GQFp
         T0wfbPzJDGxSZUYdDGYMhNXSzDCdc1fE7MICgX586k2yKuPKOrBvdsXjurIV8ZvtOrpo
         yawH8uDmQ380oQwVgFEZBp8y4cPsyJNOgorEleQbIX7eUT8S7b3Up5549rB5lim3ZZ86
         ULiw==
X-Forwarded-Encrypted: i=1; AJvYcCWsqpbpYINUtFcto7lNH6htWRnQahG3H92M9F9R2u26ryvFgpqABndBkh2LzqTqn7jx57elmXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMsbehgfIEFrVlb8gFQzPotFcBJS8cfmc2JfU75LMyyCGRelD1
	8T4J/hvBvCwundpWOSMA89vY3hv35md/EaZmlc80oDC59F+vKeFAXEonL4zB
X-Gm-Gg: ASbGncs5SxmjYUv1Dx25L6BbyNnEKJYs4lg5unw9ejAmOaN0tWxSDKEvwT5rVw60qsc
	BMUAZwzJEXqsb8/n1ReioK/RbROoGQrA0JXVmRK9gToT2XOi8x5ye67t83QCUWQ14CPAd3nuGVb
	Bx20eAapfoqIiq/OZo7xEMBRSgoxiM47OMR+W1rDAI8DIYm2tQ7giap3I9kb0nwnPdlC75qnCYC
	iPP170GN6qmH5zGGTxjKQonIJvvqdP1FZMSyrlcIOl5seCcATMN+80ocOt1WRDVFmEHgx99ROab
	3kVZt2VtVbEGVchMAF/nUmSADYAzc5Fu/KUCEmZniiFt2HYrNwopYkiZuJbmo3KQM4RF1KVH1wO
	BpwV58Otq/Gy9RdLV/2qenyC53/+AqzTiZ7m3Fu8DzDuZA3lMK94feMNcrCuenH1TaSMOEIB/30
	EuT4UVFBOqkm1cNXP3lmQ=
X-Google-Smtp-Source: AGHT+IEvSuL2pcLs02ff6tDICDiVy1cIZRV5hog1G8bH+8Au/ePi0Nv8ATYYDvBtFD/LFI+EZGN9Og==
X-Received: by 2002:a05:600c:3f08:b0:46e:4b42:1dbe with SMTP id 5b1f17b1804b1-46fa9b075f3mr172090445e9.32.1760396565972;
        Mon, 13 Oct 2025 16:02:45 -0700 (PDT)
Received: from [192.168.1.3] (p5b2aca8d.dip0.t-ipconnect.de. [91.42.202.141])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb49d0307sm205739165e9.18.2025.10.13.16.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 16:02:45 -0700 (PDT)
Message-ID: <13ca47ef-e5f9-4339-a94d-0eef595d3fb0@googlemail.com>
Date: Tue, 14 Oct 2025 01:02:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/196] 6.1.156-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251013144314.549284796@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251013144314.549284796@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.10.2025 um 16:42 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.156 release.
> There are 196 patches in this series, all will be posted as a response
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

