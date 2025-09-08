Return-Path: <stable+bounces-178873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A81B4899C
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 12:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93041B24054
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 10:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7B12F5306;
	Mon,  8 Sep 2025 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L0G+E4S8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6612EA752
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326139; cv=none; b=XZTjCpJka30iPcjiSxNBj1B23/v0DiZ0bQ2Y0a2U+pT6u7ytVp3bel7Icm6/mfgQmBFUpOBCP+LDTApXIebjfrV2uNgQyojb8ZUyTFYgGMvXVaryeoeKoEYqYaNIs4vZfacltO+wwZQTrsxKU2T7txa+upCe90hwwmyF8K0aPL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326139; c=relaxed/simple;
	bh=yv0ynS2pz5WJLY5xudp0NhwfkIIneS8CGj18mEWX4bQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lLQIaofSCP10uvH6lihW8z0cc0zwqJ0JZQVqBVo0wy8Kfd221SgZsXn0ffrCjGW4gaK1doA8j/It/c6UFByOjozXxquhapwdGF2/N8Vob5SSV7/uoDFJUlioSzbx4F5S2b6gQJ0SKR89z9WcQVx7trJZoJAsNi96uTkjNCsBWBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L0G+E4S8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757326138; x=1788862138;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=yv0ynS2pz5WJLY5xudp0NhwfkIIneS8CGj18mEWX4bQ=;
  b=L0G+E4S8e9NRCdhCE4zagYq9gYSbzfapjNPwvbSjANLQQ19kn3wbvktl
   9USrjQOgcObIkXL/CpfrW9pRyDj1Y+0YBQd3mG3L9nZgiAcsRrCd4S2Cp
   +uRS0eH5Srzlsxau8DoVufp+YRZv7mzuHjtvBxN/tmH6fkADM1XADWQUF
   hJnFtBtPhgmoSI7EHQdcjo1eXimgi9H/ibk2cYPpnVlZ45I5zZdDEW3BZ
   cRXt83RH9cNV4Q48YclsVOsXnPAqP8lGlxsUe9CYVJaDXrBKxxvp3svXg
   7wpFW4AOgk6cBfzHve+1B4GqQ77zeH/MN+fkbOqvWc1IhRVDWs4+cT9K6
   Q==;
X-CSE-ConnectionGUID: QbDe3l2bQZq8Zb3UaP8i/A==
X-CSE-MsgGUID: QwqTSgQ3Qgyhwgj3RFlsTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="62212049"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="62212049"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 03:08:58 -0700
X-CSE-ConnectionGUID: sXhkcXAKShqz3zv+gpRAxA==
X-CSE-MsgGUID: x7CfLfZzTdGAkl46eLNy9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="173216543"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.204])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 03:08:56 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Matt Roper <matthew.d.roper@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, Ville
 =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/power: fix size for for_each_set_bit() in abox
 iteration
In-Reply-To: <20250905155523.GC5752@mdroper-desk1.amr.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250905104149.1144751-1-jani.nikula@intel.com>
 <20250905155523.GC5752@mdroper-desk1.amr.corp.intel.com>
Date: Mon, 08 Sep 2025 13:08:52 +0300
Message-ID: <ba480c6e5ab4971fcaec64d74545289b04f1ad3f@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 05 Sep 2025, Matt Roper <matthew.d.roper@intel.com> wrote:
> On Fri, Sep 05, 2025 at 01:41:49PM +0300, Jani Nikula wrote:
>> for_each_set_bit() expects size to be in bits, not bytes. The abox mask
>> iteration uses bytes, but it works by coincidence, because the local
>> variable holding the mask is unsigned long, and the mask only ever has
>> bit 2 as the highest bit. Using a smaller type could lead to subtle and
>> very hard to track bugs.
>>=20
>> Fixes: 62afef2811e4 ("drm/i915/rkl: RKL uses ABOX0 for pixel transfers")
>> Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>> Cc: Matt Roper <matthew.d.roper@intel.com>
>> Cc: <stable@vger.kernel.org> # v5.9+
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>
> Good catch.
>
> Reviewed-by: Matt Roper <matthew.d.roper@intel.com>

Thanks, pushed to din.

BR,
Jani.

--=20
Jani Nikula, Intel

