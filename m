Return-Path: <stable+bounces-26903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9C4872D14
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 03:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE82F1F287FA
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 02:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF60DDA5;
	Wed,  6 Mar 2024 02:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="gr9MzxY6"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DD3D53C
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 02:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709693714; cv=none; b=RbmczAXiXLL+t77ssIbHbvJ6c+x8dlEsFHalnkM6+cdxfzf7+bQenpm+/d7cS2jBVhWrokcjxDTutWHQuEV1ntiDxy2Ov5+LeerV5JGYseSSvNZWtEVx+Cn79EGqAUB4yEqcsceWAaj7bFg/vJ/VEGiL1DvDCS2Nztj11gnLB5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709693714; c=relaxed/simple;
	bh=GsRdJoaN6E/LLUOYDglle0uztnU6Sis59Fl7J6wutgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdAl6yBAQhLrHeDydNVmMjJzoIWDJrOaU9vP7xkuaufTGpXYwwOhYZRuSsTOKaWc0OtB9tRPNWp5v5bZRAwbrbKRoDwCNhDE4eVRQRBU+Xw5babRD6lYUFneZ07hYz+iaGJN0UOzTXQVAu22WrLLFx9HAWHu+wP48D3CQEL995s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=gr9MzxY6; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a12baba314so1796160eaf.0
        for <stable@vger.kernel.org>; Tue, 05 Mar 2024 18:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1709693711; x=1710298511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRMkuI014AzS1zR02MZc4IRf3TGjXINu42gGkCfeGs0=;
        b=gr9MzxY6didSDee6a3fcTJvshdgeUWuGOajnzve4ciqcfD25SrXInp+dlXNELYE01Q
         UmA2qeoHQ1EN/Qr6s1ZHa8D96bRKjIBndr+w3LksBg9BNKTaiiHMlXfd79jJNNKc/iu6
         +Zf2xH0ZnDnkqEmy1dPrhwnE9CSVRK+yW79DI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709693711; x=1710298511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRMkuI014AzS1zR02MZc4IRf3TGjXINu42gGkCfeGs0=;
        b=hpG+DUlbN4R2gCJhYBziz4q/cS6NoxhOggkGR9mTarwd5AV8HKQ+TrWehWLrmrzxQ0
         R1/P4BrgeemSE4vDY33Jz2Kj+zehsqXF8vrNQr8qJ/rLI7yr2xrddCh97DmbZBXC8IsB
         qrOfiDzE6PIh0tVY4mKwOM+4hNNhqARPfUW8T9bpU6fUhGhP9bkeI9E59U3d3fC+yDkM
         m0mlvESiSrzlzy//8IPKDOnnVevwlHUKsc+Sr1GtcJWrj5tO1m3R7XjQleE9xWEOK/Jk
         TStbUe7peKRFqAZHUIz4jDQB8a/4VFVJ0qRe6EwlwSE6JOcCOKRHHZvMzmka/HB1kBvn
         mmKg==
X-Gm-Message-State: AOJu0YxKplr2RfKw3A05Z6qD3/oI8AWz5mUF5Ovgkmj2te72oVVN6BUU
	lO9z5vw999EmQAlaAFaXkFHjKMWDEcfaHi4dEIT3QwVLwJPsCbRbFoocwsyEJg==
X-Google-Smtp-Source: AGHT+IGVQj4drpeLlqZu0UGH7MJF2dKwPJG+QIfz4rVWUgG8ZqQMiN4a2/ohEToFBsdf7vzvg14fqw==
X-Received: by 2002:a05:6870:63a7:b0:21f:17b4:3842 with SMTP id t39-20020a05687063a700b0021f17b43842mr3820887oap.45.1709693711394;
        Tue, 05 Mar 2024 18:55:11 -0800 (PST)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id qh10-20020a056870bf0a00b002208ea2347asm3245084oab.11.2024.03.05.18.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 18:55:11 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 5 Mar 2024 20:55:09 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 000/161] 6.7.9-rc3 review
Message-ID: <ZefbDbzbLpiIR-0J@fedora64.linuxtx.org>
References: <20240305112824.448003471@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305112824.448003471@linuxfoundation.org>

On Tue, Mar 05, 2024 at 11:28:47AM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.9 release.
> There are 161 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Mar 2024 11:27:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.9-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc3 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

