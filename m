Return-Path: <stable+bounces-215933-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICyBI1uijWlh5gAAu9opvQ
	(envelope-from <stable+bounces-215933-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 10:50:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA7A12C062
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 10:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D90D309D0CD
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 09:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7E579CD;
	Thu, 12 Feb 2026 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRCnp2Uw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UM1tzJ7u"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB4E6F2F2
	for <stable@vger.kernel.org>; Thu, 12 Feb 2026 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770889804; cv=none; b=tVv6a2brF0ZXNSrH4V/NexujylbxgkcwwKMV1ZnKDSYoidWazUKI5JZhecaaJcIS7ypvVw3iTAo+oXPA4/ZrlVzuTbcAnGeWJ0nhq3n/pQCjSirQ4DWKRF8pDUSsml/aTSWN89OY5lqfAJjNpdpLGGeLedo9h7HbFMs1clBxNd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770889804; c=relaxed/simple;
	bh=ssiBpGwudSOhWWpXd6ltuV0trtgpSjINF3dITy6pg0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=goRogSRc37fNW6WK3xNFqlFqGGhrb/P2WrCw+h58OjY4ttZavo3EQ7LwWOpSu0ztMYzIF383KnJPx1CwGGGvpDrK89g/yR03Llci/8iurI5K4o5uDwTiV2Pmde49O6KG16CPl8rxnPG9jXaToQpwh3JqOn/YzL9l901ex0RrR2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CRCnp2Uw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UM1tzJ7u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770889802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7izo/A5Ul08EXM2WpJ9NM5vTC0yA5lFDEQbyiP4NFcY=;
	b=CRCnp2UwTvVzBCMIWlVfd4+IXB3P8x9g5GNV+WL6SeueerGzvkGLz/9sslIX0u5YeaN803
	sKQMHYZ0xP+8mYmMi9QzZiuuK+kdHxuJvRtzNCB17Mxuxbx368ETnNcsQoSemHHjQIxvzV
	V6yiKGl1XJ3E22Wg4gC8dP66IKjTO8M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-TqKA0r1rNvisEOucRxLB6g-1; Thu, 12 Feb 2026 04:50:00 -0500
X-MC-Unique: TqKA0r1rNvisEOucRxLB6g-1
X-Mimecast-MFC-AGG-ID: TqKA0r1rNvisEOucRxLB6g_1770889800
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48336b182ebso35252575e9.3
        for <stable@vger.kernel.org>; Thu, 12 Feb 2026 01:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770889799; x=1771494599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7izo/A5Ul08EXM2WpJ9NM5vTC0yA5lFDEQbyiP4NFcY=;
        b=UM1tzJ7u887hU+Bo0jjFMc6ZolvP1/wL5b1+c4dpfRfi5cvyD2swHCSKQCQPbQSR0J
         li8uh3p/z5tLWsEz+tIr3j6xPlt+rFU8uvnAvq5gJjNddkGXLLaHt7BFBDc3z3UDWalC
         G9bcoJ5t+/pZroQHSPznmWPkdRLaH3GXjq1o17LiHeBto7wwy0Y5D4wlomqF8uv7OLpf
         sE0jnRptuDbtMmXtHR+h0/2Jd2z8ZtDicQrQHTwwS3WpYMnrWCBurmjB6Lhvs+iePzFL
         PkCiwqn0603bq+S68IsNBCthG30Y0al64X0cdp17vPlM8u6KJGniye3o1BtC3vwksFgI
         pGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770889799; x=1771494599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7izo/A5Ul08EXM2WpJ9NM5vTC0yA5lFDEQbyiP4NFcY=;
        b=LBCZaHXyeYCrBW0J4Mmzpvy+9oQgL48eynIfpkdHRSxrL+/6/aP8UUNPweNUxCFWng
         6sXvYrwr480DvFZXH+P8s+3wdHfBE4ienkaUV/m6PnmdSMaJ3FuyLqnm5JV4FQWLFWJK
         vkfD8aouKgYCxAuFuev73TluLmgV8FVvE6Upe9ECKUWixruLY/0+pEf0iYCHaecQ0fkC
         EjwIx+2G0uZ37PxhBWuOms2vYEj4UsnFgq/y5eAV04INS8BRLiPzH4Vzk/+hhgyZpAIf
         6poj/Luj0MbN7BmR08/hSaVl4yI7h5duToV3+/V0cYccxUTA21USN9fp+IQoADg0yyvF
         tuGg==
X-Forwarded-Encrypted: i=1; AJvYcCUMtSHGP3BagTX57d8sgRx2u6Rf35SY9M6Fxla9chVzntZsH8LYhw5+GQ6xOcLXdp3Qu+zVtuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTzLnsmPR+KTFM+lwe+AM5ddUgDadoJmEBGphLms23taz/wsd6
	10+Q18Gh//gVLXidSTCYgCe4eGz87kRLfIOHC7m0NMKYlfzZT9Jxx4rq6wf+gGAr9pkm0MWP0oa
	FocAdX4kD2rkROsACETm4wrjggVkI6b26gCvPL1TsvevCNIou2xSFV748vQ==
X-Gm-Gg: AZuq6aIDoYmur6gVEjJ1u1G6Q+lenkHAGnEYNmgX/TJB7gn0GhSnfPtcK5FUgQjWumU
	66nmq9BRt2qP/P0kcB81m2gIGaLveqnsTpTdcybH2t35sppOlPiubUrxyZlMs32ZlkKlW3a2FW2
	eyfCi+8c9POmi3YkYzvwfTobxrni4I6IwwDf8kxJatiG2Ze4Rm2uF4dMfjLGH7DwTT+XQUcnGb3
	2nr8I5RBjpvG4FMKxsc8LLCzor7KFGIAtzLIh9O17Vo3FsxhnCa9UDDktPrEXuxjgnUdPWw3dZa
	4tMC01IDxfUjSow4c7Qloz3XZswX5P8lEYXR3DevCC9BSI4Lj0mNbYxOVl1Wg422lwVSlfIdYA6
	Sobzui0oUbNiZCBOtvVoPKSxXdfu7G44RF14J/1hJq3Go/ZeAvdqPHSsKQhbnCw==
X-Received: by 2002:a05:600c:c08f:b0:483:6e32:50d4 with SMTP id 5b1f17b1804b1-4836e3250ddmr2220565e9.18.1770889799516;
        Thu, 12 Feb 2026 01:49:59 -0800 (PST)
X-Received: by 2002:a05:600c:c08f:b0:483:6e32:50d4 with SMTP id 5b1f17b1804b1-4836e3250ddmr2220055e9.18.1770889799021;
        Thu, 12 Feb 2026 01:49:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4836aa0847asm29634535e9.3.2026.02.12.01.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 01:49:58 -0800 (PST)
Message-ID: <e9d35c78-1c4b-4a9c-8cf0-9531e972279f@redhat.com>
Date: Thu, 12 Feb 2026 10:49:54 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/hyperv: During panic do VMBus unload after frame
 buffer is flushed
To: mhklkml@zohomail.com, mhklinux@outlook.com, drawat.floss@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, ryasuoka@redhat.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, stable@vger.kernel.org
References: <20260209070201.1492-1-mhklinux@outlook.com>
 <20260209070201.1492-2-mhklinux@outlook.com>
 <a5372b72-8dc0-4f2d-ad5c-086f3e75ee81@redhat.com>
 <002601dc9baa$517d8b40$f478a1c0$@zohomail.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <002601dc9baa$517d8b40$f478a1c0$@zohomail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[zohomail.com,outlook.com,gmail.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,microsoft.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215933-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jfalempe@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zohomail.com:email]
X-Rspamd-Queue-Id: EBA7A12C062
X-Rspamd-Action: no action

On 12/02/2026 00:01, mhklkml@zohomail.com wrote:
> From: Jocelyn Falempe <jfalempe@redhat.com> Sent: Wednesday, February 11, 2026 1:54 PM
>>
>> On 09/02/2026 08:02, mhkelley58@gmail.com wrote:
>>> From: Michael Kelley <mhklinux@outlook.com>
>>>
>>> In a VM, Linux panic information (reason for the panic, stack trace,
>>> etc.) may be written to a serial console and/or a virtual frame buffer
>>> for a graphics console. The latter may need to be flushed back to the
>>> host hypervisor for display.
>>>
>>> The current Hyper-V DRM driver for the frame buffer does the flushing
>>> *after* the VMBus connection has been unloaded, such that panic messages
>>> are not displayed on the graphics console. A user with a Hyper-V graphics
>>> console is left with just a hung empty screen after a panic. The enhanced
>>> control that DRM provides over the panic display in the graphics console
>>> is similarly non-functional.
>>>
>>> Commit 3671f3777758 ("drm/hyperv: Add support for drm_panic") added
>>> the Hyper-V DRM driver support to flush the virtual frame buffer. It
>>> provided necessary functionality but did not handle the sequencing
>>> problem with VMBus unload.
>>>
>>> Fix the full problem by using VMBus functions to suppress the VMBus
>>> unload that is normally done by the VMBus driver in the panic path. Then
>>> after the frame buffer has been flushed, do the VMBus unload so that a
>>> kdump kernel can start cleanly. As expected, CONFIG_DRM_PANIC must be
>>> selected for these changes to have effect. As a side benefit, the
>>> enhanced features of the DRM panic path are also functional.
>>
>> Thanks for properly fixing this issue with DRM Panic on hyperv.
>>
>> I've a small comment below.
>>
>> With that fixed:
>> Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
>>
>> The first patch looks good too, I can review it if no other step up, as
>> I'm not familiar with hyperv.
>>
>>>
>>> Fixes: 3671f3777758 ("drm/hyperv: Add support for drm_panic")
>>> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
>>> ---
>>>    drivers/gpu/drm/hyperv/hyperv_drm_drv.c     |  4 ++++
>>>    drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 15 ++++++++-------
>>>    2 files changed, 12 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
>> b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
>>> index 06b5d96e6eaf..79e51643be67 100644
>>> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
>>> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
>>> @@ -150,6 +150,9 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
>>>    		goto err_free_mmio;
>>>    	}
>>>
>>> +	/* If DRM panic path is stubbed out VMBus code must do the unload */
>>> +	if (IS_ENABLED(CONFIG_DRM_PANIC) && IS_ENABLED(CONFIG_PRINTK))
>>
>> I think drm_panic should still work without printk.
>> The "user" panic screen would be unaffected, but the "kmsg" screen might
>> be blank, and the "qr_code" would generate an empty qr code.
>> (Actually I never tried to build a kernel without printk).
> 
> Yeah, I had never built such a kernel either until recently when the kernel
> test robot flagged an error in Hyper-V code when CONFIG_PRINTK is not set. :-)
> 
> But for this patch, the issue is that drm_panic() never gets called if CONFIG_PRINTK
> isn't set. In that case, kmsg_dump_register() is a stub that returns an error.  So
> drm_panic_register() never registers the callback to drm_panic(). And if
> drm_panic() isn't going to run, responsibility for doing the VMBus unload
> must remain with the VMBus code. It's hard to actually test this case because
> of depending on printk() for debugging output, so double-check my
> thinking.

Ok you're right. I changed from 
atomic_notifier_chain_register(&panic_notifier_list, ...) to 
kmsg_dump_register() in the v10 of drm_panic.

So I should either make DRM_PANIC depends on PRINTK, or call 
atomic_notifier_chain_register() if PRINTK is not defined.

As I think kernel without PRINTK are uncommon, I'll probably do the 
first solution.

-- 

Jocelyn
> 
> Michael
> 
>>
>>> +		vmbus_set_skip_unload(true);
>>>    	drm_client_setup(dev, NULL);
>>>
>>>    	return 0;
> 


