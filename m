Return-Path: <stable+bounces-98971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E9A9E6B45
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 11:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125F416A6D4
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 10:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900FB1DFDAE;
	Fri,  6 Dec 2024 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tllSumco"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C50A1EBFF8
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733479549; cv=none; b=tCM8lALETAMgqycfnZWIoLvvXFFrfcly5atejGPYjAB5ov15/wb2qUt+tA0tygCI6M1eNpCUAwsPjcceU6CZowTCjI6WgV+vdyTOYvmkSdkHe4dBwnCSg+pOwlufjSAPiODmhH5UpIcH84O/lEuodVTf/+GasA4S+yF9jH3UyPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733479549; c=relaxed/simple;
	bh=92ofUs2IAubGHwSOGTkODGaD/NhjhmEV+z78EBy4znM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrxqBx4EeB8lONNPcqSucY7IXYzCS0j3+OM7Y/cJKlfl9xvwLiUXFiRdbVoy8shaZY3LlioTjQ4XAzpiib+IIgBWrMdEwhASPb/wZmXGhXiG0DW7Iaq0Ts1FqatIKcNu3BNQdfwqlfWXfDe+pOA8vLJH9gxFmBkM3Vl2/dthxiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tllSumco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80D3C4CED1;
	Fri,  6 Dec 2024 10:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733479549;
	bh=92ofUs2IAubGHwSOGTkODGaD/NhjhmEV+z78EBy4znM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tllSumco1HugyU/joM3lsrm47dwVHuNw/e8jB3gBssu/5Wn3Vl7fuUf71EroqJdXs
	 oOeAYVjfQkLCafukR8EdtQV/hrfr4FXqw6RpTUxcvS2TzDXK4LhRnd62LYa3he7oHb
	 x2kQ3MRmxryScSShB2g3EWWoTHLkUTf86JIC6sO4=
Date: Fri, 6 Dec 2024 11:05:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: jianqi.ren.cn@windriver.com
Cc: abelova@astralinux.ru, stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] cpufreq: amd-pstate: add check for
 cpufreq_cpu_get's return value
Message-ID: <2024120619-dolphin-outlying-c78d@gregkh>
References: <20241206104115.1273254-1-jianqi.ren.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206104115.1273254-1-jianqi.ren.cn@windriver.com>

On Fri, Dec 06, 2024 at 06:41:15PM +0800, jianqi.ren.cn@windriver.com wrote:
> From: Anastasia Belova <abelova@astralinux.ru>
> 
> [ Upstream commit 5493f9714e4cdaf0ee7cec15899a231400cb1a9f ]
> 
> cpufreq_cpu_get may return NULL. To avoid NULL-dereference check it
> and return in case of error.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> Reviewed-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Any reason you are not cc:ing all of the people involved in these
patches when backporting them?

thanks,

greg k-h

