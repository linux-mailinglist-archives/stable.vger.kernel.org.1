Return-Path: <stable+bounces-98215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B48E99E31D0
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 04:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 619A7B226E1
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 03:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1274757F3;
	Wed,  4 Dec 2024 03:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CYIIh7ns"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAEE17BA1
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 03:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281627; cv=none; b=uMQm+3cKviOm2IiKTirSPk5Q6p0XL866qLWZzjO5zylLta7VmkHj7keIcjHJ2ojumWz+df9RHGQ5JwmPTuY5ZE3EybLbw47G7pIhJnL2BpGDKncZToDutHAPo8UN96gBGdUO2I5BxWrzUqiOW79GpOx+DsmBCAy9JKIkad6NoV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281627; c=relaxed/simple;
	bh=QoGgYg59vdDpgL8JplYGah7ERGS6mEtwWpLtd+kJC2s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Oa705NijWtIFZrnhh1JWLtRddRCHvJaS5NekTrLVOmnmvoavHnTxGmygWmNZEXvSNuRcEfl1F2cGQ943MH3YL9BkO48knliny9Kew32TWUrEiZCXX78LM+YxrGAdkwljz0fR5/BWjGIrcrDaW3O/I8uXlIeaglWb6sSOyUtwh68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CYIIh7ns; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733281625; x=1764817625;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=QoGgYg59vdDpgL8JplYGah7ERGS6mEtwWpLtd+kJC2s=;
  b=CYIIh7nsIOTALru6ccvFUXarPy0xVYgUZQ302yBX/KrhlRld4xdVtPHl
   XjbtYd1ve8GbqpogFjcZ4wCHHKuYg9etIX3WP8KD7Jcdeb/dxEfF2ANMM
   ozQ+Aii0D+B+tx84EBjNRWZW1LmX7fe1UIcFbcSCCjigZcBexdiik3s2e
   h7Ht0UmPDSOFoB5vK+uaZH9Gs13sSwFl/s6jtl7xsNjdIzth85Dy10gIv
   GpSxyexFSrPsDdITgoVb8qgBir87i3zie0mtFWBQK+PVHosdWGbUZWAWo
   7Ht4ONEw5yUrNbJqUtYWIUGJCyaLmgG/c+g4+ukiG9S4yFGHAxOdXrMjm
   w==;
X-CSE-ConnectionGUID: HTXa323pRCOmHuUF9rdhSA==
X-CSE-MsgGUID: L2YCzgzWQGabpfwVaWUz2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="44910216"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="44910216"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 19:07:04 -0800
X-CSE-ConnectionGUID: vwZTkvkIQK2EqQI9pNoEPA==
X-CSE-MsgGUID: Gq3Nbd7ZTwCwRy4Omirw7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="94059348"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 03 Dec 2024 19:07:03 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIfjA-0001JF-2a;
	Wed, 04 Dec 2024 03:07:00 +0000
Date: Wed, 4 Dec 2024 11:06:15 +0800
From: kernel test robot <lkp@intel.com>
To: Zach Wade <zachwade.k@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] padata: Fix refcnt handling in padata_free_shell() again
Message-ID: <Z0_HJ21_zYvegl3Q@24ad928833eb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203153426.62794-1-zachwade.k@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] padata: Fix refcnt handling in padata_free_shell() again
Link: https://lore.kernel.org/stable/20241203153426.62794-1-zachwade.k%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




