Return-Path: <stable+bounces-20821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCCF85BED6
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 15:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A191F2170F
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 14:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C2D41E4E;
	Tue, 20 Feb 2024 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="icyj/Gml"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0132F2C
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708439643; cv=none; b=KZpIjfRubswV+MT09WZT7t/WglIXF0WJ1440sPYOzdS1no2beaSxkX3fVc1PSTI3ntxSV8agsjt9RvQkFZmGxapj8Gl8I+ozVd4ikJWowp7tNysQX7KRKoHEo2/Ndkc5y92EGdGVwbLMjrXL63k1n4dd9QWM+KusgmY3Yp3V948=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708439643; c=relaxed/simple;
	bh=XhoJMIIiZEXk/cs2SQkZGuVZr+98sbrPT6T+HBM3uLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ugokj4igZrYgem+twiySGptp3TlguDlM2PxWHmM7Iho/okrqZt4GJHlks8nY+uOHnsn8aZGSsAbX7JU5FyPxw4/9u57eTVLv46lj//IRtdkdTplEuQYHBcQCoFDCfaRkKwYcjxuMisUmm8LsWHXIBDsG+BFBpuUfojyauM/u1tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=icyj/Gml; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708439642; x=1739975642;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XhoJMIIiZEXk/cs2SQkZGuVZr+98sbrPT6T+HBM3uLc=;
  b=icyj/GmlACC0d6ms8NYOxrCoSmt+KJTSjeTiZvxCr1iNn4LkorizltrJ
   Z0LkF5xjMJRIN/x/IvzWOr8GnhTDg44XmRNjTQu2gyvfxwjwcSS+WzjBI
   FMsZVpDoiYDdRrapUcuYNIS0bFR/ykjAzCxZnJgq5VqLDqa3rt6dsaI3H
   E+glxdH32x6ygBWhyATp34Bvb+zMav/4+R3eyjacuq8lOjGxbw7xnvpCS
   XwOIDYxdi2+R0JnBdc+GAb66Ec5+3dCd1v2JvyYhye0Gt3EAoN27u1Oja
   10b2h/suTi/6NSpJE+8tSxMUTysGBTojaWS/drJJ4Jxh4/YjzjI5C3Y3t
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2684568"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2684568"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:34:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="4756178"
Received: from alichtma-mobl.ger.corp.intel.com (HELO intel.com) ([10.246.34.74])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:33:58 -0800
Date: Tue, 20 Feb 2024 15:33:56 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	John Harrison <John.C.Harrison@intel.com>, stable@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH 2/2] drm/i915/gt: Set default CCS mode '1'
Message-ID: <ZdS4VH6AmFc5E8vE@ashyti-mobl2.lan>
References: <20240220142034.257370-1-andi.shyti@linux.intel.com>
 <20240220142034.257370-3-andi.shyti@linux.intel.com>
 <62a1a0d1-0972-41fb-b14f-0513f6691baf@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62a1a0d1-0972-41fb-b14f-0513f6691baf@linux.intel.com>

On Tue, Feb 20, 2024 at 02:27:07PM +0000, Tvrtko Ursulin wrote:
> 
> On 20/02/2024 14:20, Andi Shyti wrote:
> > Since CCS automatic load balancing is disabled, we will impose a
> > fixed balancing policy that involves setting all the CCS engines
> > to work together on the same load.
> 
> Erm *all* CSS engines work together..
> 
> > Simultaneously, the user will see only 1 CCS rather than the
> > actual number. As of now, this change affects only DG2.
> 
> ... *one* CCS engine.

ops... I sent V1 again!

Sorry, I will send v2 now

Thanks!

Andi

