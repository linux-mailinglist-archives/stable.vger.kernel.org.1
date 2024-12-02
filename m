Return-Path: <stable+bounces-96065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F469E066D
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19FB616B9FA
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1274920899F;
	Mon,  2 Dec 2024 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nF58oUgN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF53A20897E;
	Mon,  2 Dec 2024 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151234; cv=none; b=S45FLc6MmmyUijirU1NSi92fVmE3dgIikLlcvUwdcbcJMvrgIRBeusEAYN58JFovcUbimejqgBrDufErvrVl83L4xAxQb1CAh2VywZ21RLyqxYZrLckOQGl8Mp9uUrn4d+A3/t/e5nXnhhe8AkVGfe0pkT8KlDoFL17PblrsszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151234; c=relaxed/simple;
	bh=sLOtG/JvypBsoCx1TvC28q6WPX+ffeXtbOrJlhTq0UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VezX6ZGNc+xXMqJ2uhbCiJvGB5SHI/aHmwSdtJhRG9RpKypM/7awPLnQLGf9Nmj4AArU/J2LAVsWvCs/TziEKZc8Pdmv8HdxK8fEAAEZE04wa6kv1ATEKITkFZA8sX7rVOutyMNd7tPr+i1MKg1HYaUuTgV/kROdwIckqGNiZtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nF58oUgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A206C4CED1;
	Mon,  2 Dec 2024 14:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733151234;
	bh=sLOtG/JvypBsoCx1TvC28q6WPX+ffeXtbOrJlhTq0UU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nF58oUgNByVAfuniky7I2V5JxJop1u/r/obL5/EU/YG+NeDrktsxE0FwaQ9sLQR1n
	 x/yq9NAOuBrA7BliUfMpeV0MKm3i7RiKu2ZwUHZQBEfToVHzV8Ejdzbc+ptXsEmbNi
	 pYj+dQ/547Yn5Mw6hlSyHxsEY7k/SnOMps+sXajqxaEpsZu2RKyIaNDNmYtUjyz5fC
	 EI8AKa8/JqmjzYCNx11xA2eqgf+2qhw3lr+ntxgNjHGDTEepa0pEqE/A1O//+ABJjF
	 JEVyJip/s6bHJlZiJvoVYJCOzc5KMFFkZ4a8W5IlCP/in6OSOwcm/l4XbjsQgtT995
	 RSIaDUMcSAh5g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tI7o5-000000006pG-2vUR;
	Mon, 02 Dec 2024 15:53:50 +0100
Date: Mon, 2 Dec 2024 15:53:49 +0100
From: Johan Hovold <johan@kernel.org>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, chenqiuji666@gmail.com,
	David Lin <dtwlin@gmail.com>, Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Patch "staging: greybus: uart: Fix atomicity violation in
 get_serial_info()" has been added to the 6.12-stable tree
Message-ID: <Z03J_ZvB-NUArQkH@hovoldconsulting.com>
References: <20241201123620.1513386-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241201123620.1513386-1-sashal@kernel.org>

Hi Sasha,

On Sun, Dec 01, 2024 at 07:36:20AM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     staging: greybus: uart: Fix atomicity violation in get_serial_info()
> 
> to the 6.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      staging-greybus-uart-fix-atomicity-violation-in-get_.patch
> and it can be found in the queue-6.12 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 61937fd741031632e0a1337553e51b754748ca0d
> Author: Qiu-ji Chen <chenqiuji666@gmail.com>
> Date:   Thu Nov 7 19:33:37 2024 +0800
> 
>     staging: greybus: uart: Fix atomicity violation in get_serial_info()
>     
>     [ Upstream commit fe0ebeafc3b723b2f8edf27ecec6d353b08397df ]
>     
>     Our static checker found a bug where set_serial_info() uses a mutex, but
>     get_serial_info() does not. Fortunately, the impact of this is relatively
>     minor. It doesn't cause a crash or any other serious issues. However, if a
>     race condition occurs between set_serial_info() and get_serial_info(),
>     there is a chance that the data returned by get_serial_info() will be
>     meaningless.
>     
>     Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
>     Fixes: 0aad5ad563c8 ("greybus/uart: switch to ->[sg]et_serial()")
>     Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
>     Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
>     Reviewed-by: Alex Elder <elder@riscstar.com>
>     Link: https://lore.kernel.org/r/20241107113337.402042-1-chenqiuji666@gmail.com
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>

The CC stable tag was omitted on purpose here so please drop this one
and any dependencies from all stable queues.

Johan

