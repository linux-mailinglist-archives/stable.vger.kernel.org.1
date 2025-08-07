Return-Path: <stable+bounces-166794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF2BB1DB0E
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 17:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326D218991D3
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 15:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B5A262FE6;
	Thu,  7 Aug 2025 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I0zNu88/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD8B1C5D72;
	Thu,  7 Aug 2025 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754581966; cv=none; b=Tkt+UjtomVyfebJM79Prsm+qa615IR8lml3nHrPrDjF3S0/NYsg+C5bUhzWhHMUClp7Ls+EjE5KGdX78frU33Zq0NAt5kHAE/KmUsPsH/h+wpNd+TTr6YfQg7gwCLtT7ALac9eLl0966OG/dtLQmaBxdHOX87Bs2qJBKAamu52c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754581966; c=relaxed/simple;
	bh=YRS94p/FbNM9/y4FbArYf7EcAJfwjlAscxKZ9U1T7JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWlGXMn40/RPQjsEA8vUn3n5SvIR+kcxS9ZK7mKDYndBRIHIgh+87vJqiwVNZraVv45fxgkbYgGG/tKgm7MJZFs1Ta0akoUj2NPNAz42JFH8xHSc2NsYHLufHKidThOJTLn019smdV/7TOoiGMcLRpkZcbVesx2HDlaoy1pffqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I0zNu88/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECDBC4CEEB;
	Thu,  7 Aug 2025 15:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754581966;
	bh=YRS94p/FbNM9/y4FbArYf7EcAJfwjlAscxKZ9U1T7JE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I0zNu88/pI1njpXl57TwTnMUoFUiRSmn6pOk1qOKUF8x9lEfd97ZjHjsWSQTfW9Bh
	 TO/UgCX3A6NBkxfJbhTA73oqf485HTiGCyAY18slvwqJHJGiHYjLHrw7zJzh8C50k4
	 NizCfgVGOwX7RCgcN8Tq+pyLuPP3QWgePlVSaCr4=
Date: Thu, 7 Aug 2025 16:52:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: cat <cat@plan9.rocks>
Cc: regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [REGRESSION] vfio gpu passthrough stopped working
Message-ID: <2025080724-sage-subplot-3d0f@gregkh>
References: <718C209F-22BD-4AF3-9B6F-E87E98B5239E@plan9.rocks>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <718C209F-22BD-4AF3-9B6F-E87E98B5239E@plan9.rocks>

On Thu, Aug 07, 2025 at 03:31:17PM +0000, cat wrote:
> #regzbot introduced: v6.12.34..v6.12.35
> 
> After upgrade to kernel 6.12.35, vfio passthrough for my GPU has stopped working within a windows VM, it sees device in device manager but reports that it did not start correctly. I compared lspci logs in the vm before and after upgrade to 6.12.35, and here are the changes I noticed:
> 
> - the reported link speed for the passthrough GPU has changed from 2.5 to 16GT/s
> - the passthrough GPU has lost it's 'BusMaster' and MSI enable flags
> - latency measurement feature appeared
> 
> These entries also began appearing within the vm in dmesg when host kernel is 6.12.35 or above:
> 
> [    1.963177] nouveau 0000:01:00.0: sec2(gsp): mbox 1c503000 00000001
> [    1.963296] nouveau 0000:01:00.0: sec2(gsp):booter-load: boot failed: -5
> ...
> [    1.964580] nouveau 0000:01:00.0: gsp: init failed, -5
> [    1.964641] nouveau 0000:01:00.0: init failed with -5
> [    1.964681] nouveau: drm:00000000:00000080: init failed with -5
> [    1.964721] nouveau 0000:01:00.0: drm: Device allocation failed: -5
> [    1.966318] nouveau 0000:01:00.0: probe with driver nouveau failed with error -5
> 
> 
> 6.12.34 worked fine, and latest 6.12 LTS does not work either. I am using intel CPU and nvidia GPU (for passthrough, and as my GPU on linux system).

Can you use git bisect to find the offending commit?



