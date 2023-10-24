Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EA57D5380
	for <lists+stable@lfdr.de>; Tue, 24 Oct 2023 15:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbjJXN7b (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 24 Oct 2023 09:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbjJXN7a (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 24 Oct 2023 09:59:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09973D79
        for <stable@vger.kernel.org>; Tue, 24 Oct 2023 06:59:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C55AC433C8;
        Tue, 24 Oct 2023 13:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698155968;
        bh=w3OGgyf7wCi15F47CI7sYCuNlmg5wNYVOg+QfYrP+Sk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ut3tekt59RfqMr08DWV31FVD/eb4aQ8+gfIk6qpeWPdKsOlJnsHplppPDTR7emAFU
         ku3sffWKBxKLzQnt72JBUU0ebVCE+hbg7jb4vPxbOJRkkS4cWj2dClvJJVhZNPhVGT
         W2398lGBM24BXKcvZGrdFmSg5J4kZIqDWbOeX4r4=
Date:   Tue, 24 Oct 2023 15:59:25 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9?= Javier 
        <josejavier.rodriguez@duagon.com>
Cc:     "sashal@kernel.org" <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?B?U2FuanXhbiBHYXJj7WEs?= Jorge 
        <Jorge.SanjuanGarcia@duagon.com>,
        "morbidrsa@gmail.com" <morbidrsa@gmail.com>
Subject: Re: Missing patches of a patch series during AUTOSEL backport
Message-ID: <2023102450-designed-cosmic-1bb2@gregkh>
References: <aa7145b39b72237a7cfd9ab8ba92ad26271f4881.camel@duagon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa7145b39b72237a7cfd9ab8ba92ad26271f4881.camel@duagon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 24, 2023 at 01:02:39PM +0000, Rodríguez Barbarin, José Javier wrote:
> Dear Sasha Levin,
> 
> I am the author of a patch series and I am writting you because I have
> detected an issue with a patch series I have submitted in May'23.
> 
> I sent a series of 3 patches to the maintainer. When he approved them,
> he sent an email to Greg, requesting him to include such
> patch series in kernel 6.4.
> 
> You can check the email thread here:
> 
> https://lore.kernel.org/all/20230411083329.4506-1-jth@kernel.org/

I totally missed that patch thread as there was no git commit ids in it,
sorry.

> For a reason I cannot understand, the AUTOSEL only chose 1 of 3 patches
> of the series, so only 1 was backported to stable kernel versions.
> 
> [PATCH AUTOSEL 6.3 24/24] mcb-pci: Reallocate memory region to avoid
> memory overlapping
> [PATCH AUTOSEL 6.2 20/20] mcb-pci: Reallocate memory region to avoid
> memory overlapping
> [PATCH AUTOSEL 6.1 19/19] mcb-pci: Reallocate memory region to avoid
> memory overlapping
> [PATCH AUTOSEL 5.15 10/10] mcb-pci: Reallocate memory region to avoid
> memory overlapping
> [PATCH AUTOSEL 5.10 9/9] mcb-pci: Reallocate memory region to avoid
> memory overlapping
> [PATCH AUTOSEL 5.4 9/9] mcb-pci: Reallocate memory region to avoid
> memory overlapping
> [PATCH AUTOSEL 4.19 9/9] mcb-pci: Reallocate memory region to avoid
> memory overlapping
> [PATCH AUTOSEL 4.14 8/8] mcb-pci: Reallocate memory region to avoid
> memory overlapping
> 
> In kernel 6.4 and above, the 3 patches were included.

autosel comes along later and decided that some of them were to be
included, that was independent of your email.

> Including only 1 patch is causing crashes in part of our devices.
> 
> Please, could you backport the remaining 2 patches to the stable
> versions?

What is the git commit ids that you are asking for to be applied?
That's a requirement for us to take stuff.

thanks,

greg k-h
