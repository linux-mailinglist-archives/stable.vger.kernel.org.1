Return-Path: <stable+bounces-206056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 907CCCFB5FC
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 00:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4988830900EC
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 23:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3643309F13;
	Tue,  6 Jan 2026 23:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="V0qLj1cU"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5172830F53A
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 23:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767743016; cv=none; b=rx2JD0FFPFLalj5/LsbVaqqzfgpyXyEeGLXdaS4gwjgByIPEZs/uUMlw7ScCap4yg+Xo8PIDJtAqJTYEjYdwbvriZQBoeH2oE9b832x4/T+Ba/VlpNOujaUlhtGrWhwI1cdvHdSs5LvpLMbOQoOxxrWmqfwNa4PnytQkHTg2bfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767743016; c=relaxed/simple;
	bh=VGkLebrf2s0S0oSkDIbSvJEk7DH6tTHXsiTFxBucxho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJx8QNeIz8re70C/adFlvaHHPL32IRl6ICef9nE6J/8w7vMpyYyRbbAdpBPsuUscag0ukOdsYCSeEQiu1sbSA0CK/qlZgT+Yw43J8xvIQRFZPWbqv5XZrELWIeY47kpN9027KgFbxWpUKaXN6R+OWQSjmZOjMnQkEPnL8U8nsXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=V0qLj1cU; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ae5af476e1so194969eec.1
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 15:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1767743012; x=1768347812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iriy/jTf6gbGO8cBymtUQpIhVVJMny9RNybfpndFjsg=;
        b=V0qLj1cUeHcl2cCG4wzH7YyKZ3KZy6uVbdde+WaqubTuwhXxlGaq5G/pWfPwU4e+TK
         aH15i+QvHsLNrq8JEsB3Yg8hlYrGCGm6fQPzRnn80IF4OEKlxRMXfi68r1Qow+nVvwIp
         /dOKVL7bfE38GyVVg8KUiBPtnRLn3GYNtI8hM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767743012; x=1768347812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Iriy/jTf6gbGO8cBymtUQpIhVVJMny9RNybfpndFjsg=;
        b=HBgG3hBGjYuk9XOUv/dCavjy2gGZNS/XENr2l+h5bzSI6a3M9scUtcjRb/vt9+Yaci
         5VyBpGEc4/PNeDJI9uhYA1I94eyWAWdcTD+XALcHrDkQTr+SZ8xNbuTqA/bqmbWRLLSH
         4Vz/fxkn+PymRsrEFvssnxJ/vXtakFRrzKwnKI8pGAc6zbSjL/xY2k3MGN7miI0mnMkk
         1iSciaorXCZxsFkertDsMQbijwDiBroYnaj3AEmj63tCmFjV+/zDfNE0wWiFSgKNF9l6
         knohp+zYxeRqlKsSfYj2HIoLb/7+RMkdsK+bAlqgn+AQoxymLjLwXRcEHBuMTkY9zjGc
         n9Tg==
X-Gm-Message-State: AOJu0Yz307+qNF2DLve8j7FiQhVd0WNSx3I9DLrSeY/+r+lY8e0AGKAi
	Pzfth8QYLsmyzW90xN7o/Q4Obf5WWskYGFD5j1zWsWkDKs6QI6oMhW6q+CcPppYiaw==
X-Gm-Gg: AY/fxX7+1jpbgwlNTCu/L5KzPkJazQlC/OD0PQaCoWlZPlyHnVTx4dTDdh/27L5zHgT
	i550aX4Su0yAXQth+TyErgCphDJxpeVUDdpP0yrTuwsQLwvH6roLAHd/vkGV2Ntf+WAg00ssbnu
	r6/jlPlW9G6USp71ikV76z/DaeZOU348iy81NJbTwPoWyTBcsDd2Ri+WsimxaFtD4VNwS7Zvx2H
	CwDu7ydw0drHuyP+4rDycr0P/xrfDAvH+d+3B7wJ12V1YVq41EwLQ6j68tZNgG+UES12lL2D/zA
	CyQhU7qi2UB7AT0u9rbT/ZWSLkvU8kW8T/Smrj7Ru+IdOpjXrrrx3AlY7RC2zM+f5i9lvUr+Ti3
	BWy11pkKz2KbIm6b8b/6YBFl/06ARWRS41Noblas3b8q8qmivy0vFyVCMCpkyDELbY+wWXFNFwR
	5QrQTjZCIqTVcBFqIX2ctMQVm/ct2UJPLM
X-Google-Smtp-Source: AGHT+IHyuJEH4V7n4G0qnmsZSEUoTz784nvKISSfOirQNW/wrkNx/kkN3iOrWhsQh8ilcEMCxYtxQA==
X-Received: by 2002:a05:7300:2205:b0:2ab:9d23:f0b1 with SMTP id 5a478bee46e88-2b16fe5a446mr3385737eec.13.1767743012194;
        Tue, 06 Jan 2026 15:43:32 -0800 (PST)
Received: from fedora64.linuxtx.org ([216.147.122.116])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17078ccf4sm5457537eec.16.2026.01.06.15.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 15:43:31 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 6 Jan 2026 16:43:29 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/312] 6.18.4-rc1 review
Message-ID: <aV2eIbaO_7WxXjb7@fedora64.linuxtx.org>
References: <20260106170547.832845344@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106170547.832845344@linuxfoundation.org>

On Tue, Jan 06, 2026 at 06:01:14PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.4 release.
> There are 312 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 08 Jan 2026 17:04:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

