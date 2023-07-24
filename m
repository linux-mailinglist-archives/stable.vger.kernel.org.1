Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A2F75EEE0
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 11:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjGXJRF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 05:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjGXJRE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 05:17:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4261195
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 02:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690190219; x=1721726219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JSxNWSDjJyd0g6MAfn3yUQULlcxcG2xVrI6FN+vIjQA=;
  b=gozkV5GBl4bytNT/lpXyHMbwJbvem+9NdDC3NZwXHMRz+gZU964kE9c+
   wCT2mfCu2FugWrhwQA85eg3xKmhbSn3irPfwm7+cqaN8ivfTluTb1Bqxc
   +HVBp2yi+bqVswo9+M1GAmuzlkm17X7xpwrXLy/4FdRpxaDi5elEM9+hY
   8hFwx6SuVcluvL5adYD4i2cPaSfmjUdGs+IMf8r4G7LQWMlt9VhkhJ7qT
   66DPR7QqoNVm40uwTn6uj0/nrsiI/Xb/7ESTkMqsAj9ns0gVDtrNlS3oH
   9b5fAbu7T5rVQU9J9ExbIKIvVPmVNrmobUBOx9KyLMgAHh/mf6+DX1WbG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="364853613"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="364853613"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 02:16:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="849560489"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="849560489"
Received: from avmoskal-mobl1.ger.corp.intel.com (HELO intel.com) ([10.252.57.166])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 02:16:56 -0700
Date:   Mon, 24 Jul 2023 11:16:53 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Nirmoy Das <nirmoy.das@linux.intel.com>
Cc:     Andi Shyti <andi.shyti@linux.intel.com>,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        linux-stable <stable@vger.kernel.org>,
        dri-evel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v8 6/9] drm/i915/gt: Refactor
 intel_emit_pipe_control_cs() in a single function
Message-ID: <ZL5BhY6C2uzqd/bU@ashyti-mobl2.lan>
References: <20230721161514.818895-1-andi.shyti@linux.intel.com>
 <20230721161514.818895-7-andi.shyti@linux.intel.com>
 <dc09292f-e2e8-c800-b39e-99f5364a8a76@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc09292f-e2e8-c800-b39e-99f5364a8a76@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Nirmoy,

>      static int mtl_dummy_pipe_control(struct i915_request *rq)
>      {
>             /* Wa_14016712196 */
>             if (IS_MTL_GRAPHICS_STEP(rq->engine->i915, M, STEP_A0, STEP_B0) ||
>     -           IS_MTL_GRAPHICS_STEP(rq->engine->i915, P, STEP_A0, STEP_B0)) {
>     -               u32 *cs;
>     -
>     -               /* dummy PIPE_CONTROL + depth flush */
>     -               cs = intel_ring_begin(rq, 6);
>     -               if (IS_ERR(cs))
>     -                       return PTR_ERR(cs);
>     -               cs = gen12_emit_pipe_control(cs,
>     -                                            0,
>     -                                            PIPE_CONTROL_DEPTH_CACHE_FLUSH,
>     -                                            LRC_PPHWSP_SCRATCH_ADDR);
>     -               intel_ring_advance(rq, cs);
>     -       }
>     +           IS_MTL_GRAPHICS_STEP(rq->engine->i915, P, STEP_A0, STEP_B0))
>     +               return gen12_emit_pipe_control_cs(rq, 0,
>     +                                       PIPE_CONTROL_DEPTH_CACHE_FLUSH,
>     +                                       LRC_PPHWSP_SCRATCH_ADDR);
> 
> Don't think this will get backported to 5.8+. I think mtl introduced after
> that.
> 
> If that is not an issue for rest of the series and then

to be honest I don't think I fully understood the stable
policies, as in this series only two are the patches that are
really fixing things and the rest are only support.

In this case I think this will produce a conflict that will be
eventually fixed (... I guess!).

> Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>

Thanks,
Andi
