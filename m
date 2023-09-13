Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF6979E0A3
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 09:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbjIMHQr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 03:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238551AbjIMHQo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 03:16:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4BC1982;
        Wed, 13 Sep 2023 00:16:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B651C433C8;
        Wed, 13 Sep 2023 07:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694589400;
        bh=jbMSHPEy4vx/r2wm/ygIl/jEIoje24uhM4eGXw0OuRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oXnH0fp5+9oely5ZhPDGV40JD4mjLCFM54IsFTQ/bghhl7pxnimSDXtcNxLgDCZ6m
         eRp0QKq3M1goQKez2s+zLM1eKjql9o0Hlz3whDAvdFKNRCoOdeYVoT9kKY8kMvtfc1
         gx9yxeaT9BXqobZAEpbjKe5zoLmUr0oGDWuAvygM=
Date:   Wed, 13 Sep 2023 09:16:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, Hongyu Xie <xy521521@gmail.com>,
        stable@kernel.org, Hongyu Xie <xiehongyu1@kylinos.cn>,
        "# 5 . 15" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/4] xhci: Keep interrupt disabled in initialization
 until host is running.
Message-ID: <2023091323-splinter-skinless-7c57@gregkh>
References: <20220623111945.1557702-1-mathias.nyman@linux.intel.com>
 <20220623111945.1557702-2-mathias.nyman@linux.intel.com>
 <42bcb910-7748-cf73-a40d-217c39a63dd1@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42bcb910-7748-cf73-a40d-217c39a63dd1@quicinc.com>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 13, 2023 at 11:30:41AM +0530, Prashanth K wrote:
> 
> 
> On 23-06-22 04:49 pm, Mathias Nyman wrote:
> > From: Hongyu Xie <xy521521@gmail.com>
> > 
> > irq is disabled in xhci_quiesce(called by xhci_halt, with bit:2 cleared
> > in USBCMD register), but xhci_run(called by usb_add_hcd) re-enable it.
> > It's possible that you will receive thousands of interrupt requests
> > after initialization for 2.0 roothub. And you will get a lot of
> > warning like, "xHCI dying, ignoring interrupt. Shouldn't IRQs be
> > disabled?". This amount of interrupt requests will cause the entire
> > system to freeze.
> > This problem was first found on a device with ASM2142 host controller
> > on it.
> > 
> > [tidy up old code while moving it, reword header -Mathias]
> > Cc: stable@kernel.org
> > Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
> > Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> > ---
> >   drivers/usb/host/xhci.c | 35 ++++++++++++++++++++++-------------
> >   1 file changed, 22 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index 9ac56e9ffc64..cb99bed5f755 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> > @@ -611,15 +611,37 @@ static int xhci_init(struct usb_hcd *hcd)
> >   static int xhci_run_finished(struct xhci_hcd *xhci)
> >   {
> > +	unsigned long	flags;
> > +	u32		temp;
> > +
> > +	/*
> > +	 * Enable interrupts before starting the host (xhci 4.2 and 5.5.2).
> > +	 * Protect the short window before host is running with a lock
> > +	 */
> > +	spin_lock_irqsave(&xhci->lock, flags);
> > +
> > +	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "Enable interrupts");
> > +	temp = readl(&xhci->op_regs->command);
> > +	temp |= (CMD_EIE);
> > +	writel(temp, &xhci->op_regs->command);
> > +
> > +	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "Enable primary interrupter");
> > +	temp = readl(&xhci->ir_set->irq_pending);
> > +	writel(ER_IRQ_ENABLE(temp), &xhci->ir_set->irq_pending);
> > +
> >   	if (xhci_start(xhci)) {
> >   		xhci_halt(xhci);
> > +		spin_unlock_irqrestore(&xhci->lock, flags);
> >   		return -ENODEV;
> >   	}
> > +
> >   	xhci->cmd_ring_state = CMD_RING_STATE_RUNNING;
> >   	if (xhci->quirks & XHCI_NEC_HOST)
> >   		xhci_ring_cmd_db(xhci);
> > +	spin_unlock_irqrestore(&xhci->lock, flags);
> > +
> >   	return 0;
> >   }
> > @@ -668,19 +690,6 @@ int xhci_run(struct usb_hcd *hcd)
> >   	temp |= (xhci->imod_interval / 250) & ER_IRQ_INTERVAL_MASK;
> >   	writel(temp, &xhci->ir_set->irq_control);
> > -	/* Set the HCD state before we enable the irqs */
> > -	temp = readl(&xhci->op_regs->command);
> > -	temp |= (CMD_EIE);
> > -	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
> > -			"// Enable interrupts, cmd = 0x%x.", temp);
> > -	writel(temp, &xhci->op_regs->command);
> > -
> > -	temp = readl(&xhci->ir_set->irq_pending);
> > -	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
> > -			"// Enabling event ring interrupter %p by writing 0x%x to irq_pending",
> > -			xhci->ir_set, (unsigned int) ER_IRQ_ENABLE(temp));
> > -	writel(ER_IRQ_ENABLE(temp), &xhci->ir_set->irq_pending);
> > -
> >   	if (xhci->quirks & XHCI_NEC_HOST) {
> >   		struct xhci_command *command;
> This is not available to older kernels [< 5.19]. Can we get this backported
> to 5.15 as well? Please let me know if there is some other way to do it.
> 
> Cc: <stable@vger.kernel.org> # 5.15


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
