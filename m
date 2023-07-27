Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6027651B4
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 12:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjG0Kzi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Jul 2023 06:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjG0Kzh (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Jul 2023 06:55:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023711FEC;
        Thu, 27 Jul 2023 03:55:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ABC961E2B;
        Thu, 27 Jul 2023 10:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F66AC433C8;
        Thu, 27 Jul 2023 10:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690455336;
        bh=/n4Q4c520RL7Dl1tKjCtWlPmGbvq9IJDChGjJVXs3iA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G4yjxx+pq0FC2yz380v4JjUcdM4+LM7YQtI2TQLiO9WcWE63wZB2I3VkXI3VqcP7m
         mrBG5ZkBRTH0WCQgbCSX7Uzf8xw4f5ZEC8YBgQpVbNa0Szik89JJ8GaiX3VuPJbbhT
         prPYc1g+Qf9s4l5OmxdsXlT2iLR/zgKc1oDBFClQ=
Date:   Thu, 27 Jul 2023 12:55:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: Netfilter -stable patches for 6.1.y
Message-ID: <2023072724-thing-unselect-9f67@gregkh>
References: <ZMGbe24I9I+FOH57@calendula>
 <ZMGeeQiPNLhIlAd4@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMGeeQiPNLhIlAd4@calendula>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jul 27, 2023 at 12:30:17AM +0200, Pablo Neira Ayuso wrote:
> On Thu, Jul 27, 2023 at 12:17:31AM +0200, Pablo Neira Ayuso wrote:
> > Hi Greg, Sasha,
> > 
> > Could you please cherry-pick:
> > 
> >  29ad9a305943 ("netfilter: nf_tables: fix underflow in chain reference counter")
> >  b8ae60de6fd3 ("netfilter: nf_tables: fix underflow in object reference counter"
> 
> Err. Wrong commit IDs and patch order, apologies.
> 
> Correct commit IDs are:
> 
> Patch #1 d6b478666ffa ("netfilter: nf_tables: fix underflow in object reference counter")
> Patch #2 b389139f12f2 ("netfilter: nf_tables: fix underflow in chain reference counter")

Both now queued up, thanks.

greg k-h
