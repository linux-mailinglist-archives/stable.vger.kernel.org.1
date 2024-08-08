Return-Path: <stable+bounces-66029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED12094BC83
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 13:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD331C221DC
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 11:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA9618B469;
	Thu,  8 Aug 2024 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a4SyW0WA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C2518A6A1
	for <stable@vger.kernel.org>; Thu,  8 Aug 2024 11:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723117887; cv=none; b=EJyP5IZDgqgt7OFMM8Ekq4lxQXXQUjseCqtA+sgFBVsT1vptSOwa32MspsEcvIPJc1KvzbDtx42X/1pX3eoDcoDfQMgLhvBQJIJpkvQ0Mzf2b+uOEpLWIWlLOjk2Ayoo8kQXA55Z0TBNi+FRJKy1uvUXEMKYTHA/Q6ZFkpWL2/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723117887; c=relaxed/simple;
	bh=dmYkPnzispasMulAOj+Zz/tjlu7fEuGaXS08SwlP+UY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Fu7Nptj62mZGw1Uv28hi5TNdR5zJlH1GsYPMnDNq4QE0tFETWUfhkkJZG3JZCMR5uWrYn7ZwOdHfP/PtGufnPVu+Y9NWKXNrw27JfNGOvujk2ByM9qLVZWtW0UCBSDfGSxdmtRzH3bFiE0Cth3rU6H+znizH5Llc2LJmWI/NuEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a4SyW0WA; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723117885; x=1754653885;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=dmYkPnzispasMulAOj+Zz/tjlu7fEuGaXS08SwlP+UY=;
  b=a4SyW0WAL4fWtJiTm5tVwvUjqjEnRp8DGQXOraIUQ4ub8s2qmpOatLI1
   mDP7olGjf9yn9BBd3eHiVv5JJ2SSBMLVSMtO2cds3/99wzPpn3OXAOEVa
   K6Tcjhhg9rJSIuigsL2wiBCAkgUXFzHEa/UEKXI64GO/DBoQqneT91T8V
   ObvvBRZAJE9ZVd3YzHNqcVk6sxZyAomHwbVY9nt4Zz6daf2H/X2nRiLcq
   zdkt9R03N3ed5XoXGgWgRHKYRhhEwK/cY/WQwHGHvQ/rZEt8Kp5TCNUrH
   DmcENrXA8OwTJ1KcrWD8PL/xhbDDsGwhk8Sir2a2r4fWDQMvW0yFEOzTr
   w==;
X-CSE-ConnectionGUID: xfBzDz0aQMihml3CNIZGTg==
X-CSE-MsgGUID: aWNmh3rHSvuhJAWi7xPFlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="38693642"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="38693642"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 04:51:15 -0700
X-CSE-ConnectionGUID: DqmpC3O9RTy6BQlXYPJXTQ==
X-CSE-MsgGUID: Kr9AezGmT/SmEGpw/sJKgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="62145642"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 08 Aug 2024 04:51:11 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sc1fg-00069Y-1z;
	Thu, 08 Aug 2024 11:51:08 +0000
Date: Thu, 8 Aug 2024 19:50:15 +0800
From: kernel test robot <lkp@intel.com>
To: David Howells <dhowells@redhat.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] netfs: Fix handling of USE_PGPRIV2 and WRITE_TO_CACHE
 flags
Message-ID: <ZrSw9xfiAfioByuc@51a50089044d>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1068323.1723117607@warthog.procyon.org.uk>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] netfs: Fix handling of USE_PGPRIV2 and WRITE_TO_CACHE flags
Link: https://lore.kernel.org/stable/1068323.1723117607%40warthog.procyon.org.uk

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




