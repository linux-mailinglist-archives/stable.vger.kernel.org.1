Return-Path: <stable+bounces-55970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C4791A933
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 16:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DDE51C21C4C
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 14:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B28195B08;
	Thu, 27 Jun 2024 14:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gge1m+KQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0E7188CC6;
	Thu, 27 Jun 2024 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719498546; cv=none; b=LpiM1kHnA421ZMCVWHPzQYUX1WIZM8Nz97Xj06BC25JHy/CSd+r83IOqePFIEPP25dMCiWpKycy0oRK0jJfgRUwhdSLgtZFMslejhl0ul0rPTuc6Hq7HL6qdUqxd+SXqdeARWLgGRvyAXCxO+IYaLvcaqQp+7CXdZXS93o0e/JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719498546; c=relaxed/simple;
	bh=HqnklAZ6RVDF5mJ3H+d0Tpnr4wVwrvGXfYqlEvtzT30=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z9EzABG/cBBESqbSJxIbpSWvXcgxrBRTPbIrs/Am7UF69M1C1kO2G8WpapL7xWbDoetX7R4iq3zDHUq2mSFLtIpT2BznGXMo+c9lws3CnriHlHr27kyCmDivIpaglfWgXXMthi/kdGV5VZbiSIhrEdjwp5kK4XT6s0s5Ww98RCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gge1m+KQ; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-1f9b523a15cso13660175ad.0;
        Thu, 27 Jun 2024 07:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719498545; x=1720103345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1JcNaLWolRs7n14rIRyjHq0Qm/GfqPz8+VFMNKe+dU0=;
        b=Gge1m+KQEQidh1IaHBcy1B5wXBDG+va5f4Ljtz7kOcjuzUqCgMR1S/UX1Ov/LKz0I5
         XouarqYbPGnVEE4pxtbNzF/ktorET8mRHXYYx9JqEaNFgVFN1zIzLDSsIwlyoJZWaMox
         f0AO20yW69mWdS8msAu9oMVW+xHkh5O6SDKmW6hlLplm5A4ms4D/mYDMHfYaOZUwdju5
         MUZXI0sT+2xWFjaqMmf37wJcA3zHJf3o3mOwj6KWeydve3wXpsJS617gge+joWMLIz5g
         D3YYfNKbOy1qQC9c4+XSPAyY1HOb6e3BKWBwKb6sGTdH1LSFkyBguKurU3ZJXA14sVLd
         Zreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719498545; x=1720103345;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1JcNaLWolRs7n14rIRyjHq0Qm/GfqPz8+VFMNKe+dU0=;
        b=cd5wc59TJ61v1jpUZ7Y7tOwZmmsEYxDaiJYH+hRuHbM5oJQ5Eim2JT7Ww30FV+TSsw
         qe+nBENsXAQJHDJFMrK1WuBm6j2s+xQ7Q/hdtke9iLToEmRfqMETaiktaZ+qv5rbbQP2
         3D55I6VzMl5zEs2FhWFYVHUG/Lb3zcBUFNc1EYViPNVjuzkboC2ReCQecfZ4QSTcQrKu
         H6KL9p8zz00Vg1SVx6/cyY84zc5m2JTMUsqQ+r12/dtIGDmYle6F3RKnPZ/KDLfstGSM
         ijvgNflZC6dMa/WBKEnn/8mzjbVAZkZStOosllpEu+3thTpovxe+RImTyahjLZxiDlYA
         eLNw==
X-Forwarded-Encrypted: i=1; AJvYcCWhvzWkqLGD5PC1GI3b03Aqd5ig910Oe46119O4ab9/Rt8YDT9yEBBaYPiDokzMuP4gBQkctetG2h8kZf1/EGYJzziHJcVY
X-Gm-Message-State: AOJu0Yz+dtEAWOqiWJTz2CrlmvjlNhNj1xCR+2M7Rlys57tSyX2IUG+c
	GcgsD6lvkp4U/3715x5k5ZODxEeX5A85VwM68cpkSRXmk/DqVhATX5QQ+R4RaiI=
X-Google-Smtp-Source: AGHT+IEG6KOTj12naJO65gSeeuIGUydngcS0AbDsxxcu1iqE1UvUj8yUX43NwPl9NrYcL72FxRQO3g==
X-Received: by 2002:a17:902:e5ca:b0:1f6:87f:1156 with SMTP id d9443c01a7336-1fa5e4f60d2mr153436935ad.0.1719498544580;
        Thu, 27 Jun 2024 07:29:04 -0700 (PDT)
Received: from [127.0.0.1] ([212.107.28.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac8f2c0csm13941975ad.99.2024.06.27.07.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 07:29:04 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <6b8e1e79-5a2e-416c-8fee-878b3f5568a0@gmail.com>
Date: Thu, 27 Jun 2024 22:29:00 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: entry: always initialize regs->a0 to -ENOSYS
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 linux-riscv@lists.infradead.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, "Dmitry V . Levin" <ldv@strace.io>
Cc: linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>,
 stable@vger.kernel.org
References: <20240627103205.27914-2-CoelacanthusHex@gmail.com>
 <87o77mpjgd.fsf@all.your.base.are.belong.to.us>
Content-Language: en-GB-large
In-Reply-To: <87o77mpjgd.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-06-27 22:08, Björn Töpel wrote:

> Celeste Liu <coelacanthushex@gmail.com> writes:
> 
>> Otherwise when the tracer changes syscall number to -1, the kernel fails
>> to initialize a0 with -ENOSYS and subsequently fails to return the error
>> code of the failed syscall to userspace. For example, it will break
>> strace syscall tampering.
>>
>> Fixes: 52449c17bdd1 ("riscv: entry: set a0 = -ENOSYS only when syscall != -1")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
> 
> Reported-by: "Dmitry V. Levin" <ldv@strace.io>
> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>

Patch v2 has been sent.

