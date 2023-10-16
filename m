Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44317CA183
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjJPIZi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPIZh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:25:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAB9A1
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:25:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4399C433C7;
        Mon, 16 Oct 2023 08:25:34 +0000 (UTC)
Date:   Mon, 16 Oct 2023 10:25:31 +0200
From:   Greg KH <greg@kroah.com>
To:     Ricardo =?iso-8859-1?Q?Ca=F1uelo?= <ricardo.canuelo@collabora.com>
Cc:     stable@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 5.15.y] usb: hub: Guard against accesses to uninitialized
 BOS descriptors
Message-ID: <2023101624-faucet-dagger-0210@gregkh>
References: <2023101546-blinker-remote-0be1@gregkh>
 <20231016080930.3351178-1-ricardo.canuelo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231016080930.3351178-1-ricardo.canuelo@collabora.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 16, 2023 at 10:09:30AM +0200, Ricardo Cañuelo wrote:
> Many functions in drivers/usb/core/hub.c and drivers/usb/core/hub.h
> access fields inside udev->bos without checking if it was allocated and
> initialized. If usb_get_bos_descriptor() fails for whatever
> reason, udev->bos will be NULL and those accesses will result in a
> crash:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000018
> PGD 0 P4D 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 5 PID: 17818 Comm: kworker/5:1 Tainted: G W 5.15.108-18910-gab0e1cb584e1 #1 <HASH:1f9e 1>
> Hardware name: Google Kindred/Kindred, BIOS Google_Kindred.12672.413.0 02/03/2021
> Workqueue: usb_hub_wq hub_event
> RIP: 0010:hub_port_reset+0x193/0x788
> Code: 89 f7 e8 20 f7 15 00 48 8b 43 08 80 b8 96 03 00 00 03 75 36 0f b7 88 92 03 00 00 81 f9 10 03 00 00 72 27 48 8b 80 a8 03 00 00 <48> 83 78 18 00 74 19 48 89 df 48 8b 75 b0 ba 02 00 00 00 4c 89 e9
> RSP: 0018:ffffab740c53fcf8 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffffa1bc5f678000 RCX: 0000000000000310
> RDX: fffffffffffffdff RSI: 0000000000000286 RDI: ffffa1be9655b840
> RBP: ffffab740c53fd70 R08: 00001b7d5edaa20c R09: ffffffffb005e060
> R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
> R13: ffffab740c53fd3e R14: 0000000000000032 R15: 0000000000000000
> FS: 0000000000000000(0000) GS:ffffa1be96540000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000018 CR3: 000000022e80c005 CR4: 00000000003706e0
> Call Trace:
> hub_event+0x73f/0x156e
> ? hub_activate+0x5b7/0x68f
> process_one_work+0x1a2/0x487
> worker_thread+0x11a/0x288
> kthread+0x13a/0x152
> ? process_one_work+0x487/0x487
> ? kthread_associate_blkcg+0x70/0x70
> ret_from_fork+0x1f/0x30
> 
> Fall back to a default behavior if the BOS descriptor isn't accessible
> and skip all the functionalities that depend on it: LPM support checks,
> Super Speed capabilitiy checks, U1/U2 states setup.
> 
> Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
> Cc: stable <stable@vger.kernel.org>
> Link: https://lore.kernel.org/r/20230830100418.1952143-1-ricardo.canuelo@collabora.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> (cherry picked from commit f74a7afc224acd5e922c7a2e52244d891bbe44ee)
> ---
>  drivers/usb/core/hub.c | 25 ++++++++++++++++++++++---
>  drivers/usb/core/hub.h |  2 +-
>  2 files changed, 23 insertions(+), 4 deletions(-)

Now queued up, thanks.

greg k-h
