Return-Path: <stable+bounces-197080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 689A5C8DBC0
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 11:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8603A93BC
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 10:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47424329C61;
	Thu, 27 Nov 2025 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l66Ej2dx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4AB320CA2
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 10:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764239004; cv=none; b=EHXu2fH5W5BKtbDX/L5T/NPLG9WJO18KCkjifjv7kTUfr5v9P/unJ7Xl8Yc+Utl6ciqDxh3P2Wwh4sUQQJ+bYCo+BHCAMTAxGZmqxAPiaEi3DwH0fdw8GVSjsolh6x49uFjodWuWgKz7VTWc8ycvHDaUJtkHBznAGOKveylsNYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764239004; c=relaxed/simple;
	bh=v0CAiZAtynSgsX9hRcLh8PcM2FlN0fRZBn3spiuvtgU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uQ5/yjloF0FUwyO+GzCd42y1Eea5FRflLFcaWl5tJVQpHMegzaQtEuzxpa9BYQ8EPaQwUoV9YrtxpEtCnMCfjfa/b8RD9Sde6wiAwNjDjIYMQRpKAc2nTgSAlvp4ZOvo02pbfgnNROqneJBE93t9HlzLjetNj/Aqe4O0mm08aUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l66Ej2dx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764239004; x=1795775004;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=v0CAiZAtynSgsX9hRcLh8PcM2FlN0fRZBn3spiuvtgU=;
  b=l66Ej2dxyhMBYLWsNDK0lzZT32OKoW37+q+Tq6DxPMoQCb9uhMGvqnym
   Poj2uXBxU3fBaQOuMlV8PbkLFoiFa/X6CB4HD4VOGm9X3hc5bQnfS6+vK
   l/veGX9fmw//091xakRbtPJfEWs7qBQB0htRZlRfH4Ekl1Bd5Y1QTRtqI
   mf6NmZaXZawmW7WcS7NmcYz95Qt9IMKu+nDDoZkVTtdNVIZt/OvDJWISH
   +XePJehbl1voaQ+Rw4clqixu2itCya6voFHc7mh6qGvUuob5XHnRMeofV
   RvIMBbsayEsQSybryJ7GMxyIw65B4DlF0B78ha0S+KDrtjqdzWxphdmJA
   g==;
X-CSE-ConnectionGUID: gbp4jp8fR9q1GVFVfsDaRg==
X-CSE-MsgGUID: tPDmLVZ3SEKP78fbs1S2Uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66322944"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="66322944"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 02:23:23 -0800
X-CSE-ConnectionGUID: M7FPv6D7SIKwD57WsOwV4w==
X-CSE-MsgGUID: 95uM9/IIRiy5WMo1uIS+Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="193009990"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 27 Nov 2025 02:23:21 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOZ9j-000000004Rl-0HfJ;
	Thu, 27 Nov 2025 10:23:19 +0000
Date: Thu, 27 Nov 2025 18:23:02 +0800
From: kernel test robot <lkp@intel.com>
To: =?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1] xhci: dbgtty: fix device unregister: fixup
Message-ID: <aSgmhnGnyRa5ZSOw@73cdb724bd1e>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127101904.3097504-1-ukaszb@google.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v1] xhci: dbgtty: fix device unregister: fixup
Link: https://lore.kernel.org/stable/20251127101904.3097504-1-ukaszb%40google.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




