Return-Path: <stable+bounces-105637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B417D9FB0F1
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3CA118848AD
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 15:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419231A8F84;
	Mon, 23 Dec 2024 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gRL1a7QZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E751AB525
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734969408; cv=none; b=ClQUTlQxrxSHw/h70/mDdUVvBPof1p+RvIp1nKz0ZBLya1VA88rDc6V3Q8PY59XVxA1L2SpaL0tNmM+b44MPFhJW5qtw5i6mNgn9PXRWDnLVZo3u/w54ThEvx6B5F8ONc8J/8+n0qzuqXSBaDAsXYbmADdixRIo7FhNpU7sw1Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734969408; c=relaxed/simple;
	bh=+GNJHYPkUy9cH7hl+EMosfB6ifKRjYa3K7e2rv5aFX4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WA4h5a2YzkL3vWEOBIt4FodtFopE9DzaCGRnEbuzN8PzniSjwKORh+Kgi4zex0q6W5OuOVpniE+TcDjYx6wA3WRshI6Ao8HQVeSDAfiKu0Yukp3I90gNz0JVrtwrK9U2R5uV95hpnWl7pcU74tco1JN/EvgT9NeL/z5tX8EZm6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gRL1a7QZ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734969406; x=1766505406;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=+GNJHYPkUy9cH7hl+EMosfB6ifKRjYa3K7e2rv5aFX4=;
  b=gRL1a7QZ9BGh7b0TzSxsXzrR49ZbavIVLQXMwLC4iwdg1kTFQdNlAPPU
   wuDF6aMHDefwg68TtNWIQ9OTDTo74s1PEMwHjhMlqBpMStkfPH2KohIrd
   sA4nu+T57Gp2DjyXUAO1OSxdTT3xenRD/sFNcA8SaVfis9eQJPgnMCekq
   /bBS6UShVDnCOYcBB2dlwy1d5VZ4/wr9kH36r94luft5DgL1Qc+ch0P0L
   5LBFOero5irjI5Wk+nFqXK6qw2CGxMBORKjeB51VMoXzj7NHwznYKGcUH
   T8h0igt8kpDZH+tsXjQRpELc/11H2DFQOQvPL/jHDYaZsNI+XVtUTqaHy
   Q==;
X-CSE-ConnectionGUID: 8kBsJDB8QjqYeAirB4ysJw==
X-CSE-MsgGUID: IhCMTOKqR3GcOqQF2vDUCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="35317426"
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="35317426"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 07:56:46 -0800
X-CSE-ConnectionGUID: en4tCVlGSZaVURh1UhAuUw==
X-CSE-MsgGUID: TGQfZC/ETZmE9R+wXj0Wpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="99101051"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO [10.245.246.74]) ([10.245.246.74])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 07:56:43 -0800
Message-ID: <0110c37448ee997bbede63911ab1d498d33a4a2f.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe/tracing: Fix a potential TP_printk UAF
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: "Cavitt, Jonathan" <jonathan.cavitt@intel.com>, 
 "intel-xe@lists.freedesktop.org"
	 <intel-xe@lists.freedesktop.org>
Cc: "Sousa, Gustavo" <gustavo.sousa@intel.com>, "De Marchi, Lucas"	
 <lucas.demarchi@intel.com>, Radhakrishna Sripada	
 <radhakrishna.sripada@intel.com>, "Roper, Matthew D"
 <matthew.d.roper@intel.com>,  "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Date: Mon, 23 Dec 2024 16:56:40 +0100
In-Reply-To: <CH0PR11MB544474672DC3D24C193A12B5E5022@CH0PR11MB5444.namprd11.prod.outlook.com>
References: <20241223134250.14345-1-thomas.hellstrom@linux.intel.com>
	 <CH0PR11MB544474672DC3D24C193A12B5E5022@CH0PR11MB5444.namprd11.prod.outlook.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-12-23 at 15:44 +0000, Cavitt, Jonathan wrote:
