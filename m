Return-Path: <stable+bounces-126718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E84A71965
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 15:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B021898883
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 14:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95C71F3D56;
	Wed, 26 Mar 2025 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mGggqmkR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7651F460D
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000355; cv=none; b=TO3Qc37XmRZMU4d/vayrdb2jg5Bm6nAUXzwMNG8KTqbdoealPOq4kukVFcl994rRejAThyWomVAiwUT1SDKbVNNbiYwbz9kQqBGLhZy77qjwXShSGgtSyiw02BhM+IeUq9tY7J43PnTZo214RvWiVhuvgvL3bPkp+oOiCB/+Yqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000355; c=relaxed/simple;
	bh=1ksoWPStfT+zBgAgUW2IP3DzbG/MsZnP6p/bQBQ+Zfk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oqZVV9JS6Z6gTDAhrN2us+V5LPxS7/2HoTqg7mosgk2QNyMjz/aV2/lKxnvmmWh5lOVQXnB6Ip0mTFYaHfT5oCXm+oe+GdlGIbXaFAnnFvFsLLgo/hSZJliEnRdSxjq10mB2Unz60urDUPMj8ayJ+hR/uFcOenzVVFO+7vLlevg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mGggqmkR; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743000354; x=1774536354;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=1ksoWPStfT+zBgAgUW2IP3DzbG/MsZnP6p/bQBQ+Zfk=;
  b=mGggqmkR3HVFwmCeb5ddv6sUJ8aa4zhNxeoU65wiOKPV9iNItKVlx/Cn
   3t129h3OL96nxOxLaewvZ+nOpBiRY55WMh8dHIL7zmtyTWb4SD23siufX
   hEWX7VH8B963/kAqqqKNZnBeWN5KPiNM3AC9/l24ky7KBN96h8r+748Bc
   gTlO7raimDPbhierwf0osyBBML5Nsc9atyLWLxgqEW9RfQgWqSEZETsyu
   RQmBAtX7tWZE0oS8xFTktTLzvAKzzqudt1mwENxVm/tebsLkOcm+QhBTI
   eY7wj8urh4HxpB5gPJnle02XeaiQ7L5gdMkzqU5cgRHqCcDCfObj0pCD9
   g==;
X-CSE-ConnectionGUID: KqtevmoqQFm8xHkGPbv3DA==
X-CSE-MsgGUID: noPYS8gXSv6p7NaElNXU6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="31898208"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="31898208"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 07:45:53 -0700
X-CSE-ConnectionGUID: WLYZI0rERqit/uBr1tpURQ==
X-CSE-MsgGUID: nPhQC1SsQUKZqRTK+vxm4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="129836864"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO [10.245.246.202]) ([10.245.246.202])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 07:45:52 -0700
Message-ID: <494e40d642a82d87980ccf3fe20ed12381ff03ed.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe: Fix an out-of-bounds shift when invalidating TLB
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: intel-xe@lists.freedesktop.org, Matthew Brost <matthew.brost@intel.com>,
  Rodrigo Vivi <rodrigo.vivi@intel.com>, stable@vger.kernel.org
Date: Wed, 26 Mar 2025 15:45:48 +0100
In-Reply-To: <7r2m5yyuigo5b53uayvyoclnae2t6kev3plxsnlwqy3cfmkux6@gfpjluntolqr>
References: <20250326115117.14673-1-thomas.hellstrom@linux.intel.com>
	 <7r2m5yyuigo5b53uayvyoclnae2t6kev3plxsnlwqy3cfmkux6@gfpjluntolqr>
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

