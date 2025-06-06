Return-Path: <stable+bounces-151612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E87AD0205
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 14:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76784189F4FC
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 12:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAA8289839;
	Fri,  6 Jun 2025 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AnGp7cb5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C07289826
	for <stable@vger.kernel.org>; Fri,  6 Jun 2025 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749211794; cv=none; b=pXrtUd/jkRxcyBbBgqD2NDfNrT8DAfOy0U0vkkbmTercnrSy9FOh6qGL+hTmwuFW/K2K0K9fLCkIQQ9GnxPywcSPpkkQS7pP9MgpCkKR8qtgozM+xOt6af4S2b9V6M/7G2L92CoOjBpL7W7cvhd18NuBt7A9uvaknzHNHvuVoOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749211794; c=relaxed/simple;
	bh=H4evEe3LGXA54ohxMpqLDNu+C2QugjNSKf+0krNtL6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MiLrd4M2Dz+FTSH2McHXAb4zF+XQjgAFXp32YQKQFN4ljcKm5RfM/qNcEB0ZKv5nYoY6xcwOtdRi2o+aimIJV2RM1f1KKLbh3DH+6nkyY/iARvlWes4ztUOoVgRfExwmIdFfYLtpm4X1XvVnAUoPiturvgKo+ySvQJA7OYcT2ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AnGp7cb5; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749211793; x=1780747793;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H4evEe3LGXA54ohxMpqLDNu+C2QugjNSKf+0krNtL6o=;
  b=AnGp7cb5CK1NF4P8odRB/4IftN/ky4O9VmS0pLtgkcwYInE4pyo3i8f1
   ej9picmtuhrNL4JYumuLPvryQwrAyLmTQ6O39KD8NCFsx+MGlpaeCk8eY
   UBH6NAGe9rftTVikolQrA8Wdger2Foq1zbt+XneG4DlD3JAhebJb7RL3S
   KPTrLnnrXwF5ypTlQziy+p9XEomXkKfvxEqGbaVLME3DPZr9nLuNpZgvb
   +6pnrxS1EIeBlASocOWMAlW7bCqsf4Ovh6pznZc6ntJBh/0WHZIImbz2o
   Ph5QqChjWztGKsPf4+p8nIunT3fX3LZoLY1NTsKn/1ylrNHKIN7rEod7K
   Q==;
X-CSE-ConnectionGUID: 8CygYZulT6qqDcKW5GgmjA==
X-CSE-MsgGUID: 8f8grDJ9R1y1rTXTrpGAZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="51352893"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="51352893"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 05:09:53 -0700
X-CSE-ConnectionGUID: yFOUoUC0TAuJIZWcoww/3g==
X-CSE-MsgGUID: aF9w9JlyRbqjB2cIj/IUPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="151070327"
Received: from mchromin-mobl2.ger.corp.intel.com (HELO [10.245.112.120]) ([10.245.112.120])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 05:09:51 -0700
Message-ID: <ddfa88ba-cf7c-44b0-93b0-f67383c787af@linux.intel.com>
Date: Fri, 6 Jun 2025 14:09:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Request for backporting accel/ivpu PTL patches to 6.12
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
References: <fe7c8681-83de-4f3e-8dab-04185f0f9416@linux.intel.com>
 <2025060411-tableful-outage-4006@gregkh>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <2025060411-tableful-outage-4006@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/4/2025 3:21 PM, Greg KH wrote:
> On Tue, Jun 03, 2025 at 12:42:09PM +0200, Jacek Lawrynowicz wrote:
>> Hi,
>>
>> Please cherry-pick following 9 patches to 6.12:
>> 525a3858aad73 accel/ivpu: Set 500 ns delay between power island TRICKLE and ENABLE
>> 08eb99ce911d3 accel/ivpu: Do not fail on cmdq if failed to allocate preemption buffers
>> 755fb86789165 accel/ivpu: Use whole user and shave ranges for preemption buffers
>> 98110eb5924bd accel/ivpu: Increase MS info buffer size
>> c140244f0cfb9 accel/ivpu: Add initial Panther Lake support
>> 88bdd1644ca28 accel/ivpu: Update power island delays
>> ce68f86c44513 accel/ivpu: Do not fail when more than 1 tile is fused
>> 83b6fa5844b53 accel/ivpu: Increase DMA address range
>> e91191efe75a9 accel/ivpu: Move secondary preemption buffer allocation to DMA range
>>
>> These add support for new Panther Lake HW.
>> They should apply without conflicts.
> 
> That's way larger than the normal "add a new quirk or device id" patch
> for new device support, right?  Why do you feel this is needed and
> relevant for 6.12.y and meets the requirements that we have for stable
> kernel patches?

Yeah, maybe I overshot a bit. Sorry about this.
I wanted to provide the best possible PTL experience but most of these patches are not critical.

The absolute minimal set of patches to enable PTL is:
c140244f0cfb9 accel/ivpu: Add initial Panther Lake support
88bdd1644ca28 accel/ivpu: Update power island delays

Please include just these two.

Regards,
Jacek

