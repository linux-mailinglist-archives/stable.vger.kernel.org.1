Return-Path: <stable+bounces-191555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4264DC172BC
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 23:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915591C27FB9
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 22:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0782D97A6;
	Tue, 28 Oct 2025 22:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="dpPJPkrN"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDE338F9C
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 22:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761689956; cv=none; b=cYIBqvklkBld8TW60bHQ/jLi4gwz16qzcUfjE/veWMQ9o77c1IrwmfTv2Du+sk2PUs/+eJBc3iemzlopwy5oT0la9qQX6ht+L3yEPwzadcZH+cTWVgrhhCJLvH65sfIhSO0K28lIDYXKShd+9foc9fdZ93ZeaBRclAxK3L7iTSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761689956; c=relaxed/simple;
	bh=mevXSP3pEnwviu7Dtj0yYMRGZGl7rzL2dcYI/FArHso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n5xINcRASzn3gBKerYCHjcI5ebEGxf4s+oqt19ey5RQLqRePMrgtTKUrVJWeqzQy1XrWqHNLtd1IRnZM0/DrDce+/7INNSvE0fJlkWq17CbbGQoLDTymj4Q54x+iK8CMDusns/hj6cg5w2EoygixsX3LRbpJc73/m1OKCX+qa7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=dpPJPkrN; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-89ead335934so464449385a.2
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 15:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1761689954; x=1762294754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=56ATqaJhxY4mgO71KSReEDqtQk4ZYFmHYwLd5aGRlu0=;
        b=dpPJPkrN+UfeeVZ09Dp7awi3OINHjrL/Vwt8g+FGDqPGDXJJdn4WOJsImyIYhXm1KA
         ENt25tGaW6ecrnIz7JkYKPErRo6yGtGIRvh1C21vI59Hjvft3fonFGulvDNZNRqU3s90
         j+N+Ayw2MnHDmUZCL+hztl1milsyDzCUGTOKp+38pKkU5J9LryQHd2qxhIcXClegt2w8
         QMylaZKe+1emIncnacjCnpVEfEXKH8I3boyut1RWVlLktzqII7pQeDRoaNLd1ql79g7S
         5eosyKrmuIC5vnQVsGLlI6ZnEyiPnkdQWNbGMSYJnnzSk9sy0DAK+MvtlEMs5SokrzZ3
         6ERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761689954; x=1762294754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56ATqaJhxY4mgO71KSReEDqtQk4ZYFmHYwLd5aGRlu0=;
        b=FI4k3DbargZ9/8staYnzGwob9waHx1zyviXIu28DJVhBzZ3tjWu65fnmgWHzqI64j6
         aoVTYnaMoC+CdpPEl8U/nJajPjy7pg9b/C0xzsiprla2f2XOv4NzpT4vrJOC9xlaXppl
         j3WILEHo292DMMKq9AjUtQR1E654+Fj116eMXjPluLacBEBsJBM7yCAJ+uzPA+KDHrnn
         VacsnathJCRmWBEDMmb7OQETW4YibYmxXmjpI2IMfuBRPuRKHcMIJ3i8Vl4Cb6j26HQm
         P73f+BClJcH/KeCEBaCMfx+onhxhJYro0ToWFqwaMGh0oA+wVbazaTNfX339Yh3ajCcu
         mZsw==
X-Gm-Message-State: AOJu0Yw/S3VsmOFA4/GhcQi2B4QJywuoGI2B0YpxQP1YSDu31Y3jNCdq
	sK/7REYQgHwXOVpvdavU+6iTJTzR/YgBErCVkHU0V9UHXbjIgflSS78xhVOqj8iN+AE=
X-Gm-Gg: ASbGncv4YftLtDUObAC4Dqivb5qoeqbHs8zG2m2wQ1Sq2x/N91jTwtJ4NsXIs2JQcUZ
	qETFvDJ7oXADOkrroYl/uNLYj2qT+JOffIv1qnl+RxVf1acOl8kNuEAAKu0iAZrqodfi2KN7hF0
	tE5eDMgOYqGFagBv3IAC8zKoNDuT8mKJBBcrEis4di/FNg3jk78AXqFW1IysC1cYIL/++fQgW9q
	9h8/yK5CrSkBOqN29PKzHXBybH7YmYyfM6oWi1XsFu2XCk5AWqwqiO6bEZFNm2aYXslPMWbaV+E
	7IN6PwVXanVBpXJJlPP6Bb8I72+R4oWorn/Z8wePL88x7WN6qoypmlrYtDJle0KVdqiR6gEG4bh
	Yp4zDIZx6jfbq1KHN6ygVhEgYl5YaDYtWT24JpmY2QLlNnP4YKM4AkgcwJnq0xj2JczDI8FidzS
	cR6sYj03iaZdg20A==
X-Google-Smtp-Source: AGHT+IF8GRGi5y+TVmHqaFaB9DksAsq59HHx98BAT9jVFEgFA7NH9GIYqf3/VizIifdNtLOSDGMHdA==
X-Received: by 2002:a05:620a:1a18:b0:8a5:331:b22c with SMTP id af79cd13be357-8a8e53d8000mr152397385a.43.1761689954189;
        Tue, 28 Oct 2025 15:19:14 -0700 (PDT)
Received: from [10.10.13.73] ([76.76.25.10])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba3830f16sm80099491cf.22.2025.10.28.15.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 15:19:13 -0700 (PDT)
Message-ID: <b6e926dd-810c-4123-bda4-5ccded5f8b6b@sladewatkins.com>
Date: Tue, 28 Oct 2025 18:19:11 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/117] 5.15.196-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20251028092823.507383588@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <sr@sladewatkins.com>
In-Reply-To: <20251028092823.507383588@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/25 5:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.196 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 30 Oct 2025 09:28:07 +0000.
> Anything received after that time might be too late.

Built the new rc today and have nothing new to report. Stable on -rc2 
and my x86_64 (AMD) test system with no errors or regressions:

Tested-by: Slade Watkins <sr@sladewatkins.com>

Thanks,
Slade

