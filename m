Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6131173FF01
	for <lists+stable@lfdr.de>; Tue, 27 Jun 2023 16:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjF0Oxu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 27 Jun 2023 10:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjF0Oxa (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Jun 2023 10:53:30 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5F430F3;
        Tue, 27 Jun 2023 07:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=grZGX8JELpOIKZjXlliOgEI/DJc38Q546m4p6RZBCpM=; b=R49xoCj2QcPcOYNbLkV444Qwnp
        vHN3xtMJ/uhKF5VZnJPMpKEWskxF2mBMxp7SqIZpcg5kC+CchRVA9oTBp59RuUjmBIGXKu2gfdSnW
        8bjqo5/WN4geMWzeKypRE1tP5cl6WwlZop5oL5zclyaEEu4PIrljTLzVQ7oRuTgr+EnU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qEA1y-0002Rm-HB; Tue, 27 Jun 2023 16:50:58 +0200
Date:   Tue, 27 Jun 2023 16:50:58 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     Moritz Fischer <moritzf@google.com>, netdev@vger.kernel.org,
        pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net, bryan.whitehead@microchip.com,
        UNGLinuxDriver@microchip.com, mdf@kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: lan743x: Don't sleep in atomic context
Message-ID: <9a42d3d3-a142-4e4a-811b-0b3b931e798b@lunn.ch>
References: <20230627035000.1295254-1-moritzf@google.com>
 <ZJrc5xjeHp5vYtAO@boxer>
 <35db66a9-d478-4b15-ad30-bfc4cded0b5c@lunn.ch>
 <CAFyOScpRDOvVrCsrwdxFstoNf1tOEnGbPSt5XDM1PKhCDyUGaw@mail.gmail.com>
 <ZJr1Ifp9cOlfcqbE@boxer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJr1Ifp9cOlfcqbE@boxer>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

> Side note would be that I don't see much value in iopoll.h's macros
> returning
> 
> 	(cond) ? 0 : -ETIMEDOUT; \
> 
> this could be just !!cond but given the count of the callsites...probably
> better to leave it as is.

The general pattern everywhere in linux is:

    err = foo(bar);
    if (err)
        return err;

We want functions to return meaningful error codes, otherwise the
caller needs to figure out an error code and return it. Having iopoll
return an error code means we have consistency. Otherwise i would
expect some developers to decide on EIO, ETIMEDOUT, EINVAL, maybe
ENXIO?

	Andrew
