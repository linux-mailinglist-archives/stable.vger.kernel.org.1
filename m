Return-Path: <stable+bounces-195230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A157C7296C
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 08:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E733E348462
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 07:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A406030594D;
	Thu, 20 Nov 2025 07:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P6hUNCc4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B913054EF
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 07:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763623661; cv=none; b=fDR6/R1+Ulc26djZtPkct9iAXJ9hKSwfRngBuz+XQkE0+TJ6w373E5raQedwgS/wKKLdcFMv1wcBJuJaJbo9pvDSyUoqXvloLOHM16QA1w/514sRKWKyfPJ9mv/RrVmeG6CCe5IzdeFJGHDWjnF9HT6l/ccat1AQUjSe/437Plo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763623661; c=relaxed/simple;
	bh=uhCyuvScHcMXkMrVf5+9mwxwLss7Z70xWsWAgwg65AM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cVg2p5+hYKADutqTqQ4I4ZACni3PMmD498T1TQ4+LOeRkVnGzmgV/ePEKzxfQTbHMZED/tfI+JEn050Lu3TZPv6ra2CVgExGXj4ZyFQG61Hie9NHC+3K7wzbHPaOCjFIDLxSsuEZP8abbyWITyLvU3YgVm79moW+g2jdPyxOkC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P6hUNCc4; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763623659; x=1795159659;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=uhCyuvScHcMXkMrVf5+9mwxwLss7Z70xWsWAgwg65AM=;
  b=P6hUNCc4QOxcC2S4cm4cDc5IIyOQn6jGCNVp1Hf0grJhlu+yPPl3oDTH
   GU41jznyhgN9l4vzpNkcCJJQCC87V19JLrj4s92RWiNvo4hwW5M1QdE9Q
   uzVGgqKITBVnNS2V9N9crAMxkOojG0R1WLamNaCieLBABO3Kt9Rsx2SOA
   /Z+zbF7Sc2PkRcQ9QUUrX7u6FCKsAvUWVW7P/WxgIzHLslPfzr8wt+Ba+
   UPPuHTD7Wgi3n1Dj/gxtFKGT7u+LMwQLCnyYIotagqsxittT+N7HRNKOI
   kQkmecFi+tHH+DWy5EFppzwRKSblAZSgG85rykV1XUqPi2paiYNQ/SjU0
   A==;
X-CSE-ConnectionGUID: JZ7fwXPGSm+Q07mEzNCjKQ==
X-CSE-MsgGUID: Ex2pkIf5QgyQoBasMNPabw==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="64876492"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="64876492"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 23:27:38 -0800
X-CSE-ConnectionGUID: r+EVo+pVQlmJlU3N4BfPeA==
X-CSE-MsgGUID: fynJ7+m4T5enqxYsI+O2nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="191545264"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 19 Nov 2025 23:27:37 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLz4p-0003it-0Z;
	Thu, 20 Nov 2025 07:27:35 +0000
Date: Thu, 20 Nov 2025 15:27:16 +0800
From: kernel test robot <lkp@intel.com>
To: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH]  mpi3mr: Prevent duplicate SAS/SATA device entries in
 channel 1
Message-ID: <aR7C1O597DimVIaj@9008770f0454>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120071955.463475-1-suganath-prabu.subramani@broadcom.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH]  mpi3mr: Prevent duplicate SAS/SATA device entries in channel 1
Link: https://lore.kernel.org/stable/20251120071955.463475-1-suganath-prabu.subramani%40broadcom.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




