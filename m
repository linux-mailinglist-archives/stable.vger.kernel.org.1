Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E38970035B
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 11:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbjELJH1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 05:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239976AbjELJH0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 05:07:26 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D3CE4A;
        Fri, 12 May 2023 02:07:18 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 0105F20684;
        Fri, 12 May 2023 11:07:14 +0200 (CEST)
Date:   Fri, 12 May 2023 11:07:10 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, stable@vger.kernel.org
Cc:     francesco.dolcini@toradex.com, liu.ming50@gmail.com,
        Badhri Jagan Sridharan <badhri@google.com>
Subject: USB gadget regression on v6.4-rc1 and v6.1.28
Message-ID: <ZF4BvgsOyoKxdPFF@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello all,
I recently did have a regression on v6.4rc1, and it seems that the same
exact issue is now happening also on v6.1.28.

I was not able yet to bisect it (yet), but what is happening is that
libusbgx[1] that we use to configure a USB NCM gadget interface[2][3] just
hang completely at boot.

This is happening with multiple ARM32 and ARM64 i.MX SOC (i.MX6, i.MX7,
i.MX8MM).

The logs is something like that

```
[*     �F] A start job is running for Load def…t schema g1.schema (6s / no limit)
M[K[**    �F] A start job is running for Load def…t schema g1.schema (7s / no limit)
M[K[***   �F] A start job is running for Load def…t schema g1.schema (8s / no limit)
M[K[ ***  �F] A start job is running for Load def…t schema g1.schema (8s / no limit)
```

I will try to bisect this and provide more useful feedback ASAP, I
decided to not wait for it and just send this email in case someone has
some insight on what is going on.

Francesco

[1] https://github.com/linux-usb-gadgets/libusbgx 
[2] https://git.toradex.com/cgit/meta-toradex-bsp-common.git/tree/recipes-support/libusbgx/files/g1.schema.in?h=kirkstone-6.x.y
[3] https://git.toradex.com/cgit/meta-toradex-bsp-common.git/tree/recipes-support/libusbgx/files/g1.schema.in?h=kirkstone-6.x.y
