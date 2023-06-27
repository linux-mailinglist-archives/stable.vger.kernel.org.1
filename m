Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F0F73FC6C
	for <lists+stable@lfdr.de>; Tue, 27 Jun 2023 15:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjF0NIA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 27 Jun 2023 09:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjF0NH7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Jun 2023 09:07:59 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DB41715;
        Tue, 27 Jun 2023 06:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=XUis5pG35TsAgUo4YDECHCrWQ4QCida4BlQpVHkG5bA=; b=I3ROVaFWpWwm1rFStU6g8fw0Dr
        /RrARqjoo6AQ+tACuJcEbLhEDaqsy0Q0biQRlxT78jtC/mc1T+29TmNMLzxzuKOVTc1yQjVv9+bRX
        RZZFPIR1WFrKxW1//f6tvR4BryWk+pGFeEoE9nocVL2WnHgH5L/Obe3FqU2AapAXHxZA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qE8Pw-0001oD-IO; Tue, 27 Jun 2023 15:07:36 +0200
Date:   Tue, 27 Jun 2023 15:07:36 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     Moritz Fischer <moritzf@google.com>, netdev@vger.kernel.org,
        pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net, bryan.whitehead@microchip.com,
        UNGLinuxDriver@microchip.com, mdf@kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: lan743x: Don't sleep in atomic context
Message-ID: <35db66a9-d478-4b15-ad30-bfc4cded0b5c@lunn.ch>
References: <20230627035000.1295254-1-moritzf@google.com>
 <ZJrc5xjeHp5vYtAO@boxer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJrc5xjeHp5vYtAO@boxer>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

> > +static int lan743x_csr_wait_for_bit_atomic(struct lan743x_adapter *adapter,
> 
> adapter is not used in readx_poll_timeout_atomic() call, right?
> can be removed.

I thought that when i first looked at an earlier version of this
patch. But LAN743X_CSR_READ_OP is not what you think :-(

       Andrew
