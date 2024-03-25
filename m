Return-Path: <stable+bounces-32257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C3488B11D
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 21:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C83A2E307A
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 20:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0920C46548;
	Mon, 25 Mar 2024 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="J9OjiBv8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B836FC01
	for <stable@vger.kernel.org>; Mon, 25 Mar 2024 20:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397622; cv=none; b=gOLMVs9SSAaoli+1Ka+dJ+Q0/gK+ys/WhIoZ5ferBYkxDVYZLYdJz0/ohA4NKAcdwoC3Rie1bzKETAwFXhYZihvWC5bbNuUeNlLMjg89GnXq1rjWRUxcSGsx7h6a14lF/ryUy0aHLPbrKX5ay7PqWsFx3tgcP4dVAx1qSEeYFxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397622; c=relaxed/simple;
	bh=2GSynMfQlWPEYmmMwEWyYBd32soX6drKAt4Jc4GY5nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbvxQ3rOzzlun3Y++R8poRuA2WHekyGtgwJxDCwvvOIPGeUmnG0n3tCEGgX+6i+CUoj18YVsYMdaPIlEN6ezMI8lFgfd9OMZIQvcyJbaj97RCFYe2OHZuqJ/VHZah3xTzQnH39mjYuepBPa1rHjUd7W4G19zF7GzPqa5S+pKoCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=J9OjiBv8; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e6db4dfd7aso622874a34.2
        for <stable@vger.kernel.org>; Mon, 25 Mar 2024 13:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1711397619; x=1712002419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x5MRZLBOe60pVxfq+JGemFNyckt0tyihI28+0Lv7YxQ=;
        b=J9OjiBv8/T5ocMJDd/5wJvUXzMs8u3YHJsOsFtK7aZEATajUMTEf/ZiNit9GXGq5mI
         vi9YmwAQaAMPlYwNwB1En/hSAePenDYeHPAHyLeyW1MwNTmayE/YGQRzl0lUgdO9DNqB
         0bLT2Z853bAEEqAIpo7o5ZN1i494sBxalLoJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711397619; x=1712002419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5MRZLBOe60pVxfq+JGemFNyckt0tyihI28+0Lv7YxQ=;
        b=DjnWPMIBp41nPR+Ac9bmjipkyx9Etfp5WKj3I8T8t8RPCTfYeoj4O2EeRUaWPezgxu
         bKfGEnGqoB5exX9GEm7WYIju6oCXI38kX4HwU0CyhRHV2CfGX1CLqezR8SX6dJKzYp4g
         h8ElRG7s8B9l6UKmBn72XxB6pG8y4cXDBY9krt5CPkcRRCrs7GS6DdFDaR/xnkR07iv/
         Db23KcHvegA7t0dXd1/vjKlS92hvmlKe3rBSFhi6nE6NMTB/9pkjC2FtTpDNjmt12CiN
         ThYwedpFKG0Kv4RiUeNIL79TOAvTQkmTD/ZA/x5m/Pj2Ul3N5PsCZ8KRLGcaVGvGzvSB
         5ZEA==
X-Forwarded-Encrypted: i=1; AJvYcCUATzNmVnlJ/mr3+HeWMhAscJjdtePFFOQfX+lkCxuktgBhzE8UhBeKLROVloG5wgGNWDX3pJOluA72WTXNXfwEde8sYzlI
X-Gm-Message-State: AOJu0Yw/jpi6G0KaoEfSKlvXUtuacsWL+aE9I2viEUViVLztbhJDr3U+
	xvbvnQk7nYHVi2U/TGFL6NLaOQdCcS2LtpOQekE6RQRNVuv0jkP7Y5LWkp6H6g==
X-Google-Smtp-Source: AGHT+IH5MILjTlLT4XjELr9ZSTY0NYuaahWY+8R6aTQhpg+l1C2xqghpFtR7CSPKI3vDqSz/Q/RNiA==
X-Received: by 2002:a05:6870:4205:b0:229:8236:ae9 with SMTP id u5-20020a056870420500b0022982360ae9mr8470126oac.59.1711397619514;
        Mon, 25 Mar 2024 13:13:39 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id n20-20020a9d4d14000000b006e67e27fd71sm1271489otf.28.2024.03.25.13.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:13:39 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Mon, 25 Mar 2024 15:13:37 -0500
From: Justin Forbes <jforbes@fedoraproject.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
	pavel@denx.de
Subject: Re: [PATCH 6.8 000/710] 6.8.2-rc2 review
Message-ID: <ZgHa8SsZfpNR2r6L@fedora64.linuxtx.org>
References: <20240325120018.1768449-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325120018.1768449-1-sashal@kernel.org>

On Mon, Mar 25, 2024 at 08:00:18AM -0400, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.8.2 release.
> There are 710 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 12:00:13 PM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.8.y&id2=v6.8.1
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

