Return-Path: <stable+bounces-3672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5AE801291
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 19:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D08D1C20CCF
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 18:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F784F5F5;
	Fri,  1 Dec 2023 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="eKEBS93+"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70436106
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 10:24:52 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id 5614622812f47-3b844357f7cso544432b6e.1
        for <stable@vger.kernel.org>; Fri, 01 Dec 2023 10:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1701455092; x=1702059892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YReR/ElyLsL0HPHj+5ElEXiMYpqxoQVx7nZynS4QGhQ=;
        b=eKEBS93+jIUELnJTharIDMKoTEzFqLAUuv2msgc7j+w7ZXNUHv3MIY4jvB6lGKx8m2
         bkjBaY4vMG2ffefM1uBmIcXjd1l+G5wX9Nju1xK47KURYDB2VgOPn9GDZYPnS+zuGmV2
         patAy1vTRttovgcCrtL4+iUZhuQO6E+K1Bprc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455092; x=1702059892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YReR/ElyLsL0HPHj+5ElEXiMYpqxoQVx7nZynS4QGhQ=;
        b=S4xdxD62D3K0uy0TZGRgImGWYaqC67XCi2EFRxBf8aF01srP2/BQDPYoNDcW13FGwe
         FnoBOZCszb3vHeoUy53lurJZun3PXBktoN2PD8Si4k1BHjUmkL+Iv5i7MrvNaCf84WqP
         uNaGEMYG5lU5FwMC4m3xCskBAfa4Uxw9PfCc0FBRr+zKYYKDdxwhFAYnIJRE6RsaCw3k
         Bck71LJrOyLRcvJ0IsYTFeJQNyH8fkspnWSdELs6sk27Z+iRqxWyQVVNT1lozGTROwFO
         dXQmTVAYq1Yb5P4cxer8bvdag3S2eEhRR6939u+b89KsiySZReb6YbBuQLUnHc276Utv
         Q1jg==
X-Gm-Message-State: AOJu0YwF4qcgWom6S2EsrmwIHIZ+4xQmMhOp6pimFhz8s082F3hTr+Pr
	QnlprA+bmYJWwgAo/b2ZsqFeyg==
X-Google-Smtp-Source: AGHT+IGPgafOly1IVWDEaRcvfphGZBGLi4CqUruCxwY+paDAHENLzM84AGvunQeaAC0WN9Esn1lKIg==
X-Received: by 2002:a05:6808:2c6:b0:3b8:5e9a:b2bd with SMTP id a6-20020a05680802c600b003b85e9ab2bdmr3632976oid.15.1701455091793;
        Fri, 01 Dec 2023 10:24:51 -0800 (PST)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id be25-20020a056808219900b003b898ffd8fcsm631188oib.50.2023.12.01.10.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:24:50 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 1 Dec 2023 12:24:49 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/112] 6.6.4-rc1 review
Message-ID: <ZWokReR-lD3mFIIo@fedora64.linuxtx.org>
References: <20231130162140.298098091@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>

On Thu, Nov 30, 2023 at 04:20:47PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.4 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.4-rc1.gz
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

