Return-Path: <stable+bounces-200033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4702CCA439B
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 16:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B6CC30546C0
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 15:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3D82D6E78;
	Thu,  4 Dec 2025 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="QYKevMbG"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE4F2D77E6
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 15:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764861513; cv=none; b=llO8o19J8VQo1MLBRNYgY3iv4knoX1Rgtjsd8VzRuSDGv5ewpmLMxcSCyinNSfJR3PgSQM1QP6xy7r7xwxb4gG1N8QSTwJ/N/jHB0lfqmGmOM47tSABLyeAdy2H391opWcTq4QwyTle6ZSvBPXUYG3sn4tJZVuAvTP4YTdAdmE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764861513; c=relaxed/simple;
	bh=VljNe5kMd4ad3e+pYU1/5fLSVCmcsaeKxPnxedcvUQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qksaXhx2ilfv8/JcLZEVGMs4r3C37mHKb6SXxEh+yUXy3BySeVHloQ4rI+ZsYuO9vivy7r/iZk324MrXQGCdk3y9wZy8a2BjWzTEDi7jpOKNC8iG1WVOsZJoQaiM1Mw13KkByOxGePhzMqbcWBU4ZS1GlVsCcwyIdKTXotiLa44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=QYKevMbG; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b2d7c38352so234772185a.0
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 07:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1764861507; x=1765466307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/9FWMESgsQl8uoBJaRGwa5dScY1SoVkx5/E2nLopaQ=;
        b=QYKevMbGVzbkXmp3RVIeJAJtHfvGKj5WjZV9zb4OigMsmkb7Jn4p986c9QXvj85KVk
         vaKAx89u0xknvTwzEB0G72hdeFUgWCRMVooT9/VeYCSw4A5HVSDu3sHcrzsD/CRHnr5c
         6xAfmZIEy0nwiaXsixPR1yfHcTxnd3361RFBrfgxWO+rpRMjWGWKhYlNooMwcS/Wwzj8
         T2JBPQI94gzNGhDTi6HK/880E/VULnUPO3mJrAfcg40x9y6R6NfxsEX3Lib2h/z+3mGJ
         mMHDVp5cEjhDS3wnFTdFK7czQvKPSrfvzoOnBJw+Hkfl/qwP5YrEjbgOW2vJIuj8Qko3
         nD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764861507; x=1765466307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j/9FWMESgsQl8uoBJaRGwa5dScY1SoVkx5/E2nLopaQ=;
        b=SGTMtxEr+pComAeEE6ItSto4sCOSF6EOyIxwM3UdfDlwmdzUJxlD/1Zxonej//xUOq
         cjSvGYodESPzhAx2S4+24OgyZW4k5SuBiXymh03ldOAtauAMHh5uFjOXuxOqbXyTepna
         aK0Z46I2MhGDSaxhCs0D1WirYu4ySmRJ6cjjsLbYLtix4v9TdOFKb+LoDEi+apUaq8sW
         SUnDzhnKbsNtnac1vTaJsRegSJSVenZWrpHVvElRaN3ri7KaOLQd9Woy1taj3p1mMTFY
         2tZdPzLDn7w26KICjAWFQfbXFlCXXqX1T3V80uuq5042b55W+cm1JuMIZBdgAYnoSnCR
         LDdg==
X-Gm-Message-State: AOJu0Yyr/fAJhGp8Oj/7RqDqx4n6eKF6aMoLK0j8mp8yO+MTKhGZhX7c
	4/ciKKYm7ssmcel9zULRBy0oQgb90Nt+b7t/rzmgBI9kYzswaRO21I8NrLoE8XlF5WCN2PPna2b
	uHZKaeUU2qll2LJxL9QIUxlSEe6B2P5NwFmG0rNB3Dw==
X-Gm-Gg: ASbGncvcoBuX0OnpIQDbn2p1SIMyuG8EKyAA3ubkjfY4aUXDgu3ijQU3gTslNO3icc+
	feWkE+tMcAmOl/Cp9y50eWApkeLsd6Q60MkfEOCv2OYHloAbQch6PW3HsJzwurGhYCfSFH4uxnN
	XnDLz9368JN0K6MqVPSWYiJ2+NsEbx7qEIqG1LyK/jEvjzK/BcLCJsQFTl+gNV8nbQpTRl4NTMK
	j4s4MrtJSUSautnmuRPkFdsiFWoY1d1pcFGOF9UOL8eyna1Jd0lUwZ3Yhk10R5ywCFEh0gy
X-Google-Smtp-Source: AGHT+IGm02XUs++uw0N5zGWmXXo4/VUiNw0mAFpraa/ViGGwYBq+xKaSkX9JCx4Nux3M73pq/yF/AjNQk9F0NUbB/DI=
X-Received: by 2002:a05:620a:2904:b0:8b2:eebc:64bc with SMTP id
 af79cd13be357-8b6153ed26emr645155785a.35.1764861507550; Thu, 04 Dec 2025
 07:18:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203152343.285859633@linuxfoundation.org>
In-Reply-To: <20251203152343.285859633@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Thu, 4 Dec 2025 10:18:16 -0500
X-Gm-Features: AWmQ_bngTnQXvzs1qHGyxtus6wGI_96aRQmrOtbqZh7KJohylKIV3GIllDA8pmw
Message-ID: <CAOBMUvjGxXhw+QMBQa_NH8iQLJ7MUE-A3w0rzWGSBmj3j6PsOg@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/132] 6.12.61-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 11:50=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.61 release.
> There are 132 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Dec 2025 15:23:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.61-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds successfully.  Boots and works on qemu and Dell XPS 15 9520 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

