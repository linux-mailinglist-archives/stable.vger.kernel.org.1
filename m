Return-Path: <stable+bounces-181495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8B1B95F55
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 15:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F75165A92
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 13:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2179D322C9B;
	Tue, 23 Sep 2025 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJcswSEn"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13029324B03
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758633052; cv=none; b=bouG35h7Zlo9RaPh1fFQLdJ9CLbZYZ3pRkZBwSq9xNmgpsPq3fZKf2c4o860tXZIpT0RTYTzF5UYl8Nds5f7R/wJMEWS8VNGqVyejtn+Sij8ctp5EoIeFxWDpvhDTZv0ZlD3pZolRZnCAQZxzbiiIME3uEap7cNQ8K2VrqVsm7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758633052; c=relaxed/simple;
	bh=/L429GQ1uOh7RA6H+pvmUHywDeZB8eFEjE+XGYvQyEg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LxLtnpqZEOQLaEXLBkK98vBfpoFlX26SfNPeol0Fo7I63oJpE/tThLEoX0BL7W/dr5OYCXaIfAQeYT5m3ydukOPpbHinCZO/Tj1VICBbviovaBK9PN4BD5PBsViWClvOfht4KwFzWMBvdGvC1sU7mSlB1Jnxl90wxfDDUUTjQgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SJcswSEn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758633050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/L429GQ1uOh7RA6H+pvmUHywDeZB8eFEjE+XGYvQyEg=;
	b=SJcswSEnamn1kzbVi89FVBME7SiH31/ZKYP5r22hKUbqOl7cFWSXTaYN/5+bIv1kEcFwUx
	GLdLOR7lX0XsvSG/Fa+TYM9jmJbhTJa5IjdaNwVkQrvoRQYacwKPaKOXZmXGxAMcJGcsEJ
	OyHYiXA0/r7ySig0YpSIyEgnHtCxdec=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-rhvbv7OpPLiAC82pSmTnzQ-1; Tue, 23 Sep 2025 09:10:48 -0400
X-MC-Unique: rhvbv7OpPLiAC82pSmTnzQ-1
X-Mimecast-MFC-AGG-ID: rhvbv7OpPLiAC82pSmTnzQ_1758633047
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f3c118cbb3so3503104f8f.3
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 06:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758633047; x=1759237847;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/L429GQ1uOh7RA6H+pvmUHywDeZB8eFEjE+XGYvQyEg=;
        b=Cb7Qs6um+30RqbtkQ+m3fqQ3HiSYNKNh3keQh8350rHVy6KmDSTWSvFsAdbXl4mgtv
         WTd5VfjHC9s4EV59ZkHtl2yvO5HKLCylLL08NG6wAj3VC5qIpP5O2rhU3fBcLypi+ilI
         hS/jrRCC0/tToqHUK3a/gcR7heIeEBZEpctDNJvKc5St3kf7gkzy3dAboquD7HPM6J9V
         210Wh/4TVH0B796DoLQj4jg+Qp8z/IE9xH7nE9kHxqJUi81BivLezzFVd2TlIXQEKy0g
         eBJCEWT6qZGafPzJ5H5MQm3+W/mBywYBk1tzlS6GHu0YIkZ+QPs3DijYYrMoWasm+2ic
         Tucg==
X-Forwarded-Encrypted: i=1; AJvYcCXl+/3i0kooQk/Gji9LyAEUZrVRKvteySfL/PNUjExPwsPjG0XuFtShNtP0VDj2RBOI+Isaw94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL7sQE0KJkakZ1SIBUaPfxzvb8xqjyBRcz/Ie/PpDi1CQJMYGA
	qh6IQBI5gtf8A+kg7gTre3slcjD+UR06PvJa2QCzYlISngLDo8eFA9lp5J8aruZO0bRa8Tu1Hd6
	jdPMS0wmvG/3TugZWmzsFO3CY68sOGOLpcrqisnJg2gbgZOXupGQU/RrNvg==
