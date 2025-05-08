Return-Path: <stable+bounces-142775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D77AAF0B8
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 03:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0441C24CBE
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 01:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784111A5BBB;
	Thu,  8 May 2025 01:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="aqAWagU+"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539AEF4E2
	for <stable@vger.kernel.org>; Thu,  8 May 2025 01:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746668824; cv=none; b=Q3DY1zfdlPjZT+2a/V636oCooeYAuZMQTIwXVhVR580xtXuJ4uHNswkQ6c1makr2FQQGvgE4RgcgJp0JCx7JXVLHjO48sCI7Sc55uF4tGBm9a/WqkNRyiktoGM9eKVFTOr0yWI+9QdBAPJI65domdwS7zkHTgTx39+FkXrxbbWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746668824; c=relaxed/simple;
	bh=wPYQA0chDUAYTp1nRzQozQgezsU3Dw/AxpYicdDi2C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o910Lsf8/aizBr54KSJkJdcb85nidN0PcpBYIJ6uATm4IJ0lRTBldnw1ijt0A7IUr7R/ky6QnQvqQ2yDcnDcqnCfz0tffnq/DolbaNonKkRVEcRxpMEmubhkIw2k6xBVjImVipKz5Wzb1L4SQ6urWGk/Zmk6EtppovmHcGyQLPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=aqAWagU+; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d91db4f0c3so2232215ab.3
        for <stable@vger.kernel.org>; Wed, 07 May 2025 18:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1746668820; x=1747273620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K30ImzdgaQIMhkVLspdKyTD1ilP48uNTiegnW+raJhY=;
        b=aqAWagU+nXyxPUh6A4A/iPf63NJ49HnSu5Jgz9xqdfx7siIxFq+8Indtod7nRw4BuC
         qdmaVpyYw1g5zVgMSN3neyEY7DfpJ1UGZbB+a5Qdz42zAwlEeZJ0zY2qHnFehNi7HnsE
         p3vistPhEwzpVGc0aoqAOzvVUPdIP6Z174yTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746668820; x=1747273620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K30ImzdgaQIMhkVLspdKyTD1ilP48uNTiegnW+raJhY=;
        b=gHo7GFljtX/bImtCLnGqNB1OtypZSoNK/czcIG12sWOxPovxHWEPH56U0B45exSg13
         yvlglJ8OF4pkyPC7wn+DmgqVZkjnfMLHkzeJC6c4q/rZWRq+RxkaNbSvkZCmOH/NFr+N
         sJE93q61vQ9AYvdlJysW0UCPVKkTXcSZtgCVCBQk+JcPDddQv8XABOAr51lJZmPVUhKr
         BNteSJl/s5hlK9naXb2hgBOFfXPQzELfbERLUdaqfrCukRl+j2jsdKLncNHcWv+UBSep
         n30bfzYliy9jamTw1E45nDS3Nk38oJ5Gjz9s9z9bkdZol65ARaShIxH1ylmrs05gEIyv
         c83A==
X-Gm-Message-State: AOJu0YxZqqZlVUUHx1w0LZIq93xu6U6Z/hjxJDVD8m2cQ3yDTCdTdHfi
	hQZMGVAwGfB7h1HCcbaDcVshA/WL52KLDBjOzFUU05CiNFMwrzCVEssRq1wilQ==
X-Gm-Gg: ASbGncvRtz/Yh9u5Z4NVmOGr+BBuGsYHqhH6FwrD7RuKft3ka+h5KEdBqyZwJ7s3ZiV
	uvX8IFrTsRDSbbBH2jqqUHGGW0leOVUbiWcKLYt7RN+aNUjJGMdYP/4Zl6Dk5totENb2WYQLgWk
	nYkYqC+oa3sfd6O9j9Vc/vCNk6y1+TwXD0gpVq9F8APFA7FatN5FiGBDJWnE6GMgKfffHWeYvHt
	obqSigvmu+XpHueWz4i5GJZKG5qD5phCwMawhH6Nwr6YGzgmYKR+HXLJ9R8pPSdBggnvvXI4VTS
	pn/rMyGWHcngX7RK/t8lrS9QHprM+K6VZFdGLbAc3DDhjKqi2SwgDrlHVg==
X-Google-Smtp-Source: AGHT+IH4Lz1o04N5HigShgyvfxqljFYcADGJXBDAPQu5Ym4eae8BcvvU/ic296T5K1SMw6L5LWvptQ==
X-Received: by 2002:a05:6e02:3f02:b0:3d8:18f8:fae9 with SMTP id e9e14a558f8ab-3da738e3bf4mr67925185ab.6.1746668820373;
        Wed, 07 May 2025 18:47:00 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3da76a9c49dsm4777715ab.3.2025.05.07.18.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 18:46:59 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 7 May 2025 19:46:58 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.14 000/183] 6.14.6-rc1 review
Message-ID: <aBwNElYzao3SIHYc@fedora64.linuxtx.org>
References: <20250507183824.682671926@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507183824.682671926@linuxfoundation.org>

On Wed, May 07, 2025 at 08:37:25PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.6 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 May 2025 18:37:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

