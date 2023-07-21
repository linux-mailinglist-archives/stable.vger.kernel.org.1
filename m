Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD4D75C70C
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 14:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjGUMpZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 08:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjGUMpY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 08:45:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF94530C0
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 05:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689943520; x=1721479520;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1ywFgKtUbH+wD6Lt8cjDXh1JtExA8Tc0v2vAW2ZA8Ho=;
  b=ioOsSOol7ixLr+XR++rB/vsml39YhBnDsTJWxllXULZJkFmN3IcCnG67
   ancm4lIcHX/QW88BBFNuv3CVUZtbULRnqz46qpKamv1m1zpmb5CJwFCLB
   m7cLU35+tGoT0kYEaVP0SqxpWJ7MF9v/Kygqs+yOiZzvqMzUOVtkx2Z7E
   28vUwMsAkyrfZ25Wn042wBabfB/rJ0mtORP/hrQfJesCza6CUOiT0k3JU
   ljaVRYPYYW/D+LVOLlAj1h6Q86MSLvPrslSfOZAZTuiWxuGZLtvckjUJj
   S/Jn44gvDAI4pekNspuSl1/yPdwAcLEozzw/3GOfI/uoJ3Gxz32nzTN1W
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="370618313"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="370618313"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 05:45:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="868235335"
Received: from hbockhor-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.54.104])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 05:45:16 -0700
Date:   Fri, 21 Jul 2023 14:45:12 +0200
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
Subject: Re: [v7,7/9] drm/i915/gt: Ensure memory quiesced before invalidation
 for all engines
Message-ID: <ZLp92B6lpao5HCYQ@ashyti-mobl2.lan>
References: <20230720210737.761400-8-andi.shyti@linux.intel.com>
 <2614817.k3LOHGUjKi@jkrzyszt-mobl2.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2614817.k3LOHGUjKi@jkrzyszt-mobl2.ger.corp.intel.com>
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

On Fri, Jul 21, 2023 at 12:10:22PM +0000, Krzysztofik, Janusz wrote:
> Hi Andi,
> 
> On Thursday, 20 July 2023 23:07:35 CEST Andi Shyti wrote:
> > Commit af9e423a8aae 
> 
> You can't use this commit ID, it is invalid (the patch you are referring to 
> belongs to your series, then is not available in any official repository, 
> hence no stable commit ID yet).

yes, I need to update it, I know... this has changed at every
revision, but I was lazy and decided to do it at the end after
the whole review process was done. I didn't think that anyone
would go and check it :-D

It's good to know that there is a thorough review here! Thanks!

> > ("drm/i915/gt: Ensure memory quiesced before
> > invalidation") has made sure that the memory is quiesced before
> > invalidating the AUX CCS table. Do it for all the other engines
> > and not just RCS.
> 
> Why do we need that now for other engines, while that former patch seemed to 
> suggest we didn't?

This whole work started from a a couple of patches from Jonathan
and slowly exploded in this series of 9 patches. I tried to
preserve his work and just add things around them.

What Jonathan originally did was to add aux invalidation support
only for RCS and Compute engines, but then hardware guys updated
the docs asking to do it for basically all the engines.

Thank you,
Andi
