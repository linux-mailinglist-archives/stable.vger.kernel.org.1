Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F5C7E9C65
	for <lists+stable@lfdr.de>; Mon, 13 Nov 2023 13:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjKMMtv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 13 Nov 2023 07:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKMMtu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 13 Nov 2023 07:49:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE708171A;
        Mon, 13 Nov 2023 04:49:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387A4C433C8;
        Mon, 13 Nov 2023 12:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699879787;
        bh=tU8xq2J57Sl4LuqrzTRB/W0EKcXKJwV5rRjDD+w+8WE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GLCnkFzCfiUeYlaC2/UHWgyq9vWZNCUiwhhXZnxTQcERjWEjj83uAm8iGnC4VaR+P
         JdUniYfYlBeun2m5HKDfT4MyRHHzyN1vcFRmSL6T8UiXduMXXHb8tRcZwSvNVYIiVw
         Z5jShIRXJ4DABlzUyEiVza1Qc7HI23BBwjilCKXsg6P8RpQXU+xgAfMT947zkO8JKa
         8ip4Y4w+j56XWLRY1udC+yAtCg+W/Qysn6vaeaW/bEbdEE5BIN2ypoEFsDTT7pbm1W
         UYHKLqe0VKRHdMJeLJVDI01gAYvgvcC/GAGcYeqBC2QS2LGRqB1huMd7NCSO8YyRRI
         QiUf055zrosgg==
Date:   Mon, 13 Nov 2023 07:49:44 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     stable@vger.kernel.org, stable-commits@vger.kernel.org,
        Helge Deller <deller@gmx.de>
Subject: Re: Patch "fbdev: omapfb: Drop unused remove function" has been
 added to the 6.6-stable tree
Message-ID: <ZVIbaGnc-ClgzbW-@sashalap>
References: <20231113043603.303944-1-sashal@kernel.org>
 <20231113085330.ik34bufqhut6bt6t@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231113085330.ik34bufqhut6bt6t@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Nov 13, 2023 at 09:53:30AM +0100, Uwe Kleine-König wrote:
>On Sun, Nov 12, 2023 at 11:36:02PM -0500, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     fbdev: omapfb: Drop unused remove function
>>
>> to the 6.6-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      fbdev-omapfb-drop-unused-remove-function.patch
>> and it can be found in the queue-6.6 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>>
>>
>>
>> commit a772de6bea2f5a9b5dad8afe0d9145fd8ee62564
>> Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> Date:   Fri Nov 3 18:35:58 2023 +0100
>>
>>     fbdev: omapfb: Drop unused remove function
>>
>>     [ Upstream commit fc6699d62f5f4facc3e934efd25892fc36050b70 ]
>>
>>     OMAP2_VRFB is a bool, so the vrfb driver can never be compiled as a
>>     module. With that __exit_p(vrfb_remove) always evaluates to NULL and
>>     vrfb_remove() is unused.
>>
>>     If the driver was compilable as a module, it would fail to build because
>>     the type of vrfb_remove() isn't compatible with struct
>>     platform_driver::remove(). (The former returns void, the latter int.)
>>
>>     Fixes: aa1e49a3752f ("OMAPDSS: VRFB: add omap_vrfb_supported()")
>>     Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>     Signed-off-by: Helge Deller <deller@gmx.de>
>>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>While it doesn't hurt to backport this patch, I guess it also doesn't
>give any benefit (apart from increasing my patch count in stable :-).
>
>This commit just removes code that was thrown away by the compiler
>before. So I'd not backport it.

Ack, dropped. Thanks!

-- 
Thanks,
Sasha
