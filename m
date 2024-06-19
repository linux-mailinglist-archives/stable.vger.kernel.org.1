Return-Path: <stable+bounces-54644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA34590F088
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 16:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63643282820
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 14:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF0910A03;
	Wed, 19 Jun 2024 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiyQRlp9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4E623775;
	Wed, 19 Jun 2024 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807428; cv=none; b=vASi1CSUGUI5JJDx3cIRnlnPTWL1rcQsoTV9RKUQWgtC93c7juGIwYND6GkR3MEbh6oAxrWltSX6en1bu+9dGU2wmnSvnqBXM++WXCkqbUm730mAHuLXuE6kYhwKpn0DqD71Msqs5QqtZTtqGP4vw41lcxou+hqawJrWyE/w7J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807428; c=relaxed/simple;
	bh=5P4+U94Sj+hrx7FTYMGgX4hD00hQheT4KmraZdUEYZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBChMv0VJTKnFsS5OOoN3bfhCec7RZXX3ThrYu4PfZ1JknlVF6AwbzQ/7hbRIn1QTp4XinkDr2ZV4WcgmxFZo4w31R9Ryag6+AuzAH6cQ+ii3k+jXdo25FB+Puom9EU7x8mzu6qfHdEQGiDPNdFBWGSagc13VpwpjvM3OrSWiIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiyQRlp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9479EC2BBFC;
	Wed, 19 Jun 2024 14:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718807427;
	bh=5P4+U94Sj+hrx7FTYMGgX4hD00hQheT4KmraZdUEYZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CiyQRlp9GSAIxk7ym3Xfl08V9zmLHG9z9EicTuHhXcckzp4MxAB/Vjqs5Jyq59MJi
	 jkk5XZzmEZEWMpQABr6UjiQuHmWAlahX8ch3QJacJi9vpLkZ18NdBv+MUHfGmK0wEQ
	 h+irmSwp3MA/fiG8VDUMzci2gh0bsGk3RtMAj21zPxOEsBHZ1pu3I6xWyioQkIyuku
	 hv40ls0BfUgw7oYiRvbJO7aayLt6Kt+a3AT/yRuxDkkLecs1seXObPB8MTn7wtS94+
	 5hUDuYYbfPODY0eGMuRMlLghxl7c4JCx3fpE+JVZZ6HFpW4QjeIZ86iMMVUOJdjGYd
	 uehKS7xw1tt5Q==
Date: Wed, 19 Jun 2024 10:30:25 -0400
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
Message-ID: <ZnLrgSFIdWAcTQp3@sashalap>
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

