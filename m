Return-Path: <stable+bounces-238719-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCTgMSff5Wl8owEAu9opvQ
	(envelope-from <stable+bounces-238719-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 10:09:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E73428046
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 10:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFBC830086A6
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 08:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E62386439;
	Mon, 20 Apr 2026 08:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JxqOsqms"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E462FFF89;
	Mon, 20 Apr 2026 08:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776672544; cv=none; b=d7DKyoPUDDVOArp64ZI+9EYtOKd5KJbgkVMdx3Xepa7Oub9SA8o0ApIjhfCmT+HsXIBwh6tk9d4f6K0JXpsCYyBKTvhfrnxYVJqS0Tq4SW2sD7eiHpzPb/KMa6ldpmnBg4pStikt/kAcmPQ/V5535CHWYDA7NyQUlqVpfbqSOpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776672544; c=relaxed/simple;
	bh=xeiMmgHNb7XeXU5idRE++64Apuo6X8UZ90B/UyRdM3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0ezNrrtgOGc/6pbEKzTYiRLsQTqYW3qeLItjoMh6w1t2C40V/B+VD7MnGBSc3x3UanZOxvKOLk1nStYRcXjWktRl4hZ+WLQNZBsZEuqXsrU2nvr2RetbH1VzhKTDKxhFkf5iiNjhKO4ClwgBHEEw1ltCmwQzFNX4GO7ehT4Z0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JxqOsqms; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1776672535;
	bh=xeiMmgHNb7XeXU5idRE++64Apuo6X8UZ90B/UyRdM3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JxqOsqmszginUPEl+ZJCv+2MuTbw1KA7dlEuwIxUUPDu52ZZToHe0ic70JM+uzuie
	 N4Kyu7jajMWhgCpDQFVNUnGDrIWsj8XbiHoZldId0Ilv/RJosSKuP0R6nToKCLBVSG
	 w8mSgJyFf4wbFfXyNAr5U5K5+l6zC3ZcYtZbvTSNBfuEJWFw2CpuH+qNrVp2SsOL0q
	 wIQBofTy4F4j4xW24XOLH3VbeS711l3uBJ02DaItylX33tGaOMmKgqC6oYc08+HpuU
	 1Tc+i5yBhWcTS9SEjHb08hT56bminSrZsiAO1tqesA0h49hg1c69Y1eBm0MQDTQAI9
	 Q9ZRhCjvX1/7Q==
Received: from fedora (unknown [100.64.0.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C503117E0CA9;
	Mon, 20 Apr 2026 10:08:54 +0200 (CEST)
Date: Mon, 20 Apr 2026 10:08:51 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Gyeyoung Baek <gye976@gmail.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Rob Herring <robh@kernel.org>,
 Steven Price <steven.price@arm.com>, =?UTF-8?B?QWRyacOhbg==?= Larumbe
 <adrian.larumbe@collabora.com>, Oded Gabbay <ogabbay@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v1 2/2] drm/panfrost: Fix wait_bo ioctl leaking positive
 return from dma_resv_wait_timeout()
Message-ID: <20260420100851.5bf42dee@fedora>
In-Reply-To: <fe33f82fded7be1c18e2e0eb2db451d5a738cf39.1776581974.git.gye976@gmail.com>
References: <cover.1776581974.git.gye976@gmail.com>
	<fe33f82fded7be1c18e2e0eb2db451d5a738cf39.1776581974.git.gye976@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238719-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[tomeuvizoso.net,kernel.org,arm.com,collabora.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris.brezillon@collabora.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,collabora.com:dkim,collabora.com:email]
X-Rspamd-Queue-Id: D9E73428046
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 19 Apr 2026 16:17:16 +0900
Gyeyoung Baek <gye976@gmail.com> wrote:

> dma_resv_wait_timeout() returns a positive 'remaining jiffies' value
> on success, 0 on timeout, and -errno on failure.
> 
> panfrost_ioctl_wait_bo() returns this 'long' result from an int-typed
> ioctl handler, so positive values reach userspace as bogus errors.
> Explicitly set ret to 0 on the success path.
> 
> Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 3d0bdba2a..784e36d72 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -390,6 +390,8 @@ panfrost_ioctl_wait_bo(struct drm_device *dev, void *data,
>  				    true, timeout);
>  	if (!ret)
>  		ret = timeout ? -ETIMEDOUT : -EBUSY;
> +	else if (ret > 0)
> +		ret = 0;
>  
>  	drm_gem_object_put(gem_obj);
>  


