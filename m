Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20DB797A73
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 19:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245372AbjIGRka (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 7 Sep 2023 13:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245054AbjIGRkI (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 7 Sep 2023 13:40:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081751FF9
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 10:39:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3201C116A3;
        Thu,  7 Sep 2023 10:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694081687;
        bh=N3wDgZHEq3NWH84uCAwp4cO5NFbmwvJ1CNPN6MdpleY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xlc3rKK32bO1CegFAdg+/ZvMTWSrBDv5pDc1ywTDBEh+mJJKOjROkYZ85TzoKZUFP
         UnM84ruAriYJdVpFL53M7Y1L6jXeYGqcsxqICJ/BWny4uu0pykfcjEc9ueCsklWGHO
         6cXzL8sJJR7VrJqCPfu6FaE9pTVzn6K0ctu33n58=
Date:   Thu, 7 Sep 2023 11:14:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Keyon Jie <yang.jie@linux.intel.com>
Cc:     Doug Smythies <dsmythies@telus.net>, stable@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: set stale CPU frequency to minimum
Message-ID: <2023090715-buffalo-zesty-b746@gregkh>
References: <20230906001646.338935-1-yang.jie@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906001646.338935-1-yang.jie@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Sep 05, 2023 at 05:16:46PM -0700, Keyon Jie wrote:
> From: Doug Smythies <dsmythies@telus.net>
> 
> commit d51847acb018d83186e4af67bc93f9a00a8644f7 upstream.
> 
> This fix applies to all stable kernel versions 5.18+.
> 
> The intel_pstate CPU frequency scaling driver does not
> use policy->cur and it is 0.
> When the CPU frequency is outdated arch_freq_get_on_cpu()
> will default to the nominal clock frequency when its call to
> cpufreq_quick_getpolicy_cur returns the never updated 0.
> Thus, the listed frequency might be outside of currently
> set limits. Some users are complaining about the high
> reported frequency, albeit stale, when their system is
> idle and/or it is above the reduced maximum they have set.
> 
> This patch will maintain policy_cur for the intel_pstate
> driver at the current minimum CPU frequency.
> 
> Reported-by: Yang Jie <yang.jie@linux.intel.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217597
> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> [ rjw: White space damage fixes and comment adjustment ]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index d51f90f55c05..fbe3a4098743 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2574,6 +2574,11 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>  			intel_pstate_clear_update_util_hook(policy->cpu);
>  		intel_pstate_hwp_set(policy->cpu);
>  	}
> +	/*
> +	 * policy->cur is never updated with the intel_pstate driver, but it
> +	 * is used as a stale frequency value. So, keep it within limits.
> +	 */
> +	policy->cur = policy->min;
>  
>  	mutex_unlock(&intel_pstate_limits_lock);
>  

Now queued up, thanks.

greg k-h
