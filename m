Return-Path: <stable+bounces-196763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF27C817AB
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 17:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 298004E69A8
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 16:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D81314D07;
	Mon, 24 Nov 2025 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/i0SHw7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09037314A91;
	Mon, 24 Nov 2025 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764000214; cv=none; b=FRzddqEsb1K5dQysAAy0NEW3FhjkFto1dN3hBo9zzpA3yLyePbIPzd1v3TnGeTdKjvcb6FwbtKkf1ZxUNfjnYJMNx52SYbx7Psw5gFsZbMaMkaDKeHcWHi7aaL6kH6N39nHqoKSUN39Zuc8wE/LyKtECsU8LrifsXdu6RTnZcJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764000214; c=relaxed/simple;
	bh=yUh5KaTdq5W1Roh6URVREXeDwSR9uly626hKfFll1uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M70RXts/L8IIKOPHYmVX+wvb+yBENPMxR39BaSLn5zkueL86zArLyYmoCWXGRDCUgVgOkACMqEh/zuK5AVrjXbkjKsOY9YA73Or1mzOe/xi41bnrwp/jWnRzc55V6UGqb+5zYiySg7GkhH1Zu8dDDwt+2PcY7RBofF43WpgTz4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/i0SHw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14142C4CEF1;
	Mon, 24 Nov 2025 16:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764000213;
	bh=yUh5KaTdq5W1Roh6URVREXeDwSR9uly626hKfFll1uU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/i0SHw7qNZPsvERbIZO3I2hWSSgKtZ+pFRxppX11/yLM5vbztxnJG8noE2gV2s9V
	 3DCLsi8M7tsnfWEeNRT9zGj31sW0BVBgoZL6CajuW/3Dxpr4Ufd/IEyuS/xizqfxgU
	 INBxcMyKRU4XMUYemmBB0a3pDeFxKj5wSda4onBreH2DmioRBfIKVqHskYdqg02yiP
	 iIDM4vbfqYYy13j6+ZcD7dTdzj3wCpyQP7yDUe5UH+ArjEcvAcF1EWZJHRs24/3a47
	 LNG1pHdy3fNa6ryr8ugKORuoi02iWpXbgydKNW1v4N/ApL4y1vDdvLw2Yv5zlUTBHs
	 ocGZ2nJLTN8zw==
Date: Mon, 24 Nov 2025 16:03:29 +0000
From: Will Deacon <will@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Besar Wicaksono <bwicaksono@nvidia.com>
Subject: Re: [PATCH] perf/arm_cspmu: fix device leaks on module unload
Message-ID: <aSSB0foqqbOl3fC3@willie-the-truck>
References: <20251121115213.8481-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121115213.8481-1-johan@kernel.org>

On Fri, Nov 21, 2025 at 12:52:13PM +0100, Johan Hovold wrote:
> Make sure to drop the references taken when looking up the backend
> devices during vendor module unload.
> 
> Fixes: bfc653aa89cb ("perf: arm_cspmu: Separate Arm and vendor module")
> Cc: stable@vger.kernel.org	# 6.7
> Cc: Besar Wicaksono <bwicaksono@nvidia.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/perf/arm_cspmu/arm_cspmu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index efa9b229e701..e0d4293f06f9 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -1365,8 +1365,10 @@ void arm_cspmu_impl_unregister(const struct arm_cspmu_impl_match *impl_match)
>  
>  	/* Unbind the driver from all matching backend devices. */
>  	while ((dev = driver_find_device(&arm_cspmu_driver.driver, NULL,
> -			match, arm_cspmu_match_device)))
> +			match, arm_cspmu_match_device))) {
>  		device_release_driver(dev);
> +		put_device(dev);
> +	}

There's already a fix queued for this; please take a look:

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/commit/?h=for-next/perf&id=970e1e41805f0bd49dc234330a9390f4708d097d

Wil

