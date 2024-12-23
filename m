Return-Path: <stable+bounces-106006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D809FB383
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 18:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60BA11660BA
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 17:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A751B412B;
	Mon, 23 Dec 2024 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPo3TXVL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33202482ED
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734974021; cv=none; b=UuyM+tXZCZVPQT+L535sVa5kDofd6nt7XVbz/ftk9llCyht2NfNi6f54V59GzOaVbsn2zvwrC8vXgigIf1GQlDggcRdLA2alZKqzY2rmf6wf9lXKd3IooUdtQpGz0WENPeBKR/09sUkFVBlBBpSZKqjaydUjx62+GgT3xO5oDQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734974021; c=relaxed/simple;
	bh=rfMn5DDy9GGLIMWM5TH7f4d7lTYHpUJX7ApgBXlt77w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IDKjC6kA0BlnilzcR+x+8g6wGOEIvxfMw/Iisl4TdBZMzNXe33/qY0utoJvDfSAzUWXwQAeUCr0wmobcynW/WzJm5xf8grFu5Ucwy/QrXzIrjxoiSKswKq3d4FK6Mw6aD2nnqY9dCS5VUjOnv2TN9iwxr/MkvGUX/L1/pDIp/UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MPo3TXVL; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734974020; x=1766510020;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=rfMn5DDy9GGLIMWM5TH7f4d7lTYHpUJX7ApgBXlt77w=;
  b=MPo3TXVL9HXR9R+ngOl7W0CWJKZOufLeawUhlMer2OzrHfo41r13t4rF
   sMrCr4KPC9tvm5DO8VHQawYY5NQDuNWIGllFubSoU8WagQHchrTgWXGOx
   nYLVIxdy/IrRMKsYriCQlv2isM5Mq+plRU+JqduJT7WhYrlufD7i08fmg
   XAgzZU40kXNwDDQyiCKBDiIRkeUBdfg0F4li0O01It+m4776/6vfHSooo
   2FRNjPoUm2lVxEh3sxCrL8sUa70MgFEPtBH0G5qZNrhV3PGvQ6fvpjMoq
   Brrfu6y7By60olltyT6c/S6lTkrUYn2fYxPpePE6GYY0IchTWA7fSmcC+
   Q==;
X-CSE-ConnectionGUID: QK/zIPILSPWiczHFZYBwJQ==
X-CSE-MsgGUID: JtAfqPGNSfm+TU7SHVnQjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="52976057"
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="52976057"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 09:13:39 -0800
X-CSE-ConnectionGUID: ErU3aIsgTACupGvcke+ZvQ==
X-CSE-MsgGUID: zFPSSv5RQly2376ldHEdyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="99778263"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO [10.245.246.74]) ([10.245.246.74])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 09:13:37 -0800
Message-ID: <84d8a4cedd2458eb238bd0b089be4557c174f25b.camel@linux.intel.com>
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
Date: Mon, 23 Dec 2024 18:13:34 +0100
In-Reply-To: <CH0PR11MB54442E6C87C856BFC904880FE5022@CH0PR11MB5444.namprd11.prod.outlook.com>
References: <20241223134250.14345-1-thomas.hellstrom@linux.intel.com>
		 <CH0PR11MB544474672DC3D24C193A12B5E5022@CH0PR11MB5444.namprd11.prod.outlook.com>
	 <0110c37448ee997bbede63911ab1d498d33a4a2f.camel@linux.intel.com>
	 <CH0PR11MB54442E6C87C856BFC904880FE5022@CH0PR11MB5444.namprd11.prod.outlook.com>
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

