Return-Path: <stable+bounces-70320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E572960684
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 12:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381BB287FDF
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 10:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EE81465AC;
	Tue, 27 Aug 2024 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XtumM2v4"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BE619B3EC
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 09:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752786; cv=none; b=p4lNFNv5KYelwlRnWgPp1lVf0oXbivY7HyQI79UXMdwDbBvafoKZZ5ISld4v/ZhWGOOdZfevOJal+jqGArpC929lJZjGfIcsIBNJJvf6ag0CDZ2j4BUN78rlHb3jGTqskD0klkn7ZhdMvxhOKnIEDDGJw8ejVMkDLjPXzijfXdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752786; c=relaxed/simple;
	bh=zZVE3vWUan8otGv4LuTXwV9rlEMM1/zbCXFssxs9lh4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZXQqxPUaAnu8QwDHfxELESqoNaurL9UnLThxArwkFG+1GQEZwGET6Dy70sZDSfhum1tMcgNccFyx+CPoP9M4I4ALgMnifEIsli9AoAri2ARgBeGYJkzcionrqY0HqtgK9KYehDZ0bUlleFN0gGDGcu+y9NHCJJHdJtdmQPNfvlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XtumM2v4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724752783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4jRfteUF4K6zdJt61qizH7SSD5maFMM9NgT5b4SG1L4=;
	b=XtumM2v4jrWc58Z9SmKk9FhIU+B6nZelgMVPbMGNlNwbQUkF55HIANOs49gXVGsmMF96Gn
	xT3JwTRga1etx/Ij2/H+LT0wI7tDvc3F0Nvx/figLhhwdftzCho6+FNRgvqfMB6hFrHHy2
	MTPOwFopylIxBggV33nHSQ5xFul9uLU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-jQM_ojucMYuRYXKEy7yr1Q-1; Tue, 27 Aug 2024 05:59:41 -0400
X-MC-Unique: jQM_ojucMYuRYXKEy7yr1Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3717ddcae71so3088552f8f.3
        for <stable@vger.kernel.org>; Tue, 27 Aug 2024 02:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724752781; x=1725357581;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4jRfteUF4K6zdJt61qizH7SSD5maFMM9NgT5b4SG1L4=;
        b=WN1Rj+jLoJixJ7tcjmP+Wqo2AHc+X+vZoHPlhAMDjjkB4NE77n3AL+kVD0E/NPsym/
         z6PmfQ8GDjjhecnj7hjT2fkmKF7CK7hn7KZcQR6L4corq2X24jZdVVgc9ASEXaV9fnNW
         SQ/AVLmz+aXBZmiF5Erp7eWGjDBx6P3NhHG6h8fz5VXUAtEtPTYBYVvnaA2FplSkDhRe
         DjTMTJmZalzmSKu69SpsHvwDxOWhW0JMezFJpYAeI6il0mFMnBAbvWnm/YQ/vBEiNavT
         lSgdY/hZj5m/ehH7VxtZdfQPIJhttyzSvZrq0IvR9X/zS0CBsQHI9X1vuyFA2IygsOXs
         J/hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN7ueWD1xbw7i0i4TckejKe8ICPiAwi/AvMI3GDiiEhdgww5LzWgF9+5L9viht0/ZSP8yAZjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFko6cICe7+1QcNxQfiP/W0Hqa/Dx8oud0DUFsfikN7PdqeUdP
	vTFgA6sT3qXSwUeUZ8vpPs2TRpgH36Yh0SaxYe6i9HexermlGVYPtSMzK0ZfduyrIPXhQ9VJty1
	trWoY2O7Evao8hxRmKZbp1RJ2ASd2DRGiJcdH/Z5mPG6oPxCehpU1KA==
X-Received: by 2002:adf:ebce:0:b0:368:30a6:16d8 with SMTP id ffacd0b85a97d-3748c82c860mr1355678f8f.57.1724752780651;
        Tue, 27 Aug 2024 02:59:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKwUoHsFBchjm634UKmy74PHfoiuNaHO4aK4VhEUsCColf/kxqsyFbzDHf8ZVSaLRBv9ehqw==
