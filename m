Return-Path: <stable+bounces-161792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 728CEB0343B
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 03:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A482E18952F4
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 01:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463811465A1;
	Mon, 14 Jul 2025 01:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWUYeGI5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BFF944F
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752457830; cv=none; b=dBo4ElO625l2W5sugh1nYSuiDkAOPWsulR3E1bBLmL3V0hMq7VUEhCwNq22Hy5L2J/lDlynZvf61nunwjCB2ANwrhlMGZld9WQVR9HTFMaLG8+KmksHtgtUfuO3YoGH6YzCmytUnPhNjyEQBGj6wEDugg9bkb6wLouo6nKK9L3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752457830; c=relaxed/simple;
	bh=wfMJ5XYI5fG9Nro4Aa8x0GVVZ7Uf4KP0SfiWmecyu5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOGKQRkH2MaPX53g9XP1BlUTSRdIJISIVSVp+nmr0dCctGOR3PVMREnpvTEihmzqPH4Y1nlgRbMJ+Ey0Cldo3HXhCMvFBW9nNpLwCioxJuZB2pPrS19XlVz7tHie1zImIhqZELWzg56RY8IDNzpmWBy4vVT0uqPgslpwmYtPva0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWUYeGI5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B85CC4CEE3;
	Mon, 14 Jul 2025 01:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752457829;
	bh=wfMJ5XYI5fG9Nro4Aa8x0GVVZ7Uf4KP0SfiWmecyu5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RWUYeGI5k7hjN3LxhSltH39BNMZF/1UP0CtLP/pNop5Iol7wYS4vHUqSnZYrZ11nz
	 JNHT2odhWNlHXgz0pCpFIKYl+X7KmCQyQvuSolJHEUb90Opcf2W2jdpqckR1fl5PXk
	 FJd4vBnB63SPqvyB6Y2KB1Y5UtSmywV2gHrNTLj2kuF1tgdG5zgQAtouyVVe9+6KFK
	 fMejLMYmNVweiEpAgyVt7oZcO0cqfqA7qEzlzABy//j78qvNxwV8CZ4Xhy6h2FTvUE
	 PKgb4csyubIG1euW28lWcvICI0b2dlXUVXeJNgqVwyZlWAoqEr34wrslaPwetV37cT
	 +Beh/o9PiLn1w==
Date: Sun, 13 Jul 2025 21:50:25 -0400
From: Sasha Levin <sashal@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15-stable] x86/CPU/AMD: Properly check the TSA microcode
Message-ID: <aHRiYX_T-I--jgaT@lappy>
References: <20250711194558.GLaHFp9kw1s5dSmBUa@fat_crate.local>
 <20250712211157-88bc729ab524b77b@stable.kernel.org>
 <20250713161032.GCaHPaeCpf5Y0_WBiq@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250713161032.GCaHPaeCpf5Y0_WBiq@fat_crate.local>

On Sun, Jul 13, 2025 at 06:10:32PM +0200, Borislav Petkov wrote:
>Dear Sasha's backport helper bot,
>
>On Sun, Jul 13, 2025 at 09:06:05AM -0400, Sasha Levin wrote:
>> [ Sasha's backport helYper bot ]
>>
>> Hi,
>>
>> Summary of potential issues:
>> ⚠️ Could not find matching upstream commit
>>
>> No upstream commit was identified. Using temporary commit for testing.
>
>I think you need to be trained more to actually read commit messages too.
>Because there it is explained why.

I'll add "stable-only" as a filter, but you have to promise using it on
all of these backports going forward :)

-- 
Thanks,
Sasha

