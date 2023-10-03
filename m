Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351817B67D7
	for <lists+stable@lfdr.de>; Tue,  3 Oct 2023 13:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjJCL1C (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 3 Oct 2023 07:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239926AbjJCL1C (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Oct 2023 07:27:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59F7B4
        for <stable@vger.kernel.org>; Tue,  3 Oct 2023 04:26:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA298C433C8;
        Tue,  3 Oct 2023 11:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696332419;
        bh=vsC9fNFwTXIiE5q4fNXiP0xBI0mqnfXfb/uuds1PQ+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MTj7suKh1i+pUMEI0f1d7Gw/LXmnkgj3bqDLhJr10dbxSqvgJFp0jL2ebteqE+iFc
         M0lpUluktExaFp4UHI8nhxv8A/PKbKOuTu9c1Nvb9PI1T6a3fuW7+v9V+XqXtxyUf0
         7x3C3pwiQMZ62GFgIQ/GYLtOy8Ip1cVORob8FuROvxD1NZCDM52zeq6a0HTEcQh0Eb
         dUw+r6LjgedyuoGAD5g42OyAHoJtmeISu2w/YLXuwt8d8WdvFffAN+fMcVZJQ/NKiv
         vnbl7SYB0Q2hpWFOMNhQHUipt/vnV7e2e/RRwSkUnNukkV6JSPdkXZmo1y855IjyMh
         JBccGWPduxFJg==
Date:   Tue, 3 Oct 2023 07:26:57 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Munehisa Kamata <kamatam@amazon.com>
Cc:     stable@vger.kernel.org, casey@schaufler-ca.com,
        vishal.goel@samsung.com, roberto.sassu@huawei.com
Subject: Re: [PATCH for 4.19.y 0/3] Backport Smack fixes for 4.19.y
Message-ID: <ZRv6gaFF0hPrhj+D@sashalap>
References: <20230929015033.835263-1-kamatam@amazon.com>
 <20230929015138.835462-1-kamatam@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230929015138.835462-1-kamatam@amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Sep 28, 2023 at 06:51:35PM -0700, Munehisa Kamata wrote:
>This series backports the following fixes for Smack problems with overlayfs
>to 4.19.y.
>
>2c085f3a8f23 smack: Record transmuting in smk_transmuted
>3a3d8fce31a4 smack: Retrieve transmuting information in smack_inode_getsecurity()
>387ef964460f Smack:- Use overlay inode label in smack_inode_copy_up()
>
>This slightly modifies the original commits, because the commits rely on
>some helper functions introduced after v4.19 by different commits that
>touch more code than just Smack, require even more prerequisite commits and
>also need some adjustments for 4.19.y.  Instead, this series makes minor
>modifications for only the overlayfs-related fixes to not use the helper
>functions rather than backporting everything.

What about newer trees? We can't take fixes for 4.19 if the fixes don't
exist in 5.4+.

-- 
Thanks,
Sasha
