Return-Path: <stable+bounces-100599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B269EC9DF
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 11:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480F9188A225
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 10:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A00208986;
	Wed, 11 Dec 2024 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zyi2Y7cL"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC3E1A83E3
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733911219; cv=none; b=prHnoHplN4d0jycwjBg9vuyvp/x5HEby5x/aBAUvjZjp9SLuz5gSLBpdpfOPMlvo7Z0jT0aoyIRy1Cr9bSy+STjnNxSXNpi3Y3NwkBhvLxFYpT/M9CKnFzkXw0IbJTLDScUiv485xElETpDgwaK97B8jxkkHoz0Ewdr+2IewbEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733911219; c=relaxed/simple;
	bh=m16ojPY23lRp3kCszmlm6JGYwT/QYvlJ02am0tlpO8A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rVNIerfWei+D06IraZ9M+6P+2TZE1CrCxC2j1VzvRt2Skvi0EylFGN3+bAHHHwzRFkf2C2NfGYpPoY7FJ0JR692MijusUIcjkp0h+C20oQhxkiXUu2G9Td3NomjqVftWlWcHHLQfq/ABetp9JqGZHV5UYIBsMuRAQbcpeLUrHaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zyi2Y7cL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733911215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A4G1Jx275qN6LcIhA4ArXBMeFvjyULgRS2nH9akxaJU=;
	b=Zyi2Y7cLWRXQvEeAIzsj3Em+QN9DMTWJDrZ8Oms4FtMEd65Wzkcyvnn7YrL8+IvsiIU21b
	uzgfT6N81Xn0Ae+vTjsdR0mEFR5RuBju1yd0B+AlfEKUBLRqClfuunl717l01rmZ5EHTQM
	IDK/PSoN8GnAOmvII2DkeZjMPdX7fCc=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-zyYY8gAQMc6g8Ntcvwr01Q-1; Wed, 11 Dec 2024 05:00:14 -0500
X-MC-Unique: zyYY8gAQMc6g8Ntcvwr01Q-1
X-Mimecast-MFC-AGG-ID: zyYY8gAQMc6g8Ntcvwr01Q
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-728ea538b52so1724046b3a.3
        for <stable@vger.kernel.org>; Wed, 11 Dec 2024 02:00:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733911213; x=1734516013;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A4G1Jx275qN6LcIhA4ArXBMeFvjyULgRS2nH9akxaJU=;
        b=h9LhJRFkhnrESPCYTF5nx+NYhYeTI3nJnOUKx0lM9i54JP7Qc11YOD5ZdfxxY9JvSa
         MhbuMb+T+Eb3HOUHuJTQu5tgAitYKwlO/IM+RmfdFOKLW+V03JRu1y2iNBbMc6pprHXa
         01Yq84P8Jq+7dthS5kQLXrOCJl0pY9SfA8slugBcsElv28zM4DOB/5eRr/j6MjZY/omN
         nU0giOVWBZ067RiIUDFjCmAzBh1EpD9Xi10oAUiAkk1aefBfGBsQqAbux/OV9CYZAGPv
         vWhLw7ne/dqw8linwn1SPmVuUEtvcz9fRJu4/qdA5TJ2/rse28u+pVW1E1MrR28VpIRe
         zeZQ==
X-Gm-Message-State: AOJu0YxUy9xntlTOKs/I0Y5DpM7hCiacgScURZAoklw4OlOqqoVmWoil
	wFxPyP852W8QVgw1Vi4NnKchSn/TKaqsijhmwUxXcC0qTqpVes215DAC0ENBdx9NdEvqmx6koyv
	+7NUASlMRVG9JjaaciMbKSN0Xc8tNiQZRiMPxUCadvXbR1ySlr8nhf2EPqFEdHJSU72pxMk3tDg
	aSX3FTAFuu+pwLKG9wVuEyyCVMtkL6rrA5q49iDSv6
X-Gm-Gg: ASbGncv61a40gVplKZqu2ABUuSPzP/m8InuIVS6e8pAkrOs/KYhTBBLvkhDYRpL+DQD
	U7JxEp27sILOpPtJiI/4GBCuaY7KqPl++HhpNhlqOM/p+Wj2m3Vj3X1wM+UqR8OaJpSF8/3+uI6
	ojClevRPOZiapUPTIYsg9AsEu6w9+YYjZaZXctOItj3WjgwrZXvmbOqkwQa5X4yRZMRxyzI9ZhS
	dvcv4jBrff57uySOZQMkSQ2Ntq76/4BA4RffP23AiLCP5Aof7q/obRs8wd1kJizk3jJA1GpRgON
	NaID
X-Received: by 2002:aa7:88c7:0:b0:725:ffe:4dae with SMTP id d2e1a72fcca58-728ed3dca47mr4020115b3a.10.1733911213483;
        Wed, 11 Dec 2024 02:00:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECyyRUnrdN0BaZYlR/NYMD7vGEeBTEW+XyR1dZlXj2YlMA80qmCCrUacY1Kd3BPLzzpksokg==
