Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E83702C85
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 14:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241472AbjEOMSP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 08:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241786AbjEOMSO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 08:18:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22DBE53
        for <stable@vger.kernel.org>; Mon, 15 May 2023 05:18:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91D19616F1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 12:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD0EC433EF;
        Mon, 15 May 2023 12:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684153092;
        bh=FYnZROzLW+L9Qlu+fmdWildc7DLyIwLS1A0dsR6sGGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RXjvK3VsLNqhcvhzSgbF83EAUS7VWT57yt89vMYyBoGV5VRiTdcdja1GUVeX8VpAM
         yOGrKuozO37/R5zVGpiaUBnp1/KTgSq7y92PEcxfuZfQMN1y30gqtpJ+qq/T4QBiEg
         A7u7Lo+ZCPtvXiA/OxKK9J1n3d+vErAGHImrPdPA=
Date:   Mon, 15 May 2023 14:18:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-stable <stable@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        TRINH-THAI Florent <florent.trinh-thai@csgroup.eu>
Subject: Re: All stable branches: apply fc96ec826bce ("spi: fsl-cpm: Use 16
 bit mode for large transfers with even size")
Message-ID: <2023051534-portable-scarecrow-ec3c@gregkh>
References: <85d85262-30c0-6362-acb9-273c831c2c71@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85d85262-30c0-6362-acb9-273c831c2c71@csgroup.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, May 14, 2023 at 09:17:08AM +0000, Christophe Leroy wrote:
> Hello,
> 
> In addition to c20c57d9868d ("spi: fsl-spi: Fix CPM/QE mode Litte 
> Endian") that you already applied to all stable branches, could you 
> please also apply:
> 
> 8a5299a1278e ("spi: fsl-spi: Re-organise transfer bits_per_word adaptation")
> fc96ec826bce ("spi: fsl-cpm: Use 16 bit mode for large transfers with 
> even size")
> 
> For 4.14 and 4.19, as prerequisit you will also need
> 
> af0e6242909c ("spi: spi-fsl-spi: automatically adapt bits-per-word in 
> cpu mode")

That commit did not apply to 4.14 or 4.19, so I did not apply any of
these to those queues.  Please provide working backports for those trees
if you wish to see them there.

The other trees all got the 2 commits queued up now, thanks.

greg k-h
