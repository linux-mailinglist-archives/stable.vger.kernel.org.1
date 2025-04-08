Return-Path: <stable+bounces-131863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 455FBA818EE
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 00:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77CD3A1A6E
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 22:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84E02550C8;
	Tue,  8 Apr 2025 22:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mWE7Stnl"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBEA21CC47;
	Tue,  8 Apr 2025 22:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744152164; cv=none; b=sumPnnrBRTnZSxBeUeB0AViVB2xIQ+4Z0fLNlTl0Oq4WvoYS3fcwEldTuiL40eHPPLS2EcjOSAxXdVidc2wwqtYX8t6grgBZG1Ac7d8rNGbI//4byZItZ5aSJunCSmwJRN93yviTBuWFARKLODBiJSa208qLjUo/7dzwe/sw6fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744152164; c=relaxed/simple;
	bh=VvOE2r3DtdBAe8IWcDaWLBTTphQj9Rjj5bt89NIvxfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GlKLiO3F0exca3Yed7SDxftqAxXSPAkTZ9+iBhJAtzQQSII5A/8Bb+KwhW3NfpsjooB8aEeh4vn/AUeZ6D/YmnAM3ZQ8OAnwIf+HNkzDR2tFXo6nVrysRb8ka9zqnhVzfqwg4yfxHMx2s9lqPLBvHihKoathxm50+WMd0VXdWPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=mWE7Stnl; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so41326795e9.1;
        Tue, 08 Apr 2025 15:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1744152161; x=1744756961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cVrsX/RC2oFN8Uzy2xhFPNyhEXxy3W34iQYpN21V0sw=;
        b=mWE7Stnl7wen3uh9M3c47Q1c2ArDk/SO0NPl+WT7L20CkTBSCODDVfqumHNZ5ky4lP
         PiQvO73DpCupVF2GipopP2+mQaaapy+bNE8bowCmNv8n1hMqdLVDzJaaNmi28Wq9TFr4
         k4A3P4YJXOrwXr4HshpIWVCn/oPfkOH7aDdCYVDElRfOkAS1CKY0GVQp6cSMcTGGiRGX
         6k7OpT0allPd0e3h8xvy+c7HNCcKM55bRiwBoetaQtPugMvHZnRqKdB7/eZ0cSqhyVKu
         S8hy0FNY7PrcLRkK98VFd3UHtst4zY8YNA/PRa4MDaCNTSIuw5Bv8Jse4QhpIupN+h4p
         VQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744152161; x=1744756961;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cVrsX/RC2oFN8Uzy2xhFPNyhEXxy3W34iQYpN21V0sw=;
        b=KEUtvSFzObK5wOVnXcqJgkAT7olyHbA5GCuJ4alKWPb4A6iL2OltpO2lxSLUZQ+Apd
         B6oOqelSIJ51C/gl5PyTpVd1DHlAc8OzMbTFSXMUbc2r4nDNuBOWwR7xhk8us2JJZmSD
         BwHGrb6oyIlN7M0NEJwU0mSJ+p2KU7DNMgatuRxm2mKrlfdn7abpwhzXVl02MZj3MJGB
         wmyEaoZI0ma1pMLj6+sgPZMoltNPgK/YjSukqOOkEc3bu+ldt6RHn1Kn/EmOjWgllNKz
         meRgu3UO5SYS0Hn/kzc3OP7bvFpO9f3j2mI8eyWknjK94lPKwlT9U3kfxjMVnRoqvArS
         hKEw==
X-Forwarded-Encrypted: i=1; AJvYcCUsWsNQJE049j1Mrm3VTSZEG2aMPd1b167QBLk27sdd/u5GV5QBjyeBDlhcLhkE09imfG4fC9qK@vger.kernel.org, AJvYcCXrPmfQBKbDeiu0BTnvs3fbBOFWvfuqyW6BmpgAYwDarcqL19VPZq0bnBZH/bHMre5pIYSof5FdTk80OYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNoRgyUTE8WZIAMEMTgau6QvfDL5Yvfz1/LiJZJ/CDDPM+BWTh
	gHR51zf+s//Xc6CSr1aDF5dgz6vAacWHnHPS5utM/769cB1I0io=
X-Gm-Gg: ASbGncswdoUKw3QBaR6OCMou4EhYmBrpSM21YwVdn1BeStVCNiusjv7L6pUdG/c2LCB
	8PETneR8UbqMJgOWh1N1bM12/dZsVf3QS7L85ZFtz4L3aPuxWeJMBzuouRl7ZC/aGhTeGX3ly0O
	oPeiKPtMmF/uqbqW83qYy6M+K2PoTo3XD9OnaAKAhrtvZQGM6Ye2l1yRSG0p+xo2gWan/YssszZ
	AmBGqGtr1O5VGGlsiCRWYMTe+dU6sy1lMJ+GGV4iapw46QM/QotVftpk2J8toviH46NZlSVdvSn
	50+4cQVrOr8WRAZR88sIPFQB33ChcMDs0j+rPSLsuJ/IIeQ+TRB/15iTfDM8/3w4BxO1+/L08l6
	Tyt+0OY+nNM6x9X8iYKEC3PByR/4aqo5r
X-Google-Smtp-Source: AGHT+IEHm/LVYmhjkn2NZ+yNt7YdDBEtZNlPDop53WT6mMXLBhiVifJtxaaSv6mZb6Y23He6cKCvRQ==
X-Received: by 2002:a05:600c:1d94:b0:43c:f629:66f3 with SMTP id 5b1f17b1804b1-43f1ed0b0eamr6927825e9.18.1744152161210;
        Tue, 08 Apr 2025 15:42:41 -0700 (PDT)
Received: from [192.168.1.3] (p5b057de8.dip0.t-ipconnect.de. [91.5.125.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34be2f4sm171797715e9.19.2025.04.08.15.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 15:42:40 -0700 (PDT)
Message-ID: <87dbc3c0-dc7f-4d0f-88a4-bacef81dc56a@googlemail.com>
Date: Wed, 9 Apr 2025 00:42:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.14 000/728] 6.14.2-rc3 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250408195232.204375459@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250408195232.204375459@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 08.04.2025 um 21:55 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.14.2 release.
> There are 728 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Just like rc2, rc3 builds, boots and works fine on my 2-socket Ivy Bridge Xeon E5-2697 v2 
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

