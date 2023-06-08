Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD4A727905
	for <lists+stable@lfdr.de>; Thu,  8 Jun 2023 09:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjFHHoO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 03:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjFHHoK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 03:44:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDED126B5
        for <stable@vger.kernel.org>; Thu,  8 Jun 2023 00:44:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EC4E649AB
        for <stable@vger.kernel.org>; Thu,  8 Jun 2023 07:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E25C4339E;
        Thu,  8 Jun 2023 07:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686210247;
        bh=44ZX1/E2URdeoOQhLnD0WSIkxPdv5hv0yg9fQ0AKqQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NVF+otL98/xTKC6DMJu/vGfZAQzdK5ca97MewAtJJEKkMymQkknbqDCtbBF5p/uk5
         9DZuEkalhYoQO1dNB9/cp3rGCtwVZ1rjnAnx93gk1fnsUeB/879tVePQTOgrSCeZXE
         2LSaxwOP+JsdNSE7cKwnLrTpEQC8S4dvDiSLdMr8=
Date:   Thu, 8 Jun 2023 09:44:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     stable@vger.kernel.org, dpark@linux.microsoft.com,
        t-lo@linux.microsoft.com, Sasha Levin <sashal@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 6.1] arm64: efi: Use SMBIOS processor version to key off
 Ampere quirk
Message-ID: <2023060845-wipe-headlamp-6c00@gregkh>
References: <2023060606-shininess-rosy-7533@gregkh>
 <20230607122612.GA846@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <2023060719-uncertain-implant-dede@gregkh>
 <c8928af7-3e93-515e-1259-1d172cedef83@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8928af7-3e93-515e-1259-1d172cedef83@linux.microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 08, 2023 at 09:36:22AM +0200, Jeremi Piotrowski wrote:
> On 6/7/2023 8:36 PM, Greg KH wrote:
> > On Wed, Jun 07, 2023 at 05:26:12AM -0700, Ard Biesheuvel wrote:
> >> [ Upstream commit eb684408f3ea4856639675d6465f0024e498e4b1 ]
> >>
> >> Instead of using the SMBIOS type 1 record 'family' field, which is often
> >> modified by OEMs, use the type 4 'processor ID' and 'processor version'
> >> fields, which are set to a small set of probe-able values on all known
> >> Ampere EFI systems in the field.
> >>
> >> Fixes: 550b33cfd4452968 ("arm64: efi: Force the use of ...")
> >> Tested-by: Andrea Righi <andrea.righi@canonical.com>
> >> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >> Signed-off-by: Sasha Levin <sashal@kernel.org>
> > 
> > Where did Sasha sign off on this?
> > 
> 
> I must have picked the commit from the 6.2 backport:
> 
> https://lore.kernel.org/stable/20230328142621.544265000@linuxfoundation.org/#t
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.2.16&id=b824efafca6739f6c80d22d88a83e6545114ed8e

When doing so, please be explicit, otherwise it is very confusing.

thanks,

greg k-h
