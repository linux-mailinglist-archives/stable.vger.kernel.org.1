Return-Path: <stable+bounces-124220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1133FA5EE3B
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 292D27A6844
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 08:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82CE261562;
	Thu, 13 Mar 2025 08:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OStm+eJx"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55151EA7FC;
	Thu, 13 Mar 2025 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855287; cv=none; b=uyk1cEseu9BofWdUr+2LiR2alqLDRmALIhucLnO+lVMDZooAnRGZhFvc6StCvfdAzE28CCYUgRK90kGDjZUnJb5NTTaaj+pSYUHe/AH2Tbpv/nNPaNFh/Pi23AooE0RcffBa7crqKjGBGf4SUDLP0Sna1P93LcZ6sTCF+kxxXmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855287; c=relaxed/simple;
	bh=/Am8PS1urBK4vKQNjEf+4rlsiDrz113oLVXfJaO/094=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HAmE4lRM2VDeS4ijODJiT9K86UiDtMxrTl6uhIIN5nfvyhtiZopVbtPRRXCKgDUxYzzXsos7nK45Va02I6pViT3kOCRvvwuS59q3L3kF6Qbfyn7h64jhg/y7CyAMSuO9A3mziieGgh6HEtSAsqdj39Iwojd2CZNFYN0kD53Cn7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=OStm+eJx; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZD1Dq63N9z9tD1;
	Thu, 13 Mar 2025 09:41:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1741855275; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m0s9BXoOXwlavaR7+igiPKZFuNZEvjYPYrMoR9PJJ9U=;
	b=OStm+eJxJOT29Vjs9GNAVvClQl4ZrJ22/0/f3Ja9wWMbjT9yVJaJbTK6wsNYfKATILNJZZ
	7APXc+TcCsKMT9bwiTIbs+ChmSaHo4CXt64G7pLc4jb5qcAvc2ZO2cEH9JsCeQpuqHeFGY
	YPJLcM51YL5PAmsaC7kmVp/eeltE8IRBr4H4rANlaV3P+SjWJlGRlcdBS0X2oCdWKKYjo0
	2S6XPkqX8nQnISiSVykbX0yq1Ajz7yQRTxB8AzCmC/sfUtD1rUuaESEwUPBqkRvkX/fONW
	6ztu+gLeXzss5rmkVTOS2+asSDtLFcfEc29Rj3spsIjBJ3bxOWi73le8l1FoHw==
Message-ID: <91a06e390d6b526bd9e9ba37cb478d337a2294dd.camel@mailbox.org>
Subject: Re: [PATCH V4] drm/sched: Fix fence reference count leak
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Qianyi Liu <liuqianyi125@gmail.com>, airlied@gmail.com, 
 ckoenig.leichtzumerken@gmail.com, dakr@kernel.org, daniel@ffwll.ch, 
 maarten.lankhorst@linux.intel.com, matthew.brost@intel.com,
 mripard@kernel.org,  phasta@kernel.org, tzimmermann@suse.de
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Thu, 13 Mar 2025 09:41:11 +0100
In-Reply-To: <20250311060251.4041101-1-liuqianyi125@gmail.com>
References: <20250311060251.4041101-1-liuqianyi125@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: q1q4tsbu5owia83jckezz1ppzj9i6pga
X-MBO-RS-ID: 1b049b0e8507b5db404

On Tue, 2025-03-11 at 14:02 +0800, Qianyi Liu wrote:
> From: qianyi liu <liuqianyi125@gmail.com>
>=20
> The last_scheduled fence leaks when an entity is being killed and
> adding
> the cleanup callback fails.
>=20
> Decrement the reference count of prev when dma_fence_add_callback()
> fails, ensuring proper balance.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 2fdb8a8f07c2 ("drm/scheduler: rework entity flush, kill and
> fini")
> Signed-off-by: qianyi liu <liuqianyi125@gmail.com>

Applied to drm-misc-fixes, thank you.

P.

> ---
> v3 -> v4: Improve commit message and add code comments (Philipp)
> v2 -> v3: Rework commit message (Markus)
> v1 -> v2: Added 'Fixes:' tag and clarified commit message (Philipp
> and Matthew)
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_entity.c | 11 +++++++++--
> =C2=A01 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c
> b/drivers/gpu/drm/scheduler/sched_entity.c
> index 69bcf0e99d57..da00572d7d42 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -259,9 +259,16 @@ static void drm_sched_entity_kill(struct
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
> +			/*
> +			 * Adding callback above failed.
> +			 * dma_fence_put() checks for NULL.
> +			 */
> +			dma_fence_put(prev);
> =C2=A0			drm_sched_entity_kill_jobs_cb(NULL, &job-
> >finish_cb);
> +		}
> =C2=A0
> =C2=A0		prev =3D &s_fence->finished;
> =C2=A0	}


