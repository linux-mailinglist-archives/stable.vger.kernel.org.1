Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E4D700C26
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 17:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241990AbjELPoC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 11:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241173AbjELPoC (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 11:44:02 -0400
X-Greylist: delayed 23449 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 May 2023 08:44:00 PDT
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D264239;
        Fri, 12 May 2023 08:44:00 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id BB83E206F4;
        Fri, 12 May 2023 17:43:58 +0200 (CEST)
Date:   Fri, 12 May 2023 17:43:57 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Stephan Gerhold <stephan@gerhold.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, stable@vger.kernel.org,
        francesco.dolcini@toradex.com, liu.ming50@gmail.com,
        Badhri Jagan Sridharan <badhri@google.com>
Subject: Re: USB gadget regression on v6.4-rc1 and v6.1.28
Message-ID: <ZF5evXbOXhWFoaus@francesco-nb.int.toradex.com>
References: <ZF4BvgsOyoKxdPFF@francesco-nb.int.toradex.com>
 <ZF4bMptC3Lf2Hnee@gerhold.net>
 <13285014.O9o76ZdvQC@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13285014.O9o76ZdvQC@z3ntu.xyz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, May 12, 2023 at 05:42:03PM +0200, Luca Weiss wrote:
> to confirm I'm seeing the same issue on Qualcomm MSM8974 and MSM8226 boards. 
> Reverting the patches Stephan mentioned makes it work again on v6.4-rc1.

https://lore.kernel.org/all/20230512131435.205464-1-francesco@dolcini.it/

