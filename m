Return-Path: <stable+bounces-158698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CB7AEA260
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 17:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B247B1C64ECA
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 15:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A10E2EF9A2;
	Thu, 26 Jun 2025 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ltGfW6AV"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D882EF673;
	Thu, 26 Jun 2025 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750950158; cv=none; b=lmRpBdDUHVIpxFNrSQQ/LghxbwuEXwV2qrtSkYQYzBzFthDxP9LckgV5Qrfa7yfTWhoNwzdkxlXtgbqeb9pibKOEOnYfVFiRDMihIYf7wZoC/hWaHDWZmZiBibOHfjVmRpr0AJl4trkjL6gPBeiKGiFkQcIGusnkFQUr6k/UvqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750950158; c=relaxed/simple;
	bh=Bbgc2DY40jng+4DfV8RXgOGPojDihC9w3OdSooOoJWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MileT7PBwobfyl8F8vsIjvOnzLNcXevEArchjkBDDIsbnL7t3qlZeeolDzvXDOVO/v+o4IJZUj9OPPXygyTim37yuHIohFRCoxPHMMCfVyzQf8ii+Ywe5FRv7Q9jJbNWiHYtjn6KuxYShHQyENx2egVWt2F1GXJmp7vXG72+xJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ltGfW6AV; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=f5DlpX2huMTLf4bsOPml/8rj3dKo7+jspuRt9BtAGXg=; b=ltGfW6AV9dczegMNqj5U4DixS/
	s/6eN/vh/A38dEvSYJ4tcZS+aXcbzTWdsxkz9jL5N9G5akCrOVn7aqIJVF5QgSruAnI32KrnD8wZk
	580DShYV0S/dbwNIild2rS7Q6HFp8YvthqfKeybOAQR+BMF4M8WeUv4ofL10jVk6c2+gmI1AYV8RC
	Kn92AiR2qxwEEvti3DJ6ZQUYlZYvJ21W9IReIXIl9e4G+hNT8Hz048xZDtaDQ330CpzzQeGQNMCvD
	eakZr/mNWtOAfjJjpI/lX9t6R72uIMh0ISRfj4egQEfFpyPiu/STYKRA14aAHIICUDRBXm47rfUfQ
	tTazxPcQ==;
Received: from [189.7.87.79] (helo=[192.168.0.7])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uUo7R-0091W2-U4; Thu, 26 Jun 2025 17:02:30 +0200
Message-ID: <5baab2ed-c48d-41ae-819a-71ca195c4407@igalia.com>
Date: Thu, 26 Jun 2025 12:02:23 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vkms: Fix race-condition between the hrtimer and the
 atomic commit
To: Pranav Tyagi <pranav.tyagi03@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
 hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
 arthurgrillo@riseup.net, mairacanal@riseup.net, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, stable@vger.kernel.org,
 gregkh@linuxfoundation.org, sashal@kernel.org
References: <20250626142243.19071-1-pranav.tyagi03@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20250626142243.19071-1-pranav.tyagi03@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Pranav,

On 26/06/25 11:22, Pranav Tyagi wrote:
> From: Maíra Canal <mcanal@igalia.com>
> 
> [ Upstream commit a0e6a017ab56936c0405fe914a793b241ed25ee0 ]
> 
> Currently, it is possible for the composer to be set as enabled and then
> as disabled without a proper call for the vkms_vblank_simulate(). This
> is problematic, because the driver would skip one CRC output, causing CRC
> tests to fail. Therefore, we need to make sure that, for each time the
> composer is set as enabled, a composer job is added to the queue.
> 
> In order to provide this guarantee, add a mutex that will lock before
> the composer is set as enabled and will unlock only after the composer
> job is added to the queue. This way, we can have a guarantee that the
> driver won't skip a CRC entry.
> 
> This race-condition is affecting the IGT test "writeback-check-output",
> making the test fail and also, leaking writeback framebuffers, as the
> writeback job is queued, but it is not signaled. This patch avoids both
> problems.
> 
> [v2]:
>      * Create a new mutex and keep the spinlock across the atomic commit in
>        order to avoid interrupts that could result in deadlocks.
> 
> [ Backport to 5.15: context cleanly applied with no semantic changes.
> Build-tested. ]
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> Reviewed-by: Arthur Grillo <arthurgrillo@riseup.net>
> Signed-off-by: Maíra Canal <mairacanal@riseup.net>
> Link: https://patchwork.freedesktop.org/patch/msgid/20230523123207.173976-1-mcanal@igalia.com
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>

This patch violates locking rules and it was reversed a while ago.
Please, check commit 7908632f2927 ("Revert "drm/vkms: Fix race-condition
between the hrtimer and the atomic commit"").

Best Regards,
- Maíra

