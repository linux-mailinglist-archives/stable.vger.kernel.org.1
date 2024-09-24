Return-Path: <stable+bounces-76969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E899840E9
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 10:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282FF1F217C2
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 08:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973D9149DF0;
	Tue, 24 Sep 2024 08:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WkTe3WzG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08151537C9
	for <stable@vger.kernel.org>; Tue, 24 Sep 2024 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727167573; cv=none; b=sRY+aUbOkd2EcgTRVsmN2Z2q3+pcXE5aq6ZTjdBLjp0IX1fjNyLEZFTW5kPEUG0JlsTn12EGl87j1Zu5VC86NI5k4WVemh2cOyaQF7i5ENtSTaZ91f3y+jokgAlC19zRLLYukyVGUN8h9c7/a7nbTStVAQuj85b/EquhMZuKsrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727167573; c=relaxed/simple;
	bh=Ce69RvO5h0xWZhvC2+Rg6PshsL5YrP6R63bLK1StmlY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PMt0/ODDC1xo0nrIIi8mkG2b4drk88Gqpvf76quHkLXyY+GBN6md/C3tZpoeea9H14JwwaNUTizoOlc/knm5OCE0kRnzqMRqojk67duVvTlVaJvm9WNsTRRYbzdZjo3E6fY1iNEBnuZGsdcnSSFZJYDQnryPpowVraUJBJoiBTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WkTe3WzG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727167571; x=1758703571;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Ce69RvO5h0xWZhvC2+Rg6PshsL5YrP6R63bLK1StmlY=;
  b=WkTe3WzGN0zvtMoRMX3CiC5DUjFcV3p3PcoehVh/7rRUTqDn0TwVPnZ/
   /yMS/ehDaSA46jlVQ6xIr2ItO8oAOEZRF++C3m52syOwdSlqX+2bIa4um
   ebnBWGacWdxUsZDHkKABxQXTL+yoURObScJPiwWstpHFOX8r9DrjBlh2C
   HVAYIqgzDRbIZLHLA5oNHd1PtXfbXlXcHVxjWTf9X3mbtCvmuyXkXklmh
   IpjgwOjmj87W0jd3st6rwjuTSUrMuEJ02LhaW57fn9HvJAZLM40OOvKgO
   6M6WAOR9xsN5yx2ufDutFGZjkDfPdF54+Hm+EJ3i+Iho46ZYNorP6ozQ5
   w==;
X-CSE-ConnectionGUID: fbMgGphLRw2P4hnQymVy3Q==
X-CSE-MsgGUID: OKb7PceJQqaYOASjW+imkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="26242902"
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="26242902"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 01:46:10 -0700
X-CSE-ConnectionGUID: N0Azc3ZLRKWQoTzs/Bfavw==
X-CSE-MsgGUID: /8cJdfqpTN2nkk5bJ6BK9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="75869777"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 24 Sep 2024 01:46:09 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1st1BO-000I7x-2V;
	Tue, 24 Sep 2024 08:46:06 +0000
Date: Tue, 24 Sep 2024 16:45:23 +0800
From: kernel test robot <lkp@intel.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCHv2] usb: yurex: make waiting on yurex_write interruptible
Message-ID: <ZvJ8I9B3nIMpWGnY@5849f93d069a>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924084415.300557-1-oneukum@suse.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCHv2] usb: yurex: make waiting on yurex_write interruptible
Link: https://lore.kernel.org/stable/20240924084415.300557-1-oneukum%40suse.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




