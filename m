Return-Path: <stable+bounces-141972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD4FAAD6A3
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 08:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A075D3B12D1
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 06:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F40C21A421;
	Wed,  7 May 2025 06:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJSqkJV6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF4C214217
	for <stable@vger.kernel.org>; Wed,  7 May 2025 06:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746601147; cv=none; b=Swrw1tpdp6Nu09C4oT2FkG/IqHrDZ5bLNGxSudYeMIt+q5LEbY/2S2vKL62e+sZI3omJSfc6fpom3v6lcLjPsYDdybHE46Gj2+cBIwnZy5GEegkxYIdBUGLAZglDE0UwQwscyB98z60ZgGyY7QGFro+wdfJZ5/y7weJeclpMfGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746601147; c=relaxed/simple;
	bh=3EU/TCB9MceBiQbHdNJWE4YdlJz0LAiUGc+U4rFuXo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYO21eh2hPfQk43VQU3aovyJbonfYG9qSDGY1S4VBbY48APNQ0FunPvCHi8NNgmt/jymg3f61d8Xr8Ha7OCH2YV0ziPHsKLjzwT5zxNMhxncus6MIjMzLEu4OuyBYCvNv830ki17mVn0lvDHS0tmihM2K4fZsOkxwS7fEtH7OQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJSqkJV6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746601146; x=1778137146;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3EU/TCB9MceBiQbHdNJWE4YdlJz0LAiUGc+U4rFuXo8=;
  b=fJSqkJV6BQK3WSsoJ5FxctNKbnbwm6hD7nULeN8Pmb378LZOk4eilqX8
   XFur8wyy92IRhsP9YppXSdEOOZuwAtPAwuJuQiPlIOU8FWyogrCqeTOS2
   sRlilI8P70Gfg5uvMxfCdlP+JJuLzOOpglzx8dZfJPYSCMn/ktxJJNGG/
   +87GJU6Bcex1VrSrmYvopnGqBNEaSXaXTCaFCOfAWGZdxeqI54P7bjA4X
   d+LVpwtNgeL5UbWFfR6Hhb8cyym0OLtkZFyxCRyf8sAHdpE2tfgBnitUl
   SM8JZ7HQNTYJdHH7hRTOLZbM33bW+MdunILdcHulRCg5QSElTtIdJLI/Q
   Q==;
X-CSE-ConnectionGUID: OSYYZ9SwQ5yCSnlxpHeeKA==
X-CSE-MsgGUID: qdPnqqJiQfacgXSS/GBnqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="58969646"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="58969646"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 23:59:05 -0700
X-CSE-ConnectionGUID: VtWBItpKQcOo6A2p0zgTEw==
X-CSE-MsgGUID: 0cqwUsMZQ2CU/0J3sB4m1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="136262718"
Received: from ertle-mobl1.ger.corp.intel.com (HELO [10.245.112.108]) ([10.245.112.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 23:59:03 -0700
Message-ID: <35f0d2b1-e958-44db-b4d2-978cd741c3ab@linux.intel.com>
Date: Wed, 7 May 2025 08:59:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Use firmware names from upstream repo
To: Lizhi Hou <lizhi.hou@amd.com>, dri-devel@lists.freedesktop.org
Cc: jeff.hugo@oss.qualcomm.com, stable@vger.kernel.org
References: <20250506092030.280276-1-jacek.lawrynowicz@linux.intel.com>
 <abf77771-ca6a-3b29-f5e7-fbb11c53844a@amd.com>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <abf77771-ca6a-3b29-f5e7-fbb11c53844a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 5/6/2025 5:41 PM, Lizhi Hou wrote:
> 
> On 5/6/25 02:20, Jacek Lawrynowicz wrote:
>> Use FW names from linux-firmware repo instead of deprecated ones.
>>
>> Fixes: c140244f0cfb ("accel/ivpu: Add initial Panther Lake support")
>> Cc: <stable@vger.kernel.org> # v6.13+
>> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
>> ---
>>   drivers/accel/ivpu/ivpu_fw.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
>> index ccaaf6c100c02..9db741695401e 100644
>> --- a/drivers/accel/ivpu/ivpu_fw.c
>> +++ b/drivers/accel/ivpu/ivpu_fw.c
>> @@ -55,18 +55,18 @@ static struct {
>>       int gen;
>>       const char *name;
>>   } fw_names[] = {
>> -    { IVPU_HW_IP_37XX, "vpu_37xx.bin" },
>> +    { IVPU_HW_IP_37XX, "intel/vpu/vpu_37xx_v1.bin" },
> 
> What if old only vpu_37xx.bin is installed but not intel/vpu/vpu_37xx_v1?
> 
> Maybe just put *_v1 line in front without removing { ..., "vpu_37xx.bin"} ?
> 

The vpu_37xx.bin style names were never released. This was only for developer convenience but it turns out that developers don't use this anymore, so it is safe to remove. Maybe it make sense to mention this in commit message :)

> 
>>       { IVPU_HW_IP_37XX, "intel/vpu/vpu_37xx_v0.0.bin" },
>> -    { IVPU_HW_IP_40XX, "vpu_40xx.bin" },
>> +    { IVPU_HW_IP_40XX, "intel/vpu/vpu_40xx_v1.bin" },
>>       { IVPU_HW_IP_40XX, "intel/vpu/vpu_40xx_v0.0.bin" },
>> -    { IVPU_HW_IP_50XX, "vpu_50xx.bin" },
>> +    { IVPU_HW_IP_50XX, "intel/vpu/vpu_50xx_v1.bin" },
>>       { IVPU_HW_IP_50XX, "intel/vpu/vpu_50xx_v0.0.bin" },
>>   };
>>     /* Production fw_names from the table above */
>> -MODULE_FIRMWARE("intel/vpu/vpu_37xx_v0.0.bin");
>> -MODULE_FIRMWARE("intel/vpu/vpu_40xx_v0.0.bin");
>> -MODULE_FIRMWARE("intel/vpu/vpu_50xx_v0.0.bin");
>> +MODULE_FIRMWARE("intel/vpu/vpu_37xx_v1.bin");
>> +MODULE_FIRMWARE("intel/vpu/vpu_40xx_v1.bin");
>> +MODULE_FIRMWARE("intel/vpu/vpu_50xx_v1.bin");
>>     static int ivpu_fw_request(struct ivpu_device *vdev)
>>   {


