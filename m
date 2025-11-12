Return-Path: <stable+bounces-194595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE86C5199F
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 11:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4399A188864E
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 10:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76D1284672;
	Wed, 12 Nov 2025 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JQw1CrVC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056C8214A64
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942480; cv=none; b=S//7VuRgzZBJ/bhq2LFBpNo+iIRyTlAMmN2UKhQH+nquIWqYT54R/l5icrJKQKcB3vwYWMHcj0x70rauE+5CkZCfEmsMM4uzjXV83TCdIutqq6hju7qoz6Th7S1hsl4zHTC8Q+TxKsIwO3rEO21FYAP9ovP/TbEnUwl7gTjDgdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942480; c=relaxed/simple;
	bh=3wrJXgCipPWh4swnwPzS8kyqLb1MCSoQaTSk5LGFAjc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dHgTC4/PcYh1USRDeOi9ior3nFS29QYQLUlrqTMSBp01e/dOhxlbDXdp5NFUDaHWEQg2I08hnTMFpHDWh4inx9g70YCnGJLZYc6FWGjiBzsfQBXatzxc0dvVxP5eGur790+hh6W9k1lkTMpj1GmsjcLmAhWCFnEBwNx6RxA+k8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JQw1CrVC; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762942479; x=1794478479;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=3wrJXgCipPWh4swnwPzS8kyqLb1MCSoQaTSk5LGFAjc=;
  b=JQw1CrVCTnkd9LWq5NFU5koWuPozSBKBbW+akgG0D8SYGRKONaGxp2Te
   4S9tgEiQANVtqIWAFlYV1Y7iJaYQEtBtBcb8bzwGdxjaxsnLtyfF2LbhL
   pXJEjuCzCAta6X860ou6dOdd3n6BT/xTd2nFniXmcc0J0VncYqt/jUQ0M
   6PKMVfUJ7PMzaFawv4F7ZvWZG6OWshiZPEVvs95Yud8L9g2W/vA9AMR4c
   oZR2k57ykq4jLClFFtknG4Hf8Npal5wisItTkm1WyKyypjoPvTMFK+6lr
   7KuCH/U4tKYRfJNSmUZsNVPvRV+jjhK5W02DZhJOB/AuFn8eslgpySxBK
   Q==;
X-CSE-ConnectionGUID: HpmdYTjcT/WAcAm5b/XMQA==
X-CSE-MsgGUID: awSIymlrQvSqyUHZEaWwTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="52562232"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="52562232"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 02:14:39 -0800
X-CSE-ConnectionGUID: irpHeRlpS6iFQ9JUPe6MTA==
X-CSE-MsgGUID: IYhQHYk0SXiDt/KoN1Ta8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="189450291"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 12 Nov 2025 02:14:37 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJ7s3-00047r-0m;
	Wed, 12 Nov 2025 10:14:35 +0000
Date: Wed, 12 Nov 2025 18:13:44 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net v1 1/1] net: dsa: microchip: lan937x: Fix RGMII delay
 tuning
Message-ID: <aRRd2AjEJzwIs_Ly@2b6d71d08b4d>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112101119.3594611-1-o.rempel@pengutronix.de>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net v1 1/1] net: dsa: microchip: lan937x: Fix RGMII delay tuning
Link: https://lore.kernel.org/stable/20251112101119.3594611-1-o.rempel%40pengutronix.de

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




