Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41537413C9
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 16:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjF1OWh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 10:22:37 -0400
Received: from vps0.lunn.ch ([156.67.10.101]:40130 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231406AbjF1OWA (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Jun 2023 10:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=gFgr/WMjZrt5gb+UL2h9yo8fjkel+XtAbJzfGHXFrS4=; b=R3B0o/JcRiSjAqcrMKc03AhyQP
        vNlGFXxaLKaBfCNnguF1GGX4PWButD92hefQHm1SXzgk7VE9CgTyLot8OEAgiE9loNECeEe8V0ZHi
        ywsIR3QgBnFirHbzdJSjKXgJXMBP4zikg7NovwnDiIyHYZlS1ZsCIJCsyMsgLhc8q1Bo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qEW2u-0007kP-Gf; Wed, 28 Jun 2023 16:21:24 +0200
Date:   Wed, 28 Jun 2023 16:21:24 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Moritz Fischer <moritz.fischer.private@gmail.com>
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Moritz Fischer <moritzf@google.com>, netdev@vger.kernel.org,
        pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net, bryan.whitehead@microchip.com,
        UNGLinuxDriver@microchip.com, stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: lan743x: Don't sleep in atomic context
Message-ID: <6f79e4a6-de12-4c45-9899-d3e07d846c0e@lunn.ch>
References: <20230627035000.1295254-1-moritzf@google.com>
 <ZJrc5xjeHp5vYtAO@boxer>
 <35db66a9-d478-4b15-ad30-bfc4cded0b5c@lunn.ch>
 <CAFyOScpRDOvVrCsrwdxFstoNf1tOEnGbPSt5XDM1PKhCDyUGaw@mail.gmail.com>
 <ZJr1Ifp9cOlfcqbE@boxer>
 <9a42d3d3-a142-4e4a-811b-0b3b931e798b@lunn.ch>
 <CAJYdmeOatYbZo616HZv_peyqQRa38gtF9eT483wKNkG8gfN84g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJYdmeOatYbZo616HZv_peyqQRa38gtF9eT483wKNkG8gfN84g@mail.gmail.com>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

> Can you clarify if you suggest to leave this alone as-is in patch, or
> replace with something returning one of the errors above?
> 
> If the former, anything else missing in the patch?

I think the patch is O.K. Sorting out the ugly macro is a bigger job,
not something for this patch.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
