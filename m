Return-Path: <stable+bounces-43561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 632638C3191
	for <lists+stable@lfdr.de>; Sat, 11 May 2024 15:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187ED1F2180F
	for <lists+stable@lfdr.de>; Sat, 11 May 2024 13:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECB850A8F;
	Sat, 11 May 2024 13:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Apo/U37x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B3D50275
	for <stable@vger.kernel.org>; Sat, 11 May 2024 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715432996; cv=none; b=s1GXvb+2h4kG73MPDK8feam/tI4mWzAE4TZVOOwCHuHp6kK7sviwzaBAjZ/BI7NlATPUTjEp6pTDPLrPPUnpxY4Aji+bvxJY4FWP1mr0sD392ikczFi1csKZLgJ3ExDpft7XhMDQusF6mWd9cm4BQX+Cw6fYpA0IMa713sUD6ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715432996; c=relaxed/simple;
	bh=hRixfphZOwXYTh0exan3sxOaDImIfWp8OxGKk46j4+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0zRgqUimrmoThAHBQXb0ZlDCUblGsXw3vfDXLs4+wdbzbvZnaKfJmtwzqnvd2etfZnpQtIgWSIpWcunZM7YB6AdkgqyGk1ZB9mzGV3TVtYB2/reBFHGGNgHuvMU9nIlnxhKcqD09cz0SR6dBr9+JE0WlqCA4CflDdCB/kqaXhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Apo/U37x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55741C32781;
	Sat, 11 May 2024 13:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715432995;
	bh=hRixfphZOwXYTh0exan3sxOaDImIfWp8OxGKk46j4+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Apo/U37xMWDHA8qq3GC1+tKudddizTvgAvjKYX6O2SjQ+fs34wpkn56AumSN4PDVo
	 EZeC90uQxgTK+qlQoEqF4/ZPl8F6h5kx5FEX3CsABMClf6Z2ickKp7wO7+uzjo4gjf
	 eea0sJcIRIkWL3C4CDQhqpgGcJ/xgEje1uVOETWoCVykx+AS9rdgTraVSj1oubLruc
	 tkfqvh/Xh/Yu6Qc7MbZ+8klfZ7QCkKGiOZEf+HFow0gEUyMajBH0WDEwmxfQKCAAQK
	 bqcjupbo5HSkq+XyVW8ZH8akXxs6RJSaIj+Qh1Gcxx21t3T4EUg6wdOH+iVX/acOHC
	 817z6cAJEl4bQ==
Date: Sat, 11 May 2024 09:09:53 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: DCN 3.5 hang on boot
Message-ID: <Zj9uIXYIEu9qGPBP@sashalap>
References: <ca88501c-11ad-4803-8e0b-18fd10950733@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca88501c-11ad-4803-8e0b-18fd10950733@amd.com>

On Fri, May 10, 2024 at 09:57:00AM -0500, Mario Limonciello wrote:
>Hi,
>
>APUs with DCN 3.5 are nominally supported with kernel 6.8 but are 
>hitting a NULL pointer error at bootup.  It’s because of a VBIOS 
>change to bump to a newer version (but same structure definition).
>
>Can you please bring this to linux-6.8.y?
>
>9a35d205f466 ("drm/amd/display: Atom Integrated System Info v2_2 for DCN35")

I'll queue it up, thanks!

-- 
Thanks,
Sasha