> -----Original Message-----
> From: Intel-xe <intel-xe-bounces@lists.freedesktop.org> On Behalf Of
> Thomas Hellstr=C3=B6m
> Sent: Monday, December 23, 2024 5:43 AM
> To: intel-xe@lists.freedesktop.org
> Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>; Sousa,
> Gustavo <gustavo.sousa@intel.com>; De Marchi, Lucas
> <lucas.demarchi@intel.com>; Radhakrishna Sripada
> <radhakrishna.sripada@intel.com>; Roper, Matthew D
> <matthew.d.roper@intel.com>; Vivi, Rodrigo <rodrigo.vivi@intel.com>;
> stable@vger.kernel.org
> Subject: [PATCH] drm/xe/tracing: Fix a potential TP_printk UAF
> >=20
> > The commit
> > afd2627f727b ("tracing: Check "%s" dereference via the field and
> > not the TP_printk format")
> > exposes potential UAFs in the xe_bo_move trace event.
> >=20
> > Fix those by avoiding dereferencing the
> > xe_mem_type_to_name[] array at TP_printk time.
> >=20
> > Since some code refactoring has taken place, explicit backporting
> > may
> > be needed for kernels older than 6.10.
> >=20
> > Fixes: e46d3f813abd ("drm/xe/trace: Extract bo, vm, vma traces")
> > Cc: Gustavo Sousa <gustavo.sousa@intel.com>
> > Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> > Cc: Radhakrishna Sripada <radhakrishna.sripada@intel.com>
> > Cc: Matt Roper <matthew.d.roper@intel.com>
> > Cc: "Thomas Hellstr=C3=B6m" <thomas.hellstrom@linux.intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: intel-xe@lists.freedesktop.org
> > Cc: <stable@vger.kernel.org> # v6.11+
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
>=20
> I take it we're hitting the WARN_ONCE in ignore_event due to a
> test_safe_str failure?

Actually it's the WARN_ONCE in test_event_printk()

if (WARN_ON_ONCE(dereference_flags)) {


> I don't know about us hitting a UAF here, but this fix is exactly
> what was recommended
> in the comment immediately above the WARN_ONCE that we shouldn't be
> hitting, so
> this is probably correct if that's what we're trying to avoid.

I'll double-check to see if I can easily trigger the UAF.


> Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>

Thanks,
Thomas


> -Jonathan Cavitt
>=20
> > ---
> > =C2=A0drivers/gpu/drm/xe/xe_trace_bo.h | 12 ++++++------
> > =C2=A01 file changed, 6 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/xe/xe_trace_bo.h
> > b/drivers/gpu/drm/xe/xe_trace_bo.h
> > index 1762dd30ba6d..ea50fee50c7d 100644
> > --- a/drivers/gpu/drm/xe/xe_trace_bo.h
> > +++ b/drivers/gpu/drm/xe/xe_trace_bo.h
> > @@ -60,8 +60,8 @@ TRACE_EVENT(xe_bo_move,
> > =C2=A0	=C2=A0=C2=A0=C2=A0 TP_STRUCT__entry(
> > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 __field(struct xe_bo *, bo)
> > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 __field(size_t, size)
> > -		=C2=A0=C2=A0=C2=A0=C2=A0 __field(u32, new_placement)
> > -		=C2=A0=C2=A0=C2=A0=C2=A0 __field(u32, old_placement)
> > +		=C2=A0=C2=A0=C2=A0=C2=A0 __string(new_placement_name,
> > xe_mem_type_to_name[new_placement])
> > +		=C2=A0=C2=A0=C2=A0=C2=A0 __string(old_placement_name,
> > xe_mem_type_to_name[old_placement])
> > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 __string(device_id, __dev_name_bo(bo))
> > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 __field(bool, move_lacks_source)
> > =C2=A0			),
> > @@ -69,15 +69,15 @@ TRACE_EVENT(xe_bo_move,
> > =C2=A0	=C2=A0=C2=A0=C2=A0 TP_fast_assign(
> > =C2=A0		=C2=A0=C2=A0 __entry->bo=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D bo;
> > =C2=A0		=C2=A0=C2=A0 __entry->size =3D bo->size;
> > -		=C2=A0=C2=A0 __entry->new_placement =3D new_placement;
> > -		=C2=A0=C2=A0 __entry->old_placement =3D old_placement;
> > +		=C2=A0=C2=A0 __assign_str(new_placement_name);
> > +		=C2=A0=C2=A0 __assign_str(old_placement_name);
> > =C2=A0		=C2=A0=C2=A0 __assign_str(device_id);
> > =C2=A0		=C2=A0=C2=A0 __entry->move_lacks_source =3D move_lacks_source;
> > =C2=A0		=C2=A0=C2=A0 ),
> > =C2=A0	=C2=A0=C2=A0=C2=A0 TP_printk("move_lacks_source:%s, migrate obje=
ct %p
> > [size %zu] from %s to %s device_id:%s",
> > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __entry->move_lacks_source ? "ye=
s" : "no",
> > __entry->bo, __entry->size,
> > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xe_mem_type_to_name[__entry->old_plac=
ement],
> > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xe_mem_type_to_name[__entry->new_plac=
ement],
> > __get_str(device_id))
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __get_str(old_placement_name),
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __get_str(new_placement_name),
> > __get_str(device_id))
> > =C2=A0);
> > =C2=A0
> > =C2=A0DECLARE_EVENT_CLASS(xe_vma,
> > --=20
> > 2.47.1
> >=20
> >=20


