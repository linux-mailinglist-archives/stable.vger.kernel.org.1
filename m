Return-Path: <stable+bounces-181598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AB5B99840
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 13:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213DC19C2DFB
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 11:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7792E3376;
	Wed, 24 Sep 2025 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjXsO7uF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D78226E6E4
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758711617; cv=none; b=paykp6nHPvDwh7YG0OGSAJyoD5jBMmqa3EEXpbtXSFGayJ1Juk76pAtEDiZ1TJMQCz143PyyeiXVPhnwlDOYCylNJJuHuUyC082+dkl9eYs2TXjW+b9vMfNNB3VbRCLnc/ehUKINAwhUwyQ9rFGGGTHAS4fJyEE1XopFakF0CBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758711617; c=relaxed/simple;
	bh=PLxNIxm4nnFqvF9R5flN5cuSrvAujprcSgu1R4cCFHs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=PEqV9mQy6YH2n4Ng59Au2h9jFY4iuMXYWciX3Gds4R/6ez3Uk/Jix2OwnDUoZsYpTa5z6lYgffO6CLHFJQY1eBJ687Z9qGx15N7DRhLeSnx9NC4sVp5vqNg5ZYD7GuDAG00a7G7uCC8+tRkc9K5ZzdrDY3a+JXd6x5GMGVJbOJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjXsO7uF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5122DC4CEE7;
	Wed, 24 Sep 2025 11:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758711616;
	bh=PLxNIxm4nnFqvF9R5flN5cuSrvAujprcSgu1R4cCFHs=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=DjXsO7uFaLxhxztyX6w+3JEBJijm3UmPV62s1n4Aw/ArAWp3k4Vr4tvtzLrWQdtT8
	 owspY6gAQ17pJKLPtXCDO8pEVv00RrSlU3t/SkPmX8R7ZQZOCUbrHbJ965ZpcMLSMt
	 iWD3HVCxPaA8VgYCltKanqq+azO//2ERHHSGjO6e+YnaJId0z0HV9N4xIfVTNx9vB8
	 ksC577bCW3xhF1UH1bCrGbMo0RHQiaRGx+QNo5/lpR/n3Q5vukOBOt0BJiww5m77hI
	 Fy1lVVgRq5IpOUFRBBfHqULEAI0Yln83s956qWiqZzstdE8TqMXiHmgQG7LStyI0KE
	 aVP86a8cOspiA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Sep 2025 13:00:12 +0200
Message-Id: <DD0Z8GX3Z56G.3VLLBSJUG05WK@kernel.org>
Subject: Re: [PATCH 6.12.y 1/3] drm/sched: Optimise
 drm_sched_entity_push_job
Cc: "Philipp Stanner" <pstanner@redhat.com>, "Jules Maselbas"
 <jmaselbas@zdiv.net>, <stable@vger.kernel.org>,
 <gregkh@linuxfoundation.org>, "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>,
 "Alex Deucher" <alexander.deucher@amd.com>, "Luben Tuikov"
 <ltuikov89@gmail.com>, "Matthew Brost" <matthew.brost@intel.com>
To: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250922130948.5549-1-jmaselbas@zdiv.net>
 <8661bce085eed921feb3e718b8dc4c46784dff4d.camel@redhat.com>
 <57b2275c-d18a-418d-956f-2ed054ec555f@amd.com>
 <DCZMJLU7W6M0.23UOORGDH2DIR@zdiv.net>
 <b49f45057de59f977d9e50a4aac12bac2e8d12a0.camel@redhat.com>
 <76c94ee6-ba28-4517-8b6c-35658ac95d3b@amd.com>
In-Reply-To: <76c94ee6-ba28-4517-8b6c-35658ac95d3b@amd.com>

On Tue Sep 23, 2025 at 2:33 PM CEST, Christian K=C3=B6nig wrote:
> On 23.09.25 14:08, Philipp Stanner wrote:
>> You know folks, situations like that are why we want to strongly
>> discourage accessing another API's struct members directly. There is no
>> API contract for them.

Indeed, please don't peek API internals. If you need additional functionali=
ty,
please send a patch adding a supported API for the component instead.

Drivers messing with component internals makes impossible to maintain them =
in
the long term.

>> And a proper API function rarely changes its interface, and if it does,
>> it's easy to find for the contributor where drivers need to be
>> adjusted. If we were all following that rule, you wouldn't even have to
>> bother with patches #1 and #2.
>>=20
>> That said, I see two proper solutions for your problem:
>>=20
>>    A. amdgpu is the one stopping the entities anyways, isn't it? It
>>       knows which entities it has killed. So that information could be
>>       stored in struct amdgpu_vm.
>
> No, it's the scheduler which decides when entities are stopped.

Can you please show me the code where the scheduler calls any of
drm_sched_entity_fini(), drm_sched_entity_flush(), drm_sched_entity_destroy=
()?

Or are you referring the broken hack in drm_sched_fini() (introduced by com=
mit
c61cdbdbffc1 ("drm/scheduler: Fix hang when sched_entity released")) where =
it is
just ignored that we need to take the entity lock as well, because it
inconviniently would lead to lock inversion?

	spin_lock(&rq->lock);
	list_for_each_entry(s_entity, &rq->entities, list)
	        /*
	         * Prevents reinsertion and marks job_queue as idle,
	         * it will be removed from the rq in drm_sched_entity_fini()
	         * eventually
	         */
	        s_entity->stopped =3D true;
	spin_unlock(&rq->lock);

The patch description that introduced the hack says:

	If scheduler is already stopped by the time sched_entity
	is released and entity's job_queue not empty I encountred
	a hang in drm_sched_entity_flush.

But this sounds to me as if amdgpu simply doesn't implement the correct shu=
tdown
ordering. Why do nouveau, Xe and other drivers don't have this problem? Why=
 do
we need to solve it in the scheduler instead?

Maybe there are reasonable answers to that. And assuming there are, it stil=
l
isn't a justification for building on top of a broken workaround. :(

