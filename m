Return-Path: <stable+bounces-4873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4677807B5C
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 23:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4831F21944
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 22:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3AD563B6;
	Wed,  6 Dec 2023 22:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="P2+VFVd9"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD83D5A
	for <stable@vger.kernel.org>; Wed,  6 Dec 2023 14:34:26 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id 5614622812f47-3b88c29a995so256889b6e.0
        for <stable@vger.kernel.org>; Wed, 06 Dec 2023 14:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1701902065; x=1702506865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZLAnzUmImkhc8qIHSMyVS5GmGRI3/cRZA2cD+zeipTg=;
        b=P2+VFVd91FhMYdDvjKfNHUiArb24/CYL83mKm7g8D8ECiL+waQh5opOpPm5UGlblwP
         e/dnbPT0I2GnKMk99kvsjPB2SijJiww9Bm1TKBalGzH3YN9B/6yln4eXajy3mesq/bRS
         4kiOly8fMHG5Q/5/Hrwe2x2iEeZYozyDOg31Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701902065; x=1702506865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLAnzUmImkhc8qIHSMyVS5GmGRI3/cRZA2cD+zeipTg=;
        b=vHxwqVbKICwP0aO7X6twVwXYNN4clQQU6jG/fuSZdkI137Q8esOQHTuZa9lsrWW6ul
         SphRh4AZySiMqfXgiFKRwj9EaqxpFDmFO7z+IaMz7mPgk9ShaNVteoHlmGvWSgP1fhPg
         3Nypprthn6rEG1sJxm+Ms3CjzdzqBzlMwGAGGi9Wo5AZ5/fQZXSSGgqCCm6EOuHlU8pU
         tFSGS7fTPdSXPdYywdU9tGajQh3RDPySDyQrgDWWg/1caJ3FwLNwwWHha/P/1IGVGIhh
         JdWo0B31JbVVdvlk+5NwTyEjCn/Pqqv3iB1H4FgnyD9BTq9cGEOMpZqOQsEP0A1IYx31
         UhEg==
X-Gm-Message-State: AOJu0YyuWDmAUfG7MMbMx9n6xakNiIcZ5AObkgljiQqs8jJ5Dv/3IEr9
	GFO8VAJTxDTltIPQOMxsBHiFUA==
X-Google-Smtp-Source: AGHT+IF/i0+BQhG4ASvw1P/Q/HjuK2+tumaFPvDBBwN5XEKcKYVZi79XVoybw+GeboMuvgjJju3MIA==
X-Received: by 2002:a05:6808:1aaa:b0:3b8:b063:a1e0 with SMTP id bm42-20020a0568081aaa00b003b8b063a1e0mr1464142oib.106.1701902065495;
        Wed, 06 Dec 2023 14:34:25 -0800 (PST)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id z7-20020a056808048700b003b29c2f50f0sm11033oid.18.2023.12.06.14.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 14:34:24 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 6 Dec 2023 16:34:23 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/134] 6.6.5-rc1 review
Message-ID: <ZXD276eHg24P4237@fedora64.linuxtx.org>
References: <20231205031535.163661217@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>

On Tue, Dec 05, 2023 at 12:14:32PM +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.5 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.5-rc1.gz
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

