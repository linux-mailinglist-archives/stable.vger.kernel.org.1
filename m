Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDC27651C0
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 12:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjG0K56 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Jul 2023 06:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjG0K5x (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Jul 2023 06:57:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF2A1FED
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 03:57:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1922461DF6
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 10:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29108C433C7;
        Thu, 27 Jul 2023 10:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690455471;
        bh=winz5LgIXNhzlJNkCPA+KUfhgbEfvfpJq1sUFhcUS5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vyPT5REp+SuG6kvD5xAtY8kmyPeAqPH3Qnm5m7xkNR9Ziz0NxksE7I2zet+cZmnvO
         +g+rNZ8iFjhWo7Tx2M8FmjytMB1U/xzW+lkbS37//1uqLwXw1vlmL/Ce1JyadSqMR1
         2+3A3UZQV6+h2i7QYFTTNX1D71Pu/DHgD8U2JN+g=
Date:   Thu, 27 Jul 2023 12:57:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     chengzhihao1@huawei.com, amir73il@gmail.com, brauner@kernel.org,
        stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] ovl: fix null pointer dereference in
 ovl_permission()" failed to apply to 6.1-stable tree
Message-ID: <2023072739-arrest-scrimmage-2b16@gregkh>
References: <2023071616-vastly-cognition-78ba@gregkh>
 <CAOssrKdkLGRNn7z=7cOFpq5UtK2pXcZ37cOvn-zH8zrTAA5afA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOssrKdkLGRNn7z=7cOFpq5UtK2pXcZ37cOvn-zH8zrTAA5afA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jul 26, 2023 at 02:35:38PM +0200, Miklos Szeredi wrote:
> On Sun, Jul 16, 2023 at 6:30 PM <gregkh@linuxfoundation.org> wrote:
> >
> >
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> >
> > To reproduce the conflict and resubmit, you may use the following commands:
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 1a73f5b8f079fd42a544c1600beface50c63af7c
> 
> Applies and tests cleanly against v6.1.41.
> 
> Maybe the failure was due to dependency on commit b2dd05f107b1 ("ovl:
> let helper ovl_i_path_real() return the realinode")?

Odd, maybe?  I've queued this up now, thanks.

greg k-h
