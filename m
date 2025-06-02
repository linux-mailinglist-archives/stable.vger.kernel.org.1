Return-Path: <stable+bounces-150596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABBDACB8E8
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC1191BA6B87
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912114A1E;
	Mon,  2 Jun 2025 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ds5aAgcJ"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931431465A1
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748878453; cv=none; b=cc+X9cHlJLq8A//Z3nX43L9KbQcCMOox5lbe6BrN4lDlUFex1k0gdFRMTEtp6keMxKE1FE8lMsBYvHNbEXXWqAiMbkk6aRNZCq1WXvt1+pT5ifyN17ELOQf557Q4Vf5BGqJlpT4RvySGqEQ8OOox3EU2KSJKEEbhbM8BEeAZvIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748878453; c=relaxed/simple;
	bh=AqGvlmTC5J9HRQqMSgFftTE3ExOQiaSXNArUPTsnGhk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nKylfwjGiw+hvg2fl3x0IlFNQw0e08FKTX6n9q/h2/rltSbhDh/1vP1jmogBx0cQ3iD4u+MzRiYhdIVRIOn60Q0ZK/XkCA8yZHI9S0wZtluI/qmUq5aJ12XjiKgbL1n0MZDcMDDgo41VxmvxvHaeMig89X+VEIYXagiAf4Yipek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Ds5aAgcJ; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4b9yYk1jt6z9shl;
	Mon,  2 Jun 2025 17:34:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1748878442; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Awe1dhGUcwlwFptO9inKqI3/zNABpay/R4/pLVsmyo=;
	b=Ds5aAgcJ8EJJRaU39n2e8A+c7O2PKcwTNUlOxkrBaNM0oOiv47UtPEM6qsDp+nGtN6eSdG
	y/W2S02jag5AaEPGflZPTHhtde3qjXecJ3SOvevWK4xo8OvhGXAwkRfKTg1IxRxn7xFNZW
	JqMiwt7a5wKzU8Cc5Mq6tsDpJXeIG9rgwv26ZNp23kBwTkKK7/IcTgMPfqRqODV4F81ZMy
	QCygn6GH/A2CnUuzZl8CRJchuRJ1PNzKy/HlVzfHr8QwV8etgqbYQvJQhTAzYh1STvD9cp
	+v07SPM6GFlwMqRfpaYh0OQwR5q3p/Z5gy8gUqMNjXSVAgWIfc9PlGFfGg+nIQ==
Message-ID: <3cb4d2c9c5db4b459344ee1ff6ebdea77804ee4b.camel@mailbox.org>
Subject: Re: [PATCH] drm/etnaviv: Protect the scheduler's pending list with
 its lock
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Lucas Stach
 <l.stach@pengutronix.de>, Philipp Zabel <p.zabel@pengutronix.de>, Russell
 King <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
 <cgmeiner@igalia.com>,  Philipp Stanner <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org, 
	kernel-dev@igalia.com, stable@vger.kernel.org
Date: Mon, 02 Jun 2025 17:33:58 +0200
In-Reply-To: <20250602132240.93314-1-mcanal@igalia.com>
References: <20250602132240.93314-1-mcanal@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: rho4fa8zrfi8ucdopgjd97j174pda5hb
X-MBO-RS-ID: 12d2fd6bc7dd542828a

On Mon, 2025-06-02 at 10:22 -0300, Ma=C3=ADra Canal wrote:
> Commit 704d3d60fec4 ("drm/etnaviv: don't block scheduler when GPU is
> still
> active") ensured that active jobs are returned to the pending list
> when
> extending the timeout. However, it didn't use the pending list's lock
> to
> manipulate the list, which causes a race condition as the scheduler's
> workqueues are running.
>=20
> Hold the lock while manipulating the scheduler's pending list to
> prevent
> a race.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 704d3d60fec4 ("drm/etnaviv: don't block scheduler when GPU is
> still active")

Could also contain a "Closes: " with the link to the appropriate
message from thread [1] from below.

You might also include "Reported-by: Philipp" since I technically first
described the problem. But no hard feelings on that

> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>

Reviewed-by: Philipp Stanner <phasta@kernel.org>

> ---
> Hi,
>=20
> I'm proposing this workaround patch to address the race-condition
> caused
> by manipulating the pending list without using its lock. Although I
> understand this isn't a complete solution (see [1]), it's not
> reasonable
> to backport the new DRM stat series [2] to the stable branches.
>=20
> Therefore, I believe the best solution is backporting this fix to the
> stable branches, which will fix the race and will keep adding the job
> back to the pending list (which will avoid most memory leaks).
>=20
> [1]
> https://lore.kernel.org/dri-devel/bcc0ed477f8a6f3bb06665b1756bcb98fb7af87=
1.camel@mailbox.org/
> [2]
> https://lore.kernel.org/dri-devel/20250530-sched-skip-reset-v2-0-c40a8d2d=
8daa@igalia.com/
>=20
> Best Regards,
> - Ma=C3=ADra
> ---
> =C2=A0drivers/gpu/drm/etnaviv/etnaviv_sched.c | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_sched.c
> b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
> index 76a3a3e517d8..71e2e6b9d713 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_sched.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
> @@ -35,6 +35,7 @@ static enum drm_gpu_sched_stat
> etnaviv_sched_timedout_job(struct drm_sched_job
> =C2=A0							=C2=A0
> *sched_job)
> =C2=A0{
> =C2=A0	struct etnaviv_gem_submit *submit =3D
> to_etnaviv_submit(sched_job);
> +	struct drm_gpu_scheduler *sched =3D sched_job->sched;
> =C2=A0	struct etnaviv_gpu *gpu =3D submit->gpu;
> =C2=A0	u32 dma_addr, primid =3D 0;
> =C2=A0	int change;
> @@ -89,7 +90,9 @@ static enum drm_gpu_sched_stat
> etnaviv_sched_timedout_job(struct drm_sched_job
> =C2=A0	return DRM_GPU_SCHED_STAT_NOMINAL;
> =C2=A0
> =C2=A0out_no_timeout:
> -	list_add(&sched_job->list, &sched_job->sched->pending_list);
> +	spin_lock(&sched->job_list_lock);
> +	list_add(&sched_job->list, &sched->pending_list);
> +	spin_unlock(&sched->job_list_lock);
> =C2=A0	return DRM_GPU_SCHED_STAT_NOMINAL;
> =C2=A0}
> =C2=A0


