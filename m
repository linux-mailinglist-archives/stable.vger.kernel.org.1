Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD32D6F1119
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 06:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345338AbjD1EqV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 00:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjD1EqU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 00:46:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7C22696
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 21:46:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F411F634BC
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 04:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5E4C433EF;
        Fri, 28 Apr 2023 04:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682657178;
        bh=A6UoyBfXXjCTt4t89SXMJW1R125z01cnN3jkKijKcYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WFeO5AXy9KqtoRk6omAj5s4gcsa8oKKF/euEfXbdWlajryvyDTYfE3VDgAlV3aH9F
         f0uITjcKJMFnPDBjC2vlOFjGBknLnFzzd/FE7cwxqEvZxoOpBDwi392mTro6HhF+7W
         IgreCHmyDBaRemxGtON1utwkTpTNTRLeWciCx9K4=
Date:   Fri, 28 Apr 2023 06:46:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org
Subject: Re: [PATCH 6.2.11 3/3] riscv: No need to relocate the dtb as it lies
 in the fixmap region
Message-ID: <ZEtPl3h2Ucy3ry9L@kroah.com>
References: <20230424150354.195572-1-alexghiti@rivosinc.com>
 <20230424150354.195572-4-alexghiti@rivosinc.com>
 <2023042756-aggregate-distance-1d1a@gregkh>
 <CAHVXubgTt4K+Vp0jmd+KyjNYVYKJ+32EhPNbM=1ObxwSoyaKnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHVXubgTt4K+Vp0jmd+KyjNYVYKJ+32EhPNbM=1ObxwSoyaKnQ@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Apr 27, 2023 at 05:23:33PM +0200, Alexandre Ghiti wrote:
> Hi Greg,
> 
> On Thu, Apr 27, 2023 at 11:53 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Apr 24, 2023 at 05:03:54PM +0200, Alexandre Ghiti wrote:
> > > commit 1b50f956c8fe9082bdee4a9cfd798149c52f7043 upstream.
> > >
> > > We used to access the dtb via its linear mapping address but now that the
> > > dtb early mapping was moved in the fixmap region, we can keep using this
> > > address since it is present in swapper_pg_dir, and remove the dtb
> > > relocation.
> > >
> > > Note that the relocation was wrong anyway since early_memremap() is
> > > restricted to 256K whereas the maximum fdt size is 2MB.
> > >
> > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > Cc: <stable@vger.kernel.org> # 6.2.x
> >
> > You dropped everyone else's s-o-b for this patch, why?
> 
> Sorry for that, I'll fix it. Should I add the s-o-b even for the
> patches that I had to adapt?

Yes, you _have_ to do that :)

thanks,

greg k-h
