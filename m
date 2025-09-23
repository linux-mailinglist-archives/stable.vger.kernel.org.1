Return-Path: <stable+bounces-181473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0924EB95C6D
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 14:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91FFC3A3F0F
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 12:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF65D32276C;
	Tue, 23 Sep 2025 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duGT4IRH"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A1925A63D
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 12:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758629305; cv=none; b=BTCLd+w3xom+JOVv6dN8pyMa+c0cuz2yJUJ2pPNrDsuDCfV5IlyX1582WR2uZ1BTH5LMAau5LOK/cJPwQ+JB70Wb/PYF35DA86J5BDycOJohwId9hyyGG46oU5fVWvqXLIFc+DDhVA04UPvragEHSWn5E55MdPPjQbNkoYZYTLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758629305; c=relaxed/simple;
	bh=Om/+j6xNpRGsJ7it7mqRm8Qw3ar3DnEtYi8oPfJ+lok=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YjjsZSIaYQK1e4Ci+uBGsD1LUmNRUoTO+Cu918/HV3wZZuSEdz4aXtBTyQ05X1VuOWgdCOiMHtGQBTRpMfpPx4TSoyIGYzdAD7oCdZDxjQj9RkJUVqaCBORrcF8pEzC4Xw+BFJmUSTDgNu7/EX9Tmjb1oBFLnkyi4NLvBcOx4q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=duGT4IRH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758629302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OLAbPeahRdmcHMuQEsUJH3PPKN63kwbA2+e7vP9hQ0c=;
	b=duGT4IRH90AMhJRNvQ0+SEoOHRfbNm1wsG9w/9Ulp4EAyRTmVKC6zJCSCKQ8BGzmDIiZxR
	aPLmWg6l7cD888aU20PVj0dMEwYs30I1IAV8rcg8qCx3fGWVAURNblmRVJZcf4ytgw3G3Q
	FJFG6blx5Dbj6nzjsW5l+eRgbEP8Qh0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-D3t6wc9BMeuCzV8qxKXAwA-1; Tue, 23 Sep 2025 08:08:21 -0400
X-MC-Unique: D3t6wc9BMeuCzV8qxKXAwA-1
X-Mimecast-MFC-AGG-ID: D3t6wc9BMeuCzV8qxKXAwA_1758629300
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e19ee1094so17622025e9.0
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 05:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758629300; x=1759234100;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OLAbPeahRdmcHMuQEsUJH3PPKN63kwbA2+e7vP9hQ0c=;
        b=YM9vrNCrauPbqqbl+dx/CCyaERrw0FeCipNkaR3eEN9vIZkpfirmqiHLFsLxlLWW/H
         A99cBx6EVY1IL8kLCoc1+zKY728RoHI0ycOQSjDw9FMejC4LXF1lFmJoM59uppId1NjS
         v0u2QGgLjYSd5gRBYUbiuFFrqMOyimQrB0KH8Vy17Wbo/3MDS0g5LYHDlks5j/XXylG6
         G4+UUB9ix70yxbU66GSbhTyPiSuQfYwI9uOdEgm+vu/e4SPDTTv+leqzynbAQxqbJTja
         byF5hCQOkjyvZRkB6vJWNYvLtaX/SAMa2przePqyJ/W3Fod307A24v5I2/D2VL2JK6hK
         kLvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQexQxQcmhIUD59bCV/OI9R7WLHqDg/zj1ASDDrFROrYKOue2BIqlfoGhmGFBfb/iV2783FSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YylpyD3KxJLPke16Nk+tZLI8uMNF4lHAre8fIgKsyCNT4uILWTF
	Tj8BzPY48K6ogUBYY6k4lxpqoFgj3VgagT/JICHaOEtGrU3Kc3rDr+hbYmGMK/NRFr2uL23mi9C
	c9abxJwAkyFxcOYtD6IFd4v4ybVYCXYjKTUQ0SFwPQzAqh6EEe1n4Wmdwcw==
X-Gm-Gg: ASbGncvbSYx+QsKhl9XVTf54SUTzf6683qaGHItjyu97wbXLww8SoXsEdQLdve3PsaC
	A7sIUxmbRiaMV1lQ5EObJBcc7Rle9bSIT553NF4iQPKoQckx+8DUTxuQLW5iKh9XCkw/KVSvxi4
	XrQg9fjJbxLPpUnm806meAQQg7ceAl+u4DZOvIJoi3Lf79pZY0zmFcKytJ11VzEXzVx/mOmSzJ9
	c65ead1+UNh8zVLZ7lhJwFlP1INKfVfQL8nRePpYCRcONAOtcgCU/2ic7v95wjP5Mv08QlOCkn7
	XgosLJnoYtjTJnWsCk8mKNG1UVk2uJ3rFhC5XJWEBLxmEh/C45ajx96TlA+0UV16CVNtwATyMYK
	icpZWXLRuXSY=
X-Received: by 2002:a05:600c:a47:b0:45d:da25:595d with SMTP id 5b1f17b1804b1-46e1dab5fbcmr20260575e9.22.1758629300076;
        Tue, 23 Sep 2025 05:08:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhF92I4cAXFhdSy8WXRMehe0WrBXDHvkxCUN7naEQv27eL9GTM6HZI23J1v20HXqj724LpVg==
