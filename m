Return-Path: <stable+bounces-147922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F031AC6460
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 10:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65B0917454D
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 08:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D230C1FDA97;
	Wed, 28 May 2025 08:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LqImgGfK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393165464E;
	Wed, 28 May 2025 08:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748420617; cv=none; b=J44wW8mFt5kD2Zb3J046B6APkLVvYUWUSpTv2YK9Jgo7X1EhDBfNYF++sJGw6GzCvBAbS8AStjmLNPdOSBxaoVoeCxGUVLZCMLGm6qj7rdmZmRQGYO7JBns1v59fYrXS28sPC7QCFuOQ74HCL8UBYY3E5XsrachAGqMcyZsyHjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748420617; c=relaxed/simple;
	bh=kK59nSQeZRnZhVrcA5DcPYiSMQQqlQStnEkyPKvgl0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHTxm7wdBQWlK7SRRBrkIYPvS8PktWJTifL9EL75YTkXbj7ZRijM17hs3g8WOtjj74dNkHSK6mVePGyzjWd3UWAqqwVUql9m79XZqbFXFn5mlNveva3NrgUTXGkPEXEsKq/+rt8eeNvui9NT5tOF2FtUGrZIQtanFIcdPaXN2mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LqImgGfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E121C4CEE7;
	Wed, 28 May 2025 08:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748420616;
	bh=kK59nSQeZRnZhVrcA5DcPYiSMQQqlQStnEkyPKvgl0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LqImgGfKigRFT3Lm1iqjTjeAWQePbq4cmQKEskLdi4tYWPPkTo2gniIlOoPyAbYhB
	 b7SxgG0+JmBb+WaBdImrYusQXUrQVBIUWQ82k33C6SgIQs01jvPPCJ//xWy/IxRTMP
	 aJKSHvMrfmQMm9c0JYMJ8bvkmAxhzOnB0WnDmNwE=
Date: Wed, 28 May 2025 10:21:41 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Kuen-Han Tsai <khtsai@google.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v4] usb: dwc3: Abort suspend on soft disconnect failure
Message-ID: <2025052819-affluent-reputably-83bb@gregkh>
References: <20250416100515.2131853-1-khtsai@google.com>
 <20250419012408.x3zxum5db7iconil@synopsys.com>
 <CAKzKK0qi9Kze76G8NGGoE=-VTrtf47BbTWCA9XWbKK1N=rh9Ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKzKK0qi9Kze76G8NGGoE=-VTrtf47BbTWCA9XWbKK1N=rh9Ew@mail.gmail.com>

