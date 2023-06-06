Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA2F723E89
	for <lists+stable@lfdr.de>; Tue,  6 Jun 2023 11:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbjFFJ5B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 6 Jun 2023 05:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237438AbjFFJ4t (ORCPT
        <rfc822;Stable@vger.kernel.org>); Tue, 6 Jun 2023 05:56:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B610E55
        for <Stable@vger.kernel.org>; Tue,  6 Jun 2023 02:56:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8DDD62FE5
        for <Stable@vger.kernel.org>; Tue,  6 Jun 2023 09:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60FDC433EF;
        Tue,  6 Jun 2023 09:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686045404;
        bh=WV9cFxNG+MfsOlL3M5I032Kzw7wL2kNvcilFif6XVsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hx1BxtHef5gUICF+wBk4PIst+R3X8K8jSuS5r31yH/3MEiwSFQhw7Fr5MXqEkADOy
         eBt+pWH31ev2aeH2BNCZKp58zrlcDtpt/M2TeuiTggUWY9mnU5iNjLM3/E1qsaFp0K
         ohZt1dFiOIGNUJdtl3117YarqxLlXpA5ZLdUEY54=
Date:   Tue, 6 Jun 2023 11:56:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     vasant.hegde@amd.com, Stable@vger.kernel.org, jroedel@suse.de,
        suravee.suthikulpanit@amd.com
Subject: Re: FAILED: patch "[PATCH] iommu/amd/pgtbl_v2: Fix domain max
 address" failed to apply to 6.3-stable tree
Message-ID: <2023060606-stalemate-stoneware-292c@gregkh>
References: <2023060548-rake-strongman-fdbe@gregkh>
 <qlookcllwfzobdymwx3vsx4r3nn6sk5y4glqkxiyczxrjtkn7t@owslivpdbc6t>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qlookcllwfzobdymwx3vsx4r3nn6sk5y4glqkxiyczxrjtkn7t@owslivpdbc6t>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 05, 2023 at 03:43:19PM -0700, Jerry Snitselaar wrote:
> On Mon, Jun 05, 2023 at 10:38:48PM +0200, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.3-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 11c439a19466e7feaccdbce148a75372fddaf4e9
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023060548-rake-strongman-fdbe@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> > 
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> I'm not sure what happened, but it works for me:

I think you skipped the line above that said:

> > # <resolve conflicts, build, test, etc.>

Did you test-build this?

thanks,

greg k-h
