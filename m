Return-Path: <stable+bounces-147997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE90AC7140
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 21:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2A0171B2A
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 19:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB8D218851;
	Wed, 28 May 2025 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="V+waCASj"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B021D1F463E
	for <stable@vger.kernel.org>; Wed, 28 May 2025 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748458862; cv=none; b=m7DCd237Rl54+BZ+vnqsBmZvcB8+AYhbeu1PiEfjbpPOXX6KEE92jNiST0oee5KP9J2K/obVR0+V4YbbpquICkCIJ+6F2/0pheUxiKutRfLQUDB38Tl+P7rJQYtVr8lq2S+5ublGgdGRAbxBSlAWTXPxDuKzUTD+dhdVpmzKpxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748458862; c=relaxed/simple;
	bh=99lZxN5vhS9pT7XjyafkDptBxd868nvYUBqPecl/XbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHJ8P6gO6WCjLSaVp+GiJQywU+UIcJk1Dt2Ebkm+7fJOMM6g+fy1LBlmCZIjwn+gkqihN3DxcYdM9azjL6Pe+5AD1MnnyH697QaySvA8GVRaoFKrsWsW2wu25N26lbcg4/TC6tQOJchBDZTJcW34RXjJjfUCuMLr+YbIh4bBKGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=V+waCASj; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3dc8265b9b5so943785ab.1
        for <stable@vger.kernel.org>; Wed, 28 May 2025 12:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1748458860; x=1749063660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6uMWV3+sb1xZHl//TOe7Sv20/rDXHWApZwSoImEOEg=;
        b=V+waCASjWLzl/GEBRfbNUVhOL83uvHoAfOinIr53OEXjAYzr2pQeLXf2+XrXKHX8Kj
         ZJXlbd2MpPmud9yls9r+AMhVwhkHNjzhJa0DOb5Vw9Tp6JfeYiNg0m3fw7eH/oUIEZpq
         inUBEBw/u9CV/hRPrSVx+038rHT1SfDgKqCrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748458860; x=1749063660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6uMWV3+sb1xZHl//TOe7Sv20/rDXHWApZwSoImEOEg=;
        b=V6V4aTaLL3ReG5PPTXujJOOBqU9ydEhY/iONPPfAnlkA3xoZhlJ/BuxPomdILwTTjq
         lcFbI7BR7F5h8Vu448mq1ne0LwU6rGEEeizI1T1If1eIIeLXGjiIzCOim0V7ofSBYh5j
         DxmrdsW3YQdNcBuDsJfNpJ4zRT6pUbdd0gLO3oQJnuDdg0SFAh89Q6Hytt3WPZHl9TdG
         Lng4NeTTsbLlgml8ytVZ7ADheS5mEcVWL4vJ6Y9Up5/3KEBGpFL0pjEtv6BoX9ZS6OG9
         JM3w0OvMRTsNj0XV1dDcFOptK9JDr4WLwtr5/+uvqeq1pUAkaRiYIJSQzUhbTXTGGXxm
         LPTw==
X-Gm-Message-State: AOJu0YzzXxuiOkyNpGVDd4lqOrCIqb2gd+GJwkvRUD9NatsrYN3PYb3x
	p87w3OScdlg4QIN6oH7K+bc8UigRWS69iog0ebFo1ixihUQboYFrIEudM+15nA8joA==
X-Gm-Gg: ASbGncvDChOMuFCZk3bPAYMXFNwZ3X1BR98aEufx5zt+QQ1EVXJmAvwhSluf9HIxeTQ
	QaqZ0OemBWYEXZWICEyrvJsbkwgYL3zhlFXCoRbG0PrP09f6pNr+iAwxkRjn+eyX9oKpyBkFj5o
	hzQOtccfKGobHEbqZ/8/ryB5lqe0KPD/v9/tCQM7RLoUZa10QsEMzamYYjGpd9S9wNaT5SDXs1u
	IqDA7il8G/3+pqxCNtLia83ejQCA1j7Ixqxa/zfu6CFWH6ev0fcYr+Nd/p8eBRU0oirYY8yOzg6
	mzL07cFV6XXb90Dmg7PcKFY6TCn132Pt5aYVE3QNmQks+zCkGfwFQwAb3YeYD6js2WYi4ucHOnM
	/KIg=
X-Google-Smtp-Source: AGHT+IGO2PTzIAqkK41ccV62UVml+KrtjC/CCurWR884MEq1rueZvDmtfrOp5qmDL+URey90IDvSbQ==
X-Received: by 2002:a05:6e02:1786:b0:3dc:8423:543e with SMTP id e9e14a558f8ab-3dd8b044b9bmr36739375ab.17.1748458859626;
        Wed, 28 May 2025 12:00:59 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdbd58790asm341459173.95.2025.05.28.12.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 12:00:59 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 28 May 2025 13:00:57 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.14 000/783] 6.14.9-rc1 review
Message-ID: <aDddaQGen1YUVCYz@fedora64.linuxtx.org>
References: <20250527162513.035720581@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>

On Tue, May 27, 2025 at 06:16:37PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.9 release.
> There are 783 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 May 2025 16:22:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 minus the broken "s390/crash: Use note name macros" patch against
the Fedora build system (aarch64, ppc64le, s390x, x86_64), and boot tested
x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

