Return-Path: <stable+bounces-60466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E41449341CA
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 20:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25871C2193C
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 18:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCA4183062;
	Wed, 17 Jul 2024 18:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="p1/ibcfd"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E39180A9E;
	Wed, 17 Jul 2024 18:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721239456; cv=none; b=g7PDyRUCOBR/TJke5usrBJjasuscZ7do2I9HZoz193m5ZSk4lfBkOvXoGiVfBrDSmlkn4ok92A/Qtt6Ev53olMxPEy2A9Wp1bB/twChj3B27Bv8VCbHFWlcAxw6iJEIc+qxw0I6vUymCNDJFLB0Wr8lNPXUO0XzczwGbB5js0gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721239456; c=relaxed/simple;
	bh=ejxbA+jS6/7qCmlb66AETP4OAV1YSkhHZt2p0WXDx9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKgayFoMN4REj3JfJajJuRpz4N7FmjrH5G3V5BXWfwuBR+DIkHao1fTFgIozWR3sEsRJCkqb8/PEQDE2p31LIexC6KM7kkkS66Wy3A5Cp8sogQp/o+bQP3ubRIHuYH0GP+6BOJlW0VM5xEs7EIva9+F53fj4G2tUO+k+70Gl94w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=p1/ibcfd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id 8111520B7165; Wed, 17 Jul 2024 11:04:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8111520B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1721239449;
	bh=eNkicc1CFVATrogoWEaQSqdmIwGTa8/Pq6zDIJW4vYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p1/ibcfdFf26aC7Ci2OcAJ8wnaYVLoX77E5ANw8R3umsnHyqfmo/OxD/nk1hIOK2P
	 DH/Vqwr9T01j2H/CBQKsWPRSAiEXi4BpacZ7dL3Y5eEQln1tZAepk8hC73IYnew/ib
	 7Dq8VQaXiA6jyGQLyMxysnXTqoG0BgcySC36192I=
Date: Wed, 17 Jul 2024 11:04:09 -0700
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.9 000/142] 6.9.10-rc2 review
Message-ID: <20240717180409.GA7194@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240717063806.741977243@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717063806.741977243@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Jul 17, 2024 at 08:40:00AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.10 release.
> There are 142 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 19 Jul 2024 06:37:32 +0000.
> Anything received after that time might be too late.
> 
No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you. :)

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

