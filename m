Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28959719754
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 11:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjFAJnS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 05:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjFAJnR (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 05:43:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F381BE
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 02:42:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D05764295
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 09:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45007C4339B;
        Thu,  1 Jun 2023 09:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685612573;
        bh=4gJcC7FaxcfoHyT9tvZaJHLVNIrsEChcGGejnkE7x+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AnZyLLJJHH4z3BzxLQC5Gj8nkVOq4yMLpqpeaAFklUpSDPaub1fyzC8o6NkCU7O4a
         aMnuwg2Qyo5IU82GXu+x6+6brsUJ/DSsAK4A/iknvf6x+PP6KpsJou/SSRzWwr7cae
         nscobvmdHoRZuxKnZcd4J87pf6GqdFhGaP1ZCwKQ=
Date:   Thu, 1 Jun 2023 10:42:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ido Schimmel <idosch@nvidia.com>
Cc:     stable@vger.kernel.org, daniel.lezcano@linaro.org,
        vadimp@nvidia.com, sashal@kernel.org, petrm@nvidia.com,
        davem@davemloft.net, joe@atomic.ac
Subject: Re: [PATCH stable 6.1] Revert "thermal/drivers/mellanox: Use generic
 thermal_zone_get_trip() function"
Message-ID: <2023060136-macarena-parasail-5b89@gregkh>
References: <20230601064803.1063014-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601064803.1063014-1-idosch@nvidia.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 01, 2023 at 09:48:03AM +0300, Ido Schimmel wrote:
> This reverts commit a71f388045edbf6788a61f43e2cdc94b392a4ea3.
> 
> Commit a71f388045ed ("thermal/drivers/mellanox: Use generic
> thermal_zone_get_trip() function") was backported as a dependency of the
> fix in upstream commit 6d206b1ea9f4 ("mlxsw: core_thermal: Fix fan speed
> in maximum cooling state"). However, it is dependent on changes in the
> thermal core that were merged in v6.3. Without them, the mlxsw driver is
> unable to register its thermal zone:
> 
> mlxsw_spectrum 0000:03:00.0: Failed to register thermal zone
> mlxsw_spectrum 0000:03:00.0: cannot register bus device
> mlxsw_spectrum: probe of 0000:03:00.0 failed with error -22
> 
> Fix this by reverting this commit and instead fix the small conflict
> with the above mentioned fix. Tested using the test case mentioned in
> the change log of the fix:
> 
>  # cat /sys/class/thermal/thermal_zone2/cdev0/type
>  mlxsw_fan
>  # echo 10 > /sys/class/thermal/thermal_zone2/cdev0/cur_state
>  # cat /sys/class/hwmon/hwmon1/name
>  mlxsw
>  # cat /sys/class/hwmon/hwmon1/pwm1
>  255
> 
> After setting the fan to its maximum cooling state (10), it operates at
> 100% duty cycle instead of being stuck at 0 RPM.
> 
> Fixes: a71f388045ed ("thermal/drivers/mellanox: Use generic thermal_zone_get_trip() function")
> Reported-by: Joe Botha <joe@atomic.ac>
> Tested-by: Joe Botha <joe@atomic.ac>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> I read the stable rules, but it is not clear to me which "upstream
> commit ID" to specify in this case given I am reverting a commit that
> was mistakenly backported to stable.

This was great, I've taken it as-is, thanks!

greg k-h
