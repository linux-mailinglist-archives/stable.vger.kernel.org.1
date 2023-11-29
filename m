Return-Path: <stable+bounces-3173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1BB7FDFB6
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 19:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1929282F4E
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 18:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FFB58AB8;
	Wed, 29 Nov 2023 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irKTjjYJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4823213ADC;
	Wed, 29 Nov 2023 18:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F791C433C7;
	Wed, 29 Nov 2023 18:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701283977;
	bh=i+tnNAu21b0nbMOtwHe3q6NcoSc0Q1WYLCCmqoKWGwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=irKTjjYJOQIJbNq4/Whhe2qIpO4klLOy0EWRMznhCA91rkjPKGwml13f3EBo6exim
	 5mLa4WCygkal7wSF/iYImgIu9fctpwyjUB/34O65/nZ4TdNCl4kdhadanRXhMHTgHH
	 4K+kNqLAH7gyezXtUb+uHD+tuFdDgCO47plskG/zUlalajf9mDGL5Iz4nAai3OOHSs
	 33ebTSRik78ylVIw3pFzY919gs6rZ3K12NXJT1I4bj5wBe4B9ANn5V4wUPiys28JRY
	 H3cb1tl6yfafJd6Pzh8CntWLQ1jvhBZJFQMYlikCIg1WVmNpasXXx1lQaqxRaWyHvL
	 uAXC8F6Aycq6g==
Date: Wed, 29 Nov 2023 13:52:56 -0500
From: Sasha Levin <sashal@kernel.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
	stable-commits@vger.kernel.org, stable@vger.kernel.org,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@lists.linux.dev
Subject: Re: Patch "dm delay: for short delays, use kthread instead of timers
 and wq" has been added to the 6.6-stable tree
Message-ID: <ZWeIiCcZXwZkY1_J@sashalap>
References: <20231129025441.892320-1-sashal@kernel.org>
 <cac7f5be-454c-5ae1-e025-9ad1d84999fc@redhat.com>
 <bdf739ae-5e45-4192-b682-81f05982c220@arm.com>
 <30e67bef-4aaf-31d6-483f-2ca6523099c3@redhat.com>
 <ZWd3HCVNTkZYREGo@sashalap>
 <b8d0fdf7-fca4-4a2d-3dd-94b2c97b7fb4@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b8d0fdf7-fca4-4a2d-3dd-94b2c97b7fb4@redhat.com>

On Wed, Nov 29, 2023 at 07:16:52PM +0100, Mikulas Patocka wrote:
>
>
>On Wed, 29 Nov 2023, Sasha Levin wrote:
>
>> On Wed, Nov 29, 2023 at 06:28:16PM +0100, Mikulas Patocka wrote:
>> >
>> >
>> >On Wed, 29 Nov 2023, Christian Loehle wrote:
>> >
>> >> Hi Mikulas,
>> >> Agreed and thanks for fixing.
>> >> Has this been selected for stable because of:
>> >> 6fc45b6ed921 ("dm-delay: fix a race between delay_presuspend and
>> >> delay_bio")
>> >> If so, I would volunteer do the backports for that for you at least.
>> >
>> >I wouldn't backport this patch - it is an enhancement, not a bugfix, so it
>> >doesn't qualify for the stable kernel backports.
>>
>> Right - this watch was selected as a dependency for 6fc45b6ed921
>> ("dm-delay: fix a race between delay_presuspend and delay_bio").
>>
>> In general, unless it's impractical, we'd rather take a dependency chain
>> rather than deal with a non-trivial backport as those tend to have
>> issues longer term.
>>
>> --
>> Thanks,
>> Sasha
>
>The patch 70bbeb29fab0 ("dm delay: for short delays, use kthread instead
>of timers and wq") changes behavior of dm-delay from using timers to
>polling, so it may cause problems to people running legacy kernels - the
>polling consumes more CPU time than the timers - so I think it shouldn't
>go to the stable kernels where users expect that there will be no
>functional change.
>
>Here I'm submitting the patch 6fc45b6ed921 backported for 6.6.3.

Is this okay for 6.1 too?

-- 
Thanks,
Sasha

