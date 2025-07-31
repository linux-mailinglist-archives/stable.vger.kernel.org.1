Return-Path: <stable+bounces-165606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24A8B169E0
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 03:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94633B65EE
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 01:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381F45579E;
	Thu, 31 Jul 2025 01:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcWyLb1U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB96A40BF5
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 01:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753924183; cv=none; b=GK8XzbaqoQvshsQj4YN8sDFUKMGbgWaUT0kLi5wPjDklQty7/15Ct9AC65H738mY2eXhlNBemlPJtUDgSJTTOX8AaNS911vw4lVLwgRh7xjctoqas6aDJKjUA2Y42H/+N+xq01URYpWfmjbB7tEUYe96lEIKirL2XSKjmcwq3TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753924183; c=relaxed/simple;
	bh=Sozp8d8bgQ9EktbpEgQVH/rVV6QkxLkANx+38C1fZSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyKVPFyW1ITn9bGF64f81p5QKPQsuqt5lQWXktc10thr5lx1MXqacdwmLAtXHe1N3HWvRF6dII1jOTiHRAmc3dleri/MGndlP1wnyOvah1FpbiLwoJAAAZlN9VGrgKbIr45qZMNnA06yjvfB89g6c5cSNpI6Qm6UiZAJWSw5PL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcWyLb1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35581C4CEEB;
	Thu, 31 Jul 2025 01:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753924181;
	bh=Sozp8d8bgQ9EktbpEgQVH/rVV6QkxLkANx+38C1fZSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gcWyLb1UswcXVmvjLVAfWmmJxgBidRoy6BF2/VN0XC7FEt4FNV6+6cKeGNzQO+lxJ
	 mbOCrLxxhN0abEdg1Owk3vWfvpfqqttpZvM1QCQ7mag0KxUavi0+mFgYFZZPG0/nlR
	 wQKrhypXXwWH6RsXmaSTorYT3+QSj5kuNgqB0H5i7njN1Qo5n9rEMwjGmqbuT5pKcx
	 Dy7CKW4wN6qZC/uiiWK42Djo+svzx7UXEjNk3dvJTht1pbryvKDK/3da2GP9acJMqv
	 0Qq+tQqI3bFtl0P/Z+R4YPZATup0Smz/8l38zP6xoQz6bNTBiLdhK01+iVpNn44FCh
	 cm2bo7ShRMNOA==
Date: Wed, 30 Jul 2025 21:09:38 -0400
From: Sasha Levin <sashal@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y 2/3] selftests: mptcp: connect: also cover alt
 modes
Message-ID: <aIrCUht5H3ALyGsu@lappy>
References: <1753887608-2e6325ec@stable.kernel.org>
 <bf0ed59b-c519-4aa1-b05e-160dac6b5b8f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf0ed59b-c519-4aa1-b05e-160dac6b5b8f@kernel.org>

On Wed, Jul 30, 2025 at 06:41:19PM +0200, Matthieu Baerts wrote:
>Hi Sasha,
>
>On 30/07/2025 18:28, Sasha Levin wrote:
>> [ Sasha's backport helper bot ]
>>
>> Hi,
>>
>> Summary of potential issues:
>> ℹ️ This is part 2/3 of a series
>> ⚠️ Could not find matching upstream commit
>>
>> The claimed upstream commit SHA1 (37848a456fc38c191aedfe41f662cc24db8c23d9) was not found.
>
>Is there maybe an issue with your bot? The SHA1 looks correct:
>
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=37848a456fc38c191aedfe41f662cc24db8c23d9
>
>Also the same as the one mentioned in Greg's email:
>
>  https://lore.kernel.org/2025072839-wildly-gala-e85f@gregkh

The SHA1 is correct, but it wasn't in Linus's tree until earlier today
via 8be4d31cb8aa ("Merge tag 'net-next-6.17' of
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next").

-- 
Thanks,
Sasha

