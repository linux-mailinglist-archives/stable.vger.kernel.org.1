Return-Path: <stable+bounces-160406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3B9AFBCF4
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 22:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F37189B0FC
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 20:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116E626E71E;
	Mon,  7 Jul 2025 20:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UsXjEJ1m"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AD126E16E
	for <stable@vger.kernel.org>; Mon,  7 Jul 2025 20:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921731; cv=none; b=RdZ64ngqHY29ilmd9Gts5hI57GnfHh5nN6MIVlZRILgFdbEx1xc8+xW0iAIRz/0tBh8YZ3G8u6XM/4T9q6HN9lfMSi7tBdACQ+Rom4xlm262mISRYGFXY3uMjH+G9ChpazmASib/NHqvi3pej9Skb8zC0eXgZADiJtzcqSvch64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921731; c=relaxed/simple;
	bh=jvLODnZxAn6R1SNlBBAUCcDEkMmPv1mB/aIBchHxrso=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IWmk1glOO/4kZhc4Fxv0cERsqgihHDdQDQmRCfur/HjFIj8U6vSkbMQ+dd8iHLUBcQhPdH43guLoH7g8zvjNTi6Hjpnm/Yvc5UVozIzfgXqSTcnIETOJx/ppgpLy8YZou7O+8DFteS67DsySg8iafvSAwOLf4Xtfk9mygFj0Rs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UsXjEJ1m; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751921729; x=1783457729;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=jvLODnZxAn6R1SNlBBAUCcDEkMmPv1mB/aIBchHxrso=;
  b=UsXjEJ1m/k1en+KNE7lpwrcKBsJTC7lyom5rxB1Y6yJzcQ0yJZ0sV4Tq
   6ymbuhQjYarlSmA1cDWljD5Zts4j/wV/l5oUPdcVxeNcEGavyR702JaCu
   hlsd/NzSGA/9UrYGPCaqrKydvYPvy5anXDrfRp88GyS+n8NMNohLmmgHt
   EXVGq+akLtfUJwmcooxj91qdtB/vhFu0c773cBC7ww8+0jNCbDds5RzhF
   SLVYU+LPQ9dpUXhvcZyUSQtA1acJAOY0NrmnrbPvHc4SAv3CxtjOP/7v0
   iT+QNIoYX9WVjM7keJHi0HbWTmumP0WD902brZt4e72gyC63ROw6QZACL
   A==;
X-CSE-ConnectionGUID: eyO9yPB9QQ+xOaXiXq+uAw==
X-CSE-MsgGUID: MP7S/j/iQGSg4VjZv7nR2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="64399292"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="64399292"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 13:55:29 -0700
X-CSE-ConnectionGUID: 7BhoYMBKQnyvU5JkCwfOIQ==
X-CSE-MsgGUID: Gs/NRC/ETfy5LOzVySz5xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="186265823"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 07 Jul 2025 13:55:27 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uYss1-0000kB-1F;
	Mon, 07 Jul 2025 20:55:25 +0000
Date: Tue, 8 Jul 2025 04:54:31 +0800
From: kernel test robot <lkp@intel.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 3/7] arm64: dts: imx8mm-venice-gw7901: Increase HS400
 USDHC clock speed
Message-ID: <aGw0BwGfTEDO8kOG@319465d791e2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707201702.2930066-3-tharvey@gateworks.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 3/7] arm64: dts: imx8mm-venice-gw7901: Increase HS400 USDHC clock speed
Link: https://lore.kernel.org/stable/20250707201702.2930066-3-tharvey%40gateworks.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




