Return-Path: <stable+bounces-139517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC720AA7A5B
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 21:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6012A9A752C
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 19:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E3E1F2BAD;
	Fri,  2 May 2025 19:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="MIGtjFAf"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13891A5B87
	for <stable@vger.kernel.org>; Fri,  2 May 2025 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746214993; cv=none; b=M2TdzrS7OB76/HnfGKE4DEYVSbdC/OSAeybB7d4WbI0kC6FvAa2BF+zRhDtG1hfICmoxcokYVv/Ah7pGmxa6YOAWCcjcGGXs9wxiKyJlywIop5dCOu4aFffGCByiOVX3b85D+LBEoT48n3DSA0q997tZIPHykLS9xUqbQhq9gCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746214993; c=relaxed/simple;
	bh=+18FQkl1Mr++8qLLdK2x40Q2FhBahjYfs1mJF+giYe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cR+AV7y3dX6ZxI8sN0sycBixzmhHL/FF4q3FcZbIPfxBKRQ5g2eohJDFc37Y+qbVOT5rbIUuRh213DR41Y3DW5okzNn5/BCVC4ir4QxndNPVb+F0yM85RNF1zmTGeRALVCn5gJP0njgVSDcrwipNKApLcDPxMWWfcW7VbWkkJz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=MIGtjFAf; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2PBRBiM7mpaVFJL76D1iK4YyWeXD0Vz/y0tu4gjIr6E=; b=MIGtjFAf+NtzWQ+xfHOfG8o6w4
	gQHIHrmPs2BWnZRALzK1Kxg0WBIjYUoRu4X/UqlTquYSydalw91qjUe/AdjwlMkxN2PHoVCgtdIgW
	q7MHiPEXJAFAIYhdxBkkq5WOE0zskrl3sjjs19UzfsOsWfwrWtW9m5pk2nXM3EzqXq4kB1I/Qb732
	NhM62ni3Rk3ImXCaIh02YPr1cYFXIv7Xzo7+S83iLzKKk2LChnmGMaREMVd4i83KB2v1LEL8PNoPQ
	TctjsMSldcq27APkHir5ZO7tuSU2qpbfL7RLQOMCqRBzHCzFbZOyJjGkXXiJqHyGXoZJYOYd6KscX
	lSClzX+Q==;
Received: from [189.7.87.174] (helo=[192.168.0.224])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uAwFp-002FqY-2C; Fri, 02 May 2025 21:43:01 +0200
Message-ID: <a314a179-3212-4690-8f45-191017a72ac8@igalia.com>
Date: Fri, 2 May 2025 16:42:57 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/v3d: Add job to pending list if the reset was
 skipped
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 stable@vger.kernel.org, Daivik Bhatia <dtgs1208@gmail.com>
References: <20250430210643.57924-1-mcanal@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20250430210643.57924-1-mcanal@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 30/04/25 17:51, Maíra Canal wrote:
> When a CL/CSD job times out, we check if the GPU has made any progress
> since the last timeout. If so, instead of resetting the hardware, we skip
> the reset and let the timer get rearmed. This gives long-running jobs a
> chance to complete.
> 
> However, when `timedout_job()` is called, the job in question is removed
> from the pending list, which means it won't be automatically freed through
> `free_job()`. Consequently, when we skip the reset and keep the job
> running, the job won't be freed when it finally completes.
> 
> This situation leads to a memory leak, as exposed in [1] and [2].
> 
> Similarly to commit 704d3d60fec4 ("drm/etnaviv: don't block scheduler when
> GPU is still active"), this patch ensures the job is put back on the
> pending list when extending the timeout.
> 
> Cc: stable@vger.kernel.org # 6.0
> Reported-by: Daivik Bhatia <dtgs1208@gmail.com>
> Closes: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12227 [1]
> Closes: https://github.com/raspberrypi/linux/issues/6817 [2]
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
> ---
> 
> Hi,
> 
> While we typically strive to avoid exposing the scheduler's internals
> within the drivers, I'm proposing this fix as an interim solution. I'm aware
> that a comprehensive fix will need some adjustments on the DRM sched side,
> and I plan to address that soon.
> 
> However, it would be hard to justify the backport of such patches to the
> stable branches and this issue is affecting users in the moment.
> Therefore, I'd like to push this patch to drm-misc-fixes in order to
> address this leak as soon as possible, while working in a more generic
> solution.

Applied to misc/kernel.git (drm-misc-fixes).

Best Regards,
- Maíra


