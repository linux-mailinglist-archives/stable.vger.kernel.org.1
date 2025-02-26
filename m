Return-Path: <stable+bounces-119706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9A8A465C7
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 16:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1744188604F
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 15:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEEF21D5AE;
	Wed, 26 Feb 2025 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OygLUs35"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C40121CA01
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584802; cv=none; b=HnWvA3iwWh8ooaYipT+K+ZBOoitsV5hscgYjh152Lwb68i9Tdn2ouhMXa9aM76lmKY/wCs0AIKBAe286xnbWxAR3T5u4tMqo0mMmB5JGNX8EC7ljY0dLok8JIZnA9UerQyo/QYKnKczHm4MeRVheONb0iphFuG0x3OEei9BddXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584802; c=relaxed/simple;
	bh=AxaTEhM5IycwKCBxxWZYxXGGBG5GdFGZsmfJu1iszUo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rt1YORNkD14EWs65exBL5XM1EoNVnY7/o5BIl4TJEX0vXmAeicrbTiWKUYVEm6WwHgPNnm/zkJ/G+UE24E4AG3yoayJmtQ+jQJU+w6qFEF8xx5Zt587I0oQ7v9UyTOh7pk+aVRQPGDPOfSTPJtegcfTLJOVg4CHkZOhOh4NtazU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OygLUs35; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740584801; x=1772120801;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=AxaTEhM5IycwKCBxxWZYxXGGBG5GdFGZsmfJu1iszUo=;
  b=OygLUs35E/mer+cIdyDUGp1hIFHxR1/SqiJiquqj5ubpQsr77FBN7WwW
   E7VXEhgfOOa4nLGcsZTI9Z88H8Iq8AJ/smsGBy/0Ay61soZTe0+EuMdFo
   tI3OSTvrxpSdfLQp0zDWQliaio0xQQy9iRvdU4LJytQZU5WAsn5jOCl8A
   z+f/X/nt1EqcAO/wkC63ytPU3cY1cbmeeIVmFY374tzN3of6ywpB+rqxV
   yvZ2m0sFBJMF8UqT+G+5EXIfsJjnSJNx5V/9jQqocjilMUX9+2RYwGpfy
   S09m4XV66vxk/iBU+I+VZcha3bbOuKrA1xTaHxIOL6F4EkC43jF+01uYx
   w==;
X-CSE-ConnectionGUID: RVoDFf/HRWWWdv9c9df6KQ==
X-CSE-MsgGUID: L3AE1nPmQouww6vp2AG9mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="40615618"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="40615618"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 07:46:40 -0800
X-CSE-ConnectionGUID: oFAsXXbsS/2/Sj/r/Hovdw==
X-CSE-MsgGUID: C1M6vDwjRfKXnzNHRiB4IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117232269"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO [10.245.246.81]) ([10.245.246.81])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 07:46:39 -0800
Message-ID: <bdc202030ec807149fc8805461779d8c8b1d5fe0.camel@linux.intel.com>
Subject: Re: [PATCH 1/4] drm/xe/vm: Validate userptr during gpu vma
 prefetching
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, stable@vger.kernel.org
Date: Wed, 26 Feb 2025 16:46:36 +0100
In-Reply-To: <Z7811mqgky+kKypb@lstrano-desk.jf.intel.com>
References: <20250226153344.58175-1-thomas.hellstrom@linux.intel.com>
	 <20250226153344.58175-2-thomas.hellstrom@linux.intel.com>
	 <Z7811mqgky+kKypb@lstrano-desk.jf.intel.com>
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

On Wed, 2025-02-26 at 07:40 -0800, Matthew Brost wrote:
> On Wed, Feb 26, 2025 at 04:33:41PM +0100, Thomas Hellstr=C3=B6m wrote:
> > If a userptr vma subject to prefetching was already invalidated
> > or invalidated during the prefetch operation, the operation would
> > repeatedly return -EAGAIN which would typically cause an infinite
> > loop.
> >=20
> > Validate the userptr to ensure this doesn't happen.
> >=20
> > Fixes: 5bd24e78829a ("drm/xe/vm: Subclass userptr vmas")
> > Fixes: 617eebb9c480 ("drm/xe: Fix array of binds")
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.9+
> > Suggested-by: Matthew Brost <matthew.brost@intel.com>
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > =C2=A0drivers/gpu/drm/xe/xe_vm.c | 9 ++++++++-
> > =C2=A01 file changed, 8 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/xe/xe_vm.c
> > b/drivers/gpu/drm/xe/xe_vm.c
> > index 996000f2424e..4c1ca47667ad 100644
> > --- a/drivers/gpu/drm/xe/xe_vm.c
> > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > @@ -2307,7 +2307,14 @@ static int vm_bind_ioctl_ops_parse(struct
> > xe_vm *vm, struct drm_gpuva_ops *ops,
> > =C2=A0		}
> > =C2=A0		case DRM_GPUVA_OP_UNMAP:
> > =C2=A0		case DRM_GPUVA_OP_PREFETCH:
> > -			/* FIXME: Need to skip some prefetch ops
> > */
>=20
> The UNMAP case statement is falling through to pretech case which I
> believe is not the intent.
>=20
> So I think:
>=20
> case DRM_GPUVA_OP_UNMAP:
> 	xe_vma_ops_incr_pt_update_ops(vops, op->tile_mask);
> 	break;
> case DRM_GPUVA_OP_PREFETCH:
> 	<new code>
>=20
> Matt

Right.
Will fix.

/Thomas

>=20
> > +			vma =3D gpuva_to_vma(op->base.prefetch.va);
> > +
> > +			if (xe_vma_is_userptr(vma)) {
> > +				err =3D
> > xe_vma_userptr_pin_pages(to_userptr_vma(vma));
> > +				if (err)
> > +					return err;
> > +			}
> > +
> > =C2=A0			xe_vma_ops_incr_pt_update_ops(vops, op-
> > >tile_mask);
> > =C2=A0			break;
> > =C2=A0		default:
> > --=20
> > 2.48.1
> >=20


