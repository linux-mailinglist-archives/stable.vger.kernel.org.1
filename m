Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623877BA884
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 19:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjJER4u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 5 Oct 2023 13:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjJER4k (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Oct 2023 13:56:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38046AB
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 10:56:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8E4C433C8;
        Thu,  5 Oct 2023 17:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696528598;
        bh=bO8/wFTfou8A3ArEbkt75Gr8XCrGtgW4BjPjmadSVjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sVtBVzPhi4rmj3h5Rj97vD1BSM8sEOGuJqkSpi+2du3Uvz2mFyBfqlUq0UnZV4gxK
         XwCVkUrn2FDWDtpYVkzVxuLP4hqZKLSpabw7qDeu0uA1wZTPUdU4Sj2A1aJNOgWha+
         K44kpiKvFiDtTC/EUabBkM0eCqCOd3SHoRpj7J/s=
Date:   Thu, 5 Oct 2023 19:56:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     akpm@linux-foundation.org, pedro.falcato@gmail.com,
        stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] maple_tree: add mas_is_active() to detect
 in-tree walks" failed to apply to 6.5-stable tree
Message-ID: <2023100558-condition-endowment-e7b9@gregkh>
References: <2023100439-obtuse-unchain-b580@gregkh>
 <20231005162754.7f2nr4feb7exkfus@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005162754.7f2nr4feb7exkfus@revolver>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Oct 05, 2023 at 12:27:54PM -0400, Liam R. Howlett wrote:
> * gregkh@linuxfoundation.org <gregkh@linuxfoundation.org> [231004 10:59]:
> > 
> > The patch below does not apply to the 6.5-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 5c590804b6b0ff933ed4e5cee5d76de3a5048d9f
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100439-obtuse-unchain-b580@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> > 
> >
> ...
> 
> This applies cleanly and builds without issue following the steps above.
> Is there more details on the failure?

The patch after this does not apply, so I dropped this one as well as it
is not needed without that one with the hope that both would be sent as
a series :)

thanks,

greg k-h
