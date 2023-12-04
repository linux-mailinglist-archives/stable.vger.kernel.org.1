Return-Path: <stable+bounces-3907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BEA803E93
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 20:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314D2281150
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 19:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2409631751;
	Mon,  4 Dec 2023 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANWs+TIf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BF52E847
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 19:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA421C433C7;
	Mon,  4 Dec 2023 19:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701718891;
	bh=3C0nPZo9CCHmXGvbhUfVNnJa+k7CGkGWbImyARSlMsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ANWs+TIfhQ8ApqGE4Ht8uvpSQryDFWTWu9jIuaDk1uNyzwX3hmkWzS969XR3jKVuc
	 FpW5KS/qwdAgtR/W4N80LouZSgZv1KmkAgtHrTgWS94S36Rqy1NTE66YEALBIt7+Hd
	 qKbYrAD9I31v5Y3V1+xSHEEMbYQZIKA/DR51i5FhYwJSroiraO0rN9ch9fGqEsAo/T
	 MO5pwwGmrzXiVawHDPhT7FQLfvstHhYRG6zsEnUpqS6zZaq+8XFlQAev1nxpC5t7c9
	 im2gVchMvcktTzABe2naJCX/eaFfp0whkZ3uFU9YP7qzrhbonRQMmXEJhX4atgeE85
	 3I3uUYQdnvM+g==
Date: Mon, 4 Dec 2023 14:41:29 -0500
From: Sasha Levin <sashal@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: stable-commits@vger.kernel.org, ville.syrjala@linux.intel.com,
	stable@vger.kernel.org,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: Patch "drm/i915: Call intel_pre_plane_updates() also for pipes
 getting enabled" has been added to the 6.1-stable tree
Message-ID: <ZW4raf5GE24YZX0B@sashalap>
References: <20231204104250.2009121-1-sashal@kernel.org>
 <87il5e2owb.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87il5e2owb.fsf@intel.com>

On Mon, Dec 04, 2023 at 01:22:28PM +0200, Jani Nikula wrote:
>On Mon, 04 Dec 2023, Sasha Levin <sashal@kernel.org> wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     drm/i915: Call intel_pre_plane_updates() also for pipes getting enabled
>>
>> to the 6.1-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      drm-i915-call-intel_pre_plane_updates-also-for-pipes.patch
>> and it can be found in the queue-6.1 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>
>Turns out this one requires another commit to go with it, both for
>v6.7-rc* and stable backports. I was just a bit too late with it for
>v6.7-rc4 [1].
>
>Please hold off with all stable backports of this until you can backport
>
>96d7e7940136 ("drm/i915: Check pipe active state in {planes,vrr}_{enabling,disabling}()")
>
>from drm-intel-fixes with it. It should find its way to v6.7-rc5.
>
>Thanks, and sorry for the mess. :(

No worries, and thanks for letting us know. I'll drop this patch from
all trees.

-- 
Thanks,
Sasha

