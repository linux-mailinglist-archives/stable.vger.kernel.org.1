Return-Path: <stable+bounces-108579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F06A102F0
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 10:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FCF9167D5D
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 09:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADB128EC6B;
	Tue, 14 Jan 2025 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bla/8NyJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3A8284A71
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736846555; cv=none; b=lghtgtkli5FdFQFm1M0L1nb1tyXtzqAeL+mpMd32fc1KGimEPahvcS00uhy0MV1AbGn27WK5yV4c8JDrFs7uIERxHnQiUPo5w3YJRh4CF4ZYcC1+IpAqDEB9hq4BHN5l90fwnKzbqHjukac8fTDH3a9ESfP+cmdyDMOHF3xEtms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736846555; c=relaxed/simple;
	bh=jM3aQF/V7ROCNUJbA5YlAjn0Z2uHE1HMCotaEhPYWv0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cmGrzd8ebXLql29OJTO2b97tZdR70Ay8TQVPeVdqpltsvt6DQlTtygnFvABDEBINIh6MqBsAaO/UPlkAIZNQu+O11Y9JUeK9/3HlcHComl5k1grbFmpI0no1n/j+3SyVuRoV5LnblP3yDv3RPavCqIEOToZ10ULqJiOIrE1VFRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bla/8NyJ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736846553; x=1768382553;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=jM3aQF/V7ROCNUJbA5YlAjn0Z2uHE1HMCotaEhPYWv0=;
  b=bla/8NyJRTFOcwgahkzXUyh4tzWoKosWcq/ntuJKQahC9ypLBQ+n5CHI
   /wtK3xeufZt66G48kI3jAfy4OLCVPkI2ZT0dMVp2F5H2ozME5Qya/CjR1
   17wuQx3/zUQwTsQu+0mczNdWrocWiETxp167KkR6rsjQKban51vAuGXio
   2tp0WV87GTkwcQeoPxB3oE0EzfG32tSvvBsaAziHQE8ZSydjtiL7LYlq+
   CYvYUuTJAoUKDU56iF2Y+r/lnqXRDLcrdMx466Xzl5UJIdd22CSu0oRQZ
   fVKVQyRdwXfKHhmvNel/HW3aJKEgbSpqNDyspN2BFvG7KtbkE6XLy22Lv
   w==;
X-CSE-ConnectionGUID: cFiP95t6T96kMPDKOqz/Sw==
X-CSE-MsgGUID: R4STJrgrRJKLn1oh16nq5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="54549941"
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="54549941"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 01:22:33 -0800
X-CSE-ConnectionGUID: MrWU+AF7TKim4rsN3zqS+w==
X-CSE-MsgGUID: 2cql6zWLQI6Ut3NSf2PJ+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="109738408"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.230])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 01:22:30 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Dave Airlie <airlied@gmail.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
 stable@vger.kernel.org, ashutosh.dixit@intel.com,
 dri-devel@lists.freedesktop.org
Subject: Re: AAARRRGGGHHH!!!! (was Re: [PATCH 6.12.y] xe/oa: Fix query mode
 of operation for OAR/OAC)
In-Reply-To: <CAPM=9txHupDKRShZLe8FA2kJwov-ScDASqJouUdxbMZ3X=U1-Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <2025010650-tuesday-motivate-5cbb@gregkh>
 <20250110205341.199539-1-umesh.nerlige.ramappa@intel.com>
 <2025011215-agreeing-bonfire-97ae@gregkh>
 <CAPM=9txHupDKRShZLe8FA2kJwov-ScDASqJouUdxbMZ3X=U1-Q@mail.gmail.com>
