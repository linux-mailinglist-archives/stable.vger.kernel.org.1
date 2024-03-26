Return-Path: <stable+bounces-32341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3508388C8E8
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 17:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C191F2564D
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 16:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4847713C9B8;
	Tue, 26 Mar 2024 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GRpHgWZN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE74F13C815
	for <stable@vger.kernel.org>; Tue, 26 Mar 2024 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470113; cv=none; b=XjvyQoc2YueJovQyJP3oz/ZTp1sutw6z9kc60QTMQRtySjjr319g+Ktl7JgLVFnTtd5mRZUP/KaJ9bj+BryimgKN3TAL4UkZbmlJyBE0mn4DsW30yaD94yrjfUtoAgHrKYcSNeuDPSeXv+E9498wLHUky3WPoVLBmXR4At9Bt9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470113; c=relaxed/simple;
	bh=BNws0gDydMfP0P1Q5QnTKaEzayYzV7OQpQeItNJTYKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsn7MKqnGmbjFh25KK6AvlAaGNwwEh0kwrjhh5BkClicLBNzrbeVNHyaashk96ydD05EKLcblZpc3Zo1vrh4CqYPl0DWQsMI/PFH7sd8LelNvUFlyGYSpVaugO9xZZI6+H2t3OWXHuEscTYD+FYZV5iuQFhVRc1AEBeE+El7j0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GRpHgWZN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711470112; x=1743006112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BNws0gDydMfP0P1Q5QnTKaEzayYzV7OQpQeItNJTYKI=;
  b=GRpHgWZN1CUIppK3mgnwRYWA06K3pVCjl27sTgQKhW8CnhyZI6GouUqz
   2/2L4JFajEYkd4gCMbTRLOvFVOPKVjtbujJvVWvqmv3lshgMuZtV5+peP
   oKNXheTi0uOZT+WjIuEewsA5QKT4xC1z1emfFroIY9X/EWkKQfOUhmQ8/
   7KwwkPIWBJDy6ww6XKTTf9HH5C4kk/gX5Y1e6wIaL9aBzu7rCW32ygXTL
   9gdW8KBoPtplTf2XiGiKsZgw3U7ixrL3AI9Ux41URLLNVf/7dqFSOl7Bx
   qgPc0xNl8qPEu2KEo5P9NY0HcjUQz2Fa1RrAjN+y2PnEdvEaFetyhGemD
   g==;
X-CSE-ConnectionGUID: y7c7i3B/R+mHfgvRXfZM0w==
X-CSE-MsgGUID: yTIxs44GQTCcxOC0KtaV6g==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17263725"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="17263725"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:21:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="16069043"
Received: from unknown (HELO intel.com) ([10.247.118.204])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:21:44 -0700
Date: Tue, 26 Mar 2024 17:21:38 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Andi Shyti <andi.shyti@linux.intel.com>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	John Harrison <John.C.Harrison@intel.com>, stable@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH v6 0/3] Disable automatic load CCS load balancing
Message-ID: <ZgL2EqrsHBoBmoGv@ashyti-mobl2.lan>
References: <20240313201955.95716-1-andi.shyti@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313201955.95716-1-andi.shyti@linux.intel.com>

Joonas,

> 1. Disables automatic load balancing as adviced by the hardware
>    workaround.

do we need a documentation update here?

Andi

