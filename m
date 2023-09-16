Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F40C7A2FB4
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 13:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjIPLao (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 07:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbjIPLal (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 07:30:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BF6CC0
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 04:30:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846A0C433C8;
        Sat, 16 Sep 2023 11:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694863835;
        bh=tb+xo4fSb2SK2auJNGK/z1wJlI5Gm2K/RpR33D1BATs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VGQMC0Ox58Vgmg3+ioBFg0bugTtas2Yo/HziA7VXJv7+Y7RDAHLkW774S3K9c6Ka1
         AmxjLqDPpbVDYVI6XMoKBTzszdjmnfFb4SOQ3pG9enVCSOSU4Cpvd5DawMRkGzMUND
         /qYJJv9ygWxEkNv17GiewZFDdsBKRS0rBIbfzF3w=
Date:   Sat, 16 Sep 2023 13:30:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     stable@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, alexanderduyck@fb.com,
        soheil@google.com, netdev@vger.kernel.org, namit@vmware.com,
        amakhalov@vmware.com, vsirnapalli@vmware.com,
        er.ajay.kaher@gmail.com
Subject: Re: [PATCH 0/4 v6.1.y] net: fix roundup issue in kmalloc_reserve()
Message-ID: <2023091600-activate-moody-bd24@gregkh>
References: <1694802065-1821-1-git-send-email-akaher@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1694802065-1821-1-git-send-email-akaher@vmware.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Sep 15, 2023 at 11:51:01PM +0530, Ajay Kaher wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> This patch series is to backport upstream commit:
> 915d975b2ffa: net: deal with integer overflows in kmalloc_reserve()
> 
> patch 1-3/4 backport requires to apply patch 4/4 to fix roundup issue
> in kmalloc_reserve()

Thanks so much for these backports.  I attempted it but couldn't figure
it out myself.

all now queued up,

greg k-h
