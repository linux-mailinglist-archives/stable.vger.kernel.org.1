Return-Path: <stable+bounces-108385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE8CA0B388
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 10:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6681881817
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 09:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7BE1FDA68;
	Mon, 13 Jan 2025 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ea6HsPqt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955A9235BEF;
	Mon, 13 Jan 2025 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736761682; cv=none; b=uRI/ym+Ksn5Z+wMnmxIjLV5SNc5M25UGAIAoXTZB927vcrwiTdeXlTIsnv13X9XPiqb84LPf8yxhmcZKb0TgGf0pVHR6JpIEpO7Egr5nSgphLQMGhlKeoPiosGsGh3Q2xzuBq3p2ne+MwGAr2sAdFPNfEdCJE6qTYAy2h3tDGvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736761682; c=relaxed/simple;
	bh=cXC8TN1xN8hl9kriYp7PuPtdADBmjjsDXk6R7Zd8rsA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rRCOJav0dQGdeAbX1BTLDpjE0IjFSeU/GZBPJZ0K1vlDoJwjOAk9eDy0WGQJsS5nYKWDJi5gP/MZaGTWvI6/D5HX0YnSExAsFqZUTi8y96IC+B3NVktp3ORp+3ObDI2fRgc/uOkjqIVZRCyeoZqKVrqh6nQvgedr5hg2U+OMzQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ea6HsPqt; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736761680; x=1768297680;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=cXC8TN1xN8hl9kriYp7PuPtdADBmjjsDXk6R7Zd8rsA=;
  b=ea6HsPqtjmQrdZeIAB0T69Fzeizb+VX+Gd2fU6ADfuGevXnGXkI8YiTi
   6rRbeIHlez4mE3GFvluQ5VuoQu41gXGqrDZNciAyS6NM8lrBpDRgFgZ1U
   YOZbLas5vNpdA1y+8XoOAYQLJ/ZQX0iN7wTpybvP9UGCBjP9C7DzLBNCB
   yrVW3xqEFf2RBPxZ/8iRhHiekTiEhNEp/O3SJEwDVzvb8ZLqQihPHPri+
   XUfGPPtWCM8NB7/1BtEjRpU344jcGa4C/gJp38rl6iBUD121WpF7Ps0Tc
   hgI7543looSPhuKvXs75U/OmsYz6Ku8TXhd8INxbr0pcePkPGT+XJZ9z5
   w==;
X-CSE-ConnectionGUID: 2MsYdgIUTHqo31aizjeW5g==
X-CSE-MsgGUID: 4urS1y3KSrCT01PM/6MP/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="24611719"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="24611719"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 01:48:00 -0800
X-CSE-ConnectionGUID: I0TjqpBSSnaK8CEDtRcNZA==
X-CSE-MsgGUID: nXDSzjKzQnWIRrg4Zi293Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="109353456"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.145])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 01:47:56 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Vitaliy Shevtsov <v.shevtsov@maxima.ru>, Simona Vetter
 <simona.vetter@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 syzbot+9a8f87865d5e2e8ef57f@syzkaller.appspotmail.com, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Matt Roper
 <matthew.d.roper@intel.com>, Michel =?utf-8?Q?D=C3=A4nzer?=
 <michel.daenzer@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/vblank: fix misuse of drm_WARN in
 drm_wait_one_vblank()
In-Reply-To: <20250111043753.b4407fcd52413ca37ed80ce9@maxima.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250110164914.15013-1-v.shevtsov@maxima.ru>
 <Z4Fy04u7RjaZIsqI@phenom.ffwll.local>
 <20250111043753.b4407fcd52413ca37ed80ce9@maxima.ru>
Date: Mon, 13 Jan 2025 11:47:53 +0200
Message-ID: <87y0zfhwom.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, 11 Jan 2025, Vitaliy Shevtsov <v.shevtsov@maxima.ru> wrote:
> On Fri, 10 Jan 2025 20:19:47 +0100
> Simona Vetter <simona.vetter@ffwll.ch> wrote:
>
>> Hm, unless a drivers vblank handling code is extremely fun, there should
>> be absolutely no memory allocations or user copies in there at all. Hence
>> I think you're papering over a real bug here. The vblank itself should be
>> purely a free-wheeling hrtimer, if those stop we have serious kernel bug
>> at our hands.
>> 
>> Which wouldn't be a big surprise, because we've fixed a _lot_ of bugs in
>> vkms' vblank and page flip code, it's surprisingly tricky.
>> 
>> Iow, what kind of memory allocation is holding up vkms vblanks?
>> 
>> Cheers, Sima
>> 
>
> I don't think this is because of memory allocation. As far as I can see
> there is no memory allocation in vblanks handling. Okay, there is a kzalloc()
> call in vkms_atomic_crtc_reset() without checking a pointer but this is
> not the root cause of this issue. My first thought was that somehow a
> vblank might not be successfully processed by drm_crtc_handle_vblank() in
> vkms_vblank_simulate() function which always returns HRTIMER_RESTART even
> if a vblank handling failed. But this hypothesis was not confirmed -
> all vblanks are fine. The hrtimers in vkms have a hardcoded framedur
> value of 16ms and what I can see is that the fault injection creates
> some delays by unwinding the call stack when it simulates an allocation
> failure and this caused the hrtimers to lag. This what I was able to
> investigate while I was debugging the kernel in the gdb.
>
> A similar issue was being discussed in
> https://lore.kernel.org/linux-kernel//0000000000009cd8d505bd545452@google.com/T/

Seems to me in most cases we do want the WARN, but there are corner
cases. Arguably those should be addressed instead to ensure we won't
ignore the real bugs. We want the warning, you want the panic.


BR,
Jani.


-- 
Jani Nikula, Intel

