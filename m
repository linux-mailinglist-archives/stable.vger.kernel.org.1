Return-Path: <stable+bounces-127319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6B6A7799C
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 13:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0874216B2E7
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 11:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6971FAC30;
	Tue,  1 Apr 2025 11:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HefyF9xF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1751F91CD;
	Tue,  1 Apr 2025 11:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743507310; cv=none; b=bqhVGUbbK3qM51n38nezg6wf9P/BOLpvVhvAAB8A/TsZLJHV6lFyEF8Tr11DLRtQRnivML0DauA3gO38hrWYlyccLq8wGG6ytBpZU9J3jrP5LtUIKhU+X+kP8nHCRyksfKm/FxZF+kyiPsAjsi0hzT/SpqRCOVGK6oR5O0kg6f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743507310; c=relaxed/simple;
	bh=ns65+oXL5DE7rKysJM1mY8iITuMcqvITWk3VuegazFY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pvktk9bm3Aorg8R0MljCp1pZSlu3jrfHvoOApBh0A4wjJQRTOPNIOdhqd8wAd5os4ymKyCKyH54WnxddlLHLyakSqdOUeC5pO5GFQfVD1EbjoC+xDm+vCYfAbvYy6NlKgLkER18nVa9LC6wEQiZ429pb94JEQ/Psj8CWcymucCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HefyF9xF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743507308; x=1775043308;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ns65+oXL5DE7rKysJM1mY8iITuMcqvITWk3VuegazFY=;
  b=HefyF9xF07uE+Y9PhsgA/cEg1AH0GiT5Nr7RCYcM2VB6/PyDgTQ5WueN
   FRhoOFF56Ll0NXroCejHUdv/ZfIm1shTTc5WX+VvTUaYkLXGdZkKESLP/
   1mnzp2pRoGnq64XKm160qX9eCT1peAUV6BcKyAc8gNoTdb7DPFo8vj80r
   LTP9/i4xpOmc8WSV6VBCMgaSXbe9rucX9A6vftXccJV71ZMgj6KmPb34P
   ZD8XH14u8NDin74ti9iwRW/8Mg6aZ+eXCIXTAf7i6AMEiBpG4/dctdEj3
   NlG441KZqvIZUr4pz0k2CQYmx/5FLmYg6U9ZReiR/lSDo8YwPaGdNJ8GQ
   w==;
X-CSE-ConnectionGUID: tn7HdwJzQWil95uyschdDQ==
X-CSE-MsgGUID: srLIaPvHT7e0BhjTjvjUhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="32422379"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="32422379"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 04:35:07 -0700
X-CSE-ConnectionGUID: 1eLpTKYjShmsUQIxTZ/8Ag==
X-CSE-MsgGUID: PMJMqGeORjajm07VotKYfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="131087891"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.126])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 04:35:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 1 Apr 2025 14:35:01 +0300 (EEST)
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86: ISST: Correct command storage data
 length
In-Reply-To: <20250328224749.2691272-1-srinivas.pandruvada@linux.intel.com>
Message-ID: <4049a875-fb64-c84d-c092-daa11fcc9a6c@linux.intel.com>
References: <20250328224749.2691272-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 28 Mar 2025, Srinivas Pandruvada wrote:

> After resume/online turbo limit ratio (TRL) is restored partially if
> the admin explicitly changed TRL from user space.
> 
> A hash table is used to store SST mail box and MSR settings when modified
> to restore those settings after resume or online. This uses a struct
> isst_cmd field "data" to store these settings. This is a 64 bit field.
> But isst_store_new_cmd() is only assigning as u32. This results in
> truncation of 32 bits.
> 
> Change the argument to u64 from u32.
> 
> Fixes: f607874f35cb ("platform/x86: ISST: Restore state on resume")
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: stable@vger.kernel.org

Thanks, I've applied this to the review-ilpo-fixes branch.

While reviewing this, I noticed full_cmd is currently typed as int but I 
think it should be u32 to match the type in the struct.

The construction of full_cmd also open codes FIELD_PREP() and doesn't use 
named defines for the fields. And ->cmd is also decomposed in 
isst_mbox_resume_command() which should use FIELD_GET() and the same 
defines.

> ---
>  drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> index dbcd3087aaa4..31239a93dd71 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> @@ -84,7 +84,7 @@ static DECLARE_HASHTABLE(isst_hash, 8);
>  static DEFINE_MUTEX(isst_hash_lock);
>  
>  static int isst_store_new_cmd(int cmd, u32 cpu, int mbox_cmd_type, u32 param,
> -			      u32 data)
> +			      u64 data)
>  {
>  	struct isst_cmd *sst_cmd;

-- 
 i.


