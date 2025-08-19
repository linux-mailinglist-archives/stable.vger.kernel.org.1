Return-Path: <stable+bounces-171843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3094B2CE68
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 23:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D485252B5
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 21:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532E43314B1;
	Tue, 19 Aug 2025 21:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="Yifq3M/z"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2B731195E
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 21:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755637895; cv=none; b=P365m/RyXbWcaqZYrk4C0WtCQJ1ib3GgAamsHQTlZ+uWE3D4BU5WLw0iYHNeyiBu/6BTyeAJ/7s5V0XPuEFZG/Zm0Rb+pRcGnasZw2uyKO28vATofttgHZPbfcvRnGhy8SPLN6tHH/t30h8+633yKwKK60QgPYXN5n0TfercoXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755637895; c=relaxed/simple;
	bh=I/3mWa+i3KERSamxNOpw1Jf3cJLvxbsmqYH+/Lbkfpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYkDaJF1UHjDJE38Yqqx+8xR8ybQuor/Kt+zAQ9nb4YsMEjgtsKN5Z56fueiIgayovZ/zOtoCdQBgXCzuVUjdzOgkIZE/CD0UpKmUNUatBbROMJBy4XwL9w2xdQ8Iby9zUfQcINS/tMslNroKJ9Z/tdDVbdXeZNDsQZCzWsoxIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=Yifq3M/z; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3e56fe95d83so30291345ab.0
        for <stable@vger.kernel.org>; Tue, 19 Aug 2025 14:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1755637893; x=1756242693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8q+y1CzQiuYlKsWREpLAsdkMHshX9bTedI6C92fr3gY=;
        b=Yifq3M/zSRlfatR3JssW67OH7k/K2Ae48tIlVkEgC0gGLG/hNlFPrLa148RQ0Yg+Sn
         CWfngvqcNwaQOztV83d7Sy9TZXhhnVQiZEQH7Qq62LdCnwqbxGy12U71uMWP3beMLRfd
         mwERt2kB58wRlZg/Z9ggZBLSrOoxgnc6lPZNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755637893; x=1756242693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8q+y1CzQiuYlKsWREpLAsdkMHshX9bTedI6C92fr3gY=;
        b=VaDz6HAjcLw5gHUhUREzSdSTqKfrJo0equYEfkPhSm/fOuF7sXcJqZnnHQkXqVLjYw
         4tyL1S7ccWrs9ijECKFm9755RPrwWy6GZbHGFGmJ2xEQMGV5yPJcK5GFzUjLlCLb+g+p
         S8hcC1TPbkr4/3t6B4/mcSz6R9GwYag9VtnRSXxwQtVMc/VWCk+Mbsx3H6DyarD/Z7B6
         ruSJLVDigYM5Cr75KmnEcTv4TRk+o/pkaIlXWiMo4avMCjCYjxdXDal+2krapitgyQLA
         dEGdUGe1CPikBwk1mSNZOL8x7EhPAiAX58GBQzTFhC187egbtG1+GdQA2gOS4WLj2qMd
         fJ/A==
X-Gm-Message-State: AOJu0YwFeDu9wiw6PAVhcZVA4eTcd/ghuhZxWTvybCR06D3orTlsvMx4
	TtGsYP47Qp0KS+KRV1ckE9caIfk1gh/8tmZr5SIbKzs2L9gkYWuZcOCmWLnX3Adi/w==
X-Gm-Gg: ASbGnctTrH8o/jT4yglgp/rGVMq+GBZuJcUzDn/XXA3WKZqTBA8J4vw2vHF0mKdrRTB
	pOyRVbLVwTg1bSQ6A00TnZ+8sm2a7WNbJ78RwjsT27MRl/A84LdcWayYbt9ULUZ8CJnUZ+RQDUf
	aEZuGtkiGZW7bTuILfLvTbkXMc2wV1BDKlSHTO7dbw1HGG5D3GZXRMVnsev8pkBt4QYvgaVbyzT
	h74ZuH4rE+GHqE3smoMZ2WbwdZEccIBpcd22ZaAoJhj+rHS6HQ3VtfH/bLIGMHKURyvOpSszgCy
	yVDuaLSSrTfHFPk3MQsxE14U5SazPYPB8XPpl8dTarFZ9baupk1T01sEs4qbzXVotwVuVqL+dG3
	oGdL+uwlGkVpMwWscs0qq1puERl0PLgw2jd8NVxd84gzcfSEIzyQ=
X-Google-Smtp-Source: AGHT+IGTxbTK35PyIo/Fygy0tLFwzQOJr9aOpFhZb3m3EzsvuRZ9OgR3OsPMRlr1RPLn5Tpib1E+6A==
X-Received: by 2002:a05:6e02:380b:b0:3e5:62a1:c9dc with SMTP id e9e14a558f8ab-3e67ca67d91mr10240565ab.12.1755637892657;
        Tue, 19 Aug 2025 14:11:32 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c94a2cca0sm3719083173.86.2025.08.19.14.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 14:11:32 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 19 Aug 2025 15:11:30 -0600
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
Subject: Re: [PATCH 6.16 000/564] 6.16.2-rc2 review
Message-ID: <aKTogt5fSaCpbeZb@fedora64.linuxtx.org>
References: <20250819122844.483737955@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819122844.483737955@linuxfoundation.org>

On Tue, Aug 19, 2025 at 02:31:49PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.2 release.
> There are 564 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 21 Aug 2025 12:27:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.2-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

