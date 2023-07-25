Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F83761860
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 14:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjGYM37 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 08:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbjGYM35 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 08:29:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E141718
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 05:29:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30E83616C2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 12:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41525C433C8;
        Tue, 25 Jul 2023 12:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690288195;
        bh=uZFw7A8lXOgbpYEhwryQMZv/uuFEem4FSIbwm53Wy+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vr7q2aWM42mN+pHEOgHHthgCKw5ubpHfBtnIleKrde7jN94uVol6c1zfJo9BlNfnc
         RAHWqD+fsVCju/EfECmDZSgEnfO1sv/ZMNdo3stWabYycELPKdkvEv+gicIvqPfvtR
         IPrwoFW9v5uIdauQYlYYPL1umltq18smSwPY0vig=
Date:   Tue, 25 Jul 2023 14:29:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "# 3.4.x" <stable@vger.kernel.org>
Subject: Re: backport request
Message-ID: <2023072521-refurnish-grooving-fd36@gregkh>
References: <CAMj1kXHQkgRCt=W0FbZZ9qLVCaWisFhv9wJtYONjA3cEPdXMRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHQkgRCt=W0FbZZ9qLVCaWisFhv9wJtYONjA3cEPdXMRQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jul 25, 2023 at 01:13:34PM +0200, Ard Biesheuvel wrote:
> Please backport commit
> 
> commit 9cf42bca30e98a1c6c9e8abf876940a551eaa3d1
> Author: Ard Biesheuvel <ardb@kernel.org>
> Date:   Tue Aug 2 11:00:16 2022 +0200
> 
>     efi: libstub: use EFI_LOADER_CODE region when moving the kernel in memory
> 
> to all active stable trees all the way back to v5.15. I will provide a
> separate backport for v5.10, and possibly a [much] larger set of
> backports for v5.4 for EFI boot support.

Sure, but why?  That sounds like a new feature, if you want EFI boot
support, why not just move to a newer kernel tree?  What bug is this
fixing?

thanks,

greg k-h
