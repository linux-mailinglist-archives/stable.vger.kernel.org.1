Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9F0727049
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 23:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbjFGVIq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 17:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjFGVIp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 17:08:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8776E4
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 14:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686172124; x=1717708124;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=UeHpEIaj26GpUP5IYCU1e0+WwoHn/3OuH4lzcnE55yc=;
  b=Z4cop3J0r3vK9zGgqu42P6thJQM+QcaSMsn10ci8v/axE92O6+t/jhJI
   Ywsk1p4LQ9szm8nEswWVKiJ3lUySmmfXbzqxV7MphKEQYnXHjvl+412aF
   czHJp1KvSHgrOPitSEROqbQrQUiRiIe6WpUp3jb2z6AYcmOz65nuzHxwA
   CRLAPVuws47qe0UR6TVazQ5Xr7O3wrxmYaxY0hoDciUNlKkAyhGNf9iWI
   C0P3hbX4hkQhtilCOZ7CuHNZ6X8w3be/Dtrfu50kdA8BiteaqmP5O2G3k
   0LXTaxvPLSpuRaNV4a1yxWTGAEqTFbeO4rhyvF4Mjt3n9HYOz+k7CHDBh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="354598655"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="354598655"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 14:08:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="712833493"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="712833493"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 07 Jun 2023 14:08:43 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q70OY-0006uf-2J;
        Wed, 07 Jun 2023 21:08:42 +0000
Date:   Thu, 8 Jun 2023 05:07:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH bpf v2 1/2] selftests/bpf: add a test for subprogram
 extables
Message-ID: <ZIDxpjpcp7EqWTsH@a93e062a6cea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3d55cfd8ce7ed989c997d1e3ea2678879227300.1686166633.git.kjlx@templeofstupid.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

Rule: 'Cc: stable@vger.kernel.org' or 'commit <sha1> upstream.'
Subject: [PATCH bpf v2 1/2] selftests/bpf: add a test for subprogram extables
Link: https://lore.kernel.org/stable/c3d55cfd8ce7ed989c997d1e3ea2678879227300.1686166633.git.kjlx%40templeofstupid.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