On Wed, 2025-03-26 at 08:34 -0500, Lucas De Marchi wrote:
> On Wed, Mar 26, 2025 at 12:51:17PM +0100, Thomas Hellstr=C3=B6m wrote:
> > When the size of the range invalidated is larger than
> > U64_MAX / 2 + 1, The function roundup_pow_of_two(length) will
> > hit an out-of-bounds shift.
> >=20
> > Use a full TLB invalidation for such cases.
> >=20
> > [=C2=A0=C2=A0 39.202421] ------------[ cut here ]------------
> > [=C2=A0=C2=A0 39.202657] UBSAN: shift-out-of-bounds in
> > ./include/linux/log2.h:57:13
> > [=C2=A0=C2=A0 39.202673] shift exponent 64 is too large for 64-bit type=
 'long
> > unsigned int'
> > [=C2=A0=C2=A0 39.202688] CPU: 8 UID: 0 PID: 3129 Comm: xe_exec_system_
> > Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0 U=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.14.0+ #10
> > [=C2=A0=C2=A0 39.202690] Tainted: [U]=3DUSER
> > [=C2=A0=C2=A0 39.202690] Hardware name: ASUS System Product Name/PRIME =
B560M-
> > A AC, BIOS 2001 02/01/2023
> > [=C2=A0=C2=A0 39.202691] Call Trace:
> > [=C2=A0=C2=A0 39.202692]=C2=A0 <TASK>
> > [=C2=A0=C2=A0 39.202695]=C2=A0 dump_stack_lvl+0x6e/0xa0
> > [=C2=A0=C2=A0 39.202699]=C2=A0 ubsan_epilogue+0x5/0x30
> > [=C2=A0=C2=A0 39.202701]=C2=A0 __ubsan_handle_shift_out_of_bounds.cold+=
0x61/0xe6
> > [=C2=A0=C2=A0 39.202705]=C2=A0 xe_gt_tlb_invalidation_range.cold+0x1d/0=
x3a [xe]
> > [=C2=A0=C2=A0 39.202800]=C2=A0 ? find_held_lock+0x2b/0x80
> > [=C2=A0=C2=A0 39.202803]=C2=A0 ? mark_held_locks+0x40/0x70
> > [=C2=A0=C2=A0 39.202806]=C2=A0 xe_svm_invalidate+0x459/0x700 [xe]
> > [=C2=A0=C2=A0 39.202897]=C2=A0 drm_gpusvm_notifier_invalidate+0x4d/0x70
> > [drm_gpusvm]
> > [=C2=A0=C2=A0 39.202900]=C2=A0 __mmu_notifier_release+0x1f5/0x270
> > [=C2=A0=C2=A0 39.202905]=C2=A0 exit_mmap+0x40e/0x450
> > [=C2=A0=C2=A0 39.202912]=C2=A0 __mmput+0x45/0x110
> > [=C2=A0=C2=A0 39.202914]=C2=A0 exit_mm+0xc5/0x130
> > [=C2=A0=C2=A0 39.202916]=C2=A0 do_exit+0x21c/0x500
> > [=C2=A0=C2=A0 39.202918]=C2=A0 ? lockdep_hardirqs_on_prepare+0xdb/0x190
> > [=C2=A0=C2=A0 39.202920]=C2=A0 do_group_exit+0x36/0xa0
> > [=C2=A0=C2=A0 39.202922]=C2=A0 get_signal+0x8f8/0x900
> > [=C2=A0=C2=A0 39.202926]=C2=A0 arch_do_signal_or_restart+0x35/0x100
> > [=C2=A0=C2=A0 39.202930]=C2=A0 syscall_exit_to_user_mode+0x1fc/0x290
> > [=C2=A0=C2=A0 39.202932]=C2=A0 do_syscall_64+0xa1/0x180
> > [=C2=A0=C2=A0 39.202934]=C2=A0 ? do_user_addr_fault+0x59f/0x8a0
> > [=C2=A0=C2=A0 39.202937]=C2=A0 ? lock_release+0xd2/0x2a0
> > [=C2=A0=C2=A0 39.202939]=C2=A0 ? do_user_addr_fault+0x5a9/0x8a0
> > [=C2=A0=C2=A0 39.202942]=C2=A0 ? trace_hardirqs_off+0x4b/0xc0
> > [=C2=A0=C2=A0 39.202944]=C2=A0 ? clear_bhb_loop+0x25/0x80
> > [=C2=A0=C2=A0 39.202946]=C2=A0 ? clear_bhb_loop+0x25/0x80
> > [=C2=A0=C2=A0 39.202947]=C2=A0 ? clear_bhb_loop+0x25/0x80
> > [=C2=A0=C2=A0 39.202950]=C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [=C2=A0=C2=A0 39.202952] RIP: 0033:0x7fa945e543e1
> > [=C2=A0=C2=A0 39.202961] Code: Unable to access opcode bytes at
> > 0x7fa945e543b7.
> > [=C2=A0=C2=A0 39.202962] RSP: 002b:00007ffca8fb4170 EFLAGS: 00000293
> > [=C2=A0=C2=A0 39.202963] RAX: 000000000000003d RBX: 0000000000000000 RC=
X:
> > 00007fa945e543e3
> > [=C2=A0=C2=A0 39.202964] RDX: 0000000000000000 RSI: 00007ffca8fb41ac RD=
I:
> > 00000000ffffffff
> > [=C2=A0=C2=A0 39.202964] RBP: 00007ffca8fb4190 R08: 0000000000000000 R0=
9:
> > 00007fa945f600a0
> > [=C2=A0=C2=A0 39.202965] R10: 0000000000000000 R11: 0000000000000293 R1=
2:
> > 0000000000000000
> > [=C2=A0=C2=A0 39.202966] R13: 00007fa9460dd310 R14: 00007ffca8fb41ac R1=
5:
> > 0000000000000000
> > [=C2=A0=C2=A0 39.202970]=C2=A0 </TASK>
> > [=C2=A0=C2=A0 39.202970] ---[ end trace ]---
> >=20
> > Fixes: 332dd0116c82 ("drm/xe: Add range based TLB invalidations")
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.8+
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
> > b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
> > index 03072e094991..79f8fe127867 100644
> > --- a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
> > +++ b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
> > @@ -346,6 +346,7 @@ int xe_gt_tlb_invalidation_range(struct xe_gt
> > *gt,
> > 	struct xe_device *xe =3D gt_to_xe(gt);
> > #define MAX_TLB_INVALIDATION_LEN	7
> > 	u32 action[MAX_TLB_INVALIDATION_LEN];
> > +	u64 length =3D end - start;
> > 	int len =3D 0;
> >=20
> > 	xe_gt_assert(gt, fence);
> > @@ -358,11 +359,10 @@ int xe_gt_tlb_invalidation_range(struct xe_gt
> > *gt,
> >=20
> > 	action[len++] =3D XE_GUC_ACTION_TLB_INVALIDATION;
> > 	action[len++] =3D 0; /* seqno, replaced in
> > send_tlb_invalidation */
> > -	if (!xe->info.has_range_tlb_invalidation) {
> > +	if (!xe->info.has_range_tlb_invalidation || length >
> > (U64_MAX >> 1) + 1) {
>=20
> maybe add a
>=20
> #define MAX_RANGE_TLB_INVALIDATION_LEN ((U64_MAX >> 1) + 1)
>=20
> here?
>=20
> Anyway,
>=20
> Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

Thanks for the review.
I noticed that roundup_pow_of_two() actually operates on unsigned long
so I need to respin anyway to ensure this doesn't reappear should
someone try a 32-bit kernel.

I'll add a define.
Thanks,
Thomas


>=20
> Lucas De Marchi
>=20
> > 		action[len++] =3D
> > MAKE_INVAL_OP(XE_GUC_TLB_INVAL_FULL);
> > 	} else {
> > 		u64 orig_start =3D start;
> > -		u64 length =3D end - start;
> > 		u64 align;
> >=20
> > 		if (length < SZ_4K)
> > --=20
> > 2.48.1
> >=20


