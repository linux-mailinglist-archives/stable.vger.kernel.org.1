Return-Path: <stable+bounces-207932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44486D0CDFC
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 04:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 638F93006A75
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 03:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6B724729A;
	Sat, 10 Jan 2026 03:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CUyogiOe"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F4B211290
	for <stable@vger.kernel.org>; Sat, 10 Jan 2026 03:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768016403; cv=none; b=pb57/6TjiLttGXYKYfIKFQival+hzasXqMw26P0iI2i2wmSTZs4C587k22B8v4WRHrFI1Gn+JjoCio7BPUNiCIE3BZAILhkfWnzNpqteIuz+GuwvQuiF/TC4wMgVmfh1GoiCsGXNaOpBczOOor+WbcsFYfrva/kM2k8X9ON6Tz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768016403; c=relaxed/simple;
	bh=ZNxmpy3s/NjQP2qO3L6gN/abYNU9nDdA/hZbIOXec2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+NPc1jpEp0WUJHyEmhLmqB76k3ZmCYDLUBDkpql0+/li44rFD8aXNFxfA4NeJzZv0M+lkZgj6FjJ+voEvTdQBGYCJrQSg4jNurwzY0FrUp9MISXeLkiHIV6NFjGeCyCd1iOx/ZZeiJaE1KgRPvzISmgvil9jYp0rz47iJu4vOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=CUyogiOe; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477563e28a3so25083355e9.1
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 19:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1768016400; x=1768621200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dz4wL0bES5zyIQrDJWjuC/U3KHdx+E5RhZrK+5E53sI=;
        b=CUyogiOeCzFR0MFFDV4M4btciQX7mG9bfEp52jITfbYVKC3PriRRdbUeVkTGKdKWvk
         I9d0iLfIk2OMaeTEsekuIk+2SMXW5zOw6vZURnpx2lC2Yv38eKln3HdQNCYmgfnuYo+a
         pD3V8IpNDLYGp/DS3pvnvDieJBBJuzijopg9tZyJ2IMNNiFH4zDk8dxtEjUPt4S/Uq+3
         nBFN8VWeXWLqA+eMPEbuUIbkmSwgf1wW3Jjy6PtBgP2Xsghmr4ukmBT1wRom6eJer72i
         iXzn35Qn/DDsh9H20J+dqiqe+ULxh1fVeH1eq+eN07PnhAWbudqwsoPq84IkS2Ui7A8C
         /s4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768016400; x=1768621200;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dz4wL0bES5zyIQrDJWjuC/U3KHdx+E5RhZrK+5E53sI=;
        b=kbxnzq2SAsGfZ4fEaoqid2q8H7w1EgfwATnP3q5CRywqRcTYOX7ccSKGFpza00CIGV
         FFMREzKtjrAtakA2ogZab5O7C2vOV2X+HBMjRXz3Rr+vcyl0yV8BoSRWklvcbaL7abUh
         8aEbDyRTfe923JbccKjPxXAd9gdnhRI2Ap+lJ9igh/hrq8dn0iMZSCjVehbPeLNdy1GY
         SoRCBkhwD2j3prrq1ABSQFEbaHF2Y2P/kzaDiLtOQEQE1EGrSMDfMBzMq07ip70Ntm/k
         ABG5hLsfdwwZLlNchiiXZQbXureQDaYqXP630w5J/Q+j3oN8L9LSA5WnQn6Gmj9uqhdo
         g8Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXiagFgepnsmcPa8iEXE+sup4Hr0rNzV0sug6ttipS1MLRBlpAyn9YZxIs0czSlrXDcBI/kUJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4M8NTxrYdetiUWHXHOEwIpVmC/zweonYIEFjLXdgFFFInFRZw
	lQxqfvvXyFdoVpMziPJ7cZ+ucFWUI3qJsuhTMlAChwC6doqSn7r3L60=
X-Gm-Gg: AY/fxX6Sp6jz4xkGixd0d1j22K7j2VaATfPdJ1tROZfn387GcNNJk2hghgxE4Rucrii
	4Al/THmfWY7eEVlg/j9HcexdEWcOJHywfZeRkNuBxZsZv0CMDze/yvye2uuF80zjx2bxP86IVlL
	ds7V2rzqG1w24GSX+/enAJ+6y3VGTVpuNbXIiKQV7rDkzEQHI+XIb/BJC9Mpj9P5oHxewZGV6j3
	WYOV0qSnAT/eg/42hunIY3jRNbBp4NGojdqYdhxn3NmVCwAwZ72R3Sf7EiFVHms5nbQjx25mdhr
	RS/+qvyLqfsPPoAeVn8qy8/Gz/l0WZAJpblEP0/8YS+2x+Q2CDQtAPwQFSfIzAcozIzuUqJQLme
	RlzxyOs/tiGJj0bON+Aey5L2UavDsbSnKQwwfc3i7dBYA6jLnk8YNGbcHHovjqMRd7x9faJkFoy
	H4EdAwzJQR3c2oh0tzqOR0nnFPtu6yNzSMb0n1FVaOHb2I6Mdg9IoZPdgUT4yw2Sk=
X-Google-Smtp-Source: AGHT+IG+rDevQNAgrZqcIZYHg5z2I6P1jkhCEo3BFirDd5CnreOq6tif91Z5O3HvJZf6UGuI+SHczA==
X-Received: by 2002:a05:600c:348c:b0:47b:deb9:163d with SMTP id 5b1f17b1804b1-47d8484a329mr127583585e9.7.1768016399759;
        Fri, 09 Jan 2026 19:39:59 -0800 (PST)
Received: from [192.168.1.3] (p5b057af3.dip0.t-ipconnect.de. [91.5.122.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f65d9f0sm246426565e9.12.2026.01.09.19.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 19:39:59 -0800 (PST)
Message-ID: <2713dcdf-d459-4e94-8ae6-a5cd1af45246@googlemail.com>
Date: Sat, 10 Jan 2026 04:39:59 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 00/16] 6.12.65-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260109111951.415522519@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260109111951.415522519@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 09.01.2026 um 12:43 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.65 release.
> There are 16 patches in this series, all will be posted as a response
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

