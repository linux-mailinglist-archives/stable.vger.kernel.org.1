Return-Path: <stable+bounces-59373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EC6931D12
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 00:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405B51F22455
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 22:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAAB13CFA5;
	Mon, 15 Jul 2024 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ho0RaTE3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC61861FFA
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 22:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721081673; cv=none; b=kf7b6lAyjxUHkC0TpQlQW74rV4VHo+lmQvBJWbJfKsd16N8JsjIj8cbYW83zyCSPrnWOipAeTMioTyT+mY4RjKEt9xsZb/5U5w+I7vEALVT5mL8ZpZVTfAOQLQc1mSdFaiuJ5hwrhMYqAJznyUfspvNMuUZSlD4be2QaTUkcjTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721081673; c=relaxed/simple;
	bh=LjFADk2GYzrpE1gXp7BUKGW0BwefJlJqWxKDFlPQjzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOyLgIH9fZorBUVl25wFLw+J490B1if5Qxh1c5Ac6Jzt8HTQDzKh8Q39xe4v16KTslQ1JODyrlckhwhVnAzUKy/9fVk1mGWiTIS9xjlfCZZFlJsWPc7W5W+K4kjyC2faNu/odVd4u2q9IZnPvz/g2VrDP7EnC4UAm+27a9MKgxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ho0RaTE3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721081672; x=1752617672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LjFADk2GYzrpE1gXp7BUKGW0BwefJlJqWxKDFlPQjzk=;
  b=ho0RaTE39WDKSR78Pxn7ZbecKUdOx439KgvpwyxzK3uUEku6h6p8BrNX
   o5G/omfpO26Go7DkpcRHWedsv4QC8R4QJUEe8WxRdGQfdeyjohsImgolO
   oMWVv4basxI5mfCsIlJ0PM99UafvjCRFB77OdnC7kYfmB4c/yc03CapU+
   9uWpEWF83Y/tVc4kR8JH451Km0rqydHU8PTnSREURS725IxqwtELa029a
   4gFDi2mGLOJPzdN/ZLlj4EuA8nj6bYfO0F24YW3L3T+S4Pf4m+vIaydOZ
   d2epH8VXejxkiBm3nkq0X4H5a+q0fT5NG7otQmZGwShJHuGHjUsJUkcNk
   w==;
X-CSE-ConnectionGUID: R+PEpE8DTkijS6EjbqcCxw==
X-CSE-MsgGUID: ISiZ1juXT5CFHydCuo0yGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18683019"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18683019"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 15:14:30 -0700
X-CSE-ConnectionGUID: m6oXyLm8SbmDGBaxUvD9Mw==
X-CSE-MsgGUID: wDv5TPuoT3y2oH6Ha1LACQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="54030544"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO intel.com) ([10.245.246.155])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 15:14:27 -0700
Date: Tue, 16 Jul 2024 00:14:22 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: "Gote, Nitin R" <nitin.r.gote@intel.com>
Cc: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	"Cavitt, Jonathan" <jonathan.cavitt@intel.com>,
	"Wilson, Chris P" <chris.p.wilson@intel.com>,
	"tursulin@ursulin.net" <tursulin@ursulin.net>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"Das, Nirmoy" <nirmoy.das@intel.com>,
	"janusz.krzysztofik@linux.intel.com" <janusz.krzysztofik@linux.intel.com>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] drm/i915/gt: Do not consider preemption during
 execlists_dequeue for gen8
Message-ID: <ZpWfPjVificBZgBD@ashyti-mobl2.lan>
References: <20240711163208.1355736-1-nitin.r.gote@intel.com>
 <CH0PR11MB54443CBE8B4A052419FFFD1BE5A52@CH0PR11MB5444.namprd11.prod.outlook.com>
 <ZpAfyzKlqlMrd4nj@intel.com>
 <SJ0PR11MB586743B1AF7DABD0F131E906D0A62@SJ0PR11MB5867.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB586743B1AF7DABD0F131E906D0A62@SJ0PR11MB5867.namprd11.prod.outlook.com>

Hi,

