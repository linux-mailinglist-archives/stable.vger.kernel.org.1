Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8650F7E9218
	for <lists+stable@lfdr.de>; Sun, 12 Nov 2023 19:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjKLSpn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 12 Nov 2023 13:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjKLSpl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 12 Nov 2023 13:45:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180BC2715
        for <stable@vger.kernel.org>; Sun, 12 Nov 2023 10:45:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A6FC433C8;
        Sun, 12 Nov 2023 18:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699814737;
        bh=K85le3M5N6X5vxm7aXwtDMsciUwKcAxv/rs64u0jS0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H+UPxP2vQbqVLgqz5CnFsnxMDVz9YsED9u2OsBHgDrNSbbFlyTRTGGJmzg1MYqpue
         mKkDnIKaNwtDwUlfs7NWg0P88K7lbn0I53Wz/LiuCFDT4xx54Ihp63nk28kXf4aSCV
         14gY83A8HnmIRpcqF4ziPwQjMuUbQTvfzqCvKNqwRxnPCQB1UC6qU5LqfBU1dggeet
         4OxEHnZEoBwy2f6tUz1v7VnJynLq2UrIQj/md/H1P3R47XikXyc/fkts7mVRJsWPiq
         OhVCkBVWTSttZkEL9D2YriyJjEzuyxDktJLmlFe8Tjb+0Ax4DaxcR8ZOi6YN9eLPH0
         TdFWdZ+Ya+0PQ==
Date:   Sun, 12 Nov 2023 13:45:35 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Adam Dunlap <acdunlap@google.com>
Cc:     stable@vger.kernel.org, Peter Gonda <pgonda@google.com>,
        Jacob Xu <jacobhxu@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: Backport f79936545fb12 ("x86/sev-es: Allow
 copy_from_kernel_nofault() in earlier boot")
Message-ID: <ZVEdT6MwMH2ElB_f@sashalap>
References: <CAMBK9=YqXa11BUPBLnitvHRFYGdEX=J3S1ssq=iBWRYpGCynBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMBK9=YqXa11BUPBLnitvHRFYGdEX=J3S1ssq=iBWRYpGCynBA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Nov 10, 2023 at 09:05:19AM -0800, Adam Dunlap wrote:
>commit f79936545fb122856bd78b189d3c7ee59928c751 upstream.
>
>This patch fixes a boot failure that happens with VMs running with
>SEV-ES or SEV-SNP when the guest kernel is compiled with a gcc version
>past 12.3 (or possibly earlier) due to undefined behavior. As far as I
>know, the UB has existed ever since SEV-ES guest support was merged in
>(I believe 5.9), but only started causing boot failures with the
>updated compiler. Thus, I propose backporting this patch to stable
>branches since 5.9.

Looks like its already queued for 5.15+, and needed some minor massaging
to get to 5.10.

-- 
Thanks,
Sasha
