Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA0C75EED8
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 11:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjGXJOz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 05:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjGXJOp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 05:14:45 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D7F10C8
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 02:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690190084; x=1721726084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q9VW+kxIEMRkkLyl4DqyG1uVPVD+dhO/5CYN521JQtQ=;
  b=a1QnLg6oMfUkE6NMvyboU0A9ZO56WBIDQ01vxDE/j0QO0NDhUW6Z0HNV
   1qepSgQ4Mucc7WhAfvuiLxSWimgx3nF3EzFC4Y6xciYEV5bSnEoG6bEOz
   fEN+8aK9mXn2BAE1aJgiYNE77wmtEJ1wwKLUngK2L+M/8um9pLQfsT6Qr
   Xd+1rin+rjGYlUv94lnduKXnLw5igXG6W/Wjf1nzt9u0ci2lFQKX5Vmfo
   GwQtA/H68r/IIuLTgQAlO+vSg/VE/ZyUyF8p+SzZ/3s19zna/TSRUUkcY
   ATB6zXFmJjYCILVtA/USqvwUTx3SNWw2Jv+GwMhjI1z2n+uwb5BWEKlfJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="431186926"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="431186926"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 02:14:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="839379527"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="839379527"
Received: from avmoskal-mobl1.ger.corp.intel.com (HELO intel.com) ([10.252.57.166])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 02:14:30 -0700
Date:   Mon, 24 Jul 2023 11:14:27 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     Andi Shyti <andi.shyti@linux.intel.com>,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-evel <dri-devel@lists.freedesktop.org>,
        linux-stable <stable@vger.kernel.org>
Subject: Re: [PATCH v8 7/9] drm/i915/gt: Ensure memory quiesced before
 invalidation for all engines
Message-ID: <ZL5A82eugN0hbFjr@ashyti-mobl2.lan>
References: <20230721161514.818895-1-andi.shyti@linux.intel.com>
 <20230721161514.818895-8-andi.shyti@linux.intel.com>
 <3b7e1781-ca2b-44b3-846d-89e42f24106e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b7e1781-ca2b-44b3-846d-89e42f24106e@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Andrzej,

> >   	intel_engine_mask_t aux_inv = 0;
> > -	u32 cmd, *cs;
> > +	u32 cmd_flush = 0;
> > +	u32 cmd = 4;
> > +	u32 *cs;
> > -	cmd = 4;
> > -	if (mode & EMIT_INVALIDATE) {
> > +	if (mode & EMIT_INVALIDATE)
> >   		cmd += 2;
> > -		if (gen12_needs_ccs_aux_inv(rq->engine) &&
> > -		    (rq->engine->class == VIDEO_DECODE_CLASS ||
> > -		     rq->engine->class == VIDEO_ENHANCEMENT_CLASS)) {
> > -			aux_inv = rq->engine->mask &
> > -				~GENMASK(_BCS(I915_MAX_BCS - 1), BCS0);
> > -			if (aux_inv)
> > -				cmd += 4;
> > -		}
> > +	if (gen12_needs_ccs_aux_inv(rq->engine))
> > +		aux_inv = rq->engine->mask &
> > +			  ~GENMASK(_BCS(I915_MAX_BCS - 1), BCS0);
> 
> Shouldn't we remove BCS check for MTL? And move it inside
> gen12_needs_ccs_aux_inv?
> Btw aux_inv is used as bool, make better is to make it bool.

Both the cleanups come in patch 9. I wanted to move it initially
before, but per engine check come later in the series.

I think would need to re-architecture all the patch structure if
I want to remove it :)

Are you strong with this change?

Andi
