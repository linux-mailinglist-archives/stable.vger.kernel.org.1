Return-Path: <stable+bounces-161336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646A3AFD622
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 20:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B85E8174A2F
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C0B21CA10;
	Tue,  8 Jul 2025 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lcGTCevu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DF214A60D;
	Tue,  8 Jul 2025 18:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998164; cv=none; b=Vw1InUaNyuw+sEnSlHYDy6pQiNE/559zc4xZVXjymL7ndTgdw3ZFIVS5E63YbeQBFdD6tyWpCc/IAlOTQprHLslMiQcaCWeQGRURNw8SgC3ERNgyTHur1rG1g9Ui4Xs0B4WiL2d60I3d9QZ9NYoQUD/85xKwQWD0lLKPGBsXsvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998164; c=relaxed/simple;
	bh=UMMGW97wtCTkaOMQqHcSn77Oz2CIF65rUcIMBl2S3XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eO4Zhsg7Ov27/cRMFpaSeq8kc7ry1wbV3K5LLTLBkwDByO6+nh656tUtxzSvdF9fGN3x8+D/IAkkVlif3gJoM6Yw0d8vy3+JwBmZwb+TU7s2uwHjSR7aKCraPl4IM2dFE553bIwXV/JMBW2IpGR2d1WIIC9AI50Om1f8e1aGbTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lcGTCevu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4D9C4CEED;
	Tue,  8 Jul 2025 18:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751998162;
	bh=UMMGW97wtCTkaOMQqHcSn77Oz2CIF65rUcIMBl2S3XQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lcGTCevue4sIzIa5S00VXxhl8AjVJdt8a18SvZAhopGoRA+KYUpBgybUDBSMT7wUM
	 2TNSQElhrWHbXRXvFAlJCo2/uS6thAcB2iyPY5BqmbENIghFMvRtp6Y/33ji0JtST9
	 OEZEWU4QQsitRhY71nSK0DEM/KKHkhNMxoW01RiY=
Date: Tue, 8 Jul 2025 20:09:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>, stable@vger.kernel.org,
	Kim Phillips <kim.phillips@amd.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 5.15 000/160] 5.15.187-rc1 review
Message-ID: <2025070800-staff-expire-a6d9@gregkh>
References: <20250708162231.503362020@linuxfoundation.org>
 <2438aa80-091d-4668-90e0-fb75f3e0b699@gmail.com>
 <20250708172319.GEaG1UB5x3BffeL9VW@fat_crate.local>
 <12b05333-69c2-42b7-89ea-d414ea14eca0@gmail.com>
 <20250708174509.GGaG1ZJSHsChiURgHW@fat_crate.local>
 <20250708180400.GIaG1dkGnKYAS1QOu0@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708180400.GIaG1dkGnKYAS1QOu0@fat_crate.local>

On Tue, Jul 08, 2025 at 08:04:00PM +0200, Borislav Petkov wrote:
> On Tue, Jul 08, 2025 at 07:45:09PM +0200, Borislav Petkov wrote:
> > Right, it needs the __weak functions - this is solved differently on newer
> > kernels. Lemme send updated patches.
> 
> ...and 6.1:

Now applied, thanks!

I'll push out -rc2 versions of both of these now.

greg k-h

