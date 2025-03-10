Return-Path: <stable+bounces-121737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1681DA59BE9
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84DC17A20E6
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A1619004A;
	Mon, 10 Mar 2025 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jmhOPGbP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5742A22B8D0;
	Mon, 10 Mar 2025 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626200; cv=none; b=h6Zv4lRpULscizaEC9LDnPzMZK+c/XzNl7tgwNyx3UyGF64YjjrLBve/g5A4RlCHxDUU9sf6jGJgCsGCFVHzIEtK0w4hXs/MbRckxrDz8Q1OUBSxpS+/em+MjdhXPhqj15RQzSJlyd+UGtAgPVPKbRlDnZconbBCkTFdI2T5T7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626200; c=relaxed/simple;
	bh=KVBDjGmEnzP91ukJECdVl5bL4hUaB3pVLGOFW7Hh0nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c87eza5cGzEZRWaeEZgRTr7mRsHB0QHP2+3gES8GXGTEy29lFhp9DUcws2tI6z6rK2m3r2qhaL2uz9G+PXmuOn5ICBZuAuBAtTDmSmk8A+blsw1ElaWJfBmct+WedNYQKmSJyoRWpb69wrP5ElV36shB/dll05gMZrRWPHCus1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jmhOPGbP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741626199; x=1773162199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KVBDjGmEnzP91ukJECdVl5bL4hUaB3pVLGOFW7Hh0nY=;
  b=jmhOPGbPkFeCYYLet/h3s2ymS+8rRrAM1G3QZTZcvYNQGrU1HqLicIoE
   fRN6WIPG3NAPeSJePHPWaBp8q9weZ3TqfLjyJjS3AfIz9XAmY+D70cz+r
   ytL1+5u3UsoTrdUU6wHwoQ27UlXh1k4SITz9pPd5ahVU3Zj0vABB35+m9
   SzCGyxmvt6hb4NY0xhm/XiZY0ddsAiLmiQej/wyDmsArb1TgnJMYl7v7U
   f8OGQGKdgb6hXlMxzKYdSkSaWY9NODHS2MHmbJKIDDbwo91cW6N6olbwK
   2vV7wRRo2Vmup/VetoOj3ZOejdOnl6UoLHbeAqvOrlT2CXk+Nx3jVlhjS
   A==;
X-CSE-ConnectionGUID: tHe3RDS4Q8mKA5L2d3VjGA==
X-CSE-MsgGUID: fn+9s7lZS6u0/ImdDD+2Mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="52841285"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="52841285"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 10:03:19 -0700
X-CSE-ConnectionGUID: VqCGhDnoS+Ok/RBNjU2PhA==
X-CSE-MsgGUID: p7MR6dQGRBKGgJu88W7NHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="125272989"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orviesa005.jf.intel.com with SMTP; 10 Mar 2025 10:03:13 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 10 Mar 2025 19:03:12 +0200
Date: Mon, 10 Mar 2025 19:03:12 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: Patch "drm/i915: Plumb 'dsb' all way to the plane hooks" has
 been added to the 6.12-stable tree
Message-ID: <Z88bUBl1qOMB0QTy@intel.com>
References: <20250309194558.4190633-1-sashal@kernel.org>
 <Z88LWG1_AeNb7Hch@intel.com>
 <2025031047-reformist-faster-c3c6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025031047-reformist-faster-c3c6@gregkh>
X-Patchwork-Hint: comment

On Mon, Mar 10, 2025 at 05:35:06PM +0100, Greg KH wrote:
> On Mon, Mar 10, 2025 at 05:55:04PM +0200, Ville Syrjälä wrote:
> > On Sun, Mar 09, 2025 at 03:45:57PM -0400, Sasha Levin wrote:
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >     drm/i915: Plumb 'dsb' all way to the plane hooks
> > > 
> > > to the 6.12-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > 
> > > The filename of the patch is:
> > >      drm-i915-plumb-dsb-all-way-to-the-plane-hooks.patch
> > > and it can be found in the queue-6.12 subdirectory.
> > > 
> > > If you, or anyone else, feels it should not be added to the stable tree,
> > > please let <stable@vger.kernel.org> know about it.
> > > 
> > > 
> > > 
> > > commit f03e7cca22f4bb50cae98840f91fcf1e6d780a54
> > > Author: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > Date:   Mon Sep 30 20:04:13 2024 +0300
> > > 
> > >     drm/i915: Plumb 'dsb' all way to the plane hooks
> > >     
> > >     [ Upstream commit 01389846f7d61d262cc92d42ad4d1a25730e3eff ]
> > 
> > It would help if you actually mentioned *why* you need to backport this?
> 
> If you read further in the patch it says:
> 	Stable-dep-of: 30bfc151f0c1 ("drm/xe: Remove double pageflip")
> 
> which is the reason.

Ah, didn't look hard enough. Thanks.

OK, seems fine by me.

-- 
Ville Syrjälä
Intel

