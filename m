Return-Path: <stable+bounces-94043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098069D296F
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 16:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1EF8281E23
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556F013AD05;
	Tue, 19 Nov 2024 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDIyBT/B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E8D199B9
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732029504; cv=none; b=nJa18DpMLZDp/anBFHIJEWQZMfSCheX1zoF88T2k9p5T1lK9jAku2Bgz26PnzzzQWIFmsNkXVmgytAE2lKYxwLVbYEm1EOw1cmc9cwLv+n7Jo0HHI1RQLhNdFG7LzJ5tnGughZXhfWGhLW5TvAQxc+CRrCfv1VSiCE2hTG5paeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732029504; c=relaxed/simple;
	bh=/KPnlSQPt+Hisr8m28KjNebHF/tDgIcjBgy1/vOi2Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5UAE8cF9oUQeydMprJO03KgfDxTWtpcGtBMRd8cKZw/Pk4X+Ko0cFLIGRgUDlm1yFkqBxm8aSrKfmu7agcEPUQr6McfVT2ugyIUbJh1FDp9tv1pyPrRMGGY6+MmOeWtlA3KulHm8LiNqO/K2NcUbmgz7b0pMZ8rFCq/iER6efQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDIyBT/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6322EC4CECF;
	Tue, 19 Nov 2024 15:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732029503;
	bh=/KPnlSQPt+Hisr8m28KjNebHF/tDgIcjBgy1/vOi2Sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BDIyBT/BSMzRTgiSPQOo73TrKOKdZiUVwb3DY6CGRhgdYn3Zcjry2k3y63b2Dkuxx
	 DelPuXiB/URNXdXs1bCrOnrECWZLym70qWBGpq+wypWbm4zTmZfkGRi9TZ6ASS0wvj
	 Jym5UXiKLbmJeCoRhhhTAXM9DleSvRnuw+Yq5VYZXMV4Wa/eOw2kU1M4MlgZYkYXVj
	 knA5dp4N/inYrgn8IiK7Bkrxzi/UQFOeAdeZide4Wa2RiuzKuTqLzZh7PCmive3Stg
	 rUM4m0v2+ANl68DbgHyyYl0BaQ/ioes8WQlpItuXLSWcmAIzIeiNzw6mspEtI9NENb
	 3+yW/KjYoNA6g==
Date: Tue, 19 Nov 2024 10:18:22 -0500
From: Sasha Levin <sashal@kernel.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: stable@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: Re: [PATCH 6.1.y v2 3/4] mm: refactor arch_calc_vm_flag_bits() and
 arm64 MTE handling
Message-ID: <ZzysPgiWqzxa7fx5@sashalap>
References: <fb0aeea7eb024efb92c512a873f40aa6ab27898a.1731946386.git.lorenzo.stoakes@oracle.com>
 <360e3143-28ed-46e4-8064-12aa03aaccf1@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <360e3143-28ed-46e4-8064-12aa03aaccf1@oracle.com>

On Tue, Nov 19, 2024 at 12:40:03PM +0530, Harshit Mogalapalli wrote:
>Hi Sasha,
>
>On 19/11/24 10:06, Sasha Levin wrote:
>>[ Sasha's backport helper bot ]
>>
>>Hi,
>>
>>The upstream commit SHA1 provided is correct: 5baf8b037debf4ec60108ccfeccb8636d1dbad81
>>
>
>Nice bot!
>
>Just few thoughts:
>
>>Commit in newer trees:
>>
>>|-----------------|----------------------------------------------|
>>| 6.11.y          |  Present (different SHA1: 9f5efc1137ba)      |
>>| 6.6.y           |  Not found                                   |
>>| 6.1.y           |  Not found                                   |
>>|-----------------|----------------------------------------------|
>>
>
>
>Given that this patch is for 6.1.y, it(6.1.y) need not be considered 
>as newer tree I think ?

I've kept it in just because sometimes we might do the backport
ourselves and then someone else will send another backport. I agree that
this could be clearer :)

>Also the backport for 6.6.y is present on lore.stable [1], so the 
>backport not being present in stable-6.6.y might be not very useful, 
>as it is possible for people to send the backport to multiple trees in 
>the same stable update cycle(before 6.6.y has the backport included) 
>-- instead could we run this while queuing up(maybe warn if it is 
>neither present in stable-queue-6.6 nor in stable-6.6.y ?) ?

Yeah... Automation is a work in progress. Ideally one day this will turn
into the backend of a dashboard that'll keep track of outstanding
backports.

-- 
Thanks,
Sasha