On Fri, Jul 12, 2024 at 03:25:23PM +0200, Gote, Nitin R wrote:
> > -----Original Message-----
> > From: Vivi, Rodrigo <rodrigo.vivi@intel.com>
> > Sent: Thursday, July 11, 2024 11:39 PM
> > To: Cavitt, Jonathan <jonathan.cavitt@intel.com>
> > Cc: Gote, Nitin R <nitin.r.gote@intel.com>; Wilson, Chris P
> > <chris.p.wilson@intel.com>; tursulin@ursulin.net; intel-
> > gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; Shyti, Andi
> > <andi.shyti@intel.com>; Das, Nirmoy <nirmoy.das@intel.com>;
> > janusz.krzysztofik@linux.intel.com; Chris Wilson
> > <chris.p.wilson@linux.intel.com>; stable@vger.kernel.org
> > Subject: Re: [PATCH v3] drm/i915/gt: Do not consider preemption during
> > execlists_dequeue for gen8
> > 
> > On Thu, Jul 11, 2024 at 04:28:53PM +0000, Cavitt, Jonathan wrote:
> > > -----Original Message-----
> > > From: Intel-gfx <intel-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > > Nitin Gote
> > > Sent: Thursday, July 11, 2024 9:32 AM
> > > To: Wilson, Chris P <chris.p.wilson@intel.com>; tursulin@ursulin.net;
> > > intel-gfx@lists.freedesktop.org
> > > Cc: dri-devel@lists.freedesktop.org; Shyti, Andi
> > > <andi.shyti@intel.com>; Das, Nirmoy <nirmoy.das@intel.com>;
> > > janusz.krzysztofik@linux.intel.com; Gote, Nitin R
> > > <nitin.r.gote@intel.com>; Chris Wilson
> > > <chris.p.wilson@linux.intel.com>; stable@vger.kernel.org
> > > Subject: [PATCH v3] drm/i915/gt: Do not consider preemption during
> > > execlists_dequeue for gen8
> > > >
> > > > We're seeing a GPU HANG issue on a CHV platform, which was caused by
> > > > bac24f59f454 ("drm/i915/execlists: Enable coarse preemption boundaries
> > for gen8").
> > > >
> > > > Gen8 platform has only timeslice and doesn't support a preemption
> > > > mechanism as engines do not have a preemption timer and doesn't send
> > > > an irq if the preemption timeout expires.
> > >
> > > That seems to mean the original can_preempt function was inaccurately
> > > built, so fixing it here makes the most sense to me, especially if it's causing
> > problems.
> > >
> > > Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com> -Jonathan
> > > Cavitt
> > >
> > > > So, add a fix to not consider preemption during dequeuing for gen8
> > > > platforms.
> > > >
> > > > v2: Simplify can_preempt() function (Tvrtko Ursulin)
> > > >
> > > > v3:
> > > >  - Inside need_preempt(), condition of can_preempt() is not required
> > > >    as simplified can_preempt() is enough. (Chris Wilson)
> > > >
> > > > Fixes: bac24f59f454 ("drm/i915/execlists: Enable coarse preemption
> > > > boundaries for gen8")
> > 
> > Something strange in here...
> > 
> > This patch is not using directly or indirectly (I915_ENGINE_HAS_PREEMPTION)
> > the can_preempt()...
> >
> 
> Thank you Rodrigo for the review comment. Seems like you are right.
> Fixes: bac24f59f454 is misleading as it's not using can_preempt(). 
> The bug could be from the commit bac24f59f454 as mentioned in the issue
> But this change fixes the original implementation of can_preempt()  in below commit.
> Fixes: 751f82b353a6 ("drm/i915/gt: Only disable preemption on gen8 render engines").
> 
> I will update the Fixes in the commit description and will send in v4.

Can I reword the commit log to something similar:

    drm/i915/gt: Do not consider preemption during execlists_dequeue for gen8

    We're seeing a GPU hang issue on a CHV platform, which was caused by commit
    bac24f59f454 ("drm/i915/execlists: Enable coarse preemption boundaries for
    Gen8").

    The Gen8 platform only supports timeslicing and doesn't have a preemption
    mechanism, as its engines do not have a preemption timer.

    Commit 751f82b353a6 ("drm/i915/gt: Only disable preemption on Gen8 render
    engines") addressed this issue only for render engines. This patch extends
    that fix by ensuring that preemption is not considered for all engines on
    Gen8 platforms.

    v4:
     - Use the correct Fixes tag (Rodrigo Vivi)
     - Reworded commit log (Andi Shyti)

    v3:
     - Inside need_preempt(), condition of can_preempt() is not required
       as simplified can_preempt() is enough. (Chris Wilson)

    v2: Simplify can_preempt() function (Tvrtko Ursulin)

Andi

