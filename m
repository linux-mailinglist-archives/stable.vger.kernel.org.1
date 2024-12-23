Return-Path: <stable+bounces-106004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FF99FB301
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 17:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6517B188167B
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFA71CDA14;
	Mon, 23 Dec 2024 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UXTmWYzH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34CA1C07F1
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734971632; cv=none; b=jv6oJYY3IUOU4YvGXrskF4KlVku1BGNnpPRNtINaPYQxLK6US9yrHxdfeK1tylijH+EtP1e6qS+Wj6l6yiHa1gdkvcOuPXHqHqAsLKsmruNP2hIgTUCo3KNGa1smAVgG9/Xu1MB5qKEOz2PumktK+7hYCzlqFiVYIhXTjLNbMFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734971632; c=relaxed/simple;
	bh=ZIcsL7AGZJifD57eK8fhfLM3OZTlY2KCEo3ChY0Pwoo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CUhKjR1eRBWsWcwICx/knTKl7Ru6KN1kaDpCTRlngRZlz3l+7dx13hO+sl9erTr8hTyO67S4K+R1oRSERfaAytbux2TJWYn00Aof8RyoDB36M1j776ZD1iqxAoYoPePexJRRZzZkrwLA2d8Zevx6AftN56MS0Nlxmvid1ny0lXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UXTmWYzH; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734971631; x=1766507631;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ZIcsL7AGZJifD57eK8fhfLM3OZTlY2KCEo3ChY0Pwoo=;
  b=UXTmWYzHw9Nd5eRNj7AX2I8/sfBljz/lcHETUOKFoa/rLLGzZbNtT6m2
   0ryb6xYYCfUtiwU51z1p5betYxITLdIufTPXdA0NCh12ltDQxoRluZuJL
   Mu5KVGJT5QtIvxf9TcM1vgHv1o4PuT5taA1eGKR212VO1iZRoNBuzwGiJ
   5fnpdgnpKLbQr2xT20DElqne2gl1rL1FVyBvjt255aBzWHQEICMtEc2Jv
   Rs/pdq613xNNbOCkx0JFfHBRnVOfEYY0882Dgqn6P6sPv9nyw4aUx11qA
   xE8w0uY1oPmEbyW1RDdveDXsOUunORS5lNOdSgptE+tjdR3JSyVA4bNAo
   A==;
X-CSE-ConnectionGUID: RXVSnUxNTsaIqQ23lRt3ig==
X-CSE-MsgGUID: W+0ZRVNAQGGQt1k8TFgprQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="46859716"
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="46859716"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 08:33:15 -0800
X-CSE-ConnectionGUID: OrqpFpc/QF611qQiBimLHg==
X-CSE-MsgGUID: 2SVhe9crTpurIbpsclqYDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122516638"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO [10.245.246.74]) ([10.245.246.74])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 08:33:13 -0800
Message-ID: <de948e6d024abe0bbd5ac30087471c02dff0dc09.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe/tracing: Fix a potential TP_printk UAF
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, Gustavo Sousa <gustavo.sousa@intel.com>,
  Lucas De Marchi <lucas.demarchi@intel.com>, Radhakrishna Sripada
 <radhakrishna.sripada@intel.com>, Matt Roper	 <matthew.d.roper@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 	stable@vger.kernel.org
Date: Mon, 23 Dec 2024 17:33:10 +0100
In-Reply-To: <Z2mFePfn73Fugmrf@lstrano-desk.jf.intel.com>
References: <20241223134250.14345-1-thomas.hellstrom@linux.intel.com>
	 <Z2mFePfn73Fugmrf@lstrano-desk.jf.intel.com>
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

On Mon, 2024-12-23 at 07:44 -0800, Matthew Brost wrote:
> On Mon, Dec 23, 2024 at 02:42:50PM +0100, Thomas Hellstr=C3=B6m wrote:
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
>=20
> So is this the UAF? i.e., The Xe module unloads and
> xe_mem_type_to_name
> is gone?

I would imagine that's the intention of the warning. However removing
the xe_module seems to empty the trace buffer of xe_bo_move events.
Whether there is a race in that process or whether the TP_printk check
can't distinguish between module local addresses and other addresses is
hard to tell. In any case, it looks like we need to comply with the
warning here (I suspect CI refuses to run otherwise), and since it only
appears to trigger on the xe module load on my system, it's unlikely
that mentioned commit will be reverted.


>=20
> I noticed that xe_mem_type_to_name is not static, it likely should
> be.
> Would that help here?

No, doesn't help unfortunately.

/Thomas



>=20
> Matt
>=20
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __get_str(old_placement_name),
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __get_str(new_placement_name),
> > __get_str(device_id))
> > =C2=A0);
> > =C2=A0
> > =C2=A0DECLARE_EVENT_CLASS(xe_vma,
> > --=20
> > 2.47.1
> >=20


