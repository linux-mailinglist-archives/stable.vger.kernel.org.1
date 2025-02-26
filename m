Return-Path: <stable+bounces-119669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C919DA45F7B
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 13:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF2F164BCF
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 12:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47F3215166;
	Wed, 26 Feb 2025 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JPa35gLf"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887A618024;
	Wed, 26 Feb 2025 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573617; cv=none; b=XknllJfxORSphddO5sJmRcrew+zjI1DgNc6Jyq/s0WwGD0YizWZVQKRpboHSTwdLegOp2VwxnOK7M2mIKxHATr9xWNa/9uhDYAAWs3/oVcqEPCyax6h2KQ2eAj3JnPvwbfBnswB5N4o+67zA6qfmZi9w4kTsl8IycrWb+Jdhw1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573617; c=relaxed/simple;
	bh=hoTM6ye1U0cropi9cWGckjGlQYCb63GXZH+OrhAk56U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=svNH7EBoOeAW72O3Vlq26AuimnOpI6fnlRgXA2rRVKv4fbxcF6UEAlJALJJU4Z7YynestmLUslJkBLOkyEjwzbSUQWmw0sQYW4dfI/RZG4H4zpfKKAt2aTR2/XQiWYyaj2V8cvEPdQLSk80r8YKSmfTt5pm8c251wpeNdmqPYlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=JPa35gLf; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Z2vFK6VcDz9tH5;
	Wed, 26 Feb 2025 13:40:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1740573605; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZ+uIJiq3RhTKEA0gh5ZWipu0RfM+2RCWylSkxgmlWY=;
	b=JPa35gLfjz9F0PVStYwlKmHjJ9E4k0AWCHhRXdZDYvnIfaMeuv1akUBer9uNAQCcsqpm0x
	iS51R5FQ3Z1M20KjKqFaL1YQkQAt/giBv8Nv4FV2DCshI9pkqVXDFtcrRTOeXESoRNPxP0
	lyETC7FJIB15e4qEL1Aw6KQzdK3wjVkM9GfdCRRo7DHJmwsZdF+YAYF24CS/QWbehQFX3e
	mZIybZA4SkmML1T/0+1IFQzD8672eJ6JrchgxIa/yAM5zHex54bPEAh0QKnNcLyNzK/f7x
	HylFjsXdhcxovtaRuiHhlTiO/wif3NStyEG5iGGLq7k2IvbNud+yUe9Okl9qwQ==
Message-ID: <99a18daf596ca384d38e561675cf3e13a9ed3161.camel@mailbox.org>
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
Date: Wed, 26 Feb 2025 13:40:01 +0100
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
X-MBO-RS-META: dcpuawum54q7wqs4efgup93ayfw5tcuh
X-MBO-RS-ID: 4711bda07a75dfb2973

On Wed, 2025-02-26 at 17:05 +0800, Qianyi Liu wrote:
> From: qianyi liu <liuqianyi125@gmail.com>
>=20
> The last_scheduled fence leaked when an entity was being killed and
> adding its callback failed.
>=20
> Decrement the reference count of prev when dma_fence_add_callback()
> fails, ensuring proper balance.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 2fdb8a8f07c2 ("drm/scheduler: rework entity flush, kill and
> fini")
> Signed-off-by: qianyi liu <liuqianyi125@gmail.com>

@Matt: since you in principle agreed with this patch, could you give it
an official RB?

I could then take it [but will probably rephrase some nits in the
commit message]


P.

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
> =C2=A0			drm_sched_entity_kill_jobs_cb(NULL, &job-
> >finish_cb);
> +		}
> =C2=A0
> =C2=A0		prev =3D &s_fence->finished;
> =C2=A0	}


