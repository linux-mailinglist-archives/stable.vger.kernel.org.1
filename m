Return-Path: <stable+bounces-210351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFEED3AA74
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 14:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2F7E309BC17
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 13:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4AC364026;
	Mon, 19 Jan 2026 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lyXtIdlc"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EB3329E66
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 13:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768829663; cv=none; b=gtdBu2OunChtpekkB98AF3edd2KY3f0FF1FXcy9ha9ofFN+Dk2ydZj950ZaoM3zhPKO6KWt/A0z8nn1SQfT56bSoc5EE1DFFP4FjSoUXfv8uOm2E65w20GocqFI2whMmzrKmnXV6kLN+o9TQ9qPbBjDDgKjaB7bE4zjmDU4m5KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768829663; c=relaxed/simple;
	bh=dwWzDFV3GOIUCxfOqs9GQG2rdR7hT6Lv/em1fGGxWWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uc3Av7zxy44c5JaOzNPwY0kgHm47Gq06tZcrfXc1ycCiiIGz0EDCBtSfn44Aacv0bygQMshNEDTnTQsWwDJ9Vvhvvh3rCRKvFX9zY3PUNghepk4Y9bmb2li73+qJ9SL//eBj4kf0zxMwS/CA6N0TgM9HnIp0sRmjj8TnBzpqHsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=lyXtIdlc; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=T74UgsmOi7s8QRwzwtqWj8hkGdBKN6XzqOPGTzVusbI=; b=lyXtIdlcFSbp100KBtd4pIhhj5
	KO5i+BhoEaV23z9ntr2bG/Y1BmO2Wtht8VY0XoS90ypK8gYhWhq9P0VEJOqnnb/gcQFf47zYEVlpp
	YLdb8k4EB2EvRotP7Mw+ynPykuxyVMAtrM6u26jcHH2Dr/hlHxUFy96h8Xh8V9G3qAGWue6SXaBfW
	9p42Fp3tt4oK5LY/GMZ5OaQs50ZsO2bHl/pL7M+qyAHpkbW1BqS8t7AlfhT+2CkJs47g4ujhXQq8a
	7pVavksfkgUPpGgGyxoI6B2zfEvpYbkElDvo/jdaYtAfddk2H4hWSTmmiS1LOh1Axs9WU44aUFtSm
	9ghH/o3w==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vhpON-0079Ha-Jo; Mon, 19 Jan 2026 14:34:03 +0100
Message-ID: <69008123-6899-49e4-9a30-b1cbff279ee4@igalia.com>
Date: Mon, 19 Jan 2026 13:34:02 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/xelp: Fix Wa_18022495364
To: Matt Roper <matthew.d.roper@intel.com>
Cc: intel-xe@lists.freedesktop.org, kernel-dev@igalia.com,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, stable@vger.kernel.org
References: <20260116095040.49335-1-tvrtko.ursulin@igalia.com>
 <20260116164624.GE458813@mdroper-desk1.amr.corp.intel.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260116164624.GE458813@mdroper-desk1.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 16/01/2026 16:46, Matt Roper wrote:
> On Fri, Jan 16, 2026 at 09:50:40AM +0000, Tvrtko Ursulin wrote:
>> It looks I mistyped CS_DEBUG_MODE2 as CS_DEBUG_MODE1 when adding the
>> workaround. Fix it.
> 
> This matches the explanation of "option 1" for the workaround, but I'm
> wondering if we want/need this workaround at all.  Option 1 is to write
> the CS_DEBUG_MODE2 register (as you're doing here), but Option 2 is to
> do a constant cache invalidation (PIPE_CONTROL[DW1][Bit3]) during
> top-of-pipe invalidation and it looks like we already do that in general
> in emit_pipe_invalidate(), so it seems like we're implementing both
> options at the same time.  It looks like there's similar redundancy in
> i915 as well...
> 
> Are you seeing the programming of the correct register here actually
> change/fix anything?  If so, does just deleting the programming of the
> wrong register without programming the right one also fix the issue?

So far the off-line reports from people doing the testing appear to 
suggest this fix indeed, well, fixes it.

If that is confirmed we will need to add:

Closes: https://gitlab.freedesktop.org/mesa/mesa/-/issues/13630

As to your wider conundrum - could it be that preemption is at play? 
When done from the indirect context the workaround will trigger after 
preemption, unlike when done from emit_pipe_invalidate(). So perhaps 
"Option 1" and "Option 2" you mention miss that angle?

Regards,

Tvrtko

>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Fixes: ca33cd271ef9 ("drm/xe/xelp: Add Wa_18022495364")
>> Cc: Matt Roper <matthew.d.roper@intel.com>
>> Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Cc: <stable@vger.kernel.org> # v6.18+
>> ---
>>   drivers/gpu/drm/xe/xe_lrc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
>> index 70eae7d03a27..44f112df4eb2 100644
>> --- a/drivers/gpu/drm/xe/xe_lrc.c
>> +++ b/drivers/gpu/drm/xe/xe_lrc.c
>> @@ -1200,7 +1200,7 @@ static ssize_t setup_invalidate_state_cache_wa(struct xe_lrc *lrc,
>>   		return -ENOSPC;
>>   
>>   	*cmd++ = MI_LOAD_REGISTER_IMM | MI_LRI_NUM_REGS(1);
>> -	*cmd++ = CS_DEBUG_MODE1(0).addr;
>> +	*cmd++ = CS_DEBUG_MODE2(0).addr;
>>   	*cmd++ = _MASKED_BIT_ENABLE(INSTRUCTION_STATE_CACHE_INVALIDATE);
>>   
>>   	return cmd - batch;
>> -- 
>> 2.52.0
>>
> 


