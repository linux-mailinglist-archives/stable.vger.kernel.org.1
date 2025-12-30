Return-Path: <stable+bounces-204231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0252ECEA005
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 16:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB444302C4FA
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 14:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ED4325739;
	Tue, 30 Dec 2025 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="D75aMIF0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393E4326928
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767106794; cv=none; b=VJHt2p4mo7uBA7emuEjPJ5CK9Pv6LvIkWlK/udJMhVe4VdJVP7q3vXVCtgg6uW2JO0dRRL37sVKKxum723mUIavzO+Q5Ob3YaSvasXvAZzDIigRh6sbsowXx8N5AaDp+s6QH3LGjK4xi+RNn5jipo71QE3Osz4DV7lTzPp83jms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767106794; c=relaxed/simple;
	bh=7sdKpaAy4sTaJN/M98wTjdHctQ8WEkEfKF9QXapr7GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVgx87NOvOdIyaepF5WRoonvFsZdSi+b3c3LOt5gcnjZAc6SuDLSKo93Z2DixUPkxhdWQ0XfbZeI995M+Q9g9LGX8FbMpnw4djJpiwSUZy3Fskd8pnHiK3p6zemLqZBcEbabDevWIkKY4D3hCZmvI72jbMOKfRFCiNlJg3STk24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=D75aMIF0; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34c565c3673so5062744a91.0
        for <stable@vger.kernel.org>; Tue, 30 Dec 2025 06:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1767106789; x=1767711589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvCtBUBb7964OvygP/IWixIiCy3FZv5fu0b66ANzNSU=;
        b=D75aMIF0yn8NrGiU9Ouokdkoh19befbqoGe2HssC8ePVMlOCNVVLiYdBBPT9SNM39B
         tlCJSXH+V4jWnZaS7NHXQYsboeZHZ09au5KeZFvchoyT2o8XahxbcW/s5R1prI/8M37h
         GITXImbzBXgrl4kDHXnRMLv6e0AqLEVOw2gdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767106789; x=1767711589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uvCtBUBb7964OvygP/IWixIiCy3FZv5fu0b66ANzNSU=;
        b=F8ogLF0BtBM9UtizmhXX1SzL8h9EHfUEGeyiPuGw1xW4P7xiMMH6Pm29wAfAiEtqqj
         3dyMkfD6ZuzPl/7XM5BBVm9m9DQOPbE39DIXBT6t0YXQ280Dn8VJNTC3Pp4ptg6ngzVh
         Hc78onrQLtqhryePYM8m9m17afXnpt2laMafnk+Hv4iY5yoqEkLNhG7+7rlwQCzeuw7M
         /jW8p1/d3m4XpwXqSCO3zuqWmCM0OsIs5fqmlcmTqDi3hTzZg1rMQZF+AIqUwXiTOwR3
         WmEaw0vhHnoEH4pFFCXznJ4BQeDSRTBnk/wVUell+WmPtExAu+QdUgpjhG5u6O//1hnx
         AuNQ==
X-Gm-Message-State: AOJu0Yx1rrwrEGBXCN6XPB2Tbyz8ncma8nh2C/8aaS5aQjtB28GhpZFJ
	HL5RE32FYDFaANaQFS/LyRgt+CfpCJ8MXFKtkL4ie99YFGzj19Qy5F6c3oWCMKOSFg==
X-Gm-Gg: AY/fxX4uMp/Ls19ZyJLZz5FGmm1XVMeXsxCBPCtaRN/S/BYK+TbcbPU8ePJn4kxM43f
	NrwjPSEKk1azDhiAKn7GqEYbeip8Aht5WSNvkrTP55/gI6xhOoSbSPs+u3Zxf8Cw32kEbfYkmWt
	FOto4fOSf6t+L+Obv2L/g2MNucw+WcHfw/8mON+ojZmY7Kb03MVpB4lnhUj7dRa4DeoekOP1556
	awf+0o104YvC51fGeXeFh3k+ifE8541FWBwlG5VND5OXTP2rMhAw/5OAOpvDTc6Q29O4skDNE6F
	XiPAE70w7Ptcg46gSDI02YJUosOwpEIs+GldrTeYHbxZWNofxiUIBgE5Lo2pXTJqRmx9jtFzGlM
	l7Vt2W2Zc6NZLBZIr4E77ejfup3/91S+GTrKEympBTR1RwIfj4ygTiISs9+6ntmjY8PvrX21wFV
	87FdInibulTtrZEnO6UQg0o+pErw7uxw==
X-Google-Smtp-Source: AGHT+IF0MxrMPuteJxQzw8e1Snaz1xJCkcZKhSP7y82QMdNPwYWZEXdirCP1n3Yf/5a2E8TlT5kmYw==
X-Received: by 2002:a17:90b:4ccd:b0:32e:3592:581a with SMTP id 98e67ed59e1d1-34e90df6ab4mr30491683a91.17.1767106788770;
        Tue, 30 Dec 2025 06:59:48 -0800 (PST)
Received: from fedora64.linuxtx.org ([216.147.127.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e92227da0sm31003306a91.9.2025.12.30.06.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 06:59:48 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 30 Dec 2025 07:59:45 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/430] 6.18.3-rc1 review
Message-ID: <aVPo4dGaSwUVuX0x@fedora64.linuxtx.org>
References: <20251229160724.139406961@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229160724.139406961@linuxfoundation.org>

On Mon, Dec 29, 2025 at 05:06:42PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.3 release.
> There are 430 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 31 Dec 2025 16:06:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

