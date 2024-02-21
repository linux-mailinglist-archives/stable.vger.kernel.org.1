Return-Path: <stable+bounces-21800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D4D85D35A
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 10:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A6B1C214EA
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 09:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989D73D0A8;
	Wed, 21 Feb 2024 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mIi4y1i1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851DD3DBA1
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507291; cv=none; b=h4gOZrjFLnLv38IgyvfvwRaRIxyJtmekU3xzDJnNBylUAc+ClLDoO1c0zs5DQUK1GyfG0LiY4z80PwEjKjyXTvw9tQEfV7vkJT2+rlS/SgQDCNGCBQuuPrparf5XrYZuqsWjORZPL285bzCKtYW7QN0iTFrp6QG4Whqi6DrhT8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507291; c=relaxed/simple;
	bh=IfIFt7mNYdvSQFxn1+hm8ApCRXU2kEobnuEsdtr9wlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rTggx/8U7GZ1VFwF1oy6gPGuzxDmI5i1mIjEeJRPxQaeH4Yoo2++G0I+mCa+U/gpb4XtXL+Vs0pHpkn2Q876XuYuVaZAI/TTmsVqbPYUGkP3WwEq9tjOJUlGgpSq2CY3+VbNWv32DH+/GkOxOvOvzs7oXbmzYKsuYYeex/WN5Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mIi4y1i1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708507289; x=1740043289;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IfIFt7mNYdvSQFxn1+hm8ApCRXU2kEobnuEsdtr9wlA=;
  b=mIi4y1i1akE1E+kOwz98fy7VGQm5s7xjYfEdIF30N1ss1qodVxyntusO
   15ibm6kmY6WI2kSFjoWHOjn5o9VKAYGFa8xI9pZjx7cunUPeV/ZYWwRGd
   D5wap/RIEFb0LG26s/FevkWAnzk+sjd1l4gvQm5I70QIJq2wHePRH7fVL
   S2wC89oIi145XlEl+nY+U1LvrWMiEsVIJR7fdDol0uvJqTWRMkcOza5Zc
   a9Lt2ATGz8rGWl74iC6gtKMlW62HEhMZiJM6rM7VoBGgSBBzf2d1s/2n5
   Pj9ejgIH/nAi9Ck8lRLtyQhh5T8mH6DCRWZrIqPqiaegw3knmGFRo81dZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2525446"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2525446"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 01:21:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="5434789"
Received: from conorwoo-mobl1.ger.corp.intel.com (HELO [10.252.22.137]) ([10.252.22.137])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 01:21:16 -0800
Message-ID: <47925d46-60f1-406e-93e1-88105075ebd9@intel.com>
Date: Wed, 21 Feb 2024 09:21:13 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: Fix an invalid freeing on already freed page in
 error path
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Dave Airlie <airlied@redhat.com>, Huang Rui <ray.huang@amd.com>,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <20240221073324.3303-1-thomas.hellstrom@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20240221073324.3303-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/02/2024 07:33, Thomas Hellström wrote:
> If caching mode change fails due to, for example, OOM we
> free the allocated pages in a two-step process. First the pages
> for which the caching change has already succeeded. Secondly
> the pages for which a caching change did not succeed.
> 
> However the second step was incorrectly freeing the pages already
> freed in the first step.
> 
> Fix.
> 
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Fixes: 379989e7cbdc ("drm/ttm/pool: Fix ttm_pool_alloc error path")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.4+
Reviewed-by: Matthew Auld <matthew.auld@intel.com>