On Mon, 2024-12-23 at 17:04 +0000, Cavitt, Jonathan wrote:
> -----Original Message-----
> From: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>=20
> Sent: Monday, December 23, 2024 7:57 AM
> To: Cavitt, Jonathan <jonathan.cavitt@intel.com>;
> intel-xe@lists.freedesktop.org
> Cc: Sousa, Gustavo <gustavo.sousa@intel.com>; De Marchi, Lucas
> <lucas.demarchi@intel.com>; Radhakrishna Sripada
> <radhakrishna.sripada@intel.com>; Roper, Matthew D
> <matthew.d.roper@intel.com>; Vivi, Rodrigo <rodrigo.vivi@intel.com>;
> stable@vger.kernel.org
> Subject: Re: [PATCH] drm/xe/tracing: Fix a potential TP_printk UAF
> >=20
> > On Mon, 2024-12-23 at 15:44 +0000, Cavitt, Jonathan wrote:
> > > -----Original Message-----
> > > From: Intel-xe <intel-xe-bounces@lists.freedesktop.org> On Behalf
> > > Of
> > > Thomas Hellstr=C3=B6m
> > > Sent: Monday, December 23, 2024 5:43 AM
> > > To: intel-xe@lists.freedesktop.org
> > > Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>; Sousa,
> > > Gustavo <gustavo.sousa@intel.com>; De Marchi, Lucas
> > > <lucas.demarchi@intel.com>; Radhakrishna Sripada
> > > <radhakrishna.sripada@intel.com>; Roper, Matthew D
> > > <matthew.d.roper@intel.com>; Vivi, Rodrigo
> > > <rodrigo.vivi@intel.com>;
> > > stable@vger.kernel.org
> > > Subject: [PATCH] drm/xe/tracing: Fix a potential TP_printk UAF
> > > >=20
> > > > The commit
> > > > afd2627f727b ("tracing: Check "%s" dereference via the field
> > > > and
> > > > not the TP_printk format")
> > > > exposes potential UAFs in the xe_bo_move trace event.
> > > >=20
> > > > Fix those by avoiding dereferencing the
> > > > xe_mem_type_to_name[] array at TP_printk time.
> > > >=20
> > > > Since some code refactoring has taken place, explicit
> > > > backporting
> > > > may
> > > > be needed for kernels older than 6.10.
> > > >=20
> > > > Fixes: e46d3f813abd ("drm/xe/trace: Extract bo, vm, vma
> > > > traces")
> > > > Cc: Gustavo Sousa <gustavo.sousa@intel.com>
> > > > Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> > > > Cc: Radhakrishna Sripada <radhakrishna.sripada@intel.com>
> > > > Cc: Matt Roper <matthew.d.roper@intel.com>
> > > > Cc: "Thomas Hellstr=C3=B6m" <thomas.hellstrom@linux.intel.com>
> > > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > > Cc: intel-xe@lists.freedesktop.org
> > > > Cc: <stable@vger.kernel.org> # v6.11+
> > > > Signed-off-by: Thomas Hellstr=C3=B6m
> > > > <thomas.hellstrom@linux.intel.com>
> > >=20
> > > I take it we're hitting the WARN_ONCE in ignore_event due to a
> > > test_safe_str failure?
> >=20
> > Actually it's the WARN_ONCE in test_event_printk()
> >=20
> > if (WARN_ON_ONCE(dereference_flags)) {
>=20
> Ah, I see.
>=20
> There's a comment above that WARN_ON_ONCE as well, and it
> more or less recommends the same actions, albeit with less
> specificity.=C2=A0 My RB still stands.

Thanks. I'll push this commit with that R-B to get CI running.

/Thomas


> -Jonathan Cavitt
>=20
> >=20
> >=20
> > > I don't know about us hitting a UAF here, but this fix is exactly
> > > what was recommended
> > > in the comment immediately above the WARN_ONCE that we shouldn't
> > > be
> > > hitting, so
> > > this is probably correct if that's what we're trying to avoid.
> >=20
> > I'll double-check to see if I can easily trigger the UAF.
> >=20
> >=20
> > > Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> >=20
> > Thanks,
> > Thomas
> >=20
> >=20
> > > -Jonathan Cavitt
> > >=20
> > > > ---
> > > > =C2=A0drivers/gpu/drm/xe/xe_trace_bo.h | 12 ++++++------
> > > > =C2=A01 file changed, 6 insertions(+), 6 deletions(-)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/xe/xe_trace_bo.h
> > > > b/drivers/gpu/drm/xe/xe_trace_bo.h
> > > > index 1762dd30ba6d..ea50fee50c7d 100644
> > > > --- a/drivers/gpu/drm/xe/xe_trace_bo.h
> > > > +++ b/drivers/gpu/drm/xe/xe_trace_bo.h
> > > > @@ -60,8 +60,8 @@ TRACE_EVENT(xe_bo_move,
> > > > =C2=A0	=C2=A0=C2=A0=C2=A0 TP_STRUCT__entry(
> > > > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 __field(struct xe_bo *, bo)
> > > > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 __field(size_t, size)
> > > > -		=C2=A0=C2=A0=C2=A0=C2=A0 __field(u32, new_placement)
> > > > -		=C2=A0=C2=A0=C2=A0=C2=A0 __field(u32, old_placement)
> > > > +		=C2=A0=C2=A0=C2=A0=C2=A0 __string(new_placement_name,
> > > > xe_mem_type_to_name[new_placement])
> > > > +		=C2=A0=C2=A0=C2=A0=C2=A0 __string(old_placement_name,
> > > > xe_mem_type_to_name[old_placement])
> > > > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 __string(device_id, __dev_name_bo(=
bo))
> > > > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 __field(bool, move_lacks_source)
> > > > =C2=A0			),
> > > > @@ -69,15 +69,15 @@ TRACE_EVENT(xe_bo_move,
> > > > =C2=A0	=C2=A0=C2=A0=C2=A0 TP_fast_assign(
> > > > =C2=A0		=C2=A0=C2=A0 __entry->bo=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D =
bo;
> > > > =C2=A0		=C2=A0=C2=A0 __entry->size =3D bo->size;
> > > > -		=C2=A0=C2=A0 __entry->new_placement =3D new_placement;
> > > > -		=C2=A0=C2=A0 __entry->old_placement =3D old_placement;
> > > > +		=C2=A0=C2=A0 __assign_str(new_placement_name);
> > > > +		=C2=A0=C2=A0 __assign_str(old_placement_name);
> > > > =C2=A0		=C2=A0=C2=A0 __assign_str(device_id);
> > > > =C2=A0		=C2=A0=C2=A0 __entry->move_lacks_source =3D
> > > > move_lacks_source;
> > > > =C2=A0		=C2=A0=C2=A0 ),
> > > > =C2=A0	=C2=A0=C2=A0=C2=A0 TP_printk("move_lacks_source:%s, migrate =
object %p
> > > > [size %zu] from %s to %s device_id:%s",
> > > > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __entry->move_lacks_source ?=
 "yes" :
> > > > "no",
> > > > __entry->bo, __entry->size,
> > > > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xe_mem_type_to_name[__entry-
> > > > >old_placement],
> > > > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xe_mem_type_to_name[__entry-
> > > > >new_placement],
> > > > __get_str(device_id))
> > > > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __get_str(old_placement_name),
> > > > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __get_str(new_placement_name),
> > > > __get_str(device_id))
> > > > =C2=A0);
> > > > =C2=A0
> > > > =C2=A0DECLARE_EVENT_CLASS(xe_vma,
> > > > --=20
> > > > 2.47.1
> > > >=20
> > > >=20
> >=20
> >=20


