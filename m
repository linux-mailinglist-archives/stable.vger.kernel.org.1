Return-Path: <stable+bounces-254530-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHw6KvjFFmrOqgcAu9opvQ
	(envelope-from <stable+bounces-254530-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 12:22:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5B15E2914
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 12:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EAF63076A54
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089303DDDB5;
	Wed, 27 May 2026 10:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z0W3FuWH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94833EF65E
	for <stable@vger.kernel.org>; Wed, 27 May 2026 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779876957; cv=none; b=s/b7sIx2U6agyzmSOQwczsbeSgA72mGkST/J0XsgOFuaqr4ClD8iARHLsmeitIQlCrKS/gj/I1w0N8tSY46ZDctUESP7WdOKpDT6I3GrNoNS7fmX8IJGX7BgVBr6OGcqZRlib0mxTXS4seVbYqpPK97vwxIF7PK0FYkEizfVuf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779876957; c=relaxed/simple;
	bh=ahcAi2jnsnoVjMBmJ24XNIWEMtmhBgwAE1w8uY3ihuo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oz13Wn4YR6B9d3jgRGw/DEF0EwdMuGYv4TWUePcMUKtqr2FavykDnO65yJpzyQn88ROg5KkQe0pFYM+PxuxMRcw2ed6oEu8DfSjyqBDhUGqnd/i3akUn4N2mwCrXyF6+A3RXOM+kBvPyuYCcaOaRwfbveDKuyVRJo5mXKVfZp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z0W3FuWH; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779876950; x=1811412950;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ahcAi2jnsnoVjMBmJ24XNIWEMtmhBgwAE1w8uY3ihuo=;
  b=Z0W3FuWH86VlNj9spPOyECJsiQHHbIBccoMSupXYHGNRjziF/D9YymsF
   WwqC4f5Hdm5o4MSV/rB291LwA+fwXSLU9UyuSjPWymLeINjEEpcSmx9kF
   sL5l/pZBd0y4OfJYWmgFMHdyaMVLcS3cY2cXnKlxtwNDZkK+E0GfMs8di
   ceoOMOGD+pn1Lu2H4T2gikWotNZy+eGDqjDgKQKucXqza6YHHkkxwETIM
   vxGGhNFds3NrfSlicsEbMykl9zWFzoLfppeGV/6uvjdjdecRIaFT0yhjt
   nyIAa2JscVKrbgXQ+eBXmU8xWLlL4KhEpcogMiI2i1BQzLKekU49Y+cFi
   A==;
X-CSE-ConnectionGUID: dsn93h3KTM2eUSjyDDc+7Q==
X-CSE-MsgGUID: uQIIoAoeQhWK+ozralISyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="92173416"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="92173416"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 03:15:45 -0700
X-CSE-ConnectionGUID: uC/WAzEpS5e40nxI447mtg==
X-CSE-MsgGUID: p5J6c0NYT6yXrwmzVhYpZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="239594844"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.245.17]) ([10.245.245.17])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 03:15:43 -0700
Message-ID: <0178d2f6358301e0bf1e5a4566c0eae35038df89.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/5] drm/xe/guc: Defer user exec queue scheduler
 start until after page table restore
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>, 
	stable@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>, Francois
 Dugast	 <francois.dugast@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Date: Wed, 27 May 2026 12:15:29 +0200
