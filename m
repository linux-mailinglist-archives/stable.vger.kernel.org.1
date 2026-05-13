Return-Path: <stable+bounces-246788-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEA3Kqk7BGoqFgIAu9opvQ
	(envelope-from <stable+bounces-246788-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 10:51:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E1852FF3F
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 10:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B4653009CE6
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 08:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501D43A9623;
	Wed, 13 May 2026 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="Rtk/ozAk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B1737F72D
	for <stable@vger.kernel.org>; Wed, 13 May 2026 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778662065; cv=none; b=MqBngHNAOIapO4+1nDSFh3RNQlBZruHK6X/1ZLR7XeajSr0+Vazdeqj56vGuTzm3RWiO+wZT6x2btb8ApJ/pdp1mobSG/CDRKZNdfezxgi6QjiHqLGhHdeZH6HFBnssXulk4d3oGv5QcQEtVs+CXxSIMMPSuvLdIpSd8f69wRic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778662065; c=relaxed/simple;
	bh=Fl0rKtcEVQcrqrJ95ZGb7OFsBKOCjFBVOZUDGFDQIbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g6591nJKqR+ZTL6do48syd97kYfBZjgdNzo8wlKaUqJilMlNNjw/xkliHt2Sc+NQXI3y7HSJ5bYiBjPV+YDw+awkdbperRZEFxfJ8SAguNMyCD2W1I5BxMHbneaM/8Mxkza1+b90RoNFJo9scJJ4W5q/1kJNyVvmoSEDLVaPUCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=Rtk/ozAk; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so5560550f8f.0
        for <stable@vger.kernel.org>; Wed, 13 May 2026 01:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1778662062; x=1779266862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U7frl8/1ENt/jGWZXenOQFuGsG+tS5zouXeHogJzrfM=;
        b=Rtk/ozAkhHxsYCUGILKjpY9VFt4rCRKhMhnldP81NaDJoUAFkiH84LB1txuGbLT9OJ
         mFx76Mp19/52ekSgLpPEehhrpBVQYqdoZeEOu5x5gQKjbh+okk2lLLx2yoFUqciC2oqP
         MiTJ0VdgMLoDEkqKFNbz08zW74aS7Hg08pa0+1aA+1VVTyZiJeCuNFlXUXpkLnBlPkhW
         toMvMgUXoWVtRx4HDVTGgDasFLw73JJ0SfAAKaBphL+T2tF4saxN6YdT8E3AG+GWMI7N
         npDB+ZtKccfAmvRbpoLFW5/A1boAzaArM4gzR+1A2KjAJAPmTJ3NTQ7/0g74V0d1RQT4
         mjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778662062; x=1779266862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U7frl8/1ENt/jGWZXenOQFuGsG+tS5zouXeHogJzrfM=;
        b=Jw/WMQ9vG28hihWhi/nQzr0i4VyFivOZ82jfrZgRUmGN20uhB8/N18dQz9TQ3neQp9
         rVTMVos/XoYHkIhE8rFv6EqRwpx1Mn2Em9BQmkPC5PHL8DpNBUTy2kgQ9i+TtikuaTdr
         xAsppyr8HhwX0T9jtXSyQ+U7ryKJKiZO63GTzTTwMZWwh39qRW+1q9idfFSG0EfL0fko
         V9PLI/sZ6lmB0UGUV2BQNxrYnePGcHUpjW9a0zB9kuCLOQ90ftG/2fWkBmjPdDcv1YUs
         yrMuZXXw5AYr3fNWZ/wK3P4JlUxOmD2TWws1jLK8PRylgmsc6vnzyEv42tza8yvOgRuJ
         /NEw==
X-Forwarded-Encrypted: i=1; AFNElJ/u9i3N9cJlD7R4inQ/LXYrP+Ww9YRahtz0yVPt+EZT41ecJh0mqkMCxUznEI66iGsRA9QEl4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhkrYD7pBopmIteK0o1MXNF1KywWL4qVEGXcQMrXT7kQwRmiF1
	k57MClQfPn/KRU3sQC//PpygvUhk4zXLRZmS13QoyJZXGVie5/JX0FBIvggNLcLWWt4=
X-Gm-Gg: Acq92OF4M1BgehFZLoGhEpL5K0FqRwQEcEBrRaevtgJ9bxW/J0An/IEO2s/i/nYuaj2
	iAPHaK/8sZZt7y0P9cn9u2Orbh3IylYKh3Y0hppgm0gc87mOV/KSg1NcmFzhHo/50kAKP1fzwQ9
	E9x6yWe8XHyWcs+A26tDPLH0dPNLOGCpT3701krFY5CSP6fbx/otFTc/IgKE9cA6BpJqIaJQgfk
	yNOXReVKMvtAzpKixgPv+sFHhDH9QDPMAumAh09KsVFuPSzu8eAPW6KvHrT/3XAkq7ctNtRGHBH
	XDmq0sxWed+wG0CDtT7MzXVSq5fllLpbU4GnNuo3hrf2ceAVQxpl9dpg50lGWAYmvSVQ0TKghCD
	t+R4bnl/l6fHcUyHieUaz/bx8z9pJKZlb0Lf8M2EgSMbLEPUuU8uRYtlKnMLhFj6BSwub9D6sHS
	Fbgk122BhZDL+riEMbcd/GkCNYFK5BbOsyXI5VH4+z29SO
X-Received: by 2002:a05:6000:2485:b0:452:3677:3fb3 with SMTP id ffacd0b85a97d-45c57edf72fmr3310268f8f.1.1778662060859;
        Wed, 13 May 2026 01:47:40 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548bb51d40sm38047611f8f.0.2026.05.13.01.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 01:47:40 -0700 (PDT)
Message-ID: <c9c1270b-f724-45dd-a66d-f7b30f6c6087@ursulin.net>
Date: Wed, 13 May 2026 09:47:39 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915: skip __i915_request_skip() for already signaled
 requests
To: Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 intel-gfx@lists.freedesktop.org
Cc: andi.shyti@linux.intel.com, krzysztof.karas@intel.com,
 stable@vger.kernel.org
References: <fe76921d35b6ae85aa651822726d0d9815aa5362.1776339012.git.sebastian.brzezinka@intel.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <fe76921d35b6ae85aa651822726d0d9815aa5362.1776339012.git.sebastian.brzezinka@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 06E1852FF3F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ursulin.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-246788-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[ursulin.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ursulin.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tursulin@ursulin.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gitlab.freedesktop.org:url,intel.com:email,ursulin.net:mid,ursulin.net:dkim]
X-Rspamd-Action: no action


On 16/04/2026 12:31, Sebastian Brzezinka wrote:
> After a GPU reset the HWSP is zeroed, so previously completed
> requests appear incomplete. If such a request is picked up during
> reset_rewind() and marked guilty, i915_request_set_error_once()
> returns early (fence already signaled), leaving fence.error without
> a fatal error code. The subsequent __i915_request_skip() then hits:
> ```
> GEM_BUG_ON(!fatal_error(rq->fence.error))
> ```
> 
> Fixes a kernel BUG observed on Sandy Bridge (Gen6) during
> heartbeat-triggered engine resets.
> ```
> kernel BUG at drivers/gpu/drm/i915/i915_request.c:556!
> RIP: __i915_request_skip+0x15e/0x1d0 [i915]
> ...
> __i915_request_reset+0x212/0xa70 [i915]
> reset_rewind+0xe4/0x280 [i915]
> intel_gt_reset+0x30d/0x5b0 [i915]
> heartbeat+0x516/0x530 [i915]
> ```
> 
> Guard __i915_request_skip() with i915_request_signaled(), if the
> fence is already signaled, the ring content is committed and there
> is nothing left to skip.
> 
> Cc: stable@vger.kernel.org
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/13729
> Fixes: 36e191f0644b ("drm/i915: Apply i915_request_skip() on submission")
> Signed-off-by: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
> ---
>   drivers/gpu/drm/i915/gt/intel_reset.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/intel_reset.c b/drivers/gpu/drm/i915/gt/intel_reset.c
> index 37272871b0f2..b728a5171e93 100644
> --- a/drivers/gpu/drm/i915/gt/intel_reset.c
> +++ b/drivers/gpu/drm/i915/gt/intel_reset.c
> @@ -133,7 +133,8 @@ void __i915_request_reset(struct i915_request *rq, bool guilty)
>   	rcu_read_lock(); /* protect the GEM context */
>   	if (guilty) {
>   		i915_request_set_error_once(rq, -EIO);
> -		__i915_request_skip(rq);
> +		if (!i915_request_signaled(rq))
> +			__i915_request_skip(rq);

I spotted this patch in drm-intel-fixes today so some questions.

If the request is okay why is setting error and marking it guilty left?

1)
How confident are you of the Fixes: target? That patch is six years old 
but the Closes: issue is only from last year? Do internal Intel log have 
evidence bug was there in between those two dates? How sporadic was it? 
Were you able to verify the fix easily or with difficulty and how?

2)
Is the issue only that the order of setting the error code and the bug 
on got swapped?

Ie. before 36e191f0644b

__i915_request_reset
  -> i915_request_skip
        GEM_BUG_ON(!IS_ERR_VALUE((long)error));
        dma_fence_set_error(&rq->fence, error);

After:

__i915_request_reset
  i915_request_set_error_once
  -> i915_request_skip

If that is the case commit message should have been clearer on both 
questions.

I will hold off the drm-intel-fixes pull request until we can clarify 
the situation.

Regards,

Tvrtko

>   		banned = mark_guilty(rq);
>   	} else {
>   		i915_request_set_error_once(rq, -EAGAIN);


