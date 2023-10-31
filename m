Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37DD7DCD5C
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 13:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344362AbjJaMvm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 08:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344275AbjJaMvm (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 08:51:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D44BB7
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 05:51:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106B6C433C7;
        Tue, 31 Oct 2023 12:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698756699;
        bh=PySEhp5C8YzBUnhvhTmJS2OYv1VPzdxYzHFpxj/AnEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D4khRRqSC+Y+kloJZx+inU3EixchclMzMZZF8j/6eE1eMwNhT0hkiIh6y9zSfRCvu
         wCucDNmgdLI7oKb7WK09ehsaVvoYNwx5E6YVA1/mppKXlLoWrrsql6buFaueBUhatQ
         GwdINQfNb+vkSG3iqdU6YukUkT6w9g8KQEc2EvOA=
Date:   Tue, 31 Oct 2023 13:51:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     stable@vger.kernel.org, sashal@kernel.org, tytso@mit.edu,
        jack@suse.cz, ritesh.list@gmail.com, patches@lists.linux.dev,
        yangerkun@huawei.com
Subject: Re: [PATCH 5.15 1/3] ext4: add two helper functions
 extent_logical_end() and pa_logical_end()
Message-ID: <2023103126-careless-frequency-07c1@gregkh>
References: <20231028064749.833278-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028064749.833278-1-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Oct 28, 2023 at 02:47:47PM +0800, Baokun Li wrote:
> commit 43bbddc067883d94de7a43d5756a295439fbe37d upstream.

Why just 5.15 and older?  What about 6.1.y?  We can't take patches only
for older stable kernels, otherwise you will have a regression when you
upgrade.  Please send a series for 6.1.y if you wish to have us apply
these for older kernels.

> When we use lstart + len to calculate the end of free extent or prealloc
> space, it may exceed the maximum value of 4294967295(0xffffffff) supported
> by ext4_lblk_t and cause overflow, which may lead to various problems.
> 
> Therefore, we add two helper functions, extent_logical_end() and
> pa_logical_end(), to limit the type of end to loff_t, and also convert
> lstart to loff_t for calculation to avoid overflow.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Link: https://lore.kernel.org/r/20230724121059.11834-2-libaokun1@huawei.com
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> 
> Conflicts:
> 	fs/ext4/mballoc.c
> 

Note, the "Conflicts:" stuff isn't needed.

thanks,

greg k-h