X-Gm-Gg: ASbGnctgaMTMKVyI1cQeiKRV8vjNSX63gyQqdT/VtIA2GIDgb9mcp0CLwzHWETyEIqz
	z6rhERU/jda1GcCKu8x6wrMk58Wg7ek+YHer9gIBzhD6hYPVEbTFAbCTBp7bGWSklDWUojnmIX5
	6ELlkiSLVX8s0PmWLq2YBKARqEctHumeN0gXOmb6NZYlyDTBR49NMIGxHEbRNTcjiaKaNXbXMgd
	xsVeBLa/gbyP8SJ0pzEqhr/gXuHahGhxFr1fjBXD8mBybZpx4zd/yRA8Qcu5K86PNY/PtPkjjwk
	5s0+MTcNIlBEVswQ/R/iEc6jIUjyd+KdiSqm1mmYRT4agaC6/L3H5Oa6OKTz/gBZISNPmdSzLl6
	0mix/EBvS3Y0=
X-Received: by 2002:a05:6000:2388:b0:3f5:d7c0:8e20 with SMTP id ffacd0b85a97d-405cc61b265mr2327014f8f.59.1758633047035;
        Tue, 23 Sep 2025 06:10:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt6kkzJnB4R0EOzLnqEobs3aqaJIq7FEq25TjAjTfM0wJ0z2gPz3D2MfgMcwHX+t2X7MPWZQ==
X-Received: by 2002:a05:6000:2388:b0:3f5:d7c0:8e20 with SMTP id ffacd0b85a97d-405cc61b265mr2326968f8f.59.1758633046501;
        Tue, 23 Sep 2025 06:10:46 -0700 (PDT)
Received: from ?IPv6:2001:16b8:3dcc:c800:4ce1:1543:83d3:837? ([2001:16b8:3dcc:c800:4ce1:1543:83d3:837])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-402188ef7b2sm5669308f8f.34.2025.09.23.06.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:10:46 -0700 (PDT)
Message-ID: <bda64a5003dacc9dde293b7e09904f1413d9d12f.camel@redhat.com>
Subject: Re: [PATCH 6.12.y 1/3] drm/sched: Optimise drm_sched_entity_push_job
From: Philipp Stanner <pstanner@redhat.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Jules
 Maselbas <jmaselbas@zdiv.net>, stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Luben Tuikov
 <ltuikov89@gmail.com>, Matthew Brost <matthew.brost@intel.com>
Date: Tue, 23 Sep 2025 15:10:45 +0200
In-Reply-To: <76c94ee6-ba28-4517-8b6c-35658ac95d3b@amd.com>
References: <20250922130948.5549-1-jmaselbas@zdiv.net>
	 <8661bce085eed921feb3e718b8dc4c46784dff4d.camel@redhat.com>
	 <57b2275c-d18a-418d-956f-2ed054ec555f@amd.com>
	 <DCZMJLU7W6M0.23UOORGDH2DIR@zdiv.net>
	 <b49f45057de59f977d9e50a4aac12bac2e8d12a0.camel@redhat.com>
	 <76c94ee6-ba28-4517-8b6c-35658ac95d3b@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-23 at 14:33 +0200, Christian K=C3=B6nig wrote:
> On 23.09.25 14:08, Philipp Stanner wrote:
> > On Mon, 2025-09-22 at 22:50 +0200, Jules Maselbas wrote:
> > > On Mon Sep 22, 2025 at 7:39 PM CEST, Christian K=C3=B6nig wrote:
> > > > On 22.09.25 17:30, Philipp Stanner wrote:
> > > > > On Mon, 2025-09-22 at 15:09 +0200, Jules Maselbas wrote:
> > > > > > From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > > > >=20
> > > > > > commit d42a254633c773921884a19e8a1a0f53a31150c3 upstream.
> > > > > >=20
> > > > > > In FIFO mode (which is the default), both drm_sched_entity_push=
_job() and
> > > > > > drm_sched_rq_update_fifo(), where the latter calls the former, =
are
> > > > > > currently taking and releasing the same entity->rq_lock.
> > > > > >=20
> > > > > > We can avoid that design inelegance, and also have a miniscule
> > > > > > efficiency improvement on the submit from idle path, by introdu=
cing a new
> > > > > > drm_sched_rq_update_fifo_locked() helper and pulling up the loc=
k taking to
> > > > > > its callers.
> > > > > >=20
> > > > > > v2:
> > > > > > =C2=A0* Remove drm_sched_rq_update_fifo() altogether. (Christia=
n)
> > > > > >=20
> > > > > > v3:
> > > > > > =C2=A0* Improved commit message. (Philipp)
> > > > > >=20
> > > > > > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > > > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > > > Cc: Luben Tuikov <ltuikov89@gmail.com>
> > > > > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > > > > Cc: Philipp Stanner <pstanner@redhat.com>
> > > > > > Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > > > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > > > > > Link: https://patchwork.freedesktop.org/patch/msgid/20241016122=
013.7857-2-tursulin@igalia.com
> > > > > > (cherry picked from commit d42a254633c773921884a19e8a1a0f53a311=
50c3)
> > > > > > Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
> > > > >=20
> > > > > Am I interpreting this mail correctly: you want to get this patch=
 into
