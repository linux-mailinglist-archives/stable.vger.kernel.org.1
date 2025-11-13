Return-Path: <stable+bounces-194735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5281FC59F9A
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 21:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8F0AA34541D
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 20:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBAF314D01;
	Thu, 13 Nov 2025 20:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L4LqXyui"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CBC31352F;
	Thu, 13 Nov 2025 20:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763065954; cv=none; b=U+hJ22AdykTQJF1372ZMsY4War/F+nRuvT36ui6YgzYFZBAshqKCiyjsGSIJCVau9eJs/eI8qguPKe3DAc5L0s7Agqtg6tWF4nEUoiZT/8/A8+wMIGGYdqhPRK04Cu/ivEf3KdKNsc8PIEvkFdoc0t/9VUWf4lqgThJfg5rjgNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763065954; c=relaxed/simple;
	bh=SBXfKO4dDqTHirh16PgzAKiWDuXanUIwj4Toq1r1g6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPEH8V6uFqNaRLH6bg0XVfwrFPc/EXk1TlriF0WY5/YJlp8eA1Bq7eFopnaus8DRaKfoNJ1lrGx/HHiGyXNSEyowRl8vWJdyUw8ORPfvHVTqUahAOYDao0BtSSoT/aViZbRflq263Zq0LMCXeB65Aa+RqhvyTUe2jCtFwTiNmcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L4LqXyui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E948C4AF0B;
	Thu, 13 Nov 2025 20:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763065953;
	bh=SBXfKO4dDqTHirh16PgzAKiWDuXanUIwj4Toq1r1g6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L4LqXyuiVmlyy1oZRrzbyo3Tj45CmYymVJ/54O5Mk5sFdZrws9x3Bex4jFkk0lD0s
	 W3e3O5Zax/H7qe0w2PGu5fj5FnVs4R0sNGc4j9eWoOxu0PRJfx9kh0nsVfkolGbaR+
	 +TFsNGo/dNe5f3CvXCSPPg1HDogz5yOwJTc66y2M=
Date: Thu, 13 Nov 2025 15:32:32 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.12 00/40] 6.12.57-rc1 review
Message-ID: <2025111321-proving-pliable-9b50@gregkh>
References: <20251031140043.939381518@linuxfoundation.org>
 <834b1518-67c0-4d8b-b607-f960a178ff2c@roeck-us.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <834b1518-67c0-4d8b-b607-f960a178ff2c@roeck-us.net>

On Wed, Nov 12, 2025 at 07:02:30PM -0800, Guenter Roeck wrote:
> Hi Greg,
> 
> On 10/31/25 07:00, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.12.57 release.
> > There are 40 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> > Anything received after that time might be too late.
> > 
> ...
> > Steven Rostedt <rostedt@goodmis.org>
> >      perf: Use current->flags & PF_KTHREAD|PF_USER_WORKER instead of current->mm == NULL
> > 
> This patch triggers a crash in one of our stress tests.
> 
> The problem is also seen in 6.18-rc5, so it is not LTS specific.

Great, we are bug compatible!  :)