In-Reply-To: <d9c796f7-1dc5-4d0c-b121-69c042a3ae32@intel.com>
References: <20260525133051.91636-1-thomas.hellstrom@linux.intel.com>
	 <20260525133051.91636-2-thomas.hellstrom@linux.intel.com>
	 <d9c796f7-1dc5-4d0c-b121-69c042a3ae32@intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-254530-lists,stable=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 0E5B15E2914
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-05-26 at 16:27 +0100, Matthew Auld wrote:
> On 25/05/2026 14:30, Thomas Hellstr=C3=B6m wrote:
> > On S3/S4 and d3cold runtime PM resume, exec queue schedulers are
> > restarted before xe_bo_restore_late() has restored userspace VM
> > page
> > table BOs and LRC BOs. If a pending job is submitted in this
> > window,
> > GuC will attempt to load the context using stale or invalid data in
> > VRAM, leading to GuC exceptions.
> >=20
> > Defer user exec queue scheduler start until after page tables and
> > LRC
> > BOs are restored, ensuring no job can be submitted before the
> > backing
> > storage is valid. Migrate and kernel VM exec queues are still
> > started
> > immediately as they are required by the restore process itself.
> >=20
> > For GT reset, VRAM is not evicted and all BOs remain valid, so user
> > exec queue schedulers are started without deferral.
> >=20
> > This covers both LR and non-LR userspace exec queues.
> >=20
> > v3:
> > - Skip queues with a running scheduler in
> > xe_guc_submit_start_user_queues()
> > =C2=A0=C2=A0 to avoid a WARN_ON in drm_sched_for_each_pending_job() whe=
n a
> > new user
> > =C2=A0=C2=A0 exec queue is created in the window between
> > xe_guc_submit_start() and
> > =C2=A0=C2=A0 xe_guc_submit_start_user_queues(). (Intel CI)
> >=20
> > Fixes: 7f387e6012b6 ("drm/xe: add XE_BO_FLAG_PINNED_LATE_RESTORE")
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.16+
> > Assisted-by: GitHub_Copilot:claude-sonnet-4.6
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > =C2=A0 drivers/gpu/drm/xe/xe_gt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 16 +++++++++
> > =C2=A0 drivers/gpu/drm/xe/xe_gt.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 2 ++
> > =C2=A0 drivers/gpu/drm/xe/xe_guc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 13 ++++++++
> > =C2=A0 drivers/gpu/drm/xe/xe_guc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 1 +
> > =C2=A0 drivers/gpu/drm/xe/xe_guc_submit.c | 52
> > ++++++++++++++++++++++++++++++
> > =C2=A0 drivers/gpu/drm/xe/xe_guc_submit.h |=C2=A0 1 +
> > =C2=A0 drivers/gpu/drm/xe/xe_pm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 6 ++++
> > =C2=A0 drivers/gpu/drm/xe/xe_uc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 16 +++++++++
> > =C2=A0 drivers/gpu/drm/xe/xe_uc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 1 +
> > =C2=A0 9 files changed, 108 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/xe/xe_gt.c
> > b/drivers/gpu/drm/xe/xe_gt.c
> > index 783eb6d631b5..2c63e4d6a649 100644
> > --- a/drivers/gpu/drm/xe/xe_gt.c
> > +++ b/drivers/gpu/drm/xe/xe_gt.c
> > @@ -955,6 +955,8 @@ static void gt_reset_worker(struct work_struct
> > *w)
> > =C2=A0=C2=A0	if (err)
> > =C2=A0=C2=A0		goto err_out;
> > =C2=A0=20
> > +	xe_uc_start_user_queues(&gt->uc);
> > +
> > =C2=A0=C2=A0	xe_force_wake_put(gt_to_fw(gt), fw_ref);
> > =C2=A0=20
> > =C2=A0=C2=A0	/* Pair with get while enqueueing the work in
> > xe_gt_reset_async() */
> > @@ -967,6 +969,7 @@ static void gt_reset_worker(struct work_struct
> > *w)
> > =C2=A0 err_out:
> > =C2=A0=C2=A0	xe_force_wake_put(gt_to_fw(gt), fw_ref);
> > =C2=A0=C2=A0	XE_WARN_ON(xe_uc_start(&gt->uc));
> > +	xe_uc_start_user_queues(&gt->uc);
> > =C2=A0=20
> > =C2=A0 err_fail:
> > =C2=A0=C2=A0	xe_gt_err(gt, "reset failed (%pe)\n", ERR_PTR(err));
> > @@ -1050,6 +1053,19 @@ int xe_gt_sanitize_freq(struct xe_gt *gt)
> > =C2=A0=C2=A0	return ret;
> > =C2=A0 }
> > =C2=A0=20
> > +/**
> > + * xe_gt_start_user_queues() - Start user exec queues after page
> > table restore
> > + * @gt: the GT object
> > + *
> > + * Starts the DRM schedulers for all user exec queues on the GT.
> > This must be
> > + * called after xe_bo_restore_late() to ensure that userspace page
> > table BOs
> > + * are valid before any job submission triggers GuC context
> > registration.
> > + */
> > +void xe_gt_start_user_queues(struct xe_gt *gt)
> > +{
> > +	xe_uc_start_user_queues(&gt->uc);
> > +}
> > +
> > =C2=A0 int xe_gt_resume(struct xe_gt *gt)
> > =C2=A0 {
> > =C2=A0=C2=A0	int err;
> > diff --git a/drivers/gpu/drm/xe/xe_gt.h
> > b/drivers/gpu/drm/xe/xe_gt.h
> > index 4150aa594f05..b6ba05a317f7 100644
> > --- a/drivers/gpu/drm/xe/xe_gt.h
> > +++ b/drivers/gpu/drm/xe/xe_gt.h
> > @@ -170,4 +170,6 @@ static inline bool
> > xe_gt_supports_multi_queue(const struct xe_gt *gt,
> > =C2=A0=C2=A0	return gt->info.multi_queue_engine_class_mask &
> > BIT(class);
> > =C2=A0 }
> > =C2=A0=20
> > +void xe_gt_start_user_queues(struct xe_gt *gt);
> > +
> > =C2=A0 #endif
> > diff --git a/drivers/gpu/drm/xe/xe_guc.c
> > b/drivers/gpu/drm/xe/xe_guc.c
> > index 4023700ff2a9..0359909b8b27 100644
> > --- a/drivers/gpu/drm/xe/xe_guc.c
> > +++ b/drivers/gpu/drm/xe/xe_guc.c
> > @@ -1717,6 +1717,19 @@ int xe_guc_start(struct xe_guc *guc)
> > =C2=A0=C2=A0	return xe_guc_submit_start(guc);
> > =C2=A0 }
> > =C2=A0=20
> > +/**
> > + * xe_guc_start_user_queues() - Start user exec queue schedulers
> > on the GuC
> > + * @guc: the GuC object
> > + *
> > + * Starts the DRM schedulers for all user exec queues managed by
> > this GuC.
> > + * Must be called after xe_bo_restore_late() to ensure page tables
> > are valid
> > + * before any job submission triggers GuC context registration.
> > + */
> > +void xe_guc_start_user_queues(struct xe_guc *guc)
> > +{
> > +	xe_guc_submit_start_user_queues(guc);
> > +}
> > +
> > =C2=A0 /**
> > =C2=A0=C2=A0 * xe_guc_runtime_suspend() - GuC runtime suspend
> > =C2=A0=C2=A0 * @guc: The GuC object
> > diff --git a/drivers/gpu/drm/xe/xe_guc.h
> > b/drivers/gpu/drm/xe/xe_guc.h
> > index 02514914f404..ad2a6521852c 100644
> > --- a/drivers/gpu/drm/xe/xe_guc.h
> > +++ b/drivers/gpu/drm/xe/xe_guc.h
> > @@ -60,6 +60,7 @@ void xe_guc_reset_wait(struct xe_guc *guc);
> > =C2=A0 void xe_guc_stop_prepare(struct xe_guc *guc);
> > =C2=A0 void xe_guc_stop(struct xe_guc *guc);
> > =C2=A0 int xe_guc_start(struct xe_guc *guc);
> > +void xe_guc_start_user_queues(struct xe_guc *guc);
> > =C2=A0 void xe_guc_declare_wedged(struct xe_guc *guc);
> > =C2=A0 bool xe_guc_using_main_gamctrl_queues(struct xe_guc *guc);
> > =C2=A0=20
> > diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c
> > b/drivers/gpu/drm/xe/xe_guc_submit.c
> > index 4d32b430bc15..2b8b316c0ca3 100644
> > --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> > +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> > @@ -2535,6 +2535,16 @@ static void guc_exec_queue_start(struct
> > xe_exec_queue *q)
> > =C2=A0=C2=A0	xe_sched_submission_resume_tdr(sched);
> > =C2=A0 }
> > =C2=A0=20
> > +/*
> > + * Returns true for user exec queues whose page tables may not yet
> > be
> > + * restored when xe_guc_submit_start() is called during GT resume.
> > + * These queues must be started later, after xe_bo_restore_late().
> > + */
> > +static bool exec_queue_needs_late_start(const struct xe_exec_queue
> > *q)
> > +{
> > +	return !(q->flags & (EXEC_QUEUE_FLAG_MIGRATE |
> > EXEC_QUEUE_FLAG_VM));
>=20
> Just one question here. Do we want to include FLAG_VM in here? Those=20
> would be bind jobs, I think, but I'm not sure if we actually flush
> those=20
> on suspend? For migrate we do an idle wait on every migrate queue, so
> I=20
> would assume when we restart a migrate queue, it should be empty, but
> not sure if that is true for bind jobs on the bind queue(s)? Bind job
> will be touching paging structures also, which need to be restored=20
> first. Or is this somehow already handled?

I think the intention here is only MIGRATE jobs, so I'll respin this.

/Thomas


>=20
> > +}
> > +
> > =C2=A0 int xe_guc_submit_start(struct xe_guc *guc)
> > =C2=A0 {
> > =C2=A0=C2=A0	struct xe_exec_queue *q;
> > @@ -2549,6 +2559,10 @@ int xe_guc_submit_start(struct xe_guc *guc)
> > =C2=A0=C2=A0		if (q->guc->id !=3D index)
> > =C2=A0=C2=A0			continue;
> > =C2=A0=20
> > +		/* User queues are deferred until page tables are
> > restored */
> > +		if (exec_queue_needs_late_start(q))
> > +			continue;
> > +
> > =C2=A0=C2=A0		guc_exec_queue_start(q);
> > =C2=A0=C2=A0	}
> > =C2=A0=C2=A0	mutex_unlock(&guc->submission_state.lock);
> > @@ -2558,6 +2572,44 @@ int xe_guc_submit_start(struct xe_guc *guc)
> > =C2=A0=C2=A0	return 0;
> > =C2=A0 }
> > =C2=A0=20
> > +/**
> > + * xe_guc_submit_start_user_queues() - Start user exec queues
> > after late restore
> > + * @guc: the GuC object
> > + *
> > + * Starts the DRM schedulers for all user exec queues (those not
> > flagged as
> > + * migrate or VM queues). Must be called after
> > xe_bo_restore_late() to ensure
> > + * page tables are valid before any job submission is attempted.
> > + */
> > +void xe_guc_submit_start_user_queues(struct xe_guc *guc)
> > +{
> > +	struct xe_exec_queue *q;
> > +	unsigned long index;
> > +
> > +	if (!guc->submission_state.initialized)
> > +		return;
> > +
> > +	mutex_lock(&guc->submission_state.lock);
> > +	xa_for_each(&guc->submission_state.exec_queue_lookup,
> > index, q) {
> > +		/* Prevent redundant attempts to start parallel
> > queues */
> > +		if (q->guc->id !=3D index)
> > +			continue;
> > +
> > +		if (!exec_queue_needs_late_start(q))
> > +			continue;
> > +
> > +		/*
> > +		 * Skip queues whose scheduler is already running:
> > they were
> > +		 * created after xe_guc_submit_start() decremented
> > stopped to 0,
> > +		 * so they need no restart.
> > +		 */
> > +		if (!drm_sched_is_stopped(&q->guc->sched.base))
> > +			continue;
> > +
> > +		guc_exec_queue_start(q);
> > +	}
> > +	mutex_unlock(&guc->submission_state.lock);
> > +}
> > +
> > =C2=A0 static void guc_exec_queue_unpause_prepare(struct xe_guc *guc,
> > =C2=A0=C2=A0					=C2=A0=C2=A0 struct xe_exec_queue
> > *q)
> > =C2=A0 {
> > diff --git a/drivers/gpu/drm/xe/xe_guc_submit.h
> > b/drivers/gpu/drm/xe/xe_guc_submit.h
> > index b3839a90c142..b210b2f6cd2d 100644
> > --- a/drivers/gpu/drm/xe/xe_guc_submit.h
> > +++ b/drivers/gpu/drm/xe/xe_guc_submit.h
> > @@ -20,6 +20,7 @@ int xe_guc_submit_reset_prepare(struct xe_guc
> > *guc);
> > =C2=A0 void xe_guc_submit_reset_wait(struct xe_guc *guc);
> > =C2=A0 void xe_guc_submit_stop(struct xe_guc *guc);
> > =C2=A0 int xe_guc_submit_start(struct xe_guc *guc);
> > +void xe_guc_submit_start_user_queues(struct xe_guc *guc);
> > =C2=A0 void xe_guc_submit_pause(struct xe_guc *guc);
> > =C2=A0 void xe_guc_submit_pause_abort(struct xe_guc *guc);
> > =C2=A0 void xe_guc_submit_pause_vf(struct xe_guc *guc);
> > diff --git a/drivers/gpu/drm/xe/xe_pm.c
> > b/drivers/gpu/drm/xe/xe_pm.c
> > index d4672eb07476..c203a59d7000 100644
> > --- a/drivers/gpu/drm/xe/xe_pm.c
> > +++ b/drivers/gpu/drm/xe/xe_pm.c
> > @@ -282,6 +282,9 @@ int xe_pm_resume(struct xe_device *xe)
> > =C2=A0=C2=A0	if (err)
> > =C2=A0=C2=A0		goto err;
> > =C2=A0=20
> > +	for_each_gt(gt, xe, id)
> > +		xe_gt_start_user_queues(gt);
> > +
> > =C2=A0=C2=A0	xe_pxp_pm_resume(xe->pxp);
> > =C2=A0=20
> > =C2=A0=C2=A0	if (IS_VF_CCS_READY(xe))
> > @@ -696,6 +699,9 @@ int xe_pm_runtime_resume(struct xe_device *xe)
> > =C2=A0=C2=A0		err =3D xe_bo_restore_late(xe);
> > =C2=A0=C2=A0		if (err)
> > =C2=A0=C2=A0			goto out;
> > +
> > +		for_each_gt(gt, xe, id)
> > +			xe_gt_start_user_queues(gt);
> > =C2=A0=C2=A0	}
> > =C2=A0=20
> > =C2=A0=C2=A0	xe_pxp_pm_resume(xe->pxp);
> > diff --git a/drivers/gpu/drm/xe/xe_uc.c
> > b/drivers/gpu/drm/xe/xe_uc.c
> > index 75091bde0d50..12606133f5bc 100644
> > --- a/drivers/gpu/drm/xe/xe_uc.c
> > +++ b/drivers/gpu/drm/xe/xe_uc.c
> > @@ -263,6 +263,22 @@ int xe_uc_start(struct xe_uc *uc)
> > =C2=A0=C2=A0	return xe_guc_start(&uc->guc);
> > =C2=A0 }
> > =C2=A0=20
> > +/**
> > + * xe_uc_start_user_queues() - Start user exec queues after late
> > restore
> > + * @uc: the UC object
> > + *
> > + * Starts the DRM schedulers for all user exec queues. Must be
> > called after
> > + * xe_bo_restore_late() to ensure page tables are valid before any
> > job
> > + * submission is attempted. Has no effect if GuC submission is not
> > enabled.
> > + */
> > +void xe_uc_start_user_queues(struct xe_uc *uc)
> > +{
> > +	if (!xe_device_uc_enabled(uc_to_xe(uc)))
> > +		return;
> > +
> > +	xe_guc_start_user_queues(&uc->guc);
> > +}
> > +
> > =C2=A0 static void uc_reset_wait(struct xe_uc *uc)
> > =C2=A0 {
> > =C2=A0=C2=A0	int ret;
> > diff --git a/drivers/gpu/drm/xe/xe_uc.h
> > b/drivers/gpu/drm/xe/xe_uc.h
> > index 255a54a8f876..2fd056cfa1d0 100644
> > --- a/drivers/gpu/drm/xe/xe_uc.h
> > +++ b/drivers/gpu/drm/xe/xe_uc.h
> > @@ -18,6 +18,7 @@ void xe_uc_runtime_suspend(struct xe_uc *uc);
> > =C2=A0 void xe_uc_stop_prepare(struct xe_uc *uc);
> > =C2=A0 void xe_uc_stop(struct xe_uc *uc);
> > =C2=A0 int xe_uc_start(struct xe_uc *uc);
> > +void xe_uc_start_user_queues(struct xe_uc *uc);
> > =C2=A0 void xe_uc_suspend_prepare(struct xe_uc *uc);
> > =C2=A0 int xe_uc_suspend(struct xe_uc *uc);
> > =C2=A0 int xe_uc_sanitize_reset(struct xe_uc *uc);

