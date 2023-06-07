Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F2B726010
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 14:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238224AbjFGMvT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 08:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237700AbjFGMvL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 08:51:11 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9940D2101
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 05:50:57 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1112)
        id 2C2AE20BE4B5; Wed,  7 Jun 2023 05:50:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2C2AE20BE4B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1686142232;
        bh=iNY9dT4dRre+qhu3jgNWxjaKldmOR8zmfNnyGrzQPWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ANNJHJSf073rXuYD/Bpc+mqx4dLHMcLcxKHYuKq0AO/4NdoQzpgV4KNPcSnarVvRG
         d3uQrsfYwIFwcfH+eBd3rI7qNFVM4YLCjrm+o3aGTzVcu/1knQhhW19QgWHtZ63Zy7
         6ww5lXrMxQZtwtQ+GczjYRMFhwCOWCeKfA2GgkqA=
Date:   Wed, 7 Jun 2023 05:50:32 -0700
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     stable@vger.kernel.org, dpark@linux.microsoft.com,
        t-lo@linux.microsoft.com, Sasha Levin <sashal@kernel.org>,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 6.1] arm64: efi: Use SMBIOS processor version to key off
 Ampere quirk
Message-ID: <20230607125032.GA2556@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <2023060606-shininess-rosy-7533@gregkh>
 <20230607122612.GA846@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607122612.GA846@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jun 07, 2023 at 05:26:12AM -0700, Ard Biesheuvel wrote:
> [ Upstream commit eb684408f3ea4856639675d6465f0024e498e4b1 ]
> 
> Instead of using the SMBIOS type 1 record 'family' field, which is often
> modified by OEMs, use the type 4 'processor ID' and 'processor version'
> fields, which are set to a small set of probe-able values on all known
> Ampere EFI systems in the field.
> 
> Fixes: 550b33cfd4452968 ("arm64: efi: Force the use of ...")
> Tested-by: Andrea Righi <andrea.righi@canonical.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
> ---
>  drivers/firmware/efi/libstub/arm64-stub.c | 39 ++++++++++++++++-----
>  drivers/firmware/efi/libstub/efistub.h    | 41 +++++++++++++++++++++--
>  drivers/firmware/efi/libstub/smbios.c     | 13 +++++--
>  3 files changed, 80 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
> index 42282c5c3fe6..e2f90566b291 100644
> --- a/drivers/firmware/efi/libstub/arm64-stub.c
> +++ b/drivers/firmware/efi/libstub/arm64-stub.c

Sorry Ard, didn't meant to spoof your sender address.

Greg: commit 550b33cfd4452968 is in v6.1 but the fix for it (upstream
eb684408f3ea4856639675d6465f0024e498e4b1) was not marked for stable. Hence this
patch. It also needed a slight tweak because the file has been split since v6.1
(drivers/firmware/efi/libstub/arm64-stub.c => arm64.c).

My Ampere system returns "Server" to 'dmidecode -s system-family', so it hits
this.

Thanks,
Jeremi


