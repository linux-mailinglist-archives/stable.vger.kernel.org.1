Return-Path: <stable+bounces-134508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8692A92E70
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 01:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8103A7A46
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 23:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91F6221F37;
	Thu, 17 Apr 2025 23:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TEkKHwSy"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45EA2040B2;
	Thu, 17 Apr 2025 23:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744933667; cv=none; b=fegRz448wT9iaV6JMmKCxUbDN6GcCTyDLVeSY28Vcmr9SwiWMdN+2hqD1PHNnGt2Zhiy7YYxfB8UDTMtNMuUnzFOLrKujIr1uKbA3DKra07xQVuoqwkfJ/ha34gva28JAyoJSrPvF4g/V17Bw/yFAmSA6oPrlfOn8iASd0Jky0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744933667; c=relaxed/simple;
	bh=Cp5E0MXQukVtmrDokjbo/0l23aWUE+cUw7t5IJRqou4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ll0e4HFBRQqVYjBx5vwJ9vhzL7yMeukfK+l+gUu9UQ4LV05mMy+fd1RrfCJhRuKjyjYMPCKbPFINHLMf/9sLsn+l5WY/031TKZ39Vcsl+vI2qI7th/5h6cgLTHoSp7MImNeEL9IA83aHKLc9Hfj7W+EvudSSLjxxHDZNq4k11jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=TEkKHwSy; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso15764855e9.3;
        Thu, 17 Apr 2025 16:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1744933664; x=1745538464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CmMvb+5lSp3wyOSxOTOWkXd7P/kI2rlXh2knPFYaNmQ=;
        b=TEkKHwSyPX/ZjFwv4Nw2GACvo8SOOd6hxRGYTHgKuVLlS8Xgq8TBNkzqwyGnrR1xz9
         +w6ysYPHeD0Xhzf5BFDZr2v5bzBd5kk+Je+fpWpVVLwb4e22t1MOKN8df+agolYZfIQd
         2g2gzLtYtA5tSINnJTKSt0FF7j056VkEdWqLPKwoprYJzN7YUTZSp2q+9LuwaSuZfliL
         6OZVPp2eCD6Att2f5vYDJ36o5W7y3eRBtWOGBcs02BFrjPS0lZxYxli+tCFA/sw0ZtU4
         LbUfVbyL718OheGfLeOCFqorI+i5F5Uq4lpd8K0tt6oDAtSp1Yr1jOpFkBKnoU9Ag9BP
         zwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744933664; x=1745538464;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CmMvb+5lSp3wyOSxOTOWkXd7P/kI2rlXh2knPFYaNmQ=;
        b=Jp76344PPEsDIt1Oi3DmuJlX5Ea9R+F7WskXNdPSQxVQ9o//H7W7amJ0KIlrZRMYwB
         8q4OOK5cfebtTegazy1fbISnovmC848HS/ifaGcNWrcMZ3gZHnsy36TOUXasenXM4CdO
         4zgSEdRjBzFsNPe4qk41I6aTRtA9rnw3gsGIbMusmrxnQ1v9nuJhGLsbPst6y8GD4yjk
         TyVVLhQwlhGxSbSSjm98l4pLP7KceTE+sluNxqpwBiaDpVVrSphrNvvOCjdAUUgE/I10
         YKbQ3hno36Qebv23tBg2mf1M3WVcbBOXdwbD2/2G2BhCL/dhdpPKfFHnYNBsrRVCsy9W
         Wd5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNxxV8J3SzE1dZU1Ag+rIzEFgSU40CyYAOVm9st9LqKGf/liozqAGAVtCl9rT0EtJ2koecG5RgyWQwnLQ=@vger.kernel.org, AJvYcCXd/ESf5WNuT8C/nJ+Os/Q4EDXontSSC9xZX6H1giYmbRQBH8Xw6igVTV+X7YhfdmCU/lB4ls6c@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6yF6xItjSdNr+QhTCo7zwxiDXugm6FPC3dFOR+TtCBch9TQUU
	c7PRXD0cdp4GLDEuYnxET41USMi8mXCh+2bRHGSI+QLi9ob7T+c=
X-Gm-Gg: ASbGncugXhWEQ2/gyD4v9Q+SA6y7GU8u8lrJ7yMJ4q0iAJk4R7k7W83W814v4GjvJRM
	TXWHQuxhQP0ygq9Q761WngjIbql0cei7Q+0FY0yarwChD/wy5RPiRImtqrCtaPiBe1I4je4mB8Z
	dtq1cr/SZ1CUb36mmtPNTCaXXTsBzZftxbHf8EppiNm02vBNDB/e6cPhyaMcauw2YGBcGtLfAN9
	4Rmx0SO13mvqSanAsb8SHYOokGWI5U39bhxYaCcsPs3XOqAxFnIe95RRvJ3pHAE+ObtkCeE2rZg
	saMx1tU1Qr5gG9aQmWrkNvhjXglxgDT2FZfA1w0Em/Bd6CW2WfHUfdbG7WsatUPhgWnN3xuPPiy
	+NORFyN4Y6poC3RsgIQ==
X-Google-Smtp-Source: AGHT+IGP3vlAWHSKVHCrAvIBNzVFbxGafZ2481P6x8p49cRaK9tDH8ty1Z35+MD2SKQAQPh4i92wEQ==
X-Received: by 2002:a05:600c:3d86:b0:43c:f6b0:e807 with SMTP id 5b1f17b1804b1-4406ac176dbmr5908785e9.31.1744933663954;
        Thu, 17 Apr 2025 16:47:43 -0700 (PDT)
Received: from [192.168.1.3] (p5b057cb5.dip0.t-ipconnect.de. [91.5.124.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa43be53sm1045282f8f.41.2025.04.17.16.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 16:47:42 -0700 (PDT)
Message-ID: <b1ca484d-3c10-4761-b367-417b8c2ffe32@googlemail.com>
Date: Fri, 18 Apr 2025 01:47:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.13 000/414] 6.13.12-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250417175111.386381660@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.04.2025 um 19:45 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.13.12 release.
> There are 414 patches in this series, all will be posted as a response
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

