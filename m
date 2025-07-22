Return-Path: <stable+bounces-164284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB708B0E37A
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 20:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F227556113C
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 18:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18E528000F;
	Tue, 22 Jul 2025 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fbBdjSE3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FFF19D082
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208839; cv=none; b=taBgfte095CYV/9LQXPgx2fNe3+eG7psjuXT0jgDkDaKK5nwTAnQRlfKuTE2gFaNkpBivxpQwr3Wad/en4wWro9Q1F12weM9FJfIeQ1JWU8ax+RJ1AZgVcHgqwGQ/amE7MrUNZ3coWMVvWDZ+OfOB+UD+cEJ1uuna6bLKjrLU/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208839; c=relaxed/simple;
	bh=TzuX4mInNFL0Y71HlZ/CxdY52DbWevcbHeKa5VEl6b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3qXjypiL7gWf0At+OatwUbji0RmLoGR9+7Ih8DQ7/KmcaEhpAWP20d9RQMQLs8lKXQ6iDfMD9LPFbwZbJfvO+ZG15WtTz7WM4UdSusaipRbL6MfL9FVgC4tdgwChxCL5JFSPgLJrs8OABjSA+KrCmUdfCAeAQGdDNQBatbK+Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fbBdjSE3; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso4006686f8f.1
        for <stable@vger.kernel.org>; Tue, 22 Jul 2025 11:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753208836; x=1753813636; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Z8+WxTUCxaG+bKBH/CjfFqMsRzOrc36DXiZRhX8IKQ=;
        b=fbBdjSE3y2GGmYpxw+mlOrzUt9fZZvAVKKg89b6flAay1wOTFChU2s10nR6Php8caf
         vlHE45fOuBxcyRXk2r8uj/u1iaQr+nJWdzaaHS3Zfa59gBMjsQXoN8fC3SrQUbk7K0iv
         LUsM82heCOvhFW98e2iorMsaBuDkpKX3UPSUArRQ/wFmco7VLe7DH1y630oPfWuevjqH
         8QtAKzhQGJ6CfgaEXMCNm4WzxijTZXkgzdlmS1JDSb9M2wzKiLwbEhIavuzwbFi6s2mX
         TftJiA5QcOpfdzWUHPEPRBaixzcYgyDnKa92qHrjTgnV0/UKQkwmWLrh8Uxycwx/aW5o
         uzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753208836; x=1753813636;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Z8+WxTUCxaG+bKBH/CjfFqMsRzOrc36DXiZRhX8IKQ=;
        b=pZ2sKxR1RZymxfk2McpU9u5nQkNsbjKf5yc8Cc8+UZbkg2wgMvjCRz6qe22h5tTwj8
         6Vu5AvLhOUoaKm5vehhsqzrkAbXlrtTwkI2M38xZS6qcwxsNf0zdwECIb8stx0GT47p3
         /5Dp+3m/zro/lUgLiiks4yaCX75nqcoZ4BN5d9nLEg80Z/iAeVPtPGetA1nQB378xKlu
         3vUvgsWwQWaJ9K8o6I93TeOPF49Fw57y6mPtzKkZ0+0/cpkS6HzbXYbREaJzV3rdJg9U
         lYloqPGsYaSQAG0X23bjh0X1CvY3P9cA/W/zr6FkkxQ78KGcKII1cRcV9Lqu51iFX7Yp
         RQog==
X-Forwarded-Encrypted: i=1; AJvYcCUAgRwXtkWalOwM/dvdomkDT93i4GKfjShm7rYfrLXLmWFR+cVhyQUZYVga36qJyx+0lY+3gSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1U2eZ5vlX41yIQG0yRaA+FaqBdf36nY9VLNi4QIjH0DspEwWd
	FHhkuU3Sb2C/cZo+kjiF28eti/BHcn6u9eFcTLh42okAGc82fWwDN9HJ7lfjlZkKtw==
X-Gm-Gg: ASbGncvhkVydyMUfgTpAh9r5KHKO4jDl2jH8DzQv4FvFgcGOzkek2UJEEg9jgScH3kM
	i0Qh9R2J+iAZTW0YOuf4vdflu4vC6uvvNY422EO9HOIi1rtMbpcI6ZfMh942nyNFQl/JhFz9v4C
	JtFWTrzL2j7yShjJrRBu1R7cRVTlHrCy1tlH7visTcKdoj7W31aWpvIlw0MT1+Kq503bKSwqq1J
	RwOPMbvUHTguhHhKobyCKuXxOQM4+bhm8yRJ2UnyvPW06NbVZp2BMXOWGj2GuqGA5WGdrVEps/h
	KgO6bTgpUX7WEokr27M2u1je9lR+JBL4lm/ovxSE1r38RSwNVxRkOpN7C5OeNEstFbgNS2g5OPI
	Le63txW6Xvzj/WIzMRIyMr2WjG5tkkwzjsFYHx4rgeL+1xdAqv7PP0WmFhw==
