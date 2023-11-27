Return-Path: <stable+bounces-2804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8FB7FAA83
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 20:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79BD1C20D24
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 19:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EA53DBA5;
	Mon, 27 Nov 2023 19:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b6Oe0Whg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC22DE
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 11:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701114106; x=1732650106;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=JNMNwsR1XgdscG9qL/LMcXXpW0ddJiGTcECl6rD9lr0=;
  b=b6Oe0WhgfTWvzYugi1Uy4folJfH0I4HwOXioDnybijKN+lCmPtrduoqq
   xvSzZs4s86BTcF9C9mP0W2739XjrJjkxdg0rx9bVHMeI8q5aQGnESQlTt
   fvqU2SsrWJ3xVYkPhdU0lfdQY/wgXikb6CRgnoZQkswKG5SN9kxoOXLV/
   +63ujkBz5fVx+RFsmhyWpjAGZ+cJ/7mZxXJaK3R+VhmjES4dJlYW/B5xn
   5+P2vPt5F3PsBDNdliVGYRa8Y9C2QulTSQjhdCxBC+1f7po21DqxKQIPi
   zJSYlaJJJhYlM1z4nCVqoAvTjMRMU9V+bLTZHka0AkOpKE2Yrgdy+lohN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="392528239"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="392528239"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 11:41:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="802746053"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="802746053"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Nov 2023 11:41:44 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r7hUE-0006bk-1H;
	Mon, 27 Nov 2023 19:41:42 +0000
Date: Tue, 28 Nov 2023 03:41:04 +0800
From: kernel test robot <lkp@intel.com>
To: Hagar Gamal Halim Hemdan <hagarhem@amazon.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] vmci: prevent speculation leaks by sanitizing event in
 event_deliver()
Message-ID: <ZWTw0LfcGH-mL4_F@520bc4c78bef>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127193533.46174-1-hagarhem@amazon.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] vmci: prevent speculation leaks by sanitizing event in event_deliver()
Link: https://lore.kernel.org/stable/20231127193533.46174-1-hagarhem%40amazon.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




