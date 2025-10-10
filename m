Return-Path: <stable+bounces-184032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C518BCE6D7
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 21:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91F1404027
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 19:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D7B301471;
	Fri, 10 Oct 2025 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="AOV4GLcw"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7413FB31
	for <stable@vger.kernel.org>; Fri, 10 Oct 2025 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760125883; cv=none; b=El1DVzVuys6by3AfMRzA1CZOYG3nvMljKGQKL4Sc7T0Rs5Hh6ce6GAn1S7j0U44jyaiAZTVXlj75RHWuqpvxbTElPKlU9T/9EPTTE648DPCNkiOOeEsVn0TFlZJZCW+5U89fnA5cQZSMUvd6LSfL7xID/3HeUv1T8bQhNkKWyuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760125883; c=relaxed/simple;
	bh=3GdRCdkK8i0HMt2ysyFwTb8cfB/yNxqn/yGQquteeC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbIhbQRXXPPku9H4eCTOohjWxVtVP1ZWEg5rsM6NktNBTs+gfO9C4nz1YFPdxIV6MTO9vx+0KNvhRkvzCndg7hMj+ZKF+aG6l5iEnFQiMiEeOeTjgOMu4bam1vBCtbL69k/xoJ7xs8cDwExogwiHd3nktcasF+jUZsnqIn4XGBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=AOV4GLcw; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-36ce5686d75so1709087fac.3
        for <stable@vger.kernel.org>; Fri, 10 Oct 2025 12:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1760125881; x=1760730681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c1mBRXfD6aVOZGe7ISkRTaKXlOb2UVmCyJNswlIaWLo=;
        b=AOV4GLcwRuut5H7EKUNgZJ9KSAEeh75K5SuCG3DlNYjDsvM0X8pepffq+vFPBbpAL9
         u6Tu/Tgj+X+gJWUzDGd6mT9/wPvp/1rp5ZCcPDqMh+8Fz7ntEb2mibnNdvyBEDNOHyiC
         HznZGz0gug1Otc5P/NU5VOLA7cdpFtm08QMeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760125881; x=1760730681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1mBRXfD6aVOZGe7ISkRTaKXlOb2UVmCyJNswlIaWLo=;
        b=VDu9sGPFX4HrjoOl6ljZh/OU3qqcb0WpQ7C3T/TRVuoD/J6I9RSZ2aLxUxhLyF7SHa
         cQpXHtl+2yhj8idw6AwMCT4ccMl3e+8HOt3KV9Vo8bl6p62nIT9zp6p+Omrg4pOGhUm1
         TnOlnsSt8lFiSeQ1kJm41JLfezOrn5prUjBZdfAa4LtaWYJXEoQQbq0GyRw23F2ecyJR
         EAyFHjZVLhMEBNB7ZR25mQkIRtsYxQvH6Yuzibt0/psBaBkThYBtBRqLn9e308EL5z3+
         9ja/5fM6WZ9QT027zORVy+kuCHzVyRo11tlG6+aWgDPiEzSdvDsoSM60s74uRUNTI4J+
         O8BQ==
X-Gm-Message-State: AOJu0YzZEMKRfOHfcLT+Fn6Im22tR7YnNqc5x8d9Yopgo75V45E2QR/R
	zp7FxO/SeVe6OOAvvtHCXSUduVr+V1nZ7ciN/wUyCtGCmsH41PgMzKlesvQE03WcCQ==
X-Gm-Gg: ASbGncutIQZw1MaJilQtEDquv4r0XwDIkP4uAOQuWKMtVkq/4fsSyq22TEecwxhu52v
	Mw5WjkuMVgbpTWzoSz3E04zt9PLEO2DiqHcEtEMmxbbUcOUmtMf4WGBeUwpKyTj7RfbRdLVkOPA
	A0geI9x5uLQ69ttMBxZWRBQ9wxQgZAmX+aNriVwAO/aMh6k25GVYo/Bkp1aqAAdkomp5FEyG6LY
	iPvQWTZmQPtuayYL81Z2+RvkEfZG1obF7Tb0Vr7kHLW1jRwjxYy0zcjSoKChl9VFMI/0ZsjCi5L
	kLkuXz1NnSWEVow/TqMrGsPnyofCe8f1yHLG+r0CxQGAELhsWcDEcEghUahRsjLHjjXebe+BIwc
	8002ZvAfIKWug5tSeBO+66dNgUeWTodFVbnVYf7bzLbvsO0HBwRk2GCGNo7PG7Fc=
X-Google-Smtp-Source: AGHT+IFwv3HVSecz/sDwYByfksZk6QFqC3jm2lmV0c+tXg//H+sD+6ELezVqd8mcsaWf1Db3uhiT0Q==
X-Received: by 2002:a05:6870:a189:b0:363:d16b:3af6 with SMTP id 586e51a60fabf-3c0fa962b9amr6908046fac.47.1760125880727;
        Fri, 10 Oct 2025 12:51:20 -0700 (PDT)
Received: from fedora64.linuxtx.org ([216.147.121.221])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c8c8f653d8sm1153620fac.28.2025.10.10.12.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 12:51:20 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 10 Oct 2025 13:51:17 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Subject: Re: [PATCH 6.17 00/26] 6.17.2-rc1 review
Message-ID: <aOljtRKkIwc0V6FS@fedora64.linuxtx.org>
References: <20251010131331.204964167@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010131331.204964167@linuxfoundation.org>

On Fri, Oct 10, 2025 at 03:15:55PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.2 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 12 Oct 2025 13:13:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

