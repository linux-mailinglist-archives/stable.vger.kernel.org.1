Return-Path: <stable+bounces-83247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1BB99716B
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 18:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA861F2966F
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 16:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AD919C563;
	Wed,  9 Oct 2024 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQciDHwy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD441E1023
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490907; cv=none; b=CIqXVh0JolRiJdRbONA2tZcQj3dJuH5C3IHzhvkl5oib3LIngXvyMTm+EnqnqzkWKcO0GVo766r/L1cEOExeh2Zz608WP7h1VA38nwBVr7KkelpQaPQNYoCR3nDuUgdyK5J7xPQDoWs+WRO0RVVmZV22EGqyE2Myw/DxYZGQvuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490907; c=relaxed/simple;
	bh=/O2eSaTYLuiViorg2i3QAvPJNkwI3ZX2ZqeXlhVwKyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HA5+lSvyFvbMNxW3BXtG+E9GVu46ICyLubAikR6JfoNvH9H0wpK9dFB/7Qq81Y0DMto4wyNCrQEf4Qz7RjIGDIvqQUjvvRChaIlCgapzXz7gtEFbf/Ef9QExRQ1cajNYDhY8D/RL0MmcOrTSerWsHgH4Xu+8iZ86uoYM8F+6s3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQciDHwy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F8AC4CEC3;
	Wed,  9 Oct 2024 16:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728490906;
	bh=/O2eSaTYLuiViorg2i3QAvPJNkwI3ZX2ZqeXlhVwKyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AQciDHwylJ/KGZcLBIQRBf+TMry+4WvcVLKMuDcePaWmuM63oX3kx4F4zWzqbxYxX
	 Gs1dr60dfUgB1k/7RQ8yxhI381ReTwLsZ94yVvSpbsnpdezX6mXu4vcrrRZccDyroM
	 dmVflnZ7mn58HhIPfbziSogaJzFv1JGnfYcrIXuwVZxxphpvCY7fcLb3zNzw72sF1V
	 gTNS24kOr0xU4xQgq5qzdmG195Asx/B5gcWzlPv7nFVRWWa/WWQJ/JKQl4lr3NSOyJ
	 hGPS6pID82bteZet18wY8DNUItH8rMrO2l78iYJWZUJ8R+PoAJq3Gm9RL2hBQMHrcV
	 irtvVn/ewY1vA==
Date: Wed, 9 Oct 2024 12:21:45 -0400
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sherry Yang <sherry.yang@oracle.com>, stable@vger.kernel.org,
	jeyu@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
	ast@kernel.org, jolsa@kernel.org, mhiramat@kernel.org,
	flaniel@linux.microsoft.com
Subject: Re: [PATCH 5.10.y 0/4] Backport fix commit for
 kprobe_non_uniq_symbol.tc test failure
Message-ID: <ZwatmQ2V8xxf1dyE@sashalap>
References: <20241008222948.1084461-1-sherry.yang@oracle.com>
 <2024100909-neatness-kennel-c24d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2024100909-neatness-kennel-c24d@gregkh>

On Wed, Oct 09, 2024 at 03:36:42PM +0200, Greg KH wrote:
>On Tue, Oct 08, 2024 at 03:29:44PM -0700, Sherry Yang wrote:
>> 5.10.y backported the commit
>> 09bcf9254838 ("selftests/ftrace: Add new test case which checks non unique symbol")
>> which added a new test case to check non-unique symbol. However, 5.10.y
>> didn't backport the kernel commit
>> b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")to support the functionality from kernel side. Backport it in this patch series.
>>
>> The first two patches are presiquisites. The 4th commit is a fix commit
>> for the 3rd one.
>
>Should we just revert the selftest test instead?  That seems simpler
>instead of adding a new feature to this old and obsolete kernel tree,
>right?

Greg, I read the cover letter the same way and asked myself the same
question, but looking at the patches it's actually a fix for something
that's broken on 5.10 and was just uncovered by the selftest.

I think we should take it.

-- 
Thanks,
Sasha