X-Received: by 2002:a05:600c:a47:b0:45d:da25:595d with SMTP id 5b1f17b1804b1-46e1dab5fbcmr20260295e9.22.1758629299665;
        Tue, 23 Sep 2025 05:08:19 -0700 (PDT)
Received: from ?IPv6:2001:16b8:3dcc:c800:4ce1:1543:83d3:837? ([2001:16b8:3dcc:c800:4ce1:1543:83d3:837])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613d33633bsm287992245e9.11.2025.09.23.05.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 05:08:19 -0700 (PDT)
Message-ID: <b49f45057de59f977d9e50a4aac12bac2e8d12a0.camel@redhat.com>
Subject: Re: [PATCH 6.12.y 1/3] drm/sched: Optimise drm_sched_entity_push_job
From: Philipp Stanner <pstanner@redhat.com>
To: Jules Maselbas <jmaselbas@zdiv.net>, Christian =?ISO-8859-1?Q?K=F6nig?=
	 <christian.koenig@amd.com>, stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Luben Tuikov
 <ltuikov89@gmail.com>, Matthew Brost <matthew.brost@intel.com>
Date: Tue, 23 Sep 2025 14:08:18 +0200
In-Reply-To: <DCZMJLU7W6M0.23UOORGDH2DIR@zdiv.net>
References: <20250922130948.5549-1-jmaselbas@zdiv.net>
	 <8661bce085eed921feb3e718b8dc4c46784dff4d.camel@redhat.com>
	 <57b2275c-d18a-418d-956f-2ed054ec555f@amd.com>
	 <DCZMJLU7W6M0.23UOORGDH2DIR@zdiv.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-22 at 22:50 +0200, Jules Maselbas wrote:
> On Mon Sep 22, 2025 at 7:39 PM CEST, Christian K=C3=B6nig wrote:
> > On 22.09.25 17:30, Philipp Stanner wrote:
> > > On Mon, 2025-09-22 at 15:09 +0200, Jules Maselbas wrote:
> > > > From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > >=20
> > > > commit d42a254633c773921884a19e8a1a0f53a31150c3 upstream.
> > > >=20
> > > > In FIFO mode (which is the default), both drm_sched_entity_push_job=
() and
> > > > drm_sched_rq_update_fifo(), where the latter calls the former, are
> > > > currently taking and releasing the same entity->rq_lock.
> > > >=20
> > > > We can avoid that design inelegance, and also have a miniscule
> > > > efficiency improvement on the submit from idle path, by introducing=
 a new
> > > > drm_sched_rq_update_fifo_locked() helper and pulling up the lock ta=
king to
> > > > its callers.
> > > >=20
> > > > v2:
> > > > =C2=A0* Remove drm_sched_rq_update_fifo() altogether. (Christian)
> > > >=20
> > > > v3:
> > > > =C2=A0* Improved commit message. (Philipp)
> > > >=20
> > > > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > Cc: Luben Tuikov <ltuikov89@gmail.com>
> > > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > > Cc: Philipp Stanner <pstanner@redhat.com>
> > > > Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > > > Link: https://patchwork.freedesktop.org/patch/msgid/20241016122013.=
7857-2-tursulin@igalia.com
> > > > (cherry picked from commit d42a254633c773921884a19e8a1a0f53a31150c3=
)
> > > > Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
> > >=20
> > > Am I interpreting this mail correctly: you want to get this patch int=
o
> > > stable?
> > >=20
> > > Why? It doesn't fix a bug.
> >=20
> > Patch #3 in this series depends on the other two, but I agree that isn'=
t a good idea.
> Yes patch #3 fixes a freeze in amdgpu
>=20
> > We should just adjust patch #3 to apply on the older kernel as well ins=
tead of backporting patches #1 and #2.
> I initially modified patch #3 to use .rq_lock instead of .lock, but i did=
n't felt very confident with this modification.
> Should i sent a new version with a modified patch #3 ?
> If so, how the change should be reflected in the commit message ?
> (I initially ask #kernelnewbies but ended pulling the two other patches)

You know folks, situations like that are why we want to strongly
discourage accessing another API's struct members directly. There is no
API contract for them.

And a proper API function rarely changes its interface, and if it does,
it's easy to find for the contributor where drivers need to be
adjusted. If we were all following that rule, you wouldn't even have to
bother with patches #1 and #2.

That said, I see two proper solutions for your problem:

   A. amdgpu is the one stopping the entities anyways, isn't it? It
      knows which entities it has killed. So that information could be
      stored in struct amdgpu_vm.
   B. Add an API: drm_sched_entity_is_stopped(). There's also
      drm_sched_entity_is_idle(), but I guess that won't serve your
      purpose?


And btw, as we're at it:
@Christian: Danilo and I recently asked about whether entities can
still outlive their scheduler in amdgpu?
That seems to be the reason why that race-"fix" in drm_sched_fini() was
added, which is the only other place that can mark an entity as
stopped, except for the proper place: drm_sched_entity_kill().


P.

>=20
> Best,
> Jules
>=20


