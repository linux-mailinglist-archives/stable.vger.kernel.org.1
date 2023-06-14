Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502897294DC
	for <lists+stable@lfdr.de>; Fri,  9 Jun 2023 11:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239432AbjFIJX6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 9 Jun 2023 05:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241376AbjFIJXa (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Jun 2023 05:23:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA25C49DD
        for <stable@vger.kernel.org>; Fri,  9 Jun 2023 02:17:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C26A165555
        for <stable@vger.kernel.org>; Fri,  9 Jun 2023 09:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA29C433EF;
        Fri,  9 Jun 2023 09:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686301667;
        bh=Y7X+ixTW1Kg7ULsTaf5xhcriWOfWBN2m8cXVd3g/nt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yLZtLbtMro86Ai5KVnUaOfLDs1KWMWF7gfrWWpc2WE0G1DWFFyamqsuNaGnxBxj6i
         aToFh+sVP8qUa86XQRB3N67Z/wUScf3lpc6X9g52g2U8kk0XdYRuvfbi0C/RKKiM/X
         x7QKAHWZpLZ5k+HX6HDbXIiot7eE5r0YHV14Ua/w=
Date:   Fri, 9 Jun 2023 11:07:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Felix Riemann <felix.riemann@sma.de>, l.sanfilippo@kunbus.com,
        patches@lists.linux.dev, sashal@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.15 070/371] tpm, tpm_tis: Claim locality before writing
 interrupt registers
Message-ID: <2023060906-starter-scrounger-1bca@gregkh>
References: <20230508094814.897191675@linuxfoundation.org>
 <20230515153759.2072-1-svc.sw.rte.linux@sma.de>
 <382309d7c0ae593d507eb816982f6a66c2cda00a.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <382309d7c0ae593d507eb816982f6a66c2cda00a.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, May 24, 2023 at 04:07:41AM +0300, Jarkko Sakkinen wrote:
> On Mon, 2023-05-15 at 17:37 +0200, Felix Riemann wrote:
> > Hi!
> > 
> > > [ Upstream commit 15d7aa4e46eba87242a320f39773aa16faddadee ]
> > > 
> > > In tpm_tis_probe_single_irq() interrupt registers TPM_INT_VECTOR,
> > > TPM_INT_STATUS and TPM_INT_ENABLE are modified to setup the interrupts.
> > > Currently these modifications are done without holding a locality thus they
> > > have no effect. Fix this by claiming the (default) locality before the
> > > registers are written.
> > > 
> > > Since now tpm_tis_gen_interrupt() is called with the locality already
> > > claimed remove locality request and release from this function.
> > 
> > On systems with SPI-connected TPM and the interrupt still configured
> > (despite it not working before) this may introduce a kernel crash.
> > The issue is that it will now trigger an SPI transfer (which will wait) 
> > from the IRQ handler:
> > 
> > BUG: scheduling while atomic: systemd-journal/272/0x00010001
> > Modules linked in: spi_fsl_lpspi
> > CPU: 0 PID: 272 Comm: systemd-journal Not tainted 5.15.111-06679-g56b9923f2840 #50
> > Call trace:
> >  dump_backtrace+0x0/0x1e0
> >  show_stack+0x18/0x40
> >  dump_stack_lvl+0x68/0x84
> >  dump_stack+0x18/0x34
> >  __schedule_bug+0x54/0x70
> >  __schedule+0x664/0x760
> >  schedule+0x88/0x100
> >  schedule_timeout+0x80/0xf0
> >  wait_for_completion_timeout+0x80/0x10c
> >  fsl_lpspi_transfer_one+0x25c/0x4ac [spi_fsl_lpspi]
> >  spi_transfer_one_message+0x22c/0x440
> >  __spi_pump_messages+0x330/0x5b4
> >  __spi_sync+0x230/0x264
> >  spi_sync_locked+0x10/0x20
> >  tpm_tis_spi_transfer+0x1ec/0x250
> >  tpm_tis_spi_read_bytes+0x14/0x20
> >  tpm_tis_spi_read32+0x38/0x70
> >  tis_int_handler+0x48/0x15c
> >  *snip*
> > 
> > The immediate error is fixable by also picking 0c7e66e5fd ("tpm, tpm_tis: 
> > Request threaded interrupt handler") from the same patchset[1]. However, as
> > the driver's IRQ test logic is still faulty it will fail the check and fall
> > back to the polling behaviour without actually disabling the IRQ in hard-
> > and software again. For this at least e644b2f498 ("tpm, tpm_tis: Enable 
> > interrupt test") and 0e069265bc ("tpm, tpm_tis: Claim locality in interrupt
> > handler") are necessary.
> > 
> > At this point 9 of the set's 14 patches are applied and I am not sure
> > whether it's better to pick the remaining five patches as well or just
> > revert the initial six patches. Especially considering there were initially
> > no plans to submit these patches to stable[2] and the IRQ feature was (at
> > least on SPI) not working before.
> 
> I think the right thing to do would be to revert 6 initial patches.

Ok, I think this isn't needed anymore with the latest 5.15.116 release,
right?  If not, please let me know.

thanks,

greg k-h
