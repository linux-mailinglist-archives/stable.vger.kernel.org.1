Return-Path: <stable+bounces-124134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A92BA5D98B
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 10:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51542178A42
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 09:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E8523A98E;
	Wed, 12 Mar 2025 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJP4r0Qj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9E338384;
	Wed, 12 Mar 2025 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741772092; cv=none; b=JZgiRboJN38pki69igP9FlEEBm2Rwr6BBupcsDSSa6YaauTRzftNIU1eYa8wBiByxxXV7IX4mc/4e5ab1nUmaUxHFkU07oSFksqX+wJMFX7zmcEnrbXsyNyPpuvKJmiadaBQDpdkxe/g2p0jlCCX692FTDyr/39V5NdrbxyQPNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741772092; c=relaxed/simple;
	bh=sxeSq7DARLje9UuKWZjona4rNmtHMjZR+LVlnGPftZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5/GQud+pF9LNhD/5NJfKUwvfoUCIqVObaszrsWKe/w4o3A6pg7PKmJ0u0Z6t8akV5GX6sKtCFSkPdpeka//84PQ6/BK/t0g/o68myyyJSRP9pnjecfo/FQvPfIry7wJDzKa3MUvcG7psXubg6AM/kW9gSwGzld4DPJoCtOkGGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJP4r0Qj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741772090; x=1773308090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=sxeSq7DARLje9UuKWZjona4rNmtHMjZR+LVlnGPftZA=;
  b=aJP4r0Qj0eJ5jlXdp66ytulFAzIvax5kR//X/TxtHCQivTdXqwOzjb74
   S9e2jPLMuIY28dF5b84u7CWZgcgSHHOiQ7RAXz6ez3w6NWApvPZ6xqrMd
   srtnQHJfMB7Z3qxMt4jdfdNfbsu9rdn0nWXGEKHYSCtdGa/AlyNDQwTMS
   eFBXK1UDte39t4+0qoFD4xzabHFqSNIGmiNrVOsHBTa+sION7zhMFQhmi
   54/BOs77ExFCbjeqerQq5k7Uon12AZpqBsvFlQwZt9Fd+zFW0TI9WxzwT
   2j720tLnZEk1XB40r6cU2zqu2GQ4TJoNkfw35Sp/cLLiKsidWf4jzzwgj
   g==;
X-CSE-ConnectionGUID: H8Y40/aWT5yfNfa5eguMkQ==
X-CSE-MsgGUID: XYnqKlH4RhmdKw+FgDbEYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="46623921"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="46623921"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 02:34:50 -0700
X-CSE-ConnectionGUID: Bp/rXOZ7QwesnFy/i3bkNg==
X-CSE-MsgGUID: 4oiua/KRTiOtZ3Qz8jcjTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="125617858"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 02:34:47 -0700
Date: Wed, 12 Mar 2025 11:34:43 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>
Cc: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
	Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Phil Elwell <phil@raspberrypi.com>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, kernel-dev@igalia.com,
	stable@vger.kernel.org, Emma Anholt <emma@anholt.net>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: Re: [PATCH v3 0/7] drm/v3d: Fix GPU reset issues on the Raspberry Pi
 5
Message-ID: <Z9FVMyP_t_fNndm0@black.fi.intel.com>
References: <20250311-v3d-gpu-reset-fixes-v3-0-64f7a4247ec0@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250311-v3d-gpu-reset-fixes-v3-0-64f7a4247ec0@igalia.com>

On Tue, Mar 11, 2025 at 03:13:42PM -0300, Maíra Canal wrote:
> This series addresses GPU reset issues reported in [1], where running a
> long compute job would trigger repeated GPU resets, leading to a UI
> freeze.
> 
> Patches #1 and #2 prevent the same faulty job from being resubmitted in a
> loop, mitigating the first cause of the issue.
> 
> However, the issue isn't entirely solved. Even with only a single GPU
> reset, the UI still freezes on the Raspberry Pi 5, indicating a GPU hang.
> Patches #3 to #6 address this by properly configuring the V3D_SMS
> registers, which are required for power management and resets in V3D 7.1.

Not sure how much it helps your case, but still leaving it here in case it
turns out to be useful here. It's already in -next and trending 6.15 merge.

https://patchwork.freedesktop.org/series/138070/

Raag

