Return-Path: <stable+bounces-78128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C8A98880C
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 17:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13421C20EAB
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 15:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A006E1C1720;
	Fri, 27 Sep 2024 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WmftYJW9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22AB1411E0;
	Fri, 27 Sep 2024 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727450249; cv=none; b=JctLDVrChyp5hljS0l7X8C1ixNB81mHRkdvSkO3wnjQ8JGNItHPuT1xqYK5z49Q72mHZF8qWVEzVWPKlUSiPdyr9v7dqqrqZWRnLdJIT+XdAZ+3H0EE8nFaK+hHV/sS9cRRuOMo9c8QwcIWljPVNfKkLsoQEcTxca+55L/Nli2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727450249; c=relaxed/simple;
	bh=qotPI54Wq5Po4F+d0vEMiGICRK9Y0VTfQlp7OOQ80A0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LoSkDQZJ2J1364tFVFtQUEjIfzZxP74Vm0yLBLzxeOHz7D1ttUmld/vJJfSxNFXom75d4A8SVac/6j95FvaVMKk0cM56gDvWQGFxybLtCp9ELqVXd9zIZe+RmpQC4ZeExOekncIk/ybR6T8xYsRGU95ISeJYWpXP8l13xFd6jcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WmftYJW9; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37cd6ece97cso749037f8f.1;
        Fri, 27 Sep 2024 08:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1727450246; x=1728055046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vhCTLLGVMcg5/d4nOELjFPANclSHCcn/4bUTIl748nE=;
        b=WmftYJW9uXEwQkMYDaprBQdgUkCQhx9fvS/eqsX/hoPt6IXgZPAArnO+K+AMX/af/k
         /fFApTnGsfsmyFhTy304WmYAg83MFMCF0xtqS70ZhhNBUBASk0lhZxFm0OyTXHyCk5/d
         4bUvTQt0QA3lMixDdC96dCyzVN7aeFZvQooAMdwnOcxZLYFEwjMfsHpnWcyVoAxsBOFl
         qEF7q1BtoBRliyZ4JrebB+o/wUVJihYskwaVIXbZkds2xtWCAV+sMEp6yrTH5UId71UI
         wp7FhHbHcwl0UMDxDN7BBdlRfF+9iwpiC5YmTOTlr0naSbfj4n5f1U7sNC7eey5Av/j5
         SQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727450246; x=1728055046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhCTLLGVMcg5/d4nOELjFPANclSHCcn/4bUTIl748nE=;
        b=lj+Dhr1y51R6Fg6XTz5z6bOvQ/+sVp4NXdx97zUAf/Waa4zv+VK5GijzZghJTe30GP
         PNtR3I433M97OrGnRBclP9f36WuzjbE5q1wAgEP0PoMsqH3JcxfOaMfgUv1LmnLp4XIO
         9ryT1SlWtzOUUcrk+r2sCdOEYAzusQbveFQ4vOTM6d/J+I0BR/dPmCCRySrNfLyp3C/B
         kKyzsEEEl6R9l1SjQ8TzNL/GVez03dkoX+uoUfYfZAjvcowu/M1U12qb0ubT9e5jN+3d
         0oLgqHYIAvv26ycF8u3jZIUzyhfRJ6vNH2AHBcVAhD5mhEQT4wEtXtDA9oxM2I4mCOfO
         8+7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVqdvfMUVay/sgmZIwu2Hk0UDWmxCaN+vOeuK0IN/cPSflNzKNMUfVeOl89YCGyPSNDkCL2uKi@vger.kernel.org, AJvYcCWtAsPXDc3oYzeeJtwqO7VHeJBtXCQBppZyUoJOy720NbQd4HQgvdlA3XiJJqL2RjEwdoTS2VwKO5UdxEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRpFFmvOC4xGU/JEqYNH05AJmHG7ScdOQuiDfDh/FcSY+FJafG
	yqC5SFABAkWZ6ekr/ZNuwygwcOuWzqaRXjfxzP6O8c/FmwZh6qU=
X-Google-Smtp-Source: AGHT+IERcBTXM/JQeaH3Cd+55vt4oYSz+GuJRentSrjtcxuR5nQoUgBDrbncowFA4cYrh+zjfP/5gw==
X-Received: by 2002:adf:f385:0:b0:37c:d23a:1e4 with SMTP id ffacd0b85a97d-37cd5aa99d5mr2543951f8f.30.1727450246143;
        Fri, 27 Sep 2024 08:17:26 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4a79.dip0.t-ipconnect.de. [91.43.74.121])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd5745696sm2750790f8f.106.2024.09.27.08.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 08:17:25 -0700 (PDT)
Message-ID: <cd70ba78-d32a-4ed1-a0f9-b6f3131fcfcb@googlemail.com>
Date: Fri, 27 Sep 2024 17:17:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/73] 6.1.112-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240927121719.897851549@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240927121719.897851549@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 27.09.2024 um 14:23 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.112 release.
> There are 73 patches in this series, all will be posted as a response
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

