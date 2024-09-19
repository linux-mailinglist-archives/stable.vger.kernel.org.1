Return-Path: <stable+bounces-76742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DC697C66A
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 10:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD951C20EA4
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 08:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A7819925D;
	Thu, 19 Sep 2024 08:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DujjDfU3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFF2179AE
	for <stable@vger.kernel.org>; Thu, 19 Sep 2024 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726736303; cv=none; b=RJ9PlaeMhr2OgeD+tqeug/46UuwnKxo+YgWudH+yETV26jOEgYn9H0eht2iJbi/FgCj4+vGwKo7qRuK+8vaXishgxqqDZ9AoR+sjhuTpP9c+N8h5tiJgBBzV+5LtHYYSk/Mi3hd7TzxcSAUDBIUO1KQbsE4RcUjhjKfMwg3WMJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726736303; c=relaxed/simple;
	bh=Xm7sv8UXsail7gevUUuGHKRIlpV192FyltCvLKTIvRY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VLzxFhik0aTZo937dS0qHgvwwZ9tR3I1fIWUpjlAVbttkEOCAiC/db+wMXaF0tBMDYjrhbeSvy4YYlNXhAxdRYAbGE8aN+tz+k/L0MsdnUen/TYnstqC5MOlt4lU+q+lpyRFLAF5JzUDHgIwyejqyqzeiEdN8tNPnkJrcbUnQNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DujjDfU3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726736302; x=1758272302;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Xm7sv8UXsail7gevUUuGHKRIlpV192FyltCvLKTIvRY=;
  b=DujjDfU3teeGaMa30cNbiJR97I9553b7HohZLChNP/Ovmpds9v5yw9Ob
   4tsYhUzU/hbnG4sDaTT0hvrZkAHmYJAmrk32pUQB2TjvI4XWw6UVQreE5
   pn5HaxPkEbAEL1yssEzvwWA1E9dZ5ABydBpiFDXeA3K2iOSJiYkA60yWd
   lfzqQ2ZQUdQ73c78GIPBekV7ZYSym3w3XlLj9CGzYPhzcPSpbad5aRWw7
   gRb+52OGVv3V1uoviBTaTvlR9YeL0SR41pNqMUUMC/AwcXR9LfGAH9muD
   VmCNicaImRTMCYT5bix4XM/WyktK/x//lsQyo9gz4j//iXkW97YSi6rMT
   A==;
X-CSE-ConnectionGUID: JNnb3BEJQ6GDMRawgIgZXA==
X-CSE-MsgGUID: xdttSi97QcqKGzIyTyj36g==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="43203818"
X-IronPort-AV: E=Sophos;i="6.10,241,1719903600"; 
   d="scan'208";a="43203818"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 01:58:21 -0700
X-CSE-ConnectionGUID: AROtHpNzTeudKvnElpJQ3Q==
X-CSE-MsgGUID: 2H1ehCFXTw6rRcNWQjNc6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,241,1719903600"; 
   d="scan'208";a="69747968"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 19 Sep 2024 01:58:20 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srCzR-000D72-1m;
	Thu, 19 Sep 2024 08:58:17 +0000
Date: Thu, 19 Sep 2024 16:57:27 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net 1/3] net: enetc: remove xdp_drops statistic from
 enetc_xdp_drop()
Message-ID: <Zuvnd29QNu93qtg9@3bb1e60d1c37>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919084104.661180-2-wei.fang@nxp.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net 1/3] net: enetc: remove xdp_drops statistic from enetc_xdp_drop()
Link: https://lore.kernel.org/stable/20240919084104.661180-2-wei.fang%40nxp.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




