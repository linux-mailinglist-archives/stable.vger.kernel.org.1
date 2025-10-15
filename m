Return-Path: <stable+bounces-185759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25477BDD55B
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 10:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D5C3A4490
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 08:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460282C15A2;
	Wed, 15 Oct 2025 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="c4tzzXhD"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BDD2D2394
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 08:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760516217; cv=none; b=b56NNOx96CmHDhZ0gidrtkhvsV7kH7OwYqdV2zixFHF4LU96aJibFm6P8mJXeAtIxjCMdKNKOQqrk1YY9CLdHYoCqysbQvhtRIMJF6lTGddpDcyMLCRLr4rJj375WsXJ7QerfbAc4ikxy7BvrPT3FROxWIZbQCMr8wnyUK12lzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760516217; c=relaxed/simple;
	bh=C7BSkyBXQ29L6uE1xSuz8AO6pXjZKHziAwzapPVSO0w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EmzuetsEASpVWhMgyVBEuFwtVpITSoT+mgye3Cp0aT8lKVLawyzjNTlvF8mBynNh0cT3RBs7qHz5Uumnz/ls+/oQIalWa9MhDT5/Iffb6G8CvwIj4Dmtzwdf7uG4JIq64s00mxZnYvsPtEPfBnEQUaHx4Bgq038Z0Ofm3JikbpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=c4tzzXhD; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cmkSr3nJxz9tLJ;
	Wed, 15 Oct 2025 10:16:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1760516204; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QiClFHNDcw7ltMq7TV0NHul53b4tdhoGhVA4VeYlkqc=;
	b=c4tzzXhDkz5+Rz2/HbOKHV6vtkBNuidvKsHvU+oHEyxj7jsU6TKm2aYrqS+kFBWCmgPqqa
	NLJeVCV4TohCx1oNKeXcOqy9c17+KGMdL1YAgKJQvoFG0u0NSZE/gF873Ww+ktfSCUtrH2
	Rew7a6ytLQMCHQpMbTN5uNUVQFS/txKpP2bFPkWJuTxBCGVikK7NPpKzI5yBbX1XuoZHW3
	DD5ypyzbI7CChVr2yQrhZdL1CIsUuuZZspK1ustgy7278xmMd7PF1Wjs/xCN34IAS/MRrh
	1yyzXDPDa1qStELXJgjIXcX/A/buKn5VTZicw/qtJGjd75LEJ9tH0FDuEhyQYQ==
Message-ID: <81b83fec1df7d87c049b75587bc3b9a2b7a026eb.camel@mailbox.org>
Subject: Re: [PATCH v2] drm/sched: Fix potential double free in
 drm_sched_job_add_resv_dependencies
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Dan Carpenter <dan.carpenter@linaro.org>, 
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Rob Clark
 <robdclark@chromium.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Matthew
 Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Philipp Stanner <phasta@kernel.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>, stable@vger.kernel.org
Date: Wed, 15 Oct 2025 10:16:38 +0200
In-Reply-To: <20251013190731.63235-1-tvrtko.ursulin@igalia.com>
References: <20251013190731.63235-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: bf7e414f5aa4a603f21
X-MBO-RS-META: sd7ihnhg1dypcieh78cstk8roghoahfq

