Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525C17AA113
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 22:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjIUU6B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 16:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjIUU5p (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 16:57:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6E984606
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 10:37:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4FCC3277C;
        Thu, 21 Sep 2023 09:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695288515;
        bh=G/72W3XROjiLdSNgpem2NRDz21XAzQQ3FBgC/VZh1ns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rcpSjpDf8bAjNr6mw/tuRsf7aUwg01DB8upwdLLC5epVhSnzSedmrb3CuVtVskfJg
         rr8t7G1UqxNH6W1U9bDbTp6uv694aotNdQQ7f0AH1ynFfE+sMYwUjK8nqcJ0cj5bRG
         b6rhr87LRwZvI7bgkivuAfwdgiMX8HmqWX5DEC/o=
Date:   Thu, 21 Sep 2023 11:28:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 083/110] netfilter: nf_tables: GC transaction API to
 avoid race with control plane
Message-ID: <2023092151-broker-studio-f608@gregkh>
References: <20230920112830.377666128@linuxfoundation.org>
 <20230920112833.527435166@linuxfoundation.org>
 <ZQr7dfIjOom3PTX+@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQr7dfIjOom3PTX+@calendula>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 20, 2023 at 04:02:29PM +0200, Pablo Neira Ayuso wrote:
> Hi Greg,
> 
> On Wed, Sep 20, 2023 at 01:32:21PM +0200, Greg Kroah-Hartman wrote:
> > 5.15-stable review patch.  If anyone has any objections, please let me know.
> 
> Please, keep this back from 5.15, I am preparing a more complete patch
> series which includes follow up fixes for this on top of this.

Thanks, I've dropped all of these netfilter patches from this tree/queue
now.

greg k-h
