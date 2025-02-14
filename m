Return-Path: <stable+bounces-116427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DEEA361C5
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 16:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CFFD3A8FE5
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 15:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91289264A8C;
	Fri, 14 Feb 2025 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="DJPNUGCT"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5657F26618E
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547229; cv=none; b=CQv5DnT2dBEJhT8EZsiSik/er+im83TJEbdrhKVVbCLvfMOCCpw6+T2FAUK1fQ4ronEzJv8RPrnbJQEki2v1oKq7E5v3tVsUHRh/vI4vFXTVZ05PGl5/n6kYDGp4Kl60MtNnSXd4bH7+lFwuYWjFTFi24u4IRAIYQEnG52uAN+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547229; c=relaxed/simple;
	bh=07AhQZY6eqBCHApP+AXZgM2NZRDZAnYHuj2a4Hr2NjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4epxGjJRt5Y+YDPdSEO9dZG1JQBzy8Y5dJ+UWgktMWg1mfHVzMmT4DH6gbdOt4qqX8H4yjPF8zjA2GcnzKG7uCfM1TYv9U4lwuZcTsPCpdLYeh/3rUGhEKd95eOLhWiNMWwihol/B8EAlbHM6EvD4lLFhQevwmlDKHox9VEv1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=DJPNUGCT; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85527b814abso33393639f.1
        for <stable@vger.kernel.org>; Fri, 14 Feb 2025 07:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1739547226; x=1740152026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qkMQckh9jiT1iN830+BKZT3u1q140/CKGbZYSL5RY18=;
        b=DJPNUGCT6u/zHwxYTyh+0wrTeEj8939ZwQAzkKVaFThB+iHhjEJTgdXu3ubUYCcwT4
         i2Svf/GAfRe/u1r8bic4ScjwmlZBuBs/h78PkqIzlVnU6Q3BDChVtlKdYMj9CRN8xtOp
         Nbejh1d3Xb1XW1Lp2iB7343l6B7e++pfyuQlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739547226; x=1740152026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkMQckh9jiT1iN830+BKZT3u1q140/CKGbZYSL5RY18=;
        b=LwwlKznxlm9n1e3JO1JgLjOnNyue74whQzzWjhs4Dzn6P0oWWwrfk3C2YIuK3Hgome
         MoqJxlqRDOciKCxaZdn5B6SEdn7Lg8T08z2JFrtTFDhhy0lu7sqSq8lUauWTIuR7tt8z
         MUxnKb1Ndg6dbRGczu5w/3d1on6/d0G4zp56r08nacN7wMIFE2jsihlqB74WL9fIrmSL
         iPsxcwESU8QskkbWu8hBxdfQZHisGMVK365M3nNaE/6q9tt/puzyCa4R0C3AS7z3Meu6
         2JuTkCazasvaI4hdY2tTot1GGKoQqgNwhypB9PguetbGIfJ/FR1zwEeJYcq+BBH9C2ng
         EysQ==
X-Gm-Message-State: AOJu0Yw5/bPYVBgwpSm7lwQZpqO7jXjEmB9XHZntz7M4CEtZwJjoIKUV
	Ui9wJf5Q9h1nRi2sLnFopyPhY59NYQUg6yRXDEluACiyfTTyq/vFFRQPu+M/QQ==
X-Gm-Gg: ASbGnctklVuKW9U2xyesJaHAG5+TII3GJ+D1Aqg7rq/vrQA9waYEiw5ouh2w/5dT9W5
	SE4SwoP+XEgRlFb5+GhyfizSbgO9ZoSABs4OltL8v59eahl8XKoAFjbkgrelmSzWik5MPYE2/YF
	7J1x3GGACnli1s3OFuoYMcX9M+Y1aZVP5lgInBQjjGB0vx8ZiYwuW5sWm5DC223+o6juiseXjNf
	Jz1m71Xjw0EOGN9xms5+qCcieY1VgbMb3Tkigt7DG6JukbLw+O4UU+GShhz4Enlp1QO1s8s5mZu
	psHxaZnbH/EKGN31mWBrroZF5/rWOCej
X-Google-Smtp-Source: AGHT+IEq9JvuG9VMapzzSQzEygbV112X3NEj6nPsFllTlUf7bexl8lMA4JJVXPsFCKRgGWrgadZhuA==
X-Received: by 2002:a05:6602:1588:b0:855:515b:ba6 with SMTP id ca18e2360f4ac-85555daecf3mr976402839f.10.1739547226240;
        Fri, 14 Feb 2025 07:33:46 -0800 (PST)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85566e63194sm74004939f.21.2025.02.14.07.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:33:45 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 14 Feb 2025 08:33:44 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.12 000/422] 6.12.14-rc1 review
Message-ID: <Z69iWGFV6szC7Jck@fedora64.linuxtx.org>
References: <20250213142436.408121546@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213142436.408121546@linuxfoundation.org>

On Thu, Feb 13, 2025 at 03:22:29PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.14 release.
> There are 422 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Feb 2025 14:23:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.14-rc1.gz
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

