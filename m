Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1987CB0FA
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 19:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbjJPRFq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 13:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbjJPRFY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 13:05:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178842D74
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 10:02:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C92C433C7;
        Mon, 16 Oct 2023 17:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697475731;
        bh=Cr/WKqaWjw62PAFlI5Q9yZuDtc3aus5qxX6u9XpKiI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=axYCOLvJ/ewXMtghMZFuyrskr4inxA4EYTCp9A0EvP/iLJSOwtYDT03uKhL7gEP/d
         fDfGl6TpYyGPFFXoDQJwExa79I8t+N4zNAbFjAI9sv8NPJP+h5kc9u2kaS8f7Bdc3D
         lg1sTXLb6uKe2hjGBs33umXLHesW7b5gDkAOIg3A=
Date:   Mon, 16 Oct 2023 19:02:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Simon Horman <horms@kernel.org>,
        Shradha Gupta <shradhagupta@linux.microsoft.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 001/131] net: mana: Fix TX CQE error handling
Message-ID: <2023101659-bronco-maybe-0dc7@gregkh>
References: <20231016084000.050926073@linuxfoundation.org>
 <20231016084000.092429858@linuxfoundation.org>
 <PH7PR21MB31164DEC6C6E7FBBC7CAE008CAD7A@PH7PR21MB3116.namprd21.prod.outlook.com>
 <2023101613-verbalize-runaround-f67f@gregkh>
 <PH7PR21MB311624F90B8FC50D05200712CAD7A@PH7PR21MB3116.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB311624F90B8FC50D05200712CAD7A@PH7PR21MB3116.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 16, 2023 at 03:35:27PM +0000, Haiyang Zhang wrote:
> 
> 
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Monday, October 16, 2023 10:47 AM
> > To: Haiyang Zhang <haiyangz@microsoft.com>
> > Cc: stable@vger.kernel.org; patches@lists.linux.dev; Simon Horman
> > <horms@kernel.org>; Shradha Gupta <shradhagupta@linux.microsoft.com>;
> > Paolo Abeni <pabeni@redhat.com>; Sasha Levin <sashal@kernel.org>
> > Subject: Re: [PATCH 6.1 001/131] net: mana: Fix TX CQE error handling
> > 
> > On Mon, Oct 16, 2023 at 02:35:15PM +0000, Haiyang Zhang wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Sent: Monday, October 16, 2023 4:40 AM
> > > > To: stable@vger.kernel.org
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> > > > patches@lists.linux.dev; Haiyang Zhang <haiyangz@microsoft.com>;
> > Simon
> > > > Horman <horms@kernel.org>; Shradha Gupta
> > > > <shradhagupta@linux.microsoft.com>; Paolo Abeni
> > <pabeni@redhat.com>;
> > > > Sasha Levin <sashal@kernel.org>
> > > > Subject: [PATCH 6.1 001/131] net: mana: Fix TX CQE error handling
> > > >
> > > > 6.1-stable review patch.  If anyone has any objections, please let me know.
> > > >
> > > > ------------------
> > > >
> > > > From: Haiyang Zhang <haiyangz@microsoft.com>
> > > >
> > > > [ Upstream commit b2b000069a4c307b09548dc2243f31f3ca0eac9c ]
> > > >
> > > > For an unknown TX CQE error type (probably from a newer hardware),
> > > > still free the SKB, update the queue tail, etc., otherwise the
> > > > accounting will be wrong.
> > > >
> > > > Also, TX errors can be triggered by injecting corrupted packets, so
> > > > replace the WARN_ONCE to ratelimited error logging.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure
> > Network
> > > > Adapter (MANA)")
> > > > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > > > Reviewed-by: Simon Horman <horms@kernel.org>
> > > > Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > > ---
> > > >  drivers/net/ethernet/microsoft/mana/mana_en.c | 16 ++++++++++------
> > > >  1 file changed, 10 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > > b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > > index 4f4204432aaa3..23ce26b8295dc 100644
> > > > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > > @@ -1003,16 +1003,20 @@ static void mana_poll_tx_cq(struct mana_cq
> > > > *cq)
> > > >  		case CQE_TX_VPORT_IDX_OUT_OF_RANGE:
> > > >  		case CQE_TX_VPORT_DISABLED:
> > > >  		case CQE_TX_VLAN_TAGGING_VIOLATION:
> > > > -			WARN_ONCE(1, "TX: CQE error %d: ignored.\n",
> > > > -				  cqe_oob->cqe_hdr.cqe_type);
> > > > +			if (net_ratelimit())
> > > > +				netdev_err(ndev, "TX: CQE error %d\n",
> > > > +					   cqe_oob->cqe_hdr.cqe_type);
> > > > +
> > > >  			break;
> > > >
> > > >  		default:
> > > > -			/* If the CQE type is unexpected, log an error, assert,
> > > > -			 * and go through the error path.
> > > > +			/* If the CQE type is unknown, log an error,
> > > > +			 * and still free the SKB, update tail, etc.
> > > >  			 */
> > > > -			WARN_ONCE(1, "TX: Unexpected CQE type %d: HW
> > > > BUG?\n",
> > > > -				  cqe_oob->cqe_hdr.cqe_type);
> > > > +			if (net_ratelimit())
> > > > +				netdev_err(ndev, "TX: unknown CQE
> > > > type %d\n",
> > > > +					   cqe_oob->cqe_hdr.cqe_type);
> > > > +
> > > >  			return;
> > >
> > > This should be changed to "break", because we should "still free the SKB,
> > update
> > > the queue tail, etc., otherwise the accounting will be wrong":
> > 
> > Is that an issue in Linus's tree, or is this unique to the stable
> > backport?
> 
> It's just a stable backporting issue.
> 
> Linus's tree is fine:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b2b000069a4c307b09548dc2243f31f3ca0eac9c

Thanks, I've fixed this up now.

greg k-h
