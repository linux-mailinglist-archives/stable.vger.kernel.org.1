Return-Path: <stable+bounces-58951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 600D292C683
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 01:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC33283688
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 23:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B81418563C;
	Tue,  9 Jul 2024 23:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NedMPovg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC77A13DB92
	for <stable@vger.kernel.org>; Tue,  9 Jul 2024 23:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720567067; cv=none; b=Yw+NkTrZniDwBd927MD7atuBDbZdXCCAVijytiPAZn9SU0kgvPyi0ZY8Kh3eVtfS73Je4LjnYYphL64CEYnb/+Kz1vAmGTqp58eHLhOILj6HbbZHwPC+nRuyAZorH2P4UhwU5mVmQUUfQMgD9+RfgEbAanUc2oLRoPUyjoqCe+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720567067; c=relaxed/simple;
	bh=8xJFKsNT0lFOi18WPQHPMRZWJTPWyn2o92XS9Ot8Nmc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GzSQRFWivF2sEb1LUn99sRlwaAHA8cQQQmdVCFM5uqP45Eo4NyG4vYtArelhkCCYfnt4mgb8GWYmSIPHuiD8X2d5fbr9r7MV+HKrZX0Q/56I49NrBB1dcCc6wGyM4yx+JbSiLlhUn3JxTM9luYeMaR3AKuf+j38LraqV597dhec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NedMPovg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720567066; x=1752103066;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=8xJFKsNT0lFOi18WPQHPMRZWJTPWyn2o92XS9Ot8Nmc=;
  b=NedMPovgZ766ehd2WFWDkAEz0k5TMtrKuF+ALIA6rBZOklT/RGUIcT94
   KvUwm7OE/pbEF1uPpVAWiGNPiYdo+l8qU8d4ktwbLdirruB0UC0GSss1o
   Rsi6GwpkShF5gG5Vv6GhlnSU4aNE4qJFzqnr7Qzehoo2EIExJ8vPbg/tH
   fK9zpOnUuNJrmd4fbAmAFdiUJy43FTfNItXrR6bXvHonqeIYlosAQhvCe
   SmN7JDNIybFgS8t4VTXrxcOe6YTnGZ+IjFHLJEB48IT46O9bsEQqxXKpu
   KSSURNXaramN9gvH83l47eehvO5OoJFtsjJ7mitfpmKeTkB8yDmyguTA1
   Q==;
X-CSE-ConnectionGUID: c9X/X7DLRMuNcYxw+u9Lvw==
X-CSE-MsgGUID: PLTSpSm6S7ShaNXrI/YVWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="28532090"
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="28532090"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 16:17:45 -0700
X-CSE-ConnectionGUID: cRPIDrO8S4OxlJT7prwXcg==
X-CSE-MsgGUID: iM7yXKWFSyuy3FEpeisAOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="78751035"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 09 Jul 2024 16:17:44 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRK5e-000XE6-0C;
	Tue, 09 Jul 2024 23:17:42 +0000
Date: Wed, 10 Jul 2024 07:17:14 +0800
From: kernel test robot <lkp@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.1] x86/retpoline: Move a NOENDBR annotation to the SRSO
 dummy return thunk
Message-ID: <Zo3E-l8Tfc3HfNfF@6724a33121ae>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709141238.GJZo1FVpZU0jRganFu@fat_crate.local>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 6.1] x86/retpoline: Move a NOENDBR annotation to the SRSO dummy return thunk
Link: https://lore.kernel.org/stable/20240709141238.GJZo1FVpZU0jRganFu%40fat_crate.local

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




