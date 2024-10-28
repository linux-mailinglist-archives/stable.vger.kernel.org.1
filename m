Return-Path: <stable+bounces-89125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 245A79B3C31
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 21:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06AD1F22E3D
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 20:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823AE1C3F10;
	Mon, 28 Oct 2024 20:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V43vdsh0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DECC18D649
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 20:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148503; cv=none; b=HAy2+sDC48NY/Veds/1mgPTLgOH5g+dYNHHjkir+SHbC62brozWbHTFN8yWkRWCcY4Y8C2vN/GKupzmQTTB1i2wXcGKnJj6vRDKWESJ7OgOGH4ygmgMevTlROz1KFiqAcunlbAx2A4sxhR6jEUlemsm/YmbGzhA6cCjMMgU4y/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148503; c=relaxed/simple;
	bh=CkIRX3wmYSaNoKY/yhPAoKoNW1IhYZDETk6DjnorKVs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkjgRL2wai0rAszpTwPj6CoDTQxXZhB6BGDLGI2cO89xUXsn6DuPRZ5vFQJRW/XKZw6XbLtcLVUt84Ngw31P4dBCUIZXBtTVXRHXhFknKzqbFZDjBccZrCeM8HCF97E8V9t+g445mCFJ+DVOhJ0al7LgKTGymrjajN7Hi720BJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V43vdsh0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730148500; x=1761684500;
  h=date:message-id:from:to:cc:subject:in-reply-to:
   references:mime-version;
  bh=CkIRX3wmYSaNoKY/yhPAoKoNW1IhYZDETk6DjnorKVs=;
  b=V43vdsh0wf5939oEBrEUTFbfS7tX7fD24brwk8q3NLlC7ssaI0Bx+Gg3
   B+AfvFQMd67rBFh7K5oJ+WcskVhSTdYrvM9ijH2Olmzbe6ZJEBbhGMRD6
   GeDGYv3lw92A6IMF843esf6FvTXGdhDaJrpczrNFXfPJR86kX/JxiRBoO
   AassDkz0ly+xU8Uh1lS1WFg3/EYiq6Pj/tA2jIA0muh0i6OSXX4s56+r/
   8fI0rnFZE3Qkg8P8ytSNoFKgii2ic9dvkRQ8slWV1CctkdBuFxBSb9Zrp
   bXa1NQDce7PWDEtbxxmPM6Q6cMzeNGwuEIoLcCYSsxs5uFAnSnmX5/064
   Q==;
X-CSE-ConnectionGUID: HAi9tnqaS4Ob5tMHVx2WCw==
X-CSE-MsgGUID: 0unxdY8mSaS5DleXZiXPnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29222453"
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="29222453"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 13:48:18 -0700
X-CSE-ConnectionGUID: FT/atqNETa+72c5574nalA==
X-CSE-MsgGUID: saMWh9kfTb23Ez4mk3MFcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="85687039"
Received: from orsosgc001.jf.intel.com (HELO orsosgc001.intel.com) ([10.165.21.142])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 13:48:17 -0700
Date: Mon, 28 Oct 2024 13:48:17 -0700
Message-ID: <857c9symwe.wl-ashutosh.dixit@intel.com>
From: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
To: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>, intel-xe@lists.freedesktop.org,
 saurabhg.gupta@intel.com, alex.zuo@intel.com, john.c.harrison@intel.com,
 stable@vger.kernel.org
Subject: Re: [PATCH v3] drm/xe/xe_guc_ads: save/restore OA registers
In-Reply-To: <Zx/2RYp2HD4gDn0a@orsosgc001>
References: <20241023200716.82624-1-jonathan.cavitt@intel.com>	<854j4wtca7.wl-ashutosh.dixit@intel.com>	<Zx/2RYp2HD4gDn0a@orsosgc001>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?ISO-8859-4?Q?Goj=F2?=) APEL-LB/10.8 EasyPG/1.0.0
 Emacs/28.2 (x86_64-redhat-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII

On Mon, 28 Oct 2024 13:38:29 -0700, Umesh Nerlige Ramappa wrote:
>
> On Mon, Oct 28, 2024 at 09:36:32AM -0700, Dixit, Ashutosh wrote:
> > On Wed, 23 Oct 2024 13:07:15 -0700, Jonathan Cavitt wrote:
> >>
> >
> > Hi Umesh,
> >
> >> @@ -748,6 +754,14 @@ static unsigned int guc_mmio_regset_write(struct xe_guc_ads *ads,
> >>		}
> >>	}
> >>
> >> +	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL0, count++);
> >> +	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL1, count++);
> >> +	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL2, count++);
> >> +	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL3, count++);
> >> +	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL4, count++);
> >> +	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL5, count++);
> >> +	guc_mmio_regset_write_one(ads, regset_map, EU_PERF_CNTL6, count++);
> >
> > I am trying to understand how this works. So these registers are
> > saved/restored by GuC because they are not part of HW context image
>
> correct.
>
> > and that is why GuC needs to do the save/restore?
>
> yes, only if GuC performs an engine reset
>
> > Bspec 46458/56839 do seem to
> > be saying that these registers are context saved/restored? If that is
> > indeed true (though not sure), do they need to be here?
>
> For pre-gen12 they were part of the engine context image, but not from
> gen12 onwards. From gen12, they are in the power context image.
>
> These were added because users were seeing the EuStall and EuActive
> counters zeroed out during OA use case. GuC was doing an engine reset for
> some reason and that was resetting these registers. Once we added it here
> (so GuC would save restore these), the counters had correct values.

Hi Umesh, thanks for the explanation, yes let's just leave these here.

Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>

