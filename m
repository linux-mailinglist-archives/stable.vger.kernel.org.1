Return-Path: <stable+bounces-161354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E8DAFD7C2
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 21:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D1E5801AE
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 19:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502C523CEFF;
	Tue,  8 Jul 2025 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="NXRpQhMA"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2E423C4FF
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004792; cv=none; b=QpaEwBoaP3tRjZopmb/MWFvZhtHJDrW0umDWLWUyMI+SaSPFFJGG+OoDzrr03Dtf/GnkWGmL0Ykeq67i0FYgMrEC1xlhkbOZRSTwupHABNEFHrijb8As4y7n4VYXzo5gOIzukoh2ozVJ9EtA2N7ZVRZobOMV4/U5R8OsAqdfrS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004792; c=relaxed/simple;
	bh=sKuB8RQnIfm8FxftIf3X0GOfjjaSkos0VBJiEDTBxlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+xmNf7qzvTRdixttU4TrVGZSq4FkOYz/8wiwWG9tTRRAVeVhutM/REWlWmX2m1vcJcn3ipEGkMrBn9kiBaUKbbBWETRtehduGLf1V6hSi7KH/Z8P4UwJAHSKiDrUXl2eMdjvUJXEOpHCw+fpU2Yy4o0A6FPqUfmYRELM2k0eFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=NXRpQhMA; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-613b02e801aso1374632eaf.2
        for <stable@vger.kernel.org>; Tue, 08 Jul 2025 12:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1752004789; x=1752609589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SB9GNWWsPYQTrcDwgkvbanghflj6Omk2OsXB5XCpSp8=;
        b=NXRpQhMA/FpyyK9ugKn2f54J29Fkp7plVmPA087Usg+7HunVn6qRtpXsRb8bjvpIJK
         xCN1s282GYJQz6nJBm8SsMwcAfPHmr2eOHatMnmK4rsTiBJ0jp7OZZGVPmlCUa5Alll/
         PduaT6o9ewKQ9eGzW8QiI67A5UMIERt8zLO+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752004789; x=1752609589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SB9GNWWsPYQTrcDwgkvbanghflj6Omk2OsXB5XCpSp8=;
        b=uS/UWWIQZ7vVFblhn+ZsTlnBF3nmT1VhQUYZWsUrSCyq3VW5+FQAscGbOXSRoMV3YT
         2+VLhw/h0+3e6owVwWM2PjdC4G8Qnbk3d80ZrVarfNV3sg6N7KvZR+CS/NUNdptnB209
         TUrfi7PTpNpmJJVKRxJ8nYstsYLSqhSx2gu+MsP6o57Gy/A53tyI8N6mqtDnYtgw03ez
         dtEfJtF8F1kKRfe8wqWDNsOj1+vHpiLnfvGDUxZZiHIKy3V3guElGLKQDw5lmE0u9+bP
         vDffsFy2jPWKqfalqYg+BeppdKhEsG2xzb0Xy0fY6hDE4hz5AoND66kqx3aoqLbWQpGp
         8peQ==
X-Gm-Message-State: AOJu0Yw1fjLJF5qe2tciNquKfJgIOGl/GGcWL0t6Aa+4BAK6cQE/jUot
	ALgXb4t8+hjNFDw7Ava+uLvrpi1C6qb6/cMw0Yl9OhPzvlPtv5iGf6loOkceaCRl2pxE9bqen/3
	MFDa4HA==
X-Gm-Gg: ASbGncvdiZRT3kw6MUMTives07OG6LaTPVf7PCekwW/GdzrMDd+WH/OQuWCj/ToW72C
	RxIOnCF9FBpNqE7jKM2a7rNTPqhpgQcritCWUYvXQnxXZmXnetByhkKrtcPmvYdpWfxb+7amSSy
	pXzlY5hVniBBiZ/hd0WWHD31dsQXWcPPhdNOqD9ukWobPqnmpvimbULRAwwx0VT9QMrOo7f/WYt
	rEJJD/WafXVSt16/QmpXSeiwOTWx32eJFxT6m1wYfIyy3csOBdaShZfjPydW8XD23HjChUmOoAh
	CgzstZ3R3vp2pAk3N4Ktw8qES524vScQc3u2eReIwvCicOV0wozmhWorr39gvKEE+OQdbD8SjPD
	KfDNnfr75eV7wNA==
X-Google-Smtp-Source: AGHT+IEtr03NSkK6ECFSDZy0Tth+9Bq9hzDGfXM4PYpkiHw9hwDD0Kxv/StPhidCcUjve7ewHnoJDw==
X-Received: by 2002:a05:6820:210e:b0:611:e30a:fa1c with SMTP id 006d021491bc7-613ca6b5916mr758011eaf.1.1752004789129;
        Tue, 08 Jul 2025 12:59:49 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6138e590c86sm1790207eaf.20.2025.07.08.12.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 12:59:48 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 8 Jul 2025 13:59:43 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.15 000/178] 6.15.6-rc1 review
Message-ID: <aG14r1ZicqU4GNbI@fedora64.linuxtx.org>
References: <20250708162236.549307806@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>

On Tue, Jul 08, 2025 at 06:20:37PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.6 release.
> There are 178 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Jul 2025 16:22:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

