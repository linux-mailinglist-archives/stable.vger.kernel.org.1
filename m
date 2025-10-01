Return-Path: <stable+bounces-182953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9354BB08E5
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 15:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5472A19465D9
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 13:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FE02FBE17;
	Wed,  1 Oct 2025 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="gATOir/C"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744ED2FBE13
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759326422; cv=none; b=aPFK1GgNQq4AnlpiaQ5qWJ2qKe7run3g5OkshEJxLzcogmwCulEyjnYBU3T6Z1aqEPYa3aDxnZ6O0MtgRr5itXiwnwVWvfh78Y3mYcKVID9gaiw+AtEc9KX/EYKtz7bHYPBs5FzP96U3d2wOfG5rKiuN6ySpuc42OYfpEXru/kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759326422; c=relaxed/simple;
	bh=XnzBrKkqhtzozb80b9whPjYrJYlVgO3E+tv6VeqoZHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwZwTzYNgjuO7f+yFeG5yz32a3ucDsCB2YO39pBzatyAtJtmv0N8KwY1dJ7f/Gcp6ZhhPBglAaljauzD/DdINn6cpL17If3E2uPH9RcByFKStf3Jjo590ygM7oiPjK8ZEd7QEXDGQmfS0oDaS+zpMPmQPEHFH6k3ML4l8O4ECqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=gATOir/C; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-938bf212b72so25553739f.1
        for <stable@vger.kernel.org>; Wed, 01 Oct 2025 06:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1759326418; x=1759931218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W45Thb4hNfN9gWdtcaFXe+UzJhkD5Q1/J4+NgR3g+ZA=;
        b=gATOir/CfwnlMXvJarfUaw7gikKwa5EaC3zYyW9cXuRsjdlGCKhK/ln3GepxfAOaOm
         FlhwdHq14Qd3sumTo/ez4yecJ3AFYglUIx10lWtjpj1CIOGoFDsk31rD52lu7MgtT2mn
         /5Or4EuaKDWlQeZuV4xfwxr+PrJeW9baa/oAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759326418; x=1759931218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W45Thb4hNfN9gWdtcaFXe+UzJhkD5Q1/J4+NgR3g+ZA=;
        b=jNcKQ4JzjLN9LN8/3pRm5Ymlt24WnP0zSDcnyM/A/MQ/C5d0rnAMQaoxF9n1/9twIP
         ut7scxO0mxmIY4aSWIDHUq7ISoXeolmWkyCuJY/N7SR3mZ4BpYPpKWq18W9bkmlFtW45
         cIb25eMXljkihufotCzeXyldN+4PaPXmir2RXY3TcaiPreKAqs24NiPEALrHRYjM9YVr
         ieQhPMkhNAmM5t/huwIBbKQ31Dv3IyU5Cm3i8c8RlMcxgo4IM9atYGCUSoHw0wLs569V
         QqGL7hk/P0rNlxusP/EAeZy/av2X8Tr4uerc/KsHOqOiH5f7BmmmdcwNKeW/q2w/lPHr
         //Dg==
X-Gm-Message-State: AOJu0YxW12kRji2hdOnJiOEq9s5yV5CzSVl/q4+5W90ck2AVr3ABlIZg
	7hzprlf9ojUe5sBek2sqONCbzDxepqmhMwM1QvOH1mXW9IgiJUuXk7UF+qWhFubsdA==
X-Gm-Gg: ASbGncuY9zThpkm1WGErZ6SYxGd7paKK0OKBETqS7OAeXc0uZMPZwqv5JzofxMe6gv/
	Rzh062/spl5tsDsb4D50lst9grBXQC3j73xmzT+CiLXf163UP1rlS3EVW/j370MyxvKFCYNbhjb
	77ZA1bbZ+SC/ue4TUf2lJhNx7/eQ5t1PuJ3R18zvps0J/JDixZ8LAZXWba0lCwoaSUgDLx9LOIH
	V2ra0js04AABFHoFq2Aubtr2UFKLW9QNqwKaFhSlW3qgtmMTB3gAIldbQnCZGrsxwOH7UYFoxVi
	9/RMl3L1pJxPD1NAWEq+6ULiHq1NJOe3sZlVXGd577yIMBxuBtxKHtATj+kSAGm2XMhO5iRq7aL
	i3bEV+L7hDTEGmYegVDx8x9sDLWNGfxfciSqi53pIbeE8FqpED44/blsQoWiTV2ZA5Oo=
X-Google-Smtp-Source: AGHT+IGcnVVpdzqOl2yJnXH/xAk2zhNyBvJcfPwTkWYHDx3ZGcmd+zfU56UdL8Te+QSrukeDpCOkzw==
X-Received: by 2002:a05:6e02:1a4c:b0:41b:6e7b:3e9f with SMTP id e9e14a558f8ab-42d81676819mr50599705ab.19.1759326417830;
        Wed, 01 Oct 2025 06:46:57 -0700 (PDT)
Received: from fedora64.linuxtx.org ([216.147.121.65])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b58db188dsm288004173.33.2025.10.01.06.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 06:46:57 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 1 Oct 2025 07:46:55 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Subject: Re: [PATCH 6.16 000/143] 6.16.10-rc1 review
Message-ID: <aN0wzwSnbG_K4xtU@fedora64.linuxtx.org>
References: <20250930143831.236060637@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930143831.236060637@linuxfoundation.org>

On Tue, Sep 30, 2025 at 04:45:24PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.10 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

