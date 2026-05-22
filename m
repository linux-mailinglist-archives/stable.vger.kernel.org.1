Return-Path: <stable+bounces-253728-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMmfL/EiEGqsUAYAu9opvQ
	(envelope-from <stable+bounces-253728-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:33:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C15745B140C
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1EF033058D9E
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 09:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20F339DBDD;
	Fri, 22 May 2026 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CXZQTs1Q"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C803BADB7;
	Fri, 22 May 2026 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441796; cv=none; b=cNaBLCyBacFH4Znzwdq9ixYcEMUVSUayMvCGwQYATg3NiChR1QDdGrlgMtO+5m68FXpemH0mTBYTgYcMbuGKcEC58DKcbBiheclsfBiy0QH7ydoZg6WUUnku43WPNSALHGSdp9cG3BH0Y8aWl+Ng/546NkFRNCXJHM6ipA+J0Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441796; c=relaxed/simple;
	bh=zpUx7pgE7dGZ1EgENSHHQ/pITq/AWUQDi5Wy33xEqmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZS36T7Y76XYM+z26dehx6HzRKIkUgLFaQTiZzMTswWMkpFq9ZumEiHkQwk2xX8MEV6OUAMZh6QnBip5nYZLgFUVNYQV9AN2DPd2Y4d77UxVVcTxoa6RMpd/gy3CXfBCly2FsZjwF8HOujjuS8u2bUi70twWULcsnuHbp7QSCrEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CXZQTs1Q; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779441795; x=1810977795;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zpUx7pgE7dGZ1EgENSHHQ/pITq/AWUQDi5Wy33xEqmA=;
  b=CXZQTs1QY696dFdkMByzo3ATQdqwgM9Em6p3pdYfRBTFSQSPcrQve4rN
   auOIERSTvggYZj24+yeuwL+XLgnWr9vnug78wxTETmaAkhVniu0kXD0OS
   qk0WeEYgjjYRkekibye8iiSk7SLD4SxW4YGqzXMa086ZmwLnrZ7J52zh/
   xXA2cU/WbWM00d/xzcr6DvWHx0zh5+wg/jXAHDlv+YqB76NzyRk62gLz4
   OxKnDUtGfFUOQbnpzYHzfOjQqHDDdfP/okcM1Dy7NlPaCoI65LuI0MLc2
   HTAni9Mf4eADZZgX3u25VAKrkDRVI06x6gKY8SluoYdLy3svaF4GIVNOf
   Q==;
X-CSE-ConnectionGUID: sPYP0ierTNGhqCrA9Awm6A==
X-CSE-MsgGUID: mEk8g2I+RAmNk6uwJy41hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80549990"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="80549990"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 02:23:14 -0700
X-CSE-ConnectionGUID: iJlfCes5T+GmhH3xgtuE/Q==
X-CSE-MsgGUID: W1uz+iWWRj2reco7DY28hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="234512805"
Received: from abityuts-desk.ger.corp.intel.com (HELO [10.245.244.203]) ([10.245.244.203])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 02:23:12 -0700
Message-ID: <874533c1-716d-4c96-aa6f-87ab04c5f617@linux.intel.com>
Date: Fri, 22 May 2026 11:23:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/client: check whether CRTC is active before waiting
 for vblank
To: Icenowy Zheng <uwu@icenowy.me>, Jani Nikula
 <jani.nikula@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
 <889a09d63c62d88a85d8a31a85feb8bbc178534c@intel.com>
 <7b49ae842c07a0437e6851aae944003785ef31a3.camel@icenowy.me>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <7b49ae842c07a0437e6851aae944003785ef31a3.camel@icenowy.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253728-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[icenowy.me,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,ravnborg.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maarten.lankhorst@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.intel.com:mid,iscas.ac.cn:email,intel.com:dkim]
X-Rspamd-Queue-Id: C15745B140C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hey,

Den 2026-05-19 kl. 13:29, skrev Icenowy Zheng:
> 在 2026-05-19二的 12:41 +0300，Jani Nikula写道：
>> On Tue, 19 May 2026, Icenowy Zheng <zhengxingda@iscas.ac.cn> wrote:
>>> Currently the implementaion of drm_client_modeset_wait_for_vblank()
>>> assumes drm_vblank_get() will fail when the CRTC isn't active.
>>> However
>>> it seems that this is not true, and running fbcon on a device with
>>> the
>>> first CRTC inactive will lead to kernel warning in some cases
>>> (which
>>> could be reproduced with the loongson driver).
>>>
>>> Change the implementation to add a check for the active state
>>> (atomic) /
>>> enabled state (non-atomic) before calling drm_vblank_get(). As the
>>> assumption of drm_vblank_get() failing for inactive CRTC isn't met,
>>> the
>>> error status of drm_vblank_get() can now be exported too.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: d8c4bddcd8bc ("drm/fb-helper: Synchronize dirty worker with
>>> vblank")
>>> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
>>> ---
>>>  drivers/gpu/drm/drm_client_modeset.c | 13 +++++++++++--
>>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_client_modeset.c
>>> b/drivers/gpu/drm/drm_client_modeset.c
>>> index bb49b8361271a..1b03bf351256e 100644
>>> --- a/drivers/gpu/drm/drm_client_modeset.c
>>> +++ b/drivers/gpu/drm/drm_client_modeset.c
>>> @@ -1310,7 +1310,7 @@ int drm_client_modeset_wait_for_vblank(struct
>>> drm_client_dev *client, unsigned i
>>>  {
>>>  	struct drm_device *dev = client->dev;
>>>  	struct drm_crtc *crtc;
>>> -	int ret;
>>> +	int ret = 0;
>>>  
>>>  	/*
>>>  	 * Rate-limit update frequency to vblank. If there's a DRM
>>> master
>>> @@ -1326,15 +1326,24 @@ int
>>> drm_client_modeset_wait_for_vblank(struct drm_client_dev *client,
>>> unsigned i
>>>  	 * Only wait for a vblank event if the CRTC is enabled,
>>> otherwise
>>>  	 * just don't do anything, not even report an error.
>>>  	 */
>>
>> I'll dodge the question whether the change below is right or not, but
>> for sure the comment above needs to be amended to match the change.
> 
> If the change is right, it perfectly matches what the comment above is
> saying -- it's the current behavior that does not match the comment.
> 
> Thanks,
> Icenowy
I would rather have expected drm_fb_helper_ioctl to fail like you mention.
Probably needs a fbcon_is_active() there to prevent it.

The damage helper should not be triggered if no CRTC is active, so that means
the check here is slightly too late.

Can you fix it at a different level, like damage helper or its callers instead?

I believe when the client gets suspended, all the pending damage is flushed before
suspend.

Kind regards,
~Maarten Lankhorst

