Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541F0739070
	for <lists+stable@lfdr.de>; Wed, 21 Jun 2023 21:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjFUTya (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 15:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjFUTy3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 15:54:29 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F16198B
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 12:54:21 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4QmZ2b0dcTz9snn;
        Wed, 21 Jun 2023 21:54:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bernhard-seibold.de;
        s=MBO0001; t=1687377255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rODZQA2Q1guObsUhtoJrbl++7E28ed2WHsAnEMQAo3E=;
        b=j3s6U7L9Mon8hoXHGjvjFgoNuPMtsbkgucw5ybu3Dm/nT+NdIKYhMDjS9CnO6L7fiBcevA
        HUCcjF2BABP1GXTiXRkkgp2TKEOAYSAho/AKzzht9K1qekp3VlscIXPFbw8XAguTu/8CmB
        F3/rvtEZSe5IWiLhYJeQCqTKej1SsrWHddsS0bLT7LL0OqkY+vHOljMA/SGLEsr+uDvX4N
        2jCE1/cl8dIjYYCsWAs0hcmkgSE2+wEZVxXsRWiXE6oc1LP2Xl0WyAx+oqJ1rO9D11q2WX
        bY1n6av7qaBzmIoYOdCEN8ge7BFA4/sOktKyibp8Lw0E+cS1xAWqi7XVvC+19g==
Date:   Wed, 21 Jun 2023 21:54:13 +0200
From:   Bernhard Seibold <mail@bernhard-seibold.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 4.14.y v2] serial: lantiq: add missing interrupt ack
Message-ID: <dqr6bzdhrvedvlifbpjfuirtqzkga246q4srhulrmery7dxlhh@dgzdztaruywc>
References: <2023061830-rubbed-stubble-2775@gregkh>
 <20230619211008.13464-1-mail@bernhard-seibold.de>
 <2023062152-rewrite-auction-0779@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023062152-rewrite-auction-0779@gregkh>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jun 21, 2023 at 08:33:05PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jun 19, 2023 at 11:10:08PM +0200, Bernhard Seibold wrote:
> > commit 306320034e8fbe7ee1cc4f5269c55658b4612048 upstream.
> > 
> > Currently, the error interrupt is never acknowledged, so once active it
> > will stay active indefinitely, causing the handler to be called in an
> > infinite loop.
> > 
> > Fixes: 2f0fc4159a6a ("SERIAL: Lantiq: Add driver for MIPS Lantiq SOCs.")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Bernhard Seibold <mail@bernhard-seibold.de>
> > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Message-ID: <20230602133029.546-1-mail@bernhard-seibold.de>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/tty/serial/lantiq.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
> > index 22df94f107e5..195b85176914 100644
> > --- a/drivers/tty/serial/lantiq.c
> > +++ b/drivers/tty/serial/lantiq.c
> > @@ -1,3 +1,4 @@
> > +
> >  /*
> >   *  Based on drivers/char/serial.c, by Linus Torvalds, Theodore Ts'o.
> >   *
> 
> This first chunk was not needed :(
> 
> I'll go hand edit it...
> 
> greg k-h

Thanks! Sorry, it was a bit too late at night.
