Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7D47312A1
	for <lists+stable@lfdr.de>; Thu, 15 Jun 2023 10:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245371AbjFOItO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 15 Jun 2023 04:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245340AbjFOIsY (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Jun 2023 04:48:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A0E3C21;
        Thu, 15 Jun 2023 01:47:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E91A611CE;
        Thu, 15 Jun 2023 08:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55724C433C0;
        Thu, 15 Jun 2023 08:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686818834;
        bh=m56mMgbW3ae6uqBwLx78dUGnP/kMnvofIKBmjW32CP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vzrZNdyDH6kLNr/bXr1VgU7KQgPThhD4lLvUe/0vTGnrAqDnKuFSKbBIOrdo4d+7E
         A9o3e+NuTglmnAuXUYNZ5IIUdIRofVFdyQg7biiu4bvoDNmr8af5lsSYO2DprtxHVa
         Y/gkhL68z899XRPx5iG2Lbk8RKT1G+t0RogvU8sg=
Date:   Thu, 15 Jun 2023 10:47:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ranjan Kumar <ranjan.kumar@broadcom.com>
Cc:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] mpt3sas: Perform additional retries if Doorbell read
 returns 0
Message-ID: <2023061538-dizzy-amiable-9ec7@gregkh>
References: <20230615083010.45837-1-ranjan.kumar@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615083010.45837-1-ranjan.kumar@broadcom.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 15, 2023 at 02:00:10PM +0530, Ranjan Kumar wrote:
> Doorbell and Host diagnostic registers could return 0 even
> after 3 retries and that leads to occasional resets of the
> controllers, hence increased the retry count to thirty.
> 
> 'Fixes: b899202901a8 ("mpt3sas: Add separate function for aero doorbell reads ")'

No ' characters here please.

> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>

No blank line before the signed-off-by and the other fields please.

Didn't checkpatch warn you about this?

> ---
>  drivers/scsi/mpt3sas/mpt3sas_base.c | 50 ++++++++++++++++-------------
>  drivers/scsi/mpt3sas/mpt3sas_base.h |  4 ++-
>  2 files changed, 31 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
> index 53f5492579cb..44e7ccb6f780 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_base.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
> @@ -201,20 +201,20 @@ module_param_call(mpt3sas_fwfault_debug, _scsih_set_fwfault_debug,
>   * while reading the system interface register.
>   */
>  static inline u32
> -_base_readl_aero(const volatile void __iomem *addr)
> +_base_readl_aero(const volatile void __iomem *addr, u8 retry_count)

Are you sure that volatile really does what you think it does here?


>  {
>  	u32 i = 0, ret_val;
>  
>  	do {
>  		ret_val = readl(addr);
>  		i++;
> -	} while (ret_val == 0 && i < 3);
> +	} while (ret_val == 0 && i < retry_count);

So newer systems will complete this failure loop faster than older ones?
That feels very wrong, you will be changing this in a year or so.  Use
time please, not counts.

thanks,

greg k-h
