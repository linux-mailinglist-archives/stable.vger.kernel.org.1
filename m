Return-Path: <stable+bounces-116385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D936A3595E
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 09:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218EB3AC089
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 08:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2936A222564;
	Fri, 14 Feb 2025 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lvvH7AJ0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A55275401
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739523105; cv=none; b=ik+cgYTb8DSmKMwvXy51OIzX+qoxApyu0SI6SI/KB5I6XGr0c133FQ5p4pdznP6GANyHZLU5+DhZom+zfyasxDIk5e5bUk5hhBzGRt9iHjP543jpBIQU4KZT0ymekc+TtG85eIPZTTi4kym4zyKxI9xwEz0xCt/aY3N5OKWl4Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739523105; c=relaxed/simple;
	bh=+YP0iLYaQDBqPZpkGOy6Cp50BxgNTyf6FaLOCF05fS4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=flTCy/72V/gCxkhD3ZSVnKsF+sxkdH8AofZwMGjg3JNUZcy02kKTPYE4FPjCQ0Ss/qPyChrfP42L0E42Qoec+M5brA+i0oC5dChHRh+bJ751nsT9rPowNUs2T5ZtcjprHUeKm+G/AZqhjRFjo7KNNdQoSC72OZ+eHYw89pmZaP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lvvH7AJ0; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739523105; x=1771059105;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=+YP0iLYaQDBqPZpkGOy6Cp50BxgNTyf6FaLOCF05fS4=;
  b=lvvH7AJ0Lf83CoY0wuaY75ZYo3Y5oOTEaIWBwtTSQBy6E4qGB0Au4/TU
   N4nitWfCzvRiPJ7QT3TT1r1w+/OfoGS2NYketFzRCgnBd9tGM4kY8xgOW
   xTGIPdOgHt4ge/TGtTPXprj9Nkx2AoBGm8nbgVXunM2f/6BMAu5+vmGpI
   A6D2llT9A8om9KxoSws5mg6DndhxYw3CsooQIvlJEVn0h0d0Aix7Q7zQR
   yCqx2l4bQwvjh0lhi9kYYbUr/xLqdgcl5KZ+MqIBJXbtfXCXFvlIY/iZd
   stR2f0y1pk7whVZppY4ssTdnSjpLJ2qN8oN9ggB0RnhrS5pJdE6Uhwxhj
   w==;
X-CSE-ConnectionGUID: /D5XBax9QYKxzBIewWriHw==
X-CSE-MsgGUID: y7hpXW3zT+KVsk7F6uwGww==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="51239991"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="51239991"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 00:51:45 -0800
X-CSE-ConnectionGUID: TVwmUxywR8aWmzpB2yQTnQ==
X-CSE-MsgGUID: CGTdao5MQlS6/z407H9HTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117532044"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 14 Feb 2025 00:51:42 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tirQC-0019I3-2M;
	Fri, 14 Feb 2025 08:51:40 +0000
Date: Fri, 14 Feb 2025 16:51:29 +0800
From: kernel test robot <lkp@intel.com>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3] arm64: dts: mediatek: mt6359: fix dtbs_check error
 for RTC and regulators
Message-ID: <Z68EEQQH7QFyhuid@4f51b8f948e0>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214084954.1181435-1-macpaul.lin@mediatek.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v3] arm64: dts: mediatek: mt6359: fix dtbs_check error for RTC and regulators
Link: https://lore.kernel.org/stable/20250214084954.1181435-1-macpaul.lin%40mediatek.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




