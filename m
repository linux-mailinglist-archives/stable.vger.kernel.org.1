Return-Path: <stable+bounces-28626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A34A8870CD
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 17:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C391C22C38
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 16:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BB856B76;
	Fri, 22 Mar 2024 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RoUJhb/j"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D8554BF7
	for <stable@vger.kernel.org>; Fri, 22 Mar 2024 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711124670; cv=none; b=PaijO6dWkhnbjEpAb6fRB84TsQgIQFv7qU1TSaWvXvBv7God+wUkH6HeRSnavgeQzpDGErnPr5fthXosTOYzazPcOTaU0S6lcP5tKFgW3oXz0S9r9Oawyfl2X662cbT0HACqkhtxq3rDKeX7vrjdhBpG17kU0lxo3wdHD/LOs9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711124670; c=relaxed/simple;
	bh=ITGp7ggrsxODmpVpH8hzjqT9j/avBBkrwVgI+83TStE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oDgcVpys5tou30uTrhyrXfzLeaoHolQdozvJDcTtUtU90YnoiM4Jmxbe5w9PIBj4yGY+PEHKjCqsqJP0WbuwtoiC3iYoQkakahZ9fIGaQejlJbTt+YVqjkqCO2b0e+QD0eSmQ1i8WxuguoG1khbVwwqiRn81GjOtt9nV6CKVbpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RoUJhb/j; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711124669; x=1742660669;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=ITGp7ggrsxODmpVpH8hzjqT9j/avBBkrwVgI+83TStE=;
  b=RoUJhb/jn+7U62Xgd2nFyRBM3KS79j/AsmS9kxvetT+xll0Tk/NfDyAa
   qyPqhIAL7Fo0aop5nmsmp9/DG6/D9kkbul3JtuoBNK1hiqkWV6gCZBnk/
   bcnqaPsel4FZN6qjvwxv+vaRuXU59064jYQv/l6r8CFqF5qBl/vR97/mT
   OKaFkLFdN2bT8SsyeKUCIP4FVgeYcVauISzcu7ByzqxVezlXFLa27E7Ce
   5MD3YInq2EgKKAgpKFS5E1Pur2dZoGSe/nvW0d2HpWzX1tCa6zK0JKkfe
   kjBuDTlSpvDDFvOVhKNKi7+FXuak1r6ZD6xGSIOJXBsXPB6wRB+LH5Qbx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6293082"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="6293082"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 09:24:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="15364244"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 22 Mar 2024 09:24:27 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rnhgv-000KQX-0t;
	Fri, 22 Mar 2024 16:24:25 +0000
Date: Sat, 23 Mar 2024 00:23:27 +0800
From: kernel test robot <lkp@intel.com>
To: Steve Wahl <steve.wahl@hpe.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] x86/mm/ident_map: Use full gbpages in identity maps
 except on UV platform.
Message-ID: <Zf2wf8MHQAmJQpII@f34f6e606ddc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322162135.3984233-1-steve.wahl@hpe.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] x86/mm/ident_map: Use full gbpages in identity maps except on UV platform.
Link: https://lore.kernel.org/stable/20240322162135.3984233-1-steve.wahl%40hpe.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




