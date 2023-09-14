Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615C27A00B0
	for <lists+stable@lfdr.de>; Thu, 14 Sep 2023 11:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbjINJst (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 14 Sep 2023 05:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjINJss (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 14 Sep 2023 05:48:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F69E3
        for <stable@vger.kernel.org>; Thu, 14 Sep 2023 02:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694684924; x=1726220924;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=4p3zvVbNlEdTy4rKe0/r+q90zwKbdyf+gPaB+VColSI=;
  b=UNG5xAt9DUC2TZHa9S+hX1+k4AvUg8bF000BRPEyYZYtj1fANURr2tsS
   Baq3Su7AI3GRNVjUOEfmyCZ9d8QtkfaPUSnmz/yT6lA9A17jIoKD12ZVQ
   YWmCUvBI4GZjvIlcukwLFkZmROVvLlTVuQFJnPQPqAmZdHBJtXPUh4Jz+
   n0lXhVVPqsIe5ZRCm/xcM6J/HC4nDhkz3+Ipu2y/3bbQDwdpEN8f3qQnr
   aKp539dG6jHNAUWST3xMeZHEzEKQBXDXrGJIcETregVD6wmMSzu1ZshGI
   oPGygv6hbDhuBv/FQzmpTJPOVufn+BZs2gSV1alAPb+Q0UOHa89DRg0+m
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="381591157"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="381591157"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 02:48:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="721185753"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="721185753"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Sep 2023 02:48:43 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgixl-0001Sh-0y;
        Thu, 14 Sep 2023 09:48:41 +0000
Date:   Thu, 14 Sep 2023 17:47:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anastasia Belova <abelova@astralinux.ru>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 5.10] btrfs: fix region size in count_bitmap_extents
Message-ID: <ZQLWykRVfQf/0jxh@6fe19fc45f19>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914094555.25657-1-abelova@astralinux.ru>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html/#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 5.10] btrfs: fix region size in count_bitmap_extents
Link: https://lore.kernel.org/stable/20230914094555.25657-1-abelova%40astralinux.ru

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



