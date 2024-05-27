Return-Path: <stable+bounces-46275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8330C8CF939
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 08:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCDE2814A3
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 06:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59F3125BA;
	Mon, 27 May 2024 06:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPgPkgmP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22B2101DE
	for <stable@vger.kernel.org>; Mon, 27 May 2024 06:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791752; cv=none; b=dzh4dc2NW9XrDFoLTkF6zfwCVmfdrmo9f2n7mQXbOLaiu9fCszYpJCNVUhjTMqqz9maa0RXMe0W87FJW06pO5XyKwckbPzeA/2wnbLdMk+z7DCRJEai1D2yGTCGIplIo/u2kZRUEECXthqoGLqYDnTuXhMO860axo17fmlDZ7xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791752; c=relaxed/simple;
	bh=0IGPEcpuNCgmpD89NY4lsMzsyLe8/reayBUbmnP4HWM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=d4sj6UMwndjvuM7YbZiZIY0oMiOKbIE7+bW4LcZtCfVXWVXHyZ5DGCyYRvRYxTglOfBVDTOmnwqxtkLvIGDH3/WrDSltgfvicSBf4VHMkRLobvfAaZ/wIxPsGsIyedyeZyrhujEwFYN3DGYQEUcw2ll0is4xsONGaod5bwxHuh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPgPkgmP; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716791751; x=1748327751;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=0IGPEcpuNCgmpD89NY4lsMzsyLe8/reayBUbmnP4HWM=;
  b=gPgPkgmPof6nEW5jHHvSYV6vCrFg8HR8qkpvBv4XtjOWzVlswXb11Aai
   lz9V2N2G6JRbk1L7ahimHF3oeFZeezuUH3EMb0uCjSGEwyWm+elW831pO
   kCTWIKImwdduCiFIukPylYsxwfWKtchLj0C3k0XQS6cW3YLVsRq8qUN8j
   LsL+kNqYjAfqh+mf5NQ+fwKCYn0M5lViWC1maqpAkhUaKBEIVnmB30pu8
   bckyb2eOyVZdMnbP0Q2ELFsAPDqKAmbpc2o/s0/GoNj8tQojUFTeBj1gU
   XOuN6yzjsy6y6pZBtmKe7eUXj4yCG4HU1RDfdbn94S/5FwD+MukT1kyb8
   g==;
X-CSE-ConnectionGUID: myS1os78TR6sBoMJtFEKag==
X-CSE-MsgGUID: GW0QR2XGTL+Z3GxxJDgsxw==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="12932104"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="12932104"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 23:35:50 -0700
X-CSE-ConnectionGUID: hRieDhjvTpmDdyL4Gk5GZw==
X-CSE-MsgGUID: EQU+SIoqSPaQJk0pX8RWPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="39625108"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 26 May 2024 23:35:50 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sBTxJ-0009XJ-1d;
	Mon, 27 May 2024 06:35:41 +0000
Date: Mon, 27 May 2024 14:34:45 +0800
From: kernel test robot <lkp@intel.com>
To: Chengen Du <chengen.du@canonical.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] af_packet: Handle outgoing VLAN packets without
 hardware offloading
Message-ID: <ZlQphdQLcOnGhCIR@64dafc7c46f7>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527063136.159616-1-chengen.du@canonical.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] af_packet: Handle outgoing VLAN packets without hardware offloading
Link: https://lore.kernel.org/stable/20240527063136.159616-1-chengen.du%40canonical.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




