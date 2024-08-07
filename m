Return-Path: <stable+bounces-65961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ABF94B132
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 22:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921811F226C9
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 20:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E628286F;
	Wed,  7 Aug 2024 20:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="U8ALGxp4"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBA7364BC
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723062239; cv=none; b=qUYQ1PzdF69ky2FL7JCRueQGLuXhfmTDmNeucun90yCiZ9BekTQOrAQjNnOvRz33vlvSBog8rA9ZOKS7I4Ea9hKIvh7tZW0JAagG5nsFpUh7plKzwFzmlAF3Bb5a9Byl7Wo+p+Sb2Re10yTuSNw1IVF1lY1m2FvwJZ1tnc+JQhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723062239; c=relaxed/simple;
	bh=+3jwXodw4pt9DovGiW81mYh8/wDwEtCWOX6/qoXKUQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X68LmwsW0uSJLDFSL78l6JFHmb0wo5ExKvHTDOLKE3AVaI/uLDJR3bLyqCe4iuhKNJb1T7TzB9vY+rQjGKg3xLQiA1q6zxS+4tpdgrY4QN0zP9kmmCfcX9ZMg8CQF7czKaxGLxjuWCrL1N8bx+NzD7Jb8zjjA2ddUnH7WXsRZCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=U8ALGxp4; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-81f95052c2cso9145639f.0
        for <stable@vger.kernel.org>; Wed, 07 Aug 2024 13:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1723062235; x=1723667035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r6tLkUPbQyEjGAfmYn4iHvooN09UUMM9a2k9Hqq5QZY=;
        b=U8ALGxp4r4axSgSXfFU6QGAnb3ZK9FuLJaTI3GtAPnLZQxUDVYNQ9N37Jw7QZYyt7A
         Uetduqx/L70eJgPlbKe9ufrrXapQa5joa/YyzXFt4vrZTy6kBLSfInizs1Xqy/XeSB8o
         YoQpT7lqCzwSKDPwU56YPJjvbe+RIwuhK0Xi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723062235; x=1723667035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6tLkUPbQyEjGAfmYn4iHvooN09UUMM9a2k9Hqq5QZY=;
        b=HX8fjYD+WbcH01R2CdbzF4WZON6bW3onCzd+ETVH5mnjug7hjaJh8pcGqr4E+UPZOD
         cQcn++6SD7SvwYvTCN1eGWs1ehaTXWqWeUr8wzRR27eVjCOIjvPqkUX94AJU+9VTnjFq
         LhuAc9JZ1F5E6w51TgKs/2q3Ph96/MTaTxoBKGN14uJ0jbq5OZ5elFKiF8J+lIRZgjbU
         LRDUEHNx/DUmiYreiSLCF1XXVWfm4EbamVOTszjDPcsI5Dqw9JrHXxZ+zx1np9ErJY1X
         gxELIQPlWQNJqo3jwIspELl8oAAgVND+ZzmwWGcgzEUrkWsfiw0kQCs1/wIpUBpbunB8
         YcmQ==
X-Gm-Message-State: AOJu0Yy4EcuLonta8ZRJmMW+YUH4ofGSSZE89CqlvZ3+NWNUwUmj4MO/
	1sTVdliOdV0J0X0lb1OewZEsL1pj66Eo0mFm8nKD6vfuzaDwrZIvK7iBF5YD9g==
X-Google-Smtp-Source: AGHT+IFM2XyOCn+eCI6JYyc7AasqD31v6ZmwIhteJB0obCYGFILhHY8WH67Vfy84rpEbTTm5+nxxHQ==
X-Received: by 2002:a05:6602:29c8:b0:81f:9b2d:e824 with SMTP id ca18e2360f4ac-81fd4361c61mr2727276539f.5.1723062235394;
        Wed, 07 Aug 2024 13:23:55 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.171])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81fd4d70115sm336133839f.34.2024.08.07.13.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 13:23:55 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 7 Aug 2024 14:23:49 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.10 000/123] 6.10.4-rc1 review
Message-ID: <ZrPX1QQO4X3Bjkes@fedora64.linuxtx.org>
References: <20240807150020.790615758@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807150020.790615758@linuxfoundation.org>

On Wed, Aug 07, 2024 at 04:58:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.4 release.
> There are 123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Aug 2024 14:59:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.4-rc1.gz
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

