Return-Path: <stable+bounces-178939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B6FB49657
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 18:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CF591C21EF4
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 16:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551A930FC3F;
	Mon,  8 Sep 2025 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpGaFcfv"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3BD183CA6;
	Mon,  8 Sep 2025 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350705; cv=none; b=IjqEmZlRfYhlF98cP2A2w0Uj2p3aTGoMfrOSAi1nZuaW2lkuZ7VKMaSpJyQEFHKKkNMZjnjDj3b4wPtM21iNkMopuCU61DYQ8zRVURSqrCGkNDpBmtNvWygQsjzVTnwx9wPrpWZ3So/Zc26/PvtOUq5WBtrj/J0PgHNl2vcobcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350705; c=relaxed/simple;
	bh=Y1rChX9DxLW70YkldiYMb4Lie70kMNo9Ol1isUhql9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQMPK9R7i1jBp+RpGl9LYANdtbFJvNFwhVTE6ag9ef4s6c0AGhLpY2TKAn8L13s1mF/inlT0ulHInS9x4klkfDfmneEEDou71ImWR1YUCNey9lC55VgIYbzRx/fa2LHZZzv+3XDyTT05yxth/IOglrZ6zhDEBHBVHnkbCaYbh54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpGaFcfv; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-726ee1a6af3so52414546d6.1;
        Mon, 08 Sep 2025 09:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757350702; x=1757955502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2mfVZ2OHIGggTmY0sxP5FH9aCSOjCFLQ5dvaKvSRES0=;
        b=OpGaFcfv8YL6cUkeuZRl6nSouxmae5xw+df8f5b4XaHbgyPXFnn3Fn4qsi7rsR0o7r
         KgEBCLmXSGH4arreGF+8yW8jY+V3FThBv3vFxrdisJm5hjAPH1jC44yb/4xtPO/C+4/T
         TojjKAFfQOfP6GprsmslyfOoDNWCr1+O+VAzwGdxdkZMfjNDfymvfCaOAOgW5L6I0y1j
         JK1OeeBazukqS5bjWFBWCTncraypNdjMSNdmWn8fDXR4bysb0hSaGqEritw9tZ2SGsjU
         DHqe7QWdliJYf+CTQl1KgCy3mb7JNA6jtitIn9Ob16xp5mQkUsntTE2hTEOQBeL2tx9W
         fD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757350702; x=1757955502;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mfVZ2OHIGggTmY0sxP5FH9aCSOjCFLQ5dvaKvSRES0=;
        b=FFCAmSaAh3ulSRPRUA2MWnLdvDedHxn4DasFIRcu1lt9u3PCE5yxnoglEdboWNlVXo
         kshJhn/Kq8jOY10rZvI2OFZFNmNCIYp5FvL7A6E76JDH76tIRx9HdxnMWp+pbW3mjBrl
         CEbkpHLjOFvEy3s70znKbXkg+I8P3iAypD8tgsvpg7JnI7u6Nop1nQl0a0hIJx8f19+j
         8LrMA/DDeAEwEibcElVIZ6AlZogqqIg5tG80ZRHgddjzk0G/nQL/dov9/nAAhYDWSy1v
         LkfVm/1uVeJ54ogSQ5ctLQ6SsTe9oUUjn7UIFjCxexOLJOYsyBY2uFV9vhVo1iRn+Gic
         1hKg==
X-Forwarded-Encrypted: i=1; AJvYcCVuaj2kDS3wA1UdKOlb5/GQT7QFKJZ1/AgjOkq0WgUE8Jf96pyVTtYkyPgIyoQS9YqrPKWrA6Md@vger.kernel.org, AJvYcCVzbXHW9jPqAClVyvREkFjJKXUKQM+e+MkvjrOe3w7LWdoV71fag9HIYPg7uehhAhrQdRsGOjqsmfdwbus=@vger.kernel.org
X-Gm-Message-State: AOJu0YwidKhmA8aflI0ZwRayQptHmmqvisX6gqR/03cpYsoOooD6MiUa
	bJfBm4QX6lnmiwPFty6vUOoaFpiwraxQyiCh8QXZTXl8fDZLJ8TQ3ka7
X-Gm-Gg: ASbGncsEJfRR19i42oO5mNiKZ+uTXp4OoRZGenp7hh1QXxFWQvaWkZrci/poymG/1cV
	ta7HHd2eTskzV45sa0QgrqhpMDUjcMBpbpxo75rLxqpl5bMkv5bkNj9mffYztSUJoLXXMtNoGTz
	j6GdOIu9h6LXlU183HcLyMdLMj4AR6Y9y+KruCtXu0yMofDToQNsxy2myVSp/y8N1+m04To/Ivy
	70IKipWkIf/WBlBT1bwhLBh/xsS1yqb5oTDL0nLJNL8hm4GsLBAwJTNbvsMddM36IdHxJ7mnbr8
	Mbd0q7YX33WufW02bKfgnz7ky/F/FC+FPDutGaaNlNk9RokcrH+0Eq1q8wSqtBNoPVcN87spqBZ
	fi7jKJq9lo3suDxQXPHavd1CMJoPwpnq2JLHO5OWHBeM7xBcupa47eMPSDxfh
X-Google-Smtp-Source: AGHT+IHaWV5EzXjXAMApAFagSMo2wK+T2IfdiINcAZD168Q3w85cxtSZmzKBd4om+JspAP71S9DUYg==
X-Received: by 2002:a05:6214:f2d:b0:70d:b2cb:d015 with SMTP id 6a1803df08f44-739453b4d70mr99445986d6.67.1757350702354;
        Mon, 08 Sep 2025 09:58:22 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ae045ef6sm124696636d6.31.2025.09.08.09.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 09:58:21 -0700 (PDT)
Message-ID: <7c162049-7dc3-4078-92ff-b5f409d7a7ed@gmail.com>
Date: Mon, 8 Sep 2025 09:58:09 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 6.1 000/101] 6.1.151-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250908151840.509077218@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250908151840.509077218@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/25 09:04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.151 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Sep 2025 15:18:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.151-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