X-Google-Smtp-Source: AGHT+IHWIMlQSVzvAq85Yom5KJ9BYmsTxVnjI5RbzJDAcwDVZQTDVOTdmdUULBd3ut0q8DI1kuLuUA==
X-Received: by 2002:a05:6000:1885:b0:3a4:f644:95f0 with SMTP id ffacd0b85a97d-3b768f165f7mr219753f8f.54.1753208835850;
        Tue, 22 Jul 2025 11:27:15 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:2834:9:53e1:3729:be19:c80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d807sm14296542f8f.73.2025.07.22.11.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 11:27:15 -0700 (PDT)
Date: Tue, 22 Jul 2025 20:27:08 +0200
From: Marco Elver <elver@google.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	clang-built-linux <llvm@lists.linux.dev>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: [PATCH 6.12 000/158] 6.12.40-rc1 review
Message-ID: <aH_X_AVUDoP7oB0E@elver.google.com>
References: <20250722134340.596340262@linuxfoundation.org>
 <CA+G9fYu8JY=k-r0hnBRSkQQrFJ1Bz+ShdXNwC1TNeMt0eXaxeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYu8JY=k-r0hnBRSkQQrFJ1Bz+ShdXNwC1TNeMt0eXaxeA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Tue, Jul 22, 2025 at 11:30PM +0530, Naresh Kamboju wrote:
> On Tue, 22 Jul 2025 at 19:27, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.12.40 release.
> > There are 158 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.40-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> With addition to the previous report on the stable-rc 6.15.8-rc1 review
> While building allyesconfig build for arm64 and x86 with the toolchain
> clang-nightly version 22.0.0 the following build warnings / errors
> noticed on the stable-rc 6.12.40-rc1 review.
> 
> Regression Analysis:
> - New regression? Yes
> - Reproducibility? Yes
> 
> Build regression: arm64 x86 kcsan_test.c error variable 'dummy' is
> uninitialized when passed as a const pointer argument here
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> ## Build log
> 
> kernel/kcsan/kcsan_test.c:591:41: error: variable 'dummy' is
> uninitialized when passed as a const pointer argument here
> [-Werror,-Wuninitialized-const-pointer]
>   591 |         KCSAN_EXPECT_READ_BARRIER(atomic_read(&dummy), false);
>       |                                                ^~~~~
> 1 error generated.

Thanks for catching this. Newer versions of Clang seem to be getting
smarter. We can silence the warning with the below patch:

From 56c920457a4e7077b83aafb0c9c8105fb98b0158 Mon Sep 17 00:00:00 2001
From: Marco Elver <elver@google.com>
Date: Tue, 22 Jul 2025 20:19:17 +0200
Subject: [PATCH] kcsan/test: Initialize dummy variable

Newer compiler versions rightfully point out:

 kernel/kcsan/kcsan_test.c:591:41: error: variable 'dummy' is
 uninitialized when passed as a const pointer argument here
 [-Werror,-Wuninitialized-const-pointer]
   591 |         KCSAN_EXPECT_READ_BARRIER(atomic_read(&dummy), false);
       |                                                ^~~~~
 1 error generated.

Although this particular test does not care about the value stored in
the dummy atomic variable, let's silence the warning.

Link: https://lkml.kernel.org/r/CA+G9fYu8JY=k-r0hnBRSkQQrFJ1Bz+ShdXNwC1TNeMt0eXaxeA@mail.gmail.com
Fixes: 8bc32b348178 ("kcsan: test: Add test cases for memory barrier instrumentation")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/kcsan_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index c2871180edcc..49ab81faaed9 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -533,7 +533,7 @@ static void test_barrier_nothreads(struct kunit *test)
 	struct kcsan_scoped_access *reorder_access = NULL;
 #endif
 	arch_spinlock_t arch_spinlock = __ARCH_SPIN_LOCK_UNLOCKED;
-	atomic_t dummy;
+	atomic_t dummy = ATOMIC_INIT(0);
 
 	KCSAN_TEST_REQUIRES(test, reorder_access != NULL);
 	KCSAN_TEST_REQUIRES(test, IS_ENABLED(CONFIG_SMP));
-- 
2.50.0.727.gbf7dc18ff4-goog

