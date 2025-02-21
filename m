Return-Path: <stable+bounces-118579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684FDA3F5CD
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 14:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3241E7A5077
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 13:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7255A36AF5;
	Fri, 21 Feb 2025 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GTDtglvB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8FD111A8
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740144210; cv=none; b=HaKF27689NSZ3p6P65slpK5phZc3CU0h1bUYFCIhb6naNWubhVyfEwTpmLHV+7ptsFRVExc0QNZVwJR5uJ4Ul371fwlDFKQ2vt+b9qPw/FdHnanLOwvtgTBjsXKvDanHnEe6k+xw/uxzLLXq9n0a9erEbrXQ9M8bvSpuuYJ1JNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740144210; c=relaxed/simple;
	bh=I3wMIoDDq3s67tRnA6fayHPSj1bN696BBtQiqVaFFqE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ozDLET5inCVBSudCizaEloYtgwwTp06sm9YCUtXwfY9eYE0FgwtKugkKpwATTaKL9psVjR157aznKJkYJs/tcVIYC4y3IzyEKi0wVnfI2Jw9Aa0UbOS6c4RD0P1JBONi0F6elr0AE9v3q3KxnhtuVTJkrY11thNy1G+seixBI9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GTDtglvB; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740144209; x=1771680209;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=I3wMIoDDq3s67tRnA6fayHPSj1bN696BBtQiqVaFFqE=;
  b=GTDtglvBnV2tyP0m2s5gUlZuTHY9vXpWkbrHbbGeqOkgWFfWKOZ/J4J1
   tPURxa41/3YNFZAlp/VzrGWn8+R1Qu6rFrpUFnQ769faPcL1LXvZ+ljwk
   hdsxUKECmQiJ7yAJpO/0gWi9Aw45s1M5RTMnIe4SDkBvktC5njzAD3tza
   hGdiZb7tAmlloXj9qDczOmHtIkJakQGDbFz+lb3mlitqeWCBmLVy2swkB
   AZyOA5O3lLOp1O6Ml6+cyds8J6m5sMOEYZsbuoWyj9OsIKvEtKstDcrD7
   YXmEownKVMe/8FsNE6YzpBu2HDm/Z8S7FH2VrOLvFSjMQx+J6dKWvEm+6
   g==;
X-CSE-ConnectionGUID: z0ArJ7fbTi2h8kYTuX9S6g==
X-CSE-MsgGUID: Ig//55YpTfGv91VVBC1Tqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40674261"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="40674261"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 05:23:28 -0800
X-CSE-ConnectionGUID: t0NephwyQ7CyzV4yJMJeKA==
X-CSE-MsgGUID: 0/mqxkRhQGeDFkfbe/ep+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="152562410"
Received: from carterle-desk.ger.corp.intel.com (HELO [10.245.246.42]) ([10.245.246.42])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 05:23:26 -0800
Message-ID: <18d8bdca761f2daaf4b46b81f49838be3488aa95.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/3] drm/xe/userptr: restore invalidation list on
 error
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Auld <matthew.auld@intel.com>, Matthew Brost
	 <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, stable@vger.kernel.org
Date: Fri, 21 Feb 2025 14:23:23 +0100
In-Reply-To: <f2c9136f-ecb4-4b60-92f5-6938ec242c2e@intel.com>
References: <20250214170527.272182-4-matthew.auld@intel.com>
	 <Z6/ttCTrEuwNsD6w@lstrano-desk.jf.intel.com>
	 <6fec16d5-cbf3-448b-9c07-85a079095f62@intel.com>
	 <Z7QFUy9ZyBRhPwuY@lstrano-desk.jf.intel.com>
	 <Z7fAIjU/3wW8eMQL@lstrano-desk.jf.intel.com>
	 <cfbcea7a-bcba-4e7a-9b63-398a48da789d@intel.com>
	 <a6ac4585efaabc710c377b786d042177e0df48ad.camel@linux.intel.com>
	 <f2c9136f-ecb4-4b60-92f5-6938ec242c2e@intel.com>
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

