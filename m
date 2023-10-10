Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827F17C0364
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 20:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbjJJS0u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 14:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbjJJS0t (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 14:26:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95223B0
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 11:26:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD92CC433C8;
        Tue, 10 Oct 2023 18:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696962408;
        bh=waPUWbJO/Xc9axF8eteOesPuRUq2mKO6nYwd8+mSl7o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O8OGieC9iXJ/DbcIGSQBJU99kCIt8X7lAt2kGPnXYquud7uIc+imEF23bTwKr17wd
         FjX5ceLbQc/CSEaNpU0uCVhdPzfsQcVVqapazg3mrL9UrrHUARJ2Bja/PMRQ7NkAqe
         ozeuOSFmo8TBfB2My9xSzLgGp2jGv7kuXderYCbd0pc+ulR1O+zLDg5vmpBtfqLBEP
         cmQnlT+0Z12rm+0/xkI8bz/w79q2QDxuJUNGoi/ZR48kWJIbwjuwrHSE66JE4UMCTs
         Lp0LTv71EPv+A6oE4mM/wIWLKc4H4nVTxReeAc/0iSUJEQ6MaaYmEcoRKCmh+eCDRo
         VwNRrguM5H3Yg==
Date:   Tue, 10 Oct 2023 11:26:47 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jamal Hadi Salim <jhs@mojatatu.com>
Cc:     Pedro Tammela <pctammela@mojatatu.com>, markovicbudimir@gmail.com,
        Christian Theune <ct@flyingcircus.io>, stable@vger.kernel.org,
        netdev@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [REGRESSION] Userland interface breaks due to hard HFSC_FSC
 requirement
Message-ID: <20231010112647.2cd6590c@kernel.org>
In-Reply-To: <CAM0EoM=mnOdEgHPzbPxCAotoy4C54XyGiisrjwnO_raqVWPryw@mail.gmail.com>
References: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
        <065a0dac-499f-7375-ddb4-1800e8ef61d1@mojatatu.com>
        <0BC2C22C-F9AA-4B13-905D-FE32F41BDA8A@flyingcircus.io>
        <20231009080646.60ce9920@kernel.org>
        <da08ba06-e24c-d2c3-b9a0-8415a83ae791@mojatatu.com>
        <20231009172849.00f4a6c5@kernel.org>
        <CAM0EoM=mnOdEgHPzbPxCAotoy4C54XyGiisrjwnO_raqVWPryw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, 10 Oct 2023 11:02:25 -0400 Jamal Hadi Salim wrote:
> > > We had a UAF with a very straight forward way to trigger it.  
> >
> > Any details?  
> 
> As in you want the sequence of commands that caused the fault posted?
> Budimir, lets wait for Jakub's response before you do that. I have
> those details as well of course.

More - the sequence of events which leads to the UAF, and on what
object it occurs. If there's an embargo or some such we can wait 
a little longer before discussing?

I haven't looked at the code for more than a minute. If this is super
trivial to spot let me know, I'll stare harder. Didn't seem like the
qdisc as a whole is all that trivial.
