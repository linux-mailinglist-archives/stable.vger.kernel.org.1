Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533F17022E0
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 06:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjEOESo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 00:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjEOESn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 00:18:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E30E48
        for <stable@vger.kernel.org>; Sun, 14 May 2023 21:18:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A47BB61EA7
        for <stable@vger.kernel.org>; Mon, 15 May 2023 04:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35FFC433D2;
        Mon, 15 May 2023 04:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684124321;
        bh=zO2YU5w39e6i3Gd1T33Z/PDeeH4qfJ5Ro9oo/RxiuiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vdgNJkmPkyCphG0k3ZBRlrKsE2g9vOPuwzCn5poSdvH9UvynYa19VQCg36IHJeICt
         bVX09uEOhg+nqOsaB0XUm8N8HRDWaSg8HHpIiSl8YXQ6QOXqk4TsGu78hUOToKTVT5
         s/sfZvEzjQG+RE1Jnu/pt6D9NMwKLlf0bF9G9qcE=
Date:   Mon, 15 May 2023 06:18:38 +0200
From:   'Greg KH' <gregkh@linuxfoundation.org>
To:     Yeongjin Gil <youngjin.gil@samsung.com>
Cc:     stable@vger.kernel.org, 'Sungjong Seo' <sj1557.seo@samsung.com>,
        'Mike Snitzer' <snitzer@kernel.org>
Subject: Re: [PATCH v2] dm verity: fix error handling for check_at_most_once
 on FEC
Message-ID: <2023051503-freefall-truce-372a@gregkh>
References: <2023050701-epileptic-unethical-f46c@gregkh>
 <CGME20230515011823epcas1p2e05135dda9e7e159d637016d81d55abc@epcas1p2.samsung.com>
 <20230515011816.25372-1-youngjin.gil@samsung.com>
 <2023051508-payphone-dimly-b417@gregkh>
 <001701d986e2$934c1cb0$b9e45610$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001701d986e2$934c1cb0$b9e45610$@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 15, 2023 at 01:06:07PM +0900, Yeongjin Gil wrote:
> > On Mon, May 15, 2023 at 10:18:16AM +0900, Yeongjin Gil wrote:
> > > In verity_end_io(), if bi_status is not BLK_STS_OK, it can be return
> > > directly. But if FEC configured, it is desired to correct the data
> > > page through verity_verify_io. And the return value will be converted
> > > to blk_status and passed to verity_finish_io().
> > >
> > > BTW, when a bit is set in v->validated_blocks, verity_verify_io()
> > > skips verification regardless of I/O error for the corresponding bio.
> > > In this case, the I/O error could not be returned properly, and as a
> > > result, there is a problem that abnormal data could be read for the
> > > corresponding block.
> > >
> > > To fix this problem, when an I/O error occurs, do not skip
> > > verification even if the bit related is set in v->validated_blocks.
> > >
> > > Fixes: 843f38d382b1 ("dm verity: add 'check_at_most_once' option to
> > > only validate hashes once")
> > > Cc: stable@vger.kernel.org
> > > Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> > > Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org> (cherry picked from
> > > commit e8c5d45f82ce0c238a4817739892fe8897a3dcc3)
> > 
> > Why did you send this 3 times?
> > 
> > And what kernel(s) is this to be applied to?
> > 
> > confused,
> I'm sorry for the confusion.
> 
> I've got patch failure mail 3 times from 4.19-stable, 5.4-stable,
> 5.10-stable.
> So I replied to each mail after conflict resolution.
> --in-reply-to '2023050708-verdict-proton-a5f0@gregkh'
> --in-reply-to '2023050709-dry-stand-f81b@gregkh'
> --in-reply-to '2023050701-epileptic-unethical-f46c@gregkh'
> 
> The stable kernel branches that I want to be applied are the above kernels.

Ah, I lost the sending email from my inbox, as I don't keep that around,
so that's why I missed this, thanks.

Looks like this is already all queued up by Sasha, so thanks!

greg k-h