X-Received: by 2002:aa7:88c7:0:b0:725:ffe:4dae with SMTP id d2e1a72fcca58-728ed3dca47mr4020038b3a.10.1733911212932;
        Wed, 11 Dec 2024 02:00:12 -0800 (PST)
Received: from [10.200.68.91] (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e34bbb22sm6158461b3a.81.2024.12.11.02.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 02:00:12 -0800 (PST)
Message-ID: <fcfc505ed42d7b263a209631c43734fb6674377e.camel@redhat.com>
Subject: Re: Patch "drm/sched: memset() 'job' in drm_sched_job_init()" has
 been added to the 6.12-stable tree
From: Philipp Stanner <pstanner@redhat.com>
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Luben Tuikov <ltuikov89@gmail.com>, Matthew Brost
 <matthew.brost@intel.com>,  Danilo Krummrich <dakr@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>
Date: Wed, 11 Dec 2024 11:00:02 +0100
In-Reply-To: <20241210204128.3579664-1-sashal@kernel.org>
References: <20241210204128.3579664-1-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-12-10 at 15:41 -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>=20
> =C2=A0=C2=A0=C2=A0 drm/sched: memset() 'job' in drm_sched_job_init()
>=20
> to the 6.12-stable tree which can be found at:
> =C2=A0=C2=A0=C2=A0
> http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.git;a=
=3Dsummary
>=20
> The filename of the patch is:
> =C2=A0=C2=A0=C2=A0=C2=A0 drm-sched-memset-job-in-drm_sched_job_init.patch
> and it can be found in the queue-6.12 subdirectory.
>=20
> If you, or anyone else, feels it should not be added to the stable
> tree,
> please let <stable@vger.kernel.org> know about it.

Hi,

you can add it, it does improve things a bit.

But I'd like to use this opportunity to understand by what criteria you
found and selected this patch? Stable was not on CC, neither does the
patch contain a Fixes tag.


Regards,
P.


>=20
>=20
>=20
> commit d0a6c893de0172427064e39be400a23b0ba5ffec
> Author: Philipp Stanner <pstanner@redhat.com>
> Date:=C2=A0=C2=A0 Mon Oct 21 12:50:28 2024 +0200
>=20
> =C2=A0=C2=A0=C2=A0 drm/sched: memset() 'job' in drm_sched_job_init()
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 [ Upstream commit 2320c9e6a768d135c7b0039995182bb1a4e4=
fd22 ]
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 drm_sched_job_init() has no control over how users all=
ocate
> struct
> =C2=A0=C2=A0=C2=A0 drm_sched_job. Unfortunately, the function can also no=
t set some
> struct
> =C2=A0=C2=A0=C2=A0 members such as job->sched.
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 This could theoretically lead to UB by users dereferen=
cing the
> struct's
> =C2=A0=C2=A0=C2=A0 pointer members too early.
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 It is easier to debug such issues if these pointers ar=
e
> initialized to
> =C2=A0=C2=A0=C2=A0 NULL, so dereferencing them causes a NULL pointer exce=
ption.
> =C2=A0=C2=A0=C2=A0 Accordingly, drm_sched_entity_init() does precisely th=
at and
> initializes
> =C2=A0=C2=A0=C2=A0 its struct with memset().
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 Initialize parameter "job" to 0 in drm_sched_job_init(=
).
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> =C2=A0=C2=A0=C2=A0 Link:
> https://patchwork.freedesktop.org/patch/msgid/20241021105028.19794-2-psta=
nner@redhat.com
> =C2=A0=C2=A0=C2=A0 Reviewed-by: Christian K=C3=B6nig <christian.koenig@am=
d.com>
> =C2=A0=C2=A0=C2=A0 Signed-off-by: Sasha Levin <sashal@kernel.org>
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> b/drivers/gpu/drm/scheduler/sched_main.c
> index e97c6c60bc96e..416590ea0dc3d 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -803,6 +803,14 @@ int drm_sched_job_init(struct drm_sched_job
> *job,
> =C2=A0		return -EINVAL;
> =C2=A0	}
> =C2=A0
> +	/*
> +	 * We don't know for sure how the user has allocated. Thus,
> zero the
> +	 * struct so that unallowed (i.e., too early) usage of
> pointers that
> +	 * this function does not set is guaranteed to lead to a
> NULL pointer
> +	 * exception instead of UB.
> +	 */
> +	memset(job, 0, sizeof(*job));
> +
> =C2=A0	job->entity =3D entity;
> =C2=A0	job->credits =3D credits;
> =C2=A0	job->s_fence =3D drm_sched_fence_alloc(entity, owner);
>=20


