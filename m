Return-Path: <stable+bounces-28503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9600881753
	for <lists+stable@lfdr.de>; Wed, 20 Mar 2024 19:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6633D283D04
	for <lists+stable@lfdr.de>; Wed, 20 Mar 2024 18:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A61762FA;
	Wed, 20 Mar 2024 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WTN+vqMP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD1D75809
	for <stable@vger.kernel.org>; Wed, 20 Mar 2024 18:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710959447; cv=none; b=mO9PEJ5Vc8Wxcx1u/qG1y+Ay3J3rSFuOlK8QrEJ3trpWnfnWSVt7uZZ+PgiyUr0V/hpjpPJc2FLIQhqsyCKRpcFENCacNxW2pRN4kJYVgpWjzr1A7MlQkpiUrcEOVfpmB936M4ZD7Av/uiQj9Prp3LJsYkionEXP+PFnLsZDsN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710959447; c=relaxed/simple;
	bh=pIMvEZlWIVtjNJitQfBbhwqYFC5rypTGNigzi89FX0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLH2XqpjfyoBMHUF7Z9NFrOG4lHP1sbyeudTZdf/gpidbygV2FwmNinRalQzAK6/B7pJ8R8UOehgacO1ugsSea6HxWwK2de3d/NxkWjsiFl43vO5GE4ZoOys/ObONmZmlyoYzgMSzgdWx6p9563rSxH4yl21ipIiJu8vA76fr9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WTN+vqMP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710959446; x=1742495446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pIMvEZlWIVtjNJitQfBbhwqYFC5rypTGNigzi89FX0w=;
  b=WTN+vqMPzTJM/kWoh0KwasBgygzr2cTheP6jKAuS+ePKwDeZZWa/LNwR
   BxGp7XllMF35Im02i9smL7gip40BELnnHwr4KR6MlaXT8miioaAjNm0kw
   yDTJTkWSENwhf2RekBmllFCYxZUMeEKm7oSy6PPzcHk3q81gCPmfdoYlZ
   wjRK906FkLiTUWZRU/D5zA8TFyd9Kml7ArkQhPP56J99hSBnEQR6eYj2p
   i24lIWfOpUvMTTIUTgdn3sve7me/4EzlbeGe1dhsHPFtLNxSnQLGqsFnT
   MnGwxgmjv0a1MGupRnPpVFIpfzZjp55/bYqPMVnYEUl4J+XbZaAx5eyZ+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5754536"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="5754536"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 11:30:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="14303213"
Received: from unknown (HELO intel.com) ([10.247.118.186])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 11:30:33 -0700
Date: Wed, 20 Mar 2024 19:30:25 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: "Mrozek, Michal" <michal.mrozek@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>,
	Nirmoy Das <nirmoy.das@linux.intel.com>,
	"Landwerlin, Lionel G" <lionel.g.landwerlin@intel.com>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	"Hajda, Andrzej" <andrzej.hajda@intel.com>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	"Das, Nirmoy" <nirmoy.das@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/i915/gt: Report full vm address range
Message-ID: <ZfsrQWNfzDGl8IVV@ashyti-mobl2.lan>
References: <20240313193907.95205-1-andi.shyti@linux.intel.com>
 <46ab1d25-5d16-4610-8b8f-2ee07064ec2e@intel.com>
 <35df0767-384f-49f2-806a-f83765ca7c4c@linux.intel.com>
 <ZfSAo791UDRnBSwc@ashyti-mobl2.lan>
 <BN9PR11MB527575D97CB63C5E4B1B0E7AE72D2@BN9PR11MB5275.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527575D97CB63C5E4B1B0E7AE72D2@BN9PR11MB5275.namprd11.prod.outlook.com>

Hi Michal,

On Mon, Mar 18, 2024 at 05:21:54AM +0000, Mrozek, Michal wrote:
> > > Lionel, Michal, thoughts?
> Compute UMD needs to know exact GTT total size.

the problem is that we cannot apply the workaround without
reserving one page from the GTT total size and we need to apply
the workaround.

If we provide the total GTT size we will have one page that will
be contended between kernel and userspace and, if userspace is
unaware that the page belongs to the kernel, we might step on
each other toe.

The ask here from kernel side is to relax the check on the
maxNBitValue() in userspace and take what the kernel provides.

Thanks,
Andi

