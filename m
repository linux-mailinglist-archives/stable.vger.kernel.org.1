Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFADB72BF15
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjFLKcT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjFLKcB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:32:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909885B93
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:13:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 749BC61F5E
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85320C43443;
        Mon, 12 Jun 2023 10:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686564206;
        bh=D98Iiiu7+09Jz22ohpv9bj6YPgwnw+2lTWx/ae9kdy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xLjdlc8xA9jRricAiMHRV9UEmnfu6VBFWq3mlPofzq1WYel/579r/XAJUq9vzXxKv
         cqxdBoCdkngpvHeIJIYLDbUfHNHsN+LJUA1il3T6/bbkCCQjFABsiFolIq9gJrgw0j
         pKKGiKsPRbnLlHqP4KHra/IGcx2XpufC/zlsqZtM=
Date:   Mon, 12 Jun 2023 12:03:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stefan Ghinea <stefan.ghinea@windriver.com>
Cc:     stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 5.10 PATCH 1/2] btrfs: check return value of
 btrfs_commit_transaction in relocation
Message-ID: <2023061212-favored-jaywalker-3645@gregkh>
References: <20230608211959.8378-1-stefan.ghinea@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608211959.8378-1-stefan.ghinea@windriver.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jun 09, 2023 at 12:19:58AM +0300, Stefan Ghinea wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> commit fb686c6824dd6294ca772b92424b8fba666e7d00 upstream
> 
> There are a few places where we don't check the return value of
> btrfs_commit_transaction in relocation.c.  Thankfully all these places
> have straightforward error handling, so simply change all of the sites
> at once.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Stefan Ghinea <stefan.ghinea@windriver.com>
> ---
>  fs/btrfs/relocation.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

All backports now queued up, thanks.

greg k-h
