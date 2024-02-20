Return-Path: <stable+bounces-20818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204B685BEB2
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 15:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5637B245BB
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 14:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3496BB20;
	Tue, 20 Feb 2024 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ElilJcPm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D906A034
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708439046; cv=none; b=ZWejzl9ojOk8YBJQn8xZKJ3WTw9KelbpSiUK/o5kY4xp3qtArRJZc+0bVvfzJMrMPHpGHppgyRbIvwK1vJb6TFZKZz+JJViUlbOSAq6jHFYZhyem+95zFa9O9UwIaUfoVBXKG4I/x0I05gwo3WN8fYkASPzyrVQw4QNKZ456FH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708439046; c=relaxed/simple;
	bh=W9VQKihaZMC7U1Rw/MLDCDASL2zahkiIpd5gl7fzUOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMHk/eftcz6lIIis9ySoZvHpoU6hmdMq4tcRkNW5HRu9QErTLYggrbnpm8xzDyf7ysT+XeiXrmbnZadotRrCbqlCgCr/9qF48jTwkpM2MYYQjvgK+WhENPZqS043k7l/3OTtzIEZhx+kmYun+wNB3nbrqxi+/mDx83jl1l2CGuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ElilJcPm; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708439044; x=1739975044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W9VQKihaZMC7U1Rw/MLDCDASL2zahkiIpd5gl7fzUOw=;
  b=ElilJcPmqPth0tOpwlxvaNo88JbU3iYbYc5K32n+efO0BDMusBfQKIe4
   xYatmHX1l9ATS7YJVwjxdTfB9LD/teqKsJIlMEoW7WUwGGNtk/9vZn45h
   ShUF+S7KIeDgEOP8b3osbQVM/WsgfOF9RhXBk5DiLToGKZc0jtr20BPUt
   io+DgNCuN7/lVkJLx1UVsi624n/7Zl0ixlIAtqAdnGLrQzorV1HrlGRt5
   WUpJPsS+DB6sEnr1WNNNdbEgCE2DpLQvh0P7n2ZcfttZVVyf1trvQFRmk
   GCsNl13v1EfhDlcxUHWN0Vw521Biry9trtJZDDzWDMYlC2u07tA7iCKGW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="20075089"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="20075089"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:24:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="9433618"
Received: from alichtma-mobl.ger.corp.intel.com (HELO intel.com) ([10.246.34.74])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:24:01 -0800
Date: Tue, 20 Feb 2024 15:23:58 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Andi Shyti <andi.shyti@linux.intel.com>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	John Harrison <John.C.Harrison@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	stable@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH 0/2] Disable automatic load CCS load balancing
Message-ID: <ZdS1_mEbYMDNCloi@ashyti-mobl2.lan>
References: <20240220142034.257370-1-andi.shyti@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220142034.257370-1-andi.shyti@linux.intel.com>

Hi,

I'm sorry, I forgot to add the changelog. Here it is:

v1 -> v2
========
- In Patch 1 use the correct workaround number (thanks Matt).
- In Patch 2 do not add the extra CCS engines to the exposed UABI
  engine list and adapt the engine counting accordingly (thanks
  Tvrtko).
- Reword the commit of Patch 2 (thanks John).

On Tue, Feb 20, 2024 at 03:20:32PM +0100, Andi Shyti wrote:
> Hi,
> 
> this series does basically two things:
> 
> 1. Disables automatic load balancing as adviced by the hardware
>    workaround.
> 
> 2. Forces the sharing of the load submitted to CCS among all the
>    CCS available (as of now only DG2 has more than one CCS). This
>    way the user, when sending a query, will see only one CCS
>    available.
> 
> Andi
> 
> Andi Shyti (2):
>   drm/i915/gt: Disable HW load balancing for CCS
>   drm/i915/gt: Set default CCS mode '1'
> 
>  drivers/gpu/drm/i915/gt/intel_gt.c          | 11 +++++++++++
>  drivers/gpu/drm/i915/gt/intel_gt_regs.h     |  3 +++
>  drivers/gpu/drm/i915/gt/intel_workarounds.c |  6 ++++++
>  drivers/gpu/drm/i915/i915_drv.h             | 17 +++++++++++++++++
>  drivers/gpu/drm/i915/i915_query.c           |  5 +++--
>  5 files changed, 40 insertions(+), 2 deletions(-)
> 
> -- 
> 2.43.0

