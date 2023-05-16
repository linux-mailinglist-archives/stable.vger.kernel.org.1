Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A9C704239
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 02:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245188AbjEPATs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 20:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244856AbjEPATr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 20:19:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A18D6E8A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684196387; x=1715732387;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=4U46PVwQJLgW+Vl8Kx+BVXEcb3nvvxhpNLneH88J8H4=;
  b=E+uUeHabYMevtkdlxjLzV4NiBr/8dkDVd8RbjkpXjDpfXIhsa7esLy3A
   cXmzXkRUX3/iX060T6/D9vETEOfczJLGdAg4Kj++Af16ND9pAcckFwfgS
   aWIRKLhIoyxAGO00KGSoLdYEnpwLfOtkQu9JJQOSCYBDSaaMVJwPG+PvK
   ufAcNwgotf6y671+7mqou6xOKHl15YcJbZFKJ5DXk4NVg5cml2cpfojLm
   f4GDbAr0K0II9XQmRfZGbMRDYxk5WHxLTYKeYiG4X7lTYW/grRIALqWoM
   Ep0Lp9uJGN53Fk4dumVvwTcVxpiEj+mEEgz59+CwP8Bpbk8TTxWjruFwP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="331704962"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="331704962"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 17:19:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="790857636"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="790857636"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 15 May 2023 17:19:45 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pyiPo-0006mg-1h;
        Tue, 16 May 2023 00:19:44 +0000
Date:   Tue, 16 May 2023 08:19:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sagar Biradar <sagar.biradar@microchip.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3] aacraid: reply queue mapping to CPUs based of IRQ
 affinity
Message-ID: <ZGLL/THrnaGX4J9o@e0f96cf4e6cd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516001703.5384-1-sagar.biradar@microchip.com>
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
Subject: [PATCH v3] aacraid: reply queue mapping to CPUs based of IRQ affinity
Link: https://lore.kernel.org/stable/20230516001703.5384-1-sagar.biradar%40microchip.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests



