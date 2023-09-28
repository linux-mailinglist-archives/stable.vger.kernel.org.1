Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A1D7B19ED
	for <lists+stable@lfdr.de>; Thu, 28 Sep 2023 13:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjI1LH3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 28 Sep 2023 07:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjI1LFg (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 28 Sep 2023 07:05:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510DCCD5
        for <stable@vger.kernel.org>; Thu, 28 Sep 2023 04:04:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD235C433C7;
        Thu, 28 Sep 2023 11:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899096;
        bh=pRVRkcaIfE9F4u+TVmNBnxxySTqMGy+7VtRipjhUiB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p5NImFcdnn0VLaumq/W0kNQEn79ktaHe9fZYuByaF+MMDyHHLG0fgF2RaiVNAWH5Y
         y7XGmNpTwO/4qxmL0AQCClRP/EfR+2iuL9LJcPACV9g/0xy8RwDXhmOV4QoRPrLUjW
         kiVtZA4RSgZQt90bdG3yipJmUsiqGIaAw+cY4q4dEze+KIOAFTVjpUTdOO+CCX+k7T
         bajKEchxTO5asLD+DS3uotrXsXD7370+4q39rWLndzJ+uq7Vxs8ANxUdVw04RtTIuC
         5SPs6HCBRtuYJmlhLtKxw0/UrC2YikwntLLiWADAJasJybub8U6qE0rcd8uA2+6Dxq
         EmsILHIxw/QEQ==
Date:   Thu, 28 Sep 2023 07:04:55 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Clark <robdclark@chromium.org>
Subject: Re: Build failure in v5.15.133
Message-ID: <ZRVd13RQgi5v3K4P@sashalap>
References: <e56ced8d-d09d-469b-80df-0cc2bdd943f4@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e56ced8d-d09d-469b-80df-0cc2bdd943f4@roeck-us.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 27, 2023 at 06:37:10AM -0700, Guenter Roeck wrote:
>Hi,
>
>I see the following build failure with v5.15.133.
>
>Build reference: v5.15.133
>Compiler version: aarch64-linux-gcc (GCC) 11.4.0
>Assembler version: GNU assembler (GNU Binutils) 2.40
>
>Building arm64:allnoconfig ... passed
>Building arm64:tinyconfig ... passed
>Building arm64:defconfig ... failed
>--------------
>Error log:
>drivers/interconnect/core.c: In function 'icc_init':
>drivers/interconnect/core.c:1148:9: error: implicit declaration of function 'fs_reclaim_acquire' [-Werror=implicit-function-declaration]
> 1148 |         fs_reclaim_acquire(GFP_KERNEL);
>      |         ^~~~~~~~~~~~~~~~~~
>drivers/interconnect/core.c:1150:9: error: implicit declaration of function 'fs_reclaim_release' [-Werror=implicit-function-declaration]
> 1150 |         fs_reclaim_release(GFP_KERNEL);
>      |         ^~~~~~~~~~~~~~~~~~
>
>This also affects alpha:allmodconfig and m68k:allmodconfig. The problem
>was introduced with 'interconnect: Teach lockdep about icc_bw_lock order'.
>
>#include <linux/sched/mm.h> is missing. Presumably that is included
>indirectly in the upstream kernel, but I wasn't able to determine which
>commit added it.

Yeah, I added a fixup commit for the next release to address that issue,
thanks for the report!


-- 
Thanks,
Sasha
