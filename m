Return-Path: <stable+bounces-20508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E6D85A108
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 11:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C62B6B2096A
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 10:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0632134A;
	Mon, 19 Feb 2024 10:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LYCD5r/s"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF5DE545
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708338724; cv=none; b=oclEsxnJpanJzs4LsB6nywAAiOstv1Hw/oq4OdD38iEM3bGa0B5zXx4hH8edk3PdHlR5/94DvZ+ST6X5Ehoz4dpuUBNeIWEuViM/JKNdGAdaLQn3OzcqISoEuto4v+YfDhS3AhgUZGuiGVAqnxtr9La2jkcgTcMWQKtJ0s+HXDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708338724; c=relaxed/simple;
	bh=EMBRqBRFw8T7hhFbe2NlzLlqJGZE8btg4vYfiNAbfnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZtnvDnkYBBIlohwyDykZYq6v5tEyl1NU8OhSSwYN4dEtY76d0EzC94LAZB6d6LWImbO+OCLK7cwEKUgRhcvy7ooNILxJ/wbvHEND4LWdunTyGkuX9nbV8OgdTM+SymX8tPaCPSq6UTaGswHluKszRkwOq7YB1fXSzZwyBooeQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LYCD5r/s; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708338723; x=1739874723;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EMBRqBRFw8T7hhFbe2NlzLlqJGZE8btg4vYfiNAbfnk=;
  b=LYCD5r/siOJ/0Ym4nvgeuL5fTizzafofQ+Rq+KePvtyoykSX1+u/oYCE
   jde319A29XoYNBO21Imy7NrJ2KY8NfmkuqliGYaV4QMssvMFITFRCX7ys
   1imKXTAhHCvTKzPBOeH/TtFqq30jvLrjKw2e7KrYg1SjVRh3Ke2BohO42
   bdJzxiQYhW/zjByUtBGu5ocAShQ9fkQZ3Tbh3aIM7/4ihT08/SpmBJmNR
   7iLzS+Nbb+b0CzR2j54bKTiiLb2QbaKLtPZaBk3NIAAM77PE3gg3oI4M0
   mzSwHmxchlWvTuPX3WhTU2GbNjVbu86NcNjxy5RcoIaH61ZnlGsQU+JTN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2273793"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2273793"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 02:32:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4709503"
Received: from samathah-mobl1.ger.corp.intel.com (HELO intel.com) ([10.246.48.149])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 02:32:00 -0800
Date: Mon, 19 Feb 2024 11:31:57 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	stable@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH 1/2] drm/i915/gt: Disable HW load balancing for CCS
Message-ID: <ZdMuHeyV9NoVzRTi@ashyti-mobl2.lan>
References: <20240215135924.51705-1-andi.shyti@linux.intel.com>
 <20240215135924.51705-2-andi.shyti@linux.intel.com>
 <20240215165541.GJ718896@mdroper-desk1.amr.corp.intel.com>
 <ZdMquCAXtNdbJHbW@ashyti-mobl2.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdMquCAXtNdbJHbW@ashyti-mobl2.lan>

On Mon, Feb 19, 2024 at 11:17:33AM +0100, Andi Shyti wrote:
> On Thu, Feb 15, 2024 at 08:55:41AM -0800, Matt Roper wrote:
> > On Thu, Feb 15, 2024 at 02:59:23PM +0100, Andi Shyti wrote:
> > > The hardware should not dynamically balance the load between CCS
> > > engines. Wa_16016805146 recommends disabling it across all
> > 
> > Is this the right workaround number?  When I check the database, this
> > workaround was rejected on both DG2-G10 and DG2-G11, and doesn't even
> > have an entry for DG2-G12.
> > 
> > There are other workarounds that sound somewhat related to load
> > balancing (e.g., part 3 of Wa_14019159160), but what's asked there is
> > more involved than just setting one register bit and conflicts a bit
> > with the second patch of this series.
> 
> thanks for checking it. Indeed the WA I mentioned is limited to
> a specific platform. This recommendation comes in different WA,
> e.g. this one: Wa_14019186972 (3rd point). Will start using that
> as a reference.

actually you are right, I checked with Joonas and I will use
Wa_14019159160.

Thanks,
Andi

