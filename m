Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AFE700374
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 11:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239984AbjELJNP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 05:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239907AbjELJNO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 05:13:14 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C5A1710;
        Fri, 12 May 2023 02:13:13 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id B02492034F;
        Fri, 12 May 2023 11:13:09 +0200 (CEST)
Date:   Fri, 12 May 2023 11:13:04 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, stable@vger.kernel.org
Cc:     francesco.dolcini@toradex.com, liu.ming50@gmail.com,
        Badhri Jagan Sridharan <badhri@google.com>
Subject: Re: USB gadget regression on v6.4-rc1 and v6.1.28
Message-ID: <ZF4DIFZJ596AIfRL@francesco-nb.int.toradex.com>
References: <ZF4BvgsOyoKxdPFF@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZF4BvgsOyoKxdPFF@francesco-nb.int.toradex.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, May 12, 2023 at 11:07:10AM +0200, Francesco Dolcini wrote:
> I recently did have a regression on v6.4rc1, and it seems that the same
> exact issue is now happening also on v6.1.28.
> 
> I was not able yet to bisect it (yet), but what is happening is that
> libusbgx[1] that we use to configure a USB NCM gadget interface[2][3] just
> hang completely at boot.

...

> [3] https://git.toradex.com/cgit/meta-toradex-bsp-common.git/tree/recipes-support/libusbgx/files/g1.schema.in?h=kirkstone-6.x.y

Whoops, this is supposed to be

[3] https://git.toradex.com/cgit/meta-toradex-bsp-common.git/tree/recipes-support/libusbgx/files/usbg.service?h=kirkstone-6.x.y


