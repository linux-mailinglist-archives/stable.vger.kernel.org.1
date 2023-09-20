Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997D07A7438
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 09:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjITHfJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 03:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbjITHfJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 03:35:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A1FCF
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 00:35:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B48C433C8;
        Wed, 20 Sep 2023 07:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695195302;
        bh=cceVS0pUPFMspnErpmWDwRXbsiaVz9xJE/gAJ0/F06M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jCKzrhLCwQ5ZIai38bw+bqq1ucFDO3l3FeWxisGEHheiAFeq68ibWIItiD4lTcLyd
         bOMRGg30E/gaIJvVURaTvxG8R1+X2H231Un56MwkAEUltvU+I3vIk0FqdzK7XLmgMN
         8fN3p8GRxwfLKAyH6Q9LwwSrzgsRXtRiWZ+dYkIo=
Date:   Wed, 20 Sep 2023 09:34:59 +0200
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
Message-ID: <2023092041-shopper-prozac-0640@gregkh>
References: <5DHV0S.D0F751ZF65JA1@gmail.com>
 <82469f2f-59e4-49d5-823d-344589cbb119@leemhuis.info>
 <2023091333-fiftieth-trustless-d69d@gregkh>
 <7991b5bd7fb5469c971a2984194e815f@realtek.com>
 <2023091921-unscented-renegade-6495@gregkh>
 <995632624f0e4d26b73fb934a8eeaebc@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <995632624f0e4d26b73fb934a8eeaebc@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 20, 2023 at 07:30:00AM +0000, Ricky WU wrote:
> Hi Greg k-h,
> 
> This patch is our solution for this issue...
> And now how can I push this? 

Submit it properly like any other patch, what is preventing that from
happening?

thanks,

greg k-h
