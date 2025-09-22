Return-Path: <stable+bounces-181408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E172B93455
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 22:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3DF1906A86
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 20:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D222765F8;
	Mon, 22 Sep 2025 20:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zdiv.net header.i=@zdiv.net header.b="sXj9+QLF"
X-Original-To: stable@vger.kernel.org
Received: from zdiv.net (zdiv.net [46.226.106.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA1925EF90
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 20:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.226.106.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758574254; cv=none; b=LPGQ0cNK8C48gjv2QBIXixmWwC8APxJL594jykBwL6RiqlLIoYNd4BwpJMgWFRATftwz49Ii3nJv71F8iAkAQcxeL2K4kWf3N0BtC22F73Usro+T+WEdTQv8a+U4HPmuJgNa9h77z7U61zdSD1PxtILxarxqHuC+SW3jnxkAx1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758574254; c=relaxed/simple;
	bh=Kp+FE/H8dAcPdUNts1p4U9gxLvxulpVgAPAqXJ0Sr1g=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=W1A52fqiH21cCQlMnSJ/dUgo/QmGwrr4vdb/JbzgebT5Grdz8tVPT+pl6U7Kn7gQWhppuNwpzcwEHW6CeJSD9RiUovJVXI5OM6D837ooqoN1Yefk6/zkDiKCHEkqEienTcuJyNvC/cLYub7ODcP/eWw1lTvip+t7Yva2Cf4GrIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zdiv.net; spf=pass smtp.mailfrom=zdiv.net; dkim=pass (2048-bit key) header.d=zdiv.net header.i=@zdiv.net header.b=sXj9+QLF; arc=none smtp.client-ip=46.226.106.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zdiv.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zdiv.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zdiv.net; s=24;
	t=1758574250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kp+FE/H8dAcPdUNts1p4U9gxLvxulpVgAPAqXJ0Sr1g=;
	b=sXj9+QLF9LGNP4vGC0PirY4IVKlNJJ7w+17rGeugOq+wUqZdOzIF2TTPNps2A6g1E1DXsW
	AwRv9eptAhLOhkkCOsggzSw6DLSqHrhMpZ9AvJ59RNp+DVRBUmX2aSezGl9aXaE6WdZRHW
	r2/ugZTJMTMq0yaeP7X8LBfMUBmfW2MocaYliNFIL7ZuHMmCQsVHujIWXj1X0SfZi0HsZi
	oz5JehWLl9V5XVOvcQgh3xf9ZIPD2y7oKJ5mmSiwlarXNHtNaVWErObOoode1tVIPWg3rl
	FWnaoPjA9voMtCwUsXSvQuUgvoJz3w2rM/CC28B839ZZHXbKkQkypWiAeSAa1g==
Received: from localhost (<unknown> [2a01:e0a:12:d860:b164:6edb:f87b:fdc6])
	by zdiv.net (OpenSMTPD) with ESMTPSA id 6cb7d465 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Sep 2025 22:50:50 +0200 (CEST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Sep 2025 22:50:50 +0200
Message-Id: <DCZMJLU7W6M0.23UOORGDH2DIR@zdiv.net>
To: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Philipp
 Stanner" <pstanner@redhat.com>, "Jules Maselbas" <jmaselbas@zdiv.net>,
 <stable@vger.kernel.org>
Cc: <gregkh@linuxfoundation.org>, "Tvrtko Ursulin"
 <tvrtko.ursulin@igalia.com>, "Alex Deucher" <alexander.deucher@amd.com>,
 "Luben Tuikov" <ltuikov89@gmail.com>, "Matthew Brost"
 <matthew.brost@intel.com>
Subject: Re: [PATCH 6.12.y 1/3] drm/sched: Optimise
 drm_sched_entity_push_job
From: "Jules Maselbas" <jmaselbas@zdiv.net>
X-Mailer: aerc 0.21.0
References: <20250922130948.5549-1-jmaselbas@zdiv.net>
 <8661bce085eed921feb3e718b8dc4c46784dff4d.camel@redhat.com>
 <57b2275c-d18a-418d-956f-2ed054ec555f@amd.com>
In-Reply-To: <57b2275c-d18a-418d-956f-2ed054ec555f@amd.com>

On Mon Sep 22, 2025 at 7:39 PM CEST, Christian K=C3=B6nig wrote:
> On 22.09.25 17:30, Philipp Stanner wrote:
>> On Mon, 2025-09-22 at 15:09 +0200, Jules Maselbas wrote:
>>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>
>>> commit d42a254633c773921884a19e8a1a0f53a31150c3 upstream.
>>>
>>> In FIFO mode (which is the default), both drm_sched_entity_push_job() a=
nd
>>> drm_sched_rq_update_fifo(), where the latter calls the former, are
>>> currently taking and releasing the same entity->rq_lock.
>>>
>>> We can avoid that design inelegance, and also have a miniscule
>>> efficiency improvement on the submit from idle path, by introducing a n=
ew
>>> drm_sched_rq_update_fifo_locked() helper and pulling up the lock taking=
 to
>>> its callers.
>>>
>>> v2:
>>> =C2=A0* Remove drm_sched_rq_update_fifo() altogether. (Christian)
>>>
>>> v3:
>>> =C2=A0* Improved commit message. (Philipp)
>>>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Luben Tuikov <ltuikov89@gmail.com>
>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>> Cc: Philipp Stanner <pstanner@redhat.com>
>>> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>>> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>>> Link: https://patchwork.freedesktop.org/patch/msgid/20241016122013.7857=
-2-tursulin@igalia.com
>>> (cherry picked from commit d42a254633c773921884a19e8a1a0f53a31150c3)
>>> Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
>>=20
>> Am I interpreting this mail correctly: you want to get this patch into
>> stable?
>>=20
>> Why? It doesn't fix a bug.
>
> Patch #3 in this series depends on the other two, but I agree that isn't =
a good idea.
Yes patch #3 fixes a freeze in amdgpu

> We should just adjust patch #3 to apply on the older kernel as well inste=
ad of backporting patches #1 and #2.
I initially modified patch #3 to use .rq_lock instead of .lock, but i didn'=
t felt very confident with this modification.
Should i sent a new version with a modified patch #3 ?
If so, how the change should be reflected in the commit message ?
(I initially ask #kernelnewbies but ended pulling the two other patches)

Best,
Jules