On Mon, 2025-10-13 at 20:07 +0100, Tvrtko Ursulin wrote:
> When adding dependencies with drm_sched_job_add_dependency(), that
> function consumes the fence reference both on success and failure, so in
> the latter case the dma_fence_put() on the error path (xarray failed to
> expand) is a double free.
>=20
> Interestingly this bug appears to have been present ever since
> ebd5f74255b9 ("drm/sched: Add dependency tracking"), since the code back
> then looked like this:
>=20
> drm_sched_job_add_implicit_dependencies():
> ...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < fence_count; i++) =
{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ret =3D drm_sched_job_add_dependency(job, fences[i]);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (ret)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (; i < fence_count; i++)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 dma_fence_put(fences[i]);
>=20
> Which means for the failing 'i' the dma_fence_put was already a double
> free. Possibly there were no users at that time, or the test cases were
> insufficient to hit it.
>=20
> The bug was then only noticed and fixed after
> 9c2ba265352a ("drm/scheduler: use new iterator in drm_sched_job_add_impli=
cit_dependencies v2")

Ah right, drm maintainer tools don't tolerate it when the word "commit"
is missing from the SHA:

69e0fb8632ec (HEAD -> drm-misc-fixes) drm/sched: Fix potential double free =
in drm_sched_job_add_resv_dependencies
-:16: ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit =
<12+ chars of sha1> ("<title line>")' - ie: 'commit ebd5f74255b9 ("drm/sche=
d: Add dependency tracking")'
#16:=20
ebd5f74255b9 ("drm/sched: Add dependency tracking"), since the code back

-:35: WARNING:COMMIT_LOG_LONG_LINE: Prefer a maximum 75 chars per line (pos=
sible unwrapped commit description?)
#35:=20
9c2ba265352a ("drm/scheduler: use new iterator in drm_sched_job_add_implici=
t_dependencies v2")

-:35: ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit =
<12+ chars of sha1> ("<title line>")' - ie: 'commit 9c2ba265352a ("drm/sche=
duler: use new iterator in drm_sched_job_add_implicit_dependencies v2")'
#35:=20
9c2ba265352a ("drm/scheduler: use new iterator in drm_sched_job_add_implici=
t_dependencies v2")

-:37: ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit =
<12+ chars of sha1> ("<title line>")' - ie: 'commit 4eaf02d6076c ("drm/sche=
duler: fix drm_sched_job_add_implicit_dependencies")'
#37:=20
4eaf02d6076c ("drm/scheduler: fix drm_sched_job_add_implicit_dependencies")=
.

-:40: ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit =
<12+ chars of sha1> ("<title line>")' - ie: 'commit 963d0b356935 ("drm/sche=
duler: fix drm_sched_job_add_implicit_dependencies harder")'
#40:=20
963d0b356935 ("drm/scheduler: fix drm_sched_job_add_implicit_dependencies h=
arder")


Reiterate that in a v3 please. You could also help me out and change
Reference (not a valid git tag afais) to Closes: as discussed before,
then I don't have to modify your patch.


P.


> landed, with its fixup of
> 4eaf02d6076c ("drm/scheduler: fix drm_sched_job_add_implicit_dependencies=
").
>=20
> At that point it was a slightly different flavour of a double free, which
> 963d0b356935 ("drm/scheduler: fix drm_sched_job_add_implicit_dependencies=
 harder")
> noticed and attempted to fix.
>=20
> But it only moved the double free from happening inside the
> drm_sched_job_add_dependency(), when releasing the reference not yet
> obtained, to the caller, when releasing the reference already released by
> the former in the failure case.
>=20
> As such it is not easy to identify the right target for the fixes tag so
> lets keep it simple and just continue the chain.
>=20
> While fixing we also improve the comment and explain the reason for takin=
g
> the reference and not dropping it.
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: 963d0b356935 ("drm/scheduler: fix drm_sched_job_add_implicit_depen=
dencies harder")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reference: https://lore.kernel.org/dri-devel/aNFbXq8OeYl3QSdm@stanley.mou=
ntain/
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Rob Clark <robdclark@chromium.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Philipp Stanner <phasta@kernel.org>
> Cc: "Christian K=C3=B6nig" <ckoenig.leichtzumerken@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.16+
> ---
> v2:
> =C2=A0* Re-arrange commit text so discussion around sentences starting wi=
th
> =C2=A0=C2=A0 capital letters in all cases can be avoided.
> =C2=A0* Keep double return for now.
> =C2=A0* Improved comment instead of dropping it.
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 13 +++++++------
> =C2=A01 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index 46119aacb809..c39f0245e3a9 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -965,13 +965,14 @@ int drm_sched_job_add_resv_dependencies(struct drm_=
sched_job *job,
> =C2=A0	dma_resv_assert_held(resv);
> =C2=A0
> =C2=A0	dma_resv_for_each_fence(&cursor, resv, usage, fence) {
> -		/* Make sure to grab an additional ref on the added fence */
> -		dma_fence_get(fence);
> -		ret =3D drm_sched_job_add_dependency(job, fence);
> -		if (ret) {
> -			dma_fence_put(fence);
> +		/*
> +		 * As drm_sched_job_add_dependency always consumes the fence
> +		 * reference (even when it fails), and dma_resv_for_each_fence
> +		 * is not obtaining one, we need to grab one before calling.
> +		 */
> +		ret =3D drm_sched_job_add_dependency(job, dma_fence_get(fence));
> +		if (ret)
> =C2=A0			return ret;
> -		}
> =C2=A0	}
> =C2=A0	return 0;
> =C2=A0}


