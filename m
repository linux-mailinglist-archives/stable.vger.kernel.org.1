Return-Path: <stable+bounces-121676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA42A58F2F
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 10:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5F4F3A6387
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 09:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57888224896;
	Mon, 10 Mar 2025 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pU+pR6Uj"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801202248B9;
	Mon, 10 Mar 2025 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598035; cv=none; b=k68HUI4dAF4rSl4xdhB50oDBl0acBdgKf1o7I+G3SU70N8Y0P3RSzswXFLGOAraUVJqC98dnk+6lkQx8kl5L93PS76YIc0uYP/m0djA08NmRQtPaLXpcXSak5DyQPIadwrbTYz9m5w++PwaLZ8XjoS+T9etP8szcqbVtmUhOm+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598035; c=relaxed/simple;
	bh=XfqVA1eLFQTZsxMmkkRxeF2YhLjvx7FSu87mBznz5Ag=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MFfBRgO0yqRCSnBAfg8io6CT9fsPL/cysNVb6p5VfFLk8h2Bc8kAF/H/Yo/KlFg6VQjeWF9fpX4NgZvJSTc8o2vhWM+Kr8K2TFXP0Mgdzecf8WOe+jT4t/3dJtiRspCTR79hQh4fT8BFrxxdRq+lRIk9PjSaupsyQqn1TMlFCKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=pU+pR6Uj; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZBB5n5gXhz9t46;
	Mon, 10 Mar 2025 10:13:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1741598029; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Grk/iMdx6as89Jp6GRGx4aLkNUjRWKj6c7iYN0UxCY=;
	b=pU+pR6UjepIeZZq7nEwQHkLB02W7DIxPYvc6ntffoINVR5buiVl557Gs0nMMbetP5DWfGU
	slR+horO11JKIoPN4Vgl9lhSgwVRRqYY6AutHfY5TRucS5TVbM8syy2rnxa+wc3UNFvCzA
	EGkF8ZB/khkvekfup2JlY6uUr46EnYcZ9MXFSnwH5R5Xr0URhToa3r3XYTgYQW6wmGh/MQ
	bgnxugKBxsKM2XVcw0hLQMnmnu6dRXC8Wm+Cg1BHnnkM0TaSiPVSCG9WxTcfLTHpmiKCW8
	oyTNXY0uuIbBgD/pDfWiSkJBWPovONk+41PTvx3sYMCXlFtTg7X5Q1F/d5hDiA==
Message-ID: <a5f389b1c08847fb658f4120b205521e4a8ea0c1.camel@mailbox.org>
Subject: Re: [PATCH V3] drm/sched: Fix fence reference count leak
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Qianyi Liu <liuqianyi125@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
  Matthew Brost <matthew.brost@intel.com>, Philipp Stanner
 <phasta@kernel.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Mon, 10 Mar 2025 10:13:45 +0100
In-Reply-To: <20250226090521.473360-1-liuqianyi125@gmail.com>
References: <20250226090521.473360-1-liuqianyi125@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 686061f9bf9bbaf9224
X-MBO-RS-META: w4wqa8qnina3nwo1udsi9otp7yx1mt1u

Sorry for the delay

On Wed, 2025-02-26 at 17:05 +0800, Qianyi Liu wrote:
> From: qianyi liu <liuqianyi125@gmail.com>
>=20
> The last_scheduled fence leaked when an entity was being killed and
> adding its callback failed.

s/leaked/leaks

s/was being/is being

s/its callback/the cleanup callback

s/failed/fails


>=20
> Decrement the reference count of prev when dma_fence_add_callback()
> fails, ensuring proper balance.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 2fdb8a8f07c2 ("drm/scheduler: rework entity flush, kill and
> fini")
> Signed-off-by: qianyi liu <liuqianyi125@gmail.com>
> ---
> v2 -> v3: Rework commit message (Markus)
> v1 -> v2: Added 'Fixes:' tag and clarified commit message (Philipp
> and Matthew)
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_entity.c | 7 +++++--
> =C2=A01 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c
> b/drivers/gpu/drm/scheduler/sched_entity.c
> index 69bcf0e99d57..1c0c14bcf726 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -259,9 +259,12 @@ static void drm_sched_entity_kill(struct
> drm_sched_entity *entity)
> =C2=A0		struct drm_sched_fence *s_fence =3D job->s_fence;
> =C2=A0
> =C2=A0		dma_fence_get(&s_fence->finished);
> -		if (!prev || dma_fence_add_callback(prev, &job-
> >finish_cb,
> -					=C2=A0=C2=A0
> drm_sched_entity_kill_jobs_cb))
> +		if (!prev ||
> +		=C2=A0=C2=A0=C2=A0 dma_fence_add_callback(prev, &job->finish_cb,
> +					=C2=A0=C2=A0
> drm_sched_entity_kill_jobs_cb)) {
> +			dma_fence_put(prev);

Please add a little comment about the dma_fence_put()'s purpose. Sth
like "Adding callback above failed. dma_fence_put() checks for NULL."

Then we should be good I think

Thx

> =C2=A0			drm_sched_entity_kill_jobs_cb(NULL, &job-
> >finish_cb);
> +		}



}


> =C2=A0
> =C2=A0		prev =3D &s_fence->finished;
> =C2=A0	}


