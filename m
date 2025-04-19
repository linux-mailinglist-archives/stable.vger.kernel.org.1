Return-Path: <stable+bounces-134659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02073A9408E
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 02:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 884F7444A5C
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 00:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7279F4A3C;
	Sat, 19 Apr 2025 00:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="Z9GjjmTJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BDF801
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 00:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745021648; cv=none; b=bbCqO2+Zs0NRChOd1eZOJ6i+H4UvMZPsRTm5hJ2WI2tHv4z49lWMZmjaMdQW5U5utsUGD7tUW84QeEB6ySRGTF+X5G4+KNjNfOkcl6Fr1Ey+szRSoe2GvT07ByI16DWFZNNykGsdnz9QueVp3sdnrS6UGvUE2DqL8aDzzRue0e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745021648; c=relaxed/simple;
	bh=yJgu/Dhzu0IBN3vhc2eYs63bBunMr5TNjKKesXcVz50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfxsqggPuTRKJEUFZK/QglSfduJSgHrOrxcoLDbjbsNBC+hF3VsQVKEsfuUJPH2kjNQLwbxrX4owbYCov8i/JaFlyU0yqAU2CJbDaX9xZkOTLMRtvfvx0ugN3e+Mpa2eS1W5VZIIQELo+tDIC4mS2FaAl0AHv9j/nLJVH/c6pxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=Z9GjjmTJ; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3cfce97a3d9so10094495ab.2
        for <stable@vger.kernel.org>; Fri, 18 Apr 2025 17:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1745021644; x=1745626444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOeVBHov7VKB5DDUBSqDYO930hNH61XeY5sxFZIOsKI=;
        b=Z9GjjmTJnxco1t8HWS0jfbLwB81fuxCvphOSpvd58udelglWrIKfIY1H1LvR5dhJNj
         Opo7JiOXdF+KcEH2uImJ6AF9VspdXrLlSeuJ3VZEU4vXbUDWcHMsDdnmOSciHitzo7d3
         shHxoHpd5xns4MtaMFCyMT4uAIw3cKr7PaGL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745021644; x=1745626444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOeVBHov7VKB5DDUBSqDYO930hNH61XeY5sxFZIOsKI=;
        b=U9D/e/LUIzdo+K0tz3QZhWTq0ZZ7hBClE2gjELP/TpWmKqdZIE67pHna55y5pc6EhF
         nH8GbYP0OHGmrV/W3c43ffkqea8PKgpF0S98CHGdZYYy1EYMAQ2qvnERAwNH9mJdAOe2
         x1mhMzVr1tZ40/EYygjajoXQoOU4BIKsAUA5dDoWb5F4860Yi8MEiX44rTjzcZN/kBmX
         jtFXGe61TnhGQ7x0yzxvSk2LGoN8TaKz4L0tlhkrOY9+CNaNGLFHesksd5S7bgSlJ1Po
         jqVcBkUrbsDaDzsLYjnvNyc4ko6lu1ZorXcunw3hqgrOvUfdKiLkJvBveA+OuOwCp4ax
         Z0kg==
X-Gm-Message-State: AOJu0Yy55d7HJNWdOdO0JJ4NPNqQpOMZsTILLmASRoIGDwSQ/9y72RrW
	w3iF9zCJuVd3Lr//30i5Lz0DKXcLtRUuYZShCFI/c0w+pRpIgiaQzuIix+s9Cg==
X-Gm-Gg: ASbGncuhMZUoM4TkRK2Qh+nTkEJEeW2Fz9XlzkNATEQnjCpjprhmZnaJm2BKiKsCqQf
	oDu9s2X4z3FezhoDxmRhC5uqGrwyi+mZYgbsdUwDQ51r2IhomICwSt9lPcn1nCk9C3AZpNBzTm7
	ZPPYom5SCyZOo2vjxrYNQrXV3X90kI3M4i03ungk0Qy6vd8lH3M4qljnbkxVLOFDKH22e5o2AsI
	PsUkaJELJKLlCAb6HC5zX/cc33uprBgPz/cwYQy+ofOKTtBB3t+AOtmWsR4WTTfsyGxYE92H0s7
	1RpcCtZndA54KU2G0+CBVBc0lOxmsJhhjlozhYK0aahUODBw+VxmQ9P/2Q==
X-Google-Smtp-Source: AGHT+IFOJCeVjmoBLR8EM84DP/SEvCgRXJtSxJ6KIQXOM7wzlmTfsBHJKFO0ZpklJTM30Nv0Ca+1YQ==
X-Received: by 2002:a05:6e02:1fc9:b0:3d3:eeec:89f3 with SMTP id e9e14a558f8ab-3d88edc338cmr41184805ab.13.1745021643992;
        Fri, 18 Apr 2025 17:14:03 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a37f934csm682098173.49.2025.04.18.17.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 17:14:03 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 18 Apr 2025 18:14:01 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.14 000/447] 6.14.3-rc2 review
Message-ID: <aALqyf-hy4-_K8f5@fedora64.linuxtx.org>
References: <20250418110423.925580973@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418110423.925580973@linuxfoundation.org>

On Fri, Apr 18, 2025 at 01:05:27PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.3 release.
> There are 447 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 20 Apr 2025 11:02:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.3-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

