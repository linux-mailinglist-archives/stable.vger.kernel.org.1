Return-Path: <stable+bounces-233166-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN0NNeOPz2kzxQYAu9opvQ
	(envelope-from <stable+bounces-233166-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 12:01:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C334B393192
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 12:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CAB0630069A0
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 10:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1C5286419;
	Fri,  3 Apr 2026 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STaMsq6O"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986E6388E45
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775210461; cv=none; b=JEwD5o9nZNtF4cP5RG8/P9qduj8Hmj6S3EKqd6mIEnNEFd/4BTAx/o3HWOUuq52IUtPVk3rvq8LhCN8V8OZlT+hIGXkDBjOHg+WxHAiMhYtoTOclDzlaO3329TZpm/idSsbOPf3EMcGC0wmyqvMipCsDxbiYkeuIEdy00EWuQpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775210461; c=relaxed/simple;
	bh=4JSRAw9km5Zo7bBKyhkiNKgxBjfgpidzKmClEAuBpuY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XqPWUP/LtbyOleUD2rmeGkpZyvaXJ2uVwJJYT1eTngSRzSH6qoy1yCBL2v50kgseHfPRjqTIau/LzYPusJgNnIBquTWJtCi8Vv1yuBXBcIodbEr72SAkkmDjDRsNq6XeA0F33oVz8oJXSzAaU82RVBhnyVeuXDsx28EuFAlHSJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=STaMsq6O; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775210454; x=1806746454;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=4JSRAw9km5Zo7bBKyhkiNKgxBjfgpidzKmClEAuBpuY=;
  b=STaMsq6OnlXu9Y8rKO4F4+fmI8l6A1Q3ug+H6BXE2aO4ohZHRC3Gb25t
   nUVPR6RDklqMzgopNLcEsJqsjFWp00OQK9i5qTQ1ZwyP9LaOvfG1X9GzL
   QyPBzPviy6cNR9xZM/LbFXh2jLFn7ht92IWZejDaBKxNUAO0QuPaors4a
   T4PYdrzJKCSndeGMwvbdcFqHbwa+Vy0aG1QHEYEjEtp7h3o9hpMTBtNoX
   VIWZI8A8SHxRnOaAlSlzhPqyDko7hfukSVNi7PW+kyBMTmP2L4LIf8/Ae
   8lLU1+45oAttBD13RRW6Ny+7fyDlHyt3qgReLvATNCGmc3uiFfMk1aLRJ
   Q==;
X-CSE-ConnectionGUID: gR5z+lVGTk20j3sYxR/wew==
X-CSE-MsgGUID: 8XhCtF5URqCjZqft1Hh+xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76161514"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="76161514"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 03:00:52 -0700
X-CSE-ConnectionGUID: FF06Eq2TQ5+RrGkR0aH7kw==
X-CSE-MsgGUID: 8GWrnRaJTNSUJaapYFuk7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="220581680"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO [10.245.245.191]) ([10.245.245.191])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 03:00:50 -0700
Message-ID: <de63e900ec874a731b1a9423ec45f1984e33b367.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe: Fix slab-out-of-bounds on PT update ops retry
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, Matthew Auld <matthew.auld@intel.com>, 
	stable@vger.kernel.org
Date: Fri, 03 Apr 2026 12:00:48 +0200
In-Reply-To: <ac8pYV9MTav7nmZu@gsse-cloud1.jf.intel.com>
References: <20260402091539.4114-1-thomas.hellstrom@linux.intel.com>
	 <ac8o/ubOXlXYTUeV@gsse-cloud1.jf.intel.com>
	 <ac8pYV9MTav7nmZu@gsse-cloud1.jf.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-233166-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Queue-Id: C334B393192
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-04-02 at 19:43 -0700, Matthew Brost wrote:
> On Thu, Apr 02, 2026 at 07:42:06PM -0700, Matthew Brost wrote:
> > On Thu, Apr 02, 2026 at 11:15:39AM +0200, Thomas Hellstr=C3=B6m wrote:
> > > xe_pt_update_ops_prepare() calls xe_pt_update_ops_init() at the
> > > start of
> > > each invocation to reset per-attempt state, but current_op was
> > > not
> > > included in that reset. When vm_bind_ioctl_ops_execute() retries
> > > due to
> > > ww-mutex contention (drm_exec_retry_on_contention), ops_execute()
> > > calls
> >=20
> > I'm falling to see retry path around vm_bind_ioctl_ops_execute
> > related
> > to drm_exec_retry_on_contention... Also by the time we get to
> > vm_bind_ioctl_ops_execute we have all dma-resv, right?
>=20
> s/vm_bind_ioctl_ops_execute/ops_execute here...
>=20
> Matt

