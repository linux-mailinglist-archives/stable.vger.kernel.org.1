Return-Path: <stable+bounces-3096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62857FC904
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 23:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 622C828289D
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 22:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE4B481AD;
	Tue, 28 Nov 2023 22:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gWHPI+QP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA50F19A
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 14:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701208977; x=1732744977;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Bzsxc1dUICg1Vhw8VrTeoSIPB8poDOQR29TGkACiujQ=;
  b=gWHPI+QPGXV5OldNPvgiyUeGWVa4Ckz5g/TTQTclIrr3eB3JsdIePCzn
   AG/Yc3HDxG9KkzzUFlwniM5++rrb/ASz6XHJyjD8xBX0YWP2Jk/nQN5fd
   eBSSiob/BfXyoJY9y3jbpSYlFChP7p+gKkmAbrkSm5jsUO4WSuHDjD6a6
   q+hDem/Z8akqFCjfc6/uUf8kL0MqRg9pSc40pWhXkgrpU5TQ/oJXP/79n
   HFiUV+YWPakcarV7s5U5Pi1Mm6aBaftIDBkMB1fFsqHjCV4FFpnagSLiy
   lhPB8UDg0NqeuiFp73DLJ+AcNMz4ZTUTtXstDb3BgsxXCajR81oea6B/F
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="391903585"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="391903585"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:02:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="859582301"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="859582301"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Nov 2023 14:02:56 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r86AP-0008Am-31;
	Tue, 28 Nov 2023 22:02:53 +0000
Date: Wed, 29 Nov 2023 06:01:01 +0800
From: kernel test robot <lkp@intel.com>
To: Chuck Lever <cel@kernel.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/8] NFSD: Refactor nfsd_reply_cache_free_locked()
Message-ID: <ZWZjHVscdrNKXRLv@520bc4c78bef>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170120877882.1515.3190174495040446432.stgit@klimt.1015granger.net>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 1/8] NFSD: Refactor nfsd_reply_cache_free_locked()
Link: https://lore.kernel.org/stable/170120877882.1515.3190174495040446432.stgit%40klimt.1015granger.net

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




