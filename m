Return-Path: <stable+bounces-95416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A899D89DD
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 17:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05DF6B2AE05
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 15:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB30194AC7;
	Mon, 25 Nov 2024 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJ9LljWI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92C8291E;
	Mon, 25 Nov 2024 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732549949; cv=none; b=aBEbZBnf1bMT77Vk5cAqZ+ehaWedTi0HcJmXgHMT+a9cRy+IplOOBv8+tBCdgTEZsVwFGPU5VIEDwm4qaWS8mSceDAJ/LiRXVqXpZcAKXTHPlKx9aGQFVElEwhgRyaic0zVy5jFCgYw+Md6nmOtUxHUblIvcVUV1QiqHG1AR090=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732549949; c=relaxed/simple;
	bh=/WoWitydF92Rc+lpLKLEnfGTJhdbwccFT6fc/tQiuR8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YQbvbHo3BfwpH0C15NDkTMz0oCfqpHRLKjChtq5SKg2O037hgkzt2SxBNZ6OALXYg8ENbSAs/s4JEfC39CJ5q6Oc6ZRtX56zR03d49/QTnbBw1QTDQz1bFe5XELZz91vd+FS5xI6p4lnVGlO1nYL7ZpPf9eW80PH+25PS9twrAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJ9LljWI; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732549948; x=1764085948;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=/WoWitydF92Rc+lpLKLEnfGTJhdbwccFT6fc/tQiuR8=;
  b=QJ9LljWIlwsJ7CLgbofar/cGCG9GWGnmKwC0qst7rQKnTR98pZUy9EKF
   mRWLv8GfwkVQJiL6VDnpCuEsnbMn1b26d+76DmeuXKiA5CDwlrpPi5N+n
   DKfD50CY+b47ZUznERYgh9thJmKrPmWyM1jxm3qb08/GJKTlZFq8HOfJ2
   p/Dh51u7xwAxaGA7gBabzMKX61LkSU2Au+LhZw/buykXhsoQupekXToQ7
   LzxeL7r9+RK2LkTkKcoc0asJVXA1Gy+4mfNu6GQWLq2uevjor+lq3ErPG
   o/2GMjNHT+OpjnIRbY4QTSkr/Ai8tDrR1F9RyXxV9Wd2m4SjQuyqbxNHR
   g==;
X-CSE-ConnectionGUID: U4ce8JX9S3WWyA2U1e1KAw==
X-CSE-MsgGUID: P3+HQHUnSHKp9OerB9Q/gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="50074722"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="50074722"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 07:52:27 -0800
X-CSE-ConnectionGUID: s8lpRx83TFCuCQxoW28YAQ==
X-CSE-MsgGUID: y58xV3DNR5e0x6ompTZ9DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="96213492"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO [10.245.246.22]) ([10.245.246.22])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 07:52:25 -0800
Message-ID: <0566a0ab18448a9206a92defb695dd2e5d9bd77c.camel@linux.intel.com>
Subject: Re: [PATCH AUTOSEL 6.6 3/4] locking/ww_mutex: Adjust to lockdep
 nest_lock requirements
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, will@kernel.org
Date: Mon, 25 Nov 2024 16:52:22 +0100
In-Reply-To: <20241124124702.3338309-3-sashal@kernel.org>
References: <20241124124702.3338309-1-sashal@kernel.org>
	 <20241124124702.3338309-3-sashal@kernel.org>
Autocrypt: addr=thomas.hellstrom@linux.intel.com; prefer-encrypt=mutual;
 keydata=mDMEZaWU6xYJKwYBBAHaRw8BAQdAj/We1UBCIrAm9H5t5Z7+elYJowdlhiYE8zUXgxcFz360SFRob21hcyBIZWxsc3Ryw7ZtIChJbnRlbCBMaW51eCBlbWFpbCkgPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPoiTBBMWCgA7FiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQuBaTVQrGBr/yQAD/Z1B+Kzy2JTuIy9LsKfC9FJmt1K/4qgaVeZMIKCAxf2UBAJhmZ5jmkDIf6YghfINZlYq6ixyWnOkWMuSLmELwOsgPuDgEZaWU6xIKKwYBBAGXVQEFAQEHQF9v/LNGegctctMWGHvmV/6oKOWWf/vd4MeqoSYTxVBTAwEIB4h4BBgWCgAgFiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwwACgkQuBaTVQrGBr/P2QD9Gts6Ee91w3SzOelNjsus/DcCTBb3fRugJoqcfxjKU0gBAKIFVMvVUGbhlEi6EFTZmBZ0QIZEIzOOVfkaIgWelFEH
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-3.fc39) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-11-24 at 07:46 -0500, Sasha Levin wrote:
> From: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
>=20
> [ Upstream commit 823a566221a5639f6c69424897218e5d6431a970 ]
>=20
> When using mutex_acquire_nest() with a nest_lock, lockdep refcounts
> the
> number of acquired lockdep_maps of mutexes of the same class, and
> also
> keeps a pointer to the first acquired lockdep_map of a class. That
> pointer
> is then used for various comparison-, printing- and checking
> purposes,
> but there is no mechanism to actively ensure that lockdep_map stays
> in
> memory. Instead, a warning is printed if the lockdep_map is freed and
> there are still held locks of the same lock class, even if the
> lockdep_map
> itself has been released.
>=20
> In the context of WW/WD transactions that means that if a user
> unlocks
> and frees a ww_mutex from within an ongoing ww transaction, and that
> mutex happens to be the first ww_mutex grabbed in the transaction,
> such a warning is printed and there might be a risk of a UAF.
>=20
> Note that this is only problem when lockdep is enabled and affects
> only
> dereferences of struct lockdep_map.
>=20
> Adjust to this by adding a fake lockdep_map to the acquired context
> and
> make sure it is the first acquired lockdep map of the associated
> ww_mutex class. Then hold it for the duration of the WW/WD
> transaction.
>=20
> This has the side effect that trying to lock a ww mutex *without* a
> ww_acquire_context but where a such context has been acquire, we'd
> see
> a lockdep splat. The test-ww_mutex.c selftest attempts to do that, so
> modify that particular test to not acquire a ww_acquire_context if it
> is not going to be used.
>=20
> Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link:
> https://lkml.kernel.org/r/20241009092031.6356-1-thomas.hellstrom@linux.in=
tel.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>

