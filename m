Return-Path: <stable+bounces-210047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5987D3116F
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 13:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D69633058A12
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 12:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD661DE8B5;
	Fri, 16 Jan 2026 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iGIdwEir"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AF81D95A3
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768566542; cv=none; b=Q0PhXdMk3TSVve2Vdmam3PSnUaftAXyjI0qyJ08rg6TUkv/cTaRlZvOY5dBJBk3sRSPnX9nk6gHaMDocEulrGUrrMUVG/Ei3GJtSWOFg5HR46NF3amISJD5Y7gXZMxZ3hRg24vG6IprZt6IhNNEe3HpQ+pW07NJWoax84kqcwBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768566542; c=relaxed/simple;
	bh=8lihPPXddl4nXmkS+7M3Ov5OGAJiiGJ4AEFErABQcsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HM10/n6f72beMFPXOJGQmDONbHiLCrzYmSR3mW3Z8D1+v+BX9N/xWT/Fs4HKCKkUEAUZ6y5VnIdiY6NjYn+kdgGF6fFDy0oojSmUCEPInKO2I3PS9BSxQ9l87rqq0LcWXq2yMDL4WKQnBYHcaK63NaSWP4qvEO5bCOxssiYPE+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=iGIdwEir; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42fb5810d39so1562597f8f.2
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 04:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1768566540; x=1769171340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v2vIcNHIpTLIvJVy+m8iWxg+GbYuo6KoiowqnHlQO3o=;
        b=iGIdwEir74CZGlnOxIwcQDNHgtJleaPMeoGLTYGgw8YaTECTagELz3idWYZHQMOdoU
         JOfdo5moZdm4t/5Ii2tDD1HT6wv/2qBoU5HTlaKavrQb53394ajJR7JL1+zBvyiy1DJ2
         MpbEGtGHZBrxnpmUb8w1QMKo5JQYmYYkvDHSmflxq+z7WlnuZC9HqSY9v2TKCSAIufea
         vurzs6FWCWom0doxZdzQ3NcO+7zwjAv6q96l19+5S/3v17U/0stjaYALnZSWw5SxHr04
         kZhGpjLHXv5GDV2Xh+COYjT/kRuu5HLEmR8BzHMJ8TXPxMnrAaTk3NfB7lpBgYuJu6y6
         +HYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768566540; x=1769171340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v2vIcNHIpTLIvJVy+m8iWxg+GbYuo6KoiowqnHlQO3o=;
        b=qdGYeIQP3eRb10mgNyWqcqTpZOfHyTb4GlzvfAvsBUPNcaE3/roxt+mF2GyI4zi0/K
         06ZZ8Oi2WscWYRWHGo8y+yFl03LUKW2LMUAI1rjPtTO163AZU2ssNOHWd6D5ELPkofVP
         C5kupZ0u/S9cAA1kB/XkkRvlKpeit+ZTdPVTM2Ifsdz7+4uRYzS94QULBCLTvluv+QYZ
         aCqZ4gtdx4JY0LfHK7vAAnUkQiRlWaNPw7flmvnvZNpaxG7+CGuePwWiw/kxOYz58cKa
         ihq/CAwJYX+nBoRhVHfuf1wuELP8K5SSZ81wELYGeZYVnVfIHslo1FIvhD0//iCdd2tQ
         iK8w==
X-Forwarded-Encrypted: i=1; AJvYcCUsRFnWknQtS5CB/ZdJVRtckUvNjhpxpTt+2sLOAo9mS+xZOQRaPQQ7Cz5Rc5mjGtqiLvdTfx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3vOBdm51LHku3CBoZAPnGyQ2Zn0DakrWostq3uxIM4rRz8dYI
	qX4i6XsUATNDG0LH16g7msHd3rom8d2rbgsEJt+aaePY0jZ1Q1TMnFF2+huwHyM=
X-Gm-Gg: AY/fxX7Edam1IWhNcfppscgwgAm15ofZ5kr/FbFDHbs7Ow2MLoyYoCtQj2VgLCT4Iws
	lxdlYCco4++KJ0wyaZXbX0V1kyrlUlUbl2gaewK/ZXDT0YaBmYlkHTK3BIXAkGTF0jSrzcGv4XH
	o8yq3QSCCvBnbKlbe/p5wZxOFZRwDoaUQeKZV2vuSjM7jxcBaBWULjN3gkCrCvmVh8jhyfHOPFw
	HsKyGqsDBzT6MwYhsGffx195zonQGZTI7/ngVEpCMStFVDvzHNHC8aySWeBlQgvGt60bUjUR3H3
	vbgmcAYYhVs7hzx77xoZCWxryWtTYYWVRTnnEVoJ32L1hQikr3uEbrJH17Eh0tcbqlvVDmOuaFn
	3MZOhs2AEXgJtxlsDa+rRbLNLIaP51WcD9K5L6rxKrQ6QW4QXwNFjzTfID87WQvWPF15BZLjpVC
	Dbs8leakbtAGh/pgf63Xghp61ivC5gG5GGYVYfvH9qvkvkGQ9XZNDTGYFJyXumSF0+
X-Received: by 2002:a05:6000:220d:b0:431:67d:5390 with SMTP id ffacd0b85a97d-4356a05d93fmr3352032f8f.54.1768566539478;
        Fri, 16 Jan 2026 04:28:59 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac8bd.dip0.t-ipconnect.de. [91.42.200.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921f6esm5091253f8f.4.2026.01.16.04.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 04:28:59 -0800 (PST)
Message-ID: <1d9842ea-2705-4232-9082-244d4dc4e69e@googlemail.com>
Date: Fri, 16 Jan 2026 13:28:58 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/181] 6.18.6-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260115164202.305475649@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260115164202.305475649@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 15.01.2026 um 17:45 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.6 release.
> There are 181 patches in this series, all will be posted as a response
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

