Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088307E481C
	for <lists+stable@lfdr.de>; Tue,  7 Nov 2023 19:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbjKGSUP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 7 Nov 2023 13:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjKGSUP (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 7 Nov 2023 13:20:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ACBB3
        for <stable@vger.kernel.org>; Tue,  7 Nov 2023 10:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699381213; x=1730917213;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=cqreSqJ2Fe43ZhNmJCLMVLlQQ5hJTL/XWdNJSbHvhIE=;
  b=PmzyjtK1gMYH9KF2ZQuojOuYkv8TuZjJrTPoFBdJj2MHfmbICD/n94r0
   BPZlRdEVXDGP+vTF+ZeY0oXoXMJWqZDHbbiO7Dux+xl8xQrinW3St3EaK
   49pRSYRfPART/81dfFjSeJqDIMtCOGMh2v/BWoHo+LJAWFno/tHCxP6TD
   nEhwzZnRZWZR4lfA9f+TP/ktlpr6m/CMDrMAp192PRf6Es9JGn3p+o5cr
   QIkVNevaLajSREcFg5hz1gT6BhbfLSYvbCnPTZ/16qWP4i95rvbJy84fZ
   Kj8ej7Gl+KU/ReZNJgfoFGsyl2c7uVuv2XMrpsVwOhE9vpJLBClPVsv6o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="420686478"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="420686478"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 10:20:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="906501356"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="906501356"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 Nov 2023 10:20:11 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0QgL-0007Iy-0c;
        Tue, 07 Nov 2023 18:20:09 +0000
Date:   Wed, 8 Nov 2023 02:19:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] mm: Fix for negative counter: nr_file_hugepages
Message-ID: <ZUp/wYecMvCKQeAg@b4d6968193cf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107181805.4188397-1-shr@devkernel.io>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] mm: Fix for negative counter: nr_file_hugepages
Link: https://lore.kernel.org/stable/20231107181805.4188397-1-shr%40devkernel.io

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



