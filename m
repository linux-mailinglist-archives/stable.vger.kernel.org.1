Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BC07D6A79
	for <lists+stable@lfdr.de>; Wed, 25 Oct 2023 13:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjJYLyb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 25 Oct 2023 07:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbjJYLy3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Oct 2023 07:54:29 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Oct 2023 04:54:27 PDT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C8F13D
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 04:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698234868; x=1729770868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TNzg+MIBwG6SSa/l4BUCesBK7A6YbR+V303xAXDElSA=;
  b=Z67J+cG9DNkTu4L50wrQut5IyugzejbLLoV5DxTN2I7f71u+fubRmICr
   BA8/o5B5a4DLA3KvWMxCO0HqosE+SOeeJEz+CzclR6cC0FmX14/m5Cv4I
   1m+7GbfBxqY53Vpf//2R3zsT0PWNZa9eB8A8P1grirKD2tQo/n5C3gBtq
   jhMxWuCUydA9p6GAdYiJ0PEDIom10hovjf5PUAX/+OetNa7vdgMUKeSYy
   jgJ1NHT4xCT8RtHTpAbCyK6Ns5gPezQz5wsaZKb37XavlYiAEHCK89Oy4
   5e+goIhngHpjpjgVAyfWVqnK+J3Ze3v08hsHBWhAN9onQDUxnQQSujiM5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="44868"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="44868"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 04:53:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="758847846"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="758847846"
Received: from shenkel-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.63.39])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 04:53:23 -0700
Date:   Wed, 25 Oct 2023 13:53:20 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH] drm/i915/pmu: Check if pmu is closed before
 stopping event
Message-ID: <ZTkBsAW2l6ESAlnB@ashyti-mobl2.lan>
References: <20231020152441.3764850-1-umesh.nerlige.ramappa@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020152441.3764850-1-umesh.nerlige.ramappa@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Umesh,

On Fri, Oct 20, 2023 at 08:24:41AM -0700, Umesh Nerlige Ramappa wrote:
> When the driver unbinds, pmu is unregistered and i915->uabi_engines is
> set to RB_ROOT. Due to this, when i915 PMU tries to stop the engine
> events, it issues a warn_on because engine lookup fails.
> 
> All perf hooks are taking care of this using a pmu->closed flag that is
> set when PMU unregisters. The stop event seems to have been left out.
> 
> Check for pmu->closed in pmu_event_stop as well.
> 
> Based on discussion here -
> https://patchwork.freedesktop.org/patch/492079/?series=105790&rev=2
> 
> v2: s/is/if/ in commit title
> v3: Add fixes tag and cc stable
> 
> Cc: <stable@vger.kernel.org> # v5.11+
> Fixes: b00bccb3f0bb ("drm/i915/pmu: Handle PCI unbind")
> Signed-off-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

the failure from the shards tests looks unrelated.

Please next time don't forget to add a versioning to the patches
you are sending.

Pushed in drm-intel-gt-next.

Thank you,
Andi
