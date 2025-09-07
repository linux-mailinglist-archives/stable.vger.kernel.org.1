Return-Path: <stable+bounces-178023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38B6B478CF
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 05:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFF467B5603
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 03:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1873C1C3BE0;
	Sun,  7 Sep 2025 03:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UtJDRlBt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244B717BED0
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 03:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757216590; cv=none; b=h4rXFqxfh+9ysvfqa/VbNnMlEHgRQFU6niOdt8uSQ+SLsdPkQHY5lCc8XOjOxVeRyO9Gd74QIhBUKyM863OzLELzg28pUitRWHVdP7StiYIc3NikAGzt+rrgKLgzw8KBDmQEefaFSIqfuTrnfy//F8RcrNaWRfpbB/DV8z/Za2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757216590; c=relaxed/simple;
	bh=EmoIZ6x2JkkGsvZvoJvyjb6Uau4ghlOR3ydbGs4pByE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=P7UW8fpmhyZCdmkp5sFn/1vV60UOIqTfSUHItVqi0yHJ1RXx4hn+M2m4HFvGhLgHBkoEnEVwUeUgUIXGHPUDHqYTtHt/F61gn69muh8AcCveZjngA2eik/gbNW77IoUAkHDckk4bRO0obRxyycqNc5vuaV61gbBFgRkTftv7A/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UtJDRlBt; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757216589; x=1788752589;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=EmoIZ6x2JkkGsvZvoJvyjb6Uau4ghlOR3ydbGs4pByE=;
  b=UtJDRlBtN7y+9Noh/9EB832lzuqNhuXPi83iKfgKa1gGUeeA9qoBSAgT
   6ELtAjn7N3i93AeeSrpxXIsXn30qdaDU8R3OHnBED1L/IN3r7bWCm/Mv5
   L8TK+e0pyawKTDtJbqUu39WtG1yDezpdcra9kX2GFtwCtReA9/ocW2TpK
   rjuSYVAX3FAxpl5dGnmzz0GnBgES1trFI+tQfds5PH5iNJ3CEUFI2ztSs
   jQAi7cFeDoCrn4JhyOX1dQFHivdQr9t+ECo4l0+mYbzqYg/Mko+Ly/OjN
   pFj4cnhJXzOWTUXSoZLCPMU7VUlYVFh4oZFKkhdg5PZOKPYgpzLT55/3z
   Q==;
X-CSE-ConnectionGUID: 6xRik/YtRMSo5RUjFJ4wig==
X-CSE-MsgGUID: 4d+dGRf9S26MA7Q6xi4wXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59439272"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59439272"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 20:43:09 -0700
X-CSE-ConnectionGUID: YTpK7AluRz+xjsgsqk+j0w==
X-CSE-MsgGUID: PLbBC9T6TCKREzwwP/sYVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="203434392"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 06 Sep 2025 20:43:07 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uv6Iy-0001zf-2o;
	Sun, 07 Sep 2025 03:43:04 +0000
Date: Sun, 7 Sep 2025 11:42:41 +0800
From: kernel test robot <lkp@intel.com>
To: GuangFei Luo <luogf2025@163.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] ACPI: battery: prevent sysfs_add_battery re-entry on
 rapid events
Message-ID: <aLz_Mb2YcWzoUccu@c9fd1d3328ad>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250907033925.223849-1-luogf2025@163.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] ACPI: battery: prevent sysfs_add_battery re-entry on rapid events
Link: https://lore.kernel.org/stable/20250907033925.223849-1-luogf2025%40163.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




