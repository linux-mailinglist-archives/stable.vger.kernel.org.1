Return-Path: <stable+bounces-35607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD10895579
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 15:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 596FD1C2147E
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 13:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442F581AB6;
	Tue,  2 Apr 2024 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="LbRVt0x1"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A24283CD8
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064798; cv=none; b=d2AVIdKODE+NZ55KL0wl/xg0sGrM9l8d026wCK3mKThF4OZXyXxoS18pqHz0x0a89yb73O34KCu0FRrOLNcQ5VpZ7mmTb/YuOe4MOFQkjq3Il9Fq10k8MTQuUJdqjCnVL2Q06RXVEDCk31CmmMlmOQ/u9OvTGM/ZWDPDLEGt8+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064798; c=relaxed/simple;
	bh=gRjg45/IctrQIu/6W6PlRyxAxtvj4BHh8gNS04jmN80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JALnUtjjdrMzrvALh0RUPPmbZOfAVR9wnxl6oIr2KJyM8QoKtbkCiVFIyZ7fw2dyOJs9ZiusHHrUGBwP6xV/sW3vS78Hnb0IOpFIF1htG+hFdHM7gIDL4Hf1zpN20EKeySJHfKBQwWlTEmpFPKBl2p9CdtqvOwqxWgOKfRIltTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=LbRVt0x1; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-229b7ada9e8so2318669fac.0
        for <stable@vger.kernel.org>; Tue, 02 Apr 2024 06:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1712064794; x=1712669594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAhsn8hkNoKhwwl/nXRKoYjZr1I0J1JHEwu/MNqQsKs=;
        b=LbRVt0x1C9hi5iANBRK9MN/bfM288DlPlCzjRPd0TV7RIq22797nX3eiLkdR58oN34
         MzHyMp0Hy3gZapUhsC6rZoyURuTenNZNxD8R7/XEpHezcO4W2y1ngbuNw80YTaBL1bQb
         H6LPPKspzLCtVom17oqQ+GVKB94xL2sJgqUME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712064794; x=1712669594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAhsn8hkNoKhwwl/nXRKoYjZr1I0J1JHEwu/MNqQsKs=;
        b=qMP0efeBRTokl+tqB3dzhrr+CuJ1EOWils37rf5P6A0/IiFpJ/pcZcBSzJOCGmx7G/
         wwB5SQoeenm/8ctNalYXKEuevpu88TJj8K4lojKX3AQILkyASpMArTQHlxXmQi5vsue5
         SexZJrkRV685vZeW9jqqpMT/10woWlOWJgkKtSc3Lal/lYeEYhbhO1NFa5NemuDX7JqU
         GAumDEly4wSJrHoagwj9sMWdlYzfL4BqePZosm/Iu3tJC/k+oTN8jO6CULQtdqRMZvGY
         BXfB6djV5vz1HcMZyKzhazHj0nco+6NDFewC65ZL5FD8DqcGZC8tQggBc3D2bsK2dzaq
         icAQ==
X-Gm-Message-State: AOJu0Yxi8phGwphey34oPl2gS9saZ7PBQYHf+m1L9zXVk4DNYLJKaa54
	kFhl8KD331otfz+DJjmCceqPDPTglDeNCHAaRyiJEw7EW2ABzVwwIpG9bHy1Fw==
X-Google-Smtp-Source: AGHT+IEmdktlG/bLWeHAf98nPjODsS9Xnop/ympsC418g2OXevOGyMcq9kJz/Ps+yK4aVORa+/luiA==
X-Received: by 2002:a05:6871:7411:b0:22a:a11f:5513 with SMTP id nw17-20020a056871741100b0022aa11f5513mr14486738oac.48.1712064794554;
        Tue, 02 Apr 2024 06:33:14 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id qb9-20020a056871e78900b0022e89cf40edsm28077oac.57.2024.04.02.06.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 06:33:14 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 2 Apr 2024 08:33:12 -0500
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.8 000/399] 6.8.3-rc1 review
Message-ID: <ZgwJGDNx7vQ0_CrB@fedora64.linuxtx.org>
References: <20240401152549.131030308@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>

On Mon, Apr 01, 2024 at 05:39:26PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.3 release.
> There are 399 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

