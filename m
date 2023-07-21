Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7693C75C694
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 14:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjGUMJ0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 08:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjGUMJZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 08:09:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7875E19B3
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 05:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689941361; x=1721477361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SwrcA9sTJRVaDzGBUug5hrRnJ4Kkdw2wtJDmFY8ttGA=;
  b=bLG/5hiYRzk92Md9B7T08l9ZVL8LgJTvOgyin6dvngxS1lAY5bNGLPI8
   k5YsND207E0ad9U79dOG0Jhv7DyZ606BriyiNkRjySrQZoZTwDHukjkLl
   0/HYZhQSXM6rhVGkI9QqVc6bWnn3nBDW8Y+z21Dyij36Ym+BcphAcx8OQ
   0/NQiU9e7meu+9P8hpWzS56zarh1NRlf5DOE9Yscaw2JgtsCuoU6cjoJO
   0p32HKAc/XRjVZ28ugKBwr5NAa68QQGEQ1CjEUZeE+ARlukl5HuwpqSFw
   CMhA1rHcZRFX2Cs5LMpOCv2gDWdZydti+FnP+9e1nPxZIOOGmVXljWGMA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="433238524"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="433238524"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 05:09:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="814924617"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="814924617"
Received: from hbockhor-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.54.104])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 05:09:16 -0700
Date:   Fri, 21 Jul 2023 14:09:13 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     "Krzysztofik, Janusz" <janusz.krzysztofik@intel.com>
Cc:     "Cavitt, Jonathan" <jonathan.cavitt@intel.com>,
        "Roper, Matthew D" <matthew.d.roper@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        "Das, Nirmoy" <nirmoy.das@intel.com>,
        "Hajda, Andrzej" <andrzej.hajda@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        linux-stable <stable@vger.kernel.org>,
        dri-evel <dri-devel@lists.freedesktop.org>
Subject: Re: [v7,5/9] drm/i915/gt: Enable the CCS_FLUSH bit in the pipe
 control
Message-ID: <ZLp1aa2lbM3abmBG@ashyti-mobl2.lan>
References: <20230720210737.761400-6-andi.shyti@linux.intel.com>
 <4155037.1IzOArtZ34@jkrzyszt-mobl2.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4155037.1IzOArtZ34@jkrzyszt-mobl2.ger.corp.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Janusz,

> > Enable the CCS_FLUSH bit 13 in the control pipe for render and
> > compute engines in platforms starting from Meteor Lake (BSPEC
> > 43904 and 47112).
> > 
> > Fixes: 972282c4cf24 ("drm/i915/gen12: Add aux table invalidate for all engines")
> 
> I'm not sure why you think that your change fixes that commit.  Can you please 
> explain?

Hardware folks have provided a new sequence for performing the
quiescing of the engines... that's how it is :)

Thanks,
Andi
