Return-Path: <stable+bounces-161690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E426DB0275D
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 01:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A4C1C84321
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 23:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EB82192EF;
	Fri, 11 Jul 2025 23:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="Becwzx1k"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6826AEEBD;
	Fri, 11 Jul 2025 23:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752275175; cv=none; b=tjEycVEfcW6wfsq45k81aeX34SnrmIRjfIO8efKp2sVgZhly8mkXK+zSH6xxghpjm3bliox0zTSjSuC9D4TBnpbIOhPq+PWi9ckoTLP84RFRQJJZQxP0uZLNXX+5Ey4Y1rZEdEr1pniFrW6MBehjuIioI3DnBTN8Xs44i2CATMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752275175; c=relaxed/simple;
	bh=VI6qoWOvqKUEUCwSe+hdLALtB4ReX4yV89J0v8X/edQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d922iWEWJ3sB9cy8JgDmFiJEQelGOCfRIjT8Bsvq+GKW+RYpVjMFHI0o0UvCamCykm9hp/1XU18iwcQAy+0LqR4anWClhn7yvTIZfg+77go2bbsjdqRInj4IUq5koJfpCXG+J7kt1/jz6P2MhHb9SUAoqC4UIWmMshSUYyGMvZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=Becwzx1k; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bf6lP6glBz9sTb;
	Sat, 12 Jul 2025 01:06:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1752275170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EaQt37ncXxe7vpEYUeV0gd8M3Nem6ZAh9Q+7EX7zS3g=;
	b=Becwzx1kFhZ952gSPnjRpRB17wBAcq0agzE9fiH6RHTxgtYSZ4ALsKgCUhA7ekxK0JLCoq
	sSUZJvhDVPFJrh2o6d9zLKBly0X0F8eIKgOw1D2AjNWhlwDSJVnMI+cAlW/TVYdi43GlQt
	0LZoIcmsK1stXU/TOGpfYfjv3EGcK97pE2E3O5OHm/xOVRVhzYdjAxQWUABji8oRdGRGcJ
	ScEfARaaPFyPHF+hM6JI0Ay0RRV94cY1TrtcD6+m5iArtWqEt//lXTiZrHeWnLJMuQbXVq
	owaFT/3bXroobHsywfpQbhjtiKITc9bB5LgM2Cn0UePablj4KqcM7+w9BXgLCQ==
Message-ID: <0e855c4f-2ff9-4007-854a-20955dec052b@hauke-m.de>
Date: Sat, 12 Jul 2025 01:06:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] kernel/fork: Increase minimum number of allowed threads
To: sashal@kernel.org, linux-kernel@vger.kernel.org
Cc: frederic@kernel.org, david@redhat.com, viro@zeniv.linux.org.uk,
 paulmck@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 stable@vger.kernel.org
References: <20250711230348.213841-1-hauke@hauke-m.de>
Content-Language: en-US
From: Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <20250711230348.213841-1-hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/12/25 01:03, Hauke Mehrtens wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Sorry this has the wrong from tag, will send a new patch.

Hauke>
> A modern Linux system creates much more than 20 threads at bootup.
> When I booted up OpenWrt in qemu the system sometimes failed to boot up
> when it wanted to create the 419th thread. The VM had 128MB RAM and the
> calculation in set_max_threads() calculated that max_threads should be
> set to 419. When the system booted up it tried to notify the user space
> about every device it created because CONFIG_UEVENT_HELPER was set and
> used. I counted 1299 calles to call_usermodehelper_setup(), all of
> them try to create a new thread and call the userspace hotplug script in
> it.
> 
> This fixes bootup of Linux on systems with low memory.
> 
> I saw the problem with qemu 10.0.2 using these commands:
> qemu-system-aarch64 -machine virt -cpu cortex-a57 -nographic
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>   kernel/fork.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 7966c9a1c163..388299525f3c 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -115,7 +115,7 @@
>   /*
>    * Minimum number of threads to boot the kernel
>    */
> -#define MIN_THREADS 20
> +#define MIN_THREADS 600
>   
>   /*
>    * Maximum number of threads


