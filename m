Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1FC726777
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 19:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjFGRdZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 13:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjFGRdV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 13:33:21 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id DCB902118
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 10:32:56 -0700 (PDT)
Received: (qmail 233960 invoked by uid 1000); 7 Jun 2023 13:32:55 -0400
Date:   Wed, 7 Jun 2023 13:32:55 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        xuetao09@huawei.com, quic_eserrao@quicinc.com,
        water.zhangjiantao@huawei.com, francesco@dolcini.it,
        alistair@alistair23.me, stephan@gerhold.net, bagasdotme@gmail.com,
        luca@z3ntu.xyz, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6 1/2] usb: gadget: udc: core: Offload
 usb_udc_vbus_handler processing
Message-ID: <65faa454-c822-4163-be3d-940fb4a647c7@rowland.harvard.edu>
References: <20230601031028.544244-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601031028.544244-1-badhri@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 01, 2023 at 03:10:27AM +0000, Badhri Jagan Sridharan wrote:
> usb_udc_vbus_handler() can be invoked from interrupt context by irq
> handlers of the gadget drivers, however, usb_udc_connect_control() has
> to run in non-atomic context due to the following:
> a. Some of the gadget driver implementations expect the ->pullup
>    callback to be invoked in non-atomic context.
> b. usb_gadget_disconnect() acquires udc_lock which is a mutex.
> 
> Hence offload invocation of usb_udc_connect_control()
> to workqueue.
> 
> UDC should not be pulled up unless gadget driver is bound. The new flag
> "allow_connect" is now set by gadget_bind_driver() and cleared by
> gadget_unbind_driver(). This prevents work item to pull up the gadget
> even if queued when the gadget driver is already unbound.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1016fc0c096c ("USB: gadget: Fix obscure lockdep violation for udc_mutex")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
> Changes since v1:
> - Address Alan Stern's comment on usb_udc_vbus_handler invocation from
>   atomic context:
> * vbus_events_lock is now a spinlock and allocations in
> * usb_udc_vbus_handler are atomic now.
> 
> Changes since v2:
> - Addressing Alan Stern's comments:
> ** connect_lock is now held by callers of
> * usb_gadget_pullup_update_locked() and gadget_(un)bind_driver() does
> * notdirectly hold the lock.
> 
> ** Both usb_gadget_(dis)connect() and usb_udc_vbus_handler() would
> * set/clear udc->vbus and invoke usb_gadget_pullup_update_locked.
> 
> ** Add "unbinding" to prevent new connections after the gadget is being
> * unbound.
> 
> Changes since v3:
> ** Made a minor cleanup which I missed to do in v3 in
> * usb_udc_vbus_handler().
> 
> Changes since v4:
> - Addressing Alan Stern's comments:
> ** usb_udc_vbus_handler() now offloads invocation of usb_udc_connect_control()
> * from workqueue.
> 
> ** Dropped vbus_events list as this was redundant. Updating to the
> * latest value is suffice
> 
> Changes since v5:
> - Addressing Alan Stern's comments:
> ** Squashed allow_connect logic to this patch.
> ** Fixed comment length to wrap at 76
> ** Cancelling vbus_work in del_gadget()

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
