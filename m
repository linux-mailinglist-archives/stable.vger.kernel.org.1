Return-Path: <stable+bounces-4700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8E58058F4
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 16:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC3701F21783
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 15:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCE25F1E8;
	Tue,  5 Dec 2023 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UhJVfC0R"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1D210C2
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 07:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701790781; x=1733326781;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=pDMlfjIK+FXlrFwXf3T6Y7ndgKfj5NZon/tI/R9KD4c=;
  b=UhJVfC0RDMZalLf1mLrt77aeLF3AfOgjGlZEM1veMTe0dQi5Zr+kNQ5U
   D+1aD2z2eRfLBGx6ylbVy3xs8xMNwTcP9Q1sP7gP411fYIG+9nrIvln3L
   /j72vwpaLuEjmZT9NzSD0ORDX1bP20Rn5yWvDtJ2+GE7c0W8FHrz0+AXj
   tKVzyatEmO/Dg03g1xxIuWARd/CSsmJ/Yj/najUod2ADqAXybdj1V8Th7
   XEjZSl9snJoPhukO+wTVLT9rmLk2GiP9e415qVakp7FBkiq2ID2F333F1
   AG+DseJt7fJVB4J8L4AS/tg4iOsz0mILgVWrMQ9oJLTPHElW49AmjmHUX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="460396643"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="460396643"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 07:39:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="770959778"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="770959778"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 05 Dec 2023 07:39:40 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rAXWL-0009Fe-2F;
	Tue, 05 Dec 2023 15:39:37 +0000
Date: Tue, 5 Dec 2023 23:39:22 +0800
From: kernel test robot <lkp@intel.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4 4/5] pci: move devres code from pci.c to devres.c
Message-ID: <ZW9EKm9W2tbRfHfg@5b683c117983>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205153629.26020-6-pstanner@redhat.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v4 4/5] pci: move devres code from pci.c to devres.c
Link: https://lore.kernel.org/stable/20231205153629.26020-6-pstanner%40redhat.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




