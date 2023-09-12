Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B1D79D0BB
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 14:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbjILMIW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 08:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbjILMIM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 08:08:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544C31708
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 05:08:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B84C433C7;
        Tue, 12 Sep 2023 12:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694520488;
        bh=dFjeuoaKEKIAAw8l9zzHoexwE40Uu7bF3hPwA0kcSUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gNa923OnzAfm/FuKaY1rhFtxuzuSNXntu9eXwWpxJJDoPvgTKr3xAU+EL11XxJ5KI
         GLV3jIFCn3FSkFYDsrSBtnOIr5JBtxh2niS74CDkpA1y8Zc2KWwH39n7pmwzOdE40M
         JtUu8cwGHzq3zN3q5VpPZ/MOL4jWrKgxVXtgcxv8=
Date:   Tue, 12 Sep 2023 14:08:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     stable <stable@vger.kernel.org>
Subject: Re: Regression with raid1 in stable 5.15.132-rc1 and 6.1.53-rc1
Message-ID: <2023091241-ecology-greyhound-4e24@gregkh>
References: <CAMGffEmtW+95Hsmf-6sZmS76Mpdt+R6uYQKtjbLup+iX96eVfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEmtW+95Hsmf-6sZmS76Mpdt+R6uYQKtjbLup+iX96eVfg@mail.gmail.com>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Sep 12, 2023 at 01:46:29PM +0200, Jinpu Wang wrote:
> Hi Greg and Stable folks.
> 
> We've noticed regression in raid1 due to following commits:
> 79dabfd00a2b ("md/raid1: hold the barrier until handle_read_error() finishes")
> caeed0b9f1ce ("md/raid1: free the r1bio before waiting for blocked rdev")

I'll drop them from all queues, but can you test 6.6-rc1 to be sure that
all is ok there?

thanks,

greg k-h
