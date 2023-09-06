Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F6479373E
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 10:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjIFIiY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 6 Sep 2023 04:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjIFIiY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 6 Sep 2023 04:38:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335ECE45
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 01:38:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79997C433C8;
        Wed,  6 Sep 2023 08:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693989500;
        bh=3zE0giBClwa2X7EBKs8nAsXJOGJGAgNY0pTHG5rQr1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T9N3oSK/sHb8hMYpEc4O/dOLI7BdXK81QgpxbempNx9Jn9PQcSBWMIKqPK/jpEfEw
         1sw4T/jaKdNIPkl+jIKXia3ZOOg+FIDMmVyL8z7rMoBzqPEoLYfaIY8eQrS5/Z5A2U
         RsaXPAz/d7dAEju7d4XeykK2hrjz7N3JWQ0eWWyw=
Date:   Wed, 6 Sep 2023 09:38:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Keyon Jie <yang.jie@linux.intel.com>
Cc:     Doug Smythies <dsmythies@telus.net>, stable@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: set stale CPU frequency to minimum
Message-ID: <2023090607-virus-earshot-268d@gregkh>
References: <20230906001646.338935-1-yang.jie@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906001646.338935-1-yang.jie@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

What stable kernel(s) is this for?
