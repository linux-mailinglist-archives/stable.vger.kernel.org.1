Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327C479249F
	for <lists+stable@lfdr.de>; Tue,  5 Sep 2023 17:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjIEP7W (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 5 Sep 2023 11:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353765AbjIEH7P (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 5 Sep 2023 03:59:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C384CCB
        for <stable@vger.kernel.org>; Tue,  5 Sep 2023 00:59:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8B5160A66
        for <stable@vger.kernel.org>; Tue,  5 Sep 2023 07:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40ACC433C7;
        Tue,  5 Sep 2023 07:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693900751;
        bh=ZnYi1exwfCzum+po4FxbLW7bAJE6y5WTscP1cS4zChw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WO1sY51fk12y66XOmcjO1top4OF4fnm4y0AIDCm/Gy7O4l9MXwe2wgNfx2/T1ManK
         mitf4aGyLYoGYVqarvskwW9PMrQ8QafK0ntNsdPmWqutMgac3DRneyWGTNuPWbkgxz
         6jvzUGCAsekvD21E9Kb4GGHPFs3GDJ0vmIA8bHzk=
Date:   Tue, 5 Sep 2023 08:59:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vladislav Efanov <VEfanov@ispras.ru>
Cc:     stable@vger.kernel.org, Jan Kara <jack@suse.com>,
        lvc-project@linuxtesting.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 5.10 1/1] udf: Handle error when adding extent to a file
Message-ID: <2023090526-unrefined-handpick-4e23@gregkh>
References: <20230815113453.2213555-1-VEfanov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815113453.2213555-1-VEfanov@ispras.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 15, 2023 at 02:34:53PM +0300, Vladislav Efanov wrote:
> From: Jan Kara <jack@suse.cz>
> 
> commit 19fd80de0a8b5170ef34704c8984cca920dffa59 upstream
> 
> When adding extent to a file fails, so far we've silently squelshed the
> error. Make sure to propagate it up properly.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>
> ---
> Syzkaller reports this problem in 5.10 stable release. The problem has
> been fixed by the following patch which can be cleanly applied to the
> 5.10 branch.
>  fs/udf/inode.c | 41 +++++++++++++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 14 deletions(-)

Sorry I missed this, but we need versions for 5.10 and newer if we were
to be able to take this.

thanks,

greg k-h
