Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A597763F48
	for <lists+stable@lfdr.de>; Wed, 26 Jul 2023 21:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjGZTLP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 26 Jul 2023 15:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGZTLL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 26 Jul 2023 15:11:11 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216EC1FF0
        for <stable@vger.kernel.org>; Wed, 26 Jul 2023 12:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690398671; x=1721934671;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=qQhB+ij1euS2a0im8T3b7oQJyZyn1NbDOhFBu7S9nWk=;
  b=dwKjZ6a4RG93XrfzgghzQGta5d8MlAPJJxls27oVG1L7nUlFEaUPtFat
   A3m/SsNitW/9fmg/doTsS267ncqMGL2IRmD8r6KmUg2sH1/nAtz86p0KL
   HlTp6KlLmVTKu5AwpZAXXpXqri7gwdEFn72aXCK4i4gE+h0LQUhNZusU5
   e/EOMFWjYazCpsFopKajJ6+6KsyL01/dnT6kQzh6WmNt8APIdJBt+Ss9Z
   OfyacDBpShRTgfC09Nd/YvSZfWhy+Twpe0EoaeS1PILMKDv8ziEB6cbgU
   /rrcmU61vcOtG0TMwYNOHtRdv7Rspz+rzT+rc//f+XlQJ+kVRZyd9EflZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="365569356"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="365569356"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 12:11:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="900549431"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="900549431"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 26 Jul 2023 12:11:06 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOjub-0001Dr-0d;
        Wed, 26 Jul 2023 19:11:05 +0000
Date:   Thu, 27 Jul 2023 03:10:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] vdpa/mlx5: Fix crash on shutdown for when no ndev exists
Message-ID: <ZMFvpmbXmk176Dy7@c507f7d2ae6a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726190744.14143-1-dtatulea@nvidia.com>
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
Subject: [PATCH] vdpa/mlx5: Fix crash on shutdown for when no ndev exists
Link: https://lore.kernel.org/stable/20230726190744.14143-1-dtatulea%40nvidia.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



