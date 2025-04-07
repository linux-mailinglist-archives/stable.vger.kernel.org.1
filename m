Return-Path: <stable+bounces-128578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D64A7E4B0
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 17:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FBB6442A56
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 15:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B0A1FF1D6;
	Mon,  7 Apr 2025 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ode2WNyx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C1C1FF1C5;
	Mon,  7 Apr 2025 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744039521; cv=none; b=mURT3BII6Ri2h/RinywTnqOhzxZW71M5L0Pe1rZj8qqhEWMxKq7pqEGRrNygZSHMjhsN+kLZ8sp7SfuHalo2nCLrDiquAlil28wrAwxPgAEA6jSGM89PYq+45hUZmKbt8vjDeup2NADDtE5QSFZT8KR3b4aONl/094LN9t7RRKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744039521; c=relaxed/simple;
	bh=+dMDlk4/IugJw2FDppkeJkwdLYA9dxFtsb2IakkQXsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J67jw+SjiaKruM/SxYaSXiHItgzEe1lQGv8cetWA8CygPRWknMkJANZ8Bibo0BzQozj8KGTd8AInk41YgtZ3uPB6sVrigz/mF0+Y/Ym2ym/2aDD38T4Oh4/G2KFXdq7+Njv8fPg8eOXhj6hV1z91JrZrDxI8pVtTGll2ZjIrEbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ode2WNyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4457AC4CEDD;
	Mon,  7 Apr 2025 15:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744039520;
	bh=+dMDlk4/IugJw2FDppkeJkwdLYA9dxFtsb2IakkQXsc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ode2WNyxkKEnIxnZrfS6AEdU2DYqhY7zUEQtKeDaResOV7MrXscXgVYRcUrWAJQEw
	 tPoFBQYXn5oR0mjAJet5ll21ZR4ZNG4kvkiQmaY/vojJXOyJdCnAr5AY69v9xhdXco
	 f8APHPT9dMI8nPyIitdkEcJlgCQNkZLajjU8oQk9LBRpviUhHhgfPSq2Sy+vJiNWcM
	 98RRyXN54X9a+aNEDMjv1m7G+a5Z63SCiCiKWAvmp9QG6tnvlKJ+SKMlfEH86nNuzX
	 gX3WuVbidN57VfVHNMS0kuWFA6jPjMKcM/qoBpaSCJpHz96X9NVchvMSWNSpv8/1jV
	 2sp5QbEU3OenQ==
Message-ID: <392938bb-24b8-4873-ba89-aacf2c404499@kernel.org>
Date: Mon, 7 Apr 2025 10:25:19 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86: amd: pmf: Fix STT limits
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: mario.limonciello@amd.com, Shyam-sundar.S-k@amd.com,
 Hans de Goede <hdegoede@redhat.com>, Yijun Shen <Yijun.Shen@dell.com>,
 stable@vger.kernel.org, Yijun Shen <Yijun_Shen@Dell.com>,
 platform-driver-x86@vger.kernel.org
References: <20250407133645.783434-1-superm1@kernel.org>
 <60e43790-bbeb-29b3-dcf1-7311439e15cc@linux.intel.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <60e43790-bbeb-29b3-dcf1-7311439e15cc@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/7/2025 10:19 AM, Ilpo Järvinen wrote:
> On Mon, 7 Apr 2025, Mario Limonciello wrote:
> 
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> On some platforms it has been observed that STT limits are not being applied
>> properly causing poor performance as power limits are set too low.
>>
>> STT limits that are sent to the platform are supposed to be in Q8.8
>> format.  Convert them before sending.
>>
>> Reported-by: Yijun Shen <Yijun.Shen@dell.com>
>> Fixes: 7c45534afa443 ("platform/x86/amd/pmf: Add support for PMF Policy Binary")
>> Cc: stable@vger.kernel.org
>> Tested-By: Yijun Shen <Yijun_Shen@Dell.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v2:
>>   * Handle cases for auto-mode, cnqf, and sps as well
>> ---
>>   drivers/platform/x86/amd/pmf/auto-mode.c | 4 ++--
>>   drivers/platform/x86/amd/pmf/cnqf.c      | 4 ++--
>>   drivers/platform/x86/amd/pmf/sps.c       | 8 ++++----
>>   drivers/platform/x86/amd/pmf/tee-if.c    | 4 ++--
>>   4 files changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/platform/x86/amd/pmf/auto-mode.c b/drivers/platform/x86/amd/pmf/auto-mode.c
>> index 02ff68be10d01..df37f8a84a007 100644
>> --- a/drivers/platform/x86/amd/pmf/auto-mode.c
>> +++ b/drivers/platform/x86/amd/pmf/auto-mode.c
>> @@ -120,9 +120,9 @@ static void amd_pmf_set_automode(struct amd_pmf_dev *dev, int idx,
>>   	amd_pmf_send_cmd(dev, SET_SPPT_APU_ONLY, false, pwr_ctrl->sppt_apu_only, NULL);
>>   	amd_pmf_send_cmd(dev, SET_STT_MIN_LIMIT, false, pwr_ctrl->stt_min, NULL);
>>   	amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
>> -			 pwr_ctrl->stt_skin_temp[STT_TEMP_APU], NULL);
>> +			 pwr_ctrl->stt_skin_temp[STT_TEMP_APU] << 8, NULL);
> 
> Hi Mario,
> 
> Could we add some helper on constructing the fixed-point number from the
> integer part as this magic shifting makes the intent somewhat harder to
> follow just by reading the code itself?
> 
> I hoped that include/linux/ would have had something for this but it seems
> generic fixed-point helpers are almost non-existing except for very
> specific use cases such as averages so maybe add a helper only for this
> driver for now as this will be routed through fixes branch so doing random
> things i include/linux/ might not be preferrable and would require larger
> review audience.
> 
> What I mean for general helpers is that it would be nice to have something
> like DECLARE_FIXEDPOINT() similar to DECLARE_EWMA() macro (and maybe a
> signed variant too) which creates a few helper functions for the given
> name prefix. It seems there's plenty of code which would benefit from such
> helpers and would avoid the need to comment the fixed-point operations
> (not to speak of how many of such ops likely lack the comment). So at
> least keep that in mind for naming the helpers so the conversion to
> a generic helper could be done smoothly.
> 

Do I follow right that you mean something like this?

static inline u32 amd_pmf_convert_q88 (u32 val)
{
	return val << 8;
}



