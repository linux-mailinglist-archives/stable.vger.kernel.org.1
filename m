Return-Path: <stable+bounces-254310-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGCKBmKBFWoHWQcAu9opvQ
	(envelope-from <stable+bounces-254310-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:17:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7180F5D4C5A
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A44F305F736
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 11:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA1B3DA7EC;
	Tue, 26 May 2026 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZZzgA2S"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27B93B47F7;
	Tue, 26 May 2026 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794112; cv=none; b=QnjIjBru1nQsxq5fSj1WYYsdkWMiBJXriiV+ZaiPuuHdKihc8P4FYH/54gLI6xTORrfDjbW32jwJ0xjkzJ98Hb3BfEzlfV4pfOasRYkLXQb5/MySU9It2oYzFajhiCRnWfo+L0zfN9h67HVxctGc3h9WDXMJwA3jfgF6Ri8XwOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794112; c=relaxed/simple;
	bh=LH1kk/OjDWW9qCPf90sUt3+xiiFp4lugKAXQrebJ1gY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hFQ50naJHrR2M1mbo8aSZLb7R3oNNvvaezC3bjyeWkrn5oA4etbz1OY99ie+3U4JYjr5DH8N3TRqUzCcbpOdS66Mbql+3OjZQ7K+GDeM4bYjK0ot9kpaqI8z/Ggzu6XavzDsCmF3MKMWm+BVcMakQRq1+XCTqYNnDNimTv16fKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZZzgA2S; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779794108; x=1811330108;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LH1kk/OjDWW9qCPf90sUt3+xiiFp4lugKAXQrebJ1gY=;
  b=WZZzgA2SxVjuHQsqXpGGVTAVk3dhbgs6h95nG7hJIVd9/P67aDNacYI3
   mBXzXcQK5+WC2UsXzgQW2d4pokeE03uPrbmkLE2aWhZEfyqE3tb4suhHW
   K71aoTfUmudim0H9y/VCzsriOcQagoDujdSfNRPDQSPbuNv2pJNy9FbGl
   I4sbpVumQ8cxmYsnSyHZaBn3DIeYT/nwBHmp/S2IF8NRsWtrOzbkG/qTG
   6qEGDVhPCQoJ0RooF1+bg6kfZbSAL1qgSV5HynUWD4ydGjCwOn3mvrYpb
   wXcZuxQr1wbsbd7wC0vxPEpUbzHjQac5/VrwFnNxEx2D0xi6Iicjsivk3
   A==;
X-CSE-ConnectionGUID: mXkmE1RETN+aAQQ8IBdpvQ==
X-CSE-MsgGUID: XDUnCYTEQxOWlIOGV8wc8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80575285"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="80575285"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 04:15:07 -0700
X-CSE-ConnectionGUID: gleDVuQfQOe8JfdHmtbKmA==
X-CSE-MsgGUID: SSHd7gO4QfOl9Mo7DX8x0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="242064468"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO [10.245.244.113]) ([10.245.244.113])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 04:15:04 -0700
Message-ID: <ce002f59-50ae-451c-8904-0caf50f5eef5@linux.intel.com>
Date: Tue, 26 May 2026 13:14:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/client: check whether CRTC is active before waiting
 for vblank
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,
 stable@vger.kernel.org
References: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
 <ee86cb43-e5df-4946-a957-931a73dde752@suse.de> <ahBWayIcQUHuAt4i@intel.com>
 <b4b2e8cb-dd7c-42c2-88b7-0a2ab95a90ee@suse.de> <ahBZ8nIqR4qESLZg@intel.com>
 <5fbcda92-f6b0-4de2-89e5-ea43a6248b05@suse.de> <ahCw9zakihaGHLsN@intel.com>
 <428be9d9-06f7-4bcb-807b-d351101c3c4b@linux.intel.com>
 <ahRA17a7JR2PVOuJ@intel.com>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <ahRA17a7JR2PVOuJ@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254310-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[suse.de,iscas.ac.cn,kernel.org,gmail.com,ffwll.ch,ravnborg.org,lists.freedesktop.org,vger.kernel.org,icenowy.me];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maarten.lankhorst@linux.intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7180F5D4C5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hey,

