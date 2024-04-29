Return-Path: <stable+bounces-41717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535E28B5964
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 15:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71871F22312
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BF3762DE;
	Mon, 29 Apr 2024 13:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U2wvUDmO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324946EB6F
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395951; cv=none; b=gfvpzrTuCymP4+WaJ00UkbSVoORUfmOYfQy+E8/5CIsw4iEwV3SdObxlL0XLWjU/8Ev36ON7BQukDI0/pfuKA+0bUOHuLA7pOwXzcIq0856qkoojUygMHF7LMHDQkjAp7lx06pdog1NbkyfC7X+4zxi17zPuUM1Fn0SBHFPaoY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395951; c=relaxed/simple;
	bh=BP2NL6JGHrKt0V8kRwSfeo4xBJMHJfIrsmzsIFBfdhY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BsTffh8b/pv4CwF1WkWfTwnvnGdnQeBt+Zqj7FpSPKE2asPQN/eby+6wY+NWVoX9n4gcTGFjOmuLEvqCk4901stinJIBRUp4I9MA5WRlHxiBpFC9m88cPOiWFI/GXO7tRir2Vovvrfm7Ht+F+//oVz5G54U1ZN71At9XmeuWSUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U2wvUDmO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714395950; x=1745931950;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=BP2NL6JGHrKt0V8kRwSfeo4xBJMHJfIrsmzsIFBfdhY=;
  b=U2wvUDmOlq29W4q1cRIHLHAuenK8kmX+HDuJS+5iukZo4G7TMNT5SQH2
   xjKTozziRRqY7uVaeMOutwrNbKg4mag20aosYdImNQfQxnZp2nCtk7teW
   N2OJ9QuUnc8dw1RBwZECMSG2jUV4p3jSbuQGPUgOik+TRT0ZEZCyKzTq9
   NG6l05qYzy7zdX+ZPXTK6axDVjn/wxFpB4lchYt1G5V5pw1/eS8xLpZU/
   y04P2tmFkyt0GRLeLjt4iSMITRMISXUkBf8oHEIATcretWVl78IEIy0WI
   FRgOkjm4QBTkOR7OdJ6b2ZWeA1aQjqLfRIP6IMTerxqimtlrmv4BxevC9
   Q==;
X-CSE-ConnectionGUID: p14NevHdQsCqATqEpKmtXQ==
X-CSE-MsgGUID: KO6a0lLgReu+9voraDSEDw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="21460899"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="21460899"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 06:05:49 -0700
X-CSE-ConnectionGUID: X+vMbHFeRb6Lb0Vobp1Wgw==
X-CSE-MsgGUID: dUI5wlLISmu0FVaeC6MIHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26090043"
Received: from sbint17x-mobl.gar.corp.intel.com (HELO [10.249.254.23]) ([10.249.254.23])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 06:05:48 -0700
Message-ID: <fd5fd09fcfe3604d92be3352753cc0510718f281.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe: Unmap userptr in MMU invalidation notifier
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org
Date: Mon, 29 Apr 2024 15:05:45 +0200
In-Reply-To: <Zi7z0MU9gV9+o8c8@DUT025-TGLU.fm.intel.com>
References: <20240426233236.2077378-1-matthew.brost@intel.com>
	 <Zi7z0MU9gV9+o8c8@DUT025-TGLU.fm.intel.com>
Autocrypt: addr=thomas.hellstrom@linux.intel.com; prefer-encrypt=mutual;
 keydata=mDMEZaWU6xYJKwYBBAHaRw8BAQdAj/We1UBCIrAm9H5t5Z7+elYJowdlhiYE8zUXgxcFz360SFRob21hcyBIZWxsc3Ryw7ZtIChJbnRlbCBMaW51eCBlbWFpbCkgPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPoiTBBMWCgA7FiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQuBaTVQrGBr/yQAD/Z1B+Kzy2JTuIy9LsKfC9FJmt1K/4qgaVeZMIKCAxf2UBAJhmZ5jmkDIf6YghfINZlYq6ixyWnOkWMuSLmELwOsgPuDgEZaWU6xIKKwYBBAGXVQEFAQEHQF9v/LNGegctctMWGHvmV/6oKOWWf/vd4MeqoSYTxVBTAwEIB4h4BBgWCgAgFiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwwACgkQuBaTVQrGBr/P2QD9Gts6Ee91w3SzOelNjsus/DcCTBb3fRugJoqcfxjKU0gBAKIFVMvVUGbhlEi6EFTZmBZ0QIZEIzOOVfkaIgWelFEH
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-29 at 01:11 +0000, Matthew Brost wrote:
> On Fri, Apr 26, 2024 at 04:32:36PM -0700, Matthew Brost wrote:
> > To be secure, when a userptr is invalidated the pages should be dma
> > unmapped ensuring the device can no longer touch the invalidated
> > pages.
> >=20
> > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
> > GPUs")
> > Fixes: 12f4b58a37f4 ("drm/xe: Use hmm_range_fault to populate user
> > pages")
> > Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > Cc: stable@vger.kernel.org=C2=A0# 6.8
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> > =C2=A0drivers/gpu/drm/xe/xe_vm.c | 3 +++
> > =C2=A01 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/xe/xe_vm.c
> > b/drivers/gpu/drm/xe/xe_vm.c
> > index dfd31b346021..964a5b4d47d8 100644
> > --- a/drivers/gpu/drm/xe/xe_vm.c
> > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > @@ -637,6 +637,9 @@ static bool vma_userptr_invalidate(struct
> > mmu_interval_notifier *mni,
> > =C2=A0		XE_WARN_ON(err);
> > =C2=A0	}
> > =C2=A0
> > +	if (userptr->sg)
> > +		xe_hmm_userptr_free_sg(uvma);
> > +
>=20
> I thought about this a bit, I think here we only dma unmap the SG,
> not
> free it. Freeing it could cause a current bind walk to access corrupt
> memory. Freeing can be deferred to the next attempt to bind the
> userptr
> or userptr destroy.

Yes, makes sense.
/Thomas



>=20
> Matt
>=20
> > =C2=A0	trace_xe_vma_userptr_invalidate_complete(vma);
> > =C2=A0
> > =C2=A0	return true;
> > --=20
> > 2.34.1
> >=20


