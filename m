Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FBE7174FF
	for <lists+stable@lfdr.de>; Wed, 31 May 2023 06:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjEaERg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 31 May 2023 00:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjEaERf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 31 May 2023 00:17:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F56C9
        for <stable@vger.kernel.org>; Tue, 30 May 2023 21:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685506654; x=1717042654;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=qUabQjz9II247iFOOabpXWHtBRce/lkLHc/UWIqTl2w=;
  b=bNM9m6YcnEuQ1AUGBorRK6Y++n6rXQPPL9a4RSJo2Ne1dgcVfX8L+MWt
   F6ZpdAqULPUQ0GNGWCawhR5afhhyUfCkNng3TdeSNYCjcQC/6cNrUdVJI
   IgtMhwUZ2joEFm6fN+O4ZGCBwjAX3ZTMWO2xd7LcN5x0526vxBQTFD2sL
   eiE6iaGbV9272cf+DTkTG3xpLSS5R3ECbpZH2pUk0qPEQEtZEGJJSAP+y
   IAkELUJYVSvNF1asTZZOEX8nqEKsebmn+IKjCTS8vixOaWs53hxJk8/o7
   ieDmpiJYWVhN/XU6BTZraV7gi8Vw46efVuuhjX5pWjTJCPr9B3nxavRZj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="339724547"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="339724547"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 21:05:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="831062117"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="831062117"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 30 May 2023 21:05:58 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4D5x-00014N-2T;
        Wed, 31 May 2023 04:05:57 +0000
Date:   Wed, 31 May 2023 12:05:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 3/3] usb: gadget: udc: core: Prevent UDC from starting
 when unbound
Message-ID: <ZHbHpMlIxKO7zwfZ@b4b7677a4534>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531040203.19295-3-badhri@google.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
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
Subject: [PATCH v5 3/3] usb: gadget: udc: core: Prevent UDC from starting when unbound
Link: https://lore.kernel.org/stable/20230531040203.19295-3-badhri%40google.com

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



