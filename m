Return-Path: <stable+bounces-98235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3799B9E32FE
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 06:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1235F164C2B
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 05:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0BA38385;
	Wed,  4 Dec 2024 05:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJlLkQc1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F5441C85
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 05:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733289037; cv=none; b=DNF9w8KmSEz4TVxq0G7V8mtn/B9W/E1ycQ3vV6eCH1gkAm9adQmcg/a1Y6UqUd2TBTkIXOsHXusWM0/F9vA30cMtIWSDnRbQgvAmJbuGJKimed2ZjsIHrLjJeCfYYcZw89DvL/D+U/B59u5JoPaILtMysnvVmAnzVevHH89YLsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733289037; c=relaxed/simple;
	bh=EpiONNx3Awea6gxAEJuEObBVvFNLhfiTReodoWPWfyk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rI/eH8FjCMpnP7AFgu0lakcovZCSpjUKe9dO+VQkDxx5TE6elBt/25cudu47rDBr4IS/Okzp+6nGeB2qEDYyomEl76R8lHituFZI2ACVPG6FPS1ke6GWqHkePRISvSuyuOpHxmdBFuZsRQOJGn333r4E4huYM4Zg6aIBXu+VnyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJlLkQc1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733289036; x=1764825036;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=EpiONNx3Awea6gxAEJuEObBVvFNLhfiTReodoWPWfyk=;
  b=kJlLkQc1ToUduMRLPTTMgMoc7CG5U4ZjEPpCC4YAuMNHLVSPAaAU6cIh
   zeWPPQD8W/cGM+dYYnB4fEo1agX//CWhtq393TkB1Ba7vpSzcDJUkFAW0
   8F4NiAHKUO6akTvqgVMhdAiXPo/yrR0wPSmoAeA7O6xQ+Q6lwW39q/MZw
   V7ly9zPLM+LrB18a+AtCl/vbxHl9n+NZRRR11ImCeAmGiJeDSQbl57kwS
   uORxccAslGKmnujumZGKHceXe/h2SGHcRyYXTkIFLMOjC2Opb1ebcPzMy
   wk24qGuSydkmNf/a4fdzM7HZP4j0RSg7uVii7fcrG8pYXK1phqrEe4Tl0
   A==;
X-CSE-ConnectionGUID: fGatM1w+Rn2Ui0fmjy0RvA==
X-CSE-MsgGUID: zWKX3jeqThuuOW6JFiILRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="44566255"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="44566255"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 21:10:36 -0800
X-CSE-ConnectionGUID: 9F5oESZRS/Sqm0fMDQN3oA==
X-CSE-MsgGUID: LpeyXGqCSY22vyfm2VP2yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="94483009"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 03 Dec 2024 21:10:35 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIhei-0002bx-1w;
	Wed, 04 Dec 2024 05:10:32 +0000
Date: Wed, 4 Dec 2024 13:09:47 +0800
From: kernel test robot <lkp@intel.com>
To: Koichiro Den <koichiro.den@canonical.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net-next v3 2/7] virtio_net: replace vq2rxq with vq2txq
 where appropriate
Message-ID: <Z0_kGx5kqFdUZXed@24ad928833eb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204050724.307544-3-koichiro.den@canonical.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net-next v3 2/7] virtio_net: replace vq2rxq with vq2txq where appropriate
Link: https://lore.kernel.org/stable/20241204050724.307544-3-koichiro.den%40canonical.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




