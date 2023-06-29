Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937F77420BB
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 09:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjF2HHA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 03:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjF2HG7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 03:06:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB822110
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 00:06:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10E706148F
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 07:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE330C433C0;
        Thu, 29 Jun 2023 07:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688022417;
        bh=p4KPY5upec/sqxfcO6ZhN+aFQ7MFbLlU6keU2wsYxhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DmFBqBAGxNNor2BBO4dsHJuuPbu69dmeZY0rYVsCjMuDCXIue0kAh1+Tzjd7OirwJ
         RHqZdgOZY+Y2Sg3Cl+eSCLwLpiDD2MJuVEG87h4BZkYIQe7Kkc5CyhBgo4RDQrTN4o
         i1SXrI3h7Ka+yHr6V2ctCE6C3qL0dWNTPvgHTBG4=
Date:   Thu, 29 Jun 2023 09:06:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.14 19/26] fbdev: imsttfb: Release framebuffer and
 dealloc cmap on error path
Message-ID: <2023062922-unweave-configure-a094@gregkh>
References: <20230626180733.699092073@linuxfoundation.org>
 <20230626180734.413046667@linuxfoundation.org>
 <2b0316ee-d5be-9f86-14d1-debb1e756e54@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b0316ee-d5be-9f86-14d1-debb1e756e54@gmx.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jun 28, 2023 at 11:41:33PM +0200, Helge Deller wrote:
> Hi Greg & Sasha,
> 
> The patch below landed in 4.14-stable and breaks build with this error:
> 
> drivers/video/fbdev/imsttfb.c:1457:3: error: void function 'init_imstt' should not return a value [-Wreturn-type]
>                    return -ENODEV;
>                    ^      ~~~~~~~
>    1 error generated.
> 
> 
> I suggest to simply drop (revert) it again from the v4.14-stable tree.
> Shall I send a revert-patch, or can you do it manually?

How about just fix it up by changing the line to "return;" instead?

thanks,

greg k-h
