Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1147199A4
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 12:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbjFAK0J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 06:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbjFAKZw (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 06:25:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4BD212B
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 03:23:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 554F0615F6
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 10:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B32C433D2;
        Thu,  1 Jun 2023 10:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685614969;
        bh=Pl36m8O7NZUiAFB/DYxKXlXqTkdSUlzmEFIS8eUFlas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KH0h/ljL4DAjfawVkhsLKy4cv+vcF4LnPkvNAyy2mnfH8hl7FNT0OAMgwhqvbKK23
         bDIzKD5tZ43txvK2EpmOWo/59MfkyAfcJcNiwEnIyyJAddnCquFS/ab0BiHxwIVhh4
         8D7sZJJV18y63WKz1bpB6p66+/oOaJLva5YRU5G8=
Date:   Thu, 1 Jun 2023 11:22:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     stable@vger.kernel.org,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 6.3.y] cpufreq: amd-pstate: Add ->fast_switch() callback
Message-ID: <2023060137-mating-bucked-6b32@gregkh>
References: <2023052858-danger-kilowatt-29cc@gregkh>
 <20230530115503.3702-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530115503.3702-1-wyes.karny@amd.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 30, 2023 at 11:55:03AM +0000, Wyes Karny wrote:
> From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
> 
> [ Upstream commit 4badf2eb1e986bdbf34dd2f5d4c979553a86fe54 ]
> 
> Schedutil normally calls the adjust_perf callback for drivers with
> adjust_perf callback available and fast_switch_possible flag set.
> However, when frequency invariance is disabled and schedutil tries to
> invoke fast_switch. So, there is a chance of kernel crash if this
> function pointer is not set. To protect against this scenario add
> fast_switch callback to amd_pstate driver.
> 
> Fixes: 1d215f0319c2 ("cpufreq: amd-pstate: Add fast switch function for AMD P-State")
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> (cherry picked from commit 4badf2eb1e986bdbf34dd2f5d4c979553a86fe54)
> ---
>  drivers/cpufreq/amd-pstate.c | 37 +++++++++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 7 deletions(-)

All now queued up, thanks.

greg k-h
