Return-Path: <stable+bounces-126858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778A3A73298
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 13:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1CA3B63E4
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 12:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E6438FA6;
	Thu, 27 Mar 2025 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m71q7kSX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4539F2F2A
	for <stable@vger.kernel.org>; Thu, 27 Mar 2025 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743079850; cv=none; b=IcP443SrepvLx7d09L+zYjFHxjDyEBsoYLitRX5qpEnT/r7+YDM8NFu5Ulfn1yxkN4s6vD/V/d8qecHH/sVzgiKpgHPAOL3Dudr0dzU2/hw33GHJd31irfwBFG/U6gYmH0rBjS7A6E9XVttFAjJt1EE7O2sb6WyYwBqIQngebVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743079850; c=relaxed/simple;
	bh=ADizISV61R67N+/speR0GVdxFoBHzsujpuBdr10/NNE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZNgtXQG08DroskZibLzSLXVxEaCQAANUQJgn8i9OtXtHU/TkqpmdKeouwSIT1pR3CMnJegkQy6kwc1IvHQ7jx8/RaGoXnkIrZ0NyHLC4rUFsDNYwLLo1T8W3k2MNN02n7O9o6ShaJvGhwT9lHle9Zbl9cnhmKpSdkEGM2WSM+l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m71q7kSX; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743079848; x=1774615848;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ADizISV61R67N+/speR0GVdxFoBHzsujpuBdr10/NNE=;
  b=m71q7kSXFS6o811x106KqWTCb635sGg/0l3tnP+W1aZHMqqCpGZnuHVw
   szkRC08Vjb4MK4XFxQ74a0ksfDdGCOXEvOQFwZ/nx07rqB8MAClmyVloW
   LLvoB1lhvJLWnjHUR+LO/B8ZqJ9lT2KjULThQZskfzRMQdj6gnxRBeLYo
   2Z9QeCx/mF2E75pkfXYWdlfUQ1nfX0VLqe+K02hEwO74Su6i5tAxnBQbw
   Wy6pRz+YlXm8qGU34FFCxN8kjZvcM/XTA9DEmcMPAX/z+GFWzDfjTNz0Z
   WsO+lBErM8v2elrMadou5usCiotxyIIAUGbRYuikdtQ3D+fkce5jfC0hy
   w==;
