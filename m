Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166A9702CD5
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 14:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbjEOMhe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 08:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241850AbjEOMfd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 08:35:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DC619BB
        for <stable@vger.kernel.org>; Mon, 15 May 2023 05:33:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54A2161840
        for <stable@vger.kernel.org>; Mon, 15 May 2023 12:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3232BC433A4;
        Mon, 15 May 2023 12:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684154003;
        bh=EKBIXsFGmXRshytrxzJ5UDTM0Od//GCVrnTO8Fn5mkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hL5UlOCbjfmezILbXXYIO902kwzI1i+rNCxey+kaBfUmv5Tuu6o71zJ5yJszjeML2
         KivdjchfFVufCt9UoBG/FGBXXMLYzLN8xknd5mW+N4sU59+R1MiopgxHrXYGQ7u3WF
         cACKZgU0FOvAvYbMHLzBK6BpEJPhPShKgUi245R4=
Date:   Mon, 15 May 2023 14:33:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-stable <stable@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        TRINH-THAI Florent <florent.trinh-thai@csgroup.eu>
Subject: Re: All stable branches: apply fc96ec826bce ("spi: fsl-cpm: Use 16
 bit mode for large transfers with even size")
Message-ID: <2023051543-unwound-squealer-f3c9@gregkh>
References: <85d85262-30c0-6362-acb9-273c831c2c71@csgroup.eu>
 <2023051534-portable-scarecrow-ec3c@gregkh>
 <1b880684-6e3a-08f9-f442-c5e0553f5eb7@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b880684-6e3a-08f9-f442-c5e0553f5eb7@csgroup.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 15, 2023 at 12:29:51PM +0000, Christophe Leroy wrote:
> 
> 
> Le 15/05/2023 à 14:18, Greg Kroah-Hartman a écrit :
> > On Sun, May 14, 2023 at 09:17:08AM +0000, Christophe Leroy wrote:
> >> Hello,
> >>
> >> In addition to c20c57d9868d ("spi: fsl-spi: Fix CPM/QE mode Litte
> >> Endian") that you already applied to all stable branches, could you
> >> please also apply:
> >>
> >> 8a5299a1278e ("spi: fsl-spi: Re-organise transfer bits_per_word adaptation")
> >> fc96ec826bce ("spi: fsl-cpm: Use 16 bit mode for large transfers with
> >> even size")
> >>
> >> For 4.14 and 4.19, as prerequisit you will also need
> >>
> >> af0e6242909c ("spi: spi-fsl-spi: automatically adapt bits-per-word in
> >> cpu mode")
> > 
> > That commit did not apply to 4.14 or 4.19, so I did not apply any of
> > these to those queues.  Please provide working backports for those trees
> > if you wish to see them there.
> > 
> 
> That's strange. It does apply cleanly with 'git cherry-pick':
> 
> $ git reset --hard v4.14.314
> HEAD is now at 9bbf62a71963 Linux 4.14.314
> 
> $ git cherry-pick af0e6242909c
> Auto-merging drivers/spi/spi-fsl-spi.c
> [detached HEAD 0923539dff2f] spi: spi-fsl-spi: automatically adapt 
> bits-per-word in cpu mode
>   Author: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>   Date: Wed Mar 27 14:30:52 2019 +0000
>   1 file changed, 16 insertions(+)
> 
> I can send the result of the cherry-pick if it helps.

Odds are it will break the build, given that it did so for 5.4, 5.10,
and 5.15, so please, send a backported, tested, set of patches and I
will be glad to queue them up.

thanks,

greg k-h
