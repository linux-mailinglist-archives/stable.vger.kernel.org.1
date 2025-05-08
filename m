Return-Path: <stable+bounces-142844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E759BAAF996
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 14:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239321C030F3
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 12:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AD6226D1C;
	Thu,  8 May 2025 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2dNpDDU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADA7226888
	for <stable@vger.kernel.org>; Thu,  8 May 2025 12:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706596; cv=none; b=cyntqQBIaUWxX4Y+Px0YRJej6XjByXo7sANz7/1cEFGJQ/+UvJ5bzdgZOCqzFnCS6Tygth/hG7SYUVUnIPWo5frKe4HaRD0fz0pRuGbNUh5Y/u4PiseRESeoYKl7dWfDI/vUnin5FqaV3acfE9kfV7A/UyQoTl/ekXPIgaUSPZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706596; c=relaxed/simple;
	bh=7X3Ofin17uEXRiWR2/7qF07FRRAOt7jou2NssZWBl6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MN48t44V4Ben7srOJFgSReql3/cfN3qfliir8fHYrksHndtIIoQZLv6CBddYLX/AwmydTiI7LPv0MEeZH8OsLApCnY6w1+MOshBYu7BmbwzHxwftG+jNyp3Lr1L3e68fJowwu9fr/39HxeolIv+Wo/rgppzoW0O7DoMNDa2y7Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2dNpDDU; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746706594; x=1778242594;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=7X3Ofin17uEXRiWR2/7qF07FRRAOt7jou2NssZWBl6g=;
  b=g2dNpDDU3NroTh0bAzIWbK2+zEznQhwpIZuHvBAASaRY42sRV19L/7+q
   U97FUUSbl0XrJ3w+DRXcFCBdpmtlmbiEBshfuWGkUWPBXiQRGjDjFJ9bN
   pwntCsmB4il74s7WHJuThGCTBcCetqy6pGT3aVYq0p+uJ7tExCfdcrXcT
   U/Jqhv1Kb50E6XTZkIGbADIL8TBKUcw3j7vSBJagRuRBZWP+Oun+fRm3W
   /ykBGZ5bGr/8DezwvbwkQcvL8EYkEQmKrjMBvCRkjjbtpK0y5h871Hw1A
   TJd8F3+rIoV0HnBADJ/ukjl41aeLDWY+amUar40sjPor+sdtHuWAa4VzM
   w==;
X-CSE-ConnectionGUID: w1O0OFq7Qo+shJNXwjvyJw==
X-CSE-MsgGUID: 91L/W7paRFq/pjIbTAk6ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="52293828"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="52293828"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:16:33 -0700
X-CSE-ConnectionGUID: TkJmIs6ESgGmq2EEtRNiMA==
X-CSE-MsgGUID: pKn7x70CTz2Q/Gwd5rNzlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="136206747"
Received: from unknown (HELO localhost) ([10.237.66.160])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:16:32 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
Cc: "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/dp: Fix Write_Status_Update_Request AUX request format
In-Reply-To: <CO6PR12MB5489386C2D4F5D6DC49FF27AFC8BA@CO6PR12MB5489.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250427095053.875064-1-Wayne.Lin@amd.com>
 <877c2rv7k3.fsf@intel.com>
 <CO6PR12MB5489386C2D4F5D6DC49FF27AFC8BA@CO6PR12MB5489.namprd12.prod.outlook.com>
Date: Thu, 08 May 2025 15:16:29 +0300
Message-ID: <878qn7ti02.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 08 May 2025, "Lin, Wayne" <Wayne.Lin@amd.com> wrote:
> [Public]
>
>> -----Original Message-----
>> From: Jani Nikula <jani.nikula@intel.com>
>> Sent: Thursday, May 8, 2025 4:19 PM
>> To: Lin, Wayne <Wayne.Lin@amd.com>; dri-devel@lists.freedesktop.org
>> Cc: ville.syrjala@linux.intel.com; Limonciello, Mario <Mario.Limonciello@amd.com>;
>> Wentland, Harry <Harry.Wentland@amd.com>; Lin, Wayne
>> <Wayne.Lin@amd.com>; stable@vger.kernel.org
>> Subject: Re: [PATCH] drm/dp: Fix Write_Status_Update_Request AUX request
>> format
>>
>> On Sun, 27 Apr 2025, Wayne Lin <Wayne.Lin@amd.com> wrote:
>> > +                   /*
>> > +                    * When I2C write firstly get defer and get ack after
>> > +                    * retries by wirte_status_update, we have to return
>> > +                    * all data bytes get transferred instead of 0.
>> > +                    */
>>
>> My brain gives me syntax and parse error here. ;)
>
> Appreciate for the feedback, Jani.
> Could you elaborate more on your concerns please?
>
> Since Write_Status_Update_Request is address only request. Data length
> is 0. When I2C write request completes, reply for
> Write_Status_Update_Request from DPRx will be ACK only (i.e. data
> length is 0).
>
> Is your concern about returning 0 from aux->transfer?
> My thoughts is drm_dp_i2c_do_msg() is designed to handle I2C-Over-Aux
> reply data, and aux->transfer() is handling hw specific manipulation and
> return transferred bytes. For Write_Status_Update_Request request itself,
> nothing new to be transferred. I think drm_dp_i2c_do_msg() should be
> responsible for determining the correct transferred data bytes under this
> case. Or do you expect aux->transfer to memorize the data length of
> write request?

My concern is that I don't understand what the comment is trying to say.

"when i2c write firstly get defer" - what does it mean?

"wirte_status_update" - typo

"we have to" - why?

"return all data bytes get transferred" - what does it mean?

>
> Thanks!
>>
>> BR,
>> Jani.
>>
>> --
>> Jani Nikula, Intel
> --
> Wayne Lin

-- 
Jani Nikula, Intel

