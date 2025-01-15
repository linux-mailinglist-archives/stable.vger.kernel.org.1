Return-Path: <stable+bounces-109169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE86A12DB0
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 22:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F5F3A4C6C
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 21:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B611DA631;
	Wed, 15 Jan 2025 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="QX9pwi/2"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0D74D599
	for <stable@vger.kernel.org>; Wed, 15 Jan 2025 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736976566; cv=none; b=r/ALeLyUOxc5fI0W9WFGu8OSdp3c6B2DlJ4zcYI7lPtULpbVhU2N/Tx8SUIUEjSEJGM4B5CUoowLuHIsJs2fg7GXBxKYrfv8Bp97ho8eOaMb2ZXR5HeaLVYebzqkkrbBMsKCRGycb1gF4dJPyI3YLxbOxyJlf43qFTwovS+bPrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736976566; c=relaxed/simple;
	bh=RJn9wLLW+Uqm3UXhw6lKi+ALKeUFLR2ponMqUsUMxF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPzcU9IYsE8fXvPxWe7zkhvpDY4+Gvd8CUixIjNzVFnmjCv1wpwzpdb7jtf1As06DVVdrEPWP/5ZfLbPjILjJw58O/MsvyNRkge/8SGBYS2BcMM+7hpIwFsWBLJCiHOT2eS9Xsnv7XAVZsu614gpJYazo65C3HFnBJ2D+RYUXJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=QX9pwi/2; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3ce886a2d5bso1704715ab.1
        for <stable@vger.kernel.org>; Wed, 15 Jan 2025 13:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1736976563; x=1737581363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMxRqVKC1OS1+OO5j00J8Q528QAXBH6vrdlisTHHjvs=;
        b=QX9pwi/2lQjy7/CBlHPjwWFpqaCGTw1WbRLPVcZJQfEqu9G99/Cbgix8rVS065xE97
         y3EIg5pAZGhwM0CIkTcTfJ9WN+qm0QtHQYBVYIJBwiPhj26gGjYe00xYXQhIHrO/2RMt
         nO6DMdjc5sGIZkcinG1D34VAiTJoLH/BVXywU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736976563; x=1737581363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMxRqVKC1OS1+OO5j00J8Q528QAXBH6vrdlisTHHjvs=;
        b=Cjc4uFhFSLH6TaHCctOWL9GLjeknbbtwyO44vCuQwaG5e1CtNvPMW3R8erypz8KlU8
         IuNkRIa/TU11UwqfSzkwu2GND0pexYik5Nf0QMJD+dbyeSIsdo09Ahr08cYvwWcERKaq
         5lrMIclqAB763Tu+ymOhhqoOkzqSwDy3iMX+WWD5jl3EoEpVC1KcypMnQ1+7h9A3MzPg
         Mp/G0eJddhL4VQvP0r4qc4YJYhJcf309FUgq/d8rMIGfg5M0CEL1UB1ODPUaOYM2atWJ
         3Ivo1uVBPOqtKl44hKHfYI58JRkALL0OnaEJMAx9ayZTGYjnKD+6toc8Vtqd32LxIIKq
         eDPg==
X-Gm-Message-State: AOJu0YxjTwnZgTeq26+fu+CKVUjWxQAR9hHgHlsa6FLm1hnKZGYSmNiB
	5YlkgBdDHEc4SsX3i+wF2MetHs2CEhsoyUHIWACD701xbbFVh98DxsiyhBi+0g==
X-Gm-Gg: ASbGncsbiw/gQQ94Jr1titD+CBiK1mZv9bPsLSLN4i8TVrdYs9yhqsTiwHFtWJQTG9K
	+fY2yu539W1AuKxESibxEUj2VljFkQFkMnfU/BWC+1e+ZlZk4wjcbSklSOX3fWmnfoLpHHT30Nz
	dYWd7DQFZCZI76sx/5FDzclXx4VT+trWyBgbmvZ3FokbLMY4rJ/5pKID+sut/pZuagS/z8x8MER
	ZF8wKae6GzxEGQd8Pet30EuAe+2O7biMS3UdPtKpHVC2H22Y28sI6cn7NjbGdliOys4Z6EnRg==
X-Google-Smtp-Source: AGHT+IFg4MrRsXl7cwIJtfpy44aCizX1v4aAPKIAJI+qPE9zX1Qtehd7vvbt8lnNiLRKPOTTvfqDMw==
X-Received: by 2002:a92:ca49:0:b0:3ce:87a0:f8a4 with SMTP id e9e14a558f8ab-3ce87a1033emr36591695ab.9.1736976563578;
        Wed, 15 Jan 2025 13:29:23 -0800 (PST)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b5f93ffsm4318839173.18.2025.01.15.13.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 13:29:23 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 15 Jan 2025 14:29:21 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.12 000/189] 6.12.10-rc1 review
Message-ID: <Z4gosZxzAJFF9pfo@fedora64.linuxtx.org>
References: <20250115103606.357764746@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115103606.357764746@linuxfoundation.org>

On Wed, Jan 15, 2025 at 11:34:56AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.10 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Jan 2025 10:34:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

