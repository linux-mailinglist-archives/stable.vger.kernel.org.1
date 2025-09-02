Return-Path: <stable+bounces-177530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BD0B40C23
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 19:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A7C5E3D5F
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 17:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355C9345723;
	Tue,  2 Sep 2025 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="ZTQGMEOB"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24B5342CB6
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756834392; cv=none; b=s9xqyWU7vnFGFGtz5+yoOlCQlbX/Rgo2ZmdQaV0Qckk5ndW0ijoDnuXhWOMrYYnXHvw++/YQ5y06pYunKRsBef5Sas/5366XtgNGz1mS3ucJ5O3o32RZjEGeo8MpWYs5mEc/UURIfGNavmDnzofqWgAYy9nefrabz3zapg/EbaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756834392; c=relaxed/simple;
	bh=vSi44c+F/pB4RK/I8Cca9wMh9fClcpeVgwxtyoNWbyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSnXmmYEup42lozZf6irrqoi35+M3UKhUKUlRj6GUAEv6bylXPvEGHe0IPIbXZyX7A0i8YDlGb0MUi1RXc1W55RVeqj3bkMxFd4z6BbMcU5qKPBOEsnVP9YKk0/Q+fesQaEqD2OcXTeGdRgZVXesdRSDd4uZcxsZbnJNn1gGS+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=ZTQGMEOB; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-61bd4d14bc4so3110007eaf.1
        for <stable@vger.kernel.org>; Tue, 02 Sep 2025 10:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1756834389; x=1757439189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KTz2L9raB5dHv0DWKjVffzBC8rLB5luuA/g5XJUA0o=;
        b=ZTQGMEOBeZQOUUD0BINEUuNzI4YNSAV8XoGLMTjnuodGnvWE/d3GSA9ondjbDuP9Cd
         nB8gM/xgkj8sOsmBakH9UOetSLMhxqt9gumoF6M37AWDHxw6jJVEuC/z6+rqdq8gj3PJ
         u8tC/MVwywLeQpYP6JDXybn6jVTIcX7HUFgpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756834389; x=1757439189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KTz2L9raB5dHv0DWKjVffzBC8rLB5luuA/g5XJUA0o=;
        b=Ok0IxEJDJrhCN/G+DvBu5j/uGFGl0PW35eBWVV9D1FCdUHZNBaifho6ye1l4DormoI
         2U83CmS/nUW+GKsCYWU11Y01coc7e4mbeu7Tz8ooPUiIlex3TY+B40MFBYp1ghzzEvq0
         Nnd+Xbe3e5/f/5hCD5CvCmJju/ajm1BNTZ5yTqikUkhvGoFgbsvWsus1mq71qpyqGM/P
         hhbKc+VsdVaHZD6uhzSQJeWl25jHo1o3PYI0a4zUV+0NIrQ/G+Kt+UITe97xe2Hj9KLV
         i1PkmOiVfpg5NKQvFPmo1ave2S8T2hMxRDC0g145D38FtSEd+eMkdcv0PwEOOdGZZBlT
         9xWw==
X-Gm-Message-State: AOJu0YxlXWjBET+W8p9KWmA88Cl7lK6kfkNxsGhSl+5W0yPDa4Z34P5q
	0Suf6SQ3wgu7/blxjPDitq0COZIjOsL3VK8BtaJqQ5nxyuM1IKLcs+3TxhiR9oZq9Q==
X-Gm-Gg: ASbGncs5mlAqDuRXm8HNwNDXNu8bW37C1PXjwV4GO93zKUYxTwNAR5//xjN7qiK59FD
	N1DP+ZpE6Ajusai87qUr/SeVPGGR2gsyDtH0J6hDRoL0BWlBGcJofl+SuQR20Sigj+uB//f2j9o
	CDEEvndg0hlcIpSr5lh3l/NiOP0ecMUiCJlpdqlmuUEii4YWqTOOtWU07RP2lxnDVAaQSodIFpR
	g7xDmSFO0NneBICKrDa7xsV1rtlg2zodGYof5SPa72cV03EBIsxuxe9BEkirEGyEwXjDlqPpOGD
	jHluJURQN25WeLMoNASm3swFcUXyNQgmthdNIw8GKBD+FqD8wYVteVeGVfy4qQVZyDKohX/fEiv
	jv9wxk3qs93QcAgnWmq+K1dA1nqVOfs7z2e6H42F5a4BJ9l2p3sfXJ6jbFWY9yQ==
X-Google-Smtp-Source: AGHT+IEKZod48ntPYt/3uzppQZfzX++dethMHjVfzgn04A5ervfNM2G9qXouzn43QjM7p2KfwjeESA==
X-Received: by 2002:a05:6808:1483:b0:437:75ea:6c68 with SMTP id 5614622812f47-437f7db9457mr5956448b6e.43.1756834389567;
        Tue, 02 Sep 2025 10:33:09 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-745743cd46bsm1705070a34.40.2025.09.02.10.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 10:33:09 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 2 Sep 2025 11:33:07 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org
Subject: Re: [PATCH 6.16 000/142] 6.16.5-rc1 review
Message-ID: <aLcqU_rQeFwezfkm@fedora64.linuxtx.org>
References: <20250902131948.154194162@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902131948.154194162@linuxfoundation.org>

On Tue, Sep 02, 2025 at 03:18:22PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.5 release.
> There are 142 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 04 Sep 2025 13:19:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

