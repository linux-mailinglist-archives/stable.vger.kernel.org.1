Return-Path: <stable+bounces-106629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0323B9FF426
	for <lists+stable@lfdr.de>; Wed,  1 Jan 2025 14:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D1807A1273
	for <lists+stable@lfdr.de>; Wed,  1 Jan 2025 13:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1331E0DDF;
	Wed,  1 Jan 2025 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j/CHf/7L"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64D313CA9C
	for <stable@vger.kernel.org>; Wed,  1 Jan 2025 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735737957; cv=none; b=gPXNjUuIQNr7+l9zQmYEBNR5w3vA3GMvd5LP8MmJe+W5Y3h4aHIW8vGjHVa6hQnTRu62u7uXYGGGlNBQeiWPFMGcv1Ccw+jQAq7KKulppndb1I6Wa/u9boFWFLTj25x+yu45YT+OEMC6PQZucJRD2I2XXDtkWkmuuHlRTfRLfKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735737957; c=relaxed/simple;
	bh=O4XVS9kqxmNdfEkA47hUPyNcKcEqoQ9n16YYjiKIE8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/rDB2ER11wnMwKCj19TVGBUMn2wu0RsU4u39vuwKSPLcTkw7HJ5CHDEEXxN3GR+JI8/Qs+IC5rMybwVGqlgHA3rc0oiBvldccHOLdVI8yKFdX/3/Lc1f1g59PEz+QGjKrOiKa3xFOeQT88MAgd8UvWpZvAK5uc9yrO0qVSOtVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j/CHf/7L; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735737954; x=1767273954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=O4XVS9kqxmNdfEkA47hUPyNcKcEqoQ9n16YYjiKIE8o=;
  b=j/CHf/7LDmECKuAppmW1Ny0+WfGBFCxgkjMZEKsqPmg/QmI+5v82Ywa1
   WWcchyDL+TPPSIV3n1kCBfs5v1lv/1APJSEZyrLzh/hu+/s/oxu/kl8t7
   oclvF/GRw5za5UibgM2L+wfip3rTyxh7xgPSKV0R2u3IJxyKmHMCS6Bb4
   2HD077lZUEuvnlqkAqXZlL9XnFIORfiABXaEcz3ZwNaP2un6eEtlI1jkk
   NSJ8+arRmBJP2ZA2S34MzaC/UTxmuCz6jRaVxrvdU7Br5JIu3xMKCNgEC
   05oMFD0VF/Ll++cye12DxsVk8eSzovckDRXMcpXci963aRIA5KS2kwgXy
   g==;
X-CSE-ConnectionGUID: Sfa4DuskR+C2V44/b9fIKw==
X-CSE-MsgGUID: AJmgzQtjTHG6l3mEZzEriA==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="35875939"
X-IronPort-AV: E=Sophos;i="6.12,282,1728975600"; 
   d="scan'208";a="35875939"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2025 05:25:54 -0800
X-CSE-ConnectionGUID: OqSxrWGqRAWs3rkpxyH7rA==
X-CSE-MsgGUID: 4aOUv3tcRk+eB79+eR/HBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102116782"
Received: from ldmartin-desk2.corp.intel.com (HELO ldmartin-desk2) ([10.125.109.191])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2025 05:25:54 -0800
Date: Wed, 1 Jan 2025 07:25:48 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>, 
	intel-xe@lists.freedesktop.org, Gustavo Sousa <gustavo.sousa@intel.com>, 
	Radhakrishna Sripada <radhakrishna.sripada@intel.com>, Matt Roper <matthew.d.roper@intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/xe/tracing: Fix a potential TP_printk UAF
Message-ID: <niinok4526kq3m4ethzcesfbd62jdd5x43yjefpdtarxa4xakq@scwsd6ukojph>
References: <20241223134250.14345-1-thomas.hellstrom@linux.intel.com>
 <Z2mFePfn73Fugmrf@lstrano-desk.jf.intel.com>
 <de948e6d024abe0bbd5ac30087471c02dff0dc09.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de948e6d024abe0bbd5ac30087471c02dff0dc09.camel@linux.intel.com>

