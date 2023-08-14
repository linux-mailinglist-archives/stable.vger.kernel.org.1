Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC6F77BC8A
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 17:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjHNPLF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 14 Aug 2023 11:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjHNPKg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 Aug 2023 11:10:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B437F199C
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 08:10:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8429663CC7
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 15:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D16C433C8;
        Mon, 14 Aug 2023 15:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692025792;
        bh=lB+NX6rQL/MstH4LG/ZC38jCNFEb1O73poFvlc48Nuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XWyFPrvdyQ72RkeWtNBrOcIKw6lRFUUl5muIRNS8d/UUukGzHr4o0jdZwQn+c+QLZ
         2TOg6G4kdxE2+PrS4wPimJrcWFtaiYiaEBCCx+zJ8BTjEmByEjjSatJ3PLleVik7V9
         1HY1EHb8h/aWwnymjaEqhCfipWDbv5RipolZSRjM=
Date:   Mon, 14 Aug 2023 17:09:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCe0YTQuNGG0LXRgNC+0LI=?= 
        <oficerovas@basealt.ru>
Cc:     stable@vger.kernel.org
Subject: Re: Fwd: [PATCH 2/3] mfd: intel-lpss: Add Alder Lake's PCI devices
 IDs
Message-ID: <2023081444-sank-strung-e482@gregkh>
References: <20230810115938.3741058-4-oficerovas@altlinux.org>
 <e8ff06f2-d766-dddf-869e-4c889364f83b@basealt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8ff06f2-d766-dddf-869e-4c889364f83b@basealt.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Aug 14, 2023 at 05:35:19PM +0300, Александр Офицеров wrote:
> 
> 
> 
> -------- Перенаправленное сообщение --------
> Тема: 	[PATCH 2/3] mfd: intel-lpss: Add Alder Lake's PCI devices IDs
> Дата: 	Thu, 10 Aug 2023 14:59:37 +0300
> От: 	Alexander Ofitserov <oficerovas@altlinux.org>
> Кому: 	oficerovas@altlinux.org, Lee Jones <lee.jones@linaro.org>
> Копия: 	linux-kernel@vger.kernel.org
> 
> 
> 
> Intel Alder Lake PCH has the same LPSS as Intel Broxton.
> Add the new IDs to the list of supported devices.
> 
> Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
