Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC7C73453B
	for <lists+stable@lfdr.de>; Sun, 18 Jun 2023 09:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjFRHgY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 18 Jun 2023 03:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFRHgX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Jun 2023 03:36:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BD0E42
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 00:36:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE64660E98
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 07:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB023C433C0;
        Sun, 18 Jun 2023 07:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687073781;
        bh=EXF9ayec0xkbswEFTK2tj4MOyChHQF3DLZ677wzyerQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q1ODi8PGA+lC1wapJPnQrbCGSYsfM+A+UBGQpz3BnvWEFwTkAJMbsmxSO+73SC0Fb
         MahqFqlA8Ux4dedmM3EbRTvBBLWo6LSV1r9EzAa+k2YUsNJzrPEc/+nm1AagFwOZF/
         LjlqcAbiRKWRCmG+8GzIO30WsZi4z/DDkHspgtLY=
Date:   Sun, 18 Jun 2023 09:36:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "romain.izard.pro@gmail.com" <romain.izard.pro@gmail.com>
Subject: Re: [PATCH 1/2] usb: gadget: f_ncm: Add OS descriptor support
Message-ID: <2023061854-daydream-outage-de91@gregkh>
References: <20230531173358.910767-1-joakim.tjernlund@infinera.com>
 <5533972aab4a15ab2177497edc9aa0ba1b97aaba.camel@infinera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5533972aab4a15ab2177497edc9aa0ba1b97aaba.camel@infinera.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Jun 17, 2023 at 04:03:06PM +0000, Joakim Tjernlund wrote:
> Ping ?
> 
> Did I do something wrong with submission or is it queued for later ?
> 4.19 is missing these which make USB NCM unusable with Win >= 10. 
> 
>  Jocke
> 
> On Wed, 2023-05-31 at 19:33 +0200, Joakim Tjernlund wrote:
> > From: Romain Izard <romain.izard.pro@gmail.com>
> > 
> > To be able to use the default USB class drivers available in Microsoft
> > Windows, we need to add OS descriptors to the exported USB gadget to
> > tell the OS that we are compatible with the built-in drivers.
> > 
> > Copy the OS descriptor support from f_rndis into f_ncm. As a result,
> > using the WINNCM compatible ID, the UsbNcm driver is loaded on
> > enumeration without the need for a custom driver or inf file.
> > 
> > Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> > Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> > Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
> > Cc: stable@vger.kernel.org # v4.19
> > ---
> > 
> >  Seems to have been forgotten when backporting NCM fixes.
> >  Needed to make Win10 accept Linux NCM gadget ethernet
> > 
> >  drivers/usb/gadget/function/f_ncm.c | 47 +++++++++++++++++++++++++++--
> >  drivers/usb/gadget/function/u_ncm.h |  3 ++
> >  2 files changed, 47 insertions(+), 3 deletions(-)

What is the git commit id of this change in Linus's tree?

thanks,

greg k-h
