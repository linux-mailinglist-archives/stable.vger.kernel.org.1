Return-Path: <stable+bounces-100925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C05DA9EE8ED
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D27E161D4C
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 14:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499CE6F2FE;
	Thu, 12 Dec 2024 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yAS4WK+M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0BD8837
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013985; cv=none; b=rYsn1ATM3VI/hlIqqwVI5PIE7eVNYush+hlEUWl5i7wtTsUeP89MM00V3MWPBYNG0ats+Q/QR7Y2baw093liYIDPfXF0JvowSjN/ofqEi3wa0H0UcvYIjpXPqgErZ1R0dBsHL2dginn6O82sOfQ2CJUf7gTbafFliMjyFgovrGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013985; c=relaxed/simple;
	bh=DL8HqM5MC7DaVVPkPueMq8WP3ewzftICzBSGbRfVYvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZIfxlvZjc/s1nJalAIWanI+b8ChqJxVRH/DX22Efql8ZRHJJ79c3mVcGblvt7aF31eMZf9En/aiV7sVlOQUCiXsASbChlibS/Tbv2jn32z9gqgllasvTd/e+7SA7z0v8kuCXdrM9A0SDgK9aeTmqvHJdqIyutwUhXc5WLeUaWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yAS4WK+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3189BC4CECE;
	Thu, 12 Dec 2024 14:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734013984;
	bh=DL8HqM5MC7DaVVPkPueMq8WP3ewzftICzBSGbRfVYvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yAS4WK+MeTVEgejQ/dARqmGAkVQanTEKq6B1pvWZcjHSN0Ict0d4buSJz+efvWlNK
	 cYiclx4GeDxBs0tfF6YSqxUtCZm+f2qoYz3chy6gcoBct4fOz8wo46VajtShjwPS5i
	 /0+U1IqYqdoC5DXqQt5T1d88BpzuG8Wea6UccQT0=
Date: Thu, 12 Dec 2024 15:33:01 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-stable <stable@vger.kernel.org>, lkft-triage@lists.linaro.org,
	Sasha Levin <sashal@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Benjamin Copeland <benjamin.copeland@linaro.org>
Subject: Re: stable-rc: queue/6.6: drivers/ufs/host/ufs-qcom.c:1929:13:
 error: 'host' undeclared (first use in this function)
Message-ID: <2024121244-scanning-grimace-b554@gregkh>
References: <CA+G9fYvkiFZxYFV_jKYOgePNMJDjQHL+BVo8SUWNVS37=aR5ig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvkiFZxYFV_jKYOgePNMJDjQHL+BVo8SUWNVS37=aR5ig@mail.gmail.com>

On Thu, Dec 12, 2024 at 06:58:12PM +0530, Naresh Kamboju wrote:
> The arm64 builds failed on Linux stable-rc queues/6.6 due to following build
> warnings / errors.
> 
> arm64:
>   * build/gcc-13-defconfig-lkftconfig
> 
> First seen on Linux stable-rc queues/6.6
>   Good: v6.6.65
>   Bad:  v6.6.65-348-g690f793e86f4
> 
> Build log:
> -----------
> drivers/ufs/host/ufs-qcom.c: In function 'ufs_qcom_remove':
> drivers/ufs/host/ufs-qcom.c:1929:13: error: 'host' undeclared (first
> use in this function)
>  1929 |         if (host->esi_enabled)
>       |             ^~~~
> drivers/ufs/host/ufs-qcom.c:1929:13: note: each undeclared identifier
> is reported only once for each function it appears in
> make[6]: *** [scripts/Makefile.build:243: drivers/ufs/host/ufs-qcom.o] Error 1
> 
> the commit that causes this build regression is,
>    scsi: ufs: qcom: Only free platform MSIs when ESI is enabled
>    commit 64506b3d23a337e98a74b18dcb10c8619365f2bd upstream.

Odd, that backport is broken, sorry about that.  I'll go remove it.

greg k-h