> > > > > stable?
> > > > >=20
> > > > > Why? It doesn't fix a bug.
> > > >=20
> > > > Patch #3 in this series depends on the other two, but I agree that =
isn't a good idea.
> > > Yes patch #3 fixes a freeze in amdgpu
> > >=20
> > > > We should just adjust patch #3 to apply on the older kernel as well=
 instead of backporting patches #1 and #2.
> > > I initially modified patch #3 to use .rq_lock instead of .lock, but i=
 didn't felt very confident with this modification.
> > > Should i sent a new version with a modified patch #3 ?
> > > If so, how the change should be reflected in the commit message ?
> > > (I initially ask #kernelnewbies but ended pulling the two other patch=
es)
> >=20
> > You know folks, situations like that are why we want to strongly
> > discourage accessing another API's struct members directly. There is no
> > API contract for them.
> >=20
> > And a proper API function rarely changes its interface, and if it does,
> > it's easy to find for the contributor where drivers need to be
> > adjusted. If we were all following that rule, you wouldn't even have to
> > bother with patches #1 and #2.
> >=20
> > That said, I see two proper solutions for your problem:
> >=20
> > =C2=A0=C2=A0 A. amdgpu is the one stopping the entities anyways, isn't =
it? It
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 knows which entities it has killed. So t=
hat information could be
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stored in struct amdgpu_vm.
>=20
> No, it's the scheduler which decides when entities are stopped.

The scheduler sets the stopped-flag, but that effectively only happens
when you either flush() or fini() the entity. OR if you run into that
drm_sched_fini() race.

>=20
> Otherwise we would need to re-invent the flush logic for every driver aga=
in.

Let's ask differently: Does amdgpu check here whether
drm_sched_entity_fini() or drm_sched_entity_flush() have been called on
those entities already?

>=20
> > =C2=A0=C2=A0 B. Add an API: drm_sched_entity_is_stopped(). There's also
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_sched_entity_is_idle(), but I guess =
that won't serve your
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 purpose?
>=20
> drm_sched_entity_is_stopped() should do it. drm_sched_entity_is_idle() is=
 something different and should potentially even not be exported to drivers=
 in the first place.

Fine by me.

>=20
> > And btw, as we're at it:
> > @Christian: Danilo and I recently asked about whether entities can
> > still outlive their scheduler in amdgpu?
>=20
> That should have been fixed by now. This happened only on hot-unplug and =
that was re-designed quite a bit.
>=20
> > That seems to be the reason why that race-"fix" in drm_sched_fini() was
> > added, which is the only other place that can mark an entity as
> > stopped, except for the proper place: drm_sched_entity_kill().
>=20
> That is potentially still good to have.

That's why we left it for now and just added a FIXME, because there's
not really any benefit in potentially blowing up drivers by removing it
(well, technically blowing up drivers like that would reveal
significant lifetime and, thus, design issues. But it wouldn't be
"nice").

Still, it's a clear sign of (undocumented=E2=80=A6) scheduler lifetimes bei=
ng
violated :(


P.

>=20
> Regards,
> Christian.
>=20
> >=20
> >=20
> > P.
> >=20
> > >=20
> > > Best,
> > > Jules
> > >=20
> >=20
>=20


