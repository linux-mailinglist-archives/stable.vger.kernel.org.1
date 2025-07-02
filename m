Return-Path: <stable+bounces-159196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D986CAF0C22
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 09:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7EB31C0396C
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 07:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5161220A5EB;
	Wed,  2 Jul 2025 07:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Km6oWRog"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F5A1F791C
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 07:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751439661; cv=none; b=gS7JAt4NKWO4DP6QKrg55PUkCOJp4cBbH92ejt8mqa/B4EWJ3AIqOpwY4NHSRyb9mdnI7UPlL6oNnSvJShsT510dndrxpRmCJbi7vBfCqaPGBonTf5MLgS73O0XmfyYKmMkUqG0YygctShWmc59+EL3dbng81u8M30dqpes7RS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751439661; c=relaxed/simple;
	bh=1ukfgXEYLmTnbRPbu4h9NQ19dsvCVBPOwpvfp/jvQgg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=erI275UprCInUsLzeOKDjRRP4d5WbPBKfyBp/ywsh17HvxjgpRSHKeU0TJzL5UjmUyHm3W+aaFhngYs3jybmZSraM5TMkcdTSbK932XPTghR/vxuLVUGoJOWlvNDuE5uxmkE77N6WyMEtvuyXsvj9+rRQ7iK6TqiFhVsIMroB78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Km6oWRog; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751439659; x=1782975659;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=1ukfgXEYLmTnbRPbu4h9NQ19dsvCVBPOwpvfp/jvQgg=;
  b=Km6oWRogwituaWOoE2htYdRdBzLmvsCnyqAgYdpGrhDx/bwjAB/8TwtY
   ij9LCzro7HDPPl3h9/EgIK+4cVetOMYl5aZf6Te5oGwwKsxweHE/7sT5L
   HVxZ+3pwSBHZCPuERyo8fyd8/aOieZ+iF6Po5p945juB7dZgrE95lVaCo
   MsApJoogAdonUJFAFvd32H1LvBO/K+W6AX8Aqrkcw4I6ktobqeC9zC324
   pbjnlFxInmgzMTZWzSu12jcU6tuWX4fXHLXb9++6CyXDnEtmTKQosnvqZ
   1PHkIHK3U2wziy0uUwPXsdRTVA69QHq2pm6L3/j1VsdHhd4y2LaVIUxVZ
   A==;
X-CSE-ConnectionGUID: H5t2+TbxRA+j+PLUmzREoA==
X-CSE-MsgGUID: W8EjEWVuTZeUt5T9dLe3KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="76268460"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="76268460"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 00:00:59 -0700
X-CSE-ConnectionGUID: H6Nw0e8ZQmG74bYbs7YaPA==
X-CSE-MsgGUID: 1cWQRlDhR7m3DnKID7/n0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="154475457"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 02 Jul 2025 00:00:58 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWrSh-0000I7-2F;
	Wed, 02 Jul 2025 07:00:55 +0000
Date: Wed, 2 Jul 2025 15:00:04 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] mtd: rawnand: atmel: Add missing check after DMA map
Message-ID: <aGTY9O960kU6w2ox@08871597274f>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702065806.20983-2-fourier.thomas@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] mtd: rawnand: atmel: Add missing check after DMA map
Link: https://lore.kernel.org/stable/20250702065806.20983-2-fourier.thomas%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




