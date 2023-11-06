Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36DB7E22A9
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjKFNCX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjKFNCX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:02:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A94A9;
        Mon,  6 Nov 2023 05:02:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30241C433C7;
        Mon,  6 Nov 2023 13:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699275740;
        bh=J6ZyBCrrXFDpt98KzqDamwgkpMUNKA/dnYWwQf1AMN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uZbIrciMgEIwx2f9/KUWm8evnImEYeT57T9oBM8Z+VN2p3TdBRM0aFyawWXiRELqQ
         aVTNDXS9cGf/cF1WuFGFpm669D/qSz1iOUi9bAvXEl++rbK2K6zWhtvPH5OyY/wJdh
         2Cb5tvsJYqno3vmGl1SkVgWFLlJBUnLiLS2BoSoU=
Date:   Mon, 6 Nov 2023 14:02:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Cameron Williams <cang1@live.co.uk>
Cc:     stable-commits@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Patch "tty: 8250: Add support for Intashield IX cards" has been
 added to the 5.10-stable tree
Message-ID: <2023110652-probe-unvented-312e@gregkh>
References: <2023110636-sandfish-thickness-bdc1@gregkh>
 <DU0PR02MB7899088E4076359C07F436F0C4AAA@DU0PR02MB7899.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR02MB7899088E4076359C07F436F0C4AAA@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Nov 06, 2023 at 12:56:23PM +0000, Cameron Williams wrote:
> On Mon, Nov 06, 2023 at 01:18:36PM +0100, gregkh@linuxfoundation.org wrote:
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     tty: 8250: Add support for Intashield IX cards
> > 
> > to the 5.10-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      tty-8250-add-support-for-intashield-ix-cards.patch
> > and it can be found in the queue-5.10 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> I don't think this patch should be in 5.10-stable. It's using the
> pbn_oxsemi_x_15625000 configuration which isn't available in the version
> of the driver (it's actually pbn_oxsemi_x_3906250 in this version).
> The rest of the patches to be merged look OK for this branch (as they are
> all using the generic configuration rather than Oxsemi).

Yes, it broke the build and I dropped it right after it, my scripts
committed it before I could build-test it.

thanks for the quick response!

greg k-h
