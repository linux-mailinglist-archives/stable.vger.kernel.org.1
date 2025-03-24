Return-Path: <stable+bounces-125890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD60A6DA8E
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 13:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854E716E4E0
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 12:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C92F25EF8A;
	Mon, 24 Mar 2025 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RZPwQE7h"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0674225E46C
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742821006; cv=none; b=BAYY5kDHdQyb4rclHW85NdEXaqfq3ZryKy//dYzM0fmf9ehHAJostmH28h7WiZuCipw4lQY58bZrQ6Zf9zCNtp7d/wZRKMLuLAZgCUOp7L5Dh6+KWJbO7mQCRT36DE5Xz97UwZ9AzMb2Feh/0pYF598Akwi5V8YacyI8vx+Hh/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742821006; c=relaxed/simple;
	bh=Yw8mKDKj4A5P3nno8n0/AvNsmNsgLb9K768q7zqzFrw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pS7efH5hpo1m0f2xb4ouT3/e+F8dD5r3EqYy1oNZoqKvACAkO2cc9qYkppdCWhds+8c/F/SJTO9RrVgZLCHkZZeOCPcWC74HQvezbBPR+MnLw65QCIs0utYQc6FU9XYGnxcheODMykUnF9aC9mlwu3Kr8fbJDtOaJIg3KOqIi3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RZPwQE7h; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742821004; x=1774357004;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=Yw8mKDKj4A5P3nno8n0/AvNsmNsgLb9K768q7zqzFrw=;
  b=RZPwQE7hhW8d9ZXfYqEJenbqekR+Elw0Y8/nByB1PEg3lrjPhPNTJmTU
   xerx9pz/B5rsAp2Yt3wNZ2XelSf537qIbQj1W5hAXfu7BpccPVXh+/fxy
   ZmksXXlr4pYnRSketbpfvjaXIlgZ81h8UZzT152BwqH4AZKvLxwMSrZfu
   Zm+OEd5T+8Qx4T9n37KFl4M9i3sGvUXBjOZIwjlv9B3m6OagRLbRmfiKj
   Shy9K6IH0u0zxNYVPEiB7SKxWMIdJwaRApFjTqV/0FFKQJKxOt1PKFiGY
   jB6Q3HSF8ZhoVMW7MW3YrRiC7bcADXRrjc2XHACB1+wl4sxjUPZsiy+oh
   A==;
X-CSE-ConnectionGUID: LD8/b3qLTxmFIicTneV6/Q==
X-CSE-MsgGUID: rdK3wLvXQRe/ytZl12DMNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="47897237"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="47897237"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 05:56:42 -0700
X-CSE-ConnectionGUID: MEoT5RkMRFiEdaKjS/hAkg==
X-CSE-MsgGUID: PIRSDpiYSi2Ywp9dx8LvHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="128732811"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.30])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 05:56:38 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Nicolas Chauvet <kwizart@gmail.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang
 <zhi.wang.linux@gmail.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 stable@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH 2/3] [RFC] drm/i915/gvt: Fix opregion_header->signature
 size
In-Reply-To: <CABr+WTmQ3rZ-UZH2Wv0R6qKegyjCovn3R7PWBeWiciAj+NbtnQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250324083755.12489-1-kwizart@gmail.com>
 <20250324083755.12489-3-kwizart@gmail.com> <87pli6bwxi.fsf@intel.com>
 <87h63ibwma.fsf@intel.com>
 <CABr+WTmQ3rZ-UZH2Wv0R6qKegyjCovn3R7PWBeWiciAj+NbtnQ@mail.gmail.com>
Date: Mon, 24 Mar 2025 14:56:35 +0200
Message-ID: <87msdaa8os.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Mar 2025, Nicolas Chauvet <kwizart@gmail.com> wrote:
> Le lun. 24 mars 2025 =C3=A0 10:34, Jani Nikula
> <jani.nikula@linux.intel.com> a =C3=A9crit :
>>
>> On Mon, 24 Mar 2025, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>> > On Mon, 24 Mar 2025, Nicolas Chauvet <kwizart@gmail.com> wrote:
>> >> Enlarge the signature field to accept the string termination.
>> >>
>> >> Cc: stable@vger.kernel.org
>> >> Fixes: 93615d59912 ("Revert drm/i915/gvt: Fix out-of-bounds buffer wr=
ite into opregion->signature[]")
>> >> Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
>> >
>> > Nope, can't do that. The packed struct is used for parsing data in
>> > memory.
>>
>> Okay, so I mixed this up with display/intel_opregion.c. So it's not used
>> for parsing here... but it's used for generating the data in memory, and
>> we can't change the layout or contents.
>>
>> Regardless, we can't do either patch 2 or patch 3.
>
> Thanks for review.
> So does it means the only "Fix" is to drop Werror, at least for intel/gvt=
 code ?

Of course not. The fix is to address the warning.

There's another thread about this, see my suggestion there [1].

BR,
Jani.


[1] https://lore.kernel.org/r/87r02ma8s3.fsf@intel.com


> I have CONFIG_DRM_I915_WERROR not set but CONFIG_DRM_WERROR=3Dy, (same as=
 Fedora)
> Unsure why the current Fedora kernel is unaffected by this build failure.

--=20
Jani Nikula, Intel