Den 2026-05-25 kl. 14:30, skrev Ville Syrjälä:
> On Mon, May 25, 2026 at 10:13:57AM +0200, Maarten Lankhorst wrote:
>> Hey,
>>
>> Den 2026-05-22 kl. 21:39, skrev Ville Syrjälä:
>>> On Fri, May 22, 2026 at 03:43:26PM +0200, Thomas Zimmermann wrote:
>>>> Hi
>>>>
>>>> Am 22.05.26 um 15:28 schrieb Ville Syrjälä:
>>>> [...]
>>>>>>>> But why does your HW use CRTC 1 in the first place.
>>>>>>> Could be eg. the enabled outputs can't be driven with CRTC 0.
>>>>>>>
>>>>>>> I guess what you want to do is pick the first crtc from modesets[]
>>>>>>> which is enabled. Or perhaps even "pick the Nth enabled crtc from
>>>>>>> modesets[] based on the ioctl argument".
>>>>>> The enable-status of each CRTC could change later on, which might lead
>>>>>> to problems.
>>>>> Sound like a locking issue if someone is changing the configuration
>>>>> at the same time we're trying to do the vblank wait here.
>>>>
>>>> I mean that the connected outputs could change at a later point or we 
>>>> could have multiple CRTCs in use. Today, someone in #intel-gfx reported 
>>>> a problem with panning if multiple CRTCs are in use.
>>>>
>>>> Therefore picking a CRTC freely could be a problem. Let's say we 
>>>> configure modes from one CRTC, but later wait/pan/flush with another 
>>>> CRTC. I would not trust this to work correctly.
>>>>
>>>> Hence, my suggestion is to select a primary CRTC during the fbdev 
>>>> client's probe and use it for all later operations until the next probe 
>>>> happens.  All other CRTCs would mirror the primary one.
>>>
>>> Actual mirroring may not be possible due to different modes supported
>>> on each output. The whole multi-output fbdev thing in the drm fb helper
>>> is kind of a hack that's rather hard to make work 100% sensibly.
>>>
>>> For the panning possibly the only sensible thing is to use the max of
>>> hdisplay/vdisplay of all the crtcs as the xres/yres so it's clear
>>> how much things can actually be panned. Oh and tiled displays (assuming
>>> we would actually want the fbdev stuff to tile correctly) make the
>>> situation even more complicated. I think the current support for tiled
>>> displays in the fb helper is semi-busted.´
>>
>> I tested fbdev on a tiled DP-MST monitor.
>> It works better than my kwin's wayland compositor, as it detects both tiles
>> and presents a single image spanning both tiles.
> 
> IIRC we've occasionally seen cases where it picks a non-tiled mode
> on the primary connector, and also still enables the second tile.
> 
>> Kwin sees both as separate
>> monitors.
>>
>> I still see vertical tearing between both tiles, so it would be nice if
>> intel/display would support atomic updates for both crtc's directly.
>>
>> The code's already there for bigjoiner, just needs to do the same for
>> tile joiner updates when all tiled crtc's are in the atomic update.
> 
> We don't have any special code for atomic updates with joiner
> currently. It just happens to work most of the time.
> 
> With joiner the pipes will be in sync/phase, so that helps a bit.
> But we do also try to make the pipes in sync/phase also for tiled
> display via the use of the port sync. So if you see a difference
> in tearing between joiner vs. tiled then that likely means the
> problem is in userspace (as in it submits separate commits for
> each tile).

The only thing kernel should do is if crtc 1 and 2 are part of a
commit and in sync is to perform the same as bigjoiner updates for
crtc 1 & 2 simultaneously.

That shouldn't be too much to ask from the kernel, and not hard to
implement.


> I have occasionally pondered about hiding the tiled display stuff
> completely from userspace and handling it in the kernel the same
> was as joiner. But the problem is that we'd also need to cook up
> a new EDID for the display that combines both tiles, and we'd
> still need the second connector to be enabled internally (and 
> hide that fact from userspace). None of that code exists
> currently and wouldn't be entirely trivial to implement.
> 