X-CSE-ConnectionGUID: FOpSugyVTAGcoD9+1Lq+mQ==
X-CSE-MsgGUID: tRrKpcwvQdS7G/kkGAKrKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="54610351"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="54610351"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 05:50:47 -0700
X-CSE-ConnectionGUID: tHUU/RJpTYu5XdvR1aSBzg==
X-CSE-MsgGUID: fKvI69N1QmW0GiUFwhJtCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="162365263"
Received: from carterle-desk.ger.corp.intel.com (HELO [10.245.246.40]) ([10.245.246.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 05:50:46 -0700
Message-ID: <0634c06e557f29fadca38883654720aeb1b989ed.camel@linux.intel.com>
Subject: Re: [PATCH v2] drm/xe: Fix an out-of-bounds shift when invalidating
 TLB
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org, Lucas De Marchi
 <lucas.demarchi@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>, Rodrigo Vivi
	 <rodrigo.vivi@intel.com>, stable@vger.kernel.org, Lucas De Marchi
	 <lucas.demarchi@intel.com>
Date: Thu, 27 Mar 2025 13:50:43 +0100
In-Reply-To: <20250326151634.36916-1-thomas.hellstrom@linux.intel.com>
References: <20250326151634.36916-1-thomas.hellstrom@linux.intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi, Lucas,

On Wed, 2025-03-26 at 16:16 +0100, Thomas Hellstr=C3=B6m wrote:
> When the size of the range invalidated is larger than
> rounddown_pow_of_two(ULONG_MAX),
> The function macro roundup_pow_of_two(length) will hit an out-of-
> bounds
> shift [1].
>=20
> Use a full TLB invalidation for such cases.
> v2:
> - Use a define for the range size limit over which we use a full
> =C2=A0 TLB invalidation. (Lucas)
> - Use a better calculation of the limit.

Does your R-B hold also for v2?

Thanks,
Thomas


>=20
> [1]:
> [=C2=A0=C2=A0 39.202421] ------------[ cut here ]------------
> [=C2=A0=C2=A0 39.202657] UBSAN: shift-out-of-bounds in
> ./include/linux/log2.h:57:13
> [=C2=A0=C2=A0 39.202673] shift exponent 64 is too large for 64-bit type '=
long
> unsigned int'
> [=C2=A0=C2=A0 39.202688] CPU: 8 UID: 0 PID: 3129 Comm: xe_exec_system_ Ta=
inted:
> G=C2=A0=C2=A0=C2=A0=C2=A0 U=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.14.0+ #10
> [=C2=A0=C2=A0 39.202690] Tainted: [U]=3DUSER
> [=C2=A0=C2=A0 39.202690] Hardware name: ASUS System Product Name/PRIME B5=
60M-A
> AC, BIOS 2001 02/01/2023
> [=C2=A0=C2=A0 39.202691] Call Trace:
> [=C2=A0=C2=A0 39.202692]=C2=A0 <TASK>
> [=C2=A0=C2=A0 39.202695]=C2=A0 dump_stack_lvl+0x6e/0xa0
> [=C2=A0=C2=A0 39.202699]=C2=A0 ubsan_epilogue+0x5/0x30
> [=C2=A0=C2=A0 39.202701]=C2=A0 __ubsan_handle_shift_out_of_bounds.cold+0x=
61/0xe6
> [=C2=A0=C2=A0 39.202705]=C2=A0 xe_gt_tlb_invalidation_range.cold+0x1d/0x3=
a [xe]
> [=C2=A0=C2=A0 39.202800]=C2=A0 ? find_held_lock+0x2b/0x80
> [=C2=A0=C2=A0 39.202803]=C2=A0 ? mark_held_locks+0x40/0x70
> [=C2=A0=C2=A0 39.202806]=C2=A0 xe_svm_invalidate+0x459/0x700 [xe]
> [=C2=A0=C2=A0 39.202897]=C2=A0 drm_gpusvm_notifier_invalidate+0x4d/0x70 [=
drm_gpusvm]
> [=C2=A0=C2=A0 39.202900]=C2=A0 __mmu_notifier_release+0x1f5/0x270
> [=C2=A0=C2=A0 39.202905]=C2=A0 exit_mmap+0x40e/0x450
> [=C2=A0=C2=A0 39.202912]=C2=A0 __mmput+0x45/0x110
> [=C2=A0=C2=A0 39.202914]=C2=A0 exit_mm+0xc5/0x130
> [=C2=A0=C2=A0 39.202916]=C2=A0 do_exit+0x21c/0x500
> [=C2=A0=C2=A0 39.202918]=C2=A0 ? lockdep_hardirqs_on_prepare+0xdb/0x190
> [=C2=A0=C2=A0 39.202920]=C2=A0 do_group_exit+0x36/0xa0
> [=C2=A0=C2=A0 39.202922]=C2=A0 get_signal+0x8f8/0x900
> [=C2=A0=C2=A0 39.202926]=C2=A0 arch_do_signal_or_restart+0x35/0x100
> [=C2=A0=C2=A0 39.202930]=C2=A0 syscall_exit_to_user_mode+0x1fc/0x290
> [=C2=A0=C2=A0 39.202932]=C2=A0 do_syscall_64+0xa1/0x180
> [=C2=A0=C2=A0 39.202934]=C2=A0 ? do_user_addr_fault+0x59f/0x8a0
> [=C2=A0=C2=A0 39.202937]=C2=A0 ? lock_release+0xd2/0x2a0
> [=C2=A0=C2=A0 39.202939]=C2=A0 ? do_user_addr_fault+0x5a9/0x8a0
> [=C2=A0=C2=A0 39.202942]=C2=A0 ? trace_hardirqs_off+0x4b/0xc0
> [=C2=A0=C2=A0 39.202944]=C2=A0 ? clear_bhb_loop+0x25/0x80
> [=C2=A0=C2=A0 39.202946]=C2=A0 ? clear_bhb_loop+0x25/0x80
> [=C2=A0=C2=A0 39.202947]=C2=A0 ? clear_bhb_loop+0x25/0x80
> [=C2=A0=C2=A0 39.202950]=C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [=C2=A0=C2=A0 39.202952] RIP: 0033:0x7fa945e543e1
> [=C2=A0=C2=A0 39.202961] Code: Unable to access opcode bytes at 0x7fa945e=
543b7.
> [=C2=A0=C2=A0 39.202962] RSP: 002b:00007ffca8fb4170 EFLAGS: 00000293
> [=C2=A0=C2=A0 39.202963] RAX: 000000000000003d RBX: 0000000000000000 RCX:
> 00007fa945e543e3
> [=C2=A0=C2=A0 39.202964] RDX: 0000000000000000 RSI: 00007ffca8fb41ac RDI:
> 00000000ffffffff
> [=C2=A0=C2=A0 39.202964] RBP: 00007ffca8fb4190 R08: 0000000000000000 R09:
> 00007fa945f600a0
> [=C2=A0=C2=A0 39.202965] R10: 0000000000000000 R11: 0000000000000293 R12:
> 0000000000000000
> [=C2=A0=C2=A0 39.202966] R13: 00007fa9460dd310 R14: 00007ffca8fb41ac R15:
> 0000000000000000
> [=C2=A0=C2=A0 39.202970]=C2=A0 </TASK>
> [=C2=A0=C2=A0 39.202970] ---[ end trace ]---
>=20
> Fixes: 332dd0116c82 ("drm/xe: Add range based TLB invalidations")
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com> #v1
> ---
> =C2=A0drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c | 12 ++++++++++--
> =C2=A01 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
> b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
> index 03072e094991..084cbdeba8ea 100644
> --- a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
> +++ b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
> @@ -322,6 +322,13 @@ int xe_gt_tlb_invalidation_ggtt(struct xe_gt
> *gt)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +/*
> + * Ensure that roundup_pow_of_two(length) doesn't overflow.
> + * Note that roundup_pow_of_two() operates on unsigned long,
> + * not on u64.
> + */
> +#define MAX_RANGE_TLB_INVALIDATION_LENGTH
> (rounddown_pow_of_two(ULONG_MAX))
> +
> =C2=A0/**
> =C2=A0 * xe_gt_tlb_invalidation_range - Issue a TLB invalidation on this
> GT for an
> =C2=A0 * address range
> @@ -346,6 +353,7 @@ int xe_gt_tlb_invalidation_range(struct xe_gt
> *gt,
> =C2=A0	struct xe_device *xe =3D gt_to_xe(gt);
> =C2=A0#define MAX_TLB_INVALIDATION_LEN	7
> =C2=A0	u32 action[MAX_TLB_INVALIDATION_LEN];
> +	u64 length =3D end - start;
> =C2=A0	int len =3D 0;
> =C2=A0
> =C2=A0	xe_gt_assert(gt, fence);
> @@ -358,11 +366,11 @@ int xe_gt_tlb_invalidation_range(struct xe_gt
> *gt,
> =C2=A0
> =C2=A0	action[len++] =3D XE_GUC_ACTION_TLB_INVALIDATION;
> =C2=A0	action[len++] =3D 0; /* seqno, replaced in
> send_tlb_invalidation */
> -	if (!xe->info.has_range_tlb_invalidation) {
> +	if (!xe->info.has_range_tlb_invalidation ||
> +	=C2=A0=C2=A0=C2=A0 length > MAX_RANGE_TLB_INVALIDATION_LENGTH) {
> =C2=A0		action[len++] =3D
> MAKE_INVAL_OP(XE_GUC_TLB_INVAL_FULL);
> =C2=A0	} else {
> =C2=A0		u64 orig_start =3D start;
> -		u64 length =3D end - start;
> =C2=A0		u64 align;
> =C2=A0
> =C2=A0		if (length < SZ_4K)


