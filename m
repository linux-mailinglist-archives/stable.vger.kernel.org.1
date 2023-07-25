Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB5376189A
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 14:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjGYMpU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 08:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjGYMpU (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 08:45:20 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F348719AA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 05:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690289116; x=1721825116;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0jSyA9z1hDlFtXfNkzSAavJr9Smsg+OsIh/YJM8gN4M=;
  b=VrxIT1lbwFyEJ2pNMVpUVkxNjUQY0lonALuYkPX6f7InBNWY2FUExXDI
   mJeXRAxjV7O8CVAlJgnAVbBj++PB4eagflenU/jfCOyoP3qbjx7RgiNvD
   //Ln0rfXRq9Qp6mWZvJLvUkAPCZ6c8O56db3okRsFt5e1/AIsW5zym08W
   suwHSojMjREsLzJ91KIS2EljjfHuXXispacFDDBJA0Un0IdMJ+SbJld9v
   fH6DRShbj+WvvF1XyIVsCYSZ10eTB05u3PhW5BXSdK8dfreA2CGinQZUj
   cEuUcffEZzQnm0fXSQQZYF7ljrT7SpCrMgFC8ihizWGGVtEp8yWf2bMlC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="431511415"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="431511415"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 05:45:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="726106705"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="726106705"
Received: from kshutemo-mobl.ger.corp.intel.com (HELO intel.com) ([10.249.37.237])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 05:45:14 -0700
Date:   Tue, 25 Jul 2023 14:45:06 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Andi Shyti <andi.shyti@linux.intel.com>,
        Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        stable@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Avoid GGTT flushing on non-GGTT
 paths of i915_vma_pin_iomap
Message-ID: <ZL/D0vd23NebU2+X@ashyti-mobl2.lan>
References: <20230724125633.1490543-1-tvrtko.ursulin@linux.intel.com>
 <ZL7cBvXCdtx3yzkB@ashyti-mobl2.lan>
 <d76a8009-0193-9bc9-15d1-e672cb5bd3d6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d76a8009-0193-9bc9-15d1-e672cb5bd3d6@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Tvrtko,

> > > Commit 4bc91dbde0da ("drm/i915/lmem: Bypass aperture when lmem is available")
> > > added a code path which does not map via GGTT, but was still setting the
> > > ggtt write bit, and so triggering the GGTT flushing.
> > > 
> > > Fix it by not setting that bit unless the GGTT mapping path was used, and
> > > replace the flush with wmb() in i915_vma_flush_writes().
> > > 
> > > This also works for the i915_gem_object_pin_map path added in
> > > d976521a995a ("drm/i915: extend i915_vma_pin_iomap()").
> > > 
> > > It is hard to say if the fix has any observable effect, given that the
> > > write-combine buffer gets flushed from intel_gt_flush_ggtt_writes too, but
> > > apart from code clarity, skipping the needless GGTT flushing could be
> > > beneficial on platforms with non-coherent GGTT. (See the code flow in
> > > intel_gt_flush_ggtt_writes().)
> > > 
> > > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> > > Fixes: 4bc91dbde0da ("drm/i915/lmem: Bypass aperture when lmem is available")
> > > References: d976521a995a ("drm/i915: extend i915_vma_pin_iomap()")
> > > Cc: Radhakrishna Sripada <radhakrishna.sripada@intel.com>
> > > Cc: <stable@vger.kernel.org> # v5.14+
> > > ---
> > >   drivers/gpu/drm/i915/i915_vma.c | 6 +++++-
> > >   1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/i915/i915_vma.c b/drivers/gpu/drm/i915/i915_vma.c
> > > index ffb425ba591c..f2b626cd2755 100644
> > > --- a/drivers/gpu/drm/i915/i915_vma.c
> > > +++ b/drivers/gpu/drm/i915/i915_vma.c
> > > @@ -602,7 +602,9 @@ void __iomem *i915_vma_pin_iomap(struct i915_vma *vma)
> > >   	if (err)
> > >   		goto err_unpin;
> > > -	i915_vma_set_ggtt_write(vma);
> > > +	if (!i915_gem_object_is_lmem(vma->obj) &&
> > > +	    i915_vma_is_map_and_fenceable(vma))
> > > +		i915_vma_set_ggtt_write(vma);
> > >   	/* NB Access through the GTT requires the device to be awake. */
> > >   	return page_mask_bits(ptr);
> > > @@ -617,6 +619,8 @@ void i915_vma_flush_writes(struct i915_vma *vma)
> > >   {
> > >   	if (i915_vma_unset_ggtt_write(vma))
> > >   		intel_gt_flush_ggtt_writes(vma->vm->gt);
> > > +	else
> > > +		wmb(); /* Just flush the write-combine buffer. */
> > 
> > is flush the right word? Can you expand more the explanation in
> > this comment and why this point of synchronization is needed
> > here? (I am even wondering if it is really needed).
> 
> If you are hinting flush isn't the right word then I am not remembering what
> else do we use for it?
> 
> It is needed because i915_flush_writes()'s point AFAIU is to make sure CPU
> writes after i915_vma_pin_iomap() have landed in RAM. All three methods the
> latter can map the buffer are WC, therefore "flushing" of the WC buffer is
> needed for former to do something (what it promises).
> 
> Currently the wmb() is in intel_gt_flush_ggtt_writes(). But only one of the
> three mapping paths is via GGTT. So my logic is that calling it for paths
> not interacting with GGTT is confusing and not needed.
> 
> > Anyway, it looks good:
> > 
> > Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> 
> Thanks. If you don't see a hole in my logic I can improve the comment. I
> considered it initially but then thought it is obvious enough from looking
> at the i915_vma_pin_iomap. I can comment it more.

The logic looks linear... my questions were more aiming at
confirming my understanding and improving the comment around
wmb().

Thanks,
Andi
