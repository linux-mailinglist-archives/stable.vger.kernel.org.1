Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CD67D0831
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 08:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjJTGS6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 02:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjJTGS6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 02:18:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17AED49
        for <stable@vger.kernel.org>; Thu, 19 Oct 2023 23:18:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1F1C433C8;
        Fri, 20 Oct 2023 06:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697782736;
        bh=XGhXOEjRhO0Vw5HK9APyCr6eHZI1/Lb/6opavS/zxGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xyTCiVng2inuuKGOitO+jgJSfzL4bxlyem7nrYvK9PG9Vpn58CMFTR+NV/k23qSf6
         QzGK0QNBKP3ngL5Ri9mANWS7yULBZD3nFQVSbuUzQM5h/kynUGMq2vmMFJxC1D3QTh
         ztu7RnE9PWijI79M4PDtDkn1vcVIp4ENG6rYX2G0=
Date:   Fri, 20 Oct 2023 08:11:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Luiz Capitulino <luizcap@amazon.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>
Subject: Re: [6.1] Please apply cc6003916ed46d7a67d91ee32de0f9138047d55f
Message-ID: <2023102026-zookeeper-retreat-b38f@gregkh>
References: <97397e8d-f447-4cf7-84a1-070989d0a7fd@amazon.com>
 <CAB=+i9SvjjUBUvPmQm_cEGo4OKXtkj72HnUXLhsGd4FTk4QzSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB=+i9SvjjUBUvPmQm_cEGo4OKXtkj72HnUXLhsGd4FTk4QzSw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 20, 2023 at 11:46:36AM +0900, Hyeonggon Yoo wrote:
> On Fri, Oct 20, 2023 at 10:27 AM Luiz Capitulino <luizcap@amazon.com> wrote:
> >
> > Hi,
> >
> > As reported before[1], we found another regression in 6.1 when doing
> > performance comparisons with 5.10. This one is caused by CONFIG_DEBUG_PREEMPT
> > being enabled by default by the following upstream commit if you have the
> > right config dependencies enabled (commit is introduced in v5.16-rc1):
> >
> > """
> > commit c597bfddc9e9e8a63817252b67c3ca0e544ace26
> > Author: Frederic Weisbecker <frederic@kernel.org>
> > Date: Tue Sep 14 12:31:34 2021 +0200
> >
> > sched: Provide Kconfig support for default dynamic preempt mode
> > """
> >
> > We found up to 8% performance improvement with CONFIG_DEBUG_PREEMPT
> > disabled in different perf benchmarks (including UnixBench process
> > creation and redis). The root cause is explained in the commit log
> > below which is merged in 6.3 and applies (almost) clealy on 6.1.59.
> 
> Oh, I should've sent it to the stable. Thanks for sending it!
> 
> Yes, DEBUG_PREEMPT was unintentionally enabled after the introduction
> of PREEMPT_DYNAMIC. It was already enabled by default for PREEMPTION=y kernels
> but PREEMPT_DYNAMIC always enables PREEMPT_BUILD (and hence PREEMPTION)
> so distros that were using PREEMPT_VOLUNTARY are silently affected by that.
> 
> It looks appropriate to be backported to the stable tree (to me).
> Hmm but I think it should be backported to 5.15 too?

Now queued up, thanks.

greg k-h
