Return-Path: <stable+bounces-57966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71C6926745
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 19:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E595B1C22F50
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 17:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0C3184136;
	Wed,  3 Jul 2024 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Sub6UK6U"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D04181B9F;
	Wed,  3 Jul 2024 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720028186; cv=none; b=YzlRiTr5DwXTEvlI2Z6drnr0uzS306bT6cRm3LctwtaJjHMqYylmdcPV13hFGrhEH6LNiMtvKIYKSo8mNzHOSTITLy4UcHU6OWeDSmAGv/lP2VuD5fbukYEvunaKeG5mzXuqGdiMcc0LHFDjRcvlyw7ANSfby9ULaIzy1bls73M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720028186; c=relaxed/simple;
	bh=/gUMVRgul6lcAgrcClET5+UcbQ2CnjMiDHP/4hoUcpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rORi73md1aNnYUpQwG1zKQ2ExkdPiY9ehVlR7IjDGdlPZk+6KNYOdCS+iHw6+pFPCaAVvTY6HhPiSRaLrEfDdiMI4nt1tfyU+fTugQ1HdJ0ScmtCOVdDSQvJALfwvVuOJwZ18Q0UCAoVcmcUVMvatxRa0BpNcVV3fa/M8yTgYns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Sub6UK6U; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id 2FB1520B7001; Wed,  3 Jul 2024 10:29:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2FB1520B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1720027760;
	bh=lojtzhkZgYBDqXbGu4tXhZ3dbkmsj3C4IOg0gC/mFQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sub6UK6U75CDZXdVbcN5gv88Ix/3z6HN/Fx0P34VNUZuwCp2hgNtxzg1WziW6kqLR
	 nbmN133M9je2FziU7yx9Ep8hR7lSUfdnNsSkcKWeqPxH2oP27XYlc17asywizKSJuC
	 NnWVXBhu6mRfeFseuWaeJ56uHsEAsZ4Y06CU0bpM=
Date: Wed, 3 Jul 2024 10:29:20 -0700
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/128] 6.1.97-rc1 review
Message-ID: <20240703172920.GA11716@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240702170226.231899085@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702170226.231899085@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Jul 02, 2024 at 07:03:21PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.97 release.
> There are 128 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 04 Jul 2024 17:01:55 +0000.
> Anything received after that time might be too late.
> 
No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you. :)

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

