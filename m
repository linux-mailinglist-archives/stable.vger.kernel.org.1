Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9CF797396
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 17:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjIGP2C (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 7 Sep 2023 11:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbjIGPW5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 7 Sep 2023 11:22:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1843D171F
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 08:22:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B448C32798;
        Thu,  7 Sep 2023 14:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694097989;
        bh=1aoCYTKhDuHIFTVdWtM/x9ZSKfYB3FD6Z0V6i3rRwh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JGOTCFzQiGpWE4P3/LJz9diRPFmFhREAXMjwMhd0IBBpNhPb9BshSfnwLYtkSH3Xt
         34yT90OEm6ywYRYTJWZ2gnzcbDzPbHC3XACph7cuvgrfvoCEmSeoIrTzu1Ol320qvC
         DHr5lwMRBF2qMsg7Ff1PaPMCiLmE+Duqcbv0eRrU=
Date:   Thu, 7 Sep 2023 15:46:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-stable <stable@vger.kernel.org>,
        TRINH-THAI Florent <florent.trinh-thai@csgroup.eu>,
        CASAUBON Jean-Michel <jean-michel.casaubon@csgroup.eu>
Subject: Re: Please apply 98ecc6768e8fd to 4.14 and 4.19
Message-ID: <2023090719-exuberant-marvelous-3d49@gregkh>
References: <77d5d7ea-6526-3f42-7d3d-3c11b0fd3770@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77d5d7ea-6526-3f42-7d3d-3c11b0fd3770@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Sep 07, 2023 at 01:37:19PM +0000, Christophe Leroy wrote:
> Hi,
> 
> Could you please apply commit 98ecc6768e8f ("powerpc/32: Include 
> .branch_lt in data section") to kernels 4.14 and 4.19 so that we avoid 
> having the related warnings.

Now queued up, thanks.

greg k-h
