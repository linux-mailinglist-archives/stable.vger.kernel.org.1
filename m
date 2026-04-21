Return-Path: <stable+bounces-240186-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MFjK6eT52lE+AEAu9opvQ
	(envelope-from <stable+bounces-240186-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 17:11:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3037943C955
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 17:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C5343013B50
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF7A3C2782;
	Tue, 21 Apr 2026 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lLCeCYep"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BF1223707
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 15:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784186; cv=none; b=QfXomJkaGRvjCe/+Uc8d+S5utn6xABz4QOKsdc2fOGT6BjPRJ2WVV6+sxNymVbD9v9u1lBwCMKScLdxD1EGSUU4iNQcX84GywAiYUymsVuMTIN0mRM3dKnDmKEDMpUAMjMBrNgbWwFuJ/afmgw+Cf/WqIPbAeIF9j7ss0eXkXXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784186; c=relaxed/simple;
	bh=KDwN96U5E6R4W6SWZ60dPGTpsHJNZ3TsnV7dEMJsfdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T1Z/kOSGNetvkzwQqdsQniUrGSVU176GDWKzS9bhEjzLLc90MOgdLMKJXnayg0oj+o+IjT0t0z4GcHZmuak5Kai/wtUARlAgPc/DCFmDbsxVfH/QLqhiA84Zee55vvYGdYLl9LAju7cHUol3CpV0HQEFekhQdI3Jps2BC0iWERI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=lLCeCYep; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=p9B8Qt2oRG8/qwzcjUyXCkccz6Xb3kE22c28rGUWAX0=; b=lLCeCYepiC9Efkman12VwmXSW0
	x3P3YGXdlD/rujFEULwvfJT87unW5GAwPDGZRxpMlT52lrSsyi6caIyTkBY3S6xYi+vMK2oZ8y9Yy
	j2Qzbf+eunMzMIkFXjo2KGrTLxy0/yxAXdwcDqdIVARhZ7pijX7fwovmUXrCglXkbJJrU8qwVclvH
	SozRnnB+FIitDJUbbZeA73II6eanbJSqmLwS0rWBsfMy7wczNGv4ZxS6/miczGwROxbjwjWjW9PCe
	7f2AP1JDu830JZL4Uycmt3hjT0trN4R2C+T6AbI1TzBBzF64J5BwG9e3JufURVJs2kXnJ1M5cMyHK
	HgJkAznQ==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wFCj8-001yGK-JM; Tue, 21 Apr 2026 17:09:26 +0200
Message-ID: <866fe0f9-73a6-47b3-ac37-41bb26c0c6a6@igalia.com>
Date: Tue, 21 Apr 2026 16:09:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/xelp: Fix Wa_18022495364
To: Matt Roper <matthew.d.roper@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: intel-xe@lists.freedesktop.org, kernel-dev@igalia.com,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, stable@vger.kernel.org
References: <20260420131603.70357-1-tvrtko.ursulin@igalia.com>
 <384adac7-2aa4-4568-b7a5-987e914fbaf2@ursulin.net>
 <20260420202932.GH7476@mdroper-desk1.amr.corp.intel.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260420202932.GH7476@mdroper-desk1.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240186-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tvrtko.ursulin@igalia.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,igalia.com:mid,igalia.com:email]
X-Rspamd-Queue-Id: 3037943C955
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 20/04/2026 21:29, Matt Roper wrote:
> On Mon, Apr 20, 2026 at 02:24:05PM +0100, Tvrtko Ursulin wrote:
>>
>> On 20/04/2026 14:16, Tvrtko Ursulin wrote:
>>> Command parser relative MMIO addressing needs to be enabled when writing
>>> to the register.
>>>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> Fixes: ca33cd271ef9 ("drm/xe/xelp: Add Wa_18022495364")
>>> Cc: Matt Roper <matthew.d.roper@intel.com>
>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>> Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
>>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>>> Cc: <stable@vger.kernel.org> # v6.18+
> 
> I don't think we want/need the stable Cc here; this workaround doesn't
> apply to any of the Xe2 and later platforms that the Xe driver supports
> for users.  While it's possible for developers to manually override the
> driver's detection flags and force it to load on Xe1-era platforms that
> this workaround does apply to, doing so will taint the kernel and we
> already know that a lot of Xe1 era workarounds aren't implemented.

You are right, I just blindly copied the output of dim fixes. But it 
doesn't matter hugely either way since as long as there is Fixes: it 
would get picked up for -stable anyway.

> 
>>> ---
>>>    drivers/gpu/drm/xe/xe_lrc.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
>>> index 9d12a0d2f0b5..c725cde4508d 100644
>>> --- a/drivers/gpu/drm/xe/xe_lrc.c
>>> +++ b/drivers/gpu/drm/xe/xe_lrc.c
>>> @@ -1214,7 +1214,7 @@ static ssize_t setup_invalidate_state_cache_wa(struct xe_lrc *lrc,
>>>    	if (xe_gt_WARN_ON(lrc->gt, max_len < 3))
>>>    		return -ENOSPC;
>>> -	*cmd++ = MI_LOAD_REGISTER_IMM | MI_LRI_NUM_REGS(1);
>>> +	*cmd++ = MI_LOAD_REGISTER_IMM | MI_LRI_LRM_CS_MMIO | MI_LRI_NUM_REGS(1);
>>
>> Or if this register exists only for RCS would it be better to define
>> CS_DEBUG_MODE2 as the absolute 0x20d8 (as in i915)? Unfortunately the public
>> TGL PRM does not list neither the register or the workaround so I am not
>> sure.
> 
> CS_DEBUG_MODE2 exists on both the RCS and CCS engines, so I think the
> current register definition is fine.
> 
> Personally I might have changed the line farther down to
> CS_DEBUG_MODE2(hwe->mmio_base) so that we're using an absolute offset
> instead of relative, but adding the MI_LRI_LRM_CS_MMIO flag and passing
> the relative offset should work fine too.

Good to know, thanks! I am happy to change to absolute if you prefer.
  > Reviewed-by: Matt Roper <matthew.d.roper@intel.com>

Thank you!

I assume someone will pull the patch in?

Regards,

Tvrtko



