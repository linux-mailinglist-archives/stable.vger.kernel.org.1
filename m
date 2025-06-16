Return-Path: <stable+bounces-152694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E40ADAA89
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 10:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557633A5D55
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 08:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915402309B9;
	Mon, 16 Jun 2025 08:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WG4c9r5z"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB92E2C1A2
	for <stable@vger.kernel.org>; Mon, 16 Jun 2025 08:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750061912; cv=none; b=PkvPMdIEYMcKaJgaxbxnulhXv5wR+qdjQ/idOSg578q+1Cbe0zBsepUB3dY9Bn6D4a6pynBs6R40aDrzqjIUtTg1yhtMVH3mzUWJBmOKt6Gt6nTQMdcTS9PaPavXyqQQBTvoEjXii6yuPgfHTn2iZu8oplsb79GZxAlt6e7BkXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750061912; c=relaxed/simple;
	bh=kCuE4KyG97M5pODntl3QQffNMuZGSfuTpS/w7AJk3L0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cKBLWP1xbDiIxABgzsmkxHuC8v6j49Cb/QPHqQjmoUjaa+1YpMnsQ7GRIJmwaHsztrMtGKb2BL1RmjP4v1bGRoee12zLqOye+FLENAhuqwsUtXjE7VuHGlpIXkV/9LoOpszz/BZ46chzWKGeS9m54bMaoIJaxNmPK1q/8HYZg4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WG4c9r5z; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750061911; x=1781597911;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=kCuE4KyG97M5pODntl3QQffNMuZGSfuTpS/w7AJk3L0=;
  b=WG4c9r5z+W9JAihUu0bAbQqBFOhZ4paVc5IN3sZd7p8Mc7yD5IlsXNYJ
   HEAZyhpK33P5qNTLUs7ouyGrDa5twqxQZndmLQozAINJF9K8n2z0qZOOn
   cXNegBZqb7hXcMjBHqpD03kV+QhE1NYuzbiUCWaFZbV81QqTzBv7ta9P5
   RAHa9h6h9yzZzciz3yJC+uMW0nIo3r50bHo5tXFvcr0b7aE1JbcsD40hh
   TCHYgLrFH5h9qc25YAQOXoPi3GhLkO7knN0kTCBPRCdx89UpxY+/+Tdjw
   YiIrYt6m16pPnduT4OswyL3v6LtEw5gKIkknLq7QMpYEbSthDAJ5AUIzL
   A==;
X-CSE-ConnectionGUID: kXU+GL5EQLGrNXVDYKfCjg==
X-CSE-MsgGUID: iaPEnknUSPar8citQ3FL4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="51307273"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="51307273"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 01:18:30 -0700
X-CSE-ConnectionGUID: qacDgixFSnezQuiISeOASA==
X-CSE-MsgGUID: ROpcA9P9R2S6sdydfJVItg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="149315604"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.68])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 01:18:29 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>,
 intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, suraj.kandpal@intel.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/snps_hdmi_pll: Fix 64-bit divisor truncation
 by using div64_u64
In-Reply-To: <267c5213-5be1-4fab-bf38-8f80074a3194@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250613061246.1118579-1-ankit.k.nautiyal@intel.com>
 <0d7742055fbbadf97cc3a361de6838a7d0203f51@intel.com>
 <267c5213-5be1-4fab-bf38-8f80074a3194@intel.com>
Date: Mon, 16 Jun 2025 11:18:25 +0300
Message-ID: <f3ee226ac5802243e845c3ea7caa238c1cfeea65@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, 15 Jun 2025, "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com> wrote:
> On 6/13/2025 3:06 PM, Jani Nikula wrote:
>> On Fri, 13 Jun 2025, Ankit Nautiyal<ankit.k.nautiyal@intel.com> wrote:
>>>   	*ana_cp_int = max(1, min(ana_cp_int_temp, 127));
>> Unrelated to this patch, but this should be:
>>
>> 	*ana_cp_int = clamp(ana_cp_int_temp, 1, 127);
>>
>> There's a similar issue with ana_cp_prop also in the file.
>>
> Agreed. Should there be a separate patch for this?

Yes. That's why I emphasized "unrelated to this patch". ;)

BR,
Jani.


-- 
Jani Nikula, Intel

