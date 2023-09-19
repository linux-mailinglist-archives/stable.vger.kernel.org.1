Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BAB7A5A7B
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 09:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjISHGb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 03:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjISHGa (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 03:06:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CF512F
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 00:06:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C91CC433BA;
        Tue, 19 Sep 2023 07:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695107184;
        bh=lnoQzkQJCdvMNn1Qyd6ZH0UMjb+wlW5nHACslkBfBgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=StoaHhYP18X4h6Sh6L8Q4DOr38v1tcC7PXjYAuOJfvs9sjbBMz9csxevwjJoy5ONW
         2QgMYQA8UeCr4xexpnSSGjLJ1HxBFxGgBbi52O1z2rwqUFz4KgvEZ07PMHNBQfsod1
         yh1aqvA5RPTToQ9Ub2SPn99lQmJHcDUOd/zTSnNU=
Date:   Tue, 19 Sep 2023 09:06:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Paul Grandperrin <paul.grandperrin@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Wei_wang <wei_wang@realsil.com.cn>,
        Roger Tseng <rogerable@realtek.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Regression since 6.1.46 (commit 8ee39ec): rtsx_pci from
 drivers/misc/cardreader breaks NVME power state, preventing system boot
Message-ID: <2023091921-unscented-renegade-6495@gregkh>
References: <5DHV0S.D0F751ZF65JA1@gmail.com>
 <82469f2f-59e4-49d5-823d-344589cbb119@leemhuis.info>
 <2023091333-fiftieth-trustless-d69d@gregkh>
 <7991b5bd7fb5469c971a2984194e815f@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7991b5bd7fb5469c971a2984194e815f@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Sep 19, 2023 at 02:20:53AM +0000, Ricky WU wrote:
> Hi Greg k-h，
> 
> In order to cover the those platform Power saving issue, 
> our approach on new patch will be different from the previous patch (101bd907b4244a726980ee67f95ed9cafab6ff7a).
> 
> So we need used fixed Tag on 101bd907b4244a726980ee67f95ed9cafab6ff7a 
> or a new patch for this problem?

I'm sorry, but I do not understand.  I think a new change is needed
here, right?  Or are you wanting a different commit backported to stable
trees?  What about Linus's tree now?

What exactly should I do here?

confused,

greg k-h
