Return-Path: <stable+bounces-147955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A67BDAC698E
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 14:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1235116BBFB
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 12:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0F1283FEF;
	Wed, 28 May 2025 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nYKmG6hr"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BF91F419B
	for <stable@vger.kernel.org>; Wed, 28 May 2025 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748435962; cv=none; b=Y4z++y51yuti+zjDCVwxQNX4/oX4hsnm0TXhEMAjbc8bLJQHgEEtQ7r99THmnTiX4IwmsH9rbSR7r+kVkWCVQNWq+MqSrHg44aZIDhEJuyOyuh5Pazb5BkHTqHiXfrDB8rVcuAl9KYRXUVweoRlbFVW+GxuDF7KXFmZraIWFkUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748435962; c=relaxed/simple;
	bh=918KPrz8nSGOfnhmrz+GK4lj18hbC6lx6czPDDZhrSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INyG0Leapto5UjFLsSfPKvnsVGbyTbZvYmWT98KfgsN9llTznoYCnWiWqdEsZN6rJMMTMGRh7ecgdgo+qS7BJX0geDeChw0rkJoUcj2uOnDe+zOq29z4azPAGARM+nbC313bNxFpTPi47Rs/dTxBudqNo9bVGcqgUDhnqQa7vp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=nYKmG6hr; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4b6pwL1xdKz9tMS;
	Wed, 28 May 2025 14:39:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1748435954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RGlF2J+LXP6mDAjw+NjT5XOIIldRczFgSNzdB+eCv10=;
	b=nYKmG6hre7dyxRWF/cr8UrkQxoeBGWBzUiJ0wiCmXoGWFWOHcWqYxeAF+feIeCOTGktG4b
	rOLM2K/qJMwBMt9GaQcehHErtPVX49+SRAQiZWbZMQMwYin+ZdbVZSyrcWcVBcH3a3E2J7
	VsemUzKFrx2fEv8Ib1y01OQ2w+6hgAZHsXb7lFy9X+lE9IUgzKzf4Huvj99hxpON0EArWH
	iQaA4pagPJFuXYBRvQkI9G0hN3rBqpsDGJlH0zI1iNj4Be8qSMWbgPitkN9XdVet9IInwx
	S0BcWuL1HSDXnvVzujUn925at631VLH7vpuD/7lTLZqX40x0nlPXABwko6BHSg==
Message-ID: <6cd32fcf-233d-454b-be3d-aabb870b8b4a@mailbox.org>
Date: Wed, 28 May 2025 14:39:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] drm/amdgpu: Dirty cleared blocks on allocation
To: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 stable@vger.kernel.org
References: <20250527194353.8023-1-natalie.vock@gmx.de>
 <20250527194353.8023-3-natalie.vock@gmx.de>
 <89652580-5763-4f1e-abf5-d340119543f3@amd.com>
 <dbbdcada-32ae-4457-af87-1f98362461f1@gmx.de>
 <da44526e-f2b6-4486-8ede-24647869576f@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <da44526e-f2b6-4486-8ede-24647869576f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: i9i1rih46o4e89puh5pgwzy6nrsf7iwp
X-MBO-RS-ID: 1d7103a300313c1ac30

On 2025-05-28 14:14, Paneer Selvam, Arunpravin wrote:
> On 5/28/2025 2:59 PM, Natalie Vock wrote:
>> On 5/28/25 09:07, Christian König wrote:
>>>
>>> But the problem rather seems to be that we sometimes don't clear the buffers on release for some reason, but still set it as cleared.
>>
>> Yes precisely - "some reason" being the aforementioned clear flags. We do always call amdgpu_clear_buffer on release, but that function will perform the same checks as the clear on allocation does - that means, if a block is marked clear then it will skip emitting any actual clears.
> 
> On buffer release [https://elixir.bootlin.com/linux/v6.15/source/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c#L1318], we call amdgpu_fill_buffer() and not amdgpu_clear_buffer() (in amdgpu_bo_release_notify() function), so the buffers are expected to be cleared without fail.
> 
> When the user space doesn't set the AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE flag and having only AMDGPU_GEM_CREATE_VRAM_CLEARED, we don't call this amdgpu_fill_buffer() and amdgpu_vram_mgr_set_cleared(), and that's kind of makes sense.
> I think the problem here is, when we don't clear the buffer during BO release, but the flag remains as cleared and that's why these blocks are skipped during clear on allocation (in amdgpu_bo_create() function).
> 
> Therefore, if the release path clear is skipped for any reasons (for example, in case of AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE not set), we should set all buffer to dirty. Somehow, that is missed.
BTW, I asked this before, but didn't get an answer:

Now that VRAM is always cleared before handing it out to user space, does AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE really need to do anything anymore? How can user space access the contents of a destroyed BO?


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast

