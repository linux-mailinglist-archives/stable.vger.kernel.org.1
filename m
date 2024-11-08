Return-Path: <stable+bounces-91940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A459F9C20EA
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 16:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C600A1C23156
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 15:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3CE21A718;
	Fri,  8 Nov 2024 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="TY/qDmrb"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267BA1F585F
	for <stable@vger.kernel.org>; Fri,  8 Nov 2024 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080800; cv=none; b=PDcaJwguuBahVnkGhHCQ8RPatZalS4Ecw46CegBYK/bQTgVK5+X50d9aQdquDzJ/sj0Z9cN9TeMYiktY4d5E1mp+DDlV9ZWSWtxyCPq3ifO3v+U0eAhheXakvIpd3UC/teh23UXnzExStGK0lTjIENxGKxUOa6Rty1NqCpbUpvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080800; c=relaxed/simple;
	bh=+LdFeKzzHTC8RXvEN6PYH9yBE5GfE37SIA4P+W8wZps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7SriM86mWrGr6+zhvvwH0hfOT8rgd6M+Dv8URBc9ISvnYqRYaTzvPTiZjuJKiTZP8KBDnR964F9qaDCFi4zbruFRyKtHWbvF1Njqsl0izBtPTHrdh0hXIYBjrAnfFnPKlMbuO736/kRb0FztIWoqzWU/kqQ+eyTuQighLckI6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=TY/qDmrb; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-288a90e4394so1096191fac.0
        for <stable@vger.kernel.org>; Fri, 08 Nov 2024 07:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1731080797; x=1731685597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTUnoBbq/iXzcyhOPyoYG3wdG6zX1R3z7yRa2H9Gwss=;
        b=TY/qDmrbzT6tzn1ovcsgZYLWSQ5l+NxbynlRHvb/EDYs9ZyjF+1W/qpnXuituCFzZB
         4xpKb1ACw1xVGHLvB/VKGr+Ec2HNLpqrofTBJlzChoPGVFwjEJXZEOK9ruT1ZDeikwnD
         9tUy5wTiBDbO8xdmn0gnXC38shanbJ0/9myAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731080797; x=1731685597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTUnoBbq/iXzcyhOPyoYG3wdG6zX1R3z7yRa2H9Gwss=;
        b=UyXnx//VRgWqUyCerPMxFFMhYaF67fdzrDQ6xTAqZlrxxDMIB9Aft7LdCT/Gcq649e
         JV5atJhrsSpjR9AABOf48BFhWg+Cay/s7kOojnljfOJf6TloCyH+2+xBbJdpy4HomwBb
         pnDThaziT3gEefRGfwBQgEgbqhMQx2/zVD1+xTKx0c15jSDo4R2ABrTN482fhbPmrsRJ
         d9VV7WHr0GyvO2gERyWX763AQV6UOYf473MXnORrEX1YQq94pTXzvZRKZmauOaFbEdfi
         nGV3H41NYWsAvogBd+seri268RfoM7/oEXev+jRRQfbAH73lJT00iOKAra88njoUhspn
         CenQ==
X-Gm-Message-State: AOJu0YwWR/kv+zORC0POkwmZqNOdRKHLLcLmean8GfUDc0GELUOq0kae
	WsE3g9ieTbOf1TYZM9nx+k2/OQCV8qfvHT1JioLELTtg/C7ZFfIfS5tgCovZWw==
X-Google-Smtp-Source: AGHT+IHqgM++0d3OVNWimHfkLFXzfZdpJb4sdh0RBgovuWcrSSqG177xGNnpYgyLzLqRlaE48t6dzQ==
X-Received: by 2002:a05:6870:e38c:b0:277:f5d8:b77b with SMTP id 586e51a60fabf-295602a56e3mr3728771fac.32.1731080797202;
        Fri, 08 Nov 2024 07:46:37 -0800 (PST)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29546ed7ab3sm1031801fac.42.2024.11.08.07.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 07:46:36 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 8 Nov 2024 08:46:33 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hagar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.11 000/249] 6.11.7-rc2 review
Message-ID: <Zy4yWXTJCU0-OqMj@fedora64.linuxtx.org>
References: <20241107064547.006019150@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107064547.006019150@linuxfoundation.org>

On Thu, Nov 07, 2024 at 07:47:28AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.7 release.
> There are 249 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 09 Nov 2024 06:45:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.7-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