Date: Tue, 14 Jan 2025 11:22:26 +0200
Message-ID: <871px5iwbx.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Jan 2025, Dave Airlie <airlied@gmail.com> wrote:
> On Sun, 12 Jan 2025 at 22:19, Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Fri, Jan 10, 2025 at 12:53:41PM -0800, Umesh Nerlige Ramappa wrote:
>> > commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f16 upstream
>>
>> <snip>
>>
>> > Fixes: 8135f1c09dd2 ("drm/xe/oa: Don't reset OAC_CONTEXT_ENABLE on OA =
stream close")
>> > Signed-off-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
>> > Reviewed-by: Matthew Brost <matthew.brost@intel.com> # commit 1
>> > Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
>> > Cc: stable@vger.kernel.org # 6.12+
>> > Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
>> > Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
>> > Link: https://patchwork.freedesktop.org/patch/msgid/20241220171919.571=
528-2-umesh.nerlige.ramappa@intel.com
>> > (cherry picked from commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f16)
>> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
>>
>> Oh I see what you all did here.
>>
>> I give up.  You all need to stop it with the duplicated git commit ids
>> all over the place.  It's a major pain and hassle all the time and is
>> something that NO OTHER subsystem does.
>
> Let me try and work out what you think is the problem with this
> particular commit as I read your email and I don't get it.
>
> This commit is in drm-next as  55039832f98c7e05f1cf9e0d8c12b2490abd0f16
> and says Fixes: 8135f1c09dd2 ("drm/xe/oa: Don't reset
> OAC_CONTEXT_ENABLE on OA stream close)
>
> It was pulled into drm-fixes a second time as a cherry-pick from next
> as f0ed39830e6064d62f9c5393505677a26569bb56
> (cherry picked from commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f16)
>
> Now the commit it Fixes: 8135f1c09dd2 is also at
> 0c8650b09a365f4a31fca1d1d1e9d99c56071128
>
> Now the above thing you wrote is your cherry-picked commit for stable?
> since I don't see
> (cherry picked from commit f0ed39830e6064d62f9c5393505677a26569bb56)
> in my tree anywhere.

The automatic cherry-pick for 6.12 stable failed, and Umesh provided the
manually cherry-picked patch for it, apparently using -x in the process,
adding the second cherry-pick annotation. The duplicate annotation
hasn't been merged to any tree, it's not part of the process, it's just
what happened with this manual stable backport. I think it would be wise
to ignore that part of the whole discussion. It's really not that
relevant.

BR,
Jani.


>
> So this patch comes into stable previously as
> f0ed39830e6064d62f9c5393505677a26569bb56 ? and then when it comes in
> as 55039832f98c7e05f1cf9e0d8c12b2490abd0f16 you didn't notice you
> already had it, (there is where I think the extra step of searching in
> git history for the patch (this seems easily automatable) should come
> in.
>
> Or is the concern with the Fixes: line referencing the wrong thing?
>
> Dave.
>>
>> Yes, I know that DRM is special and unique and running at a zillion
>> times faster with more maintainers than any other subsystem and really,
>> it's bigger than the rest of the kernel combined, but hey, we ALL are a
>> common project here.  If each different subsystem decided to have their
>> own crazy workflows like this, we'd be in a world of hurt.  Right now
>> it's just you all that is causing this world of hurt, no one else, so
>> I'll complain to you.
>>
>> We have commits that end up looking like they go back in time that are
>> backported to stable releases BEFORE they end up in Linus's tree and
>> future releases.  This causes major havoc and I get complaints from
>> external people when they see this as obviously, it makes no sense at
>> all.
>>
>> And it easily breaks tools that tries to track where backports went and
>> if they are needed elsewhere, which ends up missing things because of
>> this crazy workflow.  So in the end, it's really only hurting YOUR
>> subsystem because of this.
>>
>> And yes, there is a simple way to fix this, DO NOT TAG COMMITS THAT ARE
>> DUPLICATES AS FOR STABLE.  Don't know why you all don't do that, would
>> save a world of hurt.
>>
>> I'm tired of it, please, just stop.  I am _this_ close to just ignoring
>> ALL DRM patches for stable trees...
>>
>> greg k-h

--=20
Jani Nikula, Intel