So indeed the error commit message states that the retry happens
earlier, but the KASAN message indicates that ops_execute() was already
started with the same vops. The patch indeed fixes the KASAN splat.

We might be looking at a bigger issue here, since when we
xe_vm_set_validation_exec() we need to be prepared to handle -EDEADLK
(and -ENOMEM) for that matter.

I guess in this situation those would primarily come from allocating
and validating page-table bos, and if there is a contention arising
from *any* ww lock (like in the future eviction) in ops_execute(), that
contention affects the __until_all_locked() and causes an implicit
rerun.

so I need to dig down into what's actually causing the rerun in this
case, and we need to ensure to properly handle -EDEADLKS and -ENOMEMS
after the xe_set_validation_exec() enclosed regions.

/Thomas.


>=20
> >=20
> > I believe the Kasan report but I just can't spot the bug - can you
> > point
> > out the retry path to me?
> >=20
> > Matt
> >=20
> > > xe_pt_update_ops_prepare() again. The second call walks the same
> > > op list
> > > and fills ops[] starting from current_op, which still holds the
> > > value
> > > from the first attempt. This indexes past the end of the ops
> > > array
> > > allocated by xe_vma_ops_alloc(), whose size was computed for a
> > > single
> > > pass.
> > >=20
> > > KASAN reported:
> > > =C2=A0 BUG: KASAN: slab-out-of-bounds in bind_op_prepare+0x89c/0xae0
> > > [xe]
> > > =C2=A0 Write of size 8 at addr ffff88812e72bae8 by task xe_evict/2848
> > > =C2=A0 [...]
> > > =C2=A0 bind_op_prepare+0x89c/0xae0 [xe]
> > > =C2=A0 xe_pt_update_ops_prepare+0xbd0/0x1570 [xe]
> > > =C2=A0 ops_execute+0x3ae/0x2030 [xe]
> > > =C2=A0 vm_bind_ioctl_ops_execute+0x4d5/0xed0 [xe]
> > >=20
> > > The write lands at ops[1].vma (offset 360 into the second element
> > > of a
> > > one-element 384-byte allocation) because entries[] is exactly 360
> > > bytes
> > > and current_op was 1 at the start of the retried prepare pass.
> > >=20
> > > Fix by resetting current_op to 0 in xe_pt_update_ops_init().
> > >=20
> > > Fixes: e8babb280b5e ("drm/xe: Convert multiple bind ops into
> > > single job")
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > Cc: Matthew Auld <matthew.auld@intel.com>
> > > Cc: <stable@vger.kernel.org> # v6.12+
> > > Assisted-by: GitHub Copilot:claude-sonnet-4.6
> > > Signed-off-by: Thomas Hellstr=C3=B6m
> > > <thomas.hellstrom@linux.intel.com>
> > > ---
> > > =C2=A0drivers/gpu/drm/xe/xe_pt.c | 1 +
> > > =C2=A01 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/xe/xe_pt.c
> > > b/drivers/gpu/drm/xe/xe_pt.c
> > > index 8e5f4f0dea3f..3607cd57fc4c 100644
> > > --- a/drivers/gpu/drm/xe/xe_pt.c
> > > +++ b/drivers/gpu/drm/xe/xe_pt.c
> > > @@ -2291,6 +2291,7 @@ xe_pt_update_ops_init(struct
> > > xe_vm_pgtable_update_ops *pt_update_ops)
> > > =C2=A0	init_llist_head(&pt_update_ops->deferred);
> > > =C2=A0	pt_update_ops->start =3D ~0x0ull;
> > > =C2=A0	pt_update_ops->last =3D 0x0ull;
> > > +	pt_update_ops->current_op =3D 0;
> > > =C2=A0	xe_page_reclaim_list_init(&pt_update_ops->prl);
> > > =C2=A0}
> > > =C2=A0
> > > --=20
> > > 2.53.0
> > >=20

