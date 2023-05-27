Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463567136FB
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 00:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjE0WW0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 27 May 2023 18:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjE0WWZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 27 May 2023 18:22:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9660D9
        for <stable@vger.kernel.org>; Sat, 27 May 2023 15:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685226143; x=1716762143;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=yK1qtllN1lGwDPqXZyRZ6af8naRaW3Rq1ITjJb5gjns=;
  b=Auf7NYOpMPlpQbK5GRmMYiucN6OeRfSkJmwpxWg9uYqwQ0LjKZqHudhT
   xV3iJcaYaFK/yB3IXj1BzobzLqmyR5FoFA0oCfmTppVgEIvlzxwwYus1a
   gp9NPAbfWSWhQKQtsi7OMFw4BaFzhj6P6k5Jak5YmiNkYtn8bugaBuzAy
   6cWzDL68hv94nxbbCOc9+KMtqb7ej2W3FxP7qkwVcDClr17JvU3GT/o7x
   NI3/pOJRv+QFV/RflLjr2KkeLFyxQQeYLyvPNbyLTOb8xuVF/MI4vVr9F
   KjuOdJzXHU5RZtQh7E0i02o94dpoLafsxznrac2ljHnyVVl3XeCmYVrNP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="351952850"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="351952850"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2023 15:22:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="775470764"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="775470764"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 27 May 2023 15:22:22 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q32In-000KDW-3C;
        Sat, 27 May 2023 22:22:22 +0000
Date:   Sun, 28 May 2023 06:21:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH, STABLE 6.3.x] xfs: fix livelock in delayed allocation at
 ENOSPC
Message-ID: <ZHKCZhLmienVrL5I@3bef23cc04e9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHKB/KD1yyx77fop@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

Rule: 'Cc: stable@vger.kernel.org' or 'commit <sha1> upstream.'
Subject: [PATCH, STABLE 6.3.x] xfs: fix livelock in delayed allocation at ENOSPC
Link: https://lore.kernel.org/stable/ZHKB%2FKD1yyx77fop%40dread.disaster.area

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



