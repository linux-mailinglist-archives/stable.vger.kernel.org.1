Return-Path: <stable+bounces-83442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD42499A383
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 14:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C855281B9E
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 12:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CF9216A0B;
	Fri, 11 Oct 2024 12:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGWltYYN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B63215F55
	for <stable@vger.kernel.org>; Fri, 11 Oct 2024 12:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648807; cv=none; b=S1ydYjWm0XGDvcltDtgdJBlswXmwEp/0MWowaqb21rm+5aztdevTR84Y6yh8en9BcjCL1JdJ5QR3GOYH//N/tGiVikx01Uv7BWel2KsO0T80qixl0OUGRmvhzmLmT/xOJVqqycYgyW+2W3ESVSUyVLyZxweyNkeIqJKvQDLQtVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648807; c=relaxed/simple;
	bh=HCLPY4ySjPKAZgNliDyP37Pk1kRu4x5jEZJh8SnVrUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8rhUiVWA0OgGMdsm9R903X8jE7aI3dhlKkCzp9RqrA5Wa2CbXPVoTRoCGVOhD/bqAJGbunXjv+AU9max6HgS0ue37aw6iiqz99e8atczul9NF3krQQG3UKzXtepuaMaX+9Bu0mGx6pB1I3vmQ9IG8fBGfVp3tlmFGukbclTGPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGWltYYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7CAC4CEC3;
	Fri, 11 Oct 2024 12:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728648806;
	bh=HCLPY4ySjPKAZgNliDyP37Pk1kRu4x5jEZJh8SnVrUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OGWltYYNPxSobjiSp7dyWYBh22cjuf9KMKhMr4kYthpnfUnTEDBN/gwwRdHb2GcE1
	 W3FkG6PgX+musw/cznRUOdGWJukjU+n9q8xjWUOVoetvu+OZMSnCq8US6VF2NygDy4
	 6o1lxqavRvyDl64N2TERJ/I3IneIrFB0Cs/LNPWy3lw9ZYDJFdmpEyknJDf7IrkJsP
	 VETJNlKXBc/bAk+etxriiJL/LxVJXBVkJdaRgFr7EXyipsSZnJf+2QX7rndG+BFjXO
	 AMtHwmMtqIHC8YNCnVw8AbzDTWJwDqfVa7u0o66vy0VPJkB0RKOSMFCPevluHQb0gn
	 c2Yv+nwHrv6jQ==
Date: Fri, 11 Oct 2024 08:13:24 -0400
From: Sasha Levin <sashal@kernel.org>
To: Francis Laniel <flaniel@linux.microsoft.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Sherry Yang <sherry.yang@oracle.com>,
	linux-stable <stable@vger.kernel.org>,
	"jeyu@kernel.org" <jeyu@kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>
Subject: Re: [PATCH 5.10.y 0/4] Backport fix commit for
 kprobe_non_uniq_symbol.tc test failure
Message-ID: <ZwkWZHfJRtKSewVq@sashalap>
References: <20241008222948.1084461-1-sherry.yang@oracle.com>
 <2024100909-neatness-kennel-c24d@gregkh>
 <D36D144A-02BB-4F79-B992-00C2BF6FB8C9@oracle.com>
 <2204888.irdbgypaU6@pwmachine>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2204888.irdbgypaU6@pwmachine>

On Fri, Oct 11, 2024 at 01:30:28PM +0200, Francis Laniel wrote:
>Hi!
>
>Le jeudi 10 octobre 2024, 18:11:51 CEST Sherry Yang a écrit :
>> > On Oct 9, 2024, at 6:36 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> >
>> > On Tue, Oct 08, 2024 at 03:29:44PM -0700, Sherry Yang wrote:
>> >
>> >> 5.10.y backported the commit
>> >> 09bcf9254838 ("selftests/ftrace: Add new test case which checks non
>> >> unique symbol")
> which added a new test case to check non-unique symbol.
>> >> However, 5.10.y didn't backport the kernel commit
>> >> b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches
>> >> several symbols")to support the functionality from kernel side. Backport
>> >> it in this patch series.
>
>> >> The first two patches are presiquisites. The 4th commit is a fix commit
>> >> for the 3rd one.
>> >
>> >
>> > Should we just revert the selftest test instead?  That seems simpler
>> > instead of adding a new feature to this old and obsolete kernel tree,
>> > right?
>>
>>
>> Sorry about the confusion. If kprobe attaches a function which is not the
>> user wants to attach to, I would say it’s a bug. The test case uncovers the
>> bug, so it’s a fix.
>
>> Sherry
>>
>>
>
>Let me add a bit of context as I wrote the third patch of this set.
>
>It all started with a problem I had when trying to trace symbol names
>corresponding to different functions [1].
>The patch was accepted to upstream and I wanted to backport it to stables.
>Sadly, the patch itself was relying on other patches which were not present in
>some stable kernels, which leaded to various problems while releasing the new
>stable kernels (once again: sorry about having caused troubles here) [2]...
>
>The current series seems to hold all the patches for the third one to work, so
>I guess we can now have it merged to stable without problems.

Queued up, thanks!

-- 
Thanks,
Sasha