On Fri, 2025-02-21 at 13:17 +0000, Matthew Auld wrote:
> On 21/02/2025 11:20, Thomas Hellstr=C3=B6m wrote:
> > On Fri, 2025-02-21 at 11:11 +0000, Matthew Auld wrote:
> > > On 20/02/2025 23:52, Matthew Brost wrote:
> > > > On Mon, Feb 17, 2025 at 07:58:11PM -0800, Matthew Brost wrote:
> > > > > On Mon, Feb 17, 2025 at 09:38:26AM +0000, Matthew Auld wrote:
> > > > > > On 15/02/2025 01:28, Matthew Brost wrote:
> > > > > > > On Fri, Feb 14, 2025 at 05:05:28PM +0000, Matthew Auld
> > > > > > > wrote:
> > > > > > > > On error restore anything still on the pin_list back to
> > > > > > > > the
> > > > > > > > invalidation
> > > > > > > > list on error. For the actual pin, so long as the vma
> > > > > > > > is
> > > > > > > > tracked on
> > > > > > > > either list it should get picked up on the next pin,
> > > > > > > > however it looks
> > > > > > > > possible for the vma to get nuked but still be present
> > > > > > > > on
> > > > > > > > this per vm
> > > > > > > > pin_list leading to corruption. An alternative might be
> > > > > > > > then to instead
> > > > > > > > just remove the link when destroying the vma.
> > > > > > > >=20
> > > > > > > > Fixes: ed2bdf3b264d ("drm/xe/vm: Subclass userptr
> > > > > > > > vmas")
> > > > > > > > Suggested-by: Matthew Brost <matthew.brost@intel.com>
> > > > > > > > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> > > > > > > > Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com=
>
> > > > > > > > Cc: <stable@vger.kernel.org> # v6.8+
> > > > > > > > ---
> > > > > > > > =C2=A0=C2=A0=C2=A0 drivers/gpu/drm/xe/xe_vm.c | 26
> > > > > > > > +++++++++++++++++++-----
> > > > > > > > --
> > > > > > > > =C2=A0=C2=A0=C2=A0 1 file changed, 19 insertions(+), 7 dele=
tions(-)
> > > > > > > >=20
> > > > > > > > diff --git a/drivers/gpu/drm/xe/xe_vm.c
> > > > > > > > b/drivers/gpu/drm/xe/xe_vm.c
> > > > > > > > index d664f2e418b2..668b0bde7822 100644
> > > > > > > > --- a/drivers/gpu/drm/xe/xe_vm.c
> > > > > > > > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > > > > > > > @@ -670,12 +670,12 @@ int xe_vm_userptr_pin(struct
> > > > > > > > xe_vm
> > > > > > > > *vm)
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0	list_for_each_entry_safe(uvma, nex=
t, &vm-
> > > > > > > > > userptr.invalidated,
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0			=09
> > > > > > > > userptr.invalidate_link)
> > > > > > > > {
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0		list_del_init(&uvma-
> > > > > > > > > userptr.invalidate_link);
> > > > > > > > -		list_move_tail(&uvma-
> > > > > > > > >userptr.repin_link,
> > > > > > > > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &vm-
> > > > > > > > >userptr.repin_list);
> > > > > > > > +		list_add_tail(&uvma-
> > > > > > > > >userptr.repin_link,
> > > > > > > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &vm-
> > > > > > > > >userptr.repin_list);
> > > > > > >=20
> > > > > > > Why this change?
> > > > > >=20
> > > > > > Just that with this patch the repin_link should now always
> > > > > > be
> > > > > > empty at this
> > > > > > point, I think. add should complain if that is not the
> > > > > > case.
> > > > > >=20
> > > > >=20
> > > > > If it is always expected to be empty, then yea maybe add a
> > > > > xe_assert for
> > > > > this as the list management is pretty tricky.
> > > > >=20
> > > > > > >=20
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0	}
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0	spin_unlock(&vm->userptr.invalidat=
ed_lock);
> > > > > > > > -	/* Pin and move to temporary list */
> > > > > > > > +	/* Pin and move to bind list */
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0	list_for_each_entry_safe(uvma, nex=
t, &vm-
> > > > > > > > > userptr.repin_list,
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0				 userptr.repin_link) {
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0		err =3D xe_vma_userptr_pin_pages(=
uvma);
> > > > > > > > @@ -691,10 +691,10 @@ int xe_vm_userptr_pin(struct
> > > > > > > > xe_vm
> > > > > > > > *vm)
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0			err =3D
> > > > > > > > xe_vm_invalidate_vma(&uvma-
> > > > > > > > > vma);
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0			xe_vm_unlock(vm);
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0			if (err)
> > > > > > > > -				return err;
> > > > > > > > +				break;
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0		} else {
> > > > > > > > -			if (err < 0)
> > > > > > > > -				return err;
> > > > > > > > +			if (err)
> > > > > > > > +				break;
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0			list_del_init(&uvma-
> > > > > > > > > userptr.repin_link);
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0			list_move_tail(&uvma-
> > > > > > > > > vma.combined_links.rebind,
> > > > > > > > @@ -702,7 +702,19 @@ int xe_vm_userptr_pin(struct xe_vm
> > > > > > > > *vm)
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0		}
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0	}
> > > > > > > > -	return 0;
> > > > > > > > +	if (err) {
> > > > > > > > +		down_write(&vm-
> > > > > > > > >userptr.notifier_lock);
> > > > > > >=20
> > > > > > > Can you explain why you take the notifier lock here? I
> > > > > > > don't
> > > > > > > think this
> > > > > > > required unless I'm missing something.
> > > > > >=20
> > > > > > For the invalidated list, the docs say:
> > > > > >=20
> > > > > > "Removing items from the list additionally requires @lock
> > > > > > in
> > > > > > write mode, and
> > > > > > adding items to the list requires the @userptr.notifer_lock
> > > > > > in
> > > > > > write mode."
> > > > > >=20
> > > > > > Not sure if the docs needs to be updated here?
> > > > > >=20
> > > > >=20
> > > > > Oh. I believe the part of comment for 'adding items to the
> > > > > list
> > > > > requires the @userptr.notifer_lock in write mode' really
> > > > > means
> > > > > something
> > > > > like this:
> > > > >=20
> > > > > 'When adding to @vm->userptr.invalidated in the notifier the
> > > > > @userptr.notifer_lock in write mode protects against
> > > > > concurrent
> > > > > VM binds
> > > > > from setting up newly invalidated pages.'
> > > > >=20
> > > > > So with above and since this code path is in the VM bind path
> > > > > (i.e. we
> > > > > are not racing with other binds) I think the
> > > > > vm->userptr.invalidated_lock is sufficient. Maybe ask Thomas
> > > > > if
> > > > > he
> > > > > agrees here.
> > > > >=20
> > > >=20
> > > > After some discussion with Thomas, removing notifier lock here
> > > > is
> > > > safe.
> > >=20
> > > Thanks for confirming.
> >=20
> > So basically that was to protect exec when it takes the notifier
> > lock
> > in read mode, and checks that there are no invalidated userptr,
> > that
> > needs to stay true as lock as the notifier lock is held.
> >=20
> > But as MBrost pointed out, the vm lock is also held, so I think the
> > kerneldoc should be updated so that the requirement is that either
> > the
> > notifier lock is held in write mode, or the vm lock in write mode.
> >=20
> > As a general comment these locking protection docs are there to
> > simplify reading and writing of the code so that when new code is
> > written and reviewed, we should just keep to the rules to avoid
> > auditing all locations in the driver where the protected data-
> > structure
> > is touched. If we want to update those docs I think a complete such
> > audit needs to be done and all use-cases are understood.
>=20
> For this patch is the preference to go with the slightly overzealous=20
> locking for now? Circling back around later, fixing the doc when
> adding=20
> the new helper, and at the same time also audit all callers?

Since it's a -fixes patch I think we should keep the locking and
documentation consistent, so either update the docs also in the stable
backports or do the overzealous locking.

/Thomas



>=20
> >=20
> > /Thomas
> >=20
> >=20
> > >=20
> > > >=20
> > > > However, for adding is either userptr.notifer_lock || vm->lock
> > > > to
> > > > also
> > > > avoid races between binds, execs, and rebind worker.
> > > >=20
> > > > I'd like update the documentation and add a helper like this:
> > > >=20
> > > > void xe_vma_userptr_add_invalidated(struct xe_userptr_vma
> > > > *uvma)
> > > > {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct xe_vm *vm =
=3D xe_vma_vm(&uvma->vma);
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lockdep_assert(loc=
k_is_held_type(&vm->lock.dep_map, 1)
> > > > ||
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lo=
ck_is_held_type(&vm-
> > > > > userptr.notifier_lock.dep_map, 1));
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&vm->use=
rptr.invalidated_lock);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_move_tail(&uv=
ma->userptr.invalidate_link,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &v=
m->userptr.invalidated);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&vm->u=
serptr.invalidated_lock);
> > > > }
> > >=20
> > > Sounds good.
> > >=20
> > > >=20
> > > > However, let's delay the helper until this series and recently
> > > > post
> > > > series of mine [1] merge as both are fixes series and hoping
> > > > for a
> > > > clean
> > > > backport.
> > >=20
> > > Makes sense.
> > >=20
> > > >=20
> > > > Matt
> > > >=20
> > > > [1] https://patchwork.freedesktop.org/series/145198/
> > > >=20
> > > > > Matt
> > > > >=20
> > > > > > >=20
> > > > > > > Matt
> > > > > > >=20
> > > > > > > > +		spin_lock(&vm-
> > > > > > > > >userptr.invalidated_lock);
> > > > > > > > +		list_for_each_entry_safe(uvma, next,
> > > > > > > > &vm-
> > > > > > > > > userptr.repin_list,
> > > > > > > > +				=09
> > > > > > > > userptr.repin_link) {
> > > > > > > > +			list_del_init(&uvma-
> > > > > > > > > userptr.repin_link);
> > > > > > > > +			list_move_tail(&uvma-
> > > > > > > > > userptr.invalidate_link,
> > > > > > > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &vm-
> > > > > > > > > userptr.invalidated);
> > > > > > > > +		}
> > > > > > > > +		spin_unlock(&vm-
> > > > > > > > > userptr.invalidated_lock);
> > > > > > > > +		up_write(&vm->userptr.notifier_lock);
> > > > > > > > +	}
> > > > > > > > +	return err;
> > > > > > > > =C2=A0=C2=A0=C2=A0 }
> > > > > > > > =C2=A0=C2=A0=C2=A0 /**
> > > > > > > > --=20
> > > > > > > > 2.48.1
> > > > > > > >=20
> > > > > >=20
> > >=20
> >=20
>=20


