Return-Path: <stable+bounces-54645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AA490F09D
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 16:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F4028502B
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 14:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDF71B948;
	Wed, 19 Jun 2024 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFrTmS1n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF1D11C92;
	Wed, 19 Jun 2024 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807525; cv=none; b=knMAPWUpHyNjKRdOJHDSNOxuScz7a6DeicHC1tlDLtpdsUY7qI083g8/Wyp+WAQNfDtls1Lil4vyuAhyogmp69G0ojH+q827mNG4RZ1HMv3HX5EjuxPoVOeMjL80ab5k/Tv+WpLriQrnoPw/UmzgliQvs0KsSaJBHxtr7nzMaNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807525; c=relaxed/simple;
	bh=5P4+U94Sj+hrx7FTYMGgX4hD00hQheT4KmraZdUEYZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZaey7PxwQVt4zFBDWmxcu327RNV+Y3NHaqIaxlDl9X3Asvlivi3oLLCY5+OHKMCde+tR2INPRFCN4Mr1YoGFCFHj5rnTh1r2o3ADHS0E713SWnGIeBl85TRqNiXgDUE5jppUy3m/yADigxkThkaeROe6SBD1whGX0z6/urjJEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFrTmS1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE1BC2BBFC;
	Wed, 19 Jun 2024 14:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718807525;
	bh=5P4+U94Sj+hrx7FTYMGgX4hD00hQheT4KmraZdUEYZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BFrTmS1nAs54AIbQRFZWX6lLQQAx8iDngpm6hPCbqM/x2FF0WG8GEifv6OBwWMy63
	 QLX8gIuxc4F8/AU2zqq+8lzI+csN2fj+rExfrSaQHK0Thz7r2G9rP5EhglR4a4LIgN
	 GICcPGSZlt6gXYBe5uUZSaY0XCDFRbE581EkN8dytKB4p8c106gwdijV3OrZq3vFHD
	 bLfpJyZHsZN8XqgAFkZpyBmQV0TCNPbTTRPCKjXP0J2lgso5AF/PVbWVPfVVKItnnx
	 WXCH97MarRhZvHnHtNODnhxQBFoYbPN4RqrARkKyvsVdn84Z6qNBPl58dO2gLlSMqC
	 2vynCwPOKRd1A==
Date: Wed, 19 Jun 2024 10:32:03 -0400
From: Sasha Levin <sashal@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Pavel Machek <pavel@denx.de>, Sourabh Jain <sourabhjain@linux.ibm.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	hbathini@linux.ibm.com, bhe@redhat.com, akpm@linux-foundation.org,
	bhelgaas@google.com, aneesh.kumar@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Naveen N Rao <naveen@kernel.org>
Subject: Re: [PATCH AUTOSEL 6.9 18/23] powerpc: make fadump resilient with
 memory add/remove events
Message-ID: <ZnLr4_0RX-c7m7Zo@sashalap>
References: <20240527155123.3863983-1-sashal@kernel.org>
 <20240527155123.3863983-18-sashal@kernel.org>
 <944f47df-96f0-40e8-a8e2-750fb9fa358e@linux.ibm.com>
 <ZnFQQEBeFfO8vOnl@duo.ucw.cz>
 <87a5jhe94t.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87a5jhe94t.fsf@mail.lhotse>

On Wed, Jun 19, 2024 at 04:31:30PM +1000, Michael Ellerman wrote:
>Pavel Machek <pavel@denx.de> writes:
>>> Hello Sasha,
>>>
>>> Thank you for considering this patch for the stable tree 6.9, 6.8, 6.6, and
>>> 6.1.
>>>
>>> This patch does two things:
>>> 1. Fixes a potential memory corruption issue mentioned as the third point in
>>> the commit message
>>> 2. Enables the kernel to avoid unnecessary fadump re-registration on memory
>>> add/remove events
>>
>> Actually, I'd suggest dropping this one, as it fixes two things and is
>> over 200 lines long, as per stable kernel rules.
>
>Yeah I agree, best to drop this one. It's a bit big and involved, and
>has other dependencies.

I'll drop it, thanks!

-- 
Thanks,
Sasha

