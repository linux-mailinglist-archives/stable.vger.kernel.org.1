Return-Path: <stable+bounces-6362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 453CC80DB3A
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 21:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30851F21BB3
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 20:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5202537FA;
	Mon, 11 Dec 2023 20:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SScVRwsT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ABCC4;
	Mon, 11 Dec 2023 12:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702325081; x=1733861081;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=u7WIoZL1yu8n/RbFr78cdrCkBy8k+lLJ8cXUWzPfLSE=;
  b=SScVRwsTSUXZRfV4p0wi9kDvzxxrAu7Cpg3gbsPPEnrrKj2WrqQiJ4u4
   Sit/KwcBQxm2DFXxoYU9FIJjpwlyPCnRPhIxN/DjYc2Q9woear9TWBZu7
   E2qAUt6rytHhWHyxY7nCetg5FpxB9ipUQSwOqV9VHTXRQEGq3OkbvXdQ/
   vxMvvCvu+WvudhcjHskVJb7sEMUNAfTvDywd9F3BYpvGLWIhkw65iAOq6
   XkdROhnkh4Jf1bFXxSyZACGqjOBK5v/vwuoJPgi0fMR0z8fkXlpOUqt/p
   j/pokXBPUa1NuyddkYFeZ1uC3XRj/FA0kLjX0MWK/MU44DAiJX0RCdKVq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1848060"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="1848060"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 12:04:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="21217094"
Received: from kbalak2x-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.63.68])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 12:04:36 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable-commits@vger.kernel.org, ville.syrjala@linux.intel.com,
 stable@vger.kernel.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tvrtko.ursulin@linux.intel.com>, David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>
Subject: Re: Patch "drm/i915: Call intel_pre_plane_updates() also for pipes
 getting enabled" has been added to the 6.1-stable tree
In-Reply-To: <ZW4raf5GE24YZX0B@sashalap>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231204104250.2009121-1-sashal@kernel.org>
 <87il5e2owb.fsf@intel.com> <ZW4raf5GE24YZX0B@sashalap>
Date: Mon, 11 Dec 2023 22:04:33 +0200
Message-ID: <875y14y08e.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 04 Dec 2023, Sasha Levin <sashal@kernel.org> wrote:
> On Mon, Dec 04, 2023 at 01:22:28PM +0200, Jani Nikula wrote:
>>On Mon, 04 Dec 2023, Sasha Levin <sashal@kernel.org> wrote:
>>> This is a note to let you know that I've just added the patch titled
>>>
>>>     drm/i915: Call intel_pre_plane_updates() also for pipes getting enabled
>>>
>>> to the 6.1-stable tree which can be found at:
>>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>>
>>> The filename of the patch is:
>>>      drm-i915-call-intel_pre_plane_updates-also-for-pipes.patch
>>> and it can be found in the queue-6.1 subdirectory.
>>>
>>> If you, or anyone else, feels it should not be added to the stable tree,
>>> please let <stable@vger.kernel.org> know about it.
>>
>>Turns out this one requires another commit to go with it, both for
>>v6.7-rc* and stable backports. I was just a bit too late with it for
>>v6.7-rc4 [1].
>>
>>Please hold off with all stable backports of this until you can backport
>>
>>96d7e7940136 ("drm/i915: Check pipe active state in {planes,vrr}_{enabling,disabling}()")
>>
>>from drm-intel-fixes with it. It should find its way to v6.7-rc5.
>>
>>Thanks, and sorry for the mess. :(
>
> No worries, and thanks for letting us know. I'll drop this patch from
> all trees.

It should be fine to backport

d21a3962d304 ("drm/i915: Call intel_pre_plane_updates() also for pipes getting enabled")

to stable kernels as long as it's accompanied by

96d7e7940136 ("drm/i915: Check pipe active state in {planes,vrr}_{enabling,disabling}()")

which is now in v6.7-rc5.


Thanks,
Jani.




-- 
Jani Nikula, Intel

