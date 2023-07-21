Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB6E75C413
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 12:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjGUKLD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 06:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGUKLC (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 06:11:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFB5171A
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 03:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689934261; x=1721470261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Al5aUp8ePEY0ACoKiXGKNeHQh4fxfQ0rqihDe6wd1zw=;
  b=Q4iOsjswQ+LpnBd5bXhlBrjxUWaIeXqlso1t0dcGq2RX79T9cVBvzJoS
   vpzD0kkY2NzouBxKmfI/vL0lSwNuGc1u3fhlobb0KzdKqx6FoOtr/0SH5
   zZvsp/ZazpFtyRXwIl870hbSmWri2HMtsOxTwpB++TXcORnpz8ZkHxhUo
   c1gj+PqwvRucPTmOXEP9wV5VgamFHrYloNmRzdjZDcJSCn9ED/OJoB3HJ
   7Hpfc/QiWjynoE3Og8XjrdbyHvjringRUMOMDjBmeJVCB0jpqm6EjZJdu
   WVBqwhlMPgxI0ZrxCCCWiPkkrzhlawrLbfdWZzNOu0moEDYDT+jMIyaAS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="346581447"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="346581447"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:11:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="674991372"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="674991372"
Received: from hbockhor-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.54.104])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:10:56 -0700
Date:   Fri, 21 Jul 2023 12:10:53 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     Andi Shyti <andi.shyti@linux.intel.com>,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        linux-stable <stable@vger.kernel.org>,
        dri-evel <dri-devel@lists.freedesktop.org>
Subject: Re: [Intel-gfx] [PATCH v7 5/9] drm/i915/gt: Enable the CCS_FLUSH bit
 in the pipe control
Message-ID: <ZLpZreofxcoNbGyg@ashyti-mobl2.lan>
References: <20230720210737.761400-1-andi.shyti@linux.intel.com>
 <20230720210737.761400-6-andi.shyti@linux.intel.com>
 <0dc607fc-33ac-cebd-9303-873711dcc5d0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dc607fc-33ac-cebd-9303-873711dcc5d0@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Nirmoy,

On Fri, Jul 21, 2023 at 12:05:10PM +0200, Andrzej Hajda wrote:
> On 20.07.2023 23:07, Andi Shyti wrote:
> > Enable the CCS_FLUSH bit 13 in the control pipe for render and
> > compute engines in platforms starting from Meteor Lake (BSPEC
> > 43904 and 47112).
> > 
> > Fixes: 972282c4cf24 ("drm/i915/gen12: Add aux table invalidate for all engines")
> > Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> > Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
> > Cc: Nirmoy Das <nirmoy.das@intel.com>
> > Cc: <stable@vger.kernel.org> # v5.8+
> > ---
> >   drivers/gpu/drm/i915/gt/gen8_engine_cs.c     | 7 +++++++
> >   drivers/gpu/drm/i915/gt/intel_gpu_commands.h | 1 +
> >   2 files changed, 8 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> > index 7566c89d9def3..9d050b9a19194 100644
> > --- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> > +++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
> > @@ -218,6 +218,13 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
> >   		bit_group_0 |= PIPE_CONTROL0_HDC_PIPELINE_FLUSH;
> > +		/*
> > +		 * When required, in MTL+ platforms we need to
> > +		 * set the CCS_FLUSH bit in the pipe control
> > +		 */
> > +		if (GRAPHICS_VER_FULL(rq->i915) >= IP_VER(12, 70))
> > +			bit_group_0 |= PIPE_CONTROL_CCS_FLUSH;
> 
> BSpec 43904 mentions also other platforms. Why only MTL+?

This is the process of quiescing the engine and that is done in
the pipe control sequence.

In the pipe control sequence each engine has its own sequence,
even though render and compute overlap on some bits, while the
others overlap on other bits.

Besides that MTL+ need this extra bit to be set in the pipe
control and that is bit 13 defined as PIPE_CONTROL_CCS_FLUSH.

Thanks,
Andi