On Mon, Dec 23, 2024 at 05:33:10PM +0100, Thomas Hellström wrote:
>On Mon, 2024-12-23 at 07:44 -0800, Matthew Brost wrote:
>> On Mon, Dec 23, 2024 at 02:42:50PM +0100, Thomas Hellström wrote:
>> > The commit
>> > afd2627f727b ("tracing: Check "%s" dereference via the field and
>> > not the TP_printk format")
>> > exposes potential UAFs in the xe_bo_move trace event.
>> >
>> > Fix those by avoiding dereferencing the
>> > xe_mem_type_to_name[] array at TP_printk time.
>> >
>> > Since some code refactoring has taken place, explicit backporting
>> > may
>> > be needed for kernels older than 6.10.
>> >
>> > Fixes: e46d3f813abd ("drm/xe/trace: Extract bo, vm, vma traces")
>> > Cc: Gustavo Sousa <gustavo.sousa@intel.com>
>> > Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>> > Cc: Radhakrishna Sripada <radhakrishna.sripada@intel.com>
>> > Cc: Matt Roper <matthew.d.roper@intel.com>
>> > Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
>> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> > Cc: intel-xe@lists.freedesktop.org
>> > Cc: <stable@vger.kernel.org> # v6.11+
>> > Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> > ---
>> >  drivers/gpu/drm/xe/xe_trace_bo.h | 12 ++++++------
>> >  1 file changed, 6 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/xe/xe_trace_bo.h
>> > b/drivers/gpu/drm/xe/xe_trace_bo.h
>> > index 1762dd30ba6d..ea50fee50c7d 100644
>> > --- a/drivers/gpu/drm/xe/xe_trace_bo.h
>> > +++ b/drivers/gpu/drm/xe/xe_trace_bo.h
>> > @@ -60,8 +60,8 @@ TRACE_EVENT(xe_bo_move,
>> >  	    TP_STRUCT__entry(
>> >  		     __field(struct xe_bo *, bo)
>> >  		     __field(size_t, size)
>> > -		     __field(u32, new_placement)
>> > -		     __field(u32, old_placement)
>> > +		     __string(new_placement_name,
>> > xe_mem_type_to_name[new_placement])
>> > +		     __string(old_placement_name,
>> > xe_mem_type_to_name[old_placement])
>> >  		     __string(device_id, __dev_name_bo(bo))
>> >  		     __field(bool, move_lacks_source)
>> >  			),
>> > @@ -69,15 +69,15 @@ TRACE_EVENT(xe_bo_move,
>> >  	    TP_fast_assign(
>> >  		   __entry->bo      = bo;
>> >  		   __entry->size = bo->size;
>> > -		   __entry->new_placement = new_placement;
>> > -		   __entry->old_placement = old_placement;
>> > +		   __assign_str(new_placement_name);
>> > +		   __assign_str(old_placement_name);
>> >  		   __assign_str(device_id);
>> >  		   __entry->move_lacks_source = move_lacks_source;
>> >  		   ),
>> >  	    TP_printk("move_lacks_source:%s, migrate object %p
>> > [size %zu] from %s to %s device_id:%s",
>> >  		      __entry->move_lacks_source ? "yes" : "no",
>> > __entry->bo, __entry->size,
>> > -		      xe_mem_type_to_name[__entry->old_placement],
>> > -		      xe_mem_type_to_name[__entry->new_placement],
>> > __get_str(device_id))
>>
>> So is this the UAF? i.e., The Xe module unloads and
>> xe_mem_type_to_name
>> is gone?
>
>I would imagine that's the intention of the warning. However removing
>the xe_module seems to empty the trace buffer of xe_bo_move events.
>Whether there is a race in that process or whether the TP_printk check
>can't distinguish between module local addresses and other addresses is
>hard to tell. In any case, it looks like we need to comply with the
>warning here (I suspect CI refuses to run otherwise), and since it only
>appears to trigger on the xe module load on my system, it's unlikely
>that mentioned commit will be reverted.

it's actually a false positive from afd2627f727b. See explanation
by Steve at https://lore.kernel.org/all/20241230141329.5f698715@batman.local.home/
the fix later on

Lucas De Marchi


>
>
>>
>> I noticed that xe_mem_type_to_name is not static, it likely should
>> be.
>> Would that help here?
>
>No, doesn't help unfortunately.
>
>/Thomas
>
>
>
>>
>> Matt
>>
>> > +		      __get_str(old_placement_name),
>> > +		      __get_str(new_placement_name),
>> > __get_str(device_id))
>> >  );
>> >  
>> >  DECLARE_EVENT_CLASS(xe_vma,
>> > --
>> > 2.47.1
>> >
>

