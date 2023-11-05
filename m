Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604487E13CD
	for <lists+stable@lfdr.de>; Sun,  5 Nov 2023 15:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjKEODQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 5 Nov 2023 09:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKEODP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 5 Nov 2023 09:03:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50D5B6
        for <stable@vger.kernel.org>; Sun,  5 Nov 2023 06:03:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3024AC433C7;
        Sun,  5 Nov 2023 14:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699192993;
        bh=P+dLffKqeYLB7NclLXNQUK2LTfbJdrAO6ESC2CsBQkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qR3w4wW9Acdx8Av3FajVvs+vwaTdwi4wkIV3vdGAEEhhg3mqtZN2NQJoFY3jqopR9
         KefyXmhotb8yttdAQEziSD6JmAcPMY+aLdadLkyZnrwBrPhuTxxXnGGCM3bGJSg3VU
         hMP9sob0Ja0TBmGYjzZJ24NuNdDnOYaHhPWcEHW/ixBZwcwBHMr0yFlxFMR1N1qac4
         75dpw3LDEq3iMPZGWbpdVxcIf2sQEwP3djsFg5lSn6we8zdkEUicQ6/RfS8pK0wd7Z
         QrLMoYSYa1A8BvqpcWSFQo32PTlQ5U+TCo6VAzrdfyNfDTi44iJdL2pUNXqoa3sazk
         xScoOLoUmlbQw==
Date:   Sun, 5 Nov 2023 09:03:11 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org
Subject: Re: PSR w/ high IRQ
Message-ID: <ZUegn_yggWdUYEYi@sashalap>
References: <6beacbc1-4c92-4ca2-9778-15d9f73ef696@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6beacbc1-4c92-4ca2-9778-15d9f73ef696@amd.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Nov 02, 2023 at 09:19:19PM -0500, Mario Limonciello wrote:
>Hi,
>
>
>There is a problem under high IRQ that PSR can hang.  We've got a few 
>bug reports like this.
>
>Can you please bring this commit into 6.5.y and 6.6.y:
>
>79df45dc4bfb ("drm/amd/display: Don't use fsleep for PSR exit waits")
>
>This restores some of the behavior of the PSR interrupt handling to 
>how it behaved in older kernels before it was changed in 6.4-rc1 by 
>c69fc3d0de6ca.

Queued up, thanks!

-- 
Thanks,
Sasha
