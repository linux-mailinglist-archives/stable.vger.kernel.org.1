Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3922775C493
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 12:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjGUKX7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 06:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjGUKXf (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 06:23:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5F4210B
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 03:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689935014; x=1721471014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=roGcLwE29qARgCVUB/cKB+LGRXB3cs5flNEyabnZoJQ=;
  b=Yl0eOUYYwCtMW3R/lMY0MXpf5+uoUPyn2UanOel1Jc5G3fduFMIY/aFo
   qaGGo6u4OB1J92e1a29Smwd/5/IdnW1gynK6M61fLqkML/l/kyj252zxa
   dWKykUURs2UhwLrEUOcwOTQ/RUT4UXkLx1ZipgeHsdoCb5W5jmrxqjKkc
   1VAn9HS5XTS67FICdj1KG6B+yEM0q4NF+X7gBdsYxMpSFCaCsx42wY9uW
   RlG/1czw/+Q07KCLioqr5d2eW0uoI1/o9trlFcwtu3G/3AkVCZ1MHyu9b
   9FlQzBHUC46HzQVzeNZyIUHX4J8BO/rW/Cm58sIxs2FL4BlcB/69uOYXa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="367027387"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="367027387"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:23:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="702001407"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="702001407"
Received: from hbockhor-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.54.104])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:23:05 -0700
Date:   Fri, 21 Jul 2023 12:23:02 +0200
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
Message-ID: <ZLpchtXWBYtF3bLl@ashyti-mobl2.lan>
References: <20230720210737.761400-1-andi.shyti@linux.intel.com>
 <20230720210737.761400-6-andi.shyti@linux.intel.com>
 <bb22e634-03ed-7c51-8211-8fb6d5a52570@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb22e634-03ed-7c51-8211-8fb6d5a52570@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Andrzej,

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
> > +
> 
> 
> Btw, not for this patch, but related: rcs and ccs have slightly different
> set of flushes according to bspec but this functions is the same for both.
> Is it sth we should address, or just safe simplification.

I guess this is not only used for ccs aux invalidation. I think
the BSPEC is specifying the minimum set of bits that need to be
set in the pipe control. So that I left it as it is and just
added this bit for MTL+.

Thanks,
Andi
