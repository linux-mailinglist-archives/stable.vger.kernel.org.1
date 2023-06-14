Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE2072F876
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 10:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjFNI5A (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 04:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjFNI47 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 04:56:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F367510E9
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 01:56:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8758B62EAD
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 08:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A89C433C0;
        Wed, 14 Jun 2023 08:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686733017;
        bh=Xnri1Toeh7APRF4Cq3k1ATqh5aTwOIcCK3Gpu59jp8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QCa+2vsyOlulHkmwNYQ2orw0C8pCceDfFf8TG853d9X7Sevpd0Qft8I2CBvkYW/84
         s8Mhc//2mqSoY6tfN8zv/lAKO86qDPt/7FZd4lX8NgFUWput6xB9xpJz6atJmtUbuD
         vo1cGS8PxyjgRLK5SAMxk10LdCGSaNbb+14cl8wM=
Date:   Wed, 14 Jun 2023 10:56:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 4.19 02/23] i40e: fix build warnings in i40e_alloc.h
Message-ID: <2023061459-scribe-doozy-40b9@gregkh>
References: <20230612101651.138592130@linuxfoundation.org>
 <20230612101651.237619015@linuxfoundation.org>
 <b0662a1562dca6aa2059f908cf18e7be1bf26707.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0662a1562dca6aa2059f908cf18e7be1bf26707.camel@decadent.org.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jun 14, 2023 at 04:05:08AM +0200, Ben Hutchings wrote:
> On Mon, 2023-06-12 at 12:26 +0200, Greg Kroah-Hartman wrote:
> > Not upstream as it was fixed in a much larger api change in newer
> > kernels.
> > 
> > gcc-13 rightfully complains that enum is not the same as an int, so fix
> > up the function prototypes in i40e_alloc.h to be correct, solving a
> > bunch of build warnings.
> > 
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_alloc.h |   17 ++++++-----------
> >  1 file changed, 6 insertions(+), 11 deletions(-)
> > 
> > --- a/drivers/net/ethernet/intel/i40e/i40e_alloc.h
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_alloc.h
> > @@ -20,16 +20,11 @@ enum i40e_memory_type {
> >  };
> >  
> >  /* prototype for functions used for dynamic memory allocation */
> > -i40e_status i40e_allocate_dma_mem(struct i40e_hw *hw,
> > -					    struct i40e_dma_mem *mem,
> > -					    enum i40e_memory_type type,
> > -					    u64 size, u32 alignment);
> > -i40e_status i40e_free_dma_mem(struct i40e_hw *hw,
> > -					struct i40e_dma_mem *mem);
> > -i40e_status i40e_allocate_virt_mem(struct i40e_hw *hw,
> > -					     struct i40e_virt_mem *mem,
> > -					     u32 size);
> > -i40e_status i40e_free_virt_mem(struct i40e_hw *hw,
> > -					 struct i40e_virt_mem *mem);
> > +int i40e_allocate_dma_mem(struct i40e_hw *hw, struct i40e_dma_mem *mem,
> > +			  enum i40e_memory_type type, u64 size, u32 alignment);
> > +int i40e_free_dma_mem(struct i40e_hw *hw, struct i40e_dma_mem *mem);
> > +int i40e_allocate_virt_mem(struct i40e_hw *hw, struct i40e_virt_mem *mem,
> > +			   u32 size);
> > +int i40e_free_virt_mem(struct i40e_hw *hw, struct i40e_virt_mem *mem);
> 
> All these function names are actually macro names, which seems a very
> strange way to declare functions.
> 
> Shouldn't the declarations use the actual function names, which have
> "_d" suffixes?

Probably, yes, I was just trying to do the least-ammount-of-work-needed
to fix up a bunch of obvious errors that were causing build warnings on
newer versions of gcc :)

All of this is fixed differently in Linus's tree, but those changes were
way too messy to backport.

thanks,

greg k-h
