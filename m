Return-Path: <stable+bounces-89120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 832149B3AC6
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 20:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E081F2270F
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 19:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979161DF251;
	Mon, 28 Oct 2024 19:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Yzwm36ak"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B4A19006B;
	Mon, 28 Oct 2024 19:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730145044; cv=none; b=MI03DG486pPkE9fzKfwvKOpiNMLlawM3khS7VzlFOpduB8nNOkq27s+e4jM2U0WGYkzgcsv2PUS+lsMRRbcIET4LmHvySj/FhnVH14K5q/AGj0BztfaEzS6enVQaNoc2lDQWkKbHbRB1DQ629ikE/EDEX2n+waVjgLIt4x2xqKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730145044; c=relaxed/simple;
	bh=R1DQ/KMwlmEJHrayoEuqobr4p9d+H1MRATU9t2npvC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ke/3BdKcHWMjcfae5DuBxvkwCBLyGbuiz3bCacEbzdFXwPqKJhsjs25QSwX9wmLOAtTOTg+FHqfAs3fNMATrFKfw8q0ei5ABR9QS9nyUshdUpYBFCavaw53fActXWiAHliF/KPXvfUYz70p0LS/o9Dufi1uKDGVW96zuzsOuos4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Yzwm36ak; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d4ba20075so3246010f8f.0;
        Mon, 28 Oct 2024 12:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1730145040; x=1730749840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cfFITBV1myRi8hbtETvsv/FqFz4x6fCNMl87D1UqCjI=;
        b=Yzwm36akZQnT56mkJjXxUN8fYJic9Tn0wM8ZHlJwss+N73+mnecwR1pzD5YNIAFIRb
         T08ojZw4IFtFjX1iOUM+S+ehySoYAJxG0TQd0kO5NzZfeI3isLaZdVnpc3t592Dpc/nZ
         jqxNPXE8BiSZrrPmvXVie5Ju24iF6yFo4e6O6eGm71l5NbJbNTIbRLofsrq62T07dxQV
         ef1OY3AlofkLETQQMvK1dms4Gzksg0keeV+CPiNNJZEB5dUCw27i8hFekWcOFqq3Yq4e
         X/gPtXVQvtr6H4nu0VivAEs7MHfWDf3NVouBIuNVGUOQCIprng5E2CNS0cvxUThqddxI
         WmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730145040; x=1730749840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cfFITBV1myRi8hbtETvsv/FqFz4x6fCNMl87D1UqCjI=;
        b=FFh3xdzfFWC+AHipLCilDFITeKFfc+idR4zZM8F06Ew7iA1O0M54GhyReRs8CJPxuN
         2ULZGIhHwUmLL/k+FX0vPtknt0qrp4K0HB4mjVI/cRteZfbJfYI3L+YOqpZ7F2ha1vUK
         loLP7DUuk4IeJ0ebtnp2hyh4Kee/moEyBlb0gdZNieyE7aiddaq0nwRYbKvxTL92noFn
         l1eu2dJePlQ8yyxCQM15566Bauf6tFgh2z93OJVV3Vi5bqJKlPUgXoRCdFNae8n0Lard
         UyGwWmuMRGFN7dngwFGa2Ojzs3epDqzCQKwmqQ0C7bbh7nkdN6jfoyeMOQ7Y9FqJN4ra
         NsRA==
X-Forwarded-Encrypted: i=1; AJvYcCWjQ/IDwb4gu+gNXFh8olszk5W8Qp7/h3ru9iJqP7TBcxeLst5xdGIEk9bk+tY+Y5wB5THW8fuI@vger.kernel.org, AJvYcCXT1IcFDeAmctKw9CneOF+zwwSZlqIERbdF2d1yRZpZdEBQIMvCHnFe0f33sD3sPPkMSf9Z3Dxi69zameM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqf7sTJaRkAZRElYnPoDrRX+ZcTCT4TwJtC5nUgr2nchs2wjpG
	2u++U5taw3NtM70yzBdR+jrRviqy+D/G7bs21QcFFldTohAPnyo=
X-Google-Smtp-Source: AGHT+IFQlnYqBOiIxhzO/n77Z3bG0kNkLNCXhKIBxoD2+dgyOR0Z6gaZV0BvDFitzSFNe/kS94R+2g==
X-Received: by 2002:a5d:4b0b:0:b0:37d:524e:9431 with SMTP id ffacd0b85a97d-38061224a2cmr7063225f8f.57.1730145040463;
        Mon, 28 Oct 2024 12:50:40 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ace6d.dip0.t-ipconnect.de. [91.42.206.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b9d70fsm10390697f8f.108.2024.10.28.12.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 12:50:39 -0700 (PDT)
Message-ID: <1e751a01-01e1-448d-bc72-71a6fad24278@googlemail.com>
Date: Mon, 28 Oct 2024 20:50:37 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.11 000/261] 6.11.6-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241028062312.001273460@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241028062312.001273460@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 28.10.2024 um 07:22 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.11.6 release.
> There are 261 patches in this series, all will be posted as a response
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