On Wed, May 28, 2025 at 03:35:15PM +0800, Kuen-Han Tsai wrote:
> On Sat, Apr 19, 2025 at 9:24 AM Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
> >
> > On Wed, Apr 16, 2025, Kuen-Han Tsai wrote:
> > > When dwc3_gadget_soft_disconnect() fails, dwc3_suspend_common() keeps
> > > going with the suspend, resulting in a period where the power domain is
> > > off, but the gadget driver remains connected.  Within this time frame,
> > > invoking vbus_event_work() will cause an error as it attempts to access
> > > DWC3 registers for endpoint disabling after the power domain has been
> > > completely shut down.
> > >
> > > Abort the suspend sequence when dwc3_gadget_suspend() cannot halt the
> > > controller and proceeds with a soft connect.
> > >
> > > Fixes: 9f8a67b65a49 ("usb: dwc3: gadget: fix gadget suspend/resume")
> > > CC: stable@vger.kernel.org
> > > Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
> > > ---
> > >
> > > Kernel panic - not syncing: Asynchronous SError Interrupt
> > > Workqueue: events vbus_event_work
> > > Call trace:
> > >  dump_backtrace+0xf4/0x118
> > >  show_stack+0x18/0x24
> > >  dump_stack_lvl+0x60/0x7c
> > >  dump_stack+0x18/0x3c
> > >  panic+0x16c/0x390
> > >  nmi_panic+0xa4/0xa8
> > >  arm64_serror_panic+0x6c/0x94
> > >  do_serror+0xc4/0xd0
> > >  el1h_64_error_handler+0x34/0x48
> > >  el1h_64_error+0x68/0x6c
> > >  readl+0x4c/0x8c
> > >  __dwc3_gadget_ep_disable+0x48/0x230
> > >  dwc3_gadget_ep_disable+0x50/0xc0
> > >  usb_ep_disable+0x44/0xe4
> > >  ffs_func_eps_disable+0x64/0xc8
> > >  ffs_func_set_alt+0x74/0x368
> > >  ffs_func_disable+0x18/0x28
> > >  composite_disconnect+0x90/0xec
> > >  configfs_composite_disconnect+0x64/0x88
> > >  usb_gadget_disconnect_locked+0xc0/0x168
> > >  vbus_event_work+0x3c/0x58
> > >  process_one_work+0x1e4/0x43c
> > >  worker_thread+0x25c/0x430
> > >  kthread+0x104/0x1d4
> > >  ret_from_fork+0x10/0x20
> > >
> > > ---
> > > Changelog:
> > >
> > > v4:
> > > - correct the mistake where semicolon was forgotten
> > > - return -EAGAIN upon dwc3_gadget_suspend() failure
> > >
> > > v3:
> > > - change the Fixes tag
> > >
> > > v2:
> > > - move declarations in separate lines
> > > - add the Fixes tag
> > >
> > > ---
> > >  drivers/usb/dwc3/core.c   |  9 +++++++--
> > >  drivers/usb/dwc3/gadget.c | 22 +++++++++-------------
> > >  2 files changed, 16 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > index 66a08b527165..f36bc933c55b 100644
> > > --- a/drivers/usb/dwc3/core.c
> > > +++ b/drivers/usb/dwc3/core.c
> > > @@ -2388,6 +2388,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> > >  {
> > >       u32 reg;
> > >       int i;
> > > +     int ret;
> > >
> > >       if (!pm_runtime_suspended(dwc->dev) && !PMSG_IS_AUTO(msg)) {
> > >               dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
> > > @@ -2406,7 +2407,9 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> > >       case DWC3_GCTL_PRTCAP_DEVICE:
> > >               if (pm_runtime_suspended(dwc->dev))
> > >                       break;
> > > -             dwc3_gadget_suspend(dwc);
> > > +             ret = dwc3_gadget_suspend(dwc);
> > > +             if (ret)
> > > +                     return ret;
> > >               synchronize_irq(dwc->irq_gadget);
> > >               dwc3_core_exit(dwc);
> > >               break;
> > > @@ -2441,7 +2444,9 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> > >                       break;
> > >
> > >               if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
> > > -                     dwc3_gadget_suspend(dwc);
> > > +                     ret = dwc3_gadget_suspend(dwc);
> > > +                     if (ret)
> > > +                             return ret;
> > >                       synchronize_irq(dwc->irq_gadget);
> > >               }
> > >
> > > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > > index 89a4dc8ebf94..630fd5f0ce97 100644
> > > --- a/drivers/usb/dwc3/gadget.c
> > > +++ b/drivers/usb/dwc3/gadget.c
> > > @@ -4776,26 +4776,22 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
> > >       int ret;
> > >
> > >       ret = dwc3_gadget_soft_disconnect(dwc);
> > > -     if (ret)
> > > -             goto err;
> > > -
> > > -     spin_lock_irqsave(&dwc->lock, flags);
> > > -     if (dwc->gadget_driver)
> > > -             dwc3_disconnect_gadget(dwc);
> > > -     spin_unlock_irqrestore(&dwc->lock, flags);
> > > -
> > > -     return 0;
> > > -
> > > -err:
> > >       /*
> > >        * Attempt to reset the controller's state. Likely no
> > >        * communication can be established until the host
> > >        * performs a port reset.
> > >        */
> > > -     if (dwc->softconnect)
> > > +     if (ret && dwc->softconnect) {
> > >               dwc3_gadget_soft_connect(dwc);
> > > +             return -EAGAIN;
> >
> > This may make sense to have -EAGAIN for runtime suspend. I supposed this
> > should be fine for system suspend since it doesn't do anything special
> > for this error code.
> >
> > When you tested runtime suspend, did you observe that the device
> > successfully going into suspend on retry?
> >
> > In any case, I think this should be good. Thanks for the fix:
> >
> > Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> >
> > Thanks,
> > Thinh
> 
> Hi Greg,
> 
> It looks like this patch hasn't been cherry-picked into the usb-next
> branch yet. Am I missing something?

It's somehow not in my queue anymore, sorry.  Can you please resend it
and I'll pick it up after -rc1 is out.

thanks,

greg k-h

