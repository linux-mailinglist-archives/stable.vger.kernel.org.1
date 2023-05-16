Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC28D70456E
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 08:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjEPGrB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 02:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjEPGrA (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 02:47:00 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9284F1FFA;
        Mon, 15 May 2023 23:46:57 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id A7A6C20B6B;
        Tue, 16 May 2023 08:46:54 +0200 (CEST)
Date:   Tue, 16 May 2023 08:46:50 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Luca Weiss <luca@z3ntu.xyz>,
        Stephan Gerhold <stephan@gerhold.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, stable@vger.kernel.org,
        francesco.dolcini@toradex.com, liu.ming50@gmail.com
Subject: Re: USB gadget regression on v6.4-rc1 and v6.1.28
Message-ID: <ZGMm2sxN6wW/EWrR@francesco-nb.int.toradex.com>
References: <ZF4BvgsOyoKxdPFF@francesco-nb.int.toradex.com>
 <ZF4bMptC3Lf2Hnee@gerhold.net>
 <13285014.O9o76ZdvQC@z3ntu.xyz>
 <ZF5evXbOXhWFoaus@francesco-nb.int.toradex.com>
 <CAPTae5+uv3ZJaF7kAdkCzGnTgz3LzoCsT97_Mtv10+5kaEXrQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPTae5+uv3ZJaF7kAdkCzGnTgz3LzoCsT97_Mtv10+5kaEXrQA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 15, 2023 at 01:38:30PM -0700, Badhri Jagan Sridharan wrote:
> Do you see the system to crash (or) wait indefinitely for the gadget
> being pulled up ?
It wait indefinitely. Likely a deadlock.

> Is it possible to get the stack trace ?
I was able to generate this enabling some debugging kconfig:

[   41.341580] ============================================
[   41.349246] WARNING: possible recursive locking detected
[   41.357120] 6.4.0-rc1-0.0.0-devel-00005-gcda3c69ebc14 #1 Not tainted
[   41.357138] --------------------------------------------
[   41.357143] echo/566 is trying to acquire lock:
[   41.357153] c4b0a72c (&udc->connect_lock){+.+.}-{4:4}, at: usb_udc_vbus_handler+0x1c/0x60
[   41.357209]
[   41.357209] but task is already holding lock:
[   41.357214] c4b0a72c (&udc->connect_lock){+.+.}-{4:4}, at: gadget_bind_driver+0x110/0x230
[   41.357263]
[   41.357263] other info that might help us debug this:
[   41.357272]  Possible unsafe locking scenario:
[   41.357272]
[   41.357279]        CPU0
[   41.357285]        ----
[   41.357291]   lock(&udc->connect_lock);
[   41.357304]   lock(&udc->connect_lock);
[   41.357316]
[   41.357316]  *** DEADLOCK ***
[   41.357316]
[   41.357319]  May be due to missing lock nesting notation
[   41.357319]
[   41.357324] 6 locks held by echo/566:
[   41.357332]  #0: c430fabc (sb_writers#11){.+.+}-{0:0}, at: ksys_write+0x70/0xf8
[   41.357377]  #1: c5b26e98 (&buffer->mutex){+.+.}-{4:4}, at: configfs_write_iter+0x24/0x118
[   41.357420]  #2: c5284548 (&p->frag_sem){.+.+}-{4:4}, at: configfs_write_iter+0x88/0x118
[   41.357462]  #3: c55a2a20 (&gi->lock){+.+.}-{4:4}, at: gadget_dev_desc_UDC_store+0x58/0x110
[   41.357503]  #4: c4b5648c (&dev->mutex){....}-{4:4}, at: __driver_attach+0x108/0x1cc
[   41.357538]  #5: c4b0a72c (&udc->connect_lock){+.+.}-{4:4}, at: gadget_bind_driver+0x110/0x230
[   41.357578]
[   41.357578] stack backtrace:
[   41.357585] CPU: 1 PID: 566 Comm: echo Not tainted 6.4.0-rc1-0.0.0-devel-00005-gcda3c69ebc14 #1
[   41.357596] Hardware name: Freescale i.MX7 Dual (Device Tree)
[   41.357612]  unwind_backtrace from show_stack+0x10/0x14
[   41.357639]  show_stack from dump_stack_lvl+0x70/0xb0
[   41.357660]  dump_stack_lvl from __lock_acquire+0x924/0x22c4
[   41.357681]  __lock_acquire from lock_acquire+0x100/0x370
[   41.357699]  lock_acquire from __mutex_lock+0xa8/0xfb4
[   41.357720]  __mutex_lock from mutex_lock_nested+0x1c/0x24
[   41.357742]  mutex_lock_nested from usb_udc_vbus_handler+0x1c/0x60
[   41.357769]  usb_udc_vbus_handler from ci_udc_start+0x74/0x9c
[   41.357798]  ci_udc_start from gadget_bind_driver+0x130/0x230
[   41.357824]  gadget_bind_driver from really_probe+0xd8/0x3fc
[   41.357846]  really_probe from __driver_probe_device+0x94/0x1f0
[   41.357862]  __driver_probe_device from driver_probe_device+0x2c/0xc4
[   41.357877]  driver_probe_device from __driver_attach+0x114/0x1cc
[   41.357893]  __driver_attach from bus_for_each_dev+0x7c/0xcc
[   41.357915]  bus_for_each_dev from bus_add_driver+0xd4/0x200
[   41.357942]  bus_add_driver from driver_register+0x7c/0x114
[   41.357965]  driver_register from usb_gadget_register_driver_owner+0x40/0xe0
[   41.357987]  usb_gadget_register_driver_owner from gadget_dev_desc_UDC_store+0xd4/0x110
[   41.358014]  gadget_dev_desc_UDC_store from configfs_write_iter+0xac/0x118
[   41.358042]  configfs_write_iter from vfs_write+0x1b4/0x40c
[   41.358068]  vfs_write from ksys_write+0x70/0xf8
[   41.358088]  ksys_write from ret_fast_syscall+0x0/0x1c
[   41.358106] Exception stack(0xf0f15fa8 to 0xf0f15ff0)
[   41.358119] 5fa0:                   0000000a 00a741c0 00000001 00a741c0 0000000a 00000001
[   41.358132] 5fc0: 0000000a 00a741c0 b6f7dba0 00000004 0000000a 00000001 00000000 b6f7d388
[   41.358141] 5fe0: 00000004 beec4b80 b6f1c1f3 b6e9b5f6
