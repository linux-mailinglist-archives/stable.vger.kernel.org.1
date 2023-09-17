Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246DE7A3691
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 18:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjIQQeB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 12:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjIQQdp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 12:33:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C79CED
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 09:33:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843B0C433C8;
        Sun, 17 Sep 2023 16:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694968420;
        bh=zgJQapM/ECO9Ct34+OXARIRtVe/xxqxHB62SwZquj6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fQgbbJjEqQqrjQF4gkmG66XrWgVgqs1qvfkm/kIBx4y2NJ4572lWEsERXZzzYS2z9
         Ot8w+OpQwQ35lF3uQV3Y3hpukTraT4s/KdYfs73Uu7sQbWeoyxYkED49Ur6UgdtSro
         sUmQblESu9ozqmdGDrXF0Z3yj0/f1JXR76mzSmGI=
Date:   Sun, 17 Sep 2023 18:33:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable <stable@vger.kernel.org>
Subject: Re: perf build failure in v6.1.53-221-g5e5c3289d389
Message-ID: <2023091722-kinetic-stargazer-be71@gregkh>
References: <1ac26257-5434-0ef2-d9e5-66398c684ac4@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ac26257-5434-0ef2-d9e5-66398c684ac4@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Sep 17, 2023 at 07:48:43AM -0700, Guenter Roeck wrote:
> make tools/perf fails with
> 
> gcc: fatal error: no input files
> 
> Bisect points to 'perf build: Update build rule for generated files'
> which adds
> 
> +
> +# pmu-events.c file is generated in the OUTPUT directory so it needs a
> +# separate rule to depend on it properly
> +$(OUTPUT)pmu-events/pmu-events.o: $(PMU_EVENTS_C)
> +       $(call rule_mkdir)
> +       $(call if_changed_dep,cc_o_c)
> 
> but there is no PMU_EVENTS_C in v6.1.y.

Then the Fixes: tag lied :(

I'll go drop this patch now, thanks.

greg k-h
