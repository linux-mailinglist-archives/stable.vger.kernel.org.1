Return-Path: <stable+bounces-61805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 823DA93CC1C
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 02:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 114C12828C3
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 00:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A055DEC5;
	Fri, 26 Jul 2024 00:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="Xl3hr6a5"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C136FCC
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 00:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721954134; cv=none; b=aLQ6DytFqBnK5LyX5O2Ju3YVqL62wX1drC5tD1ctKtM2gp7VDmMLeH4CHZCfLPmsQBU/yIrDa1WOlxfE8CrxLm1mxEkr2Lhvgm9hv1HaEZIJExJLWbP6and4MOIhTVb12oDeN4LJV9uKhAY3YLNNXtW7kgBk1sdXBPOyveX/pPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721954134; c=relaxed/simple;
	bh=gUHi8K+nRrFhm2tkVIoYdt2I7EROvpExxq4ozqWpWZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwFnyFS9mG2DO/DGBDPQIUtp1aZqYbhvnQv4B+OUbEdSipvSTS6RshMrrFP7Yxxq42QI+H9a6P0ab5j/ByNhiB3U8Z1Rfs5pcR3UGrVe2w8WEyiSh5GsJgY4+p/K+tKYYkeSAOMJpuNZ9LfYl3zh85uq5VJTYI8678bCkOxUhAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=Xl3hr6a5; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7f6e9662880so34917639f.2
        for <stable@vger.kernel.org>; Thu, 25 Jul 2024 17:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1721954130; x=1722558930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71USRuNTycixHdXXGZ4dVWpw2ONRzjhFib/VWt9Kxxw=;
        b=Xl3hr6a5OcWOnWnYrCpnOSkdCZ3AyMYxn5IN4CpH/1kL9dT6SffzjgTNFUMquo1sMJ
         U5yy3ajl0qDOLgmI6Y+dtsJE4nLSkwqxfSlD6kJC+uI3nUa4ElHyc85A3EoAgH4iYW/H
         cWVMTryXA/MQaAd0BFFKwFKW0+fLSeV9ESGA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721954130; x=1722558930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71USRuNTycixHdXXGZ4dVWpw2ONRzjhFib/VWt9Kxxw=;
        b=YG+iY2dCo6BB+VqegvvUJaPxmZQgyH+0kRIyO7+byoOImTuwvhcW6RrWV3+jr7mDmw
         2R3QWFUPdssFxhgCKyTLtgz9Nvadm2t6ByQ5uvOOH5w1dnne3IMhEhKLMZXeUZKIRa/i
         ndvwsKvQvz2woNPOyfTRYb2lyvbvT+6QUh1T4z5S7Tr8NfOAk9C4IGDjW5mUG8CQkgzW
         j0A9/3z3cIsboBrm6ZyYFGfJy878CEP6JR8FL+wzQm2ECguJEBcTpgsS5V76fw7xD0mV
         8xnefzh9XR+vsf+BSSjrG2G1ajC3FEXO2eRT/6PVOIt2dB3gDewpiGlWKR74UUWuDOwR
         j2sQ==
X-Gm-Message-State: AOJu0Yw2XivUsXAusyKEFbDKnEaKXlkPZFPmivnOvTfV2ehkEtzP2i50
	M58AoK0OMOAaaakRhgglKbSBTbtassL+h6NVdYdgzuhcpY3mYu3FWFCZTolO5g==
X-Google-Smtp-Source: AGHT+IF2kB/EqSqSasMOsiUttph/+3l/XoSlVhheGumAPP/a6+FfLUW1HgRH/5V2V6/m4a/hCuac/w==
X-Received: by 2002:a05:6602:1605:b0:7fd:5a50:b217 with SMTP id ca18e2360f4ac-81f7e3e5bdemr505143239f.3.1721954130477;
        Thu, 25 Jul 2024 17:35:30 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.171])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fc0b1f4sm607189173.129.2024.07.25.17.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 17:35:29 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Thu, 25 Jul 2024 18:35:27 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.10 00/29] 6.10.2-rc1 review
Message-ID: <ZqLvT4tAxTSmBYRW@fedora64.linuxtx.org>
References: <20240725142731.814288796@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725142731.814288796@linuxfoundation.org>

On Thu, Jul 25, 2024 at 04:36:16PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.2 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