X-Received: by 2002:adf:ebce:0:b0:368:30a6:16d8 with SMTP id ffacd0b85a97d-3748c82c860mr1355665f8f.57.1724752780147;
        Tue, 27 Aug 2024 02:59:40 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dbc:3c00:460c:db7e:8195:ddb5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308200404sm12698815f8f.81.2024.08.27.02.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 02:59:39 -0700 (PDT)
Message-ID: <ae0c78841e0d7c35f93aeb36fc94ab630812087e.camel@redhat.com>
Subject: Re: [PATCH] drm/sched: Fix UB pointer dereference
From: Philipp Stanner <pstanner@redhat.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Danilo
 Krummrich <dakr@kernel.org>
Cc: Luben Tuikov <ltuikov89@gmail.com>, Matthew Brost
 <matthew.brost@intel.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 27 Aug 2024 11:59:38 +0200
In-Reply-To: <9ba7f944-52d1-4937-80c7-a03bc0c5b1d5@amd.com>
References: <20240827074521.12828-2-pstanner@redhat.com>
	 <c443e90d-6907-4a02-bab4-c1943f021a8c@kernel.org>
	 <9ba7f944-52d1-4937-80c7-a03bc0c5b1d5@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-27 at 11:00 +0200, Christian K=C3=B6nig wrote:
> Am 27.08.24 um 10:39 schrieb Danilo Krummrich:
> > On 8/27/24 9:45 AM, Philipp Stanner wrote:
> > > In drm_sched_job_init(), commit 56e449603f0a ("drm/sched: Convert
> > > the
> > > GPU scheduler to variable number of run-queues") implemented a
> > > call to
> > > drm_err(), which uses the job's scheduler pointer as a parameter.
> > > job->sched, however, is not yet valid as it gets set by
> > > drm_sched_job_arm(), which is always called after
> > > drm_sched_job_init().
> > >=20
> > > Since the scheduler code has no control over how the API-User has
> > > allocated or set 'job', the pointer's dereference is undefined
> > > behavior.
> > >=20
> > > Fix the UB by replacing drm_err() with pr_err().
> > >=20
> > > Cc: <stable@vger.kernel.org>=C2=A0=C2=A0=C2=A0 # 6.7+
> > > Fixes: 56e449603f0a ("drm/sched: Convert the GPU scheduler to=20
> > > variable number of run-queues")
> > > Reported-by: Danilo Krummrich <dakr@redhat.com>
> > > Closes:=20
> > > https://lore.kernel.org/lkml/20231108022716.15250-1-dakr@redhat.com/
> > > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > > ---
> > > =C2=A0 drivers/gpu/drm/scheduler/sched_main.c | 2 +-
> > > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/scheduler/sched_main.c=20
> > > b/drivers/gpu/drm/scheduler/sched_main.c
> > > index 7e90c9f95611..356c30fa24a8 100644
> > > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > > @@ -797,7 +797,7 @@ int drm_sched_job_init(struct drm_sched_job
> > > *job,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * or wor=
se--a blank screen--leave a trail in the
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * logs, =
so this can be debugged easier.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_err(job->sched, "%s: =
entity has no rq!\n",
> > > __func__);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("*ERROR* %s: entit=
y has no rq!\n", __func__);
> >=20
> > I don't think the "*ERROR*" string is necessary, it's pr_err()
> > already.
>=20
> Good point. I will remove that and also add a comment why drm_err
> won't=20
> work here before pushing it to drm-misc-fixes.

Well, as we're at it I want to point out that the exact same mechanism
occurs just a few lines below, from where I shamelessly copied it:

if (unlikely(!credits)) {
	pr_err("*ERROR* %s: credits cannot be 0!\n", __func__);


P.

>=20
> Thanks,
> Christian.
>=20
> >=20
> > Otherwise,
> >=20
> > Acked-by: Danilo Krummrich <dakr@kernel.org>
> >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOENT=
;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20


