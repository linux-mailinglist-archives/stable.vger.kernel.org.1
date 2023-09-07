Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22474797A6C
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 19:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245285AbjIGRjw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 7 Sep 2023 13:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245287AbjIGRje (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 7 Sep 2023 13:39:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8D41717
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 10:38:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B95C07616;
        Thu,  7 Sep 2023 10:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694081430;
        bh=Gy+nNJ0uithChmmt+Ut4858HgdKnAF2QzF7M2lzCMxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ELinZhVfVzk2K0ghT180Bfc3ujysfyBuEfTvVTovPxOCprt57+G4d6wUKmepkDAjr
         YRAazxpvVjMypV+5Kral/OI18OLcDgTHBCJBUBJ+H3JnZmfOpk3i2PWtA77o0BbMYt
         r5MopTugkVpjKmdRRoOh0cWfNBohzUWk1DRkwHq0=
Date:   Thu, 7 Sep 2023 11:10:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     stable <stable@vger.kernel.org>
Subject: Re: 6.4-stable backport request
Message-ID: <2023090721-update-nacho-ad33@gregkh>
References: <7ca1d2ea-b4f4-4284-bc17-6e413f5e12b5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ca1d2ea-b4f4-4284-bc17-6e413f5e12b5@kernel.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 06, 2023 at 06:32:11PM -0600, Jens Axboe wrote:
> Hi Greg / stable team,
> 
> Can you queue up this commit:
> 
> commit 106397376c0369fcc01c58dd189ff925a2724a57
> Author: David Jeffery <djeffery@redhat.com>
> Date:   Fri Jul 21 17:57:15 2023 +0800
> 
>     sbitmap: fix batching wakeup
> 
> for 6.4-stable? It'll cherry pick cleanly.

Now queued up, thanks.

greg k-h
