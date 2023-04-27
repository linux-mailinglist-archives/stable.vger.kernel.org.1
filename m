Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12B36F03BC
	for <lists+stable@lfdr.de>; Thu, 27 Apr 2023 11:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243385AbjD0Jxr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Apr 2023 05:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243419AbjD0Jxp (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Apr 2023 05:53:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2994229
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 02:53:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85AFE62630
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 09:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981E2C4339C;
        Thu, 27 Apr 2023 09:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682589214;
        bh=d2vlnCXAQk3zlAeoOdHY3S6KoTiqIR4uFvsT0I8Wz74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e283D839YuFENta1GKZzFC5NhhJZzt1mSrwSSQbLoUhBSQ/QY3MGdDn5anZNzQOdv
         8Pp2slZ/eflfmA7A6iqiNu19S2QIoN3m1qzRhlt/pqmlUskgB9QUz4vhTqzw12WPwu
         D+LKkIahH/7dCL+DuOQpAymPtBeNxaJMEs5OAT2Q=
Date:   Thu, 27 Apr 2023 11:53:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org
Subject: Re: [PATCH 6.2.11 3/3] riscv: No need to relocate the dtb as it lies
 in the fixmap region
Message-ID: <2023042756-aggregate-distance-1d1a@gregkh>
References: <20230424150354.195572-1-alexghiti@rivosinc.com>
 <20230424150354.195572-4-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424150354.195572-4-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Apr 24, 2023 at 05:03:54PM +0200, Alexandre Ghiti wrote:
> commit 1b50f956c8fe9082bdee4a9cfd798149c52f7043 upstream.
> 
> We used to access the dtb via its linear mapping address but now that the
> dtb early mapping was moved in the fixmap region, we can keep using this
> address since it is present in swapper_pg_dir, and remove the dtb
> relocation.
> 
> Note that the relocation was wrong anyway since early_memremap() is
> restricted to 256K whereas the maximum fdt size is 2MB.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Cc: <stable@vger.kernel.org> # 6.2.x

You dropped everyone else's s-o-b for this patch, why?

Please don't do that.  Please fix up all of these series and resend.

thanks,

greg k-h
