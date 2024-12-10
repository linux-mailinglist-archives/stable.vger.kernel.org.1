Return-Path: <stable+bounces-100452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EAD9EB5C1
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 17:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16DC280FE4
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 16:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D121B1C07EC;
	Tue, 10 Dec 2024 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWjHv3qI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B57C23DEBB;
	Tue, 10 Dec 2024 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847192; cv=none; b=PXWaCln+glcYh2vvf42Qs4GQ88GgaGFByJnYgfV549fQojP7q+kM01MatOXzGtPsFPDuzLodIvALjQ3We7dRsFyytpfWVlGaKUbMXQUi6ljKRuaeFZw6PCIlHjI9MShlClNsbD7//fXsC7xIGPO1fslEVsKZ8CuAJOPhGu2dL0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847192; c=relaxed/simple;
	bh=7PreuL+BnmocFlVQc2B6hkzpUB6uv0LOdMIXrzrjPiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9P3lxeI/EMV3FV3dN01jF0Yz93S9aNOp7yU43MsovvGO+iaPh7gI4vkvycfQcmVUDe7tKjqvUYxyhE0ccuuZUmocz4GWGcGvp4Lc1w9+CluzI+Vva4EOdgMyZpAQpisSmkz8E5Cy72/DNlbNKPunHAf/wvA4tycIVpeFj12NRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWjHv3qI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE031C4CED6;
	Tue, 10 Dec 2024 16:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733847192;
	bh=7PreuL+BnmocFlVQc2B6hkzpUB6uv0LOdMIXrzrjPiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hWjHv3qITm7s8ybB3RzHbk6192/o1oY+VrniIS3GiTkOA7lX54iHWEs4Ip2iYh0A2
	 XjYz3Wp5KgDE9VHdAeRJICoRqsQXfxzNV1oJV8ABq5lzYsC7TI4As5pvETePHsW6AP
	 liDyNF7KBGku+17BgDqaDP/p8cGJ9qpXdMmitPLpWqETrUDmjGL4cr71wo95A9n5b6
	 iCwsFahE8aRo+6rPJluswqoBYBeGeK6oqgIqop9StJt97Uf6yaEWUR0/TAmcUTIYSA
	 o9XJ3toxvKluFdzuOFKXlX66u384EKE+J7Qd+bAdZSF+GJUPKExvoTXiZ2pHbBC/v5
	 SL/VHNPhA1NQg==
Date: Tue, 10 Dec 2024 11:13:10 -0500
From: Sasha Levin <sashal@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee@kernel.org>,
	Chris Morgan <macroalpha82@gmail.com>
Subject: Re: [PATCH AUTOSEL 6.12 15/36] mfd: axp20x: Allow multiple regulators
Message-ID: <Z1holqqKpVPMu7zj@sashalap>
References: <20241204154626.2211476-1-sashal@kernel.org>
 <20241204154626.2211476-15-sashal@kernel.org>
 <e34a5b25-95c8-4111-baf1-c5ac4ad66cff@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e34a5b25-95c8-4111-baf1-c5ac4ad66cff@arm.com>

On Sat, Dec 07, 2024 at 09:34:27PM +0000, Andre Przywara wrote:
>Hi Sasha,
>
>
>On 04/12/2024 15:45, Sasha Levin wrote:
>>From: Andre Przywara <andre.przywara@arm.com>
>>
>>[ Upstream commit e37ec32188701efa01455b9be42a392adab06ce4 ]
>
>can you hold back those backports, please? Chris reported a regression
>in mainline[1]. He is working on a fix, but it doesn't look like to be
>trivial. In fact we only really need this patch for an upcoming board
>support, so there isn't an immediate need in stable kernels anyway.

I'll drop it, thanks!

-- 
Thanks,
Sasha