The commit introduces regressions and should not be backported, please
see the corresponding patch for 6.12 for a discussion.

Thanks,
Thomas




> ---
> =C2=A0include/linux/ww_mutex.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 +=
+++++++++++++
> =C2=A0kernel/locking/test-ww_mutex.c |=C2=A0 8 +++++---
> =C2=A02 files changed, 19 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
> index bb763085479af..a401a2f31a775 100644
> --- a/include/linux/ww_mutex.h
> +++ b/include/linux/ww_mutex.h
> @@ -65,6 +65,16 @@ struct ww_acquire_ctx {
> =C2=A0#endif
> =C2=A0#ifdef CONFIG_DEBUG_LOCK_ALLOC
> =C2=A0	struct lockdep_map dep_map;
> +	/**
> +	 * @first_lock_dep_map: fake lockdep_map for first locked
> ww_mutex.
> +	 *
> +	 * lockdep requires the lockdep_map for the first locked
> ww_mutex
> +	 * in a ww transaction to remain in memory until all
> ww_mutexes of
> +	 * the transaction have been unlocked. Ensure this by
> keeping a
> +	 * fake locked ww_mutex lockdep map between
> ww_acquire_init() and
> +	 * ww_acquire_fini().
> +	 */
> +	struct lockdep_map first_lock_dep_map;
> =C2=A0#endif
> =C2=A0#ifdef CONFIG_DEBUG_WW_MUTEX_SLOWPATH
> =C2=A0	unsigned int deadlock_inject_interval;
> @@ -146,7 +156,10 @@ static inline void ww_acquire_init(struct
> ww_acquire_ctx *ctx,
> =C2=A0	debug_check_no_locks_freed((void *)ctx, sizeof(*ctx));
> =C2=A0	lockdep_init_map(&ctx->dep_map, ww_class->acquire_name,
> =C2=A0			 &ww_class->acquire_key, 0);
> +	lockdep_init_map(&ctx->first_lock_dep_map, ww_class-
> >mutex_name,
> +			 &ww_class->mutex_key, 0);
> =C2=A0	mutex_acquire(&ctx->dep_map, 0, 0, _RET_IP_);
> +	mutex_acquire_nest(&ctx->first_lock_dep_map, 0, 0, &ctx-
> >dep_map, _RET_IP_);
> =C2=A0#endif
> =C2=A0#ifdef CONFIG_DEBUG_WW_MUTEX_SLOWPATH
> =C2=A0	ctx->deadlock_inject_interval =3D 1;
> @@ -185,6 +198,7 @@ static inline void ww_acquire_done(struct
> ww_acquire_ctx *ctx)
> =C2=A0static inline void ww_acquire_fini(struct ww_acquire_ctx *ctx)
> =C2=A0{
> =C2=A0#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	mutex_release(&ctx->first_lock_dep_map, _THIS_IP_);
> =C2=A0	mutex_release(&ctx->dep_map, _THIS_IP_);
> =C2=A0#endif
> =C2=A0#ifdef DEBUG_WW_MUTEXES
> diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-
> ww_mutex.c
> index 7c5a8f05497f2..02b84288865ca 100644
> --- a/kernel/locking/test-ww_mutex.c
> +++ b/kernel/locking/test-ww_mutex.c
> @@ -62,7 +62,8 @@ static int __test_mutex(unsigned int flags)
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	ww_mutex_init(&mtx.mutex, &ww_class);
> -	ww_acquire_init(&ctx, &ww_class);
> +	if (flags & TEST_MTX_CTX)
> +		ww_acquire_init(&ctx, &ww_class);
> =C2=A0
> =C2=A0	INIT_WORK_ONSTACK(&mtx.work, test_mutex_work);
> =C2=A0	init_completion(&mtx.ready);
> @@ -90,7 +91,8 @@ static int __test_mutex(unsigned int flags)
> =C2=A0		ret =3D wait_for_completion_timeout(&mtx.done,
> TIMEOUT);
> =C2=A0	}
> =C2=A0	ww_mutex_unlock(&mtx.mutex);
> -	ww_acquire_fini(&ctx);
> +	if (flags & TEST_MTX_CTX)
> +		ww_acquire_fini(&ctx);
> =C2=A0
> =C2=A0	if (ret) {
> =C2=A0		pr_err("%s(flags=3D%x): mutual exclusion failure\n",
> @@ -663,7 +665,7 @@ static int __init test_ww_mutex_init(void)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D stress(2047, hweight32(STRESS_ALL)*ncpus, STRESS_ALL);
> +	ret =3D stress(2046, hweight32(STRESS_ALL)*ncpus, STRESS_ALL);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0


