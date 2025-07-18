Return-Path: <stable+bounces-163361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F7EB0A3E0
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 14:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2018D7B357E
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 12:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F38D2D9498;
	Fri, 18 Jul 2025 12:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bu1XiidS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DB1215F42
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752840719; cv=none; b=BPOBKm7jGy3DaVkRG/lu/mIEXwCsmBvyEKOJpbrJH49M/ms8CaVaaPHG9ClT9vAhuH/lWLitEosVLFfP/11d1FyfcwHXJZfrJjTdscN9WfjUxVM29WXl1zWJYTf3lVWE3iyLZIOEaumcbJ6sXWnfEnptvKLqO6wiY+WsKaBHoVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752840719; c=relaxed/simple;
	bh=H5ulg1D2PmncouZNIkGRBL1+pMnm+it1GrK3QReAB1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCP5cKmFCEVVLZWgqF7NZFZanGa/orJpae0mPeaZRXSYL6nkWPGG1Xpn4vw1OOuk6mH4JKM4Fym6YsmDCWRYfIse3aOWbYqjv1K32rSLc95q+FTK+lirUtjNtR+Bcbep6XC8mNIMqIhy2hAhsv22gLHGkugDAhH3/thN7osf7bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bu1XiidS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6A3C4CEEB;
	Fri, 18 Jul 2025 12:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752840718;
	bh=H5ulg1D2PmncouZNIkGRBL1+pMnm+it1GrK3QReAB1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bu1XiidSZ4QUlYJJV9Wnh20gSobcZ5Muca6GZbLuNdSVuTO1r6++hjWiP4zXVf54R
	 +bEYxLZwk/z797SflIcDOsqgICVj5+8kP0eSOQN3PI2xStyRv8YqagcU7Mi1meWPjm
	 mnqaiWD3ftPkgr//zwgeSgewIvMUbolt0vrMLEZzpb9Cy0eZihzoTooiHVc7BqXfP1
	 jj1jTeBJdruW7e6vdT3JnVrxV/DgDsB9ZdnpK0ZC1UHqxkUgDCnhKerkNAYLB50B7U
	 CvFfSN9gI6OXQAZWANxrxzCIHqnhXrgOAvAH2NnsduVOlPNgJBmVw1uKFaeu5ZATUt
	 7FtbLp5JnN3/g==
Date: Fri, 18 Jul 2025 08:11:56 -0400
From: Sasha Levin <sashal@kernel.org>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1] crypto: qat - fix ring to service map for QAT GEN4
Message-ID: <aHo6DEwZHkedlwZE@lappy>
References: <20250717170835.25211-1-giovanni.cabiddu@intel.com>
 <1752795908-8533c229@stable.kernel.org>
 <aHnvq5RvK/UC7h15@gcabiddu-mobl.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHnvq5RvK/UC7h15@gcabiddu-mobl.ger.corp.intel.com>

On Fri, Jul 18, 2025 at 07:54:35AM +0100, Giovanni Cabiddu wrote:
>Hi Sasha,
>
>On Thu, Jul 17, 2025 at 09:34:36PM -0400, Sasha Levin wrote:
>> [ Sasha's backport helper bot ]
>>
>> Hi,
>>
>> Summary of potential issues:
>> ⚠️ Found follow-up fixes in mainline
>>
>> The upstream commit SHA1 provided is correct: a238487f7965d102794ed9f8aff0b667cd2ae886
>>
>> Status in newer kernel trees:
>> 6.15.y | Present (exact SHA1)
>> 6.12.y | Present (exact SHA1)
>> 6.6.y | Present (different SHA1: 82e4aa18bb6d)
>
>This patch applies only to the v6.1.y kernel, as it is already present
>in the other long-term stable branches.

Yup - this part just verifies that the patch exists in all never trees.

>> Found fixes commits:
>> df018f82002a crypto: qat - fix ring to service map for dcc in 4xxx
>
>Regarding the follow-up fix:
>
>  df018f82002a crypto: qat - fix ring to service map for dcc in 4xxx
>
>Not sending this to stable is intentional.
>
>The QAT driver in v6.1 does not support the DCC (data compression
>chaining) service, which was introduced later in kernel v6.7 with commit
>37b14f2dfa79 crypto: qat - enable dc chaining service.
>
>The original fix (a238487f7965 crypto: qat - fix ring to service map for
>QAT GEN4) was supposed to address the problem also for DCC (as it landed
>after the introduction of that service), but did not. Therefore the
>follow-up fix df018f82002a was merged in kernel v6.9.
>
>Hope this clarifies.

That helps, thanks!

-- 
Thanks,
Sasha

