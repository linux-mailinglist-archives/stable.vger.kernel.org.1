Return-Path: <stable+bounces-185570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4407DBD72CB
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 05:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EEFD4EFAD6
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 03:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CBE256C83;
	Tue, 14 Oct 2025 03:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Qj5gE/XY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E967494
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 03:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411936; cv=none; b=SlQcInsGbdw1a/U99+hRoDN66zh3Ht6DR+FB+927XDBu9EdUmRV/Hfr4Ikt9XZly49/MulXUm7IQd5VjOnk5JTY2GOfPo95pzruQrbKKaHqlV+NTKxiSDD9Zsm5nED2MjTBJT9dUqM2/rVKWbCGEXsYoH3JsDXlS6U045ieh92Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411936; c=relaxed/simple;
	bh=6lR/TQju9ey0aOHm4Um+2HHuV8O2PyLs66AmGS3EoSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t980RnDbiiSa8aPiMzPzE0yVtTE3mK/rQhhwq2F/1HqWA3WG9qqoqkGPAQbNlMuzni3qJleaQqTFk3mkPZxuPFNnnz1Qwwl9srj8rhWUjBsuBrs+aPOGud6haUYzNSLs1EPO0ga2sM1KRSVM6ViagjPcBQYpT5SkjXSXDncMSGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Qj5gE/XY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e42deffa8so45435045e9.0
        for <stable@vger.kernel.org>; Mon, 13 Oct 2025 20:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760411933; x=1761016733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZkQk8i8I+bz9BlzrbCcwSCImHhYisNiBNVjldByEI8=;
        b=Qj5gE/XYOWWRJ3ZU+ltFDTOPZFRXdFBwj4Nas8mmt2/5ZgLAt8onTEkutcDvmXNDzt
         6WcVdVfc7zDgHNu9zgwcDkNEiEgGmP2ugnZOiNzggmEPCqHnLo6uX9xQ5oS9WqmB0wUT
         ngksUCIuOBEAW3LNTzReQsAGWNhrwC74eGkUHeuliLbTSizG6E5ezAF3PMTMaqTwOwDM
         SjTPIVZXX5PplBo68uUfIuTBLP4AmBMuzpFyTCw4M+BNHrhPqc9HjZm+88L+p13pRAFH
         83nmTv4JFKB1/iA+evyWcJ2dFz8odM7L+FEA6NKY8t2X/eyUGKdzgIZYPpA9UXUMHyTo
         CcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760411933; x=1761016733;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZkQk8i8I+bz9BlzrbCcwSCImHhYisNiBNVjldByEI8=;
        b=qEm5uRf6QC8do0uPi2YD91H3WZd1xxur5M6K/WTkIt49AjtUvFKK0i/+/PgcoYe0sH
         2TaLBitEMTOLVldAweWCI/IR8yY925QI2ZA3ErAfhdWyYTvdS3+YscEdXRuUgQlWm0Zv
         B+ADMGZyq/BFCp3+2MN9cI++VrB8FBx/nYFxCwe0qTA/+TeM9NinBzQXIuzTgdfyMcXU
         ftCkG79Lu5WE3Z4KHcNQgwPrup0fVFakgqlVp7dNWLwwZuwOv15OLgxmXnHo9yFcOeTP
         vpbWugVBBmQ43PsGNmLaG0f4bLzgNsJx5UMDU6c861VAny7pPnxU345iaKYzP1JAAK86
         sAVA==
X-Forwarded-Encrypted: i=1; AJvYcCWfvib9wjNsFRjdhpe/pTsE1XVHNsBirr6gTA1hL7KAD8ubvHzZHZlLhDn5IgFPIiJScG+BExU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlqrbusL365Nv9mfRqEbivOsTsR8aX1zG68zxX9Gw6KvVQcLF2
	hOfBUCG+HtkhY7j2buY8BocgZsgL+5UUqFs5CnUKGcB1t4kp3p9HZeQ=
X-Gm-Gg: ASbGncsldFRzI2CqI8/R5iTkZOBIlpC8b2JcRcQYA2RMT+seAzZZQg2DlDS2cg/Xm3f
	71OGVEbKfPvTZCH/YO9zfP/hvjwKdV5cLp44JJUP4txMF9r5fTSGyLIJGUbi+63NLZq5rHv1wiz
	6YKIP9BAVl/1awL7UFfk7CVoyXf1CtDai2ahnPavBHekb2KsmL66P3O4O44pk3nyRnxYjcgrdRB
	hrU2IDqMwf2lL+3oDCPmIHFRj6Hg8yTuKpkohb7AcoG+IeqFoiSBzPF1A/dhvzfLhTl9y+mL0Le
	SugkQiFZZplg4ohBu+P2z0Lu05LpMzKm45DgwsdqfIUZw/ibGbTTp2RJbN7UZHDz3fAYRcIhsyE
	Z3t7TsfGmCbgFklkUJvqjdYAyPWL734OOKJ1DLw7Yw/0lHDiTV84JingIxH1nN8AdY3OKKd/h+r
	ZmYHCIByC/ow6SCOm1pHmFG4H/uIA=
X-Google-Smtp-Source: AGHT+IFREi6+xE8As6AfUHzhnF2zI2x/unVzciiXYX3NqYh0HkV9t5cMcjOgt5siISL+FR37Jj9fVg==
X-Received: by 2002:a05:600c:37cd:b0:46e:59dd:1b55 with SMTP id 5b1f17b1804b1-46fa9a8b3e3mr168711425e9.2.1760411932553;
        Mon, 13 Oct 2025 20:18:52 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4413.dip0.t-ipconnect.de. [91.43.68.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e13b6sm21160015f8f.44.2025.10.13.20.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 20:18:52 -0700 (PDT)
Message-ID: <8e7c9b48-0809-4678-8747-313f2bcb5699@googlemail.com>
Date: Tue, 14 Oct 2025 05:18:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.17 000/563] 6.17.3-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251013144411.274874080@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.10.2025 um 16:37 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.17.3 release.
> There are 563 patches in this series, all will be posted as a response
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

