Return-Path: <stable+bounces-6484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B679F80F509
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 18:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91801C20B1F
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 17:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04AA7D8BA;
	Tue, 12 Dec 2023 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="P8k4N9JT"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com [IPv6:2001:4860:4864:20::42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D627AAB
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 09:56:06 -0800 (PST)
Received: by mail-oa1-x42.google.com with SMTP id 586e51a60fabf-20306386deaso446165fac.1
        for <stable@vger.kernel.org>; Tue, 12 Dec 2023 09:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1702403766; x=1703008566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GhO7i0g8+DEMkg+DsYpqZaGmgA2sy3F5nbL7wCmBS1U=;
        b=P8k4N9JTMNKxIV3r6DYiw9urjtc4G3Yb7Cd06VfJwm/sWBxIaK5LfqHTTS0SrGs3Ob
         YBs4LxrUGB7LNjqCOoYvDS/V7JoFbO5wqAe005VtQ7Q0cAlIaaJPjFfGBib1sqpZxl9S
         orbhg4+TV9FLhdm1+QV+afX55bp1mUw1LN6dM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702403766; x=1703008566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhO7i0g8+DEMkg+DsYpqZaGmgA2sy3F5nbL7wCmBS1U=;
        b=an8DOzTV+u6FngYY6VrK6VgnaCeQQ13T8gjueu7cSNGxqQbHszkd+gByGZCVQfE4D1
         Nq4fX3Llo7GpHipYzYJeVfZ6JFHccZ3u5EzjWeYkQ2hxpzCuMwYyqY8GiHfRnzAzwXJF
         ZLWyHWSEQHpcRo0deg0dVAKQVW7/d1aBGDRP0OtnSY8uPlfjK1MKKc4R9AY+PR8Ib9Ew
         RL2RCzEKu/hxQDDqOLN9Z+3ifk7QYMIM0gIF2ut3FdmtVOATZqzoVDy0EL8u3SGQRcpL
         7i2toGK0omSLwaCQ/39/3X9QT6hOw4X7TG0n1o1+VoLfHEdBWf0OSiWSkOs1oohH8Xom
         KFiw==
X-Gm-Message-State: AOJu0Yzn1ABXdhTzqP/TKI/esMIRH0f/jItG4fRYkrYNSd9i7wEV7OSL
	M87376Ul+iFhZlabZvSyypoMOw==
X-Google-Smtp-Source: AGHT+IE1HD/oLSOYMj2B+IFoC9wztLPu0au2lOiT2+Zr3iFAqi8xJaGfKRpN/aRGMvC921QVzFRVTg==
X-Received: by 2002:a05:6870:d205:b0:1fa:2602:2e9 with SMTP id g5-20020a056870d20500b001fa260202e9mr8329662oac.8.1702403766102;
        Tue, 12 Dec 2023 09:56:06 -0800 (PST)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id wy3-20020a0568707e8300b001fb38204e42sm3315094oab.20.2023.12.12.09.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:56:05 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 12 Dec 2023 11:56:03 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/244] 6.6.7-rc1 review
Message-ID: <ZXies-AXCT0ZXuT3@fedora64.linuxtx.org>
References: <20231211182045.784881756@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>

On Mon, Dec 11, 2023 at 07:18:13PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.7 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

